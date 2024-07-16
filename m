Return-Path: <linux-kernel+bounces-253348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A77931FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E8D6B217D9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6986617556;
	Tue, 16 Jul 2024 05:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="HBo7i0SD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TM1TV5gq"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA89136A;
	Tue, 16 Jul 2024 05:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721106985; cv=none; b=mmbfep7dcKkHJuXrwmfevlEINaqo04OmVKF+aagC0tDAg4CnHlABTDRAgCi+HXQH2PJRK0KG8HcwD65VWehhR/M/QdzMBqp5/8Oa/mxKgIu+ltktylF2/X2wnaHof/Km1eDYUksGCaCwa6QzwzxQ08SX6thd8ANZRtUu/iL6JBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721106985; c=relaxed/simple;
	bh=ypOsnXmdm+nfdL16oWsg5hceWmNX3dfiteFsA12IJBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xh7Ky4Kn/JF4nZfSanlWXCyP9T86ndZVy18rGWdidpjLFF9+CKPThNFgmjLZRzON33kgYXA3qJjbvddsTvmpo6ta1zi8tYbHU0EVHXNjEgXYlHDLUQYXyVxfUBdxTa6V22/MYkBHtwHsdCVrwE0dtCITfJOSZ2V8lqX/8rbo1gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=HBo7i0SD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TM1TV5gq; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1C19A1148192;
	Tue, 16 Jul 2024 01:16:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 16 Jul 2024 01:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1721106982; x=1721193382; bh=jd
	RcvhBn1cGa0IZrXl2b66/oZpAq8+2kAci5+WWl/jY=; b=HBo7i0SDblBRHItr2H
	FFogQVyazg1rAyokh4pT/ypwIO9JcX/t6mP3uFJufCHG85y78k8yBaNjczi8cguJ
	8yfNsvzB/2HYJHkDI8ylkH9QgbfXEay0dBGWsFD427pOxHAKaDOgVWhJ3eCgxney
	dulsLp8PjQ3QJ7DJZ3uB2fhnV5d1qSB8gSFpfwJDVTURth55CR5LBfF1WcudZWok
	E9gHdZ9CXVSfU2rPenaAPNrntgM/fqvCalrOTDX4bDsmh1oglXf64w51WpAtraMI
	VSCgZgfIJgvhScrkRw504kjDkx0QafyebnAgFkYdlsvU2qGYDcXnRr6oiolfvAJ2
	lIrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1721106982; x=1721193382; bh=jdRcvhBn1cGa0
	IZrXl2b66/oZpAq8+2kAci5+WWl/jY=; b=TM1TV5gqJSIwM1K3IVbeg3+ItmHN3
	4d3iOTkmHVpJsUQpBbsquIFlNRho8CIiOQQzMU4kdCX5wr3It1HqZxpZ68ZsTnt6
	QPny7Ck9H06hy0J4gnUwNICIgNf6+antpBDg68ZhKa+1P1d7WT2AjjZkplU0+jCg
	wmy2CeMvVwnqBtTiNwovq2rkOWVavAXk4MUtWtY7hYDOjyT0yTdv4xms1g6PcARA
	4H76jzJADM3+vaZOoTogZxT7jWZYbsDPGxiDO1PWFbIL4FLvr1WwKZEoC3U+JPLr
	0AyubzN3Yh8Q1PYtncngiMfHs3l8hamBZm9MO2jYrMyc16eM5Ae9NmQxg==
X-ME-Sender: <xms:JAKWZoPO7aPnGx8jOqbPnBZ7YkJYdPAlyQno4GreKcbUDZr4MCozuA>
    <xme:JAKWZu-7hLbNu1nW2cYlcUSVwO6FwZarG4kEDX9Zaq_3dwSyokDINlBs4czzQPgZI
    hgF5djo6oOvs8geoQA>
X-ME-Received: <xmr:JAKWZvQWEXHy1lHu0-Tkph1YAb3dqUEreeEmYCo1UWxAlOFG7gw7QsRUg2wU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeefgdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofggtgfgsehtkeertd
    ertdejnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepjedthfehffekhfetkeeludetgedugf
    elkeehjeeuvdeufedvledtheeugfevkeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhr
    ghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluh
    hkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:JAKWZgtquYRv7cHmPVndd6Ep3iKt4l2K-VCtXs73YD0J2zjBdJNqTA>
    <xmx:JAKWZgfNn6AwFzDDwglOrz2lv6OliMiICEJXlYqeHIlPBWmO0a5SaQ>
    <xmx:JAKWZk0ymYvxQ-OkCuAnRglD-glO1uZGYpfSYxwynhg5kFx62N-3Iw>
    <xmx:JAKWZk8qBavuiw2rOgLmxq-lYv1qxoOcXyHtqnLoE2ts8RAdZ_Pezw>
    <xmx:JgKWZoTax9l8wTvmpHm1P_dhtZdeKk9qdapcDNLBWW5JuSQjnar3PDJ8>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jul 2024 01:16:17 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	mario.limonciello@amd.com,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 0/5] platform/x86: introduce asus-bioscfg
Date: Tue, 16 Jul 2024 17:16:07 +1200
Message-ID: <20240716051612.64842-1-luke@ljones.dev>
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

The review of this patch series will also affect my next patch set which
is for the ROG Ally (2k LOC) as I've used a similar strategy for the
macros to reduce LOC as much as possible.

In regards to *this* patch series though, I think the critical areas
might be the use of the mutex, the macros, possibly the way I've setup
the module to load/depend on asus-wmi (I had to read other code to try
and define the way).

I am unsure of how best to handle the deprecation of attributes.

There's also some attributes that are obviously boolean but are using 0/1.
I'm unsure if I should change that.

And would it be best to move the asus stuff to a subdir now? Akin to the
Dell platform stuff.

All guidance deeply appreciated to get this over the line.

Regards,
Luke

Luke D. Jones (5):
  platform/x86 asus-bioscfg: move existing tunings to asus-bioscfg
    module
  platform/x86: asus-bioscfg: add dgpu tgp control
  platform/x86: asus-bioscfg: add apu-mem control support
  platform/x86: asus-bios: add core count control
  asus-wmi: deprecate bios features

 .../ABI/testing/sysfs-platform-asus-wmi       |  17 +
 drivers/platform/x86/Kconfig                  |  22 +
 drivers/platform/x86/Makefile                 |   1 +
 drivers/platform/x86/asus-bioscfg.c           | 997 ++++++++++++++++++
 drivers/platform/x86/asus-bioscfg.h           | 302 ++++++
 drivers/platform/x86/asus-wmi.c               | 144 ++-
 include/linux/platform_data/x86/asus-wmi.h    |  19 +
 7 files changed, 1473 insertions(+), 29 deletions(-)
 create mode 100644 drivers/platform/x86/asus-bioscfg.c
 create mode 100644 drivers/platform/x86/asus-bioscfg.h

-- 
2.45.2


