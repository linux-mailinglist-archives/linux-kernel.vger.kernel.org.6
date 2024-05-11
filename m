Return-Path: <linux-kernel+bounces-176458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2277B8C3038
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 10:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02C91F22845
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 08:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F7437147;
	Sat, 11 May 2024 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b="xo03xNwp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d8/ZL30j"
Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E32223DE;
	Sat, 11 May 2024 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715415375; cv=none; b=NTaitYl8JhvQMaEK1gJFBgiPc/hIT3Rhqwn7RThNhbplacvK7yzPOmpGZq8iPotsqhBG2DJmISEspIe8VPwEDJeyJCiXlLG5y5H6CsIwJNW90RElOJ+X4BkLYuFwX0i3d3kyW7DOH+cQUAo6w9m1pBvWHPk41B6UwSxPHOTSGMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715415375; c=relaxed/simple;
	bh=B2flMuPt7P4w1oC2gzKRD849SpIS5HNIm2968vmz6HQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Ny6wW26qKUB+s6BUSeUyt6phlfYb8WrONThWCtxyS2kynmtpQpF1aLpigmkzgvJlte7uqzDwSgbeQ7udSgxNlYysrxTHlOm8UmbdHV3ThdOhEETGYDu/NLiCJJfT/d5bYT60p7p/d2RkFb+Dd7NFQN9Thz5/0tpvhKW5eDPz6AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=testtoast.com; spf=pass smtp.mailfrom=testtoast.com; dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b=xo03xNwp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d8/ZL30j; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=testtoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=testtoast.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id D3E8F1800115;
	Sat, 11 May 2024 04:16:11 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Sat, 11 May 2024 04:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=testtoast.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1715415371; x=
	1715501771; bh=F+lmUq+WkvIBeq12o+SumSTmxzrDuV934rJg9LBCmsc=; b=x
	o03xNwpzD0e6B/v6gsjJpFB54wQ4XZ5Kv8HqZ/i0m7ugVnnwNBadK0wSc1cmqU4y
	eWzXz0naCKm/YqjbUrA2ZA8D6a7BHLOG8WzrYVJfZxAes9QBDcqPoKmotH4sUVE5
	kR8rewl8PsnK8Ko/P4YUex78K0DQF3xN/HjqO5lvvTSs0hlbBF5+bERXU9plqTjc
	4QUZsQ3RLyKA62UYpY21ffL7l1tUbMC9aykCosY7/oFfksJDf2CC5+LbxSSATn7d
	rV928XwTKeF+TcttvWbPWIPdQokK9YdNyFNpubyIEBEE5nY0omivTQtA/UBLZBoD
	fAegJObXfFo6I6WFdFPnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715415371; x=1715501771; bh=F+lmUq+WkvIBeq12o+SumSTmxzrD
	uV934rJg9LBCmsc=; b=d8/ZL30jOMYh4elOo2liuTOAuTelCeKJXbmQ9idvXzSQ
	KOOvPad8JCjU7zBTseUQOFrPjgqwVPzzt3YoCKvxzt5GnoMNEH0oIH4bu5kHlqjm
	QLGJzg7AroNF0w2Z/Z4C7ub8zGQMpiTaEubT5ONsiefyXagnChg1CqSGzoJyuxK/
	tYCEawIraxdDpHkPu9wcq6tcGx0QNOdgkCE/Rkvx0xZJmLDwLnKn9VZZIYOLf5LN
	CDSIyJumwLGyimXYpz0y3M7c5tIDU+HfFYHXFMakPOMELRhmrIMA9/wu5Yckd7Ja
	iCUiPnM0BuC3o3YdzvOW77mbb54Erww1cJ02Q1O7ow==
X-ME-Sender: <xms:Sik_ZnLYbMROGY_dTHyt53mB5vmz4MzObZogwGpM2DjEWXiD4VomDw>
    <xme:Sik_ZrKw3Bk5CQRDwiFJWYEzImzS8SFOlXIOusPVl-XjTsE_hsMUKoCV94JTttEAM
    j97YHnyHpPQu28djQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegtddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftfih
    rghnucghrghlkhhlihhnfdcuoehrhigrnhesthgvshhtthhorghsthdrtghomheqnecugg
    ftrfgrthhtvghrnhephedvveeigedujeeufeegffehhfffveduhfeijefgtdffteelgfet
    ueevieduieejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprhihrghnsehtvghsthhtohgrshhtrdgtohhm
X-ME-Proxy: <xmx:Sik_Zvt_L4GLWUEoDzqIXqt1Rtfo8IchKcver0UfK5xzAjf9AGIRuQ>
    <xmx:Sik_ZgZsfJiV7Y73c4NNvV9wbi7npRaQlu7xfPxkKwq4tR3kameY0w>
    <xmx:Sik_ZuYm07tpSzU0uUqTFkgW4Yvoh-XFNS8V3r7fok-yJdGmsHj5lA>
    <xmx:Sik_ZkDQyH5lIJBuyQEm8FwJFZS50i9Qgp2YyS-l_MUJig-ogaZhRA>
    <xmx:Syk_ZgBzM16XudidKy32-uwvnMPdIS6z_CjRheSt_MY5CcbYDirfDJg7>
Feedback-ID: idc0145fc:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A3269A60078; Sat, 11 May 2024 04:16:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d381ea36-f668-4c30-b2fc-f9c81f99f09c@app.fastmail.com>
In-Reply-To: <20240503154402.967632-1-robh@kernel.org>
References: <20240503154402.967632-1-robh@kernel.org>
Date: Sat, 11 May 2024 20:15:49 +1200
From: "Ryan Walklin" <ryan@testtoast.com>
To: "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Chen-Yu Tsai" <wens@csie.org>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Samuel Holland" <samuel@sholland.org>, "Maxime Ripard" <mripard@kernel.org>
Cc: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: sunxi: Fix incorrect '-' usage
Content-Type: text/plain

On Sat, 4 May 2024, at 3:44 AM, Rob Herring (Arm) wrote:
> Commit 6bc6bf8a940a ("dt-bindings: arm: sunxi: document Anbernic RG35XX
> handheld gaming device variants") mistakenly added '-' on each line
> which created empty (i.e. description only) schemas matching anything.
> This causes validation to fail on all the root node compatibles as
> there are multiple oneOf clauses passing.
>
> Fixes: 6bc6bf8a940a ("dt-bindings: arm: sunxi: document Anbernic RG35XX 
> handheld gaming device variants")
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
Apologies, thanks for the fix.

Reviewed-by: Ryan Walklin <ryan@testtoast.com>

Regards,

Ryan

