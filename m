Return-Path: <linux-kernel+bounces-577502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8880A71DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BDD16A32D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302CB24C08B;
	Wed, 26 Mar 2025 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bgGVhIOz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="niJnq7D8"
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97D123E34C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743012207; cv=none; b=Eh38HCkD9OBI+zfskp69zSAwthp/rQMaPU3/SwMAlaNyoNPZEuBA+NGfojtiR2ApNUxox3pnDVR6+AJuTbV/QlozWLeFxUE/gBmVoK1wOq9c/xM1zWrV4ESDcO9jXVNTPRjO6M8jtQlqCzQy+dkTvz7+D6I1ieE4DfKPt0b9XQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743012207; c=relaxed/simple;
	bh=KFyZFtTF4jn7dIOntz+PcMunAELQMRJzre/VOrBdAQI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rQAsYWAdxJicjvrnVj9XFjKRkebm36VJKZjbTkUadsL3uZ/lMj7pl/98ICbwk/wRXXLHxVKc1MtdEiaWDZ3bXCpAqhgTMGuGSgZeRXK9/PPXIqt+W3McWQNhsAlaKGu35ccxSgk8HHfAht529BxAR/Gahk2NjRE/+/8MFKBxYyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bgGVhIOz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=niJnq7D8; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id B14861382D80;
	Wed, 26 Mar 2025 14:03:24 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Wed, 26 Mar 2025 14:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1743012204;
	 x=1743098604; bh=Ro9pG6MxHWJ6pF1usoSl7AujA1zvGiTsvD3tU9PibDk=; b=
	bgGVhIOzaMfFPiNcjVyfWRnM43aG5aJ3PhVwoU86KHmStlOHn3+4gDnMKSjdhH6c
	GHSX0UljJ3ai+LgezjbAttC8Uoq1IwPJsAwvzwJxBgLvKwzDzyEEWYX2MVhOPO6h
	c3UqAeVMVcN7B9ez5uW1fn1RtWHnIF3CBxVHevdNWknCZ1GNvIR7wCdDpaakdMH3
	qNpbOXguhKWTzVe6sqbr/6II5q8mhFC97SgaQ+1RK1YGsRhpM1ypCGn5uARX6yGl
	kxthEgiG7judCVbE3AntWSDole/pTMog+x9ykprSCtgIONwP91sM+dWSsxUhhH+t
	i190QqUcrCcWvNa3AcQwhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743012204; x=
	1743098604; bh=Ro9pG6MxHWJ6pF1usoSl7AujA1zvGiTsvD3tU9PibDk=; b=n
	iJnq7D8DF1wlEoqPbwIrp/yjQVkrIrU4K2/HCRlN374quh+D8+HR7nmApmsVsMxc
	dKdCGATpUE0cJuaSy1RTwB9B1GKf43ZzYW1t4mqU0UegmTS7VYezOtabgBtg5bdx
	Zk0j+hMK5Wo2OTeThcvsaPkW5Gwze6O+kjUFYTWsZ0imqM3C1xhgi8NeFHRNf+Av
	uqvzrhnDHU6YowrzcK1+lJfGhrOOqfZgELcshZ5d7yxabkm/Cr6olUoE7pFRbsmP
	2GSzUCpWukJYJFHDjtoJfd8mOY8Bc2RbQhhWSeHor1DS3IfRf2HjgF3snStQ/xoj
	1Reuew3tnqNLL3uPLCOBw==
X-ME-Sender: <xms:bEHkZ4XAaDh02NIDqOfGXYNh1Y8zEINcCm4Ms1oBQqlIy5M4kda_DA>
    <xme:bEHkZ8mSIzpI5aobS-FVP02fh23xPAeqV7BeGxf6opCSeAvwQkxyCrp3vb7k62t64
    Ajj4Tvm_RFg3gEsRA0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeivddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepkedvuefhiedtueeijeevtdeiieejfeelveff
    feelkeeiteejffdvkefgteeuhffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggvpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrh
    gruggvrggurdhorhhgpdhrtghpthhtohepshhotgeslhhishhtshdrlhhinhhugidruggv
    vhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:bEHkZ8Ztsk1MleNodVQoXi9UOqm-3zVxwrcnqZ-vl-KMBUeY_bbnqA>
    <xmx:bEHkZ3UNBI-ofvtxov-fuFl4xxpXtyHumEh2l2u4iqY2ybohdg0wAA>
    <xmx:bEHkZymd8KKeHzBwhj1w3vz6sLDXRQYE3iez2Nvf4fYC56Q8sLOaPQ>
    <xmx:bEHkZ8dcWH4hmjziICmWSlNeo4WeYMzms1etC6KfO1tc0EkDM8hJ_Q>
    <xmx:bEHkZ0j0bhLUkHkCGiSQfPxvfqPWajQ5xfMFmU4av2QjCNisPKuYJnld>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 644B12220072; Wed, 26 Mar 2025 14:03:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T2e1b8447a49b63d2
