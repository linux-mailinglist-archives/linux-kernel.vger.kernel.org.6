Return-Path: <linux-kernel+bounces-553353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC19A587F5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 20:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9CDA188D87B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1438217658;
	Sun,  9 Mar 2025 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="woALsv8F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ShV/1Lmm"
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1FD21766B
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741549813; cv=none; b=en/ed9/1qI20PiKz6JAq2BuLam0V/vfFgvz7PVkXztFr+eyqJDg8naix53GlCWfykEG/HMjbRwcOmDC/zY0wX+bHVkEL5Nl4RmllRNZ0RdcIYIlgopDs0izYuq/SDm4ehnDAWzB4kIx/YWsXhPshtFcaG/WKVyrZPOIUoby5cSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741549813; c=relaxed/simple;
	bh=mIMs4kZGAf5F0xT8WISzHivUr9nmNpowMUd72qt2bo8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jIYuyMxRwoqTJGjmObk+FLLq+uHI9v2dG92seb3noIPPyPusLUpU6eua/E2at/5EsUx5aD96HS3kistxma62JzKE3ZIvtOuK1vaoC3IW3opdz37Prkp7ag2KF+boAkEgkS1dQT9+4Z33jfJoItQbD0nZJXFR3QgfjhkuPTaoe50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=woALsv8F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ShV/1Lmm; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9BE011140126;
	Sun,  9 Mar 2025 15:50:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sun, 09 Mar 2025 15:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1741549810; x=1741636210; bh=DaUClHKbrw
	3O3VoC5TI5qZwqGGAi6KJugps1aNy905c=; b=woALsv8FyOgj8kYQA2rUo80QBC
	z2wp7bM167KITuyD9pzCV/pcoPNc8bjUNMgYWuqDDTjV8Biv+8kgxudPfJ1EEfzt
	0s9gDCspKHMaMsIXPhXFamWeN3097JBiDVTVttHowq46t2R0cxDDyr0jiXZcqmAn
	QYEZW9/6APuDw9tdviCJWHj5gnsglZkH2yFfZpgPFvdXkgCW9K0WnZIpvRPpebr/
	wXsQSfm6u0GnZJnozLlGdiKQQyWeeWamQC69E31gK6jY2vNcnu3VE7yPo4dvIjRA
	90Zc4eZR171B+vHBYpjR64VL6yk3XinD+fvcGTuhgVtNwOZfDqA0wqxV6uCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741549810; x=1741636210; bh=DaUClHKbrw3O3VoC5TI5qZwqGGAi6KJugps
	1aNy905c=; b=ShV/1LmmFrGPE6HYczmAX9GCGEss9pPdhLj2wSGtdu1mHlnPghe
	wX2YH+i0vmfcSxgwhVi8DmzYFHyQhzWa6HsZpjBU9EGi3hRYbMLQ1lgDpQJM+/Gc
	bwiHTMma1iebDwHx47PEMp9rwnBE9hz2wPtmyVpx2lf7kDRqnN9E7YbesJrjZKhb
	dvf5u3CuvJ2XV4jAQ0qtIXmRcOh0H2t2F2bqsrhS+k1v3A7HK9M3xq2YYFgFBysW
	BO7IWnDpZLSWRj8kVpcvkM1YZXDOsUTK/WyAfZ2ytzTyhvmp+GaKQZ7QMCDtP+16
	Ib+rPrnYifuFi/94rRsYZEpQBA62lGoyLNg==
X-ME-Sender: <xms:8vDNZ8q18oWNmIYj0GAuYMd8yGee5y_xdXmLyk7FPzjzeF0dT4WqzQ>
    <xme:8vDNZyr_2CG-UAxaCjdRC3E7zZgccatvH13yorIqCxrw16LDrvu6mEwkWMH_ogHZb
    k3OyWayBgK3ShiMfco>
X-ME-Received: <xmr:8vDNZxO5vPxSDic7Y4BBrc1UPBjqCFehqIqfwNPJ2NmxCd19CJOsORwbyb4kFtOvW6aKQpnEDKRb9rgcJ1NUZLAOabW4SN6h9xdXmhUCP0IZK6xA9B_FjJMbwvy6z5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudejfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgvthgvrhcuoehs
    vhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnhepudeiiefhge
    etgfektdeiffekhfejgeeikefftdfghfegveegkeegjeetueffvdeinecuffhomhgrihhn
    pehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvhdpnhgspghrtghpthht
    ohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhotgeslhhishhtshdrlh
    hinhhugidruggvvhdprhgtphhtthhopegrshgrhhhisehlihhsthhsrdhlihhnuhigrdgu
    vghvpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinh
    hfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8vDNZz5LCYcM-4Ppa7AOKDtq9eMw4qvkPyo7O6E5GGTjFOQrUg0CWw>
    <xmx:8vDNZ76B-jVf8fH8XvgGOXO04NF6RiEP9cuHhoqBvuqZzEIvRgRLcw>
    <xmx:8vDNZziOSOwVrP2G0OqvYplgvNaDUX78kx5xkWtOj8ycUg_EOVmVkA>
    <xmx:8vDNZ15v6OjduFyzo4Pi3I2viOjfp_9VVrBiCA9gNqPt5nRibJ6_fg>
    <xmx:8vDNZ-1LqTIRdsGedz1GOZetkVdp4JoVcWROu9GVApsj5VXiiW-Tzyhq>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Mar 2025 15:50:09 -0400 (EDT)
From: Sven Peter <sven@svenpeter.dev>
To: soc@lists.linux.dev
Cc: asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Apple SoC MAINTAINERS updates for v6.14 / arm/fixes
Date: Sun,  9 Mar 2025 20:49:26 +0100
Message-Id: <20250309194926.51824-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Arnd,

As briefly mentioned on IRC we also have updates for our section in the
MAINTAINERS file. We're adding Neal Gompa as a reviewer and I also picked
up a patch from November last year that got lost (ouch) which adds the files
for our SPI controller to make sure we're CC'ed for any patches.

Please note that this is based on 6.14-rc5 like your arm/fixes branch
since we would otherwise get a conflict with previous updates to MAINTAINERS.
Hope that works!


Best,

Sven


The following changes since commit 7eb172143d5508b4da468ed59ee857c6e5e01da6:

  Linux 6.14-rc5 (2025-03-02 11:48:20 -0800)

are available in the Git repository at:

  https://github.com/AsahiLinux/linux.git tags/asahi-soc-maintainers-6.14-fixes

for you to fetch changes up to 3a0d2facfa645ce2fca794a1105d0634ab722008:

  MAINTAINERS: Add myself (Neal Gompa) as a reviewer for ARM Apple support (2025-03-09 20:34:36 +0100)

----------------------------------------------------------------
Two updates to our ARM/APPLE MACHINE SUPPORT section in MAINTAINERS:

- Added Neal Gompa as reviewer
- Added the files for our SPI controller driver

----------------------------------------------------------------
Hector Martin (1):
      MAINTAINERS: Add apple-spi driver & binding files

Neal Gompa (1):
      MAINTAINERS: Add myself (Neal Gompa) as a reviewer for ARM Apple support

 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

