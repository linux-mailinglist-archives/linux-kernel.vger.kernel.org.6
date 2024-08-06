Return-Path: <linux-kernel+bounces-275566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6835F94874C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ADDE1C21450
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C101184D;
	Tue,  6 Aug 2024 02:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="xfFwj+L8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hu0Ti3ze"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2B8182B4;
	Tue,  6 Aug 2024 02:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910079; cv=none; b=abr6/SorMmc+3s9xzKJk1JVs6tyfPbXZwPeqZ2oAO8xcJfIyyXXWykC9G9TmEzfCO06spHyxxTJHf0oU0V51SvQzhnRFbodjuWH3TOscgQHb1kJWPZW2M510Zpzzr2VYymhUmI5wS2Yt0aQmq8O8xLIRbEAoT7OCYahqGFpbS5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910079; c=relaxed/simple;
	bh=a/7MOqiAMxoTw/EY8uL3uFvPVvdluNSPysI4DWG44Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mORBwk+sBzQzE2iTVRrPO6U6VPr3UeauMmQR1gPNJzoNS85f33oI4C0Zdf1c3PtguhuVZPRW3naABSFI+MLDNhWAoDBuxr/IVUyNjDqyFoRb2fCOd5qQVF5PBQ/rVTslihiqI8Tu/0WAye7y/6uos2C2dP/6szNxbZu3osr5Xpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=xfFwj+L8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hu0Ti3ze; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 994CF1151A79;
	Mon,  5 Aug 2024 22:07:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 05 Aug 2024 22:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1722910076; x=1722996476; bh=R5
	C4NYbdmvProK3nJjnAxeWICk+BdyoBeZa5PIJIU2g=; b=xfFwj+L8NwBjo26dCQ
	FeQx25vBPd4GTZngTLM34IFnVfVaHX9Fnzl5qTi+LdhKvZcGTb6HLyMSnGtLsihx
	TZ9EyjHEOxR+2bhUgOrOkrbQ+KJe/BUk6ANQXzI9ZcZY8rQRMTmCOO6H4QQi4qNO
	9nu3n/9xHZE8oxeC8xjP9MoKbiERDariwob8PAHcW7IUbI2aZk5KKGs+KWzJ9xHE
	TA8RGrXiUhkFeh3JkqRfijPyBTp5l53XcyZ/8Pj8E3mQBLcBbzwytMjL8C4r+mWd
	f9Vu/Es8fQcNbyczMH38kbLrdwGWwhYaGrDzWC57J76nqHRhPbK4TOrxZzCr/9sW
	fjrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1722910076; x=1722996476; bh=R5C4NYbdmvPro
	K3nJjnAxeWICk+BdyoBeZa5PIJIU2g=; b=Hu0Ti3ze89QdnjxhjL9GlcGtjZbgQ
	p3w+9yLO0rNpJ+mecEQWh2qPwR3HYaXIBakpgA7PKMYUxZMB1PkgNtXlE6ezNjPi
	SMhI2u3IEGjQZQ+ZTB44auz6rRzlLbg5S5wpLEQ5ZgyDzalbRnLYwWCFr7wlC0+E
	Gl+KT1VVo3uG61zvRQS1GRRuOrrSUyjND7BMLOoOYG9GJKZhgTemGYekKRBTB2MI
	CYQTsIZN0f11HJAlazf/enkKimEue1uLowEzv5+CgcK+zRjKAd2v7gVn9yld288x
	W71qcyMeWfdWHSWmnEhhNHNuPEezh1Em9KrJ9CrCgUJGo3MZiddTfowpQ==
X-ME-Sender: <xms:fIWxZuvCuCGzyLyhb9r3ciglUiMExUiOmeMxI554YnvMoxyaaMJoQg>
    <xme:fIWxZjc8ZB0M_5P0OsE2TkXBh5sMUeGLzNNwSR6K6bQrQFzc5zxxbXw4ZK2vvg9xo
    7AXmma3jq8opSd5mBs>
