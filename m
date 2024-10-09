Return-Path: <linux-kernel+bounces-357745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0125899751F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 572A7B243AD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9791E1A0D;
	Wed,  9 Oct 2024 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b="G6/QPwBv"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B211A255A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728499874; cv=none; b=ITgCLo/TqlKyZH2qUD3yrucrZ8ZAOli/GPAo8yBoP8orPNh2rfFi6SXuhNxhwEqntE7cQEU+4BgZuzvP6D/WMk1vLiNqRhDkRlOpt3RBDSU1R4AL8grpeSQHvMe7WJsmy7pKbbLISxQ95ePNynroDla6jb0q9iz+rYn2iX0pvus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728499874; c=relaxed/simple;
	bh=H0NK511ZSy+oxYmuR4npC5W03062kkZv/buSQXuBOTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iIXRIs6zNZKy1i+PsOYMZtDVKf/PumWyGE18VUtFGb5k4+e2fCup33FMUMVucPo7Nf6U3lDNoLGWN+/P899k3DkQNYkdTiDLuzFzhoUYG0cmuTXrcfy9P1cmqWjFKfohQijsOwm/lo3iLjuU6WWNu3mJ83nz53Fq3GGljam5od0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np; spf=none smtp.mailfrom=everestkc.com.np; dkim=fail (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b=G6/QPwBv reason="signature verification failed"; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=everestkc.com.np
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b58f2e1f4so387465ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 11:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc.com.np; s=everest; t=1728499871; x=1729104671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+0QE2yWoVqIEzNKM/3F/Lnwv5evjqB7rUXVgq/OQiuw=;
        b=G6/QPwBvr9Grz8TUrh41+nKa2yoDH+Iz4y1lQ6IX/MdjYbf1sn+cepgnYrfOfh+yWB
         wtU8inxP1x64BbEKomEOuOWErSYEzniki1VFX3RgigGK8OSYGhjOXns2Rg1toorYV8E/
         Uz0kz/Puk0UY9XJptL6nHDqwIN68sAUcldZhy8m23aVo7+pUutArzjAGdBSGGC+4sxdf
         vAgFHNoFNqOVbyG/Bjvb//MbcUXg/D90998ZVHXdUYxIQ5URks/69CKT9redu82kyaod
         WNY4h3mq4RHmBufgR8lTREDbm9k2JPxvZfCWocSKE8TVxUk6msLkdj5dpammtErMtL7n
         5TcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728499871; x=1729104671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0QE2yWoVqIEzNKM/3F/Lnwv5evjqB7rUXVgq/OQiuw=;
        b=KGwytacW1SFm1weqElco/EhJL57c0KT+XkFqzU7S3x1CYsaJgSIxQ+xwoBpmd/VMzX
         2gL4ZyBqEGvX1w7ICwpSPecjOkLX6QFFjVDPg7iiMQ/x2raim+EDdfwXKZPGySM1vrl+
         3GbkIoP1WybDve5Ae8K/k60EtJnv8xfiYc8gZhXonzy1WJDNLqUKr/PLC0GZBVuOxDHe
         RdGaicwipE+iJARD3ff6aWjYB4YTsTBV6J6JW1ROlae2sOG69q80bMbZ5EyBpYAJUMgE
         6n+LlGHOYRO5QVddYu57RcXokozo7n07z7B4ac5wzn8SiKWCYJ6vHb2ZeoPAQ0ChjGU3
         ZpIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDqo505xNtnMG+WYd3/LGtZrKUUy1VFT/AdTA9HiM3aTJNfbtVL8IMtSlgTAv2UlyFrbcmYrMA5G58ktg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNcTvBcvDWDYgLl9/iyHFLGd4+LsudJt8wpoWUgZNtOM/Rfy4E
	9N8HJWUp+Cw/hCjxHvS7cC6s/8Z+6sSLk3TsUk3c6kl/FtwcUkr8lqQIjrmCLrc=
X-Google-Smtp-Source: AGHT+IHpQGViTVc+tm/tkjno8glkT35adg2V8Ycv4zbgyv863j7Td5NNgYxT1CIZMuESuswQ3Zwc8g==
X-Received: by 2002:a17:902:dacc:b0:20b:7ece:322c with SMTP id d9443c01a7336-20c63742f31mr54388955ad.29.1728499871390;
        Wed, 09 Oct 2024 11:51:11 -0700 (PDT)
Received: from localhost.localdomain ([81.17.122.158])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20c54056b07sm29864905ad.64.2024.10.09.11.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 11:51:10 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/xe/guc: Fix dereference before Null check
Date: Wed,  9 Oct 2024 12:49:49 -0600
Message-ID: <20241009184951.4991-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pointer list->list was derefrenced before the Null check
resulting in possibility of Null pointer derefrencing.
This patch moves the Null check outside the for loop, so that
the check is performed before the derefrencing.

This issue was reported by Coverity Scan.

Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
 drivers/gpu/drm/xe/xe_guc_capture.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_capture.c b/drivers/gpu/drm/xe/xe_guc_capture.c
index 41262bda20ed..de63c622747d 100644
--- a/drivers/gpu/drm/xe/xe_guc_capture.c
+++ b/drivers/gpu/drm/xe/xe_guc_capture.c
@@ -1537,13 +1537,13 @@ read_reg_to_node(struct xe_hw_engine *hwe, const struct __guc_mmio_reg_descr_gro
 	if (!regs)
 		return;
 
+	if (!list->list)
+		return;
+
 	for (i = 0; i < list->num_regs; i++) {
 		struct __guc_mmio_reg_descr desc = list->list[i];
 		u32 value;
 
-		if (!list->list)
-			return;
-
 		if (list->type == GUC_STATE_CAPTURE_TYPE_ENGINE_INSTANCE) {
 			value = xe_hw_engine_mmio_read32(hwe, desc.reg);
 		} else {
-- 
2.43.0


