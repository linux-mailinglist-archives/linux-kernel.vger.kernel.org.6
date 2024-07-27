Return-Path: <linux-kernel+bounces-263944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3EF93DCFB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 03:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9218D1C230EE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 01:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4BD1C36;
	Sat, 27 Jul 2024 01:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="BVc2VNAV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qgPEWRUz"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7949410FA
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 01:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722045115; cv=none; b=HU/bunD4WqZJWOkKhA6A+zgM6D15A/bJazN6MeQC7WLE/f1bC8Gf0vhDLZgSwo/T48SVe7oQUB4ydcwKdq0R8ijDQsACE5TCWfjUVrXuR6ZrkLNYzjp7HyF6pQVNJwr5rOCTNDqw8eKOHDpelPfu5uufZvGQEaYS5BZBKGCyFlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722045115; c=relaxed/simple;
	bh=AwnHIGb10lVf7ldP3NsFtoEbnXCFL7vOZ/2SvTDbrwE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N1ttj8Se9tuP27dG+ffVXpxX0ftj0dUy+OEbrl2bDX5MU71vwv3XCL5/2/vrDN6UNQAzJoznyZ/d4ZgnPvOt4Sp7DcMgpbBEo/uLkWAgGIds0lvT08nknJcj1jVccAZpHC0+ImMJOicCkS21HzZZuT0JB3ty0Slo9up2CXaXnvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=BVc2VNAV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qgPEWRUz; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 89449114015C;
	Fri, 26 Jul 2024 21:51:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 26 Jul 2024 21:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1722045112; x=1722131512; bh=5LgcTsMaCPNRlo2WOdOxJ
	21YilJNtO6i9Oig6aCr06Y=; b=BVc2VNAVOksln+s73BVhjTfWsvENSAwtfoDl3
	sE+xIlUTIeEOCpq+YS59PqBiYIR3a4m2g9aUGdQBsncmDMoAsrhtbkpQbDLWPCrX
	+s18oqobznnPk4kXhxDJLFlJQwbt7LvFYah94Bv6FhUscWZcXn4TS6mGhM4He8+M
	VE7RvhLpAKLMkr5DbjzEvuQaSXQBS+7sPOdfUYZJ7DygzNSUPL+HeMfIcYh/VyaY
	D2idK3jC+Iw3cSSt1c6bWWAMctB+42ezhYta6KLmRZFaPOsNUO/Ro9EHXFFQWzDo
	x9I41wt1Zr3afQZlgEXxM7FdIvNZAuJG5BqRQFwFmDROw9XpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1722045112; x=1722131512; bh=5LgcTsMaCPNRlo2WOdOxJ21YilJNtO6i9Oi
	g6aCr06Y=; b=qgPEWRUzOAQSNGxidgsLhodNu0BU3qZW0vkYKU1fckscXP5bnTS
	DVU3Rxr42kJxJtfiLzxbH2z3HMh+dPz707P50oDEBl8pL0iZZ5Hu3Js4g589D6dx
	Hzy5GC36bqXlrsCtz/TquPERTI2lz5cKtakhMM75GMyl4nue+ZTgIIEBw2Kh6ppE
	/syZJ14aQn3wZRozSKigOhuc5AR+wXjm/xcM0JkT5Sj19lMYbW7s3F7a0csBOiuC
	5YSwWpNPrLfCdsLKE1cmuvaWK/7fdEZVJOKN8ZwA9obGuE631MDkmXUrvzpneBuu
	7Ym11vVfoGHl+aBKJnwqxLpYFoY5VR3GYvw==
X-ME-Sender: <xms:uFKkZsCZ0VcGOsbUV3zjxyz5cEuhhqZUzxACOvOitdl9cnG5iBwu2g>
    <xme:uFKkZugSVzkq9tAjd8DXBc_PJwAav3oQIJNWm1QVHCkFFhLhcQyOW3N4sE01JDh6i
    r4xMbefStGM-7yBge0>
X-ME-Received: <xmr:uFKkZvnUTzqmeGW9BoBA892njE8sPv0FVnUDRB4ySqI_s9YCNb1n88yNqzuGDgt1ufGHw4ZM5y6rizfyZD_79aKpwlQo3TeEstU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieeigdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkgggtugesthdtredttd
    dtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepteefieetfeevge
    dvgfegffehteeljeekkeelueegfffftdfgtdetteekvedvvdfgnecuffhomhgrihhnpehk
    vghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgt
    phhtthhopedt
X-ME-Proxy: <xmx:uFKkZizQxBUThvAqfu-N3c5Cgx7U79hGUsr9n9kAIneK-elN1abOhg>
    <xmx:uFKkZhTvp2RogDOpl-lSRGT4f8TKhJW0qRTocpLNXyCrpIDQqDsMFA>
    <xmx:uFKkZtZfo_tbJeqiPw6LmGZ77qHNzmusEL4TSQYgn0ETPV_aMKAstQ>
    <xmx:uFKkZqSjj0zz6-lxwLdQobgko8DM2YQytS4QUvab7FovdzO_bqfpFg>
    <xmx:uFKkZqIJBzezJdv48fhLd8eaHpnXhXYGD5DIQKsm5eGO9mZyJOQ_9mgZ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jul 2024 21:51:49 -0400 (EDT)
Date: Sat, 27 Jul 2024 10:51:47 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	tiwai@suse.de, edmund.raile@proton.me
Subject: [GIT PULL] firewire fixes for v6.11-rc1
Message-ID: <20240727015147.GA163457@workstation.local>
Mail-Followup-To: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	tiwai@suse.de, edmund.raile@proton.me
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please apply the following changes for v6.11 kernel to fix some
regressions appended to v6.10 kernel. They include the change of sound
subsystem and I have got an ack of sound subsystem maintainer.


The following changes since commit 06dcc4c9baa9e92896f00d02ffa760c0988b4371:

  firewire: core: move copy_port_status() helper function to TP_fast_assign() block (2024-07-12 14:34:12 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.11-rc1

for you to fetch changes up to c1839501fe3e67d98635f159dba8b170d08f6521:

  ALSA: firewire-lib: fix wrong value as length of header for CIP_NO_HEADER case (2024-07-27 10:28:36 +0900)

----------------------------------------------------------------
firewire fixes for 6.11-rc1

Two commits are included to fix some regressions. These commits should also
be applied to the v6.10 kernel as well.

The recent integration of compiler collections introduced the technology
to check flexible array length at runtime by providing proper annotations.
In v6.10 kernel, a patch was merged into firewire subsystem to utilize it,
however the annotation was inadequate. There is also the related change for
the flexible array in sound subsystem, but it causes a regression where
the data in the payload of isochronous packet is incorrect for some
devices. These bugs are now fixed.

----------------------------------------------------------------
Takashi Sakamoto (2):
      Revert "firewire: Annotate struct fw_iso_packet with __counted_by()"
      ALSA: firewire-lib: fix wrong value as length of header for CIP_NO_HEADER case

 include/linux/firewire.h      | 5 ++---
 sound/firewire/amdtp-stream.c | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)


Thanks

Takashi Sakamoto

