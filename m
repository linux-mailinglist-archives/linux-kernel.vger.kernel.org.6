Return-Path: <linux-kernel+bounces-201816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EA08FC3D7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE7C28707E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 06:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247DF190484;
	Wed,  5 Jun 2024 06:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhOZWKe9"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AC6190463;
	Wed,  5 Jun 2024 06:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717569626; cv=none; b=hlqdHEOTj01NL8UDsVbjqySpyrYzVpn8XBwpSHVXI9+nvvNlut7iBGq1/w778SZZRKz3qdUonfmrvIdSIRwpDuipFssjGrBeQ5xqLjQv5h6hhEKilYDDTVt7xoGJyD9o7Jw5f6MbQHoY5EzhB7bN6SjSn2oiodXtvV7ZUBLjFmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717569626; c=relaxed/simple;
	bh=HUmZC+X+gSvZ5AqCY61GMZk0M/Jpdo8sLUH0vmNpxGI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hfZqS1Pw5s08U5sEBA9IUl1MAPxMfchYSvmk4AGjY2BmKXIfNp9Z3XBvAGIAjV9dwyx55UVs+y4tdwTECtvXoZS7ab9r6Au06iTLJxT1UtA09F4Rl+0tNiEPdWsNTjvVBRmH2PumsZEbID43jSY39UjkPI3VhW9s9uBDh3Fj3Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhOZWKe9; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a31d63b6bso2473590a12.0;
        Tue, 04 Jun 2024 23:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717569623; x=1718174423; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gHQSaCky/f1AkfcDoHbC9p7wCP5m6j70LxPNgz93GEs=;
        b=EhOZWKe9YkZExHivKXNAEryVohdmm2ogClpa3rNa7AWb8Zyk5Rw01COivkUpF6tdT2
         3sWipdUpmP9uFvwRz6J0I+SIgFU1BGZeVzDeNmGjo0lojYm/ojIkwOOTllY620RHRJAQ
         aLJKBWCV0Uc6uK/Y37npFDFR3K/Bqyeplv/3hZ2AkyyzxreT1JZu624cJQfYHplZypUR
         SesSl/g+Gz9fcrI3OrSzRUw/CjpfdnP4XImkfNLbMGgrm9rB5iuUWH8Adc/mp049YS/M
         XzZzEu2VqaB7QeyTTSawQivUEIvmYXd/btBRWXXu+pB8Jv6AT/KetnS0kmKrjSnToSDx
         ZL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717569623; x=1718174423;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gHQSaCky/f1AkfcDoHbC9p7wCP5m6j70LxPNgz93GEs=;
        b=evgUa5EBw/EWjYaXSWvHHhrwpSfF3/CT9SQlC0qnnJHtoBBNWBpI8ORhjoDfpt/889
         QBzCWArvRGXJCq9LxPjH707HQgEDhgwxOK9FxoEBnEK6m9e+xALfh2oVSdS3soRagXVG
         Av1YK+bR5qfvP+c25e/XvX5umTsE+5zoPqaH6Oa8gPQVGK5mE6cxgCXkNnDKm7SF3Bm5
         f4UZsFDgTFtykuxd2suUx4UpVsf0zUn8+apocMAA2CECPTQs7OGOd33fU1Grj96PSt4I
         Ae3cijZxD0Du7j6dmX9hr7r3NgXIJ5V5gqqyMkqqDphjL1v0pppEqLuSEuxYtUA8cq+M
         m2hg==
X-Forwarded-Encrypted: i=1; AJvYcCWxiUc0dsRxL0MBZ270ynur4ywVHYMuEXuJjyOyCHLoM+LTGlDImjFECmfgf5Deap7UVBWS5jZFP8MuIO5ZeJ1lwYKq3PAbSRrYh3P0WtiQO8pl5kLSsfz1TmAmz1fFj6CjwhqulpWbLQ==
X-Gm-Message-State: AOJu0Yz0C6RDgs9EbUvmhSfCrOmDwPqkePVyoNRcO2sOBN6oK2MXZ9HL
	Z0tuepdaW/XW6KAnqcFZ2ledeJsU1igkumKOr42w4hIcx9Oik2qz
