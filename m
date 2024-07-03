Return-Path: <linux-kernel+bounces-240347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7DB926C74
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CCA728592A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48700178377;
	Wed,  3 Jul 2024 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="k2e73T4W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tpP7ooKB"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E5E1C68D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720049455; cv=none; b=fIXjz+4N29NegLPvJue8yuGGDhIq9wNJrGHnAWrOYfd3gDlEguBYOVzJTh8Us+2F4iJl9JplRPi+Id/SDkhzMLCqqRHNWcPRL46e6MQadDKxBEBFcSqr59bMLHK6KEFliq8eBjna0EwLXDrDN/fxjpxQWyjIQ9hRZ7RhuCRmoEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720049455; c=relaxed/simple;
	bh=jv9izjVCFx08jaRmdoUJ03mx+SPiEKMPfOvx7XvV0/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1JeeHBvSZyO37uEPiyIW7E9fx8InIxB9GUcF6G4kpSmQp9wpwjxWQLNjvndbttGaxzTVU5r4vux6Pfixo1Aurou5Y61oCMf0E/jJDpxd7GVV5jypKCX4vEsvEbjyPd0009VGdIeBveh6FyueGJ8wZ3qsnTZdnASlwXJyOadHM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=k2e73T4W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tpP7ooKB; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 846831140274;
	Wed,  3 Jul 2024 19:30:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 03 Jul 2024 19:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1720049451; x=
	1720135851; bh=Wk19BgkiX8lgErfCjZ7uFzpS8AsJuw3QkRtAF46r3yo=; b=k
	2e73T4WKwZjrZLCOCkSs5m4GWJ9t+EViJswf3KIGkqrXjSKH+cDyHC+C1FCnmrLf
	Ya+Me8DVeJR3B51pWoAlJAj/xhWsabhSCLa4uYiIc4kExhIj8iXrAME5IhXLGy3p
	8TlO0JI96hUwP5V1um/5xE6fcxtixRPZ/kX+ct2yzpwXfewwBEUayLvuGfWgX1QY
	lHZu+fhGnVpK2NENBe8AYTzYW9XB4pc3vB5Q7NVmjYXlCNqfs2BFb7di3QM7/EEr
	cJr36kdIhbfCHx1vQ0zevYUPvi0ZWnXxx8FvlRccXCd0Qg3i3BoCbWxslnjUUE02
	RHzq0OO9GlTMn3VAJ+LPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720049451; x=1720135851; bh=Wk19BgkiX8lgErfCjZ7uFzpS8AsJ
	uw3QkRtAF46r3yo=; b=tpP7ooKBfmqDz+1Ob6MOPzzNvG7et4cDh46dNNCnnYUS
	s0mMHTme82NsYhLPUo+L2WhtMn+Swm8n4nuc4Vt86lsitL7AXXDogKfb4lfgVgz1
	x8GZc/IEVeVrQIvdveQG1n3V1q+jYIHQQvoVkKAiJZR3ZUsp+r7LY+j45fQfEVYd
	veV8vo8zjhL0EnnxXzifIyE0xUN1oDLdg9MnkWLDYgAEJgkFA7zisA2MIbIw7LFh
	GXxSffHbxJ78Omiu2t+n0GzedxMpPlQF3WbKo8NJ52YFIctXmFe0z7gFj46xxYu8
	/n7uA7Cmp9cKvc8iUiTvZaxTOqP472E++iRyxVOMnA==
X-ME-Sender: <xms:K9-FZvX9SxQqN8CC1oaGXJmyLe5rBhOllCAnD_gg45UDjXPgvGgenQ>
    <xme:K9-FZnlbV8ZGoISAaDDkrOG7kDdeau-ABw-47gXcK7u-AOoyX-VTvcRPnA9FI2MaO
    gQjsOighVjMYBokF0s>
X-ME-Received: <xmr:K9-FZrYATSixmIm8yojwRJRcRScJ7ezqoVvLl0nGkHlOEYaCUiS7mWN8vLXYB6nXNr8jnmldhnswB9lq4HZdjPYraiZZ9CXTwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhephefhhfette
    fgkedvieeuffevveeufedtlefhjeeiieetvdelfedtgfefuedukeeunecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:K9-FZqU9GBgTMmP2wZz22u1Ghj_0M9iTFsqGVYqbqgYXQW3gssCJaA>
    <xmx:K9-FZplBFDCvGdKNHGlT-JDcHTsGHsLSmZ-L0fJbSYCnpLmghs9zJw>
    <xmx:K9-FZncAglNWV63K9GkiiccQedD8hlss23ZD2AGHzZttGkR6PHPktQ>
    <xmx:K9-FZjGuFm3omMh75C4zsyBU3mTRQ1t5yffMRUiVtAamEDhCZJ0AlA>
    <xmx:K9-FZuyIQgZmju-Qg2QKlSYv06XaaumdS3wRWK0GUD8eBu0PPgp4cLX5>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jul 2024 19:30:50 -0400 (EDT)
Date: Thu, 4 Jul 2024 08:30:47 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] firewire: ohci: add tracepoints event for data of
 Self-ID DMA
Message-ID: <20240703233047.GA1441700@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240702222034.1378764-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702222034.1378764-1-o-takashi@sakamocchi.jp>

On Wed, Jul 03, 2024 at 07:20:29AM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> In IEEE 1394, Self identification process is the last step at
> bus configuration process initiated by reset. In this step, all nodes at
> the bus broadcast self-ID packet according to the new topology. In 1394
> OHCI, the contents of the self-ID packet stream are transmitted to host
> system by DMA. This is Self-ID DMA, and configured by two registers,
> signaled by an interrupt, has a format of buffer.
> 
> Software handles the interrupt, then parse the contents of self-ID packet
> stream to detect all nodes in the bus. Finally it starts any type of
> operation in the bus. Both the timing to handle the interrupt and the
> data of DMA buffer are important as a first step to use the bus.
> 
> This series of patches is to add a tracepoints event to trace the
> interrupt and the data of DMA buffer. It would be useful to diagnose
> some kind of issue related to the self-ID process; e.g. hardware quirks.
> I also expect it useful to investigate the timing issue between hardIRQ
> and softIRQ contexts to process the contents of self-ID packets.
> 
> Takashi Sakamoto (5):
>   firewire: ohci: use common macro to interpret be32 data in le32 buffer
>   firewire: ohci: use static function to handle endian issue on PowerPC
>     platform
>   firewire: ohci: add static inline functions to deserialize for Self-ID
>     DMA operation
>   firewire: ohci: use inline functions to operate data of self-ID DMA
>   firewire: ohci: add tracepoints event for data of Self-ID DMA
> 
>  drivers/firewire/.kunitconfig        |  1 +
>  drivers/firewire/Kconfig             | 16 ++++++++
>  drivers/firewire/Makefile            |  1 +
>  drivers/firewire/ohci-serdes-test.c  | 56 ++++++++++++++++++++++++++
>  drivers/firewire/ohci.c              | 60 ++++++++++++++++++++--------
>  drivers/firewire/ohci.h              | 43 +++++++++++++++++++-
>  include/trace/events/firewire_ohci.h | 54 +++++++++++++++++++++++++
>  7 files changed, 213 insertions(+), 18 deletions(-)
>  create mode 100644 drivers/firewire/ohci-serdes-test.c

Applied to for-next branch.


Regards

Takashi Sakamoto

