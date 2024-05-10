Return-Path: <linux-kernel+bounces-176199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83878C2B90
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D523E1C20BD5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC8613B592;
	Fri, 10 May 2024 21:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="i3udHqOD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ATiCSB+w"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE3A10965
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 21:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715375579; cv=none; b=tyuu7zhJ0K/VsIySFy+UtyJr/iD39BtfH18C3Fgufdw791de8SqExlzYo0kgjuTBz67tTN7V72gUkmz1WXH7thNDA8W5o/EKvL/6dP74JsppS5gJPR3pUlla7z+0hT//ggPi96oP0NnpPfv+pNoYuYs37LuP+uqvP7cyKWrivhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715375579; c=relaxed/simple;
	bh=lv0fRbNf5vALFTpjW9XOcTk13frFXgHh6micYP5akM8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=YLCEa09dPhTon6zx47EnQ26G9CO9dvuyXdmlLFaqm4uGiheomMmxmRaq84NWCqQXctmGr+09ACpRZooKNY2ZCn6dXreWamYd99rt0i9pvSxOOf30RJIVPFpfkjMJ/E4p015c9LQmm+kCRCjJ2o0Ut5o96LMngHK9O6JmbkSe4DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=i3udHqOD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ATiCSB+w; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B6B9611400D1;
	Fri, 10 May 2024 17:12:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 10 May 2024 17:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715375576; x=1715461976; bh=+A04hSqDZA
	fectEaYhevQbQt0vFNJTAi4AGu5xEjLfA=; b=i3udHqODbkODbXptIFeddoxgHF
	tFGEh/0FArlo2trZdU5uqsfAuZl+BHQdTTRoHYNgdfKScnrRqYoglQmAEorZqSUf
	SrVz4RR6wzsQ8wW58KBgrBnR/smNoAYyvCnX09UclSes2pN+Zw4J/wid05cjduCG
	f/matfYQTt913t+ehYTTd7ACUG0/5csSPlWpWB8lV5YW7u8lea8l9G1ebh60pgVC
	jz9pdgegVJiNyE9vOg1Q6tPjLVpaVgbea/dmBPvTH6iFo6kCSNutXcqYYOVRBSDj
	aSqCG9Y99KadtEa3hrvAffB4egqbPjaOh2xYrHUNeGVrcMyjDEwzz5TMjKgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715375576; x=1715461976; bh=+A04hSqDZAfectEaYhevQbQt0vFN
	JTAi4AGu5xEjLfA=; b=ATiCSB+wTsfOUI0nkbRZTn/iCLWw+g0vKfVAI68h2PUp
	v49GQtMAA6fF4j/273y5jcTraO3xBfaq+0bMKk5T6h8xYf65dbS8FViUKZA9q77y
	yk0NSFZtMjEaxIamHI6JuAGIvVxrkikYv2Dwt4+h1ELfhARaQ0dVqkBQ+E9QFUXY
	fmR+mwUF+4SFbqRoLER/vqM5VCdPqryuNHjYQGCdhxqLpCCeeK7wTtVJktpsaHhu
	lmHsVDlrPqeOsadjsmx3eEsr9HiZqv5wVzJOOwe2JlYNDR5P0MK33/t0O7WcFLN6
	ec2SuW/gf6Di08mhu0u1k8soPyLan+IhGJpIwwFREQ==
X-ME-Sender: <xms:2I0-Zs3XPeZpCNrbvAWoDRlTUpPfwSz4jSvBH23MZEIjASi6MXp3Zg>
    <xme:2I0-ZnEsKZe3voudtPN7rbjpUJwEqru8kAGPwZHaiNC2kJLV9fwl36zVd7BbZUKb_
    asBD4Dd3Z1BR_hsYvo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:2I0-Zk7KAUjSqsYxkkysamZNh7aIoKOTC_Sa7AC2KNwa8E9Ho6mtFA>
    <xmx:2I0-Zl2jUK35iJcfFmTCNX793ULkNDiXeg1vRLkftx-sAylE6rSNAQ>
    <xmx:2I0-ZvHgGro0z1qbAz78L_szkgBDwGMs6_qbrEozj4hmbEL8cDvrbw>
    <xmx:2I0-Zu_onECDtITEoO5TFZxIXfDWx-mBhn8XYmlyAB-FY0eFOkQoLA>
    <xmx:2I0-ZnDdGcq8nhxotnDycL4AAQx49G7_uiliRC1DUYMyUbMfV4JGcy-o>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7105EB6008D; Fri, 10 May 2024 17:12:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0d70e9ef-5291-4134-b41f-183b1233b39b@app.fastmail.com>
In-Reply-To: <fa20b5a4-a131-49b4-9597-15886435a288@app.fastmail.com>
References: <fa20b5a4-a131-49b4-9597-15886435a288@app.fastmail.com>
Date: Fri, 10 May 2024 23:12:36 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 3/4] soc: arm code changes for 6.10
Content-Type: text/plain

The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-arm-6.10

for you to fetch changes up to 428ae88ef519f2009fac37563de76ffa6f93046f:

  arm64: add Airoha EN7581 platform (2024-05-10 15:56:20 +0200)

----------------------------------------------------------------
soc: arm code changes for 6.10

The code changes are fairly minimal, there is a bit of conversion of
the old orion5x platform to modern gpio descriptors, the Kconfig entry
for the added EN7581 platform and a sysfs change for the i.MX PMU
device.

----------------------------------------------------------------
Arnd Bergmann (2):
      Merge tag 'imx-soc-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into soc/arm
      Merge tag 'mvebu-arm-6.10-1' of git://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu into soc/arm

Daniel Danzberger (1):
      arm64: add Airoha EN7581 platform

Jonathan Cameron (1):
      ARM: imx: Assign parents for mmdc event_source devices

Linus Walleij (5):
      ARM: orion5x: Convert D2Net board to GPIO descriptors for LEDs
      ARM: orion5x: Convert DNS323 board to GPIO descriptors for LEDs
      ARM: orion5x: Convert MV2120 board to GPIO descriptors for LEDs
      ARM: orion5x: Convert Net2big board to GPIO descriptors for LEDs
      ARM: orion5x: Convert TS409 board to GPIO descriptors for LEDs

 arch/arm/mach-imx/mmdc.c              |  1 +
 arch/arm/mach-orion5x/board-d2net.c   | 16 +++++++--
 arch/arm/mach-orion5x/dns323-setup.c  | 63 ++++++++++++++++++++++++++---------
 arch/arm/mach-orion5x/mv2120-setup.c  | 29 +++++++++++-----
 arch/arm/mach-orion5x/net2big-setup.c | 21 +++++++++---
 arch/arm/mach-orion5x/ts409-setup.c   | 25 +++++++++-----
 arch/arm64/Kconfig.platforms          |  7 ++++
 7 files changed, 124 insertions(+), 38 deletions(-)

