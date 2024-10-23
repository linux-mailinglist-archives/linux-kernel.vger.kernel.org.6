Return-Path: <linux-kernel+bounces-377643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0A99AC1CB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9151C2443B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566F715CD79;
	Wed, 23 Oct 2024 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XxQ3WhM4"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D68415B99D
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729672549; cv=none; b=FDhhCgI3C1azAXR6NMlK3UgZtq916l+pDaa+L0vvbSPz4wfa+6MoflbM0vmwRLNTxwvauKb+PvFl37Zy6OS17MSeT1RJja4cZ7tZJeMiFPD2GRBj2asUlTG4DOoZvbcdKrdYkam1+Vm2qr4D2FQlLrfGKvfGny2NWmCpzBJkQDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729672549; c=relaxed/simple;
	bh=sWr9BoPiw234wLlV9ndaYINN62ABD8IJIL0J3zlr32E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nBNBCtvu8n3tWQZ1lZb8r6pjczZEpGIZ/yLNznRxBVg/N8Zw5Xl+ZfsrpTr5T8CfyxKU82hn8Rn8F0IaWv8yNgrSAdE/v2KMRfa8P+1suXNtsEWRqEJy46Cg8sS9eE3MbdwWSMT34QAYbhOPYkwsoW4r3b9xu7p6zL9C0eUmkXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XxQ3WhM4; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d447de11dso5134070f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 01:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729672546; x=1730277346; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3keMfTd6iA7sU3pCEbZeVuLo6cE9jEmFKIeI2gY/mSU=;
        b=XxQ3WhM4EiS4UkHwpWJ+fyPGXhmSqmSqMBOgfpaw7a+D3Q+Y8ayL7cbUT7fKd5F4B/
         6Sq3rodrDKlwKACFUo4Rajo9pmcu4Zo+iRTPHPpOKnMtRrVTfhROD64u2Pcymym/UVbi
         H/yvK/IAQB/TCPQbpFcc2zZjiyyFRKlyBT4HyeWT9YVZ2zjeT+NxG8Pq2OeK1ABzSNw/
         mJ/rV0Ap6r76tmUhYImn5K74xa/kmcNWzOIaWeNPq5ERUG4WOO+QvJ6eGaJj9Pw6YvuE
         O5FSpjuC2z2I5mUYgZkwB1bm4pyJZpal2soeqIxdKx63oChBRP9XZQdQqFZAxXbIjrJs
         kjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729672546; x=1730277346;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3keMfTd6iA7sU3pCEbZeVuLo6cE9jEmFKIeI2gY/mSU=;
        b=PYcc0jEgqoedFB8yzfbFjMW2j2PE5obZ8nItGt/VZLCC1PKEkuOOhsH/iFXYaWlEeX
         H0T7L2TronB80Ol7UYVcPKZsEaoaQvYtL6r1mx6HiKn0gCKC/HkCd87/bs1y7FM1KH5N
         GIBSAk4tluZPa3i3y/nwL+hk4xmJg+dHBqzv2chKz+1p39xRZqyJ9kFPIi4eheoGDVB9
         OET5Lz5LDOoE+EoQQe1dz6CHRkK31izQRkyl3IOXAjnUR3JljRKLis9VcVEynKWbaGAo
         E8+99Ia39XiRxOeFLlSAxFH8XES5QLpFsJ09J6aW3Pb89gQkEHbkP+nlCrJwjHlDzT8W
         wPuw==
X-Forwarded-Encrypted: i=1; AJvYcCV7UjMUZRnfF1OMM3wlQDEZWNjqRALmf2SgTv6go+jLq3bfErexsnyQ6233rgzqLMdr9uMB4NT1vYx9/mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOJZg9RoWVOxbdFXAZbiBCogM3jhGuNxf00GQxgUqkpOvHXrgQ
	K6Tf39mkCugOs/pqpopuGvcEd5DDs2LaOhhS9IdLV4g0kWgvjP1tbGVb68AOPJc=
X-Google-Smtp-Source: AGHT+IHmXnBGT7OF7hHGlVdNz3VlYEysdkSKiDQWAZPncpV01I9EuZmg4AgrOK3MaMOXgvIs1q0j+A==
X-Received: by 2002:a5d:5223:0:b0:37d:33a3:de14 with SMTP id ffacd0b85a97d-37efcf00deamr1112744f8f.7.1729672546641;
        Wed, 23 Oct 2024 01:35:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bb15sm8401812f8f.99.2024.10.23.01.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 01:35:46 -0700 (PDT)
Date: Wed, 23 Oct 2024 11:35:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthias Schiffer <matthias.schiffer@tq-group.com>
Cc: Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/fsl-dcu: prevent error pointer dereference in
 fsl_dcu_load()
Message-ID: <e4e078ed-9342-48f4-80c5-28f0f7b711b0@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The syscon_regmap_lookup_by_compatible() function returns -ENODEV if
there isn't a compatible for it or other error pointers on error.  This
code only checks for -ENODEV instead of checking for other errors so it
could lead to an error pointer dereference inside the regmap_update_bits()
function.

Fixes: ffcde9e44d3e ("drm: fsl-dcu: enable PIXCLK on LS1021A")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index 91a48d774cf7..5997d9b4a431 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -109,7 +109,9 @@ static int fsl_dcu_load(struct drm_device *dev, unsigned long flags)
 		return dev_err_probe(dev->dev, ret, "failed to initialize mode setting\n");
 
 	scfg = syscon_regmap_lookup_by_compatible("fsl,ls1021a-scfg");
-	if (PTR_ERR(scfg) != -ENODEV) {
+	if (IS_ERR(scfg) && PTR_ERR(scfg) != -ENODEV)
+		return dev_err_probe(dev->dev, PTR_ERR(scfg), "failed to find regmap\n");
+	if (!IS_ERR(scfg)) {
 		/*
 		 * For simplicity, enable the PIXCLK unconditionally,
 		 * resulting in increased power consumption. Disabling
-- 
2.45.2


