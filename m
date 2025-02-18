Return-Path: <linux-kernel+bounces-519916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0DCA3A38C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C0E3167225
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC95226FA7C;
	Tue, 18 Feb 2025 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="HB54p5z9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aOX2XuJu"
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8970F26FA6B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898340; cv=none; b=gkXMYGPXkO011L1/X4KrVqrsCyvm89CN9Hbe+kot3Q45RGzXihKb6GfcRthV1pQDaAbwBUJ/M3DP2ykM5IsQ8Ct4YO0yON8Jym0IsF5ljD6Cws9c2yaSO7MaaLS7zM0vtK2QYsSNYxys+tdSeU3hNcOh6C6S5QxrR0sT+wUxcQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898340; c=relaxed/simple;
	bh=HH5jTt+PzL7QYW0HvU2m67IKOxcIYGhud+2NfksA8hI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9mrEwye+9V25w/z6WjSpNHPhF4EJ2rRztKJ7OWkgOIJNC1BT0zE9n00x4QOpAgfwsMfHSL9bQDTlimzKqmVJoPOP/1H2EX6PbjlzmfLSy0kcoDo564NKI5hneP3kLiFyC0oL413grcTwnZ4UdO4L6AgbR4QbJyHkxScPwj0CJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=HB54p5z9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aOX2XuJu; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 6D37411401C8;
	Tue, 18 Feb 2025 12:05:37 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 18 Feb 2025 12:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1739898337; x=1739984737; bh=MREDDKhkSsDOa7xmYAOWCQtQ93NI2ABe
	BhuwuLH+9i8=; b=HB54p5z9Ijb9huJQnCofy6AS/yZlefV3fi4VBsAODeFFhaec
	VeFZ1StYrpK0jsFGMNCu66l+upbHTOsT+teY6tawr9J98Hok8WqlqGLTpt507CKJ
	YASzMTv2avNI3M2Hn8bLKrvTwkdE7nirG0SQFCMyv07tXf2W+PXyxOHiyODqYRoQ
	1g2aJlv9mKc9sVQAFuHXFwMXmoqjJIjdu1gdT2+NXrSqKHat+1SQH/CouzBCmT24
	5GHFIlCu0jOrR74Mv8R0yyPj3I/TzAoh3pn0lLPFT7W7Uvx+1FWx3Tuwkar+PYT3
	oyXBSmAsHWp6preQIdp/RUwrazVYYnWapZHDgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739898337; x=
	1739984737; bh=MREDDKhkSsDOa7xmYAOWCQtQ93NI2ABeBhuwuLH+9i8=; b=a
	OX2XuJuy7AU1JTyRJDZeDn5VVBjZijhfdgNhIdKGGYg+oHkzzJiLjSPEoHYXJlxz
	nNo6W+4u3F2hqcuxduwaHVF57B8xBSqEuFy1OwGdWzkWF7mwJ6aWJSU7kuO3XOpK
	mhcD9BXx4fA1DTDfDA6pRD32m3GFLb4rVTRB5Ai0D0RG+5eVtWE/uGwWgs6yGGWS
	Ft4eJj36Fze+smSYCKhM96nIe72gu9z8VwcuYyEm7Ahq5Ei5TkR2Wts4/3hgUwK/
	0yKxrGYodUmvVY0Pr804wCv1/V0bH9bYlAxzUB/15IxwxPOJOqvc3BFcEaq06WW2
	1OhStutsX5Sa/Y2ajakiA==
X-ME-Sender: <xms:4L20Z4xHOTR9y6Z7mbqODgvrCmocCuDSyYC2Yl5CVcQhwRg8tlwMJA>
    <xme:4L20Z8RasVdXpzQAVHU-bufABKTKtdTYKesP3L_Ylkv2Lhc-4phYu5fuEq3ICsD0s
    MPtZAcpPr98MZoBPoc>
X-ME-Received: <xmr:4L20Z6UVIEoT_gFfVOiBVe4MAtM75qQmGJCux7UbTM1qeNOrUjQ6oDpaEH2HtPSRsQ9mOTt8yCLGKRLU7JXBJp41QDmrrsgopQG-RRtfhKA2r3FWEcMNaoDLbEiRkyY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepufhvvghnucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrd
    guvghvqeenucggtffrrghtthgvrhhnpeegieehffethffhffefhfehkeevleevieetfeeg
    keehhfeifffgheehieejheeihfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvhdpnhgspghrtghp
    thhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrtggrnhesmh
    grrhgtrghnrdhsthdprhgtphhtthhopegrlhihshhsrgesrhhoshgvnhiifigvihhgrdhi
    ohdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprg
    igsghovgeskhgvrhhnvghlrdgukhdprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgt
    phhtthhopehsrghgihesghhrihhmsggvrhhgrdhmvgdprhgtphhtthhopehjsehjrghnnh
    gruhdrnhgvthdprhgtphhtthhopehlihhnrgesrghsrghhihhlihhnrgdrnhgvthdprhgt
    phhtthhopehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:4L20Z2jhGrJbzpEu8biPVN8bgJto24D0dFlv0d7hnUADVYnhlgzOTg>
    <xmx:4L20Z6AtGTTMkKx1gSRK9H0EVM2i50U9b1tM6xSQLIA1TXQ0agZAhA>
    <xmx:4L20Z3LJHB4EzDIH6skSaGmDPahUZI-6XnzJv8hGO5k8xoD91NVRJQ>
    <xmx:4L20ZxDD87IY1A0dBxrRxUQsENE_D5BGH3U-fGE9A5AAPb8BWXbzkQ>
    <xmx:4b20Z2yZG3TYCd8WlavFiZ7DKrHm5gNPwRAlXc4nDRwmoeMU4OIy1pJs>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 12:05:34 -0500 (EST)
From: Sven Peter <sven@svenpeter.dev>
To: Hector Martin <marcan@marcan.st>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Janne Grunau <j@jannau.net>,
	Asahi Lina <lina@asahilina.net>
Cc: Sven Peter <sven@svenpeter.dev>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: apple: rtkit: Pass the crashlog to the crashed() callback
Date: Tue, 18 Feb 2025 18:05:28 +0100
Message-Id: <173989828121.49947.17671473399449752322.b4-ty@svenpeter.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250202-rtkit-crashdump-v1-1-9d38615b4e12@asahilina.net>
References: <20250202-rtkit-crashdump-v1-1-9d38615b4e12@asahilina.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 02 Feb 2025 22:48:47 +0900, Asahi Lina wrote:
> Client drivers might want a copy of the crashlog to stash into a
> devcoredump blob. Since device memory management can be very variable,
> the actual devcoredump implementation is left to client drivers. Pass
> the raw crashlog buffer to the client callback so it can use it if
> desired.
> 
> 
> [...]

Applied, thanks!

[1/1] soc: apple: rtkit: Pass the crashlog to the crashed() callback
      commit: bf8b4e49777d944f84cf7d47360fe80dd3f69d96

Best regards,
-- 
Sven Peter <sven@svenpeter.dev>

