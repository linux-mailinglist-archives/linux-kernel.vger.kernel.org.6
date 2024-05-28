Return-Path: <linux-kernel+bounces-191610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CA18D116F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 03:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6216B2114C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 01:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CB6946F;
	Tue, 28 May 2024 01:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="KMCwpYPK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DBYu6q8S"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7A32907;
	Tue, 28 May 2024 01:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716860198; cv=none; b=GYaqzuBmyzXiTeoY7dGveCjVyI82+Hw9exojy0Fwg0CQr4x9NIRshNdzhhlzPvKHL7waSk9kT5xNVuJkF+hFqEPIWU6+UfiMv0chHBUpdVL1futoT+41Srv/yxvKp3GV9BtxvS96vZ1OqBbEnQNQbk2KOCE2w9aFBDnlLwW4CoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716860198; c=relaxed/simple;
	bh=prI9lKmxW1c+u+ZG4KNb5zcRk2wqgpYTWmwJk77js1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OIx63uWJsW3kvj//1UgjslhW1JdCiaB3+dvPutu4PGlRwTlS3i9nXXiwU0Xy4D7jnt00W9cUUU7SX/IbExW7WXjnVzbNYNXG6DX6PXUnrabkwS4munTLDCg/YlVRpw5hRVSe70A1H/n2GIO3Yy8fvLgTDY5G07S1j1B8GoJmqNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=KMCwpYPK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DBYu6q8S; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id C8E70138013F;
	Mon, 27 May 2024 21:36:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 27 May 2024 21:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1716860195; x=1716946595; bh=jmIL5KKIKWqEFoPAOUm/b
	kcZ2E8tX7cZYVkE26Q5IA8=; b=KMCwpYPKyuWYAOOYJwC0+IWuoEiZ+plIbTVme
	232MhWitFqYYzF+LlMS/E9ckkcVJjuDi9u8qhSZ/41JTcO38KJMB56abbhevUyTF
	O+kc/BTN3ivI2/Ko6YfSmmVV6q6kdCbrk7XvKkHBYVOqM2Mu573QbUmyxDKEPDCE
	1PdgQnYJP1oXBa+0L62uG5Iq7iiChdY8aw4bT53mpBjfDCmN8CvKhLariw1fyQDN
	juJKQrBkaV4Nt5DinKm26YsA92Kj7JIjqS6K0DDdPn5K4UxyjmUzgu6vlqOVvED/
	UoC0s/dSoRI5UW9SmNORl5NdjKzvVJ9RIL7dQRxDGgbAQfvcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716860195; x=1716946595; bh=jmIL5KKIKWqEFoPAOUm/bkcZ2E8t
	X7cZYVkE26Q5IA8=; b=DBYu6q8Skwb9WfCNwVzwMKGN7xIH3XL5fVnOFviprcwQ
	O4XbxszCV1P2nV6fGwrHe8erIS1v84WiAGC8BxkxsuJPNmlpx6ms22D6HxeayyXT
	D2gTB74wDsGKS4BsOCI88MXpG9VFAgHslPu09C/s/eByJ5HWev6auCvgc1hPTgjf
	2UquORVjLU2ybTcRql71pvfhKDaLZPb1BlDDYqkACR1n5l5PPGeYg7guYfB/x7oC
	iu6Bf3XTMDhfIUHRNlGzjn2D5b+ldWmgzOf3Cg+4usE32PLyEWn2gpX8JW1Wct7+
	DXBq7sGuZp9VYIBNIoxL+19PvI3AagqdEhEcplCrmQ==
X-ME-Sender: <xms:IzVVZsSBji3StZF4r7vZps6Aa8C2oeHks4eah-G_XpTlFYz7rummsw>
    <xme:IzVVZpx06U7rufmfhRCegUEhGI5znsTyDbQBE5jvPOpsYWpoXGntgZf_UoQ_JDYVU
    QXbSBMcuAKvetA8R8A>
X-ME-Received: <xmr:IzVVZp0mWxcBBkyIt_emIXGX3qpKLMTlAfeZfXthWc1CUlPAUZ7rnj6ki-Hc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:IzVVZgDrH9ou4pufU6QRMqnOXC04myl52mYAXT-UQfoPbH6mm0UHDg>
    <xmx:IzVVZljT_GypSlWH-XcuA-6JklsSrhIb02opCU92oGnwmZcp_Uzdmw>
    <xmx:IzVVZsqojTO3YahQTzp20v7HEwSaDVotuzgyhYR474GM1OdR7b-lCg>
    <xmx:IzVVZojry3Frp8_xHUG37DDc56Af2lQ1MlQc-iQPzdUR0yZjBaOuWw>
    <xmx:IzVVZjZsoxAuEINJueh3QnALApNUvA2Wrj6DwzXh3szApOA1EyaJcGrY>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 21:36:32 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: ilpo.jarvinen@linux.intel.com,
	corentin.chary@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 0/9] platform-x86-asus-wmi: multiple fixes, improvements, features
Date: Tue, 28 May 2024 13:36:17 +1200
Message-ID: <20240528013626.14066-1-luke@ljones.dev>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a series of patches containing either fixes, improvements, or new features.

Most of it is vary straightforward and I'd hope quick and easy to review.
However patch 0003 does a fair bit of work in reducing a series of common
patterns down to a few macros and a more generic store function. This ends
up unifying a lot of things to and making the end result much cleaner to read
plus add future features of the same pattern.

I am unsure if I've got the macros correct. Everything compiles, all is tested
and working correctly - but maybe I could use some guidance on formatting and
style there? Should they be in a header?

The debug statement patch was invaluable for debugging some issues on another
users machine. I will likely add some more debug in future.

The platform_profile issue.. It seems there is a race bewteen asus-wmi and an
AMD driver to register the platform_profile on boot on some laptops. The
asus-wmi driver can live without platform_profile quite fine as the feature
is really just a wrapper around throttle_thermal_policy. But it does raise
the question of "what's going on here?".

Many thanks,
Luke.

Luke D. Jones (9):
  platform/x86: asus-wmi: add debug print in more key places
  platform/x86: asus-wmi: don't fail if platform_profile already
    registered
  platform/x86: asus-wmi: add macros and expose min/max sysfs for ppt
    tunables
  platform/x86: asus-wmi: reduce code duplication with macros
  platform/x86: asus-wmi: use WMI_SIMPLE_SHOW in more places
  platform/x86: asus-wmi: add panel-fhd functionality
  platform/x86: asus-wmi: add enable/disable CPU cores
  platform/x86: asus-wmi: add apu_mem setting
  platform/x86: asus-wmi: add setting dGPU TGP

 .../ABI/testing/sysfs-platform-asus-wmi       |   78 +-
 drivers/platform/x86/asus-wmi.c               | 1248 ++++++++---------
 include/linux/platform_data/x86/asus-wmi.h    |   12 +
 3 files changed, 688 insertions(+), 650 deletions(-)

-- 
2.45.1


