Return-Path: <linux-kernel+bounces-563180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 923CFA637F0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 00:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E8A188F10F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 23:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE13719CD19;
	Sun, 16 Mar 2025 23:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="qEiCNt31";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2inRengk"
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD438479;
	Sun, 16 Mar 2025 23:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742166458; cv=none; b=mlwIHFxnsZ1Y0DHSH9GpheJnM8qVD3hiVAVQPn7zxf3Wjw22NZjsAx9qwUCRz/47CV12Z4Uo4Kclf7nXf266LlAJPI7awV1w8+25f+GX7Qd/WMSLduJifJfebhRMvx0WGNVmYF6KTcv821CzTH4ClsPkPHTOusWCRccR64Ok3pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742166458; c=relaxed/simple;
	bh=v6wliqY+5zMAcfiuM7vnzn+ydpn5IBkQ6FS/e5XpyhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gRdQEYb6WgO41vXAcfpNbBY2Kny6GXd/vNZB6c9AX6tB9uzQU3xN6N6Xa94x+8IFndnBu5xQD2wn80UVzeSVelHaZaEBossJ/bYTvK2qzND7djA6aSzOL5Www9uMThtBQIBSLVkXqZ2HydWJ3lIRSVBroKf47772OIh3WtFHVfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=qEiCNt31; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2inRengk; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8A5E62540103;
	Sun, 16 Mar 2025 19:07:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 16 Mar 2025 19:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1742166454; x=1742252854; bh=8i
	U71Zi/Ef0W1cLhtYycfXQ+eIXzZk8yqml9VJjuiHM=; b=qEiCNt31D0ezN6FoTo
	QrqZ2L8apwLHUUhoUGcS8DKwHua5FWUSQLz7L5cTu6WjxVaY38m5u8NzpDkYUhXk
	Ep6Sb4jYj1D1+mDJuoaCES6ot70og3UjKuP1gMZYwD4+7+Hf7j/xb8nSBRwouwSU
	deJF9Yi1c4WcwmC8v6glkrYZciKmj/FUt4COGPf7LTTxHz4P9Uw11Dz7hcQdJgef
	6/oOTlwra/ulwCtJt5TmnJki+znZ+pr8JXC62ZbD+9dYVYk2bdYDMflNlEJ4+xkH
	/Hz/TUiLCFAgDm0Hb8aDcmeusRSkfgmwW9VST76gjPr7JOnxMJgWtpoUypzeMUZd
	55nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1742166454; x=1742252854; bh=8iU71Zi/Ef0W1cLhtYycfXQ+eIXz
	Zk8yqml9VJjuiHM=; b=2inRengk1P1iIRF5m2Z57scny9oMWLz8gymMuTSnO5uO
	ndwIU43MBP6KY1ZgYzZDiL1z2ataQ0C6JAOIGs36NN4EMFGv/6mjtBdQ00WHEL+a
	NrG7Yk9svQHtKCLDC5QERYAa3iiYjiWeTw11ID7BPcQ+4gqVuXhllSQvRsTA+1hd
	Ul5sxrRv9RcoHFaLOTJx02gxDYsuGxYZsI05vFX4q40pWXdbc2XXSkI9Ap+WNS7L
	g329iCTXBXTnP/dmildZargzMtJeUyHuX39j2yau7dPd4bcjo54FyRWaultnMpYD
	YeXS8qn7pryuteIkUby3cy3KtOj6Dvh8+PBgK5jfsg==
X-ME-Sender: <xms:tlnXZ_I8ZLTv4tsMKbDxwMi_FDtLjZljAj0YHEWGn8Vpj8tI_u9gtA>
    <xme:tlnXZzJ7fTB8qnx3YRIR3X9v5niAwPfAdCrD9A7uW2GhjjtbNzyTLDYEWJSkFY1u0
    xE0_GoAn4aLxGM_lxI>
X-ME-Received: <xmr:tlnXZ3u4lEchLCGgCIFNChB_0rvTPSMcp5GTLcvdsOMXNxdAq2lq_zhaAfvqpYOCyRu64QzQ27DlzbhxEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeejkeelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:tlnXZ4Z6WBiiMubVQCW4Uvj0QmGKD4rMIinBy4ukj9eC35hVtH1PcA>
    <xmx:tlnXZ2ZTjD_dDSwSjgjOW_ALrTvhrZsf9U0nV4qTHm8LWou1lZcnbQ>
    <xmx:tlnXZ8DCm_ib1oKlzfPETlMYbxcv0pd2GkbUm6Zjw0vz5LA2urseag>
    <xmx:tlnXZ0b950ZshHlwQ7NUjWR9a8xfW6lhwg9vDjEDQ392h5xtmIR-FQ>
    <xmx:tlnXZ9zEY6Nt-9i8Wlom_13VDqoJdemQzu1NUcSNg1vW8kW0_-IM0VBn>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Mar 2025 19:07:31 -0400 (EDT)
From: Luke Jones <luke@ljones.dev>
To: linux-kernel@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	mario.limonciello@amd.com,
	Luke Jones <luke@ljones.dev>
Subject: [PATCH v7 0/8] platform/x86: Add asus-armoury driver
Date: Mon, 17 Mar 2025 12:07:16 +1300
Message-ID: <20250316230724.100165-1-luke@ljones.dev>
X-Mailer: git-send-email 2.48.1
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
everything in the v7 changelog but I've tried to be as comprehensive as I can
and I've done my level best to self-review.

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
 drivers/platform/x86/asus-armoury.c           | 1125 +++++++++++++++
 drivers/platform/x86/asus-armoury.h           | 1278 +++++++++++++++++
 drivers/platform/x86/asus-wmi.c               |  170 ++-
 include/linux/platform_data/x86/asus-wmi.h    |   24 +
 7 files changed, 2606 insertions(+), 32 deletions(-)
 create mode 100644 drivers/platform/x86/asus-armoury.c
 create mode 100644 drivers/platform/x86/asus-armoury.h

-- 
2.48.1


