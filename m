Return-Path: <linux-kernel+bounces-194533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ED08D3DB4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 19:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2491C21E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B4B184118;
	Wed, 29 May 2024 17:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="OL3VWOxY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j7c0q17r"
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9D91A0B1D;
	Wed, 29 May 2024 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004945; cv=none; b=mKYNzTpaF+3ihtQ7wGFOCrfpsG8kelNAqwYj9LVk3nv6gNmMc3bxelYC/4OtzAnOjHJwB6jWjHi9tWY4lOzvvut2vuq0gW9+D0lis2l5HjFTJjQ+yFo9dwcCAfBfmzU6Xf8WwSauWt+oETGfeXk9Zpuk3Xem74XcbNBvSkHs2l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004945; c=relaxed/simple;
	bh=UyvASCKPhoRBnZoC2uhslJpc1RGyYwlGtJ4JMey614U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rH6XPjW4Dbn2jlxvDg+4q5SlHX89FdTpBJSDhX1KMlv/qxHQG+P5zEL6nOoH/mHr09vbm4+rDxj6nfu4/SGixPdsggiHfrYZogMZ/NDDauCllZW3C9/tXLQPXVgmMObl/M797YIzswSzST70Lu6ne6IDm4HQ9p7GQBGWVjkLapM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=OL3VWOxY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j7c0q17r; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4C4D718000B1;
	Wed, 29 May 2024 13:49:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 29 May 2024 13:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1717004940; x=
	1717091340; bh=PXl9fO+mKVd+QaDNKbGTKkIfq05G+W/dSXotzP2lPfY=; b=O
	L3VWOxY/tNvc/jxoJc+Eof0QI5dIYCCfVruLAJ7aglsJgSA9gQgJLYiQNrB4n82r
	n6w3Btmj9xnDpdJbO8q9YxolS2Z/u75+BLMT0z96B/9dNuG72/y4ZQ8Df2nlIzT+
	zQ9jwo+ZrIyDQiEzo/Twx8zPns1NVkv5F7X9NZTfFTk4t1zwoCgYblrws2rn2eqh
	Ub6onGcV/lHHriRBvQ383cxgukauoT4rZHdh96yZGkBIknGG52c6Y7cY+XdZZyYd
	v+i2oTZoHg18L+Pr2LTpWjy5fVgXVidEJDLeKKjD+aCtZI3aco1k+HFGiQQRuJvP
	XWAh2QGC9gP/w00JAtxtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717004940; x=
	1717091340; bh=PXl9fO+mKVd+QaDNKbGTKkIfq05G+W/dSXotzP2lPfY=; b=j
	7c0q17rRXosah0p0Qm4qSGNJkBCma/iEZUo1KR5lEiq2W1kQPfs1XGDybQk9LveE
	a74cUq48oxONPDrVoe72wOjcfmvvljEazbCcQWN+NYyK6UfOkUCQKG2FtYam73g+
	2XR9j4WQ8mye2fNM+Et/w2Xef0oLnzRsDErXZecCQNLhMZDoG6TAtLL3balmljMy
	AnlWWCVmjknuqM3MuQ3RD8H8RjnjsJPzItiCwGCY8HzES9FtBEdAgXx0d7PwYxne
	G58IhDuxhEkJt1moSlVHKP5WKSjcIzva1pDU3DA49GR5022f+LqJFkmJZX/VfRUn
	dtQNFPXCqHhfWv6wvsOkg==
X-ME-Sender: <xms:jGpXZt681K3jA1JfKCUggiQiBtb5w0XkPYp0vgnNeBUU3lGPIDMP1Q>
    <xme:jGpXZq764Q0qJfJOPMOXT3R4oTp2U-QRi0VClxj3w3GhREcnc-RCFvkTMEMMjRXbs
    Xf2O1Aujj9LYcsxPwQ>
X-ME-Received: <xmr:jGpXZkdoOOStblSH8QpwIOJzFOjkvCZ8A0MOTBWBcp24vw1wSLLfL9mT47zATg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogetfedtuddqtdduucdludehmdenucfjughrpefhvfevufffkffojghfggfgsedtkeer
    tdertddtnecuhfhrohhmpefnhihnughonhcuufgrnhgthhgvuceolhhsrghntghhvgeslh
    ihnhguvghnohdrtggrqeenucggtffrrghtthgvrhhnpeelhfeiffektdeludfgtefggeef
    hefhtefhhfffueevhfdtkedvieekheeljeeiteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehlshgrnhgthhgvsehlhihnuggvnhhordgtrg
X-ME-Proxy: <xmx:jGpXZmKcC9K9NZjc2jfl2m9Oyf4l2mvDXCOYHG2VAXSpxerCxom-nQ>
    <xmx:jGpXZhJmDUAIhTIpqc1PYjv7lrLrGb5axr1F30ZT8H1dnV4NBMTFLg>
    <xmx:jGpXZvw954RFQifEp12AOKaugOTcFgGPRmLpPF6HA2SBHb5qKCIZCQ>
    <xmx:jGpXZtJdE3edliIh6UYfNeSSLyCvFsbsagjM31_ybT57iOm7l1yHQQ>
    <xmx:jGpXZuekFF76iV5O79Gcy-8bldsCIaMBxbsY3J-SXAKRAc3hNhZx3Jig>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 13:48:59 -0400 (EDT)
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
	Vegard Nossum <vegard.nossum@oracle.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	AceLan Kao <acelan.kao@canonical.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: [PATCH v8 0/3] platform/x86: dell: Implement platform_profile
Date: Wed, 29 May 2024 11:47:43 -0600
Message-ID: <20240529174843.13226-1-lsanche@lyndeno.ca>
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

v8:
 - Rebase all patches against master
 - dell-pc.c:
   - Separate <> and "" includes
	 - Align thermal_mode_bits with tabs
	 - Flatten nested ifs
	 - Directly return dell_send_request
	 - Correct some grammar
v7:
 - Move platform_profile into new dell-pc module
 - Add myself as maintainer of dell-pc
 - Move smbios call and fill functions to dell-smbios-base
 - Check for classes above 30 and return as not supported
 - Rename dell_laptop_check_supported_cmds to
	 dell_smbios_class_is_supported
 - Check for ENXIO and treat as no thermal modes supported
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
 - Propagate ENOMEM error

Lyndon Sanche (3):
  platform/x86: dell-smbios: Add helper for checking supported class
  platform/x86: dell-smbios: Move request functions for reuse
  platform/x86: dell-pc: Implement platform_profile

 MAINTAINERS                                  |   6 +
 drivers/platform/x86/dell/Kconfig            |  13 +
 drivers/platform/x86/dell/Makefile           |   1 +
 drivers/platform/x86/dell/dell-laptop.c      |  23 --
 drivers/platform/x86/dell/dell-pc.c          | 307 +++++++++++++++++++
 drivers/platform/x86/dell/dell-smbios-base.c |  35 +++
 drivers/platform/x86/dell/dell-smbios.h      |   7 +
 7 files changed, 369 insertions(+), 23 deletions(-)
 create mode 100644 drivers/platform/x86/dell/dell-pc.c

-- 
2.42.0


