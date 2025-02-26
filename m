Return-Path: <linux-kernel+bounces-533211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 955F0A456E9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDE787A1F69
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B8C254AE9;
	Wed, 26 Feb 2025 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="XmCAsjML";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vILheoZm"
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A06810F2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740555978; cv=none; b=lXm7kUUbrQz2vaSWXMz76cCthAEg2ZQgAAmf8gjK2RxS3fDLK0RGn26B/4dSLwylbKi979rlqTGyJ/l5c9qy10XQV5tmxPORYfAe/2F4xUgkRwBTuVql4ONjNzIEtN1f9aGC6UgamBqGZ9iUjktwTPRvgicusUcqk/p5kx2KJfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740555978; c=relaxed/simple;
	bh=SJHTc9qdPzAybwEMLa9/95pPjQ8tR1reiqc8PT8UVrc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PcRRHomwP6Het1vPTuy3qDhBORWNaRugQ65ER1ouG5pkp1YXpjRKjmQ+hlJcMR8k7I7QPeXtuesP4+Zi65Nk8ncYUc+48lBLvd+9eyCkSM3mjq0oDRgRCFtPdv5fve5LJ38/B/QU3b4CdnMZBkJ5sjOqBRWdt4M33HB6zuSIyP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=XmCAsjML; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vILheoZm; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7F2B12540213;
	Wed, 26 Feb 2025 02:46:13 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Wed, 26 Feb 2025 02:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740555973;
	 x=1740642373; bh=Pet/LFXJukOjpKw3N/qfkQZuhd+dmy6ut6K9bQDsKNE=; b=
	XmCAsjMLj0jyRI5c7icQpfnx5Q3lhSuEt95dhaiQeMN97I3PWatrgOGQ3hsAnOPj
	gtLGaAsyilMAW9/ikh+7dYdnQU1T6lVNDIc5HStuCSxMrvsK26vps2on7mOvp5Rs
	45cyKGzz9FFX3aHtmglBP/6H5P1CQ72fj8JzHgx6X0NR5kkUJ79c4g8VzOJ3PITO
	8TrEvQKbv9q/dNoY3eGCLscoPs8opSK157UWbypgb96zuTRzZ05Afs8mFHrbmEVC
	dwsrEVMAqHCSep0HQogGEaw6jQ4HY+AGs4y8gRkFHZPbrZt3cz/vuUb/Crrjlzn2
	0lUHlvYKdDhxOMW24yU8Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740555973; x=
	1740642373; bh=Pet/LFXJukOjpKw3N/qfkQZuhd+dmy6ut6K9bQDsKNE=; b=v
	ILheoZmgVcumoGluM0sqmzHhGkUdRyCCdgjI+bUU93DKkFfwYLwKuE745qKar4rY
	8PoJmWGYLDUWqsMWqBAKe0ps9pRqCUWJhedewFiExVlBVK1ToWKyMLP537uQ0+I4
	HM4BpRMedxXea2Nlcokd+VI6AnfgRdqE0vtvTHFeWdW7oPbfoVtwUnbDuvhvhqW7
	tW28QmtoLfHSHXaetuuF8xl5/JqPMvD42CYtk4fVcOuAMCW5jL6T5m0xqDnfTfCI
	lvKx+a3IEOjR/H8oP0ElUArBle3RTPRebw0+xFDPcqdnqeDsi8wT7SfFlS6mMgxa
	uxqpCEL/nS6EHMbLGbSuQ==
X-ME-Sender: <xms:xca-Z1h-av5BN7_pu2ZO5kwn7JqvTruAOL96TFa1bj2XpjATGLFcOQ>
    <xme:xca-Z6D38BG_bgVSaWuria_qOP6USGDa7kwTki-wmmMw5uPdPStYXDZI3G0nf64M2
    IbZ2W2-y4Rou_-v1iE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeel
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrg
    hssegrrhhmrdgtohhmpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehkrhiihihsiihtohhfrdhkohiilhhofihskhhisehlihhnrghrohdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhr
    rgguvggrugdrohhrghdprhgtphhtthhopehquhhitggpsghjohhrrghnuggvsehquhhitg
    hinhgtrdgtohhmpdhrtghpthhtohepuggrnhhishhhrghnfigrrhesthhirdgtohhmpdhr
    tghpthhtohepmhdqmhgrlhhlrgguihesthhirdgtohhmpdhrtghpthhtohepshhrkhesth
    hirdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:xca-Z1GH8yA_lYNQdHJboVueStmIiJ96ofVfN8o-qxod_GIkAag2Pg>
    <xmx:xca-Z6TP0hTt3FxBCDIAKQd7EDJQZ5qvJpC-ivoAXxMVkmun-l4qLw>
    <xmx:xca-ZyyFwyP7b4219fTGmYx1dQRNXP29maDiGLg1EOZGAdgQKNeKKA>
    <xmx:xca-Zw7YW1HxdaT1IddqhRn4dIYxZNxhWo-PYUZ-77xU3y0NpnkleQ>
    <xmx:xca-ZxnmRi2dtQvxN3cG5XNYUL9c4KTot-CgX9Ty3c_z1wXa2rPG7ZSJ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F28662220072; Wed, 26 Feb 2025 02:46:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Feb 2025 08:45:52 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Malladi, Meghana" <m-malladi@ti.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>
Cc: "Bjorn Andersson" <quic_bjorande@quicinc.com>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 srk@ti.com, "MD Danish Anwar" <danishanwar@ti.com>
Message-Id: <839c2c04-0022-4a7a-8e28-f526814b0aa3@app.fastmail.com>
In-Reply-To: <686f583d-6bf4-4486-b9e4-20c1e268eda6@ti.com>
References: <20240419060013.14909-1-r-gunasekaran@ti.com>
 <686f583d-6bf4-4486-b9e4-20c1e268eda6@ti.com>
Subject: Re: [PATCH] arm64: defconfig: Enable HSR driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Feb 26, 2025, at 07:18, Malladi, Meghana wrote:
> Hi all,
>
> Apologies in case you are receiving this email for the second time.
> Any reason why this patch hasn't been merged yet. Other than re-basing 
> this to the tip, anything else which needs to be addressed to get this 
> merged?
>

Someone needs to send it to soc@linux.dev so it makes it into patchwork,
ideally it should come from a platform maintainer that needs it to
be enabled.

    Arnd

