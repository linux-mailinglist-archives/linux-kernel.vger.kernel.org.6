Return-Path: <linux-kernel+bounces-405516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE559C5253
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76237283513
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C74920FAA7;
	Tue, 12 Nov 2024 09:45:54 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FD720CCF3
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404754; cv=none; b=VspnfgV2rEjR+1Cto+DSCCdDwRcP6gCKXKkv+6QXJl4+C5cuBsbNBXLI6ycbtPoQ9KcF7DdEt7gTXx5G/yyFGpL2w+i4IdhrfosRZSxs2X1Qbj/YX8r14UvaWePiLkcabP4C5kV9m4rezUE8wRgA9iNjRH4ngWWWfqVhNqnJzxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404754; c=relaxed/simple;
	bh=5MFg8ebtLeaNltXlsUnArYMSPtXF59/e1Qso2kZrvV4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KaMuOJlgmEzeSYu8kM6KTjgZprtL1JTbtPp/aAPyayPsaBZalBdqTzbcCcSfqs6aGdDnbjl2Ry/G1uylm2S+lsAbtbbIIjVRX/s5iMnvdIacq2mcV/r0cy8UOxupoUWxzcjClJomQrZbZpc4v0Jrbyy0BfjzlVEAGWfGLx7Liiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee2673323c42ad-452c7;
	Tue, 12 Nov 2024 17:45:41 +0800 (CST)
X-RM-TRANSID:2ee2673323c42ad-452c7
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee4673323c4a49-3af28;
	Tue, 12 Nov 2024 17:45:41 +0800 (CST)
X-RM-TRANSID:2ee4673323c4a49-3af28
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: acme@kernel.org,
	jolsa@kernel.org,
	namhyung@kernel.org,
	adrian.hunter@intel.com
Cc: linux-kernel@vger.kernel.org,
	Luo Yifan <luoyifan@cmss.chinamobile.com>
Subject: [PATCH] tools/lib: Fix the wrong format specifier in str_error_r
Date: Tue, 12 Nov 2024 17:45:38 +0800
Message-Id: <20241112094538.287524-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make a minor change to eliminate a static checker warning. The
variable buflen is unsigned, so the correct format specifier should
be %zu instead of %zd.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 tools/lib/str_error_r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/str_error_r.c b/tools/lib/str_error_r.c
index 6aad8308a..276596a75 100644
--- a/tools/lib/str_error_r.c
+++ b/tools/lib/str_error_r.c
@@ -22,6 +22,6 @@ char *str_error_r(int errnum, char *buf, size_t buflen)
 {
 	int err = strerror_r(errnum, buf, buflen);
 	if (err)
-		snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, [buf], %zd)=%d", errnum, buflen, err);
+		snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, [buf], %zu)=%d", errnum, buflen, err);
 	return buf;
 }
-- 
2.27.0




