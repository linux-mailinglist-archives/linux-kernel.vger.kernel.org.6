Return-Path: <linux-kernel+bounces-320466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48ED6970AC6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 02:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B785DB20B21
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 00:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977737494;
	Mon,  9 Sep 2024 00:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="PP6FcQoS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BgwTWWH6"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A896AAD;
	Mon,  9 Sep 2024 00:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725841356; cv=none; b=SlAdC9FrWSxMY9kmUYGOnqmCCG+1eed9Fp5mbUuTWPZ15TDzlrrlKXG9GsHSijdCojO6Ut18D6O2PV0yVQhLfDUIHk5OLNC8PzhkcySPSxJyLoTDzYcOozKZVdceq3rf8wK6sGSWu9exwFI3iatD9351DCbdLFxTOzStK4yPSwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725841356; c=relaxed/simple;
	bh=BB8kXN2EgBCCfFQjPpXdCitEj+cirpDuww651HyLdH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+ojTcMuYOofJJfJv00EM9QofWlWqaSfCIY6d9+t+ZDus68+Jmu71+QhsoVsm8SLLZSuKBalFlnB+huYaXxJ0rYWvJSh7LQ5lNu5YjVkdDd3Dpdivr+D6wrtfQnJk9/pw7TFbkkzW4boJ8b4138KBCxzlLJg1G2T0YtyDvrjUYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=PP6FcQoS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BgwTWWH6; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A811211400C5;
	Sun,  8 Sep 2024 20:22:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 08 Sep 2024 20:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1725841352; x=
	1725927752; bh=vfTPuiKjOfTpPO6Nz0ujZeNgem81DcoJwsV5O0J9rLw=; b=P
	P6FcQoScZ5VhBFne3PUej83FgoaZR0SMsqtYV59ip4KTxNSqBmNpByfLw5dcBMuP
	xX1sILHV/o75bp0zvv1SF1UHPbpZM6IBa1FFWmbrwCh7GwtlK/Vs30ykk9D/2yMD
	2YbIMHy1S8vSLxk9KDX3X4o8vdpv3PxMHglruhhJYoWnue7pvpG7xGOGlWmKAk7A
	nyy29NC6p+ojBaAs5QY3M9R4OKV9OlnzDY86d4jYNGurDi7WaNdmpGSDaT1Vq5UU
	eagvsE5eQctKANPPNUMrnTBAtr3CD/yKq4fz6CFv82aKdpxlal+hj+PQhDbJi2rD
	L5zvDGR9mhnk8dgMNOGFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725841352; x=1725927752; bh=vfTPuiKjOfTpPO6Nz0ujZeNgem81
	DcoJwsV5O0J9rLw=; b=BgwTWWH6iFcUMeUUMECSE8hCevKbPwS5YuxQRalSCJR8
	bYj6t9IsKRoKDmSSJchyflnpRolbl/ZFv0smIX/sabxQEDfMbbhQizoYip4ECaG/
	wlPV59Iu46uk0bYYnzUWpJ6xg6Fhu/h8tib53cdX1dSKgEB5REwe6WI/6VaXQBtJ
	/SQ4XWmYorMTtmM68aBXFHy+ZoqHkOxICjEfS0K98JEu29Hd+95HZBEGKpxIvHp0
	7MhShECDoJKhRcqwhNuZQXYm8AxQkd/2hc7HVqq+hcZkPZcDXuySQrKwR3zwod0f
	6f4yiVQeNcPEpO/IjVOEA4gI9u+cALeEHDBIW4TK5Q==
X-ME-Sender: <xms:yD_eZhxuUzZwFaqKtGziJNff42kADvI7mivhkwSzZHaXtkTCssqtnQ>
    <xme:yD_eZhQmOSg189DWBtSaNOnQGNYlXq8JX_xePY7Uid0b8QQoI_Z9Mhcn59-0LM0Vc
    EkIpyTZNfLs1NGaz20>
X-ME-Received: <xmr:yD_eZrWGW-K6Da1yGSGwo4BLPc0AtK2eajEr6t8AaAAdj8_cx_L_F7-LZbU7lG9zZNg6BEz1cD1HGb7jY70lCaf8LRmH1CG2s9EB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiiedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghm
    ohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrg
    htthgvrhhnpeehhffhteetgfekvdeiueffveevueeftdelhfejieeitedvleeftdfgfeeu
    udekueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvg
    hlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqshhouhhnugesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yD_eZjhlvgUwXfdq05orgObrGa0IvD7wHEVmKNn15zqRyV2hgMD8dQ>
    <xmx:yD_eZjAt5ZxTPLt_sZess0EQIiGEXGx4mA47Ay7AdL7woQQHiB2neA>
    <xmx:yD_eZsL5U31TZzz-hpK8vXaB6eCwhpxvOW5TlyKC0jnt4lBysMmcUQ>
    <xmx:yD_eZiA1m7wQoT24jtSKtGWRoJeU0nubborhXoKAdcDKNJ5DbTWoIA>
    <xmx:yD_eZqMVpcyi4M2neNjYhIiGkuLxiJvnoTMb8sC0e9kO34SnF4Ag_6rk>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Sep 2024 20:22:31 -0400 (EDT)
Date: Mon, 9 Sep 2024 09:22:29 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 0/2] firewire: core: allow unit drivers to schedule work
 item to process isochronous context
Message-ID: <20240909002229.GA84487@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
References: <20240908040549.75304-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240908040549.75304-1-o-takashi@sakamocchi.jp>

On Sun, Sep 08, 2024 at 01:05:47PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> ALSA firewire stack uses packet-per-buffer mode for both isochronous
> receive (IR) and transmit (IT) contexts of 1394 OHCI. To process time
> stamp per packet (or per sample in some cases) steadily for media clock
> recovery against unexpected transmission skips in the IR context, it uses
> an IT context to operate all of isochronous contexts by calls of
> fw_iso_context_flush_completions() in the bottom-half of hardIRQ for the
> IT context.
> 
> Although it looks well to handle all of isochronous contexts in a single
> bottom-half context, it relatively takes longer time to finish. In the
> future code integration (not yet), it is possible to apply parallelism
> method to process these context. In the case, it is useful to allow unit
> drivers to schedule work items to process these isochronous contexts.
> 
> As a preparation, in this series of changes,
> fw_iso_context_schedule_flush_completions() is exposed as a kernel API
> available by unit drivers. It is a counter part of
> fw_iso_context_flush_completions(). This series of changes also includes
> documentation about these kernel APIs.
> 
> Takashi Sakamoto (2):
>   firewire: core: expose kernel API to schedule work item to process
>     isochronous context
>   firewire: core: fulfill documentation of
>     fw_iso_context_flush_completions()
> 
>  Documentation/driver-api/firewire.rst |  2 ++
>  drivers/firewire/core-iso.c           | 11 +++++++++++
>  drivers/firewire/core.h               |  5 -----
>  drivers/firewire/ohci.c               |  4 ++--
>  include/linux/firewire.h              | 17 +++++++++++++++++
>  5 files changed, 32 insertions(+), 7 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

