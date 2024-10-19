Return-Path: <linux-kernel+bounces-372884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 001AE9A4ECA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 16:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843221F22E16
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 14:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C384148301;
	Sat, 19 Oct 2024 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYFbV/iL"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C2A2AD19;
	Sat, 19 Oct 2024 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729349353; cv=none; b=hcBUIDV9XtXguJb2V+rZyn2+7eo90Yt1t3i41F76xfToHr6YVn1m3nik2rH7ZL/nV7vuKzfoO4IM+hnq2oz2wM8z3TaQEh5n6qWWC7GA1i40HWagqIClQ+3B3e0s6Uz9KNd8zPNzBv7XeqkDhBCJRtg2ZJ8CuPKn3Rf/P2fD+yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729349353; c=relaxed/simple;
	bh=6EiicdGSTOVUJrs1WDjtV0CfHwrY07h6vyPTLyZblpk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WSLbRDsEoquQcDtQt4V4amDAtw+oQ9x0zNHcoV0T4CSqwYJkEVR2CptBdQduMPs3ukpbr8jbsu47ZMRlEE12JghiS+1w5PoWua6Cbi2CugK/JHaO1T4z4aDeXxJPvpVGBWArIr1lJjSN0HpVijf/JmCtj3GkSDYmCc3P5nmGN3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYFbV/iL; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2bd347124so2294831a91.1;
        Sat, 19 Oct 2024 07:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729349350; x=1729954150; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wRAsQzWsfAiV87KFN9bQd1+c9EDfP1rQjP9KURtePIQ=;
        b=TYFbV/iLS+HaVwbhc67tLxZUjSvdFH9iS5BWfyr67t9srltF6lysUdlq7lPdSR9lzp
         UmIwQHpTurroFnh0OrbspYTCDSpIWsvxkGH1BXTmdVGPuSphG3UdjlpJhmUReYRf0ynl
         zR5Nhd8DNzxxTBwvEPnM7ArkySnVES0cHdpCn5aao0GjAIDuiHpaMomAA4w2KTy8K51Z
         RyuSylC0IPmjtgxU4iMd+194wPdjObRP0z61J12tBBfUn/BUSxcm4JWrpaJ/abMhyuC8
         kyEMzki5DTzh8O70hELqZz9gM+q07Wadyweqg5HZWHpIf5D7XUi0hqGdx9kKydKj4RJ2
         0Wmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729349350; x=1729954150;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wRAsQzWsfAiV87KFN9bQd1+c9EDfP1rQjP9KURtePIQ=;
        b=LQigx5qEsQnjj/3+Eko24xNleQrN0/dN5QTEeCitw5p5AfMsepGZ4kFTstBx55BHi1
         axVTYURGQ8Qh4chaoTPnomHV5nky9V9VDydZG9FlhI5FepI0tM7+dv6bd0QTuZQNGPht
         sF4IiZrlsIt2E2po98du3BTbcyagUZtVX31nbnK4P2uPrbq/GKviJEmIi/4WTnyixfkB
         31PFgNRAgqsjSCyk6Fygo9vcUte5L/NdX1qzUUQFw4vye56mg23eO8qZVULLAvbmLbsq
         0Q2YpRHNSe0yUkJmNv6pvH4q49cD5Avzvmt6JGHnLRRaO3wqf2iPweWH2Pn9gy54jgRQ
         vPPg==
X-Forwarded-Encrypted: i=1; AJvYcCUjjHjCvevwlQBcvSEKiWRRPDtsCNV80iedFRanbdW7LocpZ5joKxQSyTwNHbRCjQfKTMgxfABh10hb4iU=@vger.kernel.org, AJvYcCVshmw9EiFzYeJwcppDRJMUZf0GXuXFJ+fRZQGeM+eAjGHmUie7blmMD32DZz2k745uh7fUxtrWJgJrQOTw@vger.kernel.org, AJvYcCXo2oe3jnBa/2+Uyf20z2LBEcNvtMYJdsoqwqH8OMypM2L4mjyTU5VPrkA/T//56mBkN7jPpNhYhaNs@vger.kernel.org
X-Gm-Message-State: AOJu0YyjcoRJr7JMuk0GxEeeadOsySZUDuddO4eTReAfX6xC4Df5myKK
	jqB7Dpxcq0UePnHGc9w18m3GW/G93dnb46BE1T1OUn3EwF9chq86
