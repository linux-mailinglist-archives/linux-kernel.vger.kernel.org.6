Return-Path: <linux-kernel+bounces-352754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AF59923CA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB2E28243B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 05:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CAE136672;
	Mon,  7 Oct 2024 05:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="NAOCqU14"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96583FBA5
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 05:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728277564; cv=none; b=AmMnWGBTynHM0io72Gmx4C7XCtzs1D3e2h/3DbkmRk/Mq/5v4aFoLAxebbrF90LzlX7V8GvxN9G6DJZxABaYLXeqhJ5ZmuXmcdnCVGtmKWoKRHNqeupNARreMfsydSrl46la9OHAU86mHmjaYwwRMCFYVIuq2US5ZB9dF5mrVzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728277564; c=relaxed/simple;
	bh=BSkmIVg1JYY73MM4nOsC3ku83PUaCGrVCyX8gAHIOhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oFQjOjQTZnubUQtLNV6faMx+O+ZtfaRpa+He9LczY8p7CYjLUJQT2eUSChmoI3F+3ZNA8qJXzlbY3HT56qj9VMHDolqORcEH7QSMzwx4RbO4eJtzNFyc9mYlLoLzE/C6ywYSvdIT50t+KjEZ9Sl9C7hAOZjLylEitkVDyuXqrNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=NAOCqU14; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cb97afcec9so27856846d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 22:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728277561; x=1728882361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=roE3JMr9lMbeU1huQ5l+ymUGwxuvCsD8E2naNBrZpXE=;
        b=NAOCqU14CugTOTirvyvZ0ZeFAEpFIwZMLujnl8uemBDflKVYZxmrhSPmIwys7XXeQB
         6uPJJPCv0Yss89YaD4oMf141lz50CqYEbwFNEH+/+vM0lzIbgZ1fGYeC6Ba0V5NLB8lW
         hgN/57d4iMytD3P7hwN1CC7I4JTsVslOluYL3d7Hke3KdcqJcZYXggzg3+uJmBkjSyiY
         Q/9wfbFAUEO9+POkicgKpJB2ywGTTC8+IRpb9Pfe2R75kKfIFzyXiDvokrnDpPPazWG6
         VU4Ch5EJ64GElf0M/i58kXfsW4X/gN4Ayt360OpRP0SJl7esK68IIvFCbxgCN2VHK8Z/
         n7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728277561; x=1728882361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=roE3JMr9lMbeU1huQ5l+ymUGwxuvCsD8E2naNBrZpXE=;
        b=Jw3XBEP4MDEcGItIQ5bJFEcxWQhMPBLVjncnftesVrxf1EmGLffxgGOX+y8H6EB8/E
         flBXjr6QhF/8Kme0StViIKPvxtomVqVTYzTcxYiI0be5hG+6ELl4Ok9liGNbeQIeIKaT
         DaJODcBANfurRaleaWWvf4d/CZ0h7mKMCp0z0JUsAn1sV4HqLTpAwHx5LNa6756CJGfK
         3X4xhYUc1TzzMKH5gCeOOlhnw8p1aUn1/KXH2ZizPWAg7BGC6ojKyLbK/dgV1qnPSCxg
         Pc4D5uWSKxnA0YYkSMfcasik5Y9Ecv3zXEo6n4w+cSepneyMQHSygD9HIFK719rM1tN/
         utag==
X-Forwarded-Encrypted: i=1; AJvYcCUlKEL1+k0Lsgi3EU/jHsplpudGiKBJ5/2Z//GEzz0nzXYqa3qWSn86LIXx2oYBqtLsCG75PIGnQuVdXh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRxbcHIWSq90C4/JxiArApHl5UxA+FedxiyMprlKatYKuZKuDO
	Zo6iKR27BLuOOW5U5xbsC+5qx+0q9EAeFFaAHc1TgODxU128Y4kp+rSeqZChtoY=
X-Google-Smtp-Source: AGHT+IEFqA0OIk3ks3aFd2muaztD8wK5Pr5n5CCRe39FVoqFWsj3k1MVbhTRHDeseeL2V/taCAEOOQ==
X-Received: by 2002:a0c:f40a:0:b0:6c3:e231:960e with SMTP id 6a1803df08f44-6cb9a32e928mr162731146d6.17.1728277560758;
        Sun, 06 Oct 2024 22:06:00 -0700 (PDT)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba476152asm22452216d6.126.2024.10.06.22.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 22:06:00 -0700 (PDT)
From: Jonathan Marek <jonathan@marek.ca>
To: freedreno@lists.freedesktop.org
Cc: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org (open list:DRM DRIVER for Qualcomm display hardware),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVER for Qualcomm display hardware),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] drm/msm/dsi: improve/fix dsc pclk calculation
Date: Mon,  7 Oct 2024 01:01:48 -0400
Message-ID: <20241007050157.26855-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_mode_vrefresh() can introduce a large rounding error, avoid it.

Fixes: 7c9e4a554d4a ("drm/msm/dsi: Reduce pclk rate for compression")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 185d7de0bf376..1205aa398e445 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -542,7 +542,7 @@ static unsigned long dsi_adjust_pclk_for_compression(const struct drm_display_mo
 
 	int new_htotal = mode->htotal - mode->hdisplay + new_hdisplay;
 
-	return new_htotal * mode->vtotal * drm_mode_vrefresh(mode);
+	return mult_frac(mode->clock * 1000u, new_htotal, mode->htotal);
 }
 
 static unsigned long dsi_get_pclk_rate(const struct drm_display_mode *mode,
-- 
2.45.1


