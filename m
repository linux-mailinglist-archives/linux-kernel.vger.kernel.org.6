Return-Path: <linux-kernel+bounces-534448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 250FEA466ED
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35EDD3AE668
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B4422257F;
	Wed, 26 Feb 2025 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZh2KD9W"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9DF21D01B;
	Wed, 26 Feb 2025 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588399; cv=none; b=tDXbtKKmyPF2xYAMP+jv3E8FHTHNisPdAb2dCI6JkL6u16jIT+W6rbEBitd2chJvf4Hwj6+IwRYkcIAK8SCmOgwmua6JFhtoqbHwiUBbe724hcDjTj8EMMVRs8xrCaaTifhdomghh63K6CON2k6sPudLiucAVUsyKqsOOenVBeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588399; c=relaxed/simple;
	bh=PI9gat1Shjx3Rwg9Z+QfkzAqopCGWVbuaV2ByMujHLo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NKUpjlj4pQRrAPv9stqOCY7O7UPxHRJKe2oWxMZU4GPtrAYlLyg+kUsOxYPtpp4VR+WYlxBUpYjPGzRx8rRdeTcjcSBk2Rw0UvAK6TAYfLi9AGFFVHJRqxbdfo1rxEG+hW/N0tcCsDdRGshTVPpkNVaBoQ/3bgSJ4Ym/pKjh1o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZh2KD9W; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-438a39e659cso168165e9.2;
        Wed, 26 Feb 2025 08:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740588396; x=1741193196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gn1jVpYNtqABB36v1CD74BC8OtMIG7ZKsW6uUkVb878=;
        b=bZh2KD9WB2puDV/caexBsjPCXPFSJVxyKN6QmJgktsvuNpkxLAQWDXzogdycXexVQF
         uyy/Ex8KTSc5lSZNPZ6QCFK9+WwNpk/0gh3t4JQ81Zu1E47B38Hu3kGLoqnFV5Ode4hR
         RGEKinz/mjen6Dap92NWyrT934eP5jd7TB2v1V+18HyaT4bfFr1/vfyKhM9fiCiaez53
         FO3KQmI73/eGN2y/JNMP2JRdpKU8n+icOImXzQpHF+boVMFlKxAxj5J/dFEHrQ7F7V+l
         8imjCjeUW9xn+kHvlVyI5Z+BvfVebjVxmp4AycgZCIpFvCwm9uD8P+CKu7PMH2SXiXVK
         zJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740588396; x=1741193196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gn1jVpYNtqABB36v1CD74BC8OtMIG7ZKsW6uUkVb878=;
        b=Fcs2oSuBqv5+LraSCtAEkl2sm4yEteM8Jwinvsf0OwnbkOo7dShAmBDxnyQpXIfKIn
         1wuUOzZbxldQJW7PDRi4ig3Wcv9MqMwXdNpuM5XT2RBqHWN/l+1zkn5QjMjH0o7pPTaR
         vtxXGg7Hus3F1XSEN06Hm65NhzeNKciBoqa/YdzMJR0yJStb/XIot8VZDpWATFzNb/ZY
         we7bzuBqfY2nMU7e2LWiL9eyFHx5S5MGtB0SLupL0X5BYH8rlSyHIOFeRtuYwHCpGhG8
         EmCbJ0rv7HAoDC2g/vG4hMytCT901uYMmn6GlAQoHqDofAEX8fiMPZn/z9PbPYQGGZjj
         mMwg==
