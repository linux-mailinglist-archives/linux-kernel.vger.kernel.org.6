Return-Path: <linux-kernel+bounces-340274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728BE9870C3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA00280D84
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8261AC439;
	Thu, 26 Sep 2024 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="OxXyz8/L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OjlRWMhX"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61652745C;
	Thu, 26 Sep 2024 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727344446; cv=none; b=LqodWbeCsUYcFUJsd+/GRAzFLcLgLNA5ewYUDw6shirVtHjAadKxD+9ujDRYsUXKxZhJC6rDt44aedIQL9wR2rlDjUbBX9RL3LXGOspSQTM8QYwI8GEaPzSgmmw8L6HAa0UIpV2gQwA3GNyC9MUJIeLvTC0y3wAyg1S7IRGXFTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727344446; c=relaxed/simple;
	bh=9m0ce/rF46/JT3BE6a/S7VEkZgt3lat6EtXZbZEhIcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tjSfDTDsFlVgLvP8pi7DfMF6AIcaCW9uzqYuatjSj8P9/Wj96zlCoiHbHqfwnlc4J4cKsKz2kyqB8jqHNHUXMZVjJh1Ywsxs2lYYoUuekZgBlZJr7+4AeWaNe9o9u+F72PB+oid5jZLsR6CH4epkHb9/pLLqI6INMuSjAzlvBGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=OxXyz8/L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OjlRWMhX; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 949F01140287;
	Thu, 26 Sep 2024 05:54:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 26 Sep 2024 05:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1727344443; x=1727430843; bh=ph2+HLVpjUvZbza6d9jwG
	hezL49XRfepl+UhJW96y+o=; b=OxXyz8/LJQuzsCHCdDbl/0VCI1PxMXmkD1bTS
	iEkawgF+4BPXpMH/1tPxckuH5H9T3houi0JUvP3axsNX7Li/FFEDZYgJermBwplv
	7eaQEUnnv/z7Yu5G6S53sXZoEL58JcbTe8Syb1Lu3f7bfG2XSMvJRBH00R8lN+hz
	dYjKZwcrx/53HfILJC5yj3jUZObq2oet47MCVOu8r3LJDwobqAvQ67Vy8ZCpvI1G
	Z+jbqAnMwtGMqkrb4CcCggOE3eMSCdcCqz3hkyVZOAvfZ92DgYzMLqf2X2YNyJdi
	RoeIZxYzHDZ9FAj5rlJ2lekXt3f2AH2/oBHLUTheLHMUCe8Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727344443; x=1727430843; bh=ph2+HLVpjUvZbza6d9jwGhezL49X
	Rfepl+UhJW96y+o=; b=OjlRWMhXYsvQuZ5tywHKJWBb6xvl37gEE2DNpAWpelpD
	sqe/e/fGzYADvln46aFdtuFT37aVk3aFCwSfD+7VexUD5ZoT7t9N7v4kXH0c99Hq
	buVZUiiYKwgVEn7/KyCcbqWwbd1WZGU3XVVR9HZj+hEvnd8ltl36oscTz00LIgAF
	xH42X+bIfWyGLnPusO2yoF83AB1AJqovJuSfEscMAxL9Jk7YqptWfGySRrNmY5am
	NppbgMOfpcL8A+cCfaXSHUCT1FwQe3tTLhb787Vx8Px0FrmXtWO48cZPwUTPSA3M
	NP76D7L1WaV2yra9xlZLVMyIWeqWGfZ2bWKl17rQfQ==
X-ME-Sender: <xms:Oy_1ZoVKiK0bSdWeo2XfKhdi-5fF1ohIAbq59pHWUNlfGBvMCUyoyA>
    <xme:Oy_1ZslUjab5N6cl_GAHU20_6pvXTprd7TYYfTTbS04TG1y6HXclTnR_Jd-OYDRA1
    kjKE3DCx1lQ7j3Y5bA>
X-ME-Received: <xmr:Oy_1ZsYHBlNQg1Vus1oIgHB22iTqU19bbTcxR8sAq4lNt4tfIBTaZs03VCbwZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdf
    uceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthf
    duudekffefkeeiffdttddvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvsh
    druggvvhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhinhhtvg
    hlrdgtohhmpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprhgt
    phhtthhopegtohhrvghnthhinhdrtghhrghrhiesghhmrghilhdrtghomhdprhgtphhtth
    hopehsuhhpvghrmhdusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkvgeslhhj
    ohhnvghsrdguvghv
X-ME-Proxy: <xmx:Oy_1ZnWf-Oc6Xt5J57rcWm97hw23CbvkRweZ6s5HUq7RFZNQGe5qOA>
    <xmx:Oy_1ZinHPtaekTuIo93g1lQh1cQ8MLpOnAPrtzKSl33nl54zjt8Gvg>
    <xmx:Oy_1Zsc-XEjL-HrahQ2GREt08MRMpZa6IhvbLFHDIHh0J93UUzAY9Q>
    <xmx:Oy_1ZkEWv5OFw0btjUgprDGRMt19ppjz6Tk2mZM3ggwRa5RtvtXHEw>
    <xmx:Oy_1ZgZb4W9f9OfO4u33rgTrZLwhjkZWkHfoa3xhQv_isx_7D6MPsBxu>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 05:53:59 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	corentin.chary@gmail.com,
	superm1@kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 0/3] platfom/x86: asus-wmi: revert ROG Ally quirks
Date: Thu, 26 Sep 2024 21:53:41 +1200
Message-ID: <20240926095344.1291013-1-luke@ljones.dev>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ASUS ROG Ally (and Ally X) quirks that I added over the last year
are not required. I worked with ASUS to pinpoint the exact cause of
the original issue (MCU USB dev missing every second resume) and the
result is a new MCU firmware which will be released on approx 16/10/24.

All users should update to MCU FW as soon as released to:
- Ally 1: v319
- Ally X: v313

Luke D. Jones (3):
  Revert "platform/x86: asus-wmi: ROG Ally increase wait time, allow MCU
    powersave"
  Revert "platform/x86: asus-wmi: disable USB0 hub on ROG Ally before
    suspend"
  platfom/x86: asus-wmi: cleanup after Ally quirk reverts

 drivers/platform/x86/asus-wmi.c | 39 +--------------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

-- 
2.46.1


