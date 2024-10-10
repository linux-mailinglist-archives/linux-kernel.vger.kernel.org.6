Return-Path: <linux-kernel+bounces-358642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 202439981E5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2811C26423
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEAB1BD4EB;
	Thu, 10 Oct 2024 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="THL5Fe8N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bkoc27xj"
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87331A0AF5;
	Thu, 10 Oct 2024 09:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551772; cv=none; b=m10P6YiwLc7JsAzOAdc5GiIiIX9dd4mZx1SMc3yGnrs7IE/TB3ZNY8/4B5qTzowor4SVLwVsksJrutLHWMwiQr553LwkjP0/euBVS8UO8EOTTCBR/ZNBeLKotj2/MABWMDbpe/F1/+3/ZkHaAI8cwbP9pjpZV/f7Rn9y+tjX/ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551772; c=relaxed/simple;
	bh=6F7gsY3zxZOCu5XPgIF+qfkkYguPkDIkva6myNI0Slo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pX5/y6s5m40oaMyuz8S0MlBKr8I8LZj3KlrUJ0LAYejCBOoq3R8W/KWlc+/10lrQvtXGpwjqQ5JA+nYgPkn5DjC15UQE1MM2NsLE7RZkNn7DyX8L/LlPyLJIjaXcH3HGiHRIJIOrLtiDXWs7dk3evl3HZ+/BajHqyxRRTAENLZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=THL5Fe8N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bkoc27xj; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D0BE413804D9;
	Thu, 10 Oct 2024 05:16:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 10 Oct 2024 05:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1728551767; x=
	1728638167; bh=DzC6lX+E/78Mu9gpg/UDozeH+U4hgVP1fbmTpf8/dD4=; b=T
	HL5Fe8N0YRwo3BnXY7dF7YlCXD88r7tQCs4Xax8YqCG164EKbHFclSBYkJRRxXDU
	cfubDEwX+SzEJkDVmXLerhVSAu1Mz1XXTorIcQSyuSBKITO7Pva8JRuGUb/nRa+x
	dMPlWvW9aQzmuxF3iP7PUKaAcMABnEu2GVAqdAvUPb1yyU1tTi72/tgReuKv8Ydw
	78f9jOyLDgKk2yifVwEHcBqU6y8GxFwTH7tJ69vOtv8YxYdq2jFZDvRYAW3ez/sx
	S6wr52mYHi9SaulwWWlXag/bMu9Sf0sGDoY4mcRo5Pxx9lOmuFUusA3oS2V6h7+p
	vTHeTp6/fwckVatKHdngQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728551767; x=1728638167; bh=DzC6lX+E/78Mu9gpg/UDozeH+U4h
	gVP1fbmTpf8/dD4=; b=bkoc27xjPsMaBRJRXcCaRAZRRaKqmTOT6+EM7eyM18QN
	1wz/rysM3i3vMRgZHAd4f6svMPtKLPzvLTN74Yd/I4ekD1VNWzUHzs/k9JxHbdcU
	bvxUx8I4HdUOPy/sXpvfqv1ElQxzuFcRfDmYDXpqhrTJlP5KtjBo9hfKk3+YHgPc
	75IiGyPQbO5bJPiI9/yvbOaRUGA5g3qWip8t0tMfHxRdNAdc3z0ucpXJnTMbe2a9
	GOBW6ouoh2IaiTV/ebhRzyGmSpDEX92QSP0qYn3fQNlR8o1SJRuSPzis1B2Surrv
	WV7uMt4PCEOc+M7pGWFjIY4baUodoG6eh8eMYaW2PA==
X-ME-Sender: <xms:V5sHZ_fbCxwPZKTvcELLdkbpCOXFEGgi2NP2dNeOj7VKjf3j9gX2VQ>
    <xme:V5sHZ1OuVtouD0J7GL0jh2diCh1duJT6B0ktLad1XOFm0RHGuJ1SxIO9tZpmx6CWZ
    aYOPQ47x041fq5BNvI>
X-ME-Received: <xmr:V5sHZ4gja32Mslt3xTrU3EPwSNLa7NM6_LKte-DOTqSyVelV_RSp70YYMIG9LqkZs6GZYnHCPMHxZLxIcoYKddumDi3ZnFgSsHU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefhedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghm
    ohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrg
    htthgvrhhnpeehhffhteetgfekvdeiueffveevueeftdelhfejieeitedvleeftdfgfeeu
    udekueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigsehtrhgvsghlihhgrd
    horhhgpdhrtghpthhtoheptghlvghmvghnsheslhgrughishgthhdruggvpdhrtghpthht
    ohepphgvrhgvgiesphgvrhgvgidrtgiipdhrtghpthhtohepthhifigrihesshhushgvrd
    gtohhmpdhrtghpthhtoheplhhinhhugidqshhouhhnugesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:V5sHZw-9zZ6JtWtVDiODCcx1IxtU8iTgJ-B10IhZ-heA0Dr1qtyqPg>
    <xmx:V5sHZ7u9jP3WD9oP6qLLpQjfLY2jy-VySe5hmK8SVERfuFl4UfazYA>
    <xmx:V5sHZ_FmrfqyKYU2UrgBkYnke2nkTfEe0EZyfnaas1DA6azUjs3sjQ>
    <xmx:V5sHZyPsGt06JK8IFHIoOPR1ZIvkJYoppJMu3aFRAvERgpB9YAgGkg>
    <xmx:V5sHZ_gsFC6QHIpnHH0yEnjtpRtn1lm0tW8unNeneKt4J4OXEvIcoDEj>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 05:16:05 -0400 (EDT)
Date: Thu, 10 Oct 2024 18:16:02 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux@treblig.org
Cc: clemens@ladisch.de, perex@perex.cz, tiwai@suse.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: firewire: Remove unused cmp_connection_update
Message-ID: <20241010091602.GA144496@workstation.local>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	linux@treblig.org, clemens@ladisch.de, perex@perex.cz,
	tiwai@suse.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20241009003653.254753-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009003653.254753-1-linux@treblig.org>

Hi,

Thanks for your sending the patch.

On Wed, Oct 09, 2024 at 01:36:53AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> cmp_connection_update() has been unused since 2019's commit
> 7eb7b18e9fc7 ("ALSA: fireworks: code refactoring for bus reset handler")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  sound/firewire/cmp.c | 47 --------------------------------------------
>  sound/firewire/cmp.h |  1 -
>  2 files changed, 48 deletions(-)

Indeed. The issued kernel API is unused.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Thanks

Takashi Sakamoto

