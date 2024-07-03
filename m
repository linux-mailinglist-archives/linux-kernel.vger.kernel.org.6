Return-Path: <linux-kernel+bounces-240132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A427926970
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B63289945
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FC218F2E4;
	Wed,  3 Jul 2024 20:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6BogCfs"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477D14C6C;
	Wed,  3 Jul 2024 20:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720037794; cv=none; b=i2Df6GzSgXES5CsrfP0V+RAGLu4KlnfYbnX4g1Wf3dLNBsWcjtA5+hgsrQPZOL9XnRfBaEqu1XiAd1zMmbKLeFYf91L+MzZ4+jmJc/3twR2NnkYpP210dl9oIO/jkMK86Klh+cbjVVtK030OJOlYwWqXKmeTAct4cpowWRG3P04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720037794; c=relaxed/simple;
	bh=u8ogO3DLpXKLPeX5tVXlur1d4bHjjIwzEkvdano2uRY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=urYW3+Cbj1bzCtpAK4I4+F23cNdkBo90mx27v3ZitamqBAOfQO2PESMyNyym9aGjJu2LqLve5YDKMO43TFpqPwbN1gwsj2CUOr+q0fGpqd30dgZcRbFJHj8oePfC4sxeovMji3F24RdlORWhaQNBVTokgEJN4SUAXR4S9WPNkbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6BogCfs; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ee4ae13aabso61389181fa.2;
        Wed, 03 Jul 2024 13:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720037791; x=1720642591; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5FMCE9UbgpOVCC9FJkSc1QmMTWN5DEOwOg2bxxVzL/o=;
        b=X6BogCfs1NW12abqWMFdwzonaarQCC9ESzOixJC58TOC9Jk7C3Z2AIcLAKhq2CN1t0
         RdhYowgWT7RoehsB66Yr4u6QWYlTvcoxn/XKIw2iaD0ga9aG/iQN/tmTgNAcLmQtTffk
         YZHN6vrrgnMswIqLlb//f/Tj91Ql1ExEMADY4sk1avAud6U++vykmi0xsTbMkD4l5emY
         QXITGEhKe4sGMTx0FNVg7KYxFXA9yfIsIwEImlU+YUbCV2hVQseP4zHykqzo8H918r/X
         Ol0ZeNFck8K9XwROaxnITOYZfOcvQHLh3GMMUM+SJH2y0zwr89aham7rW/rfaomo8Wga
         MR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720037791; x=1720642591;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5FMCE9UbgpOVCC9FJkSc1QmMTWN5DEOwOg2bxxVzL/o=;
        b=wQTwz8K9+MwxLB7uwqLp6Lv7cNIpHik2FJRM20Kz1kyMKEROVm1ZvCcKpZ5QSDF7J7
         comkD9oCh/r8pHC9Na1BcvmfIXQ4EKPAH+0lhu69xhUHnAMcozHq9fWHox1gMgT460Uf
         EnJcq8UrzmDl2+XEyMIc2g3ruk4IB2jHBp0rQ1s4OSKKNpz48fHowNO0Af/5cG5ZP5MQ
         jZOsKBUqAYGqmlf68CrB/P5+BlYyD0a0ClKjdW//QjePU9jZj0rt8L6ld7glEKX6GQgV
         Sfkgkl/teCUYaAbETxQPScov4psglj3zn0x05O1ump7OwhIooDQvBz9UIpLoVlqaHIF1
         UeUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE82VhWlISqPKsEVyMMrUud7+lxumdYWeGc4b78rcgtetbcxNgOtWJUtI8M9poUQy/KbicjQ6O1a1uTxBxFXdOVkCapBEOOy48BkDl
X-Gm-Message-State: AOJu0YzV+Gqjn/uXZ8llPY71DZ8ar1v9gxLHtkCK8eGVRTO1AoZMWhwa
	Nrbq05AFf79zwKMzKw5jZ9TopZwmtEUz1PN+Iy5VXVXe4B61nqZn
X-Google-Smtp-Source: AGHT+IGu33G8HzwFix2em+R5fqlgoTOpVBnaWG3OHM+DIQ3+gqQ6LjvhUKMiDwiUUaUNY6tINmoNbw==
X-Received: by 2002:a2e:a98b:0:b0:2ee:4f22:33f9 with SMTP id 38308e7fff4ca-2ee5e38096fmr99568081fa.24.1720037790117;
        Wed, 03 Jul 2024 13:16:30 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fc434sm16714752f8f.76.2024.07.03.13.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 13:16:29 -0700 (PDT)
Date: Wed, 3 Jul 2024 22:16:28 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
Subject: [PATCH] dt-bindings: regulator: ti,tps65132: document VIN supply
Message-ID: <ZoWxnEY944ht2EWf@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

TPS65132 is powered by its VIN supply, document it.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 Documentation/devicetree/bindings/regulator/ti,tps65132.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/ti,tps65132.yaml b/Documentation/devicetree/bindings/regulator/ti,tps65132.yaml
index 6a6d1a3d6fa7..873d92738eb0 100644
--- a/Documentation/devicetree/bindings/regulator/ti,tps65132.yaml
+++ b/Documentation/devicetree/bindings/regulator/ti,tps65132.yaml
@@ -23,6 +23,8 @@ properties:
   reg:
     maxItems: 1
 
+  vin-supply: true
+
 patternProperties:
   "^out[pn]$":
     type: object
@@ -65,6 +67,7 @@ examples:
         regulator@3e {
             compatible = "ti,tps65132";
             reg = <0x3e>;
+            vin-supply = <&supply>;
 
             outp {
                 regulator-name = "outp";
-- 
2.34.1


