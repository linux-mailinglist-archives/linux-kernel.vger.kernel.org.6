Return-Path: <linux-kernel+bounces-430814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D60F9E35F2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3242028899E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A991990CE;
	Wed,  4 Dec 2024 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="i9VVAO/2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5BGe4aMW"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E131946BC;
	Wed,  4 Dec 2024 08:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733302329; cv=none; b=JmH836nOHCsaVq8hsHe9czPju8m1hmOAgkttGpk5CJoSnD/LJJ5kPJPYu+/K2ybnOJ/TcP0ANVaPS/OBtv/U8u2PCIePgFgNypCybdrzCjBoK8lGjA/QzBp6AcRKqh+7p6Qp4fRgRsodZCHVgszwTTr0R7NmEhxV9bPbHzJauZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733302329; c=relaxed/simple;
	bh=zIcQJvA+oKpRsAfJuyACQLHY0DQLwZWhzgfqlh/fzA0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QGC02CuAd0HVDPTbXG9tdxWnJq37PyJwBxNJ9TCmfbwyO4kocX1WoH4z/Z7VVBxJxE5G/XjNoW0rFh1OYZ3+XjP95xlt/EluyWc30kvhJViEhsVyukBzeonaqO1+u1twaIYZa05WliO9F3G4FY6FjKcU9Rt7Yy2BMN4bicFWIJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=i9VVAO/2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5BGe4aMW; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 17E2F1140122;
	Wed,  4 Dec 2024 03:52:05 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 04 Dec 2024 03:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1733302325;
	 x=1733388725; bh=zIcQJvA+oKpRsAfJuyACQLHY0DQLwZWhzgfqlh/fzA0=; b=
	i9VVAO/2eSjekmfjZMyGWZSj0oO08SuuusIbfvUNfuwYi5exo5qIq4o5Dh04jNLi
	VZSQnMYc8JUuzs+gZefJqioqkrEi6gc2MLt3N12xBNIVMJtuu017z0tZ6FDAMJHR
	jPYEzznRcsPLZP1dKGnG/vXpGMJhZ5/oqjprBHtxngc7KQ/NURChCOVL1UOsScMU
	mR7uTgHm00CT6G4qMe/SPHpZmmwmjdu4hrAiAwnuBf64Hc0jofc7/DxxpfsVIwyo
	4cknDpJAErwnhC5KkVgPnsruQJSdoFm4o/cwGl7etYn+030Pi1m35vC+tL6Js7td
	nsZTvjBNYGEXBRsxim26Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733302325; x=
	1733388725; bh=zIcQJvA+oKpRsAfJuyACQLHY0DQLwZWhzgfqlh/fzA0=; b=5
	BGe4aMW3s+6AsdFqTKHiEypiD7kqbCXk2RjjUZVoQKcrcUTZJ3OsxGPkG6/xEsF3
	O3xi/1eV2EYEmI4JHaPW9pNIdTriTOUKdb7czd6NkgVMNyDLaGXLcz64v4cs+ABJ
	HZziKcwV1aJUNlyGzO4LkrAdcAb0x4DcuxDNILpqDraTgI4jKmJbWAWHiRLD7ZFG
	El/ZgTnql2PjLWJZnio9u0aLoUZZCfW/X6AqoxTBOkZk6jWCxDYXUvGXr/Tw0olR
	sve+4cmF9AdA6/YvFvoIBWzaKAGEC8awZwphcph/QYSeP6OMfoh6xj4N8I7ZJ5tk
	eQrFTPRAoUumLAiBpjqjQ==
X-ME-Sender: <xms:NBhQZ7rxsgUuQr7pdhD-A68BzOQsBZ3TARqt37qjekDjF1KYSqmbRA>
    <xme:NBhQZ1okzJ1fUbf1gK_SstYTdbnGgmRp5NZ7vT4DYlvQR5yLqnUTW3VivM9lTzv6l
    LIhGx88qc-tqRNvh2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeggdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohephedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvlhhlvghrsehgmhigrdguvgdprh
    gtphhtthhopehjrghmvghsrdgsohhtthhomhhlvgihsehhrghnshgvnhhprghrthhnvghr
    shhhihhprdgtohhmpdhrtghpthhtohepjhhulhhirghnsehouhhtvghrqdhlihhmihhtsh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhprghrihhstgesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:NBhQZ4Ou7B6qSOwvaonH0vCl65r5dKYgW3jx2j_PPFmxo0asGdn_sg>
    <xmx:NBhQZ-5rN49UsAzrbL4K4aBPrd_zk3CFj4pI5GMbCJMCb9eVCaIONA>
    <xmx:NBhQZ66MPOWyHe8tmSNzOxUPOTN9dLaSQ4Ay8jABvatPfOuisfzVvQ>
    <xmx:NBhQZ2jWehaxemh9mYfQzO-exsXDIeARzbo32B2S3_MYh1wPtU-Clg>
    <xmx:NRhQZ11GwuXS6AJF6Z-EmkR1grMeIhoD_jgNnFCGFzQnpXiYEvKyRNOS>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8B6EB2220072; Wed,  4 Dec 2024 03:52:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 04 Dec 2024 09:51:42 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Julian Vetter" <julian@outer-limits.org>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Helge Deller" <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <e8c80d6e-4b4e-4108-bdd0-b096c8d634f5@app.fastmail.com>
In-Reply-To: <20241204074632.3683523-1-julian@outer-limits.org>
References: <20241204074632.3683523-1-julian@outer-limits.org>
Subject: Re: [PATCH] parisc: Remove memcpy_toio and memset_io
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Dec 4, 2024, at 08:46, Julian Vetter wrote:
> Recently new functions for IO memcpy and IO memset were added in
> libs/iomem_copy.c. So, remove the arch specific implementations, to fall
> back to the generic ones which do exactly the same. Keep memcpy_fromio
> for now, because it's slight more optimized by doing 'u16' accesses if
> the buffer is aligned this way.
>
> Signed-off-by: Julian Vetter <julian@outer-limits.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

