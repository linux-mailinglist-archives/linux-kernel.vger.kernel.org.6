Return-Path: <linux-kernel+bounces-534337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A5DA4659A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1BE3B6507
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2609821CC7F;
	Wed, 26 Feb 2025 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="PYAy++DD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LitOKgpY"
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BA521C9EE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584869; cv=none; b=K+Gzly/R0D5gMOlOiBEDo/CsotPLcTOcE6kJh72qEWuYAoWjPuUH7lJnk4GOIZMM1czRfiEXV6Sc51UvpU0WcCBDWTYjUd5nDQe0xWqxxLddTmqHF9nqohC4zfgh4o5rxI8TYMVTA3HMUEpSLzz9kQ8BzN/hRt2hWnd/9TZPRHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584869; c=relaxed/simple;
	bh=QVPeSoVcagmA8sHcPpQJt/J0aaFaxx6wVciUnRmE1Ng=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LdP8jnLW8oGLUR2drGGzjrD4NcM5Pkxx4VzOs61BJaSCp+AEW8WytLGZOOZ18uddHYXDmw8wGTVfsXiOgPAbO/OBzpPh/plCu0J+/NPIwjd4Zs+2XYIfZMKXwmYInf5ZvEoWngT8zb/wAzZjWziCFSFjT1tjUKAgjHvB/qPuumM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=PYAy++DD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LitOKgpY; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id DAA39138025C;
	Wed, 26 Feb 2025 10:47:46 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-10.internal (MEProxy); Wed, 26 Feb 2025 10:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1740584866; x=1740671266; bh=Q6Vh6ok9v7vS3mdkra6rnIMarTJ4HEbp
	vw5ta2XHGVU=; b=PYAy++DDH/OcqFRBTwfBJaauqSElCUNFYbjLAxHjluCeF3fB
	gM5SmcDe0ZvUTRq2mrWajgxXJ1EJ+Q6+Nx/UN/GLSHDCxjHNogFyx/DJCE5B1NyF
	aFk/RBOc1vv2Ody0SJcwB0mB7JHSclL5O/RfmKkicO5jVgaLfNd2na2kJKAYau/p
	x2w0f2doOP2vj30XLJNvewDGU2pWf0/fW77GS9hxZddFqN5HCM0PJ5MN968ftjHW
	5LdedPtsSdM4s0u9ANGD/B+IOWRb4dGw2hS/S9ah64RE7aXHE/OwpeWvARAeHbEI
	FnooeccnRbLV7nYAR0gpI8SKBxp1R9e0lJjwvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740584866; x=
	1740671266; bh=Q6Vh6ok9v7vS3mdkra6rnIMarTJ4HEbpvw5ta2XHGVU=; b=L
	itOKgpYd7s4W2vIpYDz5XFpeZbTH0OczmdjA+bii/mCOFgOQSyF0evE2WP3sNv+T
	DyYUp9688OZtfJJFCdrIjcmn+4FNMptq1wOTPqqfSVYZNlnzW9ntN3o6XILOh2mb
	NsHTiBqd3G4TRL9Kl3/u9CwX/nW03m9E+kHXJzAV7j5DMaaQAJWrdMRlZj1WEka0
	+oKkgXEe+XGhBJQqUa140AX9soLztiQHoR7rWNfmMQAIngpJBGAkztxDqEKELAfn
	4wEcNWfpahzxkjhZRxBcXiOyV4n1dHT8jar72QoiKpG30JRxgVQ9WEejdkIVOE7X
	ivFwC9Ern6Is2pTm6YKRg==
X-ME-Sender: <xms:oje_Z9QZMhxLpTqrf8Ncchj8O95vC2-yjJQpRdPWvO8D6lyhqvQ9fg>
    <xme:oje_Z2yT7_NoFzKGyeR_VZjAdsw_zys1m7cNV4c4M4YITZfq1sKSqnBUe0bKH3aVP
    ot5T7z5Ah602yvPcTM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfuvhgvnhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvg
    hrrdguvghvqeenucggtffrrghtthgvrhhnpeelfeetueegudduueduuefhfeehgeevkeeu
    feffvdffkedtffffleevffdvvdeuffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhesjhgrnhhnrg
    hurdhnvghtpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhs
    rdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprghsrghhiheslhhishhtshdrlh
    hinhhugidruggvvhdprhgtphhtthhopegrlhihshhsrgesrhhoshgvnhiifigvihhgrdhi
    ohdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:oje_Zy0lZaJVcsY8STYPuH9UqVc5UgiOXZQzVlprgaOWborWOhO6YQ>
    <xmx:oje_Z1Cu1pSVK0HQwvSLnSj0bK1H-nTFN9-FpOKL6QLeUjG2Mp4k0Q>
    <xmx:oje_Z2jcB4508kLkXV49iNS2PLbpIBff48T0Aq4FNSVNCi3hEELIUg>
    <xmx:oje_Z5rkJGpO8WPvpdqxyoYcFox_D0k3PMM-7XH76f0p3ATq7z10XA>
    <xmx:oje_Z-ccaxV6X53VNPqdlCJDNyFpbjGUnrDajBiBG_EAcEQT3IQYdZiJ>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 90C69BA006F; Wed, 26 Feb 2025 10:47:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Feb 2025 16:47:25 +0100
From: "Sven Peter" <sven@svenpeter.dev>
To: "Alyssa Rosenzweig" <alyssa@rosenzweig.io>
Cc: "Janne Grunau" <j@jannau.net>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <0b3db5a1-a57f-4ccb-9f7c-6df16d4319a5@app.fastmail.com>
In-Reply-To: <Z7y0gJPD5-OQvyog@blossom>
References: <20250222-apple-soc-misc-v1-0-1a3af494a48a@svenpeter.dev>
 <20250222-apple-soc-misc-v1-1-1a3af494a48a@svenpeter.dev>
 <Z7y0gJPD5-OQvyog@blossom>
Subject: Re: [PATCH 1/4] soc: apple: rtkit: Add APPLE_RTKIT_PWR_STATE_INIT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Feb 24, 2025, at 19:03, Alyssa Rosenzweig wrote:
>> -	msg = FIELD_PREP(APPLE_RTKIT_MGMT_PWR_STATE, APPLE_RTKIT_PWR_STATE_ON);
>> +	msg = FIELD_PREP(APPLE_RTKIT_MGMT_PWR_STATE, APPLE_RTKIT_PWR_STATE_INIT);
>
> Commit message doesn't match the code. Just adding the state doesn't
> imply a behaviour change but the patch is one. How about "Use INIT state
> instead of ON" or something to make explicit the behaviour change?

Good point, will change the commit message to something like this for v2:

    soc: apple: rtkit: Add and use PWR_STATE_INIT instead of _ON

    This state is needed to wake the dcp IOP after m1n1 shut it down
    and works for all other co-processors as well.



Thanks,


Sven

