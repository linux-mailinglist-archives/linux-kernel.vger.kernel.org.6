Return-Path: <linux-kernel+bounces-319146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD36696F87C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A6B6B211CC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891751D2F67;
	Fri,  6 Sep 2024 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="qUp7S0jn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B5zWlN+k"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8231D174A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725637355; cv=none; b=osZWAiDPiR06IDgnhzKGVRlqerpu6HUon/44la4eXm05dhbGCguUYCBI7Kd/Phs0fCVQ84yBc1V1qMfYFFN0+FGAu/9oYIVPAIGnMrx2ddSUPzDLRjrhvwJjpS7CZuSSOFbuu0rilafK95ZsSP7mFuk+hAzqG0FbfRVDt5j7v18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725637355; c=relaxed/simple;
	bh=P3rr5YJAaVWoSme9ITbg5yfn9tvEUuXQPnmI1DtZFwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neoFiyZyHfDxM5hVWxD6YJEIhoKYXCzMDUsDlO9mHmEgPa09XSYK3iV+wyJ4h27PCQ3kt4CTvEBsxK4dKb8wdcQwT9qUySejNWpeKN0iZKXQkVEM8uO5Ofbn1mna74VX36ymLFVMwShyoutEHceIUYYj7q0yF6w2LrcO48E9Yqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=qUp7S0jn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B5zWlN+k; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 080A511400CF;
	Fri,  6 Sep 2024 11:42:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 06 Sep 2024 11:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1725637351; x=
	1725723751; bh=Zn9EwZR+f+c1AkwKaGYP2GwIG4dZrbiiDbyQo5Bg3NU=; b=q
	Up7S0jnKo3KkLjK+bcYoZC2saLL8OSQyzTiYgD7fKAPOJMSyGu70cmhFpxFD3LMu
	ae/lsMIG+ECCQltnKxWqAhNKD9WWObOpWPxZNa9oVLFHnvs3CZY7rwL3rRNR7YB4
	mPsnWC1QPAfISok+6/u5mL03AlA+tWPPH8KNoDulFjpyrO15elbOfvZGjmOASSko
	c3SedzkFTz8QzFIbnESd7V6TklAUdIQozHTSVTJEdHs8NkNW/eeDoSB111b3cm9B
	8Tie5Xqd6hsNqvZYqYOwFvTDH4lAqlx0L2gKkOARgQU3/cVHxrypZLYUI7wj/8cA
	h9CNIXWGXl95PTZAoXegQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725637351; x=1725723751; bh=Zn9EwZR+f+c1AkwKaGYP2GwIG4dZ
	rbiiDbyQo5Bg3NU=; b=B5zWlN+kthmHXHrqVRyQ1Vd3HbgAx6g1FjTSWkBU5mrX
	/crJLt31VPitgSwJeokbs0CBhTfAD027wN/L9Jp1uIS8cpzA4m0/NqdHaOylgccu
	NKVO4KEd8qgPXQt6TH0zHf00KYF2QFAt9Kb9srjPplFQT5TbjqJW9BQVI4dJnVuR
	97/DDlGtJgcofxrgDFkYI7rUl6sSJSOoG4XfinNmquK8VJV/rPkXHNIBBWt0EuC5
	7eCmQh56oo4UtUhD3ETXdt8Edba0Iz0ycyYekPY9FPeg9JQSsJf3KHTbIuDNm6i0
	LdcOKcCzbwsHNWaNFqGSrqNB0mi+u0PkcrhXjWfQ9Q==
X-ME-Sender: <xms:5iLbZsXx9g8AGn4H_sSr18q5uOBA4DyPIgVr9Wz8uPxOlu1hdfCtrw>
    <xme:5iLbZgkL7qgNytRKxwVqt5B6o6JyrYT3I_eWIEpT1Sqa34S5-A7T5Aj9PModOFr-5
    8fhiwWhGhKtVjn41uU>
X-ME-Received: <xmr:5iLbZgYh8bxIkjUfNVdkRyGDWIBG5Dt9ijVdplXzA8BAIe4ClYGCZmmjiUUGA-QxJvZx1WoI0SEM4CEHCmUHpNkCFR9uX2arWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiuddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhephefhhfettefgkedvieeu
    ffevveeufedtlefhjeeiieetvdelfedtgfefuedukeeunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhho
    tggthhhirdhjphdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtggvfhho
    rhhgvgdrnhgvthdprhgtphhtthhopehtihifrghisehsuhhsvgdruggvpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5iLbZrXfwQAFvatz3Q-ENTiQdbGp7X2FFunnCr8oyPv2Jr1rIbz--g>
    <xmx:5iLbZmmiqO52PJErXomz2hZMBkRtN9Ccu16mrzkyxOQ2SuuZTH7f_w>
    <xmx:5iLbZgcZamdOwG_ospY13nixJj5m97bNEgCBqjx9xPAuQZPHtBxGOw>
    <xmx:5iLbZoGDuvFy7nXCihc-fWSbROEUr0k806svi-E63V7FVCz2-YpeRg>
    <xmx:5iLbZoj44xZyve97Iep-h3kF4FJrokhB2pdDXhbf9Me80u7nAG5lZNTG>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Sep 2024 11:42:29 -0400 (EDT)
Date: Sat, 7 Sep 2024 00:42:26 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: use WARN_ON_ONCE() to avoid superfluous
 dumps
Message-ID: <20240906154226.GA6012@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
References: <20240905131029.6433-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905131029.6433-1-o-takashi@sakamocchi.jp>

On Thu, Sep 05, 2024 at 10:10:29PM +0900, Takashi Sakamoto wrote:
> It is enough to notify programming mistakes to programmers just once.
> 
> Suggested-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/core-iso.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
> index af76fa1823f1..a249974a0f87 100644
> --- a/drivers/firewire/core-iso.c
> +++ b/drivers/firewire/core-iso.c
> @@ -220,7 +220,7 @@ int fw_iso_context_flush_completions(struct fw_iso_context *ctx)
>  	might_sleep();
>  
>  	// Avoid dead lock due to programming mistake.
> -	if (WARN_ON(current_work() == &ctx->work))
> +	if (WARN_ON_ONCE(current_work() == &ctx->work))
>  		return 0;
>  
>  	disable_work_sync(&ctx->work);
> @@ -244,7 +244,7 @@ int fw_iso_context_stop(struct fw_iso_context *ctx)
>  	might_sleep();
>  
>  	// Avoid dead lock due to programming mistake.
> -	if (WARN_ON(current_work() == &ctx->work))
> +	if (WARN_ON_ONCE(current_work() == &ctx->work))
>  		return 0;
>  
>  	err = ctx->card->driver->stop_iso(ctx);

Applied to for-next branch.


Regards

Takashi Sakamoto