X-ME-Received: <xmr:fIWxZpxl2721ZUulVVbWUvkxPGRJJruFPFh_bL9Hqj-6FteOFGTXXlnfLqQZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeejgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofggtgfgsehtkeertd
    ertdejnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepjedthfehffekhfetkeeludetgedugf
    elkeehjeeuvdeufedvledtheeugfevkeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhr
    ghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluh
    hkvgeslhhjohhnvghsrdguvghvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:fIWxZpPXZyyDH7U6mZAfnK10WDip6sKbFUp5pTcOR1nOodk5Al9DQg>
    <xmx:fIWxZu-frKXXhNEruFEnSBZhou2K87FuWLYhudDeWONy-_wxyg4E7A>
    <xmx:fIWxZhVva9UFXoaK9781wa0eLKsWD0XhkjKfJb9xHMRuKIJVfKJ3WQ>
    <xmx:fIWxZne7hHQ-iM5xovi8UoAEzp7KByNAYeLaxq25G1GYeShO52tkkg>
    <xmx:fIWxZlkkxygm-ZkhEVT7UqQrLsSLoDlqRI67LcFeJds4KE2wNOsv73Nb>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 22:07:53 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	corentin.chary@gmail.com,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 0/6] platform/x86: introduce asus-armoury
Date: Tue,  6 Aug 2024 14:07:41 +1200
Message-ID: <20240806020747.365042-1-luke@ljones.dev>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the first major patch I've ever done with the intention of
introducing a new module, so it's highly likely I've made some mistakes
or misunderstood something.

TL;DR:
1. introduce new module to contain bios attributes, using fw_attributes_class
2. deprecate all possible attributes from asus-wmi that were added ad-hoc
3. remove those in the next LTS cycle

The idea for this originates from a conversation with Mario Limonciello
https://lore.kernel.org/platform-driver-x86/371d4109-a3bb-4c3b-802f-4ec27a945c99@amd.com/

It is without a doubt much cleaner to use, easier to discover, and the
API is well defined as opposed to the random clutter of attributes I had
been placing in the platform sysfs.

The name `asus-armoury` was settled on after some debate with users of the module.
This name is derived from the ASUS application named "Armoury Crate" as this is what
many users look for in searches and articles when crossing over to Linux from Windows.
The alternative was `asus-fw-settings`, which may still be up if there is any opposition
to the new name.

I am unsure of how best to handle the deprecation of attributes.

There's also some attributes that are obviously boolean but are using 0/1.
I'm unsure if I should change that.

And would it be best to move the asus stuff to a subdir now? Akin to the
Dell platform stuff.

The two new files were formatted with clangd with line length 96

I get this with checkpatch:
```
ERROR: Macros with multiple statements should be enclosed in a do - while loop
#934: FILE: drivers/platform/x86/asus-armoury.h:116:
+#define ATTR_GROUP_ENUM_INT_RO(_attrname, _fsname, _wmi, _possible, _dispname) \
+	__ATTR_CURRENT_INT_RO(_attrname, _wmi);                                \
+	__ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname)
```
I'm unsure what to do - adding the do/while breaks things.

All guidance deeply appreciated to get this over the line.

Regards,
Luke

Changelog:
- v1
  - Initial submission
- v2
  - Too many changes to list
  - History: https://lore.kernel.org/platform-driver-x86/20240716051612.64842-1-luke@ljones.dev/

Luke D. Jones (6):
  platform/x86: asus-wmi: Add quirk for ROG Ally X
  platform/x86: asus-armoury: move existing tunings to asus-armoury
    module
  platform/x86: asus-armoury: add dgpu tgp control
  platform/x86: asus-armoury: add apu-mem control support
  platform/x86: asus-armoury: add core count control
  asus-wmi: deprecate bios features

 .../ABI/testing/sysfs-platform-asus-wmi       |   17 +
 drivers/platform/x86/Kconfig                  |   22 +
 drivers/platform/x86/Makefile                 |    1 +
 drivers/platform/x86/asus-armoury.c           | 1047 +++++++++++++++++
 drivers/platform/x86/asus-armoury.h           |  241 ++++
 drivers/platform/x86/asus-wmi.c               |  187 ++-
 include/linux/platform_data/x86/asus-wmi.h    |   19 +
 7 files changed, 1506 insertions(+), 28 deletions(-)
 create mode 100644 drivers/platform/x86/asus-armoury.c
 create mode 100644 drivers/platform/x86/asus-armoury.h

-- 
2.45.2


