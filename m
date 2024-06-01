Return-Path: <linux-kernel+bounces-198051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B7F8D72CF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 01:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79A0CB21333
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 23:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8B5481B4;
	Sat,  1 Jun 2024 23:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="MB0F1Uk0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qVa8p/0U"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2082A51C42
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 23:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717285436; cv=none; b=b0ZDwkG5XGJkQJWwRpCeUC1ni5TqC3RwMWDqXHs+7WWs8HQ8fKyiZTEUBMDVEmlJrNXGNWKMsxqI2r439eMHF9PXRdv3g+dvZWASpfwVNgOMoAsYeL9rW3xqdwNTIjiZrsFhcfIuWODuIa61WsVr9uApM4MswZXU/k2bp0uZ6DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717285436; c=relaxed/simple;
	bh=wTjgxAVKbRa8rMO8lS4n3+d0PqweBxJsFbtWIKfF/ko=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TXAsI7HyoumqLKTWKor1nGla1TmOBprlkagazyagDwThpKEpi6QGVF8ZgetG4ZTo4C4JRNPEpiy7TBRPXJab7W2fsPRCXSdWcjJMXFKUEDDkCS3Z2KdN8i9IjN1SmqysZOf5c3yvEQ67O7pcMsLV+O1KN6wIXxgp/+hfI8JrrvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=MB0F1Uk0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qVa8p/0U; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2D6B611400E5;
	Sat,  1 Jun 2024 19:43:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 01 Jun 2024 19:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1717285433; x=1717371833; bh=v2e2eni5tWu94yQdh4Ilz
	6sySnlVOXpS2VomxvN/EeI=; b=MB0F1Uk0WqKbNj/QXGmcs+zEOK/+JBJiNyjh3
	yNakPLHUn8BJDBSPJIP/UF7fwfPEeuy38aG/rg1/Sh9B9isw1aKkyj927TArjix5
	FOF7YDoTNUtM+xRY4E6fAFo6dTE0XAY8TPvyS8If5yuNZiIkk+SzQkCLTylJ1IfG
	iyfCYUJimYkkrsL4cTiZNYm2mRxaL6XjZ69AoltWds05gFfawZYG/bYHt7bN7LfS
	q1VqlhJFitdfkAX3bCmhGwtaKzxzOesBlFUS+geF5kwVkojUv3mJffNNWMWLxwkU
	uoF81ayoEpOOT9TFrSP9Hbp2vFkNSlLBcMxnS33PwnEX3Ketg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1717285433; x=1717371833; bh=v2e2eni5tWu94yQdh4Ilz6sySnlVOXpS2Vo
	mxvN/EeI=; b=qVa8p/0UwnPtAU4f514YvvBXu1Xiy1+J0oEuZUmt/cMOhLSxDwm
	j0DACbNd2S429JiIZWoUKaTh3E5kT1hayqvMYNlX4s4e/Ql31YJ9Hz9GQ/nH5tgc
	ee3Uvl2x5Sg2XcFJIe3hpwn0FdbhkCIRbeyki8eEACiOdVxkdHfJSd31LpOxefKk
	HrGjjD25VUnUoguzfjQFLZJgGHoKyGaNJNj15wNsnfc37+uQji13+z3X9/b8cvh7
	W+NzKiCiq+4qGtMCSWUXynHAeLeV0D6i1KY+CkUS/kNqB0aNewqvb2n0xekd/pFu
	kRyGsmIQ6KTPZ53mBaey3o2VMALcP6Z2Srg==
X-ME-Sender: <xms:OLJbZuoIIHBAQox4ItQIJXlofM3SCM0lJnfzQM_bdWsdQZBk9H75CQ>
    <xme:OLJbZsojVPH5DJvPmkV3VwlYM5tIObkTC1ZhzhUVzWETakRw0ranGBd9dczwCIH9j
    cjw_s_csvCwqFvDJIs>
X-ME-Received: <xmr:OLJbZjMRk3oIWd6YoYvlsXPcAVs-qUbVJYxJGdoM4mbXIPRe9g5Z6jmc6jylo9s0_x7tjqVIQlR-h7vn0BZOWQ1l-4Y7OvSF2Hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekledgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehttdertd
    dttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeetfeeiteefve
    egvdfggeffheetleejkeekleeugeffffdtgfdtteetkeevvddvgfenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:OLJbZt6Q-augbRQ3Ga-cVlHi8WjirZayl1tbLPyPyiYz7IQQLUCA5g>
    <xmx:OLJbZt7mVb6gLR1onru4voRi_c3NGOk8ZVWjSC4uwW8Ij9YGgu6GHQ>
    <xmx:OLJbZthcjREv2xzBq1LBNPan8feQiHmQulViYWBjpZ6YCoEafgW-fQ>
    <xmx:OLJbZn4pWNRxeCymAb3syX11rPvdtdzNqqoGm4kJZd0inUsoktalsA>
    <xmx:ObJbZnmFw4gS19Tl8vn-1xQH3PeXTxPdc9aOKU4yItRjIQlqmVgf77px>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Jun 2024 19:43:51 -0400 (EDT)
Date: Sun, 2 Jun 2024 08:43:50 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: [GIT PULL] firewire fixes for v6.10-rc1
Message-ID: <20240601234350.GA424664@workstation.local>
Mail-Followup-To: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please apply a single trivial patch from FireWire subsystem to your tree.

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.10-rc1

for you to fetch changes up to f94b77709e82242c1101e59a90a7807455c4ab2a:

  firewire: add missing MODULE_DESCRIPTION() to test modules (2024-05-27 07:34:58 +0900)

----------------------------------------------------------------
firewire fixes for 6.10-rc1

After merging a commit 1fffe7a34c89 ("script: modpost: emit a warning when
the description is missing"), MODULE_DESCRIPTOR seems to be mandatory for
kernel modules. In FireWire subsystem, the most of practical kernel modules
have the field, while KUnit test modules do not. A single patch is applied
to fix them.

----------------------------------------------------------------
Jeff Johnson (1):
      firewire: add missing MODULE_DESCRIPTION() to test modules

 drivers/firewire/packet-serdes-test.c | 1 +
 drivers/firewire/uapi-test.c          | 1 +
 2 files changed, 2 insertions(+)


Regards

Takashi Sakamoto