Date: Wed, 26 Mar 2025 19:03:04 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 soc@lists.linux.dev
Message-Id: <9a65c188-56a7-4e0a-ad3f-350d67d854b9@app.fastmail.com>
In-Reply-To: <1ef00af5-0196-46c4-95f3-7c6b90f3e293@app.fastmail.com>
References: <1ef00af5-0196-46c4-95f3-7c6b90f3e293@app.fastmail.com>
Subject: [GIT PULL 3/4] soc: defconfig updates for 6.15
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 0ad2507d5d93f39619fc42372c347d6006b64=
319:

  Linux 6.14-rc3 (2025-02-16 14:02:44 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
efconfig-6.15

for you to fetch changes up to 8ce2a15b1e6464a8681fb2f787602fc78f8e2f39:

  arm: defconfig: drop RT_GROUP_SCHED=3Dy from bcm2835/tegra/omap2plus (=
2025-03-21 13:27:08 +0100)

----------------------------------------------------------------
soc: defconfig updates for 6.15

A small set of updates for the arm64 defconfig to enable more
drivers, plus a bit for housekeeping on some of the arm32
defconfigs on particular SoC families.

----------------------------------------------------------------
Arnd Bergmann (4):
      Merge tag 'renesas-arm-defconfig-for-v6.15-tag1' of https://git.ke=
rnel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/defconfig
      Merge tag 'v6.15-rockchip-defconfig64-1' of https://git.kernel.org=
/pub/scm/linux/kernel/git/mmind/linux-rockchip into soc/defconfig
      Merge tag 'ti-k3-config-for-v6.15' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/ti/linux into soc/defconfig
      Merge tag 'qcom-arm64-defconfig-for-6.15' of https://git.kernel.or=
g/pub/scm/linux/kernel/git/qcom/linux into soc/defconfig

Ayush Singh (1):
      arm64: defconfig: Enable gb_beagleplay

Bjorn Andersson (1):
      arm64: defconfig: Enable USB retimer and redriver

Celeste Liu (1):
      arm: defconfig: drop RT_GROUP_SCHED=3Dy from bcm2835/tegra/omap2pl=
us

Devi Priya (1):
      arm64: defconfig: Build NSS Clock Controller driver for IPQ9574

Dmitry Baryshkov (2):
      arm64: defconfig: Enable Qualcomm QCM2290 GPU clock controller
      arm64: defconfig: enable DRM_DISPLAY_CONNECTOR as a module

Neil Armstrong (1):
      arm64: defconfig: enable Qualcomm IRIS & VIDEOCC_8550 as module

Niklas S=C3=B6derlund (1):
      ARM: shmobile: defconfig: Supplement DTB with ATAG information

Ravi Gunasekaran (1):
      arm64: defconfig: Enable HSR protocol driver

Santhosh Kumar K (1):
      arm64: defconfig: Enable SPI NAND flashes

Sebastian Reichel (1):
      arm64: defconfig: Enable Synopsys HDMI receiver

Shawn Lin (1):
      arm64: defconfig: Enable Rockchip UFS host driver

 arch/arm/configs/bcm2835_defconfig   |  1 -
 arch/arm/configs/omap2plus_defconfig |  1 -
 arch/arm/configs/shmobile_defconfig  |  1 +
 arch/arm/configs/tegra_defconfig     |  1 -
 arch/arm64/configs/defconfig         | 16 ++++++++++++++++
 5 files changed, 17 insertions(+), 3 deletions(-)

