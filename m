Return-Path: <linux-kernel+bounces-567386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B189DA68557
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25DE018876B9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C9D24EF72;
	Wed, 19 Mar 2025 06:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="lZuejENv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d0d6/f1o"
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39FD212B18;
	Wed, 19 Mar 2025 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742367523; cv=none; b=TM3stYNywqyoZLzVflNopYupVnXJV6OIWgIMkAbkl2adz7vJA+OBLdx7Op1BXGXE4VtWqeq1zj77D7SQsg1Zncq6JokgFLvGZqWMrBrzYgMkiZf+OXO2BE3oOXmWK9BGxNCuCUpwfm8uCIwj/WVJRZIFpm2VBsYn1jVs6K0UksM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742367523; c=relaxed/simple;
	bh=DlTITdrau+DzQ5bcUxesBIoe+glzrxx58p3EivKd5n8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lVOIWWf8+90j713tDEcdKNkO/U32hRoalXDMeyI8KZKmUtyMQfUz02flnJzujHJMgHXhEKiOVjAJrefgREmJ1CqupRdzp1WzIPqxI5Xrhh4VzWEPK6R3lStNo8pgqITBsrbtvDRPMfAhMisGaveqmGf/eT2jwVQpBmwXTDmq7Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=lZuejENv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d0d6/f1o; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 508031140166;
	Wed, 19 Mar 2025 02:58:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 19 Mar 2025 02:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1742367518; x=1742453918; bh=+j
	XTegHZIjiivcnTzwcXUaUnV+Sd8U1bW2DKQyUxAoQ=; b=lZuejENv/+FKR9q2R1
	MsNpSMuvVmZSu1VIVFBy5epuzu04fFry0gKqSq+ohMJTQgozup33wcNC3reWBmky
	QZRwsG8UrzeVO11ty8PBI/wzwGJV7KVZvLzDX22s1PrLkyVx3glsaCSarm9STJe9
	aIWgHIAy9m8iLL5D0qPxOESzAHV4qSWstBPn8fjNj4hIkzrbh5jcHFXL74e4uO2w
	tjtCMmhrze1piVofhULNJ/hJuRkxOS8UvAUcsLKnStuw+EVLN9f34Zk1UCbitsAW
	TphdxyfUQKUc67l9QXqNihoHWcFC4+SKRns7NC1NNDqxfEEAQX+SK2jKcm/Q4ESM
	zJPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1742367518; x=1742453918; bh=+jXTegHZIjiivcnTzwcXUaUnV+Sd
	8U1bW2DKQyUxAoQ=; b=d0d6/f1oJcaYsaizEF/fslKzttGQRpn3ghghwX4lSia9
	l1FJanrp0zXM0xeEmkYkQNSh2WBPflJzAnEZ2r0rbK0Nd5hsX972HtIWSPTwaH96
	wAy+qwkCDL8rYRSPbpjtPzf0LsCyu7GtnFc2uS3+bgXJwp5I/N19cBxtxoyh/y9u
	0UGftgqtTi3V3ooV3Mn3BT72/22usNSsbf0KcdbrhySZGE4yEX70w+VBnQhlOcVJ
	T7pra4MOwqpFCAYriqOD0CGV9IOYmVaDMutugiuzTdFRCTBPOQNZYcYxQgxxzB2G
	6TFxseLIe8FLXn11ywVPzLentqpxu7/E2C4FapLgIg==
X-ME-Sender: <xms:HWvaZ2Kd8G9gc5dfo2gxFk5H-wpvN-p-UsnzccDhDYUZVO_FLXo6PQ>
    <xme:HWvaZ-IqJzG_X0Hkq54kL7fg_cLcfvY_-UKHUP7jbX0t2DsWHulYAsmfA9yTJoHPR
    Y220UkX88R694TGEQw>
