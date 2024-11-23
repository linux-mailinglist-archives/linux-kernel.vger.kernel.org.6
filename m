Return-Path: <linux-kernel+bounces-418978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FF89D67FD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 08:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ECAB1611C4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 07:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CA215B97D;
	Sat, 23 Nov 2024 07:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Jy+u+WtZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AfYneGfg"
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE30320E3
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732345994; cv=none; b=Hhm/wUDG1AsD+Xb2kanxU3I2K3xHObCGv6bvplIvVxZtsn031eczi3ACm1FwsmEP19vJGYfzj2O4PS+d1vIUIN8NlOCA/uxPjzFABiBxYZVnXq6cTF6C1JtPFFwD1CBl0/wkE4XGS8PzxIyoyTNuijjqWXSca6dRdc4s16ry0Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732345994; c=relaxed/simple;
	bh=fVheYrulJKEkYyRN1Unrr/oACThTD3uF9+LHtgL/lhk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Mik2oKuHb85kJW15ZmdstaL/Py+Vf/mGmGkS3kPNQI8vs1HjU274MSsKKBSeSoUf2t3BdTmSY6a4H4oYEnAE3gYQrtIEiDKm7RixJkIBG3eyEBISTullLCynsUblpgemDH4YhVcdYKctzmiK5v19j6wv9hYT2+kRm2ghigJMce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Jy+u+WtZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AfYneGfg; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C323511401B8;
	Sat, 23 Nov 2024 02:13:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sat, 23 Nov 2024 02:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1732345990; x=1732432390; bh=r8Jk4SM007zzUTmLbATlA
	oJXOvMWyvGE29KVLkEPgKA=; b=Jy+u+WtZC6qJ7jFH1zvLZ1HlJCfQsizLR+gp7
	7jZveAQpzuqqBhG5HD/jlCn3qRmuUvGOrXGcfRxjJVct4Y3YrXyYmW2+t0lxFn7J
	bNiXT2uzLj2EBLlHU/EFh0zHPNQ+BuFs0mRDeE9qYPuhneq4B5IkdKcJGhtXUF0D
	lggEE/w4BOIjeEqDBbeGeIEBSdlxK/sJ2+Cs7wCD+FxPGcf+zVBjexz3OSFCuivn
	JbIV4DLCwrV2HloOINjNYrEsSi+hTGu8YY8uykzcJlKmB7zxUFXG9LomucQa6P1m
	iKyWiJFEYpFzCFvLNLCmEhUKPVhUPUxbwieh08taV2aWMMThQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732345990; x=
	1732432390; bh=r8Jk4SM007zzUTmLbATlAoJXOvMWyvGE29KVLkEPgKA=; b=A
	fYneGfgS13w4johm7Zb9mGe4J1k9xesf1rtPS5od8r5EzkKF/JmPvLbJyBVrGzpo
	SOOfUBr2n/W1xlW01MbzG6vsrek6FNqO4W1Hk34USAFHMpe1QF6QFzDzhcWJoSSG
	OYHfuPzWZpVBiPl67W6bqRXmAKjQuCPh9eGcE0VwJMT38ihfYo0DvssJT1rZAOGW
	yloQRZ9yD9OXRVEAwU0M70xxQzd2DG0sl92pmCzPAHWqb+FTHYYbP69FWsxsaSJa
	BOEYj4EIJe/8XFynI1ODbc2Tn3fslcZnPEB9Z7LT3pcmIrxQ+gE/BHYIVNGlE3jL
	e3vrQwFBYlrBZ8bw7QJZQ==
X-ME-Sender: <xms:hoBBZ4ApWlMn0Akth3fqEsKM2iIvPi4tmDN1xbQq987v3O2e0egk9g>
    <xme:hoBBZ6jHogjIvmloqr7kjfoJa0lACYv_2uL6oc8oc2GjNjHoGjtqq1OM674WQFtiB
    IXJzh3tN-IZXrcWQjE>
X-ME-Received: <xmr:hoBBZ7lK8KIz-MbWWvXRv6Yyfr4h7inBo5nS-5QbbcTX03XqZAbFGneicCZS0smB0vMI0X9VojwIciMojVkVootoufqBq4eSmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgedtgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfggtggusehttdertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohht
    ohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtth
    gvrhhnpeetfeeiteefveegvdfggeffheetleejkeekleeugeffffdtgfdtteetkeevvddv
    gfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggt
    hhhirdhjphdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigudefleegqdguvghvvghlsehlihhsthhsrdhsohhurhgtvghf
    ohhrghgvrdhnvght
X-ME-Proxy: <xmx:hoBBZ-xy4dg72mM4gvyqn1bo3hKauk_zP3wvjlyHQVmeFV8kffMmGw>
    <xmx:hoBBZ9S6EbuI545aj449wKck_ATG82-8lnJSD45nlBuK8pipameudg>
    <xmx:hoBBZ5agvSh96j1LEiY6Efgr7uWU007jRzGI5MGyjebAas2h6GlLkA>
    <xmx:hoBBZ2S16UfUIwNDn_WRJtEQTXq1lNiNMVm7JAnyS0r2GNodXZpl8g>
    <xmx:hoBBZ_dChUzOYINa_ULOeErJoLgsOq7i3I4FK5bl_BjNpuX-vILkK5bB>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Nov 2024 02:13:09 -0500 (EST)
Date: Sat, 23 Nov 2024 16:13:06 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: [GIT PULL] firewire updates for v6.13-rc1
Message-ID: <20241123071306.GA108525@workstation.local>
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

Please pull some updates for 6.13 from FireWire subsystem. The
development activity has been relatively quiet, so only a few
commits are included in this PR.

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-updates-6.13

for you to fetch changes up to 4752e8cde8344cb8673abdefe0dd74e9a2fe23ad:

  tools/firewire: Fix several incorrect format specifiers (2024-11-14 09:12:04 +0900)

----------------------------------------------------------------
firewire updates for v6.13

A few updates for the 6.13 kernel, including some typo corrections in the
software stack and some fixes for tools. Additionally, it includes a
change resulting from the deprecation of a kernel API in the PCI
subsystem.

----------------------------------------------------------------
Luo Yifan (1):
      tools/firewire: Fix several incorrect format specifiers

Philipp Stanner (1):
      firewire: ohci: Replace deprecated PCI functions

Shen Lichuan (1):
      firewire: Correct some typos

 drivers/firewire/core-topology.c |  2 +-
 drivers/firewire/core.h          |  2 +-
 drivers/firewire/ohci.c          | 11 +++++------
 tools/firewire/decode-fcp.c      |  2 +-
 tools/firewire/nosy-dump.c       |  6 +++---
 5 files changed, 11 insertions(+), 12 deletions(-)


Regards

Takashi Sakamoto

