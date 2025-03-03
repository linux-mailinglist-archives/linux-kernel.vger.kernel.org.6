Return-Path: <linux-kernel+bounces-544988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47472A4E775
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4714042494C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82489206F0F;
	Tue,  4 Mar 2025 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iWDAoiCq"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54E9279350
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106155; cv=fail; b=lV31ezNFmUmy5ny7xujv0VWIcjgpvXYs8rMwL5SxzU9nUAl2R7rToGQ+Z7AxftcMxIiYHSN1K9+gQt9sJP4V/A8EpdLMr193dqEToVHqL7+TwoEG0jfoe+w4VpD8rNH30BrWKJhkvQ7pW7aRImLLycBQ3eLM7Iq/YcsE60dl55o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106155; c=relaxed/simple;
	bh=l43G/V/Q6b1qq5Sx1yo/DSJ++y4MPkFQDCnYWhqiDQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bNIY9oxVFG+V3p0+u7hpPyrQdZI4iy2o7QQD7SDXtz1GfyJNJI7crLoG+uLOU78p8cYLYxwl1JkRIfYrUyGc3BD5LFIJkqKX6LpYihEgirR01FPuQ6gjrTjV+GMDfE22uz3Q/JeqjM6sE6+fCClLZ2L6n2AmrpdoXPMucGAfRVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=bootlin.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iWDAoiCq reason="signature verification failed"; arc=none smtp.client-ip=217.70.183.196; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; arc=fail smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 03BD840D975C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:35:52 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6h8Q1519zG3fD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:33:58 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 96C4742730; Tue,  4 Mar 2025 19:33:50 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iWDAoiCq
X-Envelope-From: <linux-kernel+bounces-541221-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iWDAoiCq
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id DD2CE4225E
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:05:56 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id AC1403063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:05:56 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A39018941F9
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366631F37CE;
	Mon,  3 Mar 2025 09:03:43 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC3C1EF096;
	Mon,  3 Mar 2025 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992618; cv=none; b=A+gbLpc+yuVfCNIzVO7lAKJc3wzR81eLAgxtQ7C1DCyvUFtR0ky/bqFx/k0+FcoFtk3rs1KqzY7mrt+3Zczt3ZES5tnQpCDIXMQH/JH9al22F+nbYXe2+ybFvC4i8ICD4xZQQryzHe1GIKQk/flHH9VhTmP6vQ1C04fp/ROQh44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992618; c=relaxed/simple;
	bh=AK/p2U8XpJ6b+1+XuCwmiPcVkiG70Q8gAZniY+/qwkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nbvXyz+y0QwuLbSCkuc4DCC62B+OaXzGMyZErSc7aoiwUBIZ6S3Kg0PLj0u5j+fGQU6gCWGjpuKWnI7mBjzfF7NLKeCDLOzxvBZUGdZ0HNvU10STZ8og0hzvavTWJPd5jrza0NvK04qmdc+YJG2vUrRQ8bUUA07umYcVJRJm91Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iWDAoiCq; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DBACC443F3;
	Mon,  3 Mar 2025 09:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740992608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FNu5/p3bCwoZIxM3jDsSahP+LbfLGMyqj/lEeyoOvo4=;
	b=iWDAoiCqy4wWy4T2UzzwTqScC1wvB1GCJnSfQc+WKDXBbhFQQd9QxZrkNBaYRybitxKl4E
	i5aVk8aA4XGh7pjcQwwVyPFSpZHGkI39kLd8c+oefb/lH/ihzJ7QGAmPyrpSCrIbz8I1LT
	XkNPimrmK0GbDinVjckp6Dwzp41VM55Oios8KpM2+rnvCA+Y3Jo98mR9kGIrMwzYQ83Unr
	ORvgCuGjMF09CvwzZcnFsScHUchszwbVP3rcHgWNU4JB9ofVAWtqU3a7mAkm0fEQvBFY+7
	1gm+cSWtxrMieMRbG7XZmoEzb8rgdbJOthIsznLiv64UOtROvRU9nhnWy4t7bA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next v4 00/13] net: phy: Rework linkmodes handling in a dedicated file
