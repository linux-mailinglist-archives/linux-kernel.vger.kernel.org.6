Return-Path: <linux-kernel+bounces-215717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 996D190963B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52126282008
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 06:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A18717BA5;
	Sat, 15 Jun 2024 06:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="MIeIXuv6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RTwuwVLT"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7736179A7
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 06:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718431309; cv=none; b=FoOymPAXNvDuVGLvAzkE4hoCb2d49DX34epd6wxnE/urFyBykDSuCxuNIQvfG8+x19oR8G1rv5H6/mgV/oDGf1WBkHGT1I+IkLexhntbGyBT4ArAYEqzS5KyiBnNlTo09MJxM8mTPQc7N+8ItNU6zAL7H4d8Is6RyCKd5IUaEVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718431309; c=relaxed/simple;
	bh=POHjLfvVul8Nt2xxauu5W0L4q4Y4dFr1jlfOup9+hcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAQAntTGI3n0vAepWtBBgAoYJQntTvmwj5edVtAZqkEAMfn1XRC+aJaqifdt4taTW3/25Gx0EThPq4m54Sg8bvoKhvEt995mNQxkmD9700geUs7C9qetBSk8AskHJerwESbWS214+xT8bxKZu2VIEp1UUWCbmjk4EW43X/1W+bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=MIeIXuv6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RTwuwVLT; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id EADBC13802E0;
	Sat, 15 Jun 2024 02:01:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 15 Jun 2024 02:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1718431306; x=
	1718517706; bh=Ut+CKX+eYnOgJHTPoNOfgg3PZFekCdvoV0ptxsFX8P4=; b=M
	IeIXuv6UsRJTUvaKnxGh+dyKSt0FqTUQSpZU7Op/eB4ab+9ZBrQI8SIhdrg71lAc
	TBvcbD+2914XUalxlPnLkWsisoMl2Me0w8pAmRTEK17GW8YDvNfficb3Ns0fzzWr
	ySTe8sL0OQv97QXchCbG+9kpysJornRPljyCk+nVDjQwclXyrRKS1H3qa8IYUnoj
	9zgfLX0HL6cZJtf8xtmQDz9qS2BqvQs0g2X6RqijRZuP2eo6qxHjX6RW4Z2ywkLa
	I/ac/E8M/Dtdwu/aMQQdeholtq/LI0YkxWwd0oYyJHARU/jztUR9tW3pG+FjPvXe
	WNEJWeI5eZLWvyhUGg9XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718431306; x=1718517706; bh=Ut+CKX+eYnOgJHTPoNOfgg3PZFek
	CdvoV0ptxsFX8P4=; b=RTwuwVLTWHaQn6lHJlKNTsDg6e6SgMfwd8+PXUNFYSF/
	NPdoOCeKi27VTIL+lkx4ephbg/A4lEam7NE4+37wPwUwdUrnV17lMjWcdK1iGzQz
	Am5t72LKD1RAdAYLOaB76nrDKqptp76KQpAcMBr8+NklcizglcGCYHK5xc03pEvj
	QFi58nUAtAxSF3mrmvMMA+nCsQmk9T7lCKe12ztkEbVLyKzkiM1JRXtNkjXm33zn
	PIsTHZj+oNEbxEhz5NLW2CIpAC2NXhsG+6U/tEIdqlAs7o5hg3tl5E8woCwyYIMP
	sSUdWytuTxIqbgB5B5ZsbN/I/LiBnPueQvcNSvzaVQ==
X-ME-Sender: <xms:Si5tZsHeneIYr2DFcYsa6fAlzIouPLLxl4FNqy0dO6Tpvf3KXHu6GA>
    <xme:Si5tZlVaO1NtKEjFXwmnpGJfjO300ojv15w8b4-cIjwesRrXDZ43eeToWjtq_nug6
    1v6in79WeBZx1-GPKg>
X-ME-Received: <xmr:Si5tZmIsKre5V2qpsQwuIVbNiibR5aW00m5BhjOhBjfr12nq10ZClfxHv-GLNei3_xmHHS99YpHOzVGFfAoeFMflsYj7tjsGuiZY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvtddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesth
    dtredttddtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgr
    khgrshhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhephefhhf
    ettefgkedvieeuffevveeufedtlefhjeeiieetvdelfedtgfefuedukeeunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhih
    esshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:Si5tZuFdEAyXGcBC7RniVCQ4G1Fl2qIrluXWWxOi_EJ-2cOH-fwJFg>
    <xmx:Si5tZiXj_7y0bJSONoWhmxMCP0p4Vtu7xVxhYFYe0naP-A71JmSLvg>
    <xmx:Si5tZhORCVwgppsXhFBCCvj6LDzBwtKdtbsfxiL4ikFGg3quWR3_3w>
    <xmx:Si5tZp1oi3JiYetMLlt4enaYii_6WlLnTEMXSmwfaug7kaW684ymjA>
    <xmx:Si5tZvhPNNdyiL2JrS7Pe4CTCB1pOcqPYhzrHkE40AbtYnW6eBh7HXx9>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Jun 2024 02:01:45 -0400 (EDT)
Date: Sat, 15 Jun 2024 15:01:43 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] firewire: store the numeric identifier of card in
 data structure for tracepoint events
Message-ID: <20240615060143.GB497879@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240613131440.431766-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613131440.431766-1-o-takashi@sakamocchi.jp>

On Thu, Jun 13, 2024 at 10:14:32PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> In v6.10 kernel, some tracepoints events are added to record
> IEEE 1394 asynchronous communication. In the case that multiple 1394 OHCI
> controllers are available in Linux system, it is hard to distinguish
> the controller used for the communication, since these events have no
> member in their data structure to express the used controller. It is a
> bit inconvenient to diagnose things.
> 
> This series of patches is an attempt to solve the issue. In Linux
> FireWire core, the available controllers are maintained in list, and
> each of them has its own numeric identifier (=card_index). In this
> series, the index value is added to the data structure.
> 
> I would like to put the change to v6.10-rc4 (or later) as the part of
> fixes if receiving no objections.
> 
> Takashi Sakamoto (8):
>   firewire: core: record card index in tracepoinrts events derived from
>     async_outbound_complete_template
>   firewire: core: record card index in tracepoinrts events derived from
>     async_outbound_initiate_template
>   firewire: core: record card index in tracepoinrts events derived from
>     async_inbound_template
>   firewire: core: record card index in async_phy_outbound_initiate
>     tracepoints event
>   firewire: core: record card index in async_phy_outbound_complete
>     tracepoints event
>   firewire: core: record card index in async_phy_inbound tracepoints
>     event
>   firewire: core: record card index in tracepoinrts events derived from
>     bus_reset_arrange_template
>   firewire: core: record card index in bus_reset_handle tracepoints
>     event
> 
>  drivers/firewire/core-card.c        |   6 +-
>  drivers/firewire/core-cdev.c        |   6 +-
>  drivers/firewire/core-topology.c    |   2 +-
>  drivers/firewire/core-transaction.c |  30 ++++----
>  include/trace/events/firewire.h     | 113 +++++++++++++++++-----------
>  5 files changed, 92 insertions(+), 65 deletions(-)

Applied to for-linus branch.


Thanks

Takashi Sakamoto

