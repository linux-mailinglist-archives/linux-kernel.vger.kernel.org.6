Return-Path: <linux-kernel+bounces-332477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D13D197BA41
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648C41F2420F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1411C1791EB;
	Wed, 18 Sep 2024 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="YhEjEQgV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q3qJRJjw"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E381915C150;
	Wed, 18 Sep 2024 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726652582; cv=none; b=piR+yIAXIphdEceKrVryHINm5xPa0xiV55tCvHf7BcdFCpTcTKxOECJPCYAWLTjUMQgPZ/1QtaLenfBIHSsmprccunndNjMFY53Y3ma8KyE7NKIsRBw9+fOKIYIBCs3PITZ/s5zzDEOvBR2rLBB1V453Wq3mmVeMHQByd6FZeeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726652582; c=relaxed/simple;
	bh=tFloRtTTzF5qSAMFw0Z62deUI/pAYY86upGFXYXL6lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kgUebhzHZ2hWBIZT4Gve7dT48nTXDmsxYs4bqVmkPHwUvMPPo9SCg1xoxYFf9FoGmKBwL/CA2fuwvukEqvJ4JasVd5BocIXZBpNezXsEGgm7+7LcsUVzsl/n4bB4wBS2+LWFElBdmzAmPD0WjFSId1CgwcJqUC2XkIUArdGtKvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=YhEjEQgV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q3qJRJjw; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id EC07F1380283;
	Wed, 18 Sep 2024 05:42:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 18 Sep 2024 05:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1726652578; x=1726738978; bh=ml
	xYnUSBkXDOmfksDlJu1dQ1H4W3o3ap43oZa0IvZDE=; b=YhEjEQgVPT318+ZXBl
	gtg1UwGs12NMyGpoeec1jyH9aZqloDrJ00ClOoNW7WvXo6s6FCCrvZ+83r0Ux9gw
	J/8zg9AA759AR+XVuL9516NPyg7FvmsE75CmKap9C1WLwECrLbLk//BUnjHi63De
	uBPuI/saJ+avh0u+8E6+JGYMjj21cPudT3RqHQv0+S0+2kePDX0QDN5RMlzQHDiM
	HvxcyYEOjVMYc3JWIbtdBmuWQl2VsWi5UVlAtbjjauXRvaIohOiNHqbjXsVieHch
	5GWWtGTF2Jl2Csz75+8h/vD5Qj90IWRgI1nUdbPqZoNb5tEKJajfW6v+Dxa4GBmp
	ZAvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1726652578; x=1726738978; bh=mlxYnUSBkXDOm
	fksDlJu1dQ1H4W3o3ap43oZa0IvZDE=; b=q3qJRJjw9aSlMo/xiZ0Z3l1M9aqEX
	CGFrsaX0kPk+xJ15Z2qb0+sz0dFUWpVzVCbEcjtACIUUYvedVkHROdIfikZ61flw
	JJg71Fq/smGYnkyGmSXl8oUSs9UNaoMCorJTX5XOGp7dhte3DHnUU4/BDP3N2lSO
	zrZ4+NduqrjOR0d8SVkvtL4bSmh8Rk4GBRqQme5s1GB7qg+3NYj+YFbcJNEslyGJ
	o3K2O5x+8VOezmurP+niXixQB/W7T9Lf0QG6SdTpxxXPunSHGbfiy3DpbUBrpB3e
	L8vDUFYNfRPGWvJnu7JCCyZxEavzG6ifo6IQaMTbPfQ6RU49GmcjdkBmQ==
X-ME-Sender: <xms:oqDqZrXnG86D2q_0Ho_HbROvwEnzi_ZytERUamZnCpRhugYn_H--xA>
    <xme:oqDqZjli4KzJ76rn6ZyoPsW1Qci34qb9hCBXM5kf-Qgv_sEGve8flGQed7MhJF256
    B_iU2fEdSA3g1Mo7fM>
X-ME-Received: <xmr:oqDqZnZgtSW1YUeZ98pThfHuit11GR-6pqNrDOLqmC3ok4citF8haD2-X-c0HA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekledgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffogggtgfesthekredtredtjeenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghs
    fdcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpeejtdfhhe
    ffkefhteekleduteegudfgleekheejuedvueefvdeltdehuefgveekkeenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvhdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhlrghtfhhorhhmqdgurhhivh
    gvrhdqgiekieesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhuggvgh
    hovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepihhlphhordhjrghrvhhinhgv
    nheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegtohhrvghnthhinhdrtg
    hhrghrhiesghhmrghilhdrtghomhdprhgtphhtthhopehluhhkvgeslhhjohhnvghsrdgu
    vghv
X-ME-Proxy: <xmx:oqDqZmWCj4hBHQO7wGrGWnDJc246VTGHHSLcQxTzN0kTunJBWMO8xQ>
    <xmx:oqDqZlkHoRt1aDgNwkpS-HnILbfoget2wMQ6B5g1sqV5fJqsCjgUFA>
    <xmx:oqDqZjezHOWv0x3NLRlARUx5VxWtIXmPv9AHkR9-ZWVUEWlAiVHp9A>
    <xmx:oqDqZvFJjbFnYX2GshE21gnTZAXgneyB8TlrhX4hyMmPXDq24ogG2w>
    <xmx:oqDqZot2GVWHeAVEEwsQNynNRNwNTgbA_T1yn_S5ioYrStQpAioM_9NE>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Sep 2024 05:42:55 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	corentin.chary@gmail.com,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 0/5] platform/x86: introduce asus-armoury driver
Date: Wed, 18 Sep 2024 21:42:45 +1200
Message-ID: <20240918094250.82430-1-luke@ljones.dev>
X-Mailer: git-send-email 2.46.1
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

I am unsure of how best to handle the deprecation of attributes.

There's also some attributes that are obviously boolean but are using 0/1.
I'm unsure if I should change that.

And would it be best to move the asus stuff to a subdir now? Akin to the
Dell platform stuff.

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

Luke D. Jones (5):
  platform/x86: asus-armoury: move existing tunings to asus-armoury
    module
  platform/x86: asus-armoury: add dgpu tgp control
  platform/x86: asus-armoury: add apu-mem control support
  platform/x86: asus-armoury: add core count control
  platform/x86: asus-wmi: deprecate bios features

 .../ABI/testing/sysfs-platform-asus-wmi       |   17 +
 drivers/platform/x86/Kconfig                  |   22 +
 drivers/platform/x86/Makefile                 |    1 +
 drivers/platform/x86/asus-armoury.c           | 1056 +++++++++++++++++
 drivers/platform/x86/asus-armoury.h           |  255 ++++
 drivers/platform/x86/asus-wmi.c               |  203 +++-
 drivers/platform/x86/asus-wmi.h               |   14 +
 include/linux/platform_data/x86/asus-wmi.h    |   19 +
 8 files changed, 1538 insertions(+), 49 deletions(-)
 create mode 100644 drivers/platform/x86/asus-armoury.c
 create mode 100644 drivers/platform/x86/asus-armoury.h

-- 
2.46.1


