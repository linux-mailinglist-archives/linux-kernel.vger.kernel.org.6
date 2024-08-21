Return-Path: <linux-kernel+bounces-295661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FDC959FBE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8311F2453B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4161B1D50;
	Wed, 21 Aug 2024 14:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="FdUspjj7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XnNvnt6g"
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46E11B2518
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250354; cv=none; b=icVjzt2G9XPnkPqyf/ZDn+pwvvqfn++MsxbFtkDKNiNOKN8W8jHrepPWnlOcKwm7MFBcMSAnqWZcZ7bcabjYAZu6PQlBenD7aNmyOOPkEnscLHTFARhROdFlxosKOXZZ4m058+LLJzGWTSupuZT8nOcLmVPQ4UTQCw82EA4pvJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250354; c=relaxed/simple;
	bh=uInoj18fxpsP5BIPt90J7Wa1ZwSUV8Lg6KaGsyPqvXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irTVdirjiqa8kGd8SFBW6y5BZyiVB9NroQi2fudMa75aZITnW6CWzrtxnhtDkIOaaERxk7x612ix0oNeB0VYuIddQO7wP2PnHFvh7XqIr8QNf4Xv80wsuuf99bDmEXshLsiA8z5EaQVVbsGLFD28yGHAfKp0mZrsZi7tsDApgp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=FdUspjj7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XnNvnt6g; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9E225138FF42;
	Wed, 21 Aug 2024 10:25:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 21 Aug 2024 10:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1724250350; x=
	1724336750; bh=z5hmVB1UaluQWMIWgCRGfRfSmwBjFSaGxlbnQm46kVI=; b=F
	dUspjj71mFgkp71yMyJmaNBf2sZc/DOIO22J8CywXwDYb/ibX4EhcFcnj2Vg2arz
	NW9JW0NxGKY2qN5PYK8atXzpbloVfZRr9zDPcDFT2RYOFJtGzQ+KKGe03vg64vY6
	TgrQAvthnHSag62uANGago7cAHRQfSXw1QVcuQBMnPGkakhF2oTAA8zE9pd6Ryrf
	YeQoqDvCvgMYeRRn9TbuP4S8/Rc95XNBrWlfIvtx/mRyPt6XXR6kP+2t2ZZT41mO
	DXy4+K8iiAlFFz9wMi48H7wuYVO1yUJUGmEj5zLl/RiDwesp3GJy8vwpJsIUqFnr
	TRMZLF2/IGhvaaj4u7QiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724250350; x=1724336750; bh=z5hmVB1UaluQWMIWgCRGfRfSmwBj
	FSaGxlbnQm46kVI=; b=XnNvnt6gomwBEuHM2fRninJMHuasSml99lB/Q6Cz+AKT
	Wa8JqpeF8SbY7KMBtRyJJ50TwQ23LmUx9zlDiVN4+r0c9eo6e2yTTYfWDTJq9h+L
	9DMt8JN+ZsQ8ZF65L/VrulZf4TluVVufYyhnNhMORSnC0xy1fkGxznu8dC2gS5qM
	lDcYZmUENhM4uTV/xzrXmSWlV8NGNYqX5DHkdarUSb8Uw7xLWO5tAxEgKmLs5f3D
	VcxsJPxmawn9CLienZbNPJGRjKUoBobIhRLQMRwtLWDHl2hYxBilxMpT9/GoNtIt
	P5YgEt4sJeNTmGUzCtJU6p5VCedmJdCHOQasxrQXZw==
X-ME-Sender: <xms:7vjFZu9FCwZaJ-y9xYQEw2yIJMbusC9JGteh5u-tyxxHc3QNo1EPRg>
    <xme:7vjFZuuc67XqPkG3iCdFc3qNzcKRyyScXa2lcRWTFUADUhI5mNGDuhZdubnnVx5ab
    Hakvjf3lGNcwUezeSk>
X-ME-Received: <xmr:7vjFZkBKUY60thNjM-EUKkgcl3gc6WXGXMdMvi0XKQOt64w87mCRH5fyLTEZUpz2htRX1DJqzglYwAIfAt6S-Va04eub-0KhMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddukedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhephefhhfettefgkedvieeu
    ffevveeufedtlefhjeeiieetvdelfedtgfefuedukeeunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhho
    tggthhhirdhjphdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtggvfhho
    rhhgvgdrnhgvthdprhgtphhtthhopeiiihhjuhhnpghhuhesihgtlhhouhgurdgtohhmpd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7vjFZmeJNdmiJEnPhVCc7L-Yh0pV2-QJBTX6lUqgnXsPMU3Ms7vyPQ>
    <xmx:7vjFZjPPdc65QJ1HGLf7kzstW2t74S4K7hoVQ6Aq_7hnNjUpw2Jt7g>
    <xmx:7vjFZgmnO35moMLOwDVkiL_CEK5iDvMycdcVCKtfKeUuDLQDW482rA>
    <xmx:7vjFZlvGYZQzKuuh-ppb4ugHpruxf9pIzMzFTDsm-Lotz2HBdGRFoQ>
    <xmx:7vjFZsqEZPMs0rB5LbnWB0zsSefRJWoc83pOiQUO8s_NbnrNTNJJoViZ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Aug 2024 10:25:49 -0400 (EDT)
Date: Wed, 21 Aug 2024 23:25:46 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: update fw_device outside of
 device_find_child()
Message-ID: <20240821142546.GA48808@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org
References: <20240820132132.28839-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820132132.28839-1-o-takashi@sakamocchi.jp>

On Tue, Aug 20, 2024 at 10:21:32PM +0900, Takashi Sakamoto wrote:
> When detecting updates of bus topology, the data of fw_device is newly
> allocated and caches the content of configuration ROM from the
> corresponding node. Then, the tree of device is sought to find the
> previous data of fw_device corresponding to the node. If found, the
> previous data is updated and reused and the data of fw_device newly
> allocated is going to be released.
> 
> The above procedure is done in the call of device_find_child(), however it
> is a bit abusing against the intention of the helper function, since it is
> preferable to find only without updating.
> 
> This commit splits the update outside of the call.
> 
> Cc: Zijun Hu <zijun_hu@icloud.com>
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/core-device.c | 116 +++++++++++++++++----------------
>  1 file changed, 59 insertions(+), 57 deletions(-)

Applied to for-next branch.

Regards

Takashi Sakamoto

