Return-Path: <linux-kernel+bounces-520047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C748FA3A518
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0AD8171C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6C8272925;
	Tue, 18 Feb 2025 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RkPGU7xC"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DBE272903
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902635; cv=none; b=KHkXvYvCRQdjljefm18NqFip/S7q41wDSULYGys/WxD+ZfttprtXPdgckdCX91wPBuHnYB1s0Eo+dv+lRl3s5WvLiaBh/QtNgGuuIVmWU2OX7y5vek0jUhzcqcAa5n8lpr07gYbdYqKfK1ZYtqEZnWQ3CvOlWdws4haCQfSa/Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902635; c=relaxed/simple;
	bh=5UY/irxRLHJdLPa0Qej6u3DGWneLgK98owvlJcaf9Sg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GqaGS9aBq8b/Xt73xPs/Jf658iC78j/8TLCfi749o3a793iKILXDNPuFd+pj4E//qMsLvbClzhSVgtrHd6aj37AO0JMA41pwVP3UFtSUJ9MJ8lv7va0wiSG8enO7PtRyDJK0X7Clb5GsArblxodicbugUCu17T4ATkPlnQDCPN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RkPGU7xC; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220d6018858so101850195ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902633; x=1740507433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=28M4Y7I4U26ijj95STzi27Y4mVBVbqYB7mo45pFLbos=;
        b=RkPGU7xCHAMobKjCGvxTi6bFWk4Ka/43S4sFtNrhUzjlD5/iT+ySRRwjzsReVpQ/V7
         H3xLTEYojLfzqPPpVy/E5MHkA2eeqf3Vps84el6DCgUQyGWkqZG/LsEFlS07gpQosfR3
         AG7Z9YNXCIKZoLGS1X9PKKYiotSA25h3eY10nV2/DlZwZv5CkEdCpg6HNwGkbXvr2iRJ
         J0MHvqHvJ8dM4pa6ThCeg+tLAs6nwQoqd4ddeIRxUJ0wCVtyYVQei7wZgdbG4Rmtk+BN
         WJLJx3XXxj7NtPB1Yk8OW9+/eYuPT8I+GCBtp9IBAS94vCwtLxl5vQbRx+DBDFn4zCs3
         jiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902633; x=1740507433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28M4Y7I4U26ijj95STzi27Y4mVBVbqYB7mo45pFLbos=;
        b=AamGS+vw6EVrUpQJfUMJhiSwFYxJ1krX5zDMOjYM5Zt8cIzJAMzvJt2pW+Xi6RVCKc
         NBXWCFeGbAO9c3CKvQpC0npAkoZ7z5Dh9792+HiK6pugN1PY0Ena1gYsk53wjWaNwMXy
         etEXFmwDmExUoWL1osha75a7T3x9u4VFdywiT6182KlsIsIepAa7oFkKze1ziv4SNEIy
         YuCVguiu2Wh8XrFe4g04YObEg2D2SozWqyl2MG48BUcRuRSWF7d+dub7+EwdGRYeOaVr
         xt8dTRAOOIh2Te8YfU0SkNlwK9fPE99vd+Xv96MLvkObQ+db+izz8Qy+HeQy2kA/iqvj
         4nVw==
X-Forwarded-Encrypted: i=1; AJvYcCW029CfFzcYrci/kTg8zD3lIPVIj+ciEVtnhCYC3VkQx15uJj7DJPR76uCGGdJ5eozbVn6/PwgR7zTNBkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Ej/x/ZeOo7XqNp2/Pt6vt097Ep5FpzdRsG2kHwJ9JRIEy2Of
	hsGT0oFN6j0mKt3vMWVXPwShJNnNjKYYzqDiX8Zrds0QaJyu+1N43AjpNTS9A96W1lGWow==
X-Google-Smtp-Source: AGHT+IEYbMUCFmzET0WrgCEwTCh1KWF3YPlhwmyjrDvgvzwF7FS0w2ZdMSG5zEuVscgIA6n3HgmNbmdc
X-Received: from pfjx15.prod.google.com ([2002:aa7:9a4f:0:b0:732:20df:303c])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:6307:b0:1ee:a410:4a99
 with SMTP id adf61e73a8af0-1eea4104e77mr13684604637.24.1739902633140; Tue, 18
 Feb 2025 10:17:13 -0800 (PST)
Date: Tue, 18 Feb 2025 18:16:32 +0000
In-Reply-To: <20250218181656.207178-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218181656.207178-5-fvdl@google.com>
Subject: [PATCH v4 04/27] mm, hugetlb: use cma_declare_contiguous_multi
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

hugetlb_cma is fine with using multiple CMA ranges, as long as it
can get its gigantic pages allocated from them. So, use
cma_declare_contiguous_multi to allow for multiple ranges,
increasing the chances of getting what we want on systems
with gaps in physical memory.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 mm/hugetlb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 163190e89ea1..fadfacf56066 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7738,9 +7738,8 @@ void __init hugetlb_cma_reserve(int order)
 		 * may be returned to CMA allocator in the case of
 		 * huge page demotion.
 		 */
-		res = cma_declare_contiguous_nid(0, size, 0,
-					PAGE_SIZE << order,
-					HUGETLB_PAGE_ORDER, false, name,
+		res = cma_declare_contiguous_multi(size, PAGE_SIZE << order,
+					HUGETLB_PAGE_ORDER, name,
 					&hugetlb_cma[nid], nid);
 		if (res) {
 			pr_warn("hugetlb_cma: reservation failed: err %d, node %d",
-- 
2.48.1.601.g30ceb7b040-goog


