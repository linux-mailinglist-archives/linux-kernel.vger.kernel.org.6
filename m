Return-Path: <linux-kernel+bounces-321311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F05FC97189A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B39E1F238EE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD6B1B6555;
	Mon,  9 Sep 2024 11:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f62uuDBq"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA9B1B5ED0;
	Mon,  9 Sep 2024 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882584; cv=none; b=lF8ezoHH8e9vyLqr8vSfskYRjXPhaAljX4JijuzDyHSfdmcwgvT1ewrSfjVnAeC6Y6YmXuyn3tt6tsSWqatde8N98kPnBIDQifAA3/colvxWduYKFIv3tctQMA5K5cXSlH2p3tIjOszFWRae+L3cv170C45lKbnj74WZ1UUlo3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882584; c=relaxed/simple;
	bh=UjUQdhF28S5e2gkfA9iAi3YHEU8wzz5waE49UWZUlkk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I6HGg00WuY9vDXOJohvCVnfR26jqaZYfJ4PPQ80Ac/2VFn1IKohwY84IupiyqTn3yS04s0Tz8dKt9aIAEtjCkE4od3bUw4x7apsL828o71gtfDQlE9SN3/Yh0PckawkB5qRR4iwhQICuQt8OCFc7ngkQTJKhOjYWvWJBHmWBpko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f62uuDBq; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c3c30e663fso4791160a12.1;
        Mon, 09 Sep 2024 04:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725882581; x=1726487381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5Q59M5UcS9lYEyHTKOxDWIK9dPVLxcWx8Bc90Z64lw=;
        b=f62uuDBqmDVnXpCZzc8chSra4SbPYP6bvypOhfJWErmTwJijfmAmY47Cb5BiWWpt3C
         9TDNkRfPe3FsVPqXskO6+/JsZIQ6v2YaxspylfkDaZHmzeavxw0zNc2/h8MeG2o9riAp
         GCZkfiKMlRcoZWSKrrDQ/Bp6US7z9T/6Zj39ys4toCwm8IKIQUYJPemK7w+EFFNDNsUa
         LswB/mSvTfcNuMAExiCtN7y/4p20CbWakM2o9/2Jpp60NFDS/rp1rTftXPOn8nPNiTbK
         sI+X60V6hTZNzSxhUIixgcEY+wD747cjdQMRUg0y4Z5OjY97uToYay5bhrlOt9sMlAlA
         4Gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725882581; x=1726487381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5Q59M5UcS9lYEyHTKOxDWIK9dPVLxcWx8Bc90Z64lw=;
        b=p836ENbIktiYZzvaiCyqNdmxcfEk+jkodQAoMHLyIB57IZiUOTV08tFobE8PvX57+D
         H/Z9NKZkvDsLXRSuF7dLI7nIMOu7doy/gtUHwcCILKqQTKoKNmh8NVu0dUhp2CR/8ALD
         WlwuSSSbXRPG+tm15i7knniFEqeFgw7VNreFTE0W9osZzX4+QWKNW2ndzNZ/sSnUTDQA
         lo0PEKHsL/vpQwLRUOj8nWZmUZx+jOHT3vbIXgZqFR7/XvBKtP970GLzj6iT87Ze5BxB
         xU6eEC+kMK/G1DzKBPcfySns+e5vtTlEtgxaduNLJzoQbx9JVCHUaeJyiQdCAuRz+Igm
         HgGw==
X-Forwarded-Encrypted: i=1; AJvYcCUHbOwGpuaHnBvCxhjyaxt7rOeueK4GZaNuzco6fBwKsZUv8d3cUKs1ludPs3zQM3nzJbZo+SWC8Nqv@vger.kernel.org, AJvYcCV/BaJ7ojNMpZxtOGXJPUpmsbzyYKwAcXRuZS8KdfLXitZcXxclAE4thxMIeJ+Y+OqScKvyA81JM/+VOCZU@vger.kernel.org
X-Gm-Message-State: AOJu0YwXM58LIC54XpsOYnPuC+yPYNU9xj+F6IUZiys6YvxVEDlR85Pe
	OptXNx9JtCwkUAT/nFeN9AG5KemsLSw2FLxCZ+xBP25gtYVuMV2p
X-Google-Smtp-Source: AGHT+IGnn12OpKnei0SyDRHdvhXGAiS4aMiBJVCWCDSQABP9+v/izyXiR5wcq+A4VAgRd0gbzZIy4Q==
X-Received: by 2002:a17:907:2daa:b0:a8d:48c1:2c5b with SMTP id a640c23a62f3a-a8d48c12e94mr369797566b.59.1725882580234;
        Mon, 09 Sep 2024 04:49:40 -0700 (PDT)
Received: from hiago-nb.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25835697sm333258566b.16.2024.09.09.04.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 04:49:39 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH 1/3] ARM: dts: imx6qdl-apalis: Update audio card name
Date: Mon,  9 Sep 2024 13:49:00 +0200
Message-Id: <20240909114902.82380-2-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240909114902.82380-1-hiagofranco@gmail.com>
References: <20240909114902.82380-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

Update the audio card name for Apalis iMX6 to match its specific SoM
name, making it less than 15 characters to fix the following warning

fsl-asoc-card sound: ASoC: driver name too long
'imx6q-apalis-sgtl5000' -> 'imx6q-apalis-sg'

making it compliant with the ALSA configuration specification [1].

[1] Documentation/sound/alsa-configuration.rst

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
index edf55760a5c1..1c72da417011 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
@@ -191,7 +191,7 @@ sound {
 			"MIC_IN", "Mic Jack",
 			"Mic Jack", "Mic Bias",
 			"Headphone Jack", "HP_OUT";
-		model = "imx6q-apalis-sgtl5000";
+		model = "apalis-imx6";
 		mux-ext-port = <4>;
 		mux-int-port = <1>;
 		ssi-controller = <&ssi1>;
-- 
2.39.2


