Return-Path: <linux-kernel+bounces-408234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333AF9C7C6F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4209AB28447
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216D9208230;
	Wed, 13 Nov 2024 19:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSOMzs8y"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE70C2076AE;
	Wed, 13 Nov 2024 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731527609; cv=none; b=i2WhPGFhbnygM8TeZs5pVFHxXbGO0qdxWPhfJ+rZd3/8Zi3Or9W8cvsmOzIWwE3dzEeiLGiet4sHkwvEClHCNsO01CfXghvxG7UXY18OigSn1OvKscapU8MqC2GO7omvV6m41FlV9iOVA0udRPAEe37TrHOfLk+VgIffrh0Lxjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731527609; c=relaxed/simple;
	bh=cWi8DmSi7C7RoYGebBs9V11KbEf0JwdrdWWSFkvT2/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZNVS5Gb2KXZQV7YF/03eROhuXjLwgEivKYM6N5541cNQ7mFC/0mNQXTqnzTf2GS5k2yavfHwMUue0g9HMVSWmGyZDseUeLny+y/Tm03YadcRfxj4Ve3oKRJLzvJSHAxEQPhMqF1nbleYbqSe4cgMw+WLo0srmZXV1Sjy87JfIlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSOMzs8y; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d63a79bb6so4759063f8f.0;
        Wed, 13 Nov 2024 11:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731527604; x=1732132404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3O9xjwYbMuKJBMh8JPk0dRAP4OjyngOz+BP2VQZxpdg=;
        b=HSOMzs8ygp89H5/+VPf6u0MBUiGfeVc1vw0tY2Zybz5ntUp0mImRwQIRtMoS0DdOur
         k+xtXPyQD/pQncQrkkh1yQ7cksAwfwKqPvmDzRrt1ZdbeFUNa95Ru48WuC7ImAoOSp12
         EAZD7UQZcORFxd6hAxFuHUpdzqyJnneF/W5Yw7rBUa5EYCWQ8JcHgYv+HcfjyChTtV11
         TpH2v1/3Cj/kaS1cBbpRQp6c6lYLlLr955UbhG4odTNvC8+3F0AD7rG79c2ZQlgMmxq3
         SnvtSpmULwSshnlA4qsU3k17qcMLr+08+l4Pb95iMA3g4X5PdpR0SVdMMTOEdZbiaxKN
         dAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731527604; x=1732132404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3O9xjwYbMuKJBMh8JPk0dRAP4OjyngOz+BP2VQZxpdg=;
        b=gLqqGtioqEzC+g7emJg4906RDV71a1spiaN4/uo5TlAiN419dPrax3J/ukRIgwp7fr
         +1sgxDUdCfpFXE3JJ9CNtLT1ntmde4zkdvippwVshl1M9nzsbxBXBalbjvwoKfPTiQY7
         YjcYkCM5HE8FswRByqr+KPRg3Rh76odUqj3mE6ZsbWxM7Ysded8j6H5+9Zta642v8n9B
         qth7eO7byi/SHaLAkPKb+QtbgsYrt1hoNAETvNxaQKWIZFfcAhQCH+Wl5jQR794KpI5v
         awwR8836AoT3SfGPMbCPqNCUEZVZR5teOZUEP2kWNBOSD2oNMuiLZMD/mu4iuXi6Z51u
         s3KQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0pMunCGOFnL1o5QqN+iUbvuWMnJwHceKf01jS24jBVP/NmN/D9GFCLKvXV9cmLryckOtsDn2l5tkjS4wd@vger.kernel.org, AJvYcCVitaZ7ZCKiqFiMc6/SSsZ0x/ZwFgvXLFXk6jjCg1X+BxuR0RXt/8uGFm1CsawVkyTJ/Qqfni7cumfaT6M=@vger.kernel.org, AJvYcCXX/6achx43Sl2980SLbEFsdXR7FN886XDifJ66x+b7iv6619/w8ZaeklK5Ik82n69yMHPFiv6JN/Jg@vger.kernel.org
X-Gm-Message-State: AOJu0YwsMmBCem5GQn7Jkk8aVQDX9br9FaHdnkHlujmxMXnNhqSoYjLx
	xWDyNa8IU/5wNvQck0z2PeTYYX63VRaXdtlxzvqrxpeIgFJgavOT
X-Google-Smtp-Source: AGHT+IEANOLGqOrMck5zuaV/awm4uDnLiNsDYeECS1iqXbhkM7NIIObAN6edW4LT/VwwrIADcKG8Jg==
X-Received: by 2002:a5d:5849:0:b0:381:f596:392a with SMTP id ffacd0b85a97d-3820df8884cmr3387252f8f.43.1731527604134;
        Wed, 13 Nov 2024 11:53:24 -0800 (PST)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d5503c58sm34633065e9.22.2024.11.13.11.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 11:53:23 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Frank Li <Frank.li@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] ASoC: dt-bindings: audio-graph-card2: add widgets and hp-det-gpios support
Date: Wed, 13 Nov 2024 14:52:38 -0500
Message-Id: <20241113195240.3699-4-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113195240.3699-1-laurentiumihalcea111@gmail.com>
References: <20241113195240.3699-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Introduce the 'widgets' property, allowing the creation of widgets from
4 template widgets: Microphone, Line, Headphone, and Speaker. Also
introduce the 'hp-det-gpios' property, which allows using headphone
detection using the specified GPIO.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 .../devicetree/bindings/sound/audio-graph-card2.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml b/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml
index f943f90d8b15..94588353f852 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml
@@ -37,6 +37,10 @@ properties:
   codec2codec:
     type: object
     description: Codec to Codec node
+  hp-det-gpios:
+    $ref: audio-graph.yaml#/properties/hp-det-gpios
+  widgets:
+    $ref: audio-graph.yaml#/properties/widgets
 
 required:
   - compatible
-- 
2.34.1


