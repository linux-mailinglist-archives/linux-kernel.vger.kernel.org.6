Return-Path: <linux-kernel+bounces-432403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C860C9E4A43
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A496D1657C5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714A94C8E;
	Thu,  5 Dec 2024 00:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="AZqwORTc"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F72118D;
	Thu,  5 Dec 2024 00:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733357004; cv=none; b=Cyf6oY415IQsEpD7NBM4UmUv3fH7nVFGyNa12AHuum6wiQS1WEYfYepVicdcDiuwpklZ3eK9kb8QQ/qEsDcq8eaFDmfMJU0YtMD4lGZ8CAi2M4h9KbXoD4IHUcwpPyEtz1u05kiY8hhveXA4Q6F9Aqbe6d1iULLP1BFYOWCYPdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733357004; c=relaxed/simple;
	bh=CKE11tWu+JmxaAsYR+vRS5M547y/KoHSE90xNDKjAVg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NvXAjQOhT5qmyqtVMtazA3+OFpTYmVA/9Rb5A3QxFIdEeFrAURumCUVSeq8AI3zc2EgL1tyE5yTFMCphMYvidI3yricjrlNuU6ZkeErr2CUZQLM1UHwfFMSm453DKMvltJd6wP2y2WB1aHKSkgKdATPMBhqblDbY+s4/UnwF+kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=AZqwORTc; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 81637A0E14;
	Thu,  5 Dec 2024 01:03:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=WNNOpnUyLFiCbOGUxMtfO2sYZhHb/B54RASf1pjeX4E=; b=
	AZqwORTcqlhQcOdQ3nidlRkFbnL4iC2qfhQOVaeigT244W6otYsdMtFlk4Ps9LKK
	2uki2KeiKNF4qz1N7L5HZRO78D65w14VItktL9s4JBmns4U4UkI97AsHCmfBue49
	vl+81d002TZoujaOFfAPcc4spliyakL07ya1s9oTH3w/u86mUw/h0bdbGRXWmuBc
	ccDWOuBwUAQ6MfsCjZJCd+nLcIuAGXJmHVK3jVeZLyFeMTNQkbTRmrLWmJcW9561
	SIoPgkAB33AAIm9070j6kEWpRI/JA8MSOHL0FjCGVll7yfaEGsYFkqeXUCQoaoHb
	796yoRwYFvDpdoGYDRWcYFEWB9+tQsF7HcpK9Msbv4Xm/LGLbQmpPca3o9g0yce5
	LUP3YWnvhOkm66Tyeyyl7xK9dXKODDdz3OQBFmiO3ISCBRkBGJdlzEmATtxp5grr
	HT0nWnJhO/ehBYq2yzyhMZevaedFCXR/7d1jpFQeW8xoC6S9F2a9sAEAbYL8Rdy/
	H2ul2BthXSOeDYOor5bJ/Tsboacjzsn76tUBYCTtigf3xAdjHyJ4vkJmr3cX6NH7
	xH4c5JcaRs+BnKMDL2x/LIXRo1oSlUs6iTCpWG/3DjLIA0DP8IUBSCUw4V45Qmrw
	50l6cz2GSZeCIkK3AuarRAwHN5l9jCerQn4ZfR4XQQ0=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Mesih
 Kilinc" <mesihkilinc@gmail.com>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Chen-Yu
 Tsai" <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, "Samuel
 Holland" <samuel@sholland.org>
Subject: [PATCH 0/3] Add F1C100s audio support
Date: Thu, 5 Dec 2024 01:01:35 +0100
Message-ID: <20241205000137.187450-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733357000;VERSION=7982;MC=821435405;ID=169666;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94855627561

Support for Allwinner F1C100s/200s series audio was
merged in the for-next branches of the DMA and ALSA
trees, the last step is to add the codec to DT.
This series was forward-ported/rebased to the best of
my abilities, on top of Linus' tree as of now:
commit feffde684ac2 ("Merge tag 'for-6.13-rc1-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux")

Mesih Kilinc (3):
  ARM: dts: suniv: f1c100s: Add support for DMA
  ARM: dts: suniv: f1c100s: Add support for Audio Codec
  ARM: dts: suniv: f1c100s: Activate Audio Codec for Lichee Pi Nano

 .../allwinner/suniv-f1c100s-licheepi-nano.dts |  8 +++++++
 .../arm/boot/dts/allwinner/suniv-f1c100s.dtsi | 24 +++++++++++++++++++
 2 files changed, 32 insertions(+)

-- 
2.34.1