Date: Mon,  3 Mar 2025 10:03:06 +0100
Message-ID: <20250303090321.805785-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejhfelieehgfffiefftdffiedvheefteehkedukefgteffteevffeuueejiedtveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6h8Q1519zG3fD
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741710865.16126@QAvLLvbdib3y32ejz6R6qA
X-ITU-MailScanner-SpamCheck: not spam

Hello everyone,

This is V4 of the phy_caps series. In a nutshell, this series reworks the=
 way
we maintain the list of speed/duplex capablities for each linkmode so tha=
t we
no longer have multiple definition of these associations.

That will help making sure that when people add new linkmodes in
include/uapi/linux/ethtool.h, they don't have to update phylib and phylin=
k as
well, making the process more straightforward and less error-prone.

It also generalises the phy_caps interface to be able to lookup linkmodes
from phy_interface_t, which is needed for the multi-port work I've been w=
orking
on for a while.

This V4 addresses Russell's reviews, namely :

 - Introduce new iterators to traverse the link_caps array in ascending a=
nd
   descending order, making it more explicit and simple.
 - Remove an unneeded linkmode_zero in patch 9

V1 : https://lore.kernel.org/netdev/20250222142727.894124-1-maxime.cheval=
lier@bootlin.com/
V2 : https://lore.kernel.org/netdev/20250226100929.1646454-1-maxime.cheva=
llier@bootlin.com/
V3 : https://lore.kernel.org/netdev/20250228145540.2209551-1-maxime.cheva=
llier@bootlin.com/

For context, The text below is an extract from the V1 cover :

Following the V4 of the phy_port series [1] we've discussed about attempt=
ing
to extract some of the linkmode <-> capabilities (speed/duplex) <-> inter=
face
logic into a dedicated file, so that we can re-use that logic out of
phylink.

While trying to do that, I might have gotten a bit carried-away, and I'm
therefore submitting this series to rework the way we are currently
managing the linkmodes <-> capabilities handling.

We are currently defining all the possible Ethernet linkmodes in an
enum ethtool_link_mode_bit_indices value defined in uapi/linux/ethtool.h =
:

	ETHTOOL_LINK_MODE_10baseT_Half_BIT	=3D 0,
	ETHTOOL_LINK_MODE_10baseT_Full_BIT	=3D 1,
	...

Each of these modes represents a media-side link definition, and runs at
a given speed and duplex.

Specific attributes for each modes are stored in net/ethtool/common.c, as
an array of struct link_mode_info :

	struct link_mode_info {
		int				speed;
		u8				lanes;
		u8				duplex;
	}

The link_mode_params[] array is the canonical definition for these modes,
as (1) there are build-time checks to make sure any new linkmode
definition is also defined in this array and (2) this array is always
compiled-in, as it's part of the net stack (i.e. it is not phylib-specifi=
c).

This array is however not optimized for lookups, as it is not ordered in
any particular fashion (new modes go at the end, regardless of their spee=
d
and duplex).

Phylib also includes a similar array, in the form of the phy_settings
array in drivers/net/phy/phy-core.c :

	struct phy_setting {
		u32 speed;
		u8 duplex;
		u8 bit; // The enum index for the linkmode
	};

The phy_settings array however is ordered by descending speeds. A variety
of helpers in phylib rely on that ordering to perform lookups, usually
to get one or any linkmode corresponding to a requested speed and duplex.

Finally, we have some helpers in phylink (phylink_caps_to_linkmodes) that
allows getting the list of linkmodes that match a set of speed and duplex
value, all at once.

While the phylink and phylib helpers allows for efficient lookups, they
have some drawbacks as well :

	(1) : It's easy to forget updating of all of these helpers and structure=
