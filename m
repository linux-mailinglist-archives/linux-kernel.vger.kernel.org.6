Return-Path: <linux-kernel+bounces-261375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B6A93B683
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8891F23DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECBD15F33A;
	Wed, 24 Jul 2024 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="ZLgmD1Ev"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF39155735
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721845144; cv=none; b=qDQp1Z+FpcX2ZafctRMHz1BW72i5Ylr3+yktpaic4l75Wm2Vn7MTp7L9Q37uILLuAZYV0Oyf7Jd7BYZWr1VAasqMoir9cVnI72wSabRfDc97NuByyTl3yHqFfsklrzPr5I1QMTtwTybcZM03W5sesxv4reawwC9dSVU+DotoSpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721845144; c=relaxed/simple;
	bh=Om2j4a69CTGh9FJwhuDw19F9P9Pc0gilYcZyUV7pbO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oUuRwcwBjZTqsZ7OW0HLiCt3uw8nYL07JJK6rpW8+n45aokbm57DZobZL9SEJQaJsZVeIobtwZWowrIvw/ZwBDf7ETQxctulKeiufGbND8cz1h+rTrHX2dHHszBo2TIWbZLAALpNpQZ6OyWlwti/3Oz8DDdAe7p+YR1dcwT0/no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=ZLgmD1Ev; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc34677so176126a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 11:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1721845141; x=1722449941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u/dAQiFueQuhjl+MjEIf3d+/e2gf4wNWZn6jJ/xAWzw=;
        b=ZLgmD1EvIVJ07opJEMTtZne/lwmS/v2137wpyZilfB5jd0XmnIrb5gRTe8KSUZyln8
         YdKOAcX2eUgLNMGVaMm/RoVClBLkHJyoNvj8ZE3qBbdWppdPD6XkYIe0AsfenLbZZkdn
         Li/eOFiu8N0oeTR5XvZajsZ1iYtcAtlulHNZo3FgvQqm2tw1DgyRbIdcYyDkxDmDRFsI
         cqcLZ6rKDZvMRFAWeDHrlvofibQiLymQNEA/IgaZOGvwQME4IahEeQv5TeNeerphgYvb
         rAoNL3zP59rbChT9bj3r6ajnXJ1X9NbGu9eWvl/TEJFpL+eJHomUix/O4puotmyK7Q4Q
         4rgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721845141; x=1722449941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/dAQiFueQuhjl+MjEIf3d+/e2gf4wNWZn6jJ/xAWzw=;
        b=lKcgnkMBMLbEr61sc2KhiMzGjlHgl8opKecnjFLiekPFsGDo3kqn/DnWmJ7WXtv5lm
         LcSVeoLf3TJdK87r0OClYo7L46UiXsBM+uPRIIbsAFxU1dGNV6Y6xseq50xKQxeRqQO5
         Uow1QpIzNY1gIZjbbWM0je0MzMgizK2g74CUlNBI1tP+2DXC4A4ZrDi55Ar12v67SB7d
         AmrtlwbnxXVyAnc9qKW2HHob4GbR2DVilOw1YFwz+/7PXfhdD11RH8wln9ryOEOYHQVJ
         TTQ92AE/BK/XBOhZDxGjUcAAOf+u2yTEpFM38thotwmgsHfmDQjvk22NA62jeG6iLLns
         9k7A==
X-Forwarded-Encrypted: i=1; AJvYcCW4ifHyYD3LfD4aqYqze3dmazSgNs+MQIh895iU+WoxHqb3apRqWCSzNsnZdZCN5PaGRCG38pkDE9sI6snmymtfRoeGBhBJynBczg3Z
X-Gm-Message-State: AOJu0Yy2dm5AZ2lmX/NhAdsf+xyvYDzrGiv/sTwBuicF6zVkTsMoe5Gq
	NuZgclH1fK3zDiOX/S4xTLeZt0QmLrUXnnm/towZVyDWpi9cnKjSGreBouj5Mx4=
X-Google-Smtp-Source: AGHT+IEcoUjg/H7Tny99gyfAD8CirkS4HB9FW7AtPMpVNqZyQxrRGb//+nTTNOgXurdHH0YDNc7dgw==
X-Received: by 2002:a50:ccd5:0:b0:5a3:8c9:3c1d with SMTP id 4fb4d7f45d1cf-5ac2a6c2b15mr172141a12.14.1721845140713;
        Wed, 24 Jul 2024 11:19:00 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30aaa30b9sm9101646a12.28.2024.07.24.11.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 11:19:00 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] drm/xe/oa: Use vma_pages() helper function in xe_oa_mmap()
Date: Wed, 24 Jul 2024 20:18:27 +0200
Message-ID: <20240724181826.3163-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the vma_pages() helper function and remove the following
Coccinelle/coccicheck warning reported by vma_pages.cocci:

  WARNING: Consider using vma_pages helper on vma

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/gpu/drm/xe/xe_oa.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index 6d69f751bf78..133292a9d687 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -1244,8 +1244,7 @@ static int xe_oa_mmap(struct file *file, struct vm_area_struct *vma)
 	vm_flags_mod(vma, VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP | VM_DONTCOPY,
 		     VM_MAYWRITE | VM_MAYEXEC);
 
-	xe_assert(stream->oa->xe, bo->ttm.ttm->num_pages ==
-		  (vma->vm_end - vma->vm_start) >> PAGE_SHIFT);
+	xe_assert(stream->oa->xe, bo->ttm.ttm->num_pages == vma_pages(vma));
 	for (i = 0; i < bo->ttm.ttm->num_pages; i++) {
 		ret = remap_pfn_range(vma, start, page_to_pfn(bo->ttm.ttm->pages[i]),
 				      PAGE_SIZE, vma->vm_page_prot);
-- 
2.45.2


