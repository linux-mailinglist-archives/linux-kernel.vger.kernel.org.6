Return-Path: <linux-kernel+bounces-235287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF04E91D2F9
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 19:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8650BB20DDF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 17:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7611C156C69;
	Sun, 30 Jun 2024 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLhWlKiV"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665B3156C78
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719766844; cv=none; b=vA6orimEX7d1aG1wG9xwO5AoH58uMC6vHe/WAMhakwyKUWP7HXtxSo4f1iDqv8m+WEjgKBssdvbLXYwMcoJgDFiXY8vihs9u/SbUlc8pR/Z8yyZAI+gSCiLaOwdd3TEKiKn+1od0idcYnQIIY23RPFTAkoO0XELMcZ0iRqYhWaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719766844; c=relaxed/simple;
	bh=/RZaGLmr7Ug0J1QGj1sNNuCF3duc6YzDgUOKrMEySao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXcwWn1w9eCZaMGqigZxd5JyWSPWpONHCHxtvess2cn4/M+v/x7kIxlP2koA5qYkgQJqsVWe7AqeM6nuNBML3WxVpYYoZFBwxNly+9FkC/xvgtZqj7rDfp+mFHQLM8jiXCLz8eXSLGBZd9rQSunS00zEdPBGJNk8L5qI6GWCca8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLhWlKiV; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-79c05313eb5so201829485a.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 10:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719766842; x=1720371642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QLGAW+ynl8vrQtYcMfXzZ7X2GgW9XGKGc2Rji6SiN0=;
        b=cLhWlKiVv2vxC0ZsUgRt0XItuE2bm6Esc7EOasV+uTj9bxcY2tgSQBxrnae1CyksXM
         UcOVQQx7Rah+6phuJ3Qqke9U3kzKjcM+mBdDWJr51ePipU5XZZXJPelt32VoFqtf4v9q
         455hBqLEH2Ds0vYCf0SLg+4lYFxqc+pNzoCYzQgdzvlVMfFi7KX76zEx3BsXMwxuUlR8
         nejaaSAO9+Z7XemXMTsgmuzDrcHDyjhOoyAkZI3w78QelNfdr3Aqn8HMTg139Mu1BDok
         vMYxCG/iKOcPhnrAVIoHaLEm1IKVNDQ+VR4T9wnjI47iMc7bh7Y9X+5BazEtJhLtFlzd
         7jsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719766842; x=1720371642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QLGAW+ynl8vrQtYcMfXzZ7X2GgW9XGKGc2Rji6SiN0=;
        b=ipclEiNL/0kompRZi8BI4JcWTCrB5f8HZwhMH5fE2wiD9MrnYOt6hKL4jOtBWwnBB1
         OhdOQYKAiV+4PsvSK+m43E6wDkXTv2JeC3EhAkf15FLxNAkFYTHy4gBCEMPma3PXqYLK
         jQeXCcCOAJqz/mqfKLND4aWMOJRHoM+sVHsFc+cHKKxhqLroA8Uv2zjBFrKWK4SR9XFF
         vzhLIfzUFsQ3/HUfTWOxJV45vwIpGAkJpbKA2KpS+A4HYjuyeqahNDDSp6uBkTuTU3nB
         HmLh9omwG4uWSZFrzhuENDh3CSaTtp/pTP1/7SjWLtA7s85bmspVR/ED4cumqj04IJZ1
         1OVg==
X-Forwarded-Encrypted: i=1; AJvYcCWA8aWEdLWvYXiSVAc3jxBV7ylCrAim4oGh3n6KMZYvAfhWx//H9aY5MrZRWs3woUEn3ud+nyWVpDeyd+q/wSgnpEbO/3HMhwO+9oRw
X-Gm-Message-State: AOJu0YzN/SsFNCHA71zpDtL7USOyud4WT8FgYdh6lOqEp4bHunefk6R7
	y++ziaHrz0plpQKOrLLaO+dZFcScECimEYjPCbbEBia+6AVWk+c7
X-Google-Smtp-Source: AGHT+IGtMyrH/5c1fTXATxN1H5bbXW5O5iGXqlIdcuzLUpq4fPCLGzb/lvYkgdM8YMFaKQxHlNRx5Q==
X-Received: by 2002:a05:620a:5783:b0:797:bc08:f495 with SMTP id af79cd13be357-79d7b9f1df1mr383929985a.38.1719766842329;
        Sun, 30 Jun 2024 10:00:42 -0700 (PDT)
Received: from localhost.localdomain ([142.198.217.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69295f5esm263431785a.56.2024.06.30.10.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 10:00:42 -0700 (PDT)
From: Wu Hoi Pok <wuhoipok@gmail.com>
To: 
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Wu Hoi Pok <wuhoipok@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] drm/radeon: use variable flags as parameter
Date: Sun, 30 Jun 2024 12:59:19 -0400
Message-ID: <20240630165949.117634-4-wuhoipok@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240630165949.117634-1-wuhoipok@gmail.com>
References: <20240630165949.117634-1-wuhoipok@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To be consistent with amdgpu driver, use "flags" as the parameter because
it is already assigned as "ent->driver_data".

Signed-off-by: Wu Hoi Pok <wuhoipok@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 88d3de2a79f8..7b8aa8406751 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -314,7 +314,7 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_agp;
 
-	ret = drm_dev_register(ddev, ent->driver_data);
+	ret = drm_dev_register(ddev, flags);
 	if (ret)
 		goto err_agp;
 
-- 
2.45.2


