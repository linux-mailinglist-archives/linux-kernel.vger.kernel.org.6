Return-Path: <linux-kernel+bounces-532264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD4AA44AE3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2D33A5CA7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86D119F48D;
	Tue, 25 Feb 2025 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YAuF6iRL"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02B918B46C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740509124; cv=none; b=n5GngCAzVrsqWiimVAgIN+ciFoKNJkADL2QY6Cosb6e8MtIZIm3Xnv7z2dt/BMKmmjpgmbuHAAaKsv2tUpcLaw/OO97Ahtz2DoDoU/7nmOyAghkcTWDeLzxuL/IYloPc5g3nXIBZLXofzyQZPNKR95ynZ1jjH0Nb8VLZuiH/8tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740509124; c=relaxed/simple;
	bh=v6Co/tS+0MNwdOcyGhOKl3+nRAsxyfuWEdDGQ484BEk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Q/AH9gOvdd3lPIhtAhvxrz73nbVtXH/g458G4HDKcst34SeZKWG+ATTUAw49/5bgX0qP2AbuO+ANO4t3JfMRkrRtzut9XknR2ZsXB00AzVY5Wo3VpoqBrwmbtuD+aKGVFyOy76wPczMG2HVtUJ0FwXAEXE51IQTcUqecjnojLq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YAuF6iRL; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-38f36f03312so2438777f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740509121; x=1741113921; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Uuq2MzTQU8OzNxVyBK5axFZHCKkKakfNosvjOxzPE/c=;
        b=YAuF6iRLa2+AumcTO6QY5n0gBBvjeMWOB/6dLeMRAk44m3M+Th+U47gjRAqumEGhI/
         uMd54rA18uXAz1MBqd5A/QyZ5CWjo4vgzYT6FQOd/xTdupYzU6Pq+/hzQYmmoL1SH5s8
         Vwtz/xCV5kEZFQcwY5WnchXoTv4bKeIkvZIo1W1oevCFvYUjGYEyigxX1/uK0hq9RtK5
         vj6FcLWQGs0YFtaPmNJDAKV+xqxxMlNbYKRKcub7KpFwpNDNvS8icyu7w0oDQC18fAN3
         K9ePH0J1vDUzLRKav3RvmxvqvOwsuJ8ejXUSLPFAfhfpnWvb/9txN/uSDKcymrlgM9r2
         nc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740509121; x=1741113921;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uuq2MzTQU8OzNxVyBK5axFZHCKkKakfNosvjOxzPE/c=;
        b=cUfB7U1JeYw8TAW6SSFCbiEHrKhumEBLdm0PmoFK+seLbbOZCfCof7iUoPxFG/Fllq
         85fF4wzvIEOQRtupK9r2X2fo2DBgKBNZ3pQqmpYtnK1/vkhF1O0i5SM03UxbsyhgWRgl
         NNdF6q86Zv+HgcYYsdHAjWgzss+bSA+Nek2A4zFNIW6EQkbxjseIuASSpHcsPGv3sjOD
         vuhStKhPnmNFlExz8Qd6ntv1cJ21dOPXRz2B/DU3r6rKVvCJ2QqcwsOY5s/YlnTTZ+pa
         tmAjivE6qcp8jcWR3Kql5vMfBqblynNwNO2lTYPrRlXWy0FRyudjBxOZQQA95rd9X7IH
         s5vQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7XHHq/n/BRPyB0yn9mNA3kfAkCotNoVkY6StW4rvkpZsHQntgq/QyuZa6ySmi47q9s7YqemthtQHD3Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl1M/OZpVY92d6bIua9Tq9Sp3PaRBglZU+vbDw7PldfGtyzfD1
	/szafs4hu52y15oA6Mm9PmVH8bUq2Kd1BfNFLiz6tBQREqfwlb3pZuSHjV7FR+3/AoM2ItU8m2j
	n0tPme2r+qQ==
X-Google-Smtp-Source: AGHT+IEeOi7MBcMPL5uOIdLWbDdUI8xifnw5VvmKnr87ZFXBjRdbGkRGX0rw7TfYAQiKF2vNDxCNGJ/cTtI6Iw==
X-Received: from wmbez7.prod.google.com ([2002:a05:600c:83c7:b0:439:89d1:bf88])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:e78a:0:b0:386:3328:6106 with SMTP id ffacd0b85a97d-390cc630c5dmr3975963f8f.35.1740509121096;
 Tue, 25 Feb 2025 10:45:21 -0800 (PST)
Date: Tue, 25 Feb 2025 18:45:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALQPvmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyNT3fLEojzd0ryU1KK0nPxyXfPEJAMDM0tDC6NUIyWgpoKi1LTMCrC B0bG1tQAZv/4VYAAAAA==
X-Change-Id: 20250225-warn-underflow-7ab0069182e2
X-Mailer: b4 0.15-dev
Message-ID: <20250225-warn-underflow-v1-1-3dc542941d3a@google.com>
Subject: [PATCH] mm/page_alloc: Warn on nr_reserved_highatomic underflow
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

As documented in the comment this underflow should not happen. The
locking has indeed changed here since the comment was written, see the
migratetype hygiene patches[0]. However, those changes made the locking
_safer_, so the underflow _really_ shouldn't happen now. So upgrade
the comment to a warning.

[0] https://lore.kernel.org/all/20240320180429.678181-7-hannes@cmpxchg.org/T/#m3da87e6cc3348a4640aa298137bc9f8f61b76c84

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5d8e274c8b1d500d263a17ef36fe190f60b88196..715a9cfe162090cca9eb819a34c64f9a1c6db29a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3095,6 +3095,7 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 			if (!page)
 				continue;
 
+			size = max(pageblock_nr_pages, 1UL << order);
 			/*
 			 * It should never happen but changes to
 			 * locking could inadvertently allow a per-cpu
@@ -3102,8 +3103,8 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 			 * while unreserving so be safe and watch for
 			 * underflows.
 			 */
-			size = max(pageblock_nr_pages, 1UL << order);
-			size = min(size, zone->nr_reserved_highatomic);
+			if (WARN_ON_ONCE(size > zone->nr_reserved_highatomic))
+				size = zone->nr_reserved_highatomic;
 			zone->nr_reserved_highatomic -= size;
 
 			/*

---
base-commit: 0c789105c9d6c65777c995f4935f2e119d5a31a5
change-id: 20250225-warn-underflow-7ab0069182e2

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


