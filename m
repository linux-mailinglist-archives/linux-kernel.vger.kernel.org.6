Return-Path: <linux-kernel+bounces-519897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 983DBA3A34B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD911712F4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8C526F45C;
	Tue, 18 Feb 2025 16:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="icvSl3Xn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A5je+2XK"
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D1E26FA40;
	Tue, 18 Feb 2025 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897791; cv=none; b=aXetw+GUkORCtXchJCr3wOHqEcUgt5SWVagwPDIoJfTjH+vglR084XMdwe4G7Fdui9cMOVQrP0tvDqyPrflGz8pGgqQklM5+sc+OT3rs0X6QGJcRijQ6TrSuzBuKpuRA70qyni1wdufK6hnbGEApoGOZDicuSON+nYgFQnVkOak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897791; c=relaxed/simple;
	bh=wN/cRRoggZu1aXP+k05mu+rVjlUugGWW4wdqZg5XzlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XD4xTuoIl56ByO91G6++Z3YV8jARXER9PMtkJqOlWOlMxFJlyqwv479Sz7f3Z6KGE7kpIsMNrsp4m89zQnyZfIfFGxonRtT5StxjpWzUh4imAJQ8ZODVxITg7J6HyUe+d/QCEhn2dfCEausvhqaNNTKB6XQQLvTXNDnP3c8O0ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=icvSl3Xn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A5je+2XK; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1D0B12540135;
	Tue, 18 Feb 2025 11:56:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 18 Feb 2025 11:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1739897788; x=1739984188; bh=kcVd4OhBl6QFD1xyeheTB76pxiiwWJs9
	iW8l8/CM7SI=; b=icvSl3XnvftL/NNUY29qomne5qMgfkYZt8wMlD9gq058w9ld
	c4uhTBeL4edDmaZYFbdunBT1pL7FY0RKVvfM10Or3w89c6NBhIIKK+mh8Fj0tqYG
	giUawLFi99hEE+JOwUm6RFF1KHYYZzZqf+3r5js9T9myH5A3mfHz6uFz72NAaROA
	xNIvyTTccIFTVJ+xk4e9e1i99nmjvpXSUe+gi1Nt+a8lowKGqfF2Em4F4eyZcsKS
	GNTa5ZxkefnP/XCfYy+JdQqd1Ex1Z/BAzGiAgw7szu6/j2NdLZohNceNFoPmQZFH
	T8vNwFuk5ACCAOHbSzMzaoySza2MQl6iRwWG2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739897788; x=
	1739984188; bh=kcVd4OhBl6QFD1xyeheTB76pxiiwWJs9iW8l8/CM7SI=; b=A
	5je+2XKOUDg1axCm7tUPQBAQyadz0TWCOdEzfFVg4pLYWkLFrc97C/SHYP4AUcpG
	5FUoVzMGLkYFWeNab+8slJ4ND59IhriLhmQz1ivgTOv0w2PO1omifWHf92hQmQok
	qGhCwFOxtc3AUrpihsAzsDI3IEv8FT0CQ6ZDb1X+Hz9KYSBqIhANRlSKyIq4cHcL
	91LargTyQDt21Uu+HbkCJvlkWWMyTDfurazynLN/3IWOKIRAmTRVfkWIS8xPNdq+
	Feak0Sz0Va4hyoHvk7J4A0b2s0KSXIaQf2AJRXbnrPbLYM1cwsrRYkmEXRm/VIer
	K7LyfO104Z4g4/pj78k6w==
X-ME-Sender: <xms:vLu0Z0fYI7c_7aguukxwy7hmui40Q4LVPUrcDXGc2M7Nb83A73no8g>
    <xme:vLu0Z2P8_Gk-TUHZdjXMSr2R9mnw6F8hyl2kQOSr_871cxphVf6ARDsdqXFmukftj
    O91ETVJmQbBv-AMimA>
X-ME-Received: <xmr:vLu0Z1jAHOgDHuvghuUuGrJeRUm_625kgaDTzl9cnabqBhkaT6CAY0CtNQcuh4TcMJe818grpCAg8jMfKWVa2Bv7nh4uK1QgTUdEA9HKcRUT0B1MyM2xR7iS_knzEHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepufhvvghnucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrd
    guvghvqeenucggtffrrghtthgvrhhnpeegieehffethffhffefhfehkeevleevieetfeeg
    keehhfeifffgheehieejheeihfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvhdpnhgspghrtghp
    thhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjsehjrghnnhgruh
    drnhgvthdprhgtphhtthhopegrlhihshhsrgesrhhoshgvnhiifigvihhgrdhiohdprhgt
    phhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodguth
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehnvggrlhesghhomhhprgdruggvvhdprhgtphhtthhopehtoh
    ifihhntghhvghnmhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhvvghnsehsvhgv
    nhhpvghtvghrrdguvghvpdhrtghpthhtoheprghsrghhiheslhhishhtshdrlhhinhhugi
    druggvvh
X-ME-Proxy: <xmx:vLu0Z59hEI9YKaEODgQN5vtSiKpqMGA9YIXHA4jm7JFtp_QNTZ1-GQ>
    <xmx:vLu0Zwsvhr6XUY9yrP9yQFEhRczd7X-Gqzs6cpOXOFHLDLKgWqjzqQ>
    <xmx:vLu0ZwGGcBbVHgLg8KcEOvLSxWS3RjCATnjeaDIew666c1Z59je5rw>
    <xmx:vLu0Z_OF1386C00OpnT-Q3KlHuUYRYDe4vrAvwk2Eo2cF_X2OWuyLw>
    <xmx:vLu0ZxHpjJ2XmT1Yd1zt4xFymjIAf7FhBDaHe-q5d7ZifjDmxHggIzMW>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 11:56:26 -0500 (EST)
From: Sven Peter <sven@svenpeter.dev>
To: Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neal Gompa <neal@gompa.dev>,
	Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@svenpeter.dev>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH asahi-soc/dt] arm64: dts: apple: t7000: Add missing CPU p-state 7 for J96 and J97
Date: Tue, 18 Feb 2025 17:56:15 +0100
Message-Id: <173989773060.49326.7671492051197942178.b4-ty@svenpeter.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250217-mini4-cpufreq-v1-1-8974e90dd806@gmail.com>
References: <20250217-mini4-cpufreq-v1-1-8974e90dd806@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 17 Feb 2025 14:10:05 +0800, Nick Chan wrote:
> Add missing CPU p-state 7 @ 1512 MHz for iPad mini 4.
> 
> 

Applied, thanks!

[1/1] arm64: dts: apple: t7000: Add missing CPU p-state 7 for J96 and J97
      commit: 97aeb6507356c72d87fd93f45705d3f4b1a05d14

Best regards,
-- 
Sven Peter <sven@svenpeter.dev>

