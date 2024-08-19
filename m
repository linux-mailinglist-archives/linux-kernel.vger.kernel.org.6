Return-Path: <linux-kernel+bounces-291829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C54D89567B3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662531F226C9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D754915DBB9;
	Mon, 19 Aug 2024 09:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="bvKKSNH2"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0FB15D5CE
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061502; cv=none; b=eQLQsJewZk4A+Az9btvFSGaLtchkTT48FPBHcL8kp8ukN4WzpmH9kcjRwgTEgH6UQcWlw3BAbYx/G1G9qPMn0OJIZtvM8PU7bBSQrAgBkI6TQFKuxVOt4BwHwxc77+fh21siGQgdYdcw0AJk3gRTrMgmpb6jBJdYHgzRQu8MnOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061502; c=relaxed/simple;
	bh=6ZZdZCRFsHhRWDlGAK+gYiJ5DQqr/lmuyPxD7mZ+llY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A41+vkjtzPprFmyklIk0gQLVVy0IngwuNTdxSEpLrkz+5rqkJZIcHbGeTEL92GX15Ojm1qyOHRpmUpPa6P0ujh+sqBchJDpDllaRksHxgnknS/ZwCgOeiIWPpfuTu2MlqQbQDe30D2OOEynz+scekXw3c4YNS9lw4oPOicfBBPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=bvKKSNH2; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7aa4bf4d1eso559144866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 02:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724061499; x=1724666299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z/WM/vbPfsLB9+Ywm21579BeaRCehpr1hL+f09TjRp8=;
        b=bvKKSNH2M3+IVMmfos84UbVLx2wb0Qa3NC9Tv2Kzf00LX+DIVp7oWlUFrzkK17heBT
         B1CAAufinsU/yC1hU3CrwRs7RmVH7YSfwpbz8g1k5y2vC6jYw4FBZdR2lksvha2zJH/t
         kPyNWq8o03d/a3rqwqlu0eX5uEjmUkch1lZJkfJyFT4LCMDROKp1zJy1LCTLwKK8OXEX
         bY5zYrNnAlShflB3mXPAlb5zDN2idiz6XZsJmUTEG2Trb626j5gQRJa9lVQui5gAeg6t
         fD9/V5F8XreK3JPcowVFqxrpDZOlNDWqzmdo47kv7BETnf0Lj81gu3DVzQla2XPNTv/D
         ZIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724061499; x=1724666299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/WM/vbPfsLB9+Ywm21579BeaRCehpr1hL+f09TjRp8=;
        b=EyzC/bsZkBGfDP17iSQ0oj4fH0E2TYBYI8lEId4KHgdAliVwEnssZYQmcJ6k9qKw19
         vojgO7qs0Is2fCx9aig9XwvuYDwDNzyjsiXffA8M1Ve+9Yd6VckMMVTWZMqHWuwrGyw0
         wUSSstijvRffT2GrZaRxV8nQ7x1QuUd3m+wkSBD7XzaoNIoCB/eRcpCZHl1sfKMlFXKu
         HvY+qmIXFAfUTpYZf/QZ63pBnJr3dCk76e6svD+J0txZ+P90tyZQhZCrKqtW9/UzYkvy
         lXnN6LKb6rv2FMoPINkfh5yiRo+D298VCWEMkGK8u7PwVUJYdJxtnUBKTbCcbqQLn5Wv
         g+og==
X-Forwarded-Encrypted: i=1; AJvYcCVsqejSwH3Aal40mrnh+rYpH4tliB24zUbk7ABNvsPPoBSctIGZgLeHylH9uiZ4beGdkOGcIVu4EBEzoxxKGzlcT9hpDaEm1eVwSubu
X-Gm-Message-State: AOJu0Yygv51jlWPQUjdl6yf+ZWhqKnwYlKB1eHH6H18+9qtfpsg7ycm2
	xFhu3w9VJn9wD7IM7f1XN48OXH1GytvlPv3galZw74fpopif2uDebyCBj+HeUXI=
X-Google-Smtp-Source: AGHT+IE8dujqtNt2QB+POwilgZUwLTFuKQfMnKJC0wL4+RUjvO0qyeyj2M6q5xsQmP85IflYGSB+eQ==
X-Received: by 2002:a17:907:e61d:b0:a7a:a892:8e05 with SMTP id a640c23a62f3a-a83929534d8mr738035366b.33.1724061498556;
        Mon, 19 Aug 2024 02:58:18 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839472f4sm612225466b.184.2024.08.19.02.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 02:58:18 -0700 (PDT)
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
	Thorsten Blum <thorsten.blum@toblux.com>,
	Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [RESEND PATCH] drm/xe/oa: Use vma_pages() helper function in xe_oa_mmap()
Date: Mon, 19 Aug 2024 11:57:52 +0200
Message-ID: <20240819095751.539645-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
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

Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
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
2.46.0