X-Google-Smtp-Source: AGHT+IF/CW7kqVzu7hqUryPlTN2q8R7zDuFbVqC8bGTXEhRj5xeUdaMdZBx6GucLxSsVvyMCzUkE/A==
X-Received: by 2002:a17:90a:a617:b0:2c9:5a85:f8dd with SMTP id 98e67ed59e1d1-2e56163fae6mr7006798a91.18.1729349349808;
        Sat, 19 Oct 2024 07:49:09 -0700 (PDT)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e58390d63bsm1325747a91.0.2024.10.19.07.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 07:49:09 -0700 (PDT)
From: James Calligeros <jcalligeros99@gmail.com>
Subject: [PATCH v2 0/3] ASoC: add CS42L84 codec driver
Date: Sun, 20 Oct 2024 00:47:30 +1000
Message-Id: <20241020-cs42l84-v2-0-37ba2b6721d9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAILGE2cC/2XMywrCMBCF4VcpszaSTIKNrnwP6aJkpu1AL5JIU
 Ere3dity/9w+HZIHIUT3JodImdJsq018NRAmPp1ZCVUG1CjM9pcVEgOZ+/UYL11ntAE76G+n5E
 HeR/So6s9SXpt8XPA2fzWfyMbpZWnlq/kbEtI93HpZT6HbYGulPIF/2LGzJ4AAAA=
X-Change-ID: 20241016-cs42l84-f38348d21c88
To: =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 James Calligeros <jcalligeros99@gmail.com>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: asahi@lists.linux.dev, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>, 
 Neal Gompa <neal@gompa.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2417;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=6EiicdGSTOVUJrs1WDjtV0CfHwrY07h6vyPTLyZblpk=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnCx26dKtl54sDfs78bD3t/vvw0SiBWLH/lUpcU33dzZ
 s4x6Jk9r6OUhUGMi0FWTJFlQ5OQx2wjtpv9IpV7YeawMoEMYeDiFICJbPvCyPA87FODY+tezw8/
 lxy7MvtjYcFHG95b/Mt77r1aJt8Zk9nOyDDF5nPZ7mu2LHH/ukNOuHvnNB4zmFSwU3uD82nhpcy
 hWiwA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

Hi all,

This is version 2 of the Cirrus Logic CS42L84 ASoC codec driver.

This patch set adds a driver for the Cirrus Logic CS42L84 codec. This chip
is (so far) found only on Apple Silicon Macs. In keeping with proud Apple
tradition, the CS42L84 is essentially just a CS42L42 with a different
regmap and no publicly available datasheet. It may also be missing its
parent's S/PDIF capabilities as none of Apple's devices support S/PDIF out,
however this cannot be positively confirmed.

This driver has lived in the downstream Asahi tree for quite a while now,
and gained some refinements along the way. I have squashed most of these
into the initial driver commit as they were small changes like tweaking
msleep()s or filling out TLVs, but left seperate a larger change to
tip/ring sense IRQ handling as it differs significantly from what is found
in the CS42L42 driver.

---
Changes in v2:
- Fixed failing DT binding checks. Sorry! (Patch 1)

- Added Martin's name to the DT binding maintainer list (Patch 1)

- Documented #sound-dai-cells property in DT binding (Patch 1)

- Dropped superfluous DT binding descriptions (Patch 1)

- Fixed DT binding description whitespace  (Patch 1)

- Fixed licence comment format in cs42l42.h (Patch 2)

- Fixed erroneous whitespace in cs42l84.h (Patch 2)

- Switched driver to use maple tree for regcache (Patch 2)

- Lowered max_register property to address of highest observed register (Patch 2)

- Fixed switch/case statement style (Patches 2, 3)

- Picked up Neal's Reviewed-by

- Link to v1: https://lore.kernel.org/r/20241016-cs42l84-v1-0-8d7e9d437d2d@gmail.com

---
James Calligeros (1):
      ASoC: cs42l84: leverage ring sense IRQs to correctly detect headsets

Martin Povišer (2):
      dt-bindings: sound: Add CS42L84 codec
      ASoC: cs42l84: Add new codec driver

 .../bindings/sound/cirrus,cs42l84.yaml   |   56 ++
 MAINTAINERS                              |    2 +
 sound/soc/codecs/Kconfig                 |    7 +
 sound/soc/codecs/Makefile                |    2 +
 sound/soc/codecs/cs42l84.c               | 1112 +++++++++++++++++++++++++
 sound/soc/codecs/cs42l84.h               |  210 +++++
 6 files changed, 1389 insertions(+)
---
base-commit: 469819cc17368702a6f68cec2148f518d3f3679b
change-id: 20241016-cs42l84-f38348d21c88

Best regards,
-- 
James Calligeros <jcalligeros99@gmail.com>


