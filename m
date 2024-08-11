Return-Path: <linux-kernel+bounces-282252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1466C94E159
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 15:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 931E1B20E72
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 13:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9167148FE6;
	Sun, 11 Aug 2024 13:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+mCjAsf"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CACC19478;
	Sun, 11 Aug 2024 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723382404; cv=none; b=MyDuhitO4PzLaO5A0pbthfgKNj+mNzqo8RtM7xxWNS1O8Lr1IU30ESrds145DTntn6AEkt4vM65VuIwf3jUIyTZzOrMYF+ZYsH8D+izlQLUh0JXLKMJX8eTx8iwyTB/mjJ/klbfKRoub9vRhocYttQl3VCR+As/iqjyuRbSVCE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723382404; c=relaxed/simple;
	bh=HE6rDQsuZ6KidfU9Kxf6v892SC7kFXxatYVSyVJ4tPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ugcQNowj7XYIPG9EuIgmHyD75vHyb5xKSd7VdRipjkjNTFmtabrrz2rstBZKige5vjHBtdqRtLtBmSMzVPXAJpeYb1bNSoTbfK1o63pg/bNFlW9XDH4kEtZ4UEgUVLAJ0QnulEVqO1sUSkur4QArPzL60otfTZW4mltTJnj8hTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+mCjAsf; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3683329f787so1828459f8f.1;
        Sun, 11 Aug 2024 06:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723382401; x=1723987201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aob1f+ZTFLPVeGHfjalCeyzfLsWos1PAqrTXFXfIPMo=;
        b=d+mCjAsf8wwcont+541n/wwN/PIqCxU0WL6wXgUSKJvxYr3nVV3b4EShJutt1xrjLL
         blaPDIw2+4UVEbBOqjQJtPh7u8briVj3AxSdhOssxRPIKSHbXZyixUPK5QYasiQIW70S
         C8szJwwzeikMGEDLV1oO2Q0ZBa/NAUW46KZSyNp/h2oxdK1A/yNxr+sL+DB5y76crkBA
         EBtFelTUhgMcP5Z2ZSph0LfcPOZ0hEYPHSRO/sN4d1eBA/aygrk1VJo6lqwJfBVVzYrN
         om9XmZH4kxPegVZnCDz6Tt2PHsmsl5rdNaLGJJsrkLHxHUhpXHAU7eZ/sGuoQRiU180v
         9J3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723382401; x=1723987201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aob1f+ZTFLPVeGHfjalCeyzfLsWos1PAqrTXFXfIPMo=;
        b=QCNh53UzAEW76bP1aJwmYw8WBhdRSIW3HwdUX2DXUKnwYhPVexTU9+lDfEqHlI2KWW
         072OUawZtG+TpvjJko35fW77yyP5zKRxd2sdoJgwukFa5YzM1MCSJ3D/biyLB4Iv934x
         kIPdzOkeVXLWZxkPZpYnD87QiHSD0q6OxL7xOIz7nf5ZtaisPGef6U6kBhvLhCCxSNIP
         GsTpXpGJs+jpb6z+WY41fEl4rhob5Hh6SBpzgH1I4Yy1ifTwE/VRG8A2mGx6bsxP7vJk
         ZDRnXgJwZmMTDiaq+6YxiniWNfhbUUSxCdB1wpyLJ/QIfdTyIz4h/n9inEufhhdsVrTm
         YBVA==
X-Forwarded-Encrypted: i=1; AJvYcCWMtDKEC6u59ASGbrXJhVTq+u2tXeGAOgbxgaVItMOnV01JqVO2TxPOZ9e75EUonFnACBNQ40VtBFx9EUv1ZIERb7M8u5Q3H62JSU53
X-Gm-Message-State: AOJu0YxHAiAgAFdGPJhy2XR1aaA4nzkVmvnaEqPEyaR16tTidhh6kTBj
	cQfvZdObXA41++LVxuYqImzURVU2tEx1O1zOImcxx7tXhJqJg859sXxWoQ==
X-Google-Smtp-Source: AGHT+IGwcVciRCQGf+6Mg3nJ+VPvRP5+R0t7zHBcOacNp+CLWidPXbyzWZkefMsxktlndOZFITZ/Cw==
X-Received: by 2002:a5d:480e:0:b0:36b:a3f1:eb with SMTP id ffacd0b85a97d-36d6024f7bemr5139556f8f.53.1723382400502;
        Sun, 11 Aug 2024 06:20:00 -0700 (PDT)
Received: from xws.fritz.box ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c36b874sm4959680f8f.1.2024.08.11.06.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 06:19:59 -0700 (PDT)
From: Maximilian Luz <luzmaximilian@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 1/5] platform/surface: aggregator_registry: Add Support for Surface Pro 10
Date: Sun, 11 Aug 2024 15:19:44 +0200
Message-ID: <20240811131948.261806-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240811131948.261806-1-luzmaximilian@gmail.com>
References: <20240811131948.261806-1-luzmaximilian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SAM client device nodes for the Surface Pro 10. It seems to use the
same SAM client devices as the Surface Pro 9, so re-use its node group.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_aggregator_registry.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 1c4d74db08c9..fa5b896e5f4e 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -324,7 +324,7 @@ static const struct software_node *ssam_node_group_sp8[] = {
 	NULL,
 };
 
-/* Devices for Surface Pro 9 */
+/* Devices for Surface Pro 9 and 10 */
 static const struct software_node *ssam_node_group_sp9[] = {
 	&ssam_node_root,
 	&ssam_node_hub_kip,
@@ -365,6 +365,9 @@ static const struct acpi_device_id ssam_platform_hub_match[] = {
 	/* Surface Pro 9 */
 	{ "MSHW0343", (unsigned long)ssam_node_group_sp9 },
 
+	/* Surface Pro 10 */
+	{ "MSHW0510", (unsigned long)ssam_node_group_sp9 },
+
 	/* Surface Book 2 */
 	{ "MSHW0107", (unsigned long)ssam_node_group_gen5 },
 
-- 
2.46.0


