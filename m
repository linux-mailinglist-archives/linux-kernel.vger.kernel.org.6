Return-Path: <linux-kernel+bounces-510165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A8FA31922
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015CF1651B6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D3E267715;
	Tue, 11 Feb 2025 22:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWxxU+ec"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9F9272931;
	Tue, 11 Feb 2025 22:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739314721; cv=none; b=D8ODq4151CYgrK2FQpn22kCxtn9H0sKxS/fqdQtt8JXpvxZXSKb3w4X9NDgK9HbY9BT7/TXXyumg99wvV4EjI9YHyxsTvMkuTwGzfyqYZ/LI0cVNrhKjvDVECevTM6UBvQvMMA163uU5fmVmmQlndqbSDwLN2zds+s7pea32Ews=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739314721; c=relaxed/simple;
	bh=z17XEyYa6XmOl6iA3JgMuK6paNd3sVdubTKxNieH85w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A59WQbvudzOq2V0vh9hI0XHYQ3+8mtNagRGCo1VdNhmDF7GR2bwsgIU5O1/tWf3ACEryKQwzmZLxH7ma9p3Fzwsu2K4Ujzm/LN8TUqMI2Wad6E1824JIvJlNuqFJp08RzBRJTH9UkWmRnZeU0sQFIHmx/ZjQaNzWuNXGDF/DmNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWxxU+ec; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7c07e8b9bso468304166b.1;
        Tue, 11 Feb 2025 14:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739314718; x=1739919518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IS1Aa/IQ/IUlV5JxAaBTn62cmT2MDAhS4oWaHSnRKrY=;
        b=DWxxU+ecsI0SZoeV6fAw8+a1O+OvmsoNa+Ih3HcEFzeDeQdql/ZLm/wnNOh1Lohhct
         bjteAjYtfK5rDCNMmc8k0CWi1D0hvdT2mocQtdG0CVQlDjz4KMkVgnVlFNzppFlGc+/z
         8aV9X5Xxu5DwKt1Ph4tFHUcCYEqJP5+wmIulWgetfLexCcJcipd5QNPVdJATO7otN74f
         EJTz5Q0ihs+HIx5sqB9+gUHMIs/PrtsJhpB64yjx6JGOK/R4nU5vbmjluDovVW+X2L79
         UZNwQgLyxJjuGexJCFfDcxbf9AiFPGQxDuBjX7zoV+ZoBCxI4Aczjo/GIuqfWSUXzZc4
         yHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739314718; x=1739919518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IS1Aa/IQ/IUlV5JxAaBTn62cmT2MDAhS4oWaHSnRKrY=;
        b=UiHSahcxBx0V9hsFlZIddNyy8qJqr+tMZBJ8t8XrkqzMa8XpAJXYcv0ZsuNGNTyYBt
         G/B/BIM6lchsvTDt/JDkYKnVkdw/DIdEAzFT/z4t4KefojGScK/MTI2WDNqIQyWwlioI
         2nUl05ueCghWlwIDT77oFB1JUZcMgF3MLQvcO5aijTdThz8GGVAHUgmnb66vVRpqRo68
         3RZAohbywUjQUfUaURjm0yHph/EEQAyj4cflHsX+jNYll+b2TXRNa8JP/4N3kBWnU8Uy
         Lonfx+Z23yXrszqFvE+sNHjTP7bbTD4HaiT9TLJKw3WxL+j8eQbt38XmDX7yMIgQKCGl
         JP4w==
X-Forwarded-Encrypted: i=1; AJvYcCVm2j3HzagnE3C2XO62LknrD+QcQoxKE6FfFaqHSqs3B1HCLrSrKJsXqH9Hag+Q9hgNrnk4tlAf2P8to1Y=@vger.kernel.org, AJvYcCWSP3fMQvCezYkBCHKZ20fkvjzvOCaaCKfbrZ4al9lJ2imJoeexOOEhYogZ35gNX35uPbXytUK8SrvQGRm0@vger.kernel.org, AJvYcCWTYSIhShUyTgcSmR8K5eb0XqPTRoz2xY58c+BjvtamFwTEBBCTBW1xKX86qGcKw1vVVbC9ktBUhFzU@vger.kernel.org
X-Gm-Message-State: AOJu0YwGNHG1z8MCeqT40H5gud7cm5S2MsMaqntqz7YWSvjyC7aFHxz7
	iRy7MUPE2OiOIYioL9ODWqnEN9igTJestwVlint2oPhwX3Q7Nf/O
