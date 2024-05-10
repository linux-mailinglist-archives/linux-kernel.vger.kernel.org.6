Return-Path: <linux-kernel+bounces-176201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A4D8C2B95
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815891F21B75
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285CA13B7B2;
	Fri, 10 May 2024 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="isrf+GGa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J80B271F"
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E1613B5A6
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 21:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715375726; cv=none; b=fbHqIPbY6Uyw7UstlFf2xKhgHJihuuBe++C3vA8rS5dAz4gyyNgMPLYip8fjltHXLd2rcC5gUuoy9n+2gjlVnP5r1evIOnVfbXBEo520APgbnbIhkWFmM5pL80nAsQvF6a+U2h2l1Z6cyN1ZzSb6mOW5XnJmAJl9jnBGOR2Pe3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715375726; c=relaxed/simple;
	bh=auGTu7esIT0vw90kFpXiYWwKZeOL11cQbE8q4dBOikw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=HqKnuhBJEZpUF09ys2JC+EeHTQgjBHhavl89X3FP+A1GG1Tdsl/3Thu6oTlsgawyQEB0boDaegUWHaK13vQJiJNRVtqLbhvnePRaLaSfziXXjBsGn+28z/kuLaazGTzOAcgdGvAP3LQ4JBy8LKcq7ngmTIl8cmfY8mx5hIt3cbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=isrf+GGa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J80B271F; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id DE3A91380396;
	Fri, 10 May 2024 17:15:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 10 May 2024 17:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715375722; x=1715462122; bh=iMO1GaEnJx
	wMSjVKJ+hpYFQaPPqa58048TbbEanpKyU=; b=isrf+GGaYho24FMdfxDvFyungK
	SH4mZVvw0DFDx0yo5evVdTa+PWzi5IZdwgSeq3ah3uur7A1z8tzy4loxmv0U2/QK
	na7lFAHt/Mt+fjAKnH8MOOXMSXPpm2MG3xlwlhmqhkeuzxPbIxLjK3mIRlmZlHrx
	uGEzITHD/nYaHES1M6cctPWPQjq26nARkBmyhJxxGucRfReIFytYrjkEaUrkXo7Z
	Sh7OEZwzRDhN7dFMH5c0pJrDRD2G6314kktZmg3BZZqNpW/P5/+pqM1dJYu2vF9R
	7T0HtO9JBOWYNN3iWVE57u1NBbQJvtA+jJrsH4iDShKJAxPElNDacGnV30mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715375722; x=1715462122; bh=iMO1GaEnJxwMSjVKJ+hpYFQaPPqa
	58048TbbEanpKyU=; b=J80B271FB6bIcSkTDOudg98EiUQsHbpuzDiTlS0bucmn
	Tha4xYU7VVjiygMxZP2cARMPRxiOJFMrePjpWgxuZzWoEvACtU8vQ6FvedCeRzzW
	R91INPTFpBg0IY7h9MLKXZiUJKqUGDwDD4ehhr4OKVa4iCySDUfUB5Tzzu7dlo63
	pXnRTwAmERyvL97s+rOW+fonq2TtDJbKf2ovAXVwr6BjUGRfiMaIsHXpbljpg75C
	yY86pEGH/Xdd1rXDjlV19frl/Z2LOP1TUa7jg5aFzJ2HWE8zxo8jU34aoob+5E2O
	SWkYXQmDxoyTJcyxfExqCrr8dB015tBqRFp+N27TvA==
X-ME-Sender: <xms:ao4-Zj-X9vgF6iMRwkwIMBLM7KepEgKuLm3offI2tUbLcL8JZBijqQ>
    <xme:ao4-Zvsb6-QbQAVgKeJHhb99cXQVac0pJHzOF-dNsp5ckgSACcsLqiZ4eV9O5F2bq
    toWh_wZDpP7sTfoJNo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeeigeeuvdekheevudeiteegudfgjeehuefghfettddvteeuteekhfehudfh
    tefgvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggv
X-ME-Proxy: <xmx:ao4-ZhDEAiAjcWCOdfuhuJqu2OjOFveYHVe_MrYQ_4JIwBXaoKia0Q>
    <xmx:ao4-ZvdG9wD01AxiiGK80pI-qhihS70gdmtM_mGQD2B0oA7czcKjOA>
    <xmx:ao4-ZoPlAm3mk8RF6DNuGwKPPDI032IEdj-rrdMHo4ZUtHHXzaTenw>
    <xmx:ao4-ZhkHGrQPTM3z_-ppzaIwXD3XDyFpNGoZqcNXzDDOsLDa7QUiGw>
    <xmx:ao4-ZtrWCNXOE2whJXg_kOtwAuUFaEYfNMMMsykdsPDWE6bIZxFicBsO>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 947EBB6008D; Fri, 10 May 2024 17:15:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d8eb719b-3b66-4475-b117-7a4734af9def@app.fastmail.com>
