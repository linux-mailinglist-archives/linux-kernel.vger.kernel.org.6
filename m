Return-Path: <linux-kernel+bounces-426738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CAE9DF723
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 22:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B284B21780
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 21:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A9B1D86CE;
	Sun,  1 Dec 2024 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFfcxC0k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E4E1D9329
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733088175; cv=none; b=IKE5mW3s+g27eCkabfXPUYDWURg/8p7mmb2Ud+wAjKrBz5WMDCcwGxzhxXcEGOW1+tdsBEbLoDIMTiKe//lhnuHMwnK0kr+OH6KSG+/aTJUWQRrNtl1kyk1ujh+1vkBAAo3Z056F8bBJSGD42Y+YiAc/m3HICE3b3dUN1UlbQmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733088175; c=relaxed/simple;
	bh=P/Y6sO9nx2bCFON9rLT8Z54/1lT+XGcwNhlJrI5hx+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abd/5KqkZESF0idFtDCEaePRjUxigm2Vl21NLGeqyNOpZrF+a+zWwJM2TNpFdnrpCgsx7ZDdxkLaaSwCHD8AuK4EEL9oSalc+eM70TyDsAzYE2byzIAHUk2le+nyOqnwu3lOA54fdim5xiNKd3OqM+g511iu5HZK4RhqYMwj60Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KFfcxC0k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733088172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KsWvwrfBnqjvbOnN4TJvOMsBkpZZHFy0C0E293ikvrs=;
	b=KFfcxC0kxOO1wjZj8i71u+5VeYr+tUEG/QJJUXw+Zb//KAVO3POSIoZFguTrpWS1B9GbIv
	kspeyrO8BV44crZlpY6NSOeTzePCXVMXKH3J712BFbUUjvATAPnsrwIy0MQ++X+LAswykR
	XuEAV+jE67LHxxUa7xby0imSrgDdD8c=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-9-k1L_7mMyq2Kr8egeZauA-1; Sun, 01 Dec 2024 16:22:51 -0500
X-MC-Unique: 9-k1L_7mMyq2Kr8egeZauA-1
X-Mimecast-MFC-AGG-ID: 9-k1L_7mMyq2Kr8egeZauA
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4668f208ff7so62033551cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 13:22:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733088170; x=1733692970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsWvwrfBnqjvbOnN4TJvOMsBkpZZHFy0C0E293ikvrs=;
        b=w3W2rglhQo0UNgCheHDhuAaPwmOWhQhzEDPiY7OhQX9P+aOGAlkCWmKTPjHeO77sjU
         Qt/nBdEDqyFCZICY6v0cTCMXychsC2AEYUcPE/qZFRyoxn8kE/JP6W2aluy5PVX7CEPH
         C1+q9s/SyzfC5lryMhuCdfv86DQjmO2xbMCT62yE7Hsp7UAE7CZAR7Y0nQSbj0aR89O0
         BOocy3Ghy10BocXShf3ZE0g1K4/BASpXzY2NT4oDuMZYWD9TnI4PNgs0SPOvzBzzAf82
         KmTEkKcyHzUDtVbscatjj2Ybouh31VZdYsMWJqE5yHVMscMqTZLvoqHFiVuVSQu2KdBi
         Nqag==
X-Gm-Message-State: AOJu0YxglFUuHCaLLaIn04eCmzGClfcF7Vi7B2TzF3q6uA7bgBVsXC+1
	Gdh6b2Ka8B+GKxtkJXq8DZcL9cptiDdwd3qR5ohq4kwvaMfnhbMZ5Spu1wF3d982i4SP5Rh/tWU
	ES81I2mhIgPXBLrcCjQWwHehzDFs+3ve+R+vFZxiftA+kNCJkAGfI7OoDhmXX3OJC0knb50AgyD
	rZT5SoHpWuJNUtfCwABtqgVPqilZ8RHeoo0UyDu14Hmr8=
X-Gm-Gg: ASbGnct2B4Oo5Wn6XBGZPSXtRFWYWyTZDpIEQFatqAA8ifxNuxfUbDQFMqqeomz+zTh
	ATTPz4FdEauRBCrz+bRssDZevGEqjW3WENjaPHCbjf9EaM+TJOMIgwybXnLDR23pD8uQiAz5rqo
	YMD5UNfhkiCCltE5QfsQV8O5dZr3OW/WUELzkpYznjnDZ/DDRNCOCq0HlPUomnDVc0NWmeY+OVD
	pCioozcJt33nCxed9Gg8EZ6JwWCHJrWRHPAZ60bmaDhAhCZ/pkTI7m5jOpNBOxH1Fi8VCS9YwLy
	xGMrfV6ZBPsoI+2OnWY6zzNw1A==
X-Received: by 2002:a05:622a:46ca:b0:466:d559:b528 with SMTP id d75a77b69052e-466d559b5cfmr148250451cf.17.1733088170735;
        Sun, 01 Dec 2024 13:22:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTMiVxnYL67fM20hfjxO5Kmh9CkTakr0bybTA/KMxSrhoCBEVkaO75R4et7jq3KR1ig2eA4Q==
X-Received: by 2002:a05:622a:46ca:b0:466:d559:b528 with SMTP id d75a77b69052e-466d559b5cfmr148250121cf.17.1733088170359;
        Sun, 01 Dec 2024 13:22:50 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c4249f0asm41278911cf.81.2024.12.01.13.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 13:22:49 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Rik van Riel <riel@surriel.com>,
	Breno Leitao <leitao@debian.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	peterx@redhat.com,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Ackerley Tng <ackerleytng@google.com>
Subject: [PATCH 2/7] mm/hugetlb: Stop using avoid_reserve flag in fork()
Date: Sun,  1 Dec 2024 16:22:35 -0500
Message-ID: <20241201212240.533824-3-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241201212240.533824-1-peterx@redhat.com>
References: <20241201212240.533824-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When fork() and stumble on top of a dma-pinned hugetlb private page, CoW
must happen during fork() to guarantee dma coherency.

In this specific path, hugetlb pages need to be allocated for the child
process.  Stop using avoid_reserve=1 flag here: it's not required to be
used here, as dest_vma (which is destined to be a MAP_PRIVATE hugetlb vma)
will have no private vma resv map, and that will make sure it won't be able
to use a vma reservation later.

No functional change intended with this change.  Said that, it's still
wanted to do this, so as to reduce the usage of avoid_reserve to the only
one user, which is also why this flag was introduced initially in commit
04f2cbe35699 ("hugetlb: guarantee that COW faults for a process that called
mmap(MAP_PRIVATE) on hugetlbfs will succeed").  I don't see whoever else
should set it at all.

Further patch will clean up resv accounting based on this.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9ce69fd22a01..8d4b4197d11b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5317,7 +5317,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				spin_unlock(src_ptl);
 				spin_unlock(dst_ptl);
 				/* Do not use reserve as it's private owned */
-				new_folio = alloc_hugetlb_folio(dst_vma, addr, 1);
+				new_folio = alloc_hugetlb_folio(dst_vma, addr, 0);
 				if (IS_ERR(new_folio)) {
 					folio_put(pte_folio);
 					ret = PTR_ERR(new_folio);
-- 
2.47.0


