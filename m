Return-Path: <linux-kernel+bounces-519915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD9DA3A388
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10CF73ACFBE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3803226FA5B;
	Tue, 18 Feb 2025 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="JoeflBjS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aiw9LZ50"
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD50726F449;
	Tue, 18 Feb 2025 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898336; cv=none; b=A/E2Ll/QE1P7KN3O5Ix86Y7rNtt9xg86AHPRbyct8zB+KAL8oGhvXGRbqvlkkKAxMHro68T52Dk42vcz2ASwD3br9rgUJVWYga+VgFJ/eiSKdnaii6jF2MXHjevhngfksZ8i5eusoau6+YspdJfcGmcZRMGpe29PcwvParnIQYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898336; c=relaxed/simple;
	bh=x5U56tZVCuT5LWmJKBQY3XqlQC3tuJAS2mDZtD1d4IA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+2MUFN45L/CBd/4ZXCl7k4BkEbRuqqm40n6Mm5WUzQ0s+bWGRnZy7PX/jY5PpTJK8sI2ZPc3X/Ml6hycnpK/1++dFXAjE9wR7jORHDv6BjJB1PRWZYG+7xlQBuY6ieNh7MNwgV5c+l/0RlDoWP3CuMO7kLXnpiSTnwbVIPqcbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=JoeflBjS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aiw9LZ50; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C1DC111400C6;
	Tue, 18 Feb 2025 12:05:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 18 Feb 2025 12:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1739898333; x=1739984733; bh=X2YBb1ww7P4FN6Kapfe0IGZ60gd3Ip2D
	VQdxj2GxLyY=; b=JoeflBjSlcECYktB8zIicHBlOAIRwj32VLOU9LZRCUOvNJz6
	xFCznPxz2DYndiNeVdGp2c+dx6FdbZ+sUO6rKTkM1+IUZs6iuhDxiQHnY6ALBR/K
	gowHqBRpdla38zSP4ao8AC6omid4ZQDCufpRdqK1bwOjubN8Qzk0Hkdf9goHsRjo
	72wYAVhMSsm82QXkThitDTHSzt8shcD9IoX+wgGN6j63voQEor8iM/l80BqQDwUe
	mPFCIjv9dMvMXOHBBbsyMGk5x4sL3a94rVnTYJ+ky41+IV4ZGJi64s+ry2O8/a3h
	RqOEkVNhgTXqYnonAK57Um/wgRHTW/VhOQfZPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739898333; x=
	1739984733; bh=X2YBb1ww7P4FN6Kapfe0IGZ60gd3Ip2DVQdxj2GxLyY=; b=a
	iw9LZ50bRNZaZQxx4tlb60DuiBq0r4tiV9DR/9qYm181DbPTWEDiuwLmtYjgVfoN
	PCWc+5Lste7N/i6y1AL2WF1sNZ0D/X272MemhXEfM00LtgQYKLVCCfkB2tx4jNYN
	dcraQIbKVmOo37ZZ3rRuxzJiFBljtCns2Ea6CzWVTjfRYmGLowb/bZrb6S17cIhn
	QOQutCpvzqDW6qY9/PLdxmtPuPw5bkUR4DT8+Og+cBbKMc+v3IhbxhX7S/8lg93h
	38kjzmMNtY7fQJzI4VotHEhRbRRn+67ZVPNlJXnP57fUCj21iZw5eZYi2OhIIPSr
	O52ozPO4xCYWGcu23xV3Q==
X-ME-Sender: <xms:3b20Zzz_1Z_YVvfAPjQnhLVW_63deT-Rm51msfkgovtsAmAO_3arOQ>
    <xme:3b20Z7Sws-x803j8OCRaPnLnEPofH53AVJRqwefhpBUo6I5jUCRcx8yCfvNBwzYpx
    xTD0dpHall8d_m3-yA>
X-ME-Received: <xmr:3b20Z9VMlC4XcisRVf0_Fxmw4GpeIb53f-ZlolIuRj8dcljLHrXgs0RSvbyOcy_XmdoWBF24wAv78XWFnIL2ZGRwkWx75xTiTuQLrRU0EGnh92swSFbB03Gtd4bd8mA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepufhvvghnucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrd
    guvghvqeenucggtffrrghtthgvrhhnpeegieehffethffhffefhfehkeevleevieetfeeg
    keehhfeifffgheehieejheeihfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvhdpnhgspghrtghp
    thhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhihshhsrgesrh
    hoshgvnhiifigvihhgrdhiohdprhgtphhtthhopehjsehjrghnnhgruhdrnhgvthdprhgt
    phhtthhopehlihhnrgesrghsrghhihhlihhnrgdrnhgvthdprhgtphhtthhopegrgigsoh
    gvsehkvghrnhgvlhdrughkpdhrtghpthhtoheprghsrghhiheslhhishhtshdrlhhinhhu
    gidruggvvhdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtsh
    drihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrghrshhhihhtrdhmrdhmoh
    hgrghlrghprghllhhisehorhgrtghlvgdrtghomhdprhgtphhtthhopehsvhgvnhesshhv
    vghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:3b20Z9iAa-FCjrsN2Rk1i86HGdEpAmjfrJxB9_UKNYv1ihQCZ7zHGA>
    <xmx:3b20Z1Cw6-MipYR4ZYpRtLo8aJHLMElI-KMh67ZOR1twqj8yTiGP9g>
    <xmx:3b20Z2KOaDYVxI9EwCuo8eKbQVCkeUl1R2pQWbQfmUu9JjCykak3yA>
    <xmx:3b20Z0A9Zsu1FoRiwZDRzmaacllSxIcg9cl_nvqz3STC4Bk9yqlcZw>
    <xmx:3b20Z54NHNk79hMLD2GLpkFnUMe7AyebEstp-Qt8fhwk1mLMcOV1SNqL>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 12:05:31 -0500 (EST)
From: Sven Peter <sven@svenpeter.dev>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Janne Grunau <j@jannau.net>,
	Asahi Lina <lina@asahilina.net>,
	Jens Axboe <axboe@kernel.dk>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Sven Peter <sven@svenpeter.dev>,
	dan.carpenter@linaro.org,
	kernel-janitors@vger.kernel.org,
	error27@gmail.com
Subject: Re: [PATCH] soc: apple: rtkit: Fix use-after-free in apple_rtkit_crashlog_rx()
Date: Tue, 18 Feb 2025 18:05:27 +0100
Message-Id: <173989828130.49947.10388452698510580758.b4-ty@svenpeter.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250212085853.1357906-1-harshit.m.mogalapalli@oracle.com>
References: <20250212085853.1357906-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 12 Feb 2025 00:58:53 -0800, Harshit Mogalapalli wrote:
> This code calls kfree(bfr); and then passes "bfr" to rtk->ops->crashed()
> which is a use after free.  The ->crashed function pointer is implemented
> by apple_nvme_rtkit_crashed() and it doesn't use the "bfr" pointer so
> this doesn't cause a problem.  But it still looks sketchy as can be.
> 
> Fix this by moving kfree() after the last usage of bfr.
> 
> [...]

Applied, thanks!

[1/1] soc: apple: rtkit: Fix use-after-free in apple_rtkit_crashlog_rx()
      commit: 00834971f0d9e38beae37e92055b1432782827d0

Best regards,
-- 
Sven Peter <sven@svenpeter.dev>

