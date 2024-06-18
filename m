Return-Path: <linux-kernel+bounces-219521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B26A90D3B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66B7E1C243DA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936A314F138;
	Tue, 18 Jun 2024 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oy//mXjH"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744AD2139DC;
	Tue, 18 Jun 2024 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719137; cv=none; b=F76GRZVMxxNiwrtXw7gQjay1dCWEEVV0+su9epoxvvwgKXUG4WkUMK4DPsqkgO8jvxq9cE/l0ppNNa6rkH/sK1wMS7LowaaG61gkVUOLPl1eR6+NO8Cwou6GS21i4TKLr1HVSzX6tpsdAfrgfQbQXzbZ77OidWsFqmyDsgPLglo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719137; c=relaxed/simple;
	bh=t74u3phtzLN0vUBs5RytaJNRQLOAkYDCVIdyyRNA18Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F7+Dn1o5JQJw1xsHXvVYT8wsP4oeTDAUZbBpPKu9NKw/LStVbCiBdapRHhN1MQerIEcxpe9DAMNINgB3B0nmj6lsDcqzCJNvkAIa5msjOParTlK6sycjRGKUEeQ4/yzjHZG+CULXxg51mxl6mMZU2ZNDEWcsZjQeAaxCjPSxwvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oy//mXjH; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4ecf1013d73so1634695e0c.2;
        Tue, 18 Jun 2024 06:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718719135; x=1719323935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TYfI5nOU0IAPMtEFtRxzuAHSwpXT7+g+NfhR/02RYVc=;
        b=Oy//mXjHKyLMdn/ESciM2SrABNmAw0Mdmyg8kcrS0f+bQSGVEwlzJL58sKOV2tHeNg
         De9lKlM4G9LmOsujJ+NevdjXGaqXb6ji7KM3NLIN57bHfz5TngwdpbC1i35l1fPOX0bb
         IxzPSz4uQ04OtRYrX/sntWN2BkFXpLXJ9HL5kwD/f7T4C8wjG0iNj9LxFs/Qogsu6l30
         kOQmBocYEgDDhOZe+1vcApO7x7X77obw2WQC108zJyMKCkk08xen/TQZWB5oxRW88y1H
         ibLOKquSxCSReelzGem0GSr8ndEg5gEJSWbxBH7uP0K8tCjvNXWgNYyUzTBbBWjY/W0c
         n7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719135; x=1719323935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYfI5nOU0IAPMtEFtRxzuAHSwpXT7+g+NfhR/02RYVc=;
        b=B59HFBC6ke/N7zijb9bOGkJs8kTlALSn6OHekn7dMyTWeSlzdRe49dZrNf8cTpJ093
         s4wTYOH9xjEjwdEp9WPJ4DjSPOQdIAdqjFuGlwHSnDHD86JsqlFBHTURLvnxVEfPupvr
         i1e1VdbkeZEuZ0N6kiVSHW2ND1US7UiBugHlq1STD5r+ZT/iJUMQmfPVR10gxm5c941O
         dl5cfAU5TTGMOWM29GU0KeERgXSiWrIpSItlj2LtwLgWr2AWgvMELk5PXyHAMGmqOf6u
         CESqXmkf4MURFCchSrp/dxSG2ULsd1rfe0GrQWywP2Ma5U46uHODsh7pN2o+vb4fneM9
         2vGA==
X-Forwarded-Encrypted: i=1; AJvYcCXuDIZWluMQZ3foVnN0QYaS0Xc+z3vFmEmnK/aYRmA9uAycMP8AxQoNbruKr34E6ETUs9Bvu8ADcryvqadKDA74XVfA08SD5pxln4TmBiozItvEFk2zHzexV/noNdBPhlK6sR9WNilA6rY=
X-Gm-Message-State: AOJu0Yyz0YV+1JoztBZpK+PKibC1+lpBkyshEJOTRZJd+/Kt/ZOTUd4G
	1VBifZRV0Qp7hlpDpO8CVecFB7EYsmRQ3ZOWRp2wxAcBSsoqmSTD
X-Google-Smtp-Source: AGHT+IFIPVkPn7XiLT66LAV6MJqZPMDQbCwF7nP30+mENWEUlNOpaTUZgvZ8wjsLdKHQqaCxxYDjGw==
X-Received: by 2002:a05:6122:2025:b0:4ed:53c:e0f6 with SMTP id 71dfb90a1353d-4ee3e48c19emr11715153e0c.8.1718719135392;
        Tue, 18 Jun 2024 06:58:55 -0700 (PDT)
Received: from localhost (57-135-107-183.static4.bluestreamfiber.net. [57.135.107.183])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4ed3fda8815sm1771295e0c.32.2024.06.18.06.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 06:58:54 -0700 (PDT)
From: David Hunter <david.hunter.linux@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com,
	lgirdwood@gmail.com,
	broonie@kernel.org
Cc: David Hunter <david.hunter.linux@gmail.com>,
	linux-sound@vger.kernel.org,
	julia.lawall@inria.fr,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sound:rk817 reduce memmory leak chance with __free
Date: Tue, 18 Jun 2024 09:58:45 -0400
Message-Id: <20240618135845.13387-1-david.hunter.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using the __free function instead of of_node_put helps with
preventing memory leaks.

The kernel was cross-compiled and installed on an arm64 system.

Unable to test if the sound system still worked because I was on an
Arm64 virtual machine, and I could not get the sound to work on
the machine.

I could not find unit tests or kselftests that utilize code in
rk817_codec.c. If there are any tests that I should run, please
let me know.

Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
---
 sound/soc/codecs/rk817_codec.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rk817_codec.c b/sound/soc/codecs/rk817_codec.c
index d4da98469f8b..1ad576cd7ea2 100644
--- a/sound/soc/codecs/rk817_codec.c
+++ b/sound/soc/codecs/rk817_codec.c
@@ -456,9 +456,9 @@ static const struct snd_soc_component_driver soc_codec_dev_rk817 = {
 static void rk817_codec_parse_dt_property(struct device *dev,
 					 struct rk817_codec_priv *rk817)
 {
-	struct device_node *node;
+	struct device_node *node __free(device_node) = of_get_child_by_name(dev->parent->of_node,
+									    "codec");
 
-	node = of_get_child_by_name(dev->parent->of_node, "codec");
 	if (!node) {
 		dev_dbg(dev, "%s() Can not get child: codec\n",
 			__func__);
@@ -466,8 +466,6 @@ static void rk817_codec_parse_dt_property(struct device *dev,
 
 	rk817->mic_in_differential =
 			of_property_read_bool(node, "rockchip,mic-in-differential");
-
-	of_node_put(node);
 }
 
 static int rk817_platform_probe(struct platform_device *pdev)
-- 
2.34.1


