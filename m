Return-Path: <linux-kernel+bounces-358492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2C9998003
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C4F1C24193
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52854206946;
	Thu, 10 Oct 2024 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VWatSswK"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D414D206956
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728547479; cv=none; b=spiV4hqiOxDLq9QFJS51vm7Tr4YpjomiXXalzrLpu/PEh+nsUt03viT6PDSYQtMNakqvBfJpTDzhIeRCqIOTu+/B0nblqbkFdOVi9NBO2Ocy98Q6l9XCWEoarL5PiprdpQfwmjATiQkhOlr91wFOGLNJYf8B4xh1XBPL1E786GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728547479; c=relaxed/simple;
	bh=aUjpPpkknw2el3r4s/lHP3q+/q3VThZOucWruxsgJgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LhRey7aSZsFa6cZ+orgUQdfbzFivXn3Hv0q4PizFzQyjWA7NkHJ2Jq+AgIf+FTKoCtvPc9qkTTWLgfvGupQw4dx1MSx5YEM+NgnVb2fvC3Gr7UhqZU2rKppbk7CbCSrbFg6/qf8NuxydReaiYg3D2ujxrXeXfls4lOaQ0W5y0WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VWatSswK; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37cea34cb57so356702f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 01:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728547476; x=1729152276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fDHNOq/uVfdhPQnxx8C/p+1N1tZCw9Q9Wr687fna89I=;
        b=VWatSswKS3jVCixqpHzShCFS4DLD29fpjZJS+2Jy9v30PIz9KKCbvjp6w5748sMe/x
         NY1b0R2AztBMghYfxmqH2mMVIsnEgdPdogPSziyzNdJvAoNEAVlGv0BbtKuM9SEEoJxa
         L0cKDqUsBBf3Kpv6U0s/oBKXvmkd3vSigjx6xcLkMm1cJmHVgQBLCNudZ0pn4yXN3LA/
         8vwNsvKvLZUkodRl2aD0JhbRy7mJiFEWFpCKkAPBPqBhSknaUHRPg3HIt61xv1cDJ6E/
         EA+kqA6+wt61nNVhRAjclSEsAjtzSewezyj3lWvDCqU8mVHFQ2ORFD957N5C27zvX7cj
         cfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728547476; x=1729152276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDHNOq/uVfdhPQnxx8C/p+1N1tZCw9Q9Wr687fna89I=;
        b=XOwhVX2sbidoCLQE/FBz0HAUNOVsGcSEykLZ+55AROxLZj8IpzB7GGeUNDITwwRBfA
         fvMfJKnrx+PMwHA1VDxTGLspS2PF0OxwxJFWQDQe6ORjOBjabGWGxp2jorSal+iIGD6G
         IfG0rYglWf+17ALHu0SU0vFgRMlAqAUU1xui8EWQ0VHJgjSmKWt2ai+rBwcVbgYyV08b
         G+abHIqYZDb+1kvhVY9Vc6GmnNy+bDzR9gilTZcfT8/LuyHL8YiJWlLX9RalVFFn1M6b
         zPj8FVqysBsSVihL8arimIWEkwqkpKnpsj8uuFxRDNb64hQqsus7GtNsSauGGJiqmIUl
         Do6w==
X-Forwarded-Encrypted: i=1; AJvYcCW0YMm+Z1y4jk7LmSKvmhNiJ7BlNG2Zy0P8plRHtyNQcFEJxmy6rjgQoUHcVFgnQUlWw6+QVDcEfFuKJZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJMhoRYwmoirtbSA3bdeI3bBc5dv7g/GGYvPe0NdFKQMDKSM+Q
	kyZ+ctrzh3SszBTkSz8R/B01XgPcNLXiCzaUe65EPMd2Cd1jkn8Or+NEOQMfhHHOoACdW2ZrOC/
	1
X-Google-Smtp-Source: AGHT+IGwm2D6G2wMATcQxqf8VcOEbPWKjS5rVqXjGHNeFK9yTfG0sAAFmSK0lF9J9dyNi7ghAkS3Mw==
X-Received: by 2002:a5d:61c9:0:b0:374:c92e:f6b1 with SMTP id ffacd0b85a97d-37d3a9d3c13mr3402974f8f.23.1728547476002;
        Thu, 10 Oct 2024 01:04:36 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:5e5d:bfca:20cc:60ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd266sm786718f8f.40.2024.10.10.01.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:04:35 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Michal Simek <michal.simek@amd.com>,
	Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc: linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] pinctrl: zynqmp: drop excess struct member description
Date: Thu, 10 Oct 2024 10:04:32 +0200
Message-ID: <20241010080432.7781-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The 'node' member has never been part of this structure so drop its
description.

Fixes: 8b242ca700f8 ("pinctrl: Add Xilinx ZynqMP pinctrl driver support")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/pinctrl-zynqmp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-zynqmp.c
index 2b9f8db49a15..fddf0fef4b13 100644
--- a/drivers/pinctrl/pinctrl-zynqmp.c
+++ b/drivers/pinctrl/pinctrl-zynqmp.c
@@ -56,7 +56,6 @@
  * @name:	Name of the pin mux function
  * @groups:	List of pin groups for this function
  * @ngroups:	Number of entries in @groups
- * @node:	Firmware node matching with the function
  *
  * This structure holds information about pin control function
  * and function group names supporting that function.
-- 
2.43.0