X-Forwarded-Encrypted: i=1; AJvYcCUpmW9Wxk544NN43ld+Srck3QXESxPDt26HkN8er5sQ6HDYHnj9MRAxcpifyaU2wCS7vCGmPpeVBRnb@vger.kernel.org, AJvYcCV88OeKg9DX1e5nr1kHmmd65PKF8cqyX9G5wqHfjURBaMSBOdAwxrUUXBFcfJuaEdGdpEjiuupuC3Ep0pA0@vger.kernel.org, AJvYcCVWJ4JHUh2rhgAEm/Ke5/RNgjH5C58eASd8safZEpmDlRav+u56M+XmHRub0epy5J6IsYrVNuAmyKBz@vger.kernel.org
X-Gm-Message-State: AOJu0YxKDneeS//ihucLK4yhCgGitwKw2+SG0+ZG/c9m3u4hV0qK6pbR
	dZt/i88S76sHtMLelNFsoAAIOHI85tuksTnuznbAJDOQD1ey4+2Z
X-Gm-Gg: ASbGncsnwtjZmkdrzb41Sj4OmSOSqguPDrudjZB1Kqf4PlUgAY7AVzQwdD7Dso21dEX
	H24DAlu3Qa8PdJ4WnfOHC2AcofgC8dxSNfW3xs/3fNI/Te9oymI3wuPPHQN0VrxqMaiFIZyXh33
	HzCsXUbylOll67HKIzbIelgXbrXqGOUmGgHxkl3X5AGSedJfCiWBPSdlhI0h7O2lykrtMvEo268
	HM11je/qiDHgO6cWrdvyM4QK2p58mkNxLu3aSPseCi9dqAIxikC9gc9XLFuayMCYZDxjU0PDBDA
	+LttLgr5ckW0Y3nq4ximDXLw9q7AkigRd2yB2y4GO4QQfONZkMW4lZ4jcBvaBkNl
X-Google-Smtp-Source: AGHT+IHASu5EZyCMob3n+ZWyMrlOQTMJxxFYG7U17xiFzsRsj31Q08c/ZUItm4yM1mcyej2N52nKxg==
X-Received: by 2002:a05:600c:4689:b0:439:9f97:7d67 with SMTP id 5b1f17b1804b1-439aeb2c755mr223185145e9.16.1740588395267;
        Wed, 26 Feb 2025 08:46:35 -0800 (PST)
Received: from playground.localdomain ([188.25.208.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8e7165sm6200215f8f.73.2025.02.26.08.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 08:46:34 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Marek Vasut <marex@denx.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Adam Ford <aford173@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] clk: imx8mp: fix parents of AUDIOMIX DSP/OCRAM_A
Date: Wed, 26 Feb 2025 11:45:09 -0500
Message-Id: <20250226164513.33822-1-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Correct the parent of the AUDIOMIX DSP and OCRAM_A clock gates by setting
it to AUDIO_AXI_CLK_ROOT, instead of AUDIO_AHB_CLK_ROOT. Additionally, set
the frequency of AUDIO_AXI_CLK_ROOT to 800MHz instead of the current
400MHz.

---
Changes in v3:
* add missing Fixes tag for binding patch
* improve the commit message of the binding patch
* link to v2: https://lore.kernel.org/imx/20250221190929.31469-1-laurentiumihalcea111@gmail.com/

Changes in v2:
* add Fixes tags
* add Iulia's R-b
* link to v1: https://lore.kernel.org/imx/20250217165718.74619-1-laurentiumihalcea111@gmail.com/
---

Laurentiu Mihalcea (4):
  dt-bindings: clock: imx8mp: add axi clock
  clk: clk-imx8mp-audiomix: fix dsp/ocram_a clock parents
  arm64: dts: imx8mp: add AUDIO_AXI_CLK_ROOT to AUDIOMIX block
  arm64: dts: imx8mp: change AUDIO_AXI_CLK_ROOT freq. to 800MHz

 .../devicetree/bindings/clock/imx8mp-audiomix.yaml     | 10 ++++++----
 arch/arm64/boot/dts/freescale/imx8mp.dtsi              |  7 ++++---
 drivers/clk/imx/clk-imx8mp-audiomix.c                  |  6 +++---
 3 files changed, 13 insertions(+), 10 deletions(-)

-- 
2.34.1


