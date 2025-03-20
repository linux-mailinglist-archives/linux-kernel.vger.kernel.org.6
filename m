Return-Path: <linux-kernel+bounces-570245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FF1A6AE09
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A3A189EF95
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5CE24A05B;
	Thu, 20 Mar 2025 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNBgItCC"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8263248867
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496848; cv=none; b=Nbmzyb0290uN02eKUDIYpXz7pUL1fKzfFXoq3mOytjjXgkVoLRk0Ib4TbOikcVPJ/Xfhq4Ti0ya/azUxY0o4cL3fURTFh//DiFyHukBcp6lAduMspA4PzZbOt4t66YNgfas3XvxZGxEGvq8xB4UaI4NbC7XCcqRVoclE4srFKCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496848; c=relaxed/simple;
	bh=N9BDlQuttJ/CG7/8erFPoatDdgkmwr3Xfmvi/9L/ya8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hbjc8mlPhTrPRrjN525mn/A4LT330TOSpdwW0j/3zZScRbGZL5A/JrWJaT4CvaH0a4kOaoh4aOcx3fhIV2m+XP0SxEBJvyun9EjJabtCZ+1ZobxdQb1Txbasqj9IMMlwCABBifKgxkvxDWcbTLUFrjic8FaZsBA7DfLtvxinX9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNBgItCC; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-85b515e4521so36874839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496846; x=1743101646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=av5O5WnsuBn1uC/IGfMHk77btJQzrlTi1UNrBIeIfGA=;
        b=aNBgItCCDCn5X8308AhZ0ohghCrRmI/1NPi2z5vlxiYVEOkS+asHCVeUJC4m1TyqY3
         swBgY7EKIxCmzqwvmwON0JGrqIb7qwWccTKljNLH0938oI9QtnfyrrEc4dzUb/THNTEX
         lpIF08oGwtO9U8MYcSGL/QR0PuGMll1mb2pmh5CvSFzSLGETD4uQJos7Y5qfwrcNT8Ed
         H1Sqa44XDUXIAx5HOw8pw4h4M1KWbOj9SwBIP9m1LVOf1Dc3y2IcOFwzSZOyDCbz1Yji
         LzrRuhbK1jBJ/imiKTGQp+rRA9UCpzNLgkddPe2P/P/96AMFQal59bhxFJoRza47N+sZ
         jTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496846; x=1743101646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=av5O5WnsuBn1uC/IGfMHk77btJQzrlTi1UNrBIeIfGA=;
        b=N5aElqvzzqk8jT6eZhcCat7/9zsawQdsw2xdAX1AZtTWHQnOpDDoKyCRt9u5TNB3mG
         NnUVlhweE4UYJC/VWbpZ/rMvZaa+jDbti619aLm3fYTrhx1tJf6DEKY/u2wDKTG2y8DQ
         eU0dSpfOBcCb9s1OAcJ/JWCDU4HjrsD3CUoPF9e69ieG77azpW0a9ax4llAaEldINOLu
         m9UISa3Ox+QwoW+xwV49AWX6XCd8gRID8/+KemTqU0CxML1E0S5g+3yTVSSjVKmtex9A
         L6ZEkN4RtnCyotBO5YEwwrGWG6uEwCEoUH6MsFw8o88rbWQ359mZH2UPYGLuOf3j8QMd
         /1VA==
X-Gm-Message-State: AOJu0Yz4IJeiknRUjR3lAeQAM/t3s6f2Sw4sMpAtOYqOsoXqRir0/VZs
	FCO8NXTpkY3kyAhkMmvgkD95GD6ZNG7TbTkkWp/cTAW1hzq9E0cGdiZ2IXTv
X-Gm-Gg: ASbGnctOIZXuiZBhJD8EgW7hBZX7RqamiPH/unTFprOuECTsoOXSsFEzBvHWte9grIz
	c/nYbkZXy/IAAmwx8Lj9JqSoilG79wCqLUfHpFhtVT92sJFXbaIbFs24/6veMGe+ehbGxi5kMib
	RCv+HNZJh70bCwVDfaqcF/yS6LSdje5MeTFu1dZ+siJ9qU7SPZXkSQKiTkD4IyOpRO+G6nQOr+t
	oxrfYmS4TEWvhXVxFCqNZMXzJ9FQBhWUkD6CE3G60/E9gDxDPts9WAPNRe1gqOiWPGM4VOQV4je
	2YMUnvCU2ICFf7Z9qkwAM9UUJ9K8LaqZiCLpp4UNRMTOhplW3YnHuoNRlbnsQHNTazcuJfubyUh
	zPg==
X-Google-Smtp-Source: AGHT+IFrm0izbW5klOGAefVwIfXwq8vA34rc+9wleGItV26sAOFToBmsSmKm8djU5+LnJkwqDnPVZw==
X-Received: by 2002:a05:6602:380f:b0:85d:9e5d:efa9 with SMTP id ca18e2360f4ac-85e2cb423f8mr36109539f.10.1742496845798;
        Thu, 20 Mar 2025 11:54:05 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:54:05 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-gfx-trybot@lists.freedesktop.org
Cc: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 54/59] drm-dyndbg: add DRM_CLASSMAP_USE to mgag200 driver
Date: Thu, 20 Mar 2025 12:52:32 -0600
Message-ID: <20250320185238.447458-55-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320185238.447458-1-jim.cromie@gmail.com>
References: <20250320185238.447458-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mgag200 driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/mgag200/mgag200_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c b/drivers/gpu/drm/mgag200/mgag200_drv.c
index 069fdd2dc8f6..5b6ec1550da3 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.c
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
@@ -27,6 +27,8 @@ static int mgag200_modeset = -1;
 MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
 module_param_named(modeset, mgag200_modeset, int, 0400);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 int mgag200_init_pci_options(struct pci_dev *pdev, u32 option, u32 option2)
 {
 	struct device *dev = &pdev->dev;
-- 
2.49.0