In-Reply-To: <fa20b5a4-a131-49b4-9597-15886435a288@app.fastmail.com>
References: <fa20b5a4-a131-49b4-9597-15886435a288@app.fastmail.com>
Date: Fri, 10 May 2024 23:13:38 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 4/4] soc: defconfig updates for 6.10
Content-Type: text/plain

The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-defconfig-6.10

for you to fetch changes up to 78b08cf6313061499948126aebdf00e1079e4d21:

  arm64: defconfig: enable Airoha platform (2024-05-10 15:56:33 +0200)

----------------------------------------------------------------
soc: defconfig updates for 6.10

Most of the changes enable additional device driver modules and arm64
platforms. In addition, the usb onboard-device support and ext4 security
labels are turned on.

----------------------------------------------------------------
Adam Ford (1):
      arm64: defconfig: Enable DRM_IMX8MP_DW_HDMI_BRIDGE as module

Akhil R (1):
      arm64: defconfig: Enable Tegra Security Engine

Arnd Bergmann (9):
      Merge tag 'v6.10-rockchip-defconfig64' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into soc/defconfig
      Merge tag 'sunxi-config-for-6.10-1' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into soc/defconfig
      Merge tag 'tegra-for-6.10-arm64-defconfig' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into soc/defconfig
      Merge tag 'qcom-arm64-defconfig-for-6.10' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/defconfig
      Merge tag 'imx-defconfig-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into soc/defconfig
      Merge tag 'renesas-arm-defconfig-for-v6.10-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/defconfig
      Merge tag 'arm-soc/for-6.10/defconfig-arm64' of https://github.com/Broadcom/stblinux into soc/defconfig
      Merge tag 'amlogic-defconfig-for-v6.10' of https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux into soc/defconfig
      Merge tag 'qcom-arm64-defconfig-for-6.10-2' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/defconfig

Bartosz Golaszewski (1):
      arm64: defconfig: build ath12k as a module

Biju Das (2):
      arm64: defconfig: Enable Renesas RZ/G2L display unit DRM driver
      arm64: defconfig: Enable Renesas DA9062 PMIC

Bjorn Andersson (2):
      Merge branch 'arm64-defconfig-for-6.10' onto 'v6.9-rc1'
      arm64: defconfig: Enable sc7280 display and gpu clock controllers

Daniel Danzberger (1):
      arm64: defconfig: enable Airoha platform

Dmitry Baryshkov (2):
      arm64: defconfig: enable REGULATOR_QCOM_USB_VBUS
      arm64: defconfig: select INTERCONNECT_QCOM_SM6115 as built-in

Fabio Estevam (2):
      ARM: imx_v6_v7_defconfig: Select CONFIG_USB_ONBOARD_HUB
      ARM: imx_v6_v7_defconfig: Update ONBOARD_USB_HUB to ONBOAD_USB_DEV

Geert Uytterhoeven (1):
      ARM: shmobile: defconfig: Refresh for v6.9-rc1

Johan Hovold (1):
      arm64: defconfig: enable ext4 security labels

Krzysztof Kozlowski (2):
      arm64: defconfig: enable reset-gpio driver as module
      arm64: defconfig: qcom: enable X1E80100 sound card

Lad Prabhakar (1):
      arm64: defconfig: Enable R9A09G057 SoC

Luca Ceresoli (1):
      arm64: defconfig: enable Rockchip RK3308 internal audio codec driver

Maxime Ripard (1):
      ARM: configs: sunxi: Enable DRM_DW_HDMI

Neil Armstrong (1):
      arm64: defconfig: enable Khadas TS050 panel as module

Ritesh Kumar (1):
      arm64: defconfig: enable Novatek NT36672E DSI Panel driver

Sebastian Reichel (2):
      arm64: defconfig: support Mali CSF-based GPUs
      arm64: defconfig: enable Rockchip Samsung USBDP PHY

Stefan Wahren (1):
      arm64: defconfig: build snd_bcm2835 as module

 arch/arm/configs/imx_v6_v7_defconfig |  1 +
 arch/arm/configs/shmobile_defconfig  |  3 ++-
 arch/arm/configs/sunxi_defconfig     |  1 +
 arch/arm64/configs/defconfig         | 23 +++++++++++++++++++++++
 4 files changed, 27 insertions(+), 1 deletion(-)

