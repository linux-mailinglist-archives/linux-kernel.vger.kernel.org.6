Return-Path: <linux-kernel+bounces-568848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7121A69B2D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBCAF19C0D70
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DD01AAA1E;
	Wed, 19 Mar 2025 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="eAKQXDzt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yyGiBfHm"
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD8F14AD29
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742420781; cv=none; b=WP3psfyA+Ik6rv/0WeQv4PoWuoSMXS7zmgzmC0qSrWscoAtw8X1hzT5YIfhdSSBCaCwrg3oMvB32+XAOqsdoZ9UQjL0x/Y0eLkSjyWg2EN9V/S96Y7dnfXdfhbNyL6ea+SVlHSAp8ShKlrjWsQ0wTlu99O6IddEeepJwMR7KSuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742420781; c=relaxed/simple;
	bh=S6dPOjstlHnUUS0SzulTlassAEAlYfK0ehyTno+oZMU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RFhePawrtfE3yCPPWLlTBlBD2YvzpKvQhnrMWETZZ4P37S9bb7DzhWDjyg/6V8/zK7k+5zGZY8h0bnRGqMJbUegQb5PuK5JStEcC2xuQuiwBGf8MHgt0eqkaDBIZQMfU/VG5j8bnkJXY5ePPjMfFPNl+87mBxm+Xvnayh0Oh7pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=eAKQXDzt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yyGiBfHm; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5824925401B2;
	Wed, 19 Mar 2025 17:46:18 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Wed, 19 Mar 2025 17:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742420778;
	 x=1742507178; bh=NIV1jl6V2fZlix63bFp4nlCTMLgC0hAJC1UlPpspvig=; b=
	eAKQXDztmvO28zcR3zDMxe9omF5+kZdnh93neULpzO3AOzG2tkCkjMc9fsTMWfDs
	4qRxP17m9ImvKjz+4bDDLnHeh2cVuNev80WAr1y8TGNedm4BJ10w59tgbVf0YC3k
	ZyGCOPjEHGv7o93B1v87wkYSoXULyKy4qHf6lnIMPC6i9HjEILdE7el4ubUZgXSG
	3xN/VpEM1MT15my+nwJprokD6Fk8B/fUIqBWSQDusZBp6xEZCw1mOmGItAGGHbmP
	3Tpx/5Bp8HHOoifKhzk+DOrWubK7MxNdpOCZNbUsXPihehy3/Y7cSf6MpTGDfpVG
	YNuFgzeijoqkZ21+XWl6Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742420778; x=
	1742507178; bh=NIV1jl6V2fZlix63bFp4nlCTMLgC0hAJC1UlPpspvig=; b=y
	yGiBfHms1axUwQxMcMRsZYFpYxCvenPcokpYVW5oOV0yvA73QmKaC8BuurTy4e9a
	5TRxA2kQ3dSPAWDy3wLb/hh7w4d5/sQLm8d3Wq3UwmxLIJQ/00Apd4ptdzwrXvCV
	ZxUcPENBezQRn6xy7FihnmHz8841B8D4POG8kh9s4idXyUG6zB4QhCegGBwpz2vU
	Sxkb//wwEYf9E6ZyEW1li+ntKNxM6RqBWxzFNGxUJ1avyshVdqu3Ogy/V1vrvecF
	nhxkbFWLIqkl5+CYEJmOb6UaIl2/Y5hExN3bVZe3b6YKkxuRKaA15oDqAdPqpDD2
	3LzZDBYxTlr6yuY5BvMkQ==
X-ME-Sender: <xms:KTvbZ_FP79bCtSPAr5O0UKHiysXybUM1bmwMjjMOgPAIJPgVj86Xzw>
    <xme:KTvbZ8Wr2X0hYkerR8U2xHYOYyJdJjJvVO-bXfIQyv524RvJUAkIdo790-HrfZlE3
    zp9jemQvxkik3Fnt8U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeeigeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhlrghrohhquhgvsegsrgihlh
    hisghrvgdrtghomhdprhgtphhtthhopehkrhhishhtoheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgrug
    gvrggurdhorhhgpdhrtghpthhtoheprghfugesthhirdgtohhmpdhrtghpthhtohepnhhm
    sehtihdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KTvbZxJ5_UxHkfnazQSQz6Im7JqvN3lyZjge0OIHfn5R0pgqqxCQow>
    <xmx:KTvbZ9EkLgDyA7IG31TjHc-KqiNUgFu77yb4bH8Poc_2yVEM6hjSCg>
    <xmx:KTvbZ1U3qfMhl4t4LYzBiQkX6oL19nVdQ_pfuFtsl77iK9wfaQzGUQ>
    <xmx:KTvbZ4OJBQDTW_q8jEgr8trulU3oqVsvIE_AgWUUZJkdiiaCk84u-w>
    <xmx:KjvbZzdNDkZpcl3g21IIa6UX_Sz61HSXPFaqrTe7R6PShid2Y1QcFxgF>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CFC152220073; Wed, 19 Mar 2025 17:46:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Te367c4c16dcaf1bf
Date: Wed, 19 Mar 2025 22:45:57 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Guillaume La Roque" <glaroque@baylibre.com>,
 "Nishanth Menon" <nm@ti.com>, "Tero Kristo" <kristo@kernel.org>
Cc: "Andrew Davis" <afd@ti.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Message-Id: <c506a805-9221-4afe-8d98-af0ca97a1fd2@app.fastmail.com>
In-Reply-To: <20250220-ti-firmware-v2-1-ff26883c6ce9@baylibre.com>
References: <20250220-ti-firmware-v2-1-ff26883c6ce9@baylibre.com>
Subject: Re: [PATCH v2] firmware: config: ti-sci: Default set to ARCH_K3 for the ti sci
 driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Feb 20, 2025, at 14:31, Guillaume La Roque wrote:
> With ARCH_K3=y we cannot enable TI_SCI_PROTOCOL=m because
> ARCH_K3 selects TI_SCI_PROTOCOL.
>
> Modify the logic to enable TI_SCI_PROTOCOL by default when ARCH_K3=y
> allowing us to submit a future patch to remove select on ARCH_K3 without
> breaking existing users.
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
> Link to comment done on last serie [1] we come back on first version of
> series[2] to not use imply but set deps on ARCH_K3 in driver directly.
> An other patch will be sent to update Kconfig.platform when this patch
> is merged.

I just merged the patch and hadn't seen the earlier discussion,
just two small notes from me:

- thanks for doing it this way instead of the backwards 'imply'
- there is really no need to split it into two steps, since the
  change to the Kconfig.platforms file logically goes with this
  one and I would merge both through the SoC tree, having it
  as a single patch would make sense.

        Arnd

