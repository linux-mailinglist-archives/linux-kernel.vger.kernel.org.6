Return-Path: <linux-kernel+bounces-409599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 674149C8EFF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6D528B1B6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450AC1420A8;
	Thu, 14 Nov 2024 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="gHPv12Wg"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E884474421
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600106; cv=none; b=mVjBirJYqd9TgubfDbIQ8kY4O7LBqOIpZHtM+1Zjv3Ob/VsiCwFF6Q+3EcqgAcR0qDS7a42x7r60oHa9/aR3f1CWOTVmGPMRN45e+O/suYr8IwR1I+pYa8cI76Zp5Zhb8u1SgKS1PCUXrTJ8U/OlldtrlyDSfEM9I1cAkDPUZPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600106; c=relaxed/simple;
	bh=1EPzcE/kgZDig5Otxrs/UZexLcFi8WM1Xgs11JokbYA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Vl6Hz5wdyiC6glIlgFyla0ET26sJEZTUnHD8t6q6EwLtRI6iAXMBNdFjrwcJqgV5XpnR/ZJUrcIThFRBLhDFnelNakcq7AM4BFkCMWEPMPThjEKp4JtEuf3gPJzNXdYpUb09ilBTmp0gBOjJ+An6xVJqaJNQt4bSS3tyN73nDKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=gHPv12Wg; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38222245a86so195860f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1731600103; x=1732204903; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3JMdSgtq+Ttm3L6LRQ+ruGkVxLt0T6TxcM+79MWVPjE=;
        b=gHPv12WgX84b9BZBuABq8IgpEx9aCr9sfEs6amrpqNn8HVTZrh05b0Jfgl9YgN75CZ
         UkXFPW+ztAA2I96LFL/GY0sSVwfFPzHH/9LT4yRjnBYlK8rYFBYqAn9t4VJ26mpge7q7
         UJVGbwBBUarhE2QhewPnFc431i+PCExbAKk2/rF7lODSZlslAedcMunoeEg8a492MRLX
         mLmYsXugmJS+exb+vzjPvJcVdGmf6vtoYi6pr8rk0AUJdV2I2TSMPTPML1+hOReBKP41
         jISZIia5OSUEpoHiMUyORwF+6GBrOtrqNeN8kHg8CyaAnKaBmKGZKsVN8JPG5X7I8u20
         u7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731600103; x=1732204903;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3JMdSgtq+Ttm3L6LRQ+ruGkVxLt0T6TxcM+79MWVPjE=;
        b=Sq8dh+mQJlkrCvtBtt/VaLJf8pzGWqtjEBg5wJUq5rA74a1v7cj/qJ4Df4JXDhKF4M
         Dr0uNwvxTaQYlsmIv6kvxHfUgnP+TibWzaKH2dwKWwGU4gFPzxr0nOEka7km7DNIeLF9
         kYX37q76KeqoJ4+1vtlyO0L/MgOnDv/zDdiZ7diJGivhss9sOpKU24k/7KotfH/5d55a
         CljEfMu5WeILQ6KekupClOntGV8P/ii8AMnK70KF/3dwsYQKrpZnnFqFsPHz9hnXpM3U
         kWTSloswEB8xkTMDK+QAYzaBlX57EAP0at5EJUr7hbZW4gVJaQfsNtA1eQhmSacbtz84
         A2lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdu4DSlRukQAbqiyi0bmibBqksZK6QmLiI96nhNZSTNxbESxKxQfe7rKw+FNDbzLLVSAHdw72dO+tiiuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU06PJw2t1Js5QaRlnKCPSFN695Bgb7G6rHjDl+ve037QIDSes
	JhuKbnfJTwKbuIOaJ/1Hc5g8klYvQIk03EfQuCsnO0/cMHirF6mMXVXt90PGbxg=
X-Google-Smtp-Source: AGHT+IHU3640S++GiWHY22g8DyZvC0xVaN2q6y5oxKROmxj3Ujh55YAboEOHGvnPvVceKb9fEiHwew==
X-Received: by 2002:a05:6000:784:b0:382:5af:e993 with SMTP id ffacd0b85a97d-38205afeb31mr11196763f8f.54.1731600102718;
        Thu, 14 Nov 2024 08:01:42 -0800 (PST)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-382200fe00esm1139024f8f.42.2024.11.14.08.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:01:42 -0800 (PST)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH 0/3] media: i2c: imx290: Add support for imx462
Date: Thu, 14 Nov 2024 16:01:12 +0000
Message-Id: <20241114-media-imx290-imx462-v1-0-c538a2e24786@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMgeNmcC/x2MQQqAIBAAvxJ7TmgXS+or0UFzqz1YoRBB+Pes0
 zCHmQcSR+EEQ/VA5EuSHHsRrCuYN7uvrMQXB2pII6JWgb1YJeGmvvmgO1Ku8ziTdsa4Fkp5Rl7
 k/q/jlPMLm8rouWUAAAA=
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

imx462 is the successor to imx290 (and imx327 before that), and only
requires a few very minor register tweaks.

Whilst at it I also fixed the todo over imx327 and imx290 having very
slightly different maximum analog gains (29.4dB vs 30.0dB) and added
that to the variant structure.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
Dave Stevenson (3):
      media: i2c: imx290: Limit analogue gain according to module
      media: dt-bindings: media: i2c: Add IMX462 to the IMX290 binding
      media: i2c: imx290: Add configuration for IMX462

 .../devicetree/bindings/media/i2c/sony,imx290.yaml |  2 +
 drivers/media/i2c/imx290.c                         | 78 ++++++++++++++++++++--
 2 files changed, 74 insertions(+), 6 deletions(-)
---
base-commit: ed61c59139509f76d3592683c90dc3fdc6e23cd6
change-id: 20241114-media-imx290-imx462-b6d1c24b77b5

Best regards,
-- 
Dave Stevenson <dave.stevenson@raspberrypi.com>