X-ME-Received: <xmr:HWvaZ2um7JlGSfb7gAKiW5WhBdAPZDf-m6kmtkNeHfnDGuHylEyP_FWQgf6YUYTp0AWYPRP2KyudlLcvng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeegieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffogggtgfesthekredtredtjeenucfhrhhomhepnfhukhgvucflohhnvghsuceo
    lhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepjefhtdevgfehhf
    ekkefffeeiheetfeektdetjeetfefhffejffeitddvuefgjeeknecuffhomhgrihhnpehk
    vghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghvpdhnsggprhgtphhtthhopeeipdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrght
    rdgtohhmpdhrtghpthhtohepihhlphhordhjrghrvhhinhgvnheslhhinhhugidrihhnth
    gvlhdrtghomhdprhgtphhtthhopehplhgrthhfohhrmhdqughrihhvvghrqdigkeeisehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtih
    gvlhhlohesrghmugdrtghomhdprhgtphhtthhopehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:HWvaZ7ZpzqAJ1KsAXiEHiNzdj0jv81GPx7Qkei1yrDlak9Ti3MSFGQ>
    <xmx:HWvaZ9ZK6G67-y6lfpNdzoA8PsZEDfLD-zr29HI7RiQ0Ery1NPC85Q>
    <xmx:HWvaZ3C9Uv4CivvU0dCqCHKIwnokGFn1Ii7_H-_v4MstShDDRv85nw>
    <xmx:HWvaZzbaStWzzDop-IuQnLC6thsZrqIk9doaw9vWoN_OCsf3xICcFQ>
    <xmx:HmvaZwyNzWbVEh8byIEGVPe-pkzm0LMgw-WMcfv8NdZLV0h4NX8xWB2f>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 02:58:33 -0400 (EDT)
From: Luke Jones <luke@ljones.dev>
To: linux-kernel@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	mario.limonciello@amd.com,
	Luke Jones <luke@ljones.dev>
Subject: [PATCH v8 0/8] platform/x86: Add asus-armoury driver
Date: Wed, 19 Mar 2025 19:58:19 +1300
Message-ID: <20250319065827.53478-1-luke@ljones.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

the TL;DR:
1. Introduce new module to contain bios attributes, using fw_attributes_class
2. Deprecate all possible attributes from asus-wmi that were added ad-hoc
3. Remove those in the next LTS cycle

The idea for this originates from a conversation with Mario Limonciello
https://lore.kernel.org/platform-driver-x86/371d4109-a3bb-4c3b-802f-4ec27a945c99@amd.com/

It is without a doubt much cleaner to use, easier to discover, and the
API is well defined as opposed to the random clutter of attributes I had
been placing in the platform sysfs. Given that Derek is also working on a
similar approach to Lenovo in part based on my initial work I'd like to think
that the overall approach is good and may become standardised for these types
of things.

Regarding PPT: it is intended to add support for "custom" platform profile
soon. If it's a blocker for this patch series being accepted I will drop the 
platform-x86-asus-armoury-add-ppt_-and-nv_-tuning.patch and get that done
separately to avoid holding the bulk of the series up. Ideally I would like
to get the safe limits in so users don't fully lose functionality or continue
to be exposed to potential instability from setting too low, or be mislead
in to thinking they can set limits higher than actual limit.

The bulk of the PPT patch is data, the actual functional part is relatively
small and similar to the last version.

Unfortunately I've been rather busy over the months and may not cover
everything in the v7 changelog but I've tried to be as comprehensive as I can.

Regards,
Luke

Changelog:
- v1
  - Initial submission
- v2
  - Too many changes to list, but all concerns raised in previous submission addressed.
  - History: https://lore.kernel.org/platform-driver-x86/20240716051612.64842-1-luke@ljones.dev/
- v3
  - All concerns addressed.
  - History: https://lore.kernel.org/platform-driver-x86/20240806020747.365042-1-luke@ljones.dev/
- v4
  - Use EXPORT_SYMBOL_NS_GPL() for the symbols required in this patch series
  - Add patch for hid-asus due to the use of EXPORT_SYMBOL_NS_GPL()
  - Split the PPT knobs out to a separate patch
  - Split the hd_panel setting out to a new patch
  - Clarify some of APU MEM configuration and convert int to hex
  - Rename deprecated Kconfig option to ASUS_WMI_DEPRECATED_ATTRS
  - Fixup cyclic dependency in Kconfig
