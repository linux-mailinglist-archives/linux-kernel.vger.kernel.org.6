Return-Path: <linux-kernel+bounces-176392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 532138C2F15
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 04:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABD39B21D89
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4C421345;
	Sat, 11 May 2024 02:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="B6o8E9vm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VWENNb7y"
Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9424E125C0;
	Sat, 11 May 2024 02:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715395121; cv=none; b=s2SsPQaXz/g0PIB9Ij89MUPhKcIjB7LcL7U6dISwp5S6N81H7UjgIVYIJ4Qd7j5jyOMd2R+seLnTygW2atc1cg1Ep+xboEXfeb5pg4jH0W86ezKPgBCOLDZm7HNpu/yY/gfpq3znKL1us6fBI9BFWRsVgotW+eF5QHEkhszFkZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715395121; c=relaxed/simple;
	bh=vt+CBkRTpChhguZmAsmOJ+xaJIA+507ew6mlrucxVGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmJmQLfZXmyjTK0S3YFCLuvdrpYYdj6M8zKXDzfTgIRlVWujX4XlVr1/XErODvPtTmpFEEcUkUBx6KaKmWvrwAm5UB/8NPk4nHyv9igZ5em9A+aDwNTkDl1llegGGmPjSkP86oombwQfsFRjVDQPaiXsOjSmlosL32LLhsRchu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=B6o8E9vm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VWENNb7y; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 9D91B18000A9;
	Fri, 10 May 2024 22:38:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 10 May 2024 22:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1715395117; x=
	1715481517; bh=vz1erGw23082AM7aJVdhF7aJINrmP0eysxVIQ7I0X9A=; b=B
	6o8E9vmIAyNPlW3Z+rN9kh7BiDzQ22V6Ovz4y7snrC2fQr//DcVPp/5SOdQIKkwc
	S0Oc1W2+bVka9XphF1XSY3VEfZU6S/8kEA7zmLBXsSxd7Tot4fsNCGidT3Hr7pXQ
	ifP6USv3rRb2rHze7LYCJMvHkRR2RK9ZbOlxOELHDRODHlq3tYlyMD0ulaMWfWhu
	hkMUT4AKxcdAGBpISNrYS3UQfQHgsAm64qdhL8Rf+1ZRMAcOjAWUHrWWFnZyl2zl
	Vxtr2gDTbpFTajQld/+f9w+/Xit8VUkTobexRHTqqF/dzkkUSv31fhcKYaPYvXQG
	W5GWtNTDemBpETh2coR1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715395117; x=
	1715481517; bh=vz1erGw23082AM7aJVdhF7aJINrmP0eysxVIQ7I0X9A=; b=V
	WENNb7y70GmG+tSlbe9ZAI4JZfw8015djn23giIqTN/q9CNdug9A6oJMl6X2HnkC
	Zc1qkzxNr6dEeRBTTIt5iQIHKXWfdhuQWHBIvlwrTUS8E+LWBQWGtfO/2UQmTXh1
	I8+UisqAWJGsw+eRi5kILKGavmx8Nff6jd1mzzgMuK+2z33jkUUKX8VP0vT30sLD
	Yt6f5cAdfzURxRZs8Yx7lDausRKasY1GpC5/N1UCWya2thLdvLKgeewT3Ws96ggq
	F7447iAJR6Dy3ZBX7fVNBWOn3TmC5wzbvFj8A7yyLPP2iZFIMxDm1ldBUKCjkiUE
	WYYvq6Y3ZxLcdrMGDO4iQ==
X-ME-Sender: <xms:LNo-ZoJ0z89qW08_q2d7jqn2Zb0CpslGWKGfB5Pz3_SU-d4yjOLKUg>
    <xme:LNo-ZoKDz0lOs3jNNISmr3ePxjSPF5muGRopc86SbClGGYCZFEe3QHT2qi9PbY52Q
    K6MVHyRFeGEMl-18c0>