X-Google-Smtp-Source: AGHT+IFBIMS6vkz0iVSVx1CRPA3R9CNPTJew2oQiC4UzE9eGj9fN4Cxwfgw2HMmCfC3PB4GWaIidtw==
X-Received: by 2002:a50:d49b:0:b0:57a:2fa2:8b99 with SMTP id 4fb4d7f45d1cf-57a8b7c61f9mr1234625a12.29.1717569622846;
        Tue, 04 Jun 2024 23:40:22 -0700 (PDT)
Received: from hex.my.domain (83.8.128.191.ipv4.supernova.orange.pl. [83.8.128.191])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31b99445sm8665505a12.18.2024.06.04.23.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 23:40:22 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH 0/2] ARM: dts: bcm-mobile: Split out nodes used by both
 BCM21664 and BCM23550
Date: Wed, 05 Jun 2024 08:40:11 +0200
Message-Id: <20240605-bcm21664-common-v1-0-6386e9141eb6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEsIYGYC/x3MQQqAIBBA0avErBNUJouuEi3MppqFGgoRiHdPW
 r7F/wUyJaYMc1cg0cOZY2hQfQfusuEkwXszaKlRDnoSm/NaGYPCRe9jEAqlwcmgRTtCq+5EB7/
 /cVlr/QB0VC+QYQAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, 
 ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717569621; l=2315;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=HUmZC+X+gSvZ5AqCY61GMZk0M/Jpdo8sLUH0vmNpxGI=;
 b=3ZQ3nIGatAyX+FXgVC/jZDU7XBK+W7jMk8bN1v2GBcYR4q+AKCAxJL3K1ZZ16TFMEGQPFa2Au
 Q0IWcwheBEEAoPRlR9ml3t0atWa//LV15tXcMKeDcF0NGs6Oyo4zDfo
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

The BCM21664 and BCM23550 are nearly identical to each other in terms
of register layout. This was verified against a downstream kernel[1] -
Broadcom's kernel has "RDB" directories which includes headers with
the full register maps for the included hardware. Running:

  diff --recursive arch/arm/mach-{hawaii,java}/include/mach/rdb

reveals that the differences are minuscule - some things related to
ISP and H264 decoding. Most of the other differences are related to
the different CPUs in the two chipsets - the BCM21664 has 2x Cortex-A9
cores, and the BCM23550 has 4x Cortex-A7 cores.

In mainline, most drivers are also re-used between the two.

To make development for both platforms easier, split out the common
nodes into a separate DTSI, bcm21664-common.dtsi. This only leaves
the device-specific nodes - so, CPU and related things - in the SoC-
specific DTSIs (bcm21664.dtsi and bcm23550.dtsi).

The new DTSI is based off the bcm23550.dtsi, with its split into
busses. Since it's pretty much 99% identical, I kept the licensing
of the original file (BSD 3-clause). The license for the bcm21664.dtsi
file remains GPL 2.0 as it originally was.

make CHECK_DTBS=y on bcm21664-garnet.dtb and bcm23550-sparrow.dtb
seem to pass fine for me (thanks to Stanislav Jakubek for converting
the bindings to YAML format!). It's worth noting though that some
bcm23550 compatibles now go unused, since the bcm21664-common.dtsi
file uses bcm21664 compatibles.

[1] https://github.com/knuxdroid/android_kernel_samsung_baffinlite

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Artur Weber (2):
      ARM: dts: broadcom: bcm21664: Move chosen node into bcm21664-garnet DTS
      ARM: dts: bcm-mobile: Split out nodes used by both BCM21664 and BCM23550

 arch/arm/boot/dts/broadcom/bcm21664-common.dtsi | 334 ++++++++++++++++++++++
 arch/arm/boot/dts/broadcom/bcm21664-garnet.dts  |   4 +
 arch/arm/boot/dts/broadcom/bcm21664.dtsi        | 326 +---------------------
 arch/arm/boot/dts/broadcom/bcm23550.dtsi        | 354 +-----------------------
 4 files changed, 357 insertions(+), 661 deletions(-)
---
base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
change-id: 20240528-bcm21664-common-14064864a4a7

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>


