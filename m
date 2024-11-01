Return-Path: <linux-kernel+bounces-392804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE019B984F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B2B28252C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA351CF5C3;
	Fri,  1 Nov 2024 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tITwQKZq"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CF537B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730488800; cv=none; b=djnfnXC9HK23urAVQlcpnnswKk/vncJdkEGd8FRI+IfpicPje2kaEfhBaLXsmLQU0KWgmfSTTMIgFJM9i5AFizEaXEyiznofD7Alg7hoCFg/P7gSBXNBRuwzopiD2LoUFykM3WRV/yLnhXSEQsuuco7WKApDbNKXuq6coLAbGSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730488800; c=relaxed/simple;
	bh=sIXvOD3OZG6iRjOMU+KtarI1UnUvVaJqVcaWBqHgXqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PbeMTlcbakNkxknKXWw+fwXftp4OnYSTlsAxZ2B/HfUKxm7nt+peQXOSLQH7ZfFKzVNYBL4yCbvalniMVvOEEpzpt19PEzxiOY3FL9zKQb9h30ueV//gnBR4WwMidpKLNfzbHWt5zIFkf5n5bgLK2srzfqqQokziNXhxgbidI0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tITwQKZq; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730488796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qfMRzJmRTtk2n3vrWnRLlS39WI0LbCfZDKFxpKqV/OY=;
	b=tITwQKZq3zSE+tEoz6oT7fXGkLs6SfFvec9LSklENAU0B4vTbCNON855CpTmb4ocnhukMs
	GKeISR/YRDqyjwrbOCtCYacSn1cDM0CF6PGPuWuPA7H5MPkb1yTBKYitsVXtsYG26xuW+p
	P9DFu1gYoKXFWK3HQYHymBGpnrJWkA0=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andrei Vagin <avagin@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Alexey Gladkov <legion@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] ucounts: fix counter leak in inc_rlimit_get_ucounts()
Date: Fri,  1 Nov 2024 19:19:40 +0000
Message-ID: <20241101191940.3211128-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrei Vagin <avagin@google.com>

The inc_rlimit_get_ucounts() increments the specified rlimit counter and
then checks its limit. If the value exceeds the limit, the function
returns an error without decrementing the counter.

v2: changed the goto label name [Roman]

Fixes: 15bc01effefe ("ucounts: Fix signal ucount refcounting")
Signed-off-by: Andrei Vagin <avagin@google.com>
Co-developed-by: Roman Gushchin <roman.gushchin@linux.dev>
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Tested-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Alexey Gladkov <legion@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Andrei Vagin <avagin@google.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexey Gladkov <legion@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: <stable@vger.kernel.org>
---
 kernel/ucount.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 8c07714ff27d..9469102c5ac0 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -317,7 +317,7 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
 	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
 		long new = atomic_long_add_return(1, &iter->rlimit[type]);
 		if (new < 0 || new > max)
-			goto unwind;
+			goto dec_unwind;
 		if (iter == ucounts)
 			ret = new;
 		max = get_userns_rlimit_max(iter->ns, type);
@@ -334,7 +334,6 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
 dec_unwind:
 	dec = atomic_long_sub_return(1, &iter->rlimit[type]);
 	WARN_ON_ONCE(dec < 0);
-unwind:
 	do_dec_rlimit_put_ucounts(ucounts, iter, type);
 	return 0;
 }
-- 
2.47.0.163.g1226f6d8fa-goog