X-ME-Received: <xmr:LNo-Zosiusyfo6JldwdJz-rGVpBV4_6HMFERkath8wBZSrDc0zS0hieCg_0W89v7s6Q9pnPLTtb5_AprtQXIY_z4OAPTmjf->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefledgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goteeftdduqddtudculdduhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredt
    redttdenucfhrhhomhepnfihnhguohhnucfurghntghhvgcuoehlshgrnhgthhgvsehlhi
    hnuggvnhhordgtrgeqnecuggftrfgrthhtvghrnheplefhieffkedtledugfetgfegfeeh
    hfethffhffeuvefhtdekvdeikeehleejieetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheplhhsrghntghhvgeslhihnhguvghnohdrtggr
X-ME-Proxy: <xmx:LNo-ZlYDUQ32vD1DJ2AgR5nGcf79cZ-7ISiEB5mWzASHVJjkDp9now>
    <xmx:LNo-ZvZzCVjJm2r-WNxCd0stuOE_tVvwMroxjRR4-TaF8JWbjXDsGg>
    <xmx:LNo-ZhAA5LXW5y-fJk4rz-PxkTtsjU0uiKQiBhlpX4s9WQvJnCL0sQ>
    <xmx:LNo-Zlb4f6uGA3qrFsAd2-XxlCLRKUxQpEWs6f2wPfeRbyB_L1rKlQ>
    <xmx:Ldo-ZnK1UHjvsAkBzLjJ754zhNi_rYMSUjhkiYJllZqlTJFpxq8AUTxB>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 22:38:36 -0400 (EDT)
From: Lyndon Sanche <lsanche@lyndeno.ca>
To: lsanche@lyndeno.ca
Cc: mario.limonciello@amd.com,
	pali@kernel.org,
	W_Armin@gmx.de,
	srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	lkp@intel.com,
	hdegoede@redhat.com,
	Yijun.Shen@dell.com,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Jonathan Corbet <corbet@lwn.net>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: [PATCH v6 0/2] platform/x86: dell-laptop: Implement platform_profile
Date: Fri, 10 May 2024 20:36:50 -0600
Message-ID: <20240511023726.7408-2-lsanche@lyndeno.ca>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240425172758.67831-1-lsanche@lyndeno.ca>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Dell laptops support configuration of preset fan modes through
smbios tables.

If the platform supports these fan modes, set up platform_profile to
change these modes. If not supported, skip enabling platform_profile.

v6:
 - Add ACPI dependency for dell-laptop
 - Add and use helper symbol for checking supported commands
v5:
 - Fix indent in smbios-thermal-ctl comment
 - Remove linux/wmi.h include
 - Add 'select ACPI_PLATFORM_PROFILE' to Dell KConfig
v4:
 - Make thermal_init and thermal_cleanup static
 - Rearrange order of added includes, did not edit current includes
 - Include bits.h
 - Switch comment style
 - Return error if platform_profile registering failed
 - Add thermal calls to call_blacklist
 - Align defines with tabs
 - Correct separation of function and error handling
 - Propagate error codes up
v3:
 - Convert smbios-thermal-ctl docs to multiline comment and wrap
 - Change thermal_mode_bits enum to directly be BIT() values
	- Convert related code to use this
 - Use FIELD_GET/PREP and GENNMASK for getting/setting thermal modes
	- Correct offset for getting current ACC mode, setting offset
		unchanged
 - Check if thermal_handler is allocated before freeing and
	 unregistering platform_profile
v2:
 - Wrap smbios-thermal-ctl comment
 - Return proper error code when invalid state returned
 - Simplify platform_profile_get returns
 - Propogate ENOMEM error

Lyndon Sanche (2):
  platform/x86: dell-smbios: Add helper for checking supported commands
  platform/x86: dell-laptop: Implement platform_profile

 drivers/platform/x86/dell/Kconfig            |   2 +
 drivers/platform/x86/dell/dell-laptop.c      | 242 +++++++++++++++++++
 drivers/platform/x86/dell/dell-smbios-base.c |   7 +
 drivers/platform/x86/dell/dell-smbios.h      |   2 +
 4 files changed, 253 insertions(+)

-- 
2.42.0