- v5
  - deprecate patch: cleanup ``#if`, ``#endif` statements, edit kconfig detail, edit commit msg
  - cleanup ppt* tuning patch
  - proper error handling in module init, plus pr_err()
  - ppt tunables have a notice if there is no match to get defaults
  - better error handling in cpu core handling
    - don't continue if failure
  - use the mutex to gate WMI writes
- V6
  - correctly cleanup/unwind if module init fails
- V7
  - Remove review tags where the code changed significantly
  - Add auto_screen_brightness WMI attribute support
  - Move PPT patch to end
  - Add support min/max PPT values for 36 laptops (and two handhelds)
  - reword commit for "asus-wmi: export symbols used for read/write WMI"
  - asus-armoury: move existing tunings to asus-armoury
    - Correction to license header
    - Remove the (initial) mutex use (added for core count only in that patch)
    - Clarify some doc comments (attr_int_store)
    - Cleanup pr_warn in dgpu/egpu/mux functions
    - Restructure logic in asus_fw_attr_add()
    - Check gpu_mux_dev_id and mini_led_dev_id before remove attrs
  - asus-armoury: add core count control:
    - add mutex to prevent possible concurrent write to the core
      count WMI due to separated bit/little attributes
  - asus-armoury: add ppt_* and nv_* tuning knobs:
    - Move to end of series
    - Refactor to use a table of allowed min/max values to
      ensure safe settings
    - General code cleanup
  - Ensure checkpatch.pl returns clean for all
- V8
  - asus-armoury: move existing tunings to asus-armoury module
    - Further cleanup: https://lore.kernel.org/platform-driver-x86/20250316230724.100165-2-luke@ljones.dev/T/#m72e203f64a5a28c9c21672406b2e9f554a8a8e38
  - asus-armoury: add ppt_* and nv_* tuning knobs
    - Address concerns in https://lore.kernel.org/platform-driver-x86/20250316230724.100165-2-luke@ljones.dev/T/#m77971b5c1e7f018954c16354e623fc06522c5e41
    - Refactor struct asus_armoury_priv to record both AC and DC settings
    - Tidy macros and functions affected by the above to be clearer as a result
    - Move repeated strings such as "ppt_pl1_spl" to #defines
    - Split should_create_tunable_attr() in to two functions to better clarify:
      - is_power_tunable_attr()
      - has_valid_limit()
    - Restructure init_rog_tunables() to initialise AC and DC in a
      way that makes more sense.
    - Ensure that if DC setting table is not available then attributes
      return -ENODEV only if on DC mode.

Luke D. Jones (7):
  platform/x86: asus-wmi: export symbols used for read/write WMI
  platform/x86: asus-armoury: move existing tunings to asus-armoury
    module
  platform/x86: asus-armoury: add panel_hd_mode attribute
  platform/x86: asus-armoury: add apu-mem control support
  platform/x86: asus-armoury: add core count control
  platform/x86: asus-wmi: deprecate bios features
  platform/x86: asus-armoury: add ppt_* and nv_* tuning knobs

Luke Jones (1):
  platform/x86: asus-armoury: add screen auto-brightness toggle

 .../ABI/testing/sysfs-platform-asus-wmi       |   17 +
 drivers/platform/x86/Kconfig                  |   23 +
 drivers/platform/x86/Makefile                 |    1 +
 drivers/platform/x86/asus-armoury.c           | 1202 ++++++++++++++++
 drivers/platform/x86/asus-armoury.h           | 1278 +++++++++++++++++
 drivers/platform/x86/asus-wmi.c               |  170 ++-
 include/linux/platform_data/x86/asus-wmi.h    |   24 +
 7 files changed, 2683 insertions(+), 32 deletions(-)
 create mode 100644 drivers/platform/x86/asus-armoury.c
 create mode 100644 drivers/platform/x86/asus-armoury.h

-- 
2.49.0


