Return-Path: <linux-kernel+bounces-540484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EA0A4B13B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 12:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A913B2D0E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 11:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8AE1DF749;
	Sun,  2 Mar 2025 11:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="ijsAh4yD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Thwnl+G1"
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7461B6CFE
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740915535; cv=none; b=An/kmM7ISinZ+8fY0K8IY+gJErjbtv98C4JImNlsHPvw9ICHx/BlS36AX+cQHAgvq1BV95Mmb760qtGH9Ln+9CIbyM2HWbnWFwO9ttN3c6TC7Kz3T/YUxiPOShtQxsFF0G+HCKKqLq7ptmcfseNiiTlBUavY2nM5Wt6daL0Hhtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740915535; c=relaxed/simple;
	bh=AKKUuqE+qvGHOcveL7+kNvIIz2UbbpPTXNWMm9P1Xik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b32HhM+LGkZ2IWSFF8NQudV8jo/vXaGPgtRwB1xoEnEJOtIUJ4q02Ln6wCj22aoq1zZgYK9jTW1ZBFAYX2oWr5ZlAtVwCbN/HJqcQ1PfsgTcwXuGwS+GU/i3TewnO03AK2PZ+Fsj/iuW+gDpWVn9phiHSFp4m1ZeOZF7EI5K/X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=ijsAh4yD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Thwnl+G1; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 0A33C1140132;
	Sun,  2 Mar 2025 06:38:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sun, 02 Mar 2025 06:38:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1740915531; x=1741001931; bh=Z7Y/TKSfcK
	jLz+8BY7qiShSlDpuTu6NU1rFgchBJCvQ=; b=ijsAh4yDeENoiS+vJz+z5+exXs
	FT3TIu9GqgbOBXZRb73E4TcQb2FaEnRnT30r1t5J8TRg2xNk7Lk7he3HsL1IvX8E
	mANGlNaQHKpHmervHmqafCY3AdiNwS2lSk43baVh/XzczvQ2o/5LL2Y/GoGI8kg1
	S6p9Qm1UzE0dUPDAwX2GtsRWXufhZk1W8E7Cxkoey/K5Rb/jnRiyFYuFfCoq99OZ
	5mOQJ+khSrIyDKzFUxXhwwfAxucD40rbyXeiHckkOq6UwOevduaQ0c+ZhVV7WOLm
	zaThmwkc2kT54/C/EerCOmVBC6wuEJbWfl249QRwRbzlFYHbfEPCC+NBBs5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740915531; x=1741001931; bh=Z7Y/TKSfcKjLz+8BY7qiShSlDpuTu6NU1rF
	gchBJCvQ=; b=Thwnl+G1wJ/fJM/Fx1BsZ25YSJGThHZa1pT03BGuEpPW5a40qzy
	He1KBq/xDmBXtq5hwHrSTSYK3J8k1lCJCJ3bggctBvq/+2WLy36dYvpHrCNCUt3b
	eycPB+vYjcFgvKuIIPM0vkKHWfMv5t5zouG2z9zuACm3fGywKZSZ16K0TN0wLI1s
	2LAuftua4Zm2/TPyIa9PKExM52pXu9nty60NaJPsFfRV37tHe7M25sq+boClscAI
	5IHMBvugl+xPn/QjpyWOzLtkB59OdW2P6TURlEpRMG1ZiS1pQH2L3WfeyMtsWdcD
	lB5UlNYCip/4ndnjQBaFM4gaPHFfr0njrRA==
X-ME-Sender: <xms:S0PEZyHLFxfCdY8wN8-nu41tgFU3C4wFlxBtvivA7EqcfEmpr_tZCg>
    <xme:S0PEZzU_A15PH_ta0tbr_WRnZCwBCJPo5vPHPlZbOegBPO6mWmSCkZoecDh9L5ZQw
    aNQ6np296170oORoRU>
X-ME-Received: <xmr:S0PEZ8LfZyS478PA4J4OCbaz3M4ndGGlpby7rtYE0-jH9bNDcQqr99ssQnGyaZcylIlT5GpgrUEkv6VDs2tYrqYGLDmf0MYKDsT_qVna6vQaOB-Uzz7XtC6lFuMAdJs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelieduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgggfestdekredtredttdenucfhrhhomhepufhvvghnucfrvghtvghruceoshhv
    vghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrhhnpeduieeihfegte
    fgkedtieffkefhjeegieekffdtgffhgeevgeekgeejteeuffdvieenucffohhmrghinhep
    ghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdguvghvpdhnsggprhgtphhtthho
    peegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsohgtsehlihhsthhsrdhlih
    hnuhigrdguvghvpdhrtghpthhtoheprghsrghhiheslhhishhtshdrlhhinhhugidruggv
    vhdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfh
    hrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:S0PEZ8H9_ZqYgeGp__YKoPT_aiX2gi4ga2cJe79FR64V2L54l7g7og>
    <xmx:S0PEZ4U1ULgt9SaJPW4O3j0KDik3IYjQh8URDSO_iCgPAmpfupeHCw>
    <xmx:S0PEZ_Pjvrf0sLpbu2zLoF-AsWV2UL_g463u2E8OFGClcQ5T23MmXQ>
    <xmx:S0PEZ_3xtA1gDzJD_CFlchcgM1Ni_Nve8l8DCZfG7lALpJsZ960eCQ>
    <xmx:S0PEZ2zjIZjNbN_UqBpiXntYgfHxkMctUo2js0cbu_bbqjge51_SsAU3>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Mar 2025 06:38:50 -0500 (EST)
From: Sven Peter <sven@svenpeter.dev>
To: soc@lists.linux.dev
Cc: asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Apple SoC RTKit IPC library updates for v6.15
Date: Sun,  2 Mar 2025 12:38:42 +0100
Message-Id: <20250302113842.58092-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please merge these Apple SoC RTKit IPC library updates for v6.15.
This batch includes a bunch of minor improvements and bugfixes mostly
required for our downstream drivers (e.g. DCP) which we are planning to
upstream in the next months.
There's one API change which requires a single line adjustment to our
NVMe driver as well which has been reviewed by a NVMe maintainer.


Best,


Sven

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://github.com/AsahiLinux/linux.git tags/asahi-soc-rtkit-6.15

for you to fetch changes up to e210227f0259d2666cc41b28ed1b7b0b0a99ed4d:

  soc: apple: rtkit: Cut syslog messages after the first '\0' (2025-02-28 21:36:45 +0000)

----------------------------------------------------------------
Apple SoC RTKit IPC library updates for 6.15:

- Additional logging for errors
- A few minor improvements and bugfixes required for drivers that are
  yet to be upstreamed

----------------------------------------------------------------
Asahi Lina (2):
      soc: apple: rtkit: Check & log more failures
      soc: apple: rtkit: Pass the crashlog to the crashed() callback

Harshit Mogalapalli (1):
      soc: apple: rtkit: Fix use-after-free in apple_rtkit_crashlog_rx()

Hector Martin (1):
      soc: apple: rtkit: Implement OSLog buffers properly

Janne Grunau (3):
      soc: apple: rtkit: Add and use PWR_STATE_INIT instead of _ON
      soc: apple: rtkit: Use high prio work queue
      soc: apple: rtkit: Cut syslog messages after the first '\0'

 drivers/nvme/host/apple.c          |   2 +-
 drivers/soc/apple/rtkit-internal.h |   1 +
 drivers/soc/apple/rtkit.c          | 112 +++++++++++++++++++++++++------------
 include/linux/soc/apple/rtkit.h    |   2 +-
 4 files changed, 78 insertions(+), 39 deletions(-)

