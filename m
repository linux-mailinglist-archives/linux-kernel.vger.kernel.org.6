Return-Path: <linux-kernel+bounces-529949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A34BA42CD7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 636167A5890
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11901200138;
	Mon, 24 Feb 2025 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWQmhBuH"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15562B9BF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740425871; cv=none; b=aJAoY3+iEUA3PntGatqvmc7cyza10bGHP+qwfr0yF6TMac6bS0E+7P8BVbQxVimevk9c3GsJbjOWRGJuhC3cz1gsD6NRnFQRJmUgR+uuR/cWa45rdUePQmaFyLH8Ps45cKQAuG+v+MENcbjBWK+PLqLhwTe3Wyg7Kn2z4860N0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740425871; c=relaxed/simple;
	bh=Yer9ETNQh9l4/nsyhuqocU9wmLcrTKZItT/z/jhnJ/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t5JXsfbrgAfZrF6SFlkqJ9aYrFZoIsbJWZFinP3qCD7fV1eCCkZnPzSm6Cs5lYxilD7+Xp32PaYlc87U3HRsEVLANbEHA++dyX0ExTsIggEisorHpWcp7RLZ9Bq7twb7B4LoSLCQCbDV4MeTUcq/gubr+5owXwYRkh+Sx4mlowM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWQmhBuH; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dedd4782c6so8935122a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740425868; x=1741030668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FrwSPRAUeS/FW9rcjfQv/aQiMRZkm6fgGKtHd8d7S3I=;
        b=DWQmhBuHZ1rctzaNUl3sSUM53sca/NesgtBIn7SfhOsFqjL13zf/GpjGUPNO3cPILa
         ItVVelPLeZTaSVNjpbcdXuSlJPTq0lYSjw/2IZLYRhpXtH/N7NPyIosw+tl6r3jsFUM1
         Rv3K9NQikQVfpW6NKw9S4syx1i2P+AShL/pYYsoEmbR7J2htVIIV/QU0Q4QGLnMoiQNq
         YiQCgOlDw8z3LUlhq0qWJJKslnUH6ouuA0D2qmYl5NiY+6oFpax1B5A62kKU1JG5BsHk
         LEsWEK6UIVYmIru0Sy9SADyjD7Q2Mv4w20fdzo6nxpJ5/Ixts8L3Ajf1IIrYypeyommX
         YAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740425868; x=1741030668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FrwSPRAUeS/FW9rcjfQv/aQiMRZkm6fgGKtHd8d7S3I=;
        b=FysAiGNH4zN8j8am8ziAROkyYVWa85AJlpk9rTib2aDWfIwKYiPLILID1V3wbwhf9T
         b4GqA2Wcgj+atmZCb4s0BU9SNv1SRiHyKxDfDOrv2CfVKvhh7QOTuHcaKAgmUFNvKTow
         hAFMzMp1NVl/IGuRiYpCR7lxp369wuP2ACeWdabwyYnKLo0y+T15Wye9MxWt6P2Wya3Y
         uxTURwNq/82bQFMQvLnqPK2N47e+nt2FLqNa5KptkP+7API0110wiMLaZE2fKcIs/rlZ
         SxL2GycFtY3/KI/xNv+Jl7cMuIaqClmGmLIZ1/7NRbZXjadC9NE8InAckkm6qhy1Knt0
         jnhw==
X-Forwarded-Encrypted: i=1; AJvYcCV0ycjr/glhIls7iXiwrS/NkVcXzzwmrsof3ZC6ZkRVCVukuXxchLrRuDEsqMSFI68vPYHaH5z193lt7b4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhXqLR+ZQfZKQJUxHWoS7aUSq5/y4IVf+SKtMq4hIiK26EWHYI
	SdDcj+Uf/FGQnXuroqPPoyBPGxw78e/6opKrkfEBvBCi+eS+qSND
X-Gm-Gg: ASbGncudRdeL2szcEs6zitFCCpalFcDt1LeUfzzWbxJZjGzRl0hn8a5xFUAMiylY1uG
	2MNOLAnNGfljvlBvuv5FnYlOtpmLVeyhJ7u8VVgCSLaWVyVbBSAJlkoQudpx/hGpIU2tdGv9Ady
	qpMFiZOhwLvUZ5P4qEsp++a/3GPtn3X5PH/Dp9tQZLTLfDYb+Wb6Yjy2UfQQQAiAmahIIAaZSnn
	t1QO6XqjGBliVCNL8HdFOapHMtC2gj8mPX+0MQcIgrRm/UeEOKiZKDwfGOfhwLV1bpYVPh8ERyH
	1ttuPz5uN+YKQNr+2LslH+4JpGLQM3+Ro4eWIHDKd9TcNM0Fei7IcA==
X-Google-Smtp-Source: AGHT+IEXdSi+85TYw9BJJn9VPwkcYV5Sc2FyfubwpLvkmNaQfzvdmWiiBDyIdD2Y+3f3lnmdqrxljg==
X-Received: by 2002:a05:6402:280a:b0:5df:b0e9:a5da with SMTP id 4fb4d7f45d1cf-5e4469daa0fmr282521a12.16.1740425867880;
        Mon, 24 Feb 2025 11:37:47 -0800 (PST)
Received: from localhost.localdomain ([2a02:2f0e:c501:f600:21cb:f6d7:4e65:6e28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e459c3fa2fsm58852a12.5.2025.02.24.11.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 11:37:47 -0800 (PST)
From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
To: florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
Subject: [PATCH] bus: brcmstb_gisb: use dev_groups to register attribute groups
Date: Mon, 24 Feb 2025 21:37:30 +0200
Message-ID: <20250224193730.2698894-1-ovidiu.panait.oss@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of manually adding attribute groups, set dev_groups pointer to
have the driver core do it.

Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
---
 drivers/bus/brcmstb_gisb.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index ee29162da4ee..91ef99c42344 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -395,10 +395,7 @@ static struct attribute *gisb_arb_sysfs_attrs[] = {
 	&dev_attr_gisb_arb_timeout.attr,
 	NULL,
 };
-
-static struct attribute_group gisb_arb_sysfs_attr_group = {
-	.attrs = gisb_arb_sysfs_attrs,
-};
+ATTRIBUTE_GROUPS(gisb_arb_sysfs);
 
 static const struct of_device_id brcmstb_gisb_arb_of_match[] = {
 	{ .compatible = "brcm,gisb-arb",         .data = gisb_offsets_bcm7445 },
@@ -490,10 +487,6 @@ static int __init brcmstb_gisb_arb_probe(struct platform_device *pdev)
 		}
 	}
 
-	err = sysfs_create_group(&pdev->dev.kobj, &gisb_arb_sysfs_attr_group);
-	if (err)
-		return err;
-
 	platform_set_drvdata(pdev, gdev);
 
 	list_add_tail(&gdev->next, &brcmstb_gisb_arb_device_list);
@@ -550,6 +543,7 @@ static struct platform_driver brcmstb_gisb_arb_driver = {
 		.name	= "brcm-gisb-arb",
 		.of_match_table = brcmstb_gisb_arb_of_match,
 		.pm	= &brcmstb_gisb_arb_pm_ops,
+		.dev_groups = gisb_arb_sysfs_groups,
 	},
 };
 
-- 
2.48.1


