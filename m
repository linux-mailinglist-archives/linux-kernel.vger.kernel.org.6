Return-Path: <linux-kernel+bounces-287316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ADD95264C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 01:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211991C21BE3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1119E14B972;
	Wed, 14 Aug 2024 23:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="TxHjceIO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t+wnsKU4"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BAB39FE5
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 23:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723679203; cv=none; b=hp7mnSuC06IX055V/JUbPhmS+sV/magwL8Xlx4+ncEPPSlyBT62RZLSjvCkpxF8u+tR5c523f5rctflv4anr0D4dUW1l4EHw1pohkVYS5GjmVJGJbomlRrcCvvF7yBDCe5J5XaYhELuZH5UIEUp7jJg3KpNX8S89TUx3escIbp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723679203; c=relaxed/simple;
	bh=NstZZzKPfVWghIrao7KIkcvUvW+2jd4+r6TOLl+90FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovEV3/6ECtQHXoxTvbKbK0Zff/TcbrunUZl/sGE2wE7g3FfwBZ5TeKVC8i7e/qYdJW1yPAlFM92bdVOdXzLucfzFfv9g/7goUkcx/TQyoOajp8P/48fhb1e5WnRtALI6NYAZNVpZBOoR/VvXLLHF/xTr52/F4/3xps1sFjJbX0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=TxHjceIO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t+wnsKU4; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 952F3138FC23;
	Wed, 14 Aug 2024 19:46:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 14 Aug 2024 19:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1723679199; x=
	1723765599; bh=eMMkPb4wq72gJTV++/aFkqKt3R3VFtBpA6zEx2Tt4oM=; b=T
	xHjceIOnyuD4GXmbqVyqmiEzKOQVSoYSanmSY1TLppm6O1aqgWBlR2ED4oijWxoH
	eLtjoEy1n6HA7iursyhL0FUzGhdlGq8ajDvbxoSJLyD+fIl2n+OF6+RMFh+j7sKj
	97SvUZgoNmLScAsaAwx3YTiaWpaEMzfxbUitxjr/lBXowbR7wQLoeL+u65S4KyIi
	o19Z4dLpHCo00H+av75YcnmqK17Kva1dnQFRFUNfBvXdzJPElINR4Gn7AK0/TtLH
	tm+xJ/PssWvFU6G0ae/jhC1j1MtEsXezpNUmXyWQM6nwYf919TKO9WnkODqMCbMq
	tBxwAiSaeBrVC4WAWOXjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723679199; x=1723765599; bh=eMMkPb4wq72gJTV++/aFkqKt3R3V
	FtBpA6zEx2Tt4oM=; b=t+wnsKU4uIXOzjHX3EQMB6N3cnl/iunmYAdcYjoIHpn5
	AEqh1qvNIPfpzbrorB7cArZrD9ndH+sezEPgUCQpcwTt9fIppGi5iKIQrXIn8MOh
	1HPKqbI/vchDMx67CBSUkyV/5AwrDxiLJrPUxwx6QwZLC7B3xnzKP7Ji7Ipa0o9t
	UON/r2zdWzQen7JR/8/rzw7tNq53JkkLS6JLewcCNe87485CLkVZYj3893c/Cuww
	FqZ8pXfoyrE+z+4TVEX+oggINk5dd1dmNeNdZRSbwMnvgz5YMhw+LoN/yNakwah/
	QDtInlryep+y43RjskKT4vwV7UoWSomU14EeH92F9w==
X-ME-Sender: <xms:30G9ZhXlfCXOitn31vQDFpaw1R9xId0XXeWiKQHOVeYnP3CcdrCzyg>
    <xme:30G9ZhmEUNld6tzzwG4M5OTj5dnsWDJP62bye6hmUqJYve5mt4vKzMzYJQNGOtza0
    lYNaXGFbHzqsnPEdAM>
X-ME-Received: <xmr:30G9ZtYMY0pV_A9p_Ed3GiZPZl0EiTXvFwDwM6YhwQEWzoCcbkBRXZAxKwxisyc0XWCR69GZjCnHFofHkvTgD2cTPs_BRcyOJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddthedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghm
    ohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrg
    htthgvrhhnpeehhffhteetgfekvdeiueffveevueeftdelhfejieeitedvleeftdfgfeeu
    udekueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvg
    hlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:30G9ZkUn4Fdq0fIVi7lA2M5WeRd0kD0k3Sk2R8nd6_vEJceKKBfsFA>
    <xmx:30G9Zrl6mBOMfaoAEOsNgT7BKIu7r2t__-rBOTx1x835jS9xHZCrBA>
    <xmx:30G9ZhcToWcWdeu9tOBkDePvOlZpn4uMToMWhwkL7AVi4BqaNqgPOA>
    <xmx:30G9ZlFcjdSQuTZQMFPGTNn0GX_CfZFBPjRGu-dM7Y6yBbeXcVu6cQ>
    <xmx:30G9ZgzGaJs54BzPfYgLNuE2KJoLqZUBsrtcSxnuMyaXRB24-55aEhwU>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 19:46:38 -0400 (EDT)
Date: Thu, 15 Aug 2024 08:46:36 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] firewire: core/ohci: minor code refactoring
Message-ID: <20240814234636.GA82950@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240814131222.69949-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814131222.69949-1-o-takashi@sakamocchi.jp>

On Wed, Aug 14, 2024 at 10:12:19PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> This series of changes include minor code refactoring in core function
> and 1394 OHCI driver.
> 
> 
> Takashi Sakamoto (3):
>   firewire: ohci: use helper macro for compiler aligned attribute
>   firewire: ohci: remove unused wrapper macro for dev_info()
>   firewire: core/ohci: minor refactoring for computation of
>     configuration ROM size
> 
>  drivers/firewire/core-device.c | 3 ++-
>  drivers/firewire/ohci.c        | 5 ++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

