Return-Path: <linux-kernel+bounces-447669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9919F35D8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6CE188256B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12ED14EC62;
	Mon, 16 Dec 2024 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="EJbOwAvx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1YWwjYpi"
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FE97E59A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366091; cv=none; b=SmXUaXs7/0enUaQ5aroU70u3DiLtbUDmT+pJa9S1v6etNtLcaRbEe34h50J2BUfLIjWh+hXk4fmnaWE0c4UBRp/oD74PVDcVTjRbZsbMmcxtdpTmt909vIXGWbLC6jILES9WeC35/5/jLBVeysyiDgVL6F01+qNcBM7VDPLcN3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366091; c=relaxed/simple;
	bh=aKpZp1F8EFqsdg/H5umA1Xxe+u1JhD5KFJkK3nUxm/g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=CJ0KHLTok5D5zAhTjK3I6o+3Ki8dYlk/dX74XZ4rIJsFHBomtwqLlWkfR0S8R/OPRB81Ky9ShZ6seQLwHXZRow5ScUPNOTa/g0o+VfAwrRNB7lM3ea5oGGE+2RdQBSVkHvcS0dHlmOqQyTdV8e8duMyuf3dV7ft/Zaa9RAZQfpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=EJbOwAvx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1YWwjYpi; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2AC7625400E6;
	Mon, 16 Dec 2024 11:21:27 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 16 Dec 2024 11:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1734366087; x=1734452487; bh=mn
	cYdzsRGea1LeZVXIMipQ4Yl5I8AiDuzr1+oaEnslg=; b=EJbOwAvxvnIY7ADPPy
	BEUTLrRE7pytTbTNDCqsgsm2TR909JnmeF9zO+Y0sumydcZhMTt5dEBAujqlCbRT
	cqvyYP/iUxc5jrxBpQQaPvgKh+vr3xFVy1iwpx3+ql22VntrbEr17bIAy9bE/C0k
	ev/58Dkh6WljuNe35j+BDW/bXoKmbzY0AqS/OBfqfeWhx8loqozo/610X+JQHJ4g
	cJMK8pewDIHeCleTul8qOaOy1QsGUk/NBa1i3x1S0RGHWL7DFzeYPDeYrT8AVlbo
	JFqDaxlvHfoG83cxGc2E01FGejUX//N4GtE3gNPIkAUmiQ90g0/NyoKGk+ODUwKq
	f5xQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1734366087; x=1734452487; bh=mncYdzsRGea1LeZVXIMipQ4Yl5I8
	AiDuzr1+oaEnslg=; b=1YWwjYpiwYY0RRaD3fkVCaMmuN59U6+DQqHQwbXAd0SI
	XKHejiIqr4saa9qbkhO6Ugr0An1Pw3zfOX0cR1RFj1CyD524bWIRM3/EfuYLM/Bt
	VUyV6ObL7ny2estNJZBPKqGh04Hcw4Y9V7FVCgcgLk3uwooWMZP1zMePlbmZdIz/
	6XNIFftEsI25r27FiYMauQ1+Dk0ftgROfqwZVsiS6sTbbuP80bw0dUKKL/mvpM4q
	HQUV5TXzkJjOB+hsm9PM44kn8pyHHPv1PIHY/I8hZUJb69m3C8KQrT/f4oDpTEo+
	fU0Iqp5ZoKKGjSwp8mJagYvzfti1NiJEsaOMezhd2g==
X-ME-Sender: <xms:hlNgZyd-ZPoeCZBGRTweh1H_Z-HSy5YyT5s-sK6x5bp-OdTG3u0N4w>
    <xme:hlNgZ8PcCkwaQ5ygTyxEBWuNp3zsi2yD1Y_38lL7ir7zYnaCZhHraZ9XQYC4zhYo_
    e_w4u_uBNf1J80iBDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkufgtgfesthejredtredttdenucfh
    rhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqe
    enucggtffrrghtthgvrhhnpeduleeigeekveeugeettdejtddtleeghefhvdfhueehtefh
    udelffduvdeuleevteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggs
    rdguvgdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epshhuuggvvghprdhhohhllhgrsegrrhhmrdgtohhmpdhrtghpthhtohepthhorhhvrghl
    ughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:hlNgZziJG7jrodz90G2Xdz4Sn7n2Ymdmp-w_AG_VzFnH6lF2K84rig>
    <xmx:hlNgZ_8ohXVT_c89oc8KR3eyfsDwCKLD_wIn3JozK_ZrtcxW-GZL1Q>
    <xmx:hlNgZ-tS39XSlZN6mZnBkfmfm8QCTKx-a6UO13h9cYTNJhvYIO0Lzg>
    <xmx:hlNgZ2EMIHBL9dAXvgzgY6VOxAmVMagXnQBMPRR-9ju0MYG7DgdCgg>
    <xmx:h1NgZyI9f0o8LSy0V1MI8dJ96cfP0R7HejNzNn4w9Ce1UcK8YGLybPbF>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9C4EF2220072; Mon, 16 Dec 2024 11:21:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Dec 2024 17:21:06 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "Sudeep Holla" <sudeep.holla@arm.com>
Message-Id: <cccdf954-3374-414c-81fb-658df16325fc@app.fastmail.com>
Subject: [GIT PULL] soc: fixes for 6.13
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.13

for you to fetch changes up to f578281000c50cae991c40e1f68b2fc0b1b9e60e:

  Merge tag 'ffa-fix-6.13' of https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/fixes (2024-12-13 14:26:32 +0100)

----------------------------------------------------------------
soc: fixes for 6.13

There are three small fixes for the soc tree:

 - A devicetee fix for the Arm Juno reference machine, so allow more
   interesting PCI configurations

 - A build fix for SCMI firmware on the NXP i.MX platform

 - A fix for a race condition in Arm FF-A firmware

----------------------------------------------------------------
Aneesh Kumar K.V (Arm) (1):
      arm64: dts: fvp: Update PCIe bus-range property

Arnd Bergmann (4):
      firmware: arm_scmi: Fix i.MX build dependency
      Merge tag 'juno-fix-6.13' of https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/fixes
      Merge tag 'scmi-fix-6.13' of https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/fixes
      Merge tag 'ffa-fix-6.13' of https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/fixes

Levi Yun (1):
      firmware: arm_ffa: Fix the race around setting ffa_dev->properties

 arch/arm64/boot/dts/arm/fvp-base-revc.dts     |  2 +-
 drivers/firmware/arm_ffa/bus.c                | 15 +++++++++++----
 drivers/firmware/arm_ffa/driver.c             |  7 +------
 drivers/firmware/arm_scmi/vendors/imx/Kconfig |  1 +
 drivers/firmware/imx/Kconfig                  |  1 -
 include/linux/arm_ffa.h                       | 13 ++++++++-----
 sound/soc/fsl/Kconfig                         |  2 +-
 7 files changed, 23 insertions(+), 18 deletions(-)