s
		  when adding a new linkmode. New linkmodes are actually added fairly
		  often, lately either for slow BaseT1 flavours, or for crazy-fast
		  modes (800Gbps modes, but I guess people won't stop there)
		 =20
	(2) : Even though the phylink and phylib modes use carefull sorting
		  to speed-up the lookup process, the phylib lookups are usually
		  done in descending speed order and will therefore get slower
		  as people add even faster link speeds.
		 =20
This series introduces a new "link_capabilities" structure that is used
to build an array of link_caps :

	struct link_capabilities {
		int speed;                          =20
		unsigned int duplex;
		__ETHTOOL_DECLARE_LINK_MODE_MASK(linkmodes);
	};

We group these in an array, indexed with LINK_CAPA enums that are basical=
ly
identical to the phylink MAC_CAPS :

...
LINK_CAPA_1000HD,            =20
LINK_CAPA_1000FD,
LINK_CAPA_2500FD,
LINK_CAPA_5000FD,
...

We now have an associative array of <speed,duplex> <-> All compatible lin=
kmodes

This array is initialized at phylib-init time based on the content of
the link_mode_params[] array from net/ethtool/common.c, that way it is
always up-to-date with new modes, and always properly ordered.

Patches 3 to 8 then convert all lookups from the phy_settings array into
lookups from this link_caps array, hopefully speeding-up lookups in the
meantime (we iterate over possible speeds instead of individual linkmodes=
)

This series is not meant to introduce changes in behaviour, however patch=
es
9 and 10 do introduce functionnal changes. When configuring the advert
for speeds >=3D 1G in PHY devices, as well as when constructing the link
parameters for fixed links in phylink, we used to rely on phy_settings
lookups returning one, and only one, compatible linkmode. This series wil=
l
make so that the lookups will result on all matching linkmodes being
returned, and MAY cause advert/fixed-link configuring more linkmodes.

Patches 12 and 13 extract the conversion logic for interface <-> caps fro=
m
phylink.

There are cons as well for this, as this is a bit more init time for phyl=
ib,
but maybe more importantly, we lose in the precision for the lookups in
phy_settings. However, given all the uses for phy_settings (most are just
to get speed/duplex), I think this is actually ok, but any comment would
be very welcome.

This series was tested with :
 - 10/100/1000M links
 - 2,5, 5, 10G BaseT links
 - 1G Fixed link

I also made sure that this compiles with the following options :

CONFIG_PHYLIB=3Dn

CNFIG_PHYLINK=3Dm
CONFIG_PHYLIB=3Dm

CNFIG_PHYLINK=3Dm
CONFIG_PHYLIB=3Dy

CNFIG_PHYLINK=3Dy
CONFIG_PHYLIB=3Dy

All the new helpers that were introduced (in drivers/net/phy/phy-caps.h)
are for internal use only (only users should be core stuff, such as phyli=
b and
phylink, and in the future, phy_port).

Thanks,

Maxime

[1]: https://lore.kernel.org/netdev/20250213101606.1154014-1-maxime.cheva=
llier@bootlin.com/

Maxime Chevallier (13):
  net: ethtool: Export the link_mode_params definitions
  net: phy: Use an internal, searchable storage for the linkmodes
  net: phy: phy_caps: Move phy_speeds to phy_caps
  net: phy: phy_caps: Move __set_linkmode_max_speed to phy_caps
  net: phy: phy_caps: Introduce phy_caps_valid
  net: phy: phy_caps: Implement link_capabilities lookup by linkmode
  net: phy: phy_caps: Allow looking-up link caps based on speed and
    duplex
  net: phy: phy_device: Use link_capabilities lookup for PHY aneg config
  net: phylink: Use phy_caps_lookup for fixed-link configuration
  net: phy: drop phy_settings and the associated lookup helpers
  net: phylink: Add a mapping between MAC_CAPS and LINK_CAPS
  net: phylink: Convert capabilities to linkmodes using phy_caps
  net: phy: phy_caps: Allow getting an phy_interface's capabilities

 drivers/net/phy/Makefile     |   2 +-
 drivers/net/phy/phy-caps.h   |  63 +++++++
 drivers/net/phy/phy-core.c   | 253 ++-----------------------
 drivers/net/phy/phy.c        |  37 +---
 drivers/net/phy/phy_caps.c   | 347 +++++++++++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c |  13 +-
 drivers/net/phy/phylink.c    | 338 +++++++++-------------------------
 include/linux/ethtool.h      |   8 +
 include/linux/phy.h          |  15 --
 net/ethtool/common.c         |   1 +
 net/ethtool/common.h         |   7 -
 11 files changed, 540 insertions(+), 544 deletions(-)
 create mode 100644 drivers/net/phy/phy-caps.h
 create mode 100644 drivers/net/phy/phy_caps.c

--=20
2.48.1



