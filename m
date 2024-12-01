Return-Path: <linux-kernel+bounces-426669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFF09DF672
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 17:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0063D281A57
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 16:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68EC1D63DE;
	Sun,  1 Dec 2024 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PL2sLsYe"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFC01CB9F0;
	Sun,  1 Dec 2024 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733070003; cv=none; b=e3YxVhGrSHJH80BY86WyLyTGfIQ/IbqIIkTc9JGTfxFBu2sPoKI6zLKXXNNJIyBomhZ5HXF2ZTBqsEgNMHkbQRWMHW6fbexMS639mhslTEcp4xTzHIKGYxc5QYUY2np18IhS5InGo/H24SZLjL4IRFUjHx+EJqozaQyIH/1HoKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733070003; c=relaxed/simple;
	bh=t7Q+03i+HqFkSl0C+vB7LQyazeimNAlISe/PiGjYgn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fAO9fbYALZ9oCjK34sjlhMDUO00ZrCUUib8EjeSfiPPW8Ch0ZWA0M+NtHWgS2x/4ce3kdgre/kLGMZLx3C5d9pB/QrVuK2t8dwp2aBHKdPenxNzPt39VRhwCLgOdY3XV+1jCh4MbStb+NJUn3qFymg8Rx/tVpRMLRVWD0v1Yh3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PL2sLsYe; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e59746062fso2614134a91.2;
        Sun, 01 Dec 2024 08:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733070001; x=1733674801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8fmmWFuj2QXwlMa+xJCOftPfiVKkyTzOSJowte4eFEQ=;
        b=PL2sLsYeopwCEkur+zZEKsVzFYPNMBvCpa+/BoU+ans0eZHwslOnu0dTebJUd4NDov
         CxRKYrQdeuRZoyf/SfQDyc1xoOne38Qahj7+mT5GuXCrUELwmzTJhU0OolQDo/EVvZjl
         h4BCtHOI4zXkfP7WzEtiVP2QqW/4XRcm3hI/gO9bV1Q/jw3MOPmrz/I8/4VZC3BRKrjv
         y8mRfmE95XpoCEUvF5JWKz4Cb41N36Kwq0cB5NKfEuN2vBXCcKTZOOqiL87Y+4rJ9R+z
         igJIoespPkcOuua3M8bRkyv/j08qq0X8uywYFnlztR5XX75YW0HDRsnFmJNPtN1G++B6
         TrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733070001; x=1733674801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8fmmWFuj2QXwlMa+xJCOftPfiVKkyTzOSJowte4eFEQ=;
        b=FwBEEZy/RzMt0RnALUmOlDPdauvLfyx7rXdm01IkvI/aXXwshaRKKTqA7gbrI0pUwP
         Wj09NurJtoEP8PK2tWt0sH+xgIcALV8XhD+Je7GkQajZRc2bq2S7dMSKhFMGoO0/pSH+
         K2peSgESRYPhREluEB4R9jAm5tp7YD1W4nW7EAS8o1JFyOM6G6ioerRYtKvc0ySKHeSH
         ZIKbsrLooQ2WXa1/xiZv7z+4LzxXOw+6tOXamZInAHPygH72ZLj9F/eW3zB5oROEn1Gt
         Wf0vAEJtvznLPa9SXmgpEGQLeriHtsbKKs0PA4cNrYKRVTRlEmkglnSBFFt0H1AqL4Pp
         NOWg==
X-Forwarded-Encrypted: i=1; AJvYcCWZcBPX8VGgVAE/ar9hZo9wzx/IYkv3yxBTNMFWdbd/D/bOkymO3cWjqcPIPHeEonNkorv2Itq4vWVs@vger.kernel.org, AJvYcCXxIk57aeToIpJZ7ztriqndQSBdV8GXqDU6p10/cr3uXM9KvZ8tJaMq8EsARgKPn/K4TKymDj5Ko30cmsKq@vger.kernel.org
X-Gm-Message-State: AOJu0YxwvqcBPlzFq5pBCRqMVDuJDJtxaZrhGimKfV5eb7Oq4EwDG2ZD
	1rcLUEGShCS6jfo8MEXk9LAGFXFFAsSOXESE2B5wr9JNFuY6iOTY
