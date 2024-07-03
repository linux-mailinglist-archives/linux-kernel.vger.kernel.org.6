Return-Path: <linux-kernel+bounces-239759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599F3926502
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D5A1C21878
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F041181BAC;
	Wed,  3 Jul 2024 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyonFXuk"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD6C181B90
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021079; cv=none; b=bJYFNBdynyDdXglHBcuipXkwXr/zEudEwpooPlpQFrENwd1PG41X8K1rVpcGF/oB9nNEaofNHD8iBTTAKy78ID31CZfLYy69rK51KDq7defKgakx5IlStbbU+E0iQ/KAA06KAPjdn/cZCjbMc7RheaLepabbvvp9X2YsxThNaxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021079; c=relaxed/simple;
	bh=ToTvATnp4WABvxAFVRt/CR2K+RafSr9oJSdMneycmR8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Yda3mOHXq1iBI4o0H0aOy+a+tp+nt5iqkPWqM3ZXRHwTKzFjTlbXqv5ntO4egnAHQM5+lX1+q5yukz3Gy1/wNIdMCwB/lXY0yQ7hqN8qIGoqK3w3j6RvNnB+9iNFkeicKmAp4MIsk0dyABvWEPF8Zy44w0Cz7BIzj9FkydfJp38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyonFXuk; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a725041ad74so219455866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 08:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720021076; x=1720625876; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0qoGRCwGNsTclf/4dZ4LBPFCeRN6TBtp4p8AKuUCcKw=;
        b=hyonFXukyrGkGBX2XyNs10hv0sjzLQPxF/Ea6MKChRW5ONwFjBRxOFuXUlXPfqOeD4
         i/NfYHvcEPqak2sleHmzeXuzeXAsdvtUXQdVTbY0hPLxglJKBNnIlPuGo2n8hS0Fi6AL
         xtqd2uvmNmcBdEjZ+c6jRyvjIqiUgKrtczWj2E4anFgn03CgPYQHsN5wpU2tlW5pKvRL
         /8WJEY+Bsy4i2dJguTnYlAW+E7rcFL1QS4iJ2qwYDKcAs1O/cZeKH4k92ZW4336cw7Zz
         Q0w1fKdjtbnsti0Nm6+7c6RRuH97gpXQoWD8MUeGdgF1YN/3q9l/YDkyPSmRHvZCS2Tv
         Y+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720021076; x=1720625876;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qoGRCwGNsTclf/4dZ4LBPFCeRN6TBtp4p8AKuUCcKw=;
        b=wryiP6rYg8G+7W/MddqIGd1Awu6TFTeXAwy4eYLvZcjHVOmnLBv4OX9IE3Ulkf8Ngz
         cipqsHq/cNYTh5ZS1EcV0i7Tcw/OylMPdTQaGsvvmCJgzGT9GhqT1zaxEZkzXKn90+rl
         r1j7gS3XFQYGBsrCFRHiGm2Seoc0Iz8T2xrMrKOTFsX3L366pezgjGLr5sfZfnYAC8/K
         VStK0e546sEYjD8j2yXbNvsezo/TlhpajBKqhkTcEeUckg/vtmBri8UXhRJc3q/BjXKE
         jf6+Ty9Q+MLzkqBfddmkJbWfnOl197piMttRTBxtxGt7Aw4wmPLo2T4h4MnsSBVIedgs
         P/lg==
X-Gm-Message-State: AOJu0YzIBkSlQcY+bJHzTvLfSB5vnTPQiGd4b75nPq3338KsuIR6sb8m
	HjtfRVY8Ee3OaO+VXH2aG9C3O7XYsgjWimxAOKku/x3a8sxO9Zvw
X-Google-Smtp-Source: AGHT+IG9tUs1K8wFUzZ6FBE31DCX9QrAQqkQU0GQjvqCXnv+VDlXB8CazidTqdklLVnNbx5+M6zTjA==
X-Received: by 2002:aa7:cf8f:0:b0:58c:3252:3ab8 with SMTP id 4fb4d7f45d1cf-58c32523b82mr2920229a12.37.1720021076222;
        Wed, 03 Jul 2024 08:37:56 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861503b4c5sm7119512a12.93.2024.07.03.08.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 08:37:55 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/7] mfd: Constify struct regmap_config
Date: Wed, 03 Jul 2024 17:37:33 +0200
Message-Id: <20240703-mfd-const-regmap_config-v1-0-aa6cd00a03bd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD1whWYC/x3MTQqAIBBA4avErBvQyv6uEhGSo80iC40IpLsnL
 b/FewkiBaYIY5Eg0M2RD58hywLWTXtHyCYbKlE1ohM17tbgevh4YSC363PJsOxwaI1WJHvdKwu
 5PgNZfv7zNL/vBxreTUxpAAAA
To: Support Opensource <support.opensource@diasemi.com>, 
 Lee Jones <lee@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, Xu Yilun <yilun.xu@intel.com>, 
 Tom Rix <trix@redhat.com>
Cc: linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720021075; l=1254;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=ToTvATnp4WABvxAFVRt/CR2K+RafSr9oJSdMneycmR8=;
 b=AGMaznePLnXgEW/jSt4EEspaxMwtnpG/rCVqCkUct9H+d4UivQMvlfVn37EjkyWRm2dkQGY+o
 seS0kQN09fvChJ2BEWEfUN6pOnxm4tP8hnbzbcmFXGqGGXfAz97JeW5
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series adds the const modifier to the remaining regmap_config
structs within mfd that are effectively used as const (i.e., only
read after their declaration), but kept as writtable data.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (7):
      mfd: da9062-core: Constify struct regmap_config
      mfd: fsl-imx25-tsadc: Constify struct regmap_config
      mfd: hi655x-pmic: Constify struct regmap_config
      mfd: wcd934x: Constify struct regmap_config
      mfd: tps6105x: Constify struct regmap_config
      mfd: rohm-bd9576: Constify struct regmap_config
      mfd: intel-m10-bmc: Constify struct regmap_config

 drivers/mfd/da9062-core.c        | 4 ++--
 drivers/mfd/fsl-imx25-tsadc.c    | 2 +-
 drivers/mfd/hi655x-pmic.c        | 2 +-
 drivers/mfd/intel-m10-bmc-pmci.c | 2 +-
 drivers/mfd/intel-m10-bmc-spi.c  | 2 +-
 drivers/mfd/rohm-bd9576.c        | 2 +-
 drivers/mfd/tps6105x.c           | 2 +-
 drivers/mfd/wcd934x.c            | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)
---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240703-mfd-const-regmap_config-96da5e18a85f

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