X-Gm-Gg: ASbGncvW8oYGm6a7C+m+9rewvCRToDdesykavAG4nDDFpKoBm0IRJ2BXu5OQRqXR3mg
	bFAmBxzbsvb6EZqQ0yt/f5nfq8lkcPm+3aJVoHdvJL77tfoF4yOsDWDhJyzKh0gTv2tgURomcPg
	uM7Gnw+zI3qt42pSpdDpf6gY2xsxSu6YdFDo8xMD58xJvFTB3/WytvunYpxDKgGvYL6tnowqL9u
	J18ooZQE5cB/Ni+aWbOqRIfj/1IgnGebCvaIhHE3fhhgOhIReSYAvtYHHOrRed3qrDrVMiA0aQu
	dowFyniMfUXCIGfB58Xv4CWR4dHZAylo9rX7+e3iK+qoZu2X9UO99g==
X-Google-Smtp-Source: AGHT+IFfDhnh48nyjrqJLvEAPlFmJ3fjs7mcyr23zd4vcVw6KZQK2okNE3vXrPxb5oT0oY2PyNoYLw==
X-Received: by 2002:a17:907:971c:b0:ab7:851d:4718 with SMTP id a640c23a62f3a-ab7f34aec59mr67103766b.36.1739314717302;
        Tue, 11 Feb 2025 14:58:37 -0800 (PST)
Received: from playground.localdomain ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7e9fcd99csm131525166b.89.2025.02.11.14.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 14:58:36 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/3] add sof support on imx95
Date: Tue, 11 Feb 2025 17:58:05 -0500
Message-Id: <20250211225808.3050-1-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add sof support on imx95. This series also includes some changes to
the audio-graph-card2 binding required for the support.

---
Changes in v4:
- addressed Frank's comments regarding the DTS.
- squashed commits for common and imx95 bindings.
- dropped patch introducing driver. This was already handled via
https://lore.kernel.org/all/20250207162246.3104-1-laurentiumihalcea111@gmail.com/
- introduced two new properties: 'reg-names' and 'memory-region-names',
which are now needed by the driver to work properly. Because of this, 'reg'
and 'memory-region' properties had to be moved from the common binding as
'reg-names' and 'memory-region-names' depend on them (you'd get a failure
when running the binding check otherwise).
- added missing 'bitclock-master' and 'frame-master' properties to codec EP.
- addressed Krzysztof's comments regarding the imx95 binding
- added Krzysztof's Acked-by
- Link to v3: https://lore.kernel.org/lkml/20241216145039.3074-1-laurentiumihalcea111@gmail.com/

Changes in v3:
- Ordered DT nodes alphabetically
- Removed 'cpu' and 'cpu_ep' labels from binding example
- Some small changes to the binding commit messages/titles.
- Link to v2: https://lore.kernel.org/lkml/20241113195240.3699-1-laurentiumihalcea111@gmail.com/

Changes in v2:
- Added new binding for 95's CM7 core with SOF. fsl,dsp.yaml is no longer used.
- "hp-det-gpios" and "widgets" properties now reference the definitions from audio-graph.yaml
- Removed extra empty spaces from DTS as suggested by Frank
- Ordered 'edma2', 'sai3', 'wm8962' DT nodes alphabetically. The order of the nodes
placed inside / is kept the same for readability
- Ordered driver header files includes alphabetically as suggested by Frank
- Removed "reg-names" and changed the maximum size of the "reg" property to 1 to align
with the other NXP CPUs sharing the same programming model (i.e: audio processing with SOF).
The region described in the DTS is the SRAM and the mailbox region is now hardcoded in the
driver as an offset to the start of the SRAM region.
- Added new binding with properties required by all NXP CPUs sharing the same programming
model (i.e: audio processing with SOF).
- Various driver adjustments made to accomodate the DT changes + some bug fixing related
to the mboxes not being requested/free'd on resume/suspend.
- Fixed value passed to "dma-channel-mask". A set bit means the channel is masked, not the
other way around.
- Link to v1: https://lore.kernel.org/lkml/20241023162114.3354-1-laurentiumihalcea111@gmail.com/
---

Laurentiu Mihalcea (3):
  ASoC: dt-bindings: support imx95's CM7 core
  ASoC: dt-bindings: audio-graph-card2: add widgets and hp-det-gpios
    support
  arm64: dts: imx: add imx95 dts for sof

 .../bindings/sound/audio-graph-card2.yaml     |  4 +
 .../bindings/sound/fsl,imx95-cm7-sof.yaml     | 64 ++++++++++++++
 .../bindings/sound/fsl,sof-cpu.yaml           | 27 ++++++
 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../dts/freescale/imx95-19x19-evk-sof.dts     | 85 +++++++++++++++++++
 5 files changed, 181 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml
 create mode 100644 arch/arm64/boot/dts/freescale/imx95-19x19-evk-sof.dts

-- 
2.34.1