X-Gm-Gg: ASbGnctm6ZPKceIqikOOBu8qk9lGPFCNhCOPLDk/jgoy2wkTaumsWM3b9eYzwPo+RFM
	jb8SFuwMCpuNPdPZBuU4rvPyqjU74JXeqkBZGwLTb3RWNI/DunDQ8Fi9H1FVqK1WcqCfWHU87hH
	5xfyNIBDGfmFgBst3n9iZE9Rco110b/9uQfuAM9f6eFHdZSxsruEPBmKwqRNBeWiBEt0j0xsFTz
	E8ssYe0uDbJAxWf0N3xjLHTDsZfve7wdKP29QPZ7McY1+MOf2j55+OME5jZcNG9WA==
X-Google-Smtp-Source: AGHT+IET+u5LDNMyzPy/22Zfz08qiTYsCD7kHsmPaZYvpfT40p0BJktpcCR4QS21645GpQRzwE7Yww==
X-Received: by 2002:a17:90b:384e:b0:2ee:3fa7:ef4d with SMTP id 98e67ed59e1d1-2ee3fa7f57fmr17772287a91.24.1733070001043;
        Sun, 01 Dec 2024 08:20:01 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2ee78834450sm3007392a91.6.2024.12.01.08.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 08:20:00 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 0/3] Device Tree for Apple T2 (T8012) SoC devices
Date: Mon,  2 Dec 2024 00:18:40 +0800
Message-ID: <20241201161942.36027-1-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds device trees for the Apple T2 Security Chip found on
some Intel Macs released after 2017. This SoC is based on Apple A10
(T8010) SoC and, for many hardware blocks, can share the A10 compatibles.

This series requires the PMGR power domains series for A7-A11[1] for
the "apple,t8010-pmgr-pwrstate" and "apple,t8010-pmgr" compaibles,
but otherwise can be applied cleanly.

[1]: https://lore.kernel.org/asahi/20241201155820.29259-1-towinchenmi@gmail.com/T

Nick Chan
---

Nick Chan (3):
  dt-bindings: arm: apple: Add T2 devices
  arm64: dts: apple: Add T2 devices
  arm64: dts: apple: t8012: Add PMGR nodes

 .../devicetree/bindings/arm/apple.yaml        |  41 +
 arch/arm64/boot/dts/apple/Makefile            |  16 +
 arch/arm64/boot/dts/apple/t8012-j132.dts      |  14 +
 arch/arm64/boot/dts/apple/t8012-j137.dts      |  14 +
 arch/arm64/boot/dts/apple/t8012-j140a.dts     |  14 +
 arch/arm64/boot/dts/apple/t8012-j140k.dts     |  14 +
 arch/arm64/boot/dts/apple/t8012-j152f.dts     |  15 +
 arch/arm64/boot/dts/apple/t8012-j160.dts      |  14 +
 arch/arm64/boot/dts/apple/t8012-j174.dts      |  14 +
 arch/arm64/boot/dts/apple/t8012-j185.dts      |  14 +
 arch/arm64/boot/dts/apple/t8012-j185f.dts     |  14 +
 arch/arm64/boot/dts/apple/t8012-j213.dts      |  15 +
 arch/arm64/boot/dts/apple/t8012-j214k.dts     |  15 +
 arch/arm64/boot/dts/apple/t8012-j215.dts      |  15 +
 arch/arm64/boot/dts/apple/t8012-j223.dts      |  15 +
 arch/arm64/boot/dts/apple/t8012-j230k.dts     |  14 +
 arch/arm64/boot/dts/apple/t8012-j680.dts      |  15 +
 arch/arm64/boot/dts/apple/t8012-j780.dts      |  15 +
 arch/arm64/boot/dts/apple/t8012-jxxx.dtsi     |  44 +
 arch/arm64/boot/dts/apple/t8012-pmgr.dtsi     | 837 ++++++++++++++++++
 arch/arm64/boot/dts/apple/t8012-touchbar.dtsi |  20 +
 arch/arm64/boot/dts/apple/t8012.dtsi          | 198 +++++
 22 files changed, 1387 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j132.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j137.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j140a.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j140k.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j152f.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j160.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j174.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j185.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j185f.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j213.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j214k.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j215.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j223.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j230k.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j680.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j780.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-jxxx.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8012-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8012-touchbar.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8012.dtsi


base-commit: fb4ec083bbf366f092f9064b18531be92756745b
-- 
2.47.1


