Return-Path: <linux-kernel+bounces-232367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B6E91A7C1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DEEB2817E9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B8A192B9E;
	Thu, 27 Jun 2024 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Y20+yAcK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ugd8S80Y"
Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108EA1922F4
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719494500; cv=none; b=qbrxMD8uff5p5E6NAcIdNqzdcBXWEKj7gXsx3w/B8Gwwsb+6ptFr93cwFtqwmiQUTp1Zf1OpGbOou9GB6FwM9nZpCCOBqD3iRNTsJbK3cWEXHmHMSlDAK7xAnenzpK7EYZ74SfX/5oRh3CYF4GNeY6znqzMMToBz3CCeOSdddrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719494500; c=relaxed/simple;
	bh=uVauWxK+ufu5v1ialmUbw78BysmisQjMfPXCzOqYT6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcdxQQxmIbL+FTFgZPizsVntXDP2f1fLDqSTHIqUdhwJozLxVdK852r1GmMBD230usxGhBJU1fuSc0ycfsRwTbjmF1Ft6VwgC9wRTkcS5U9Q/i+mwN9KJP0fcocb9Q71lPDuklZBhBsCdWwvLwBzAYQi16peqTcprfW1d1EdJic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Y20+yAcK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ugd8S80Y; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id BF0F01C00090;
	Thu, 27 Jun 2024 09:21:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 27 Jun 2024 09:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1719494496; x=
	1719580896; bh=4KbB6tEIppaeu+O5uCFPldgsfTP1h3ugpnHp8fkzIwc=; b=Y
	20+yAcKaBXLBlj0eE0kAETf2Gx+3EfHlrZ+GWobssGPTLGooU11UjPscF7crPeGA
	iDvXJOFu2GsG0fRsVmA0lIa0pKMg0U9M3fAo307VYQhuLQXkKK0f3ZGQ72HUoxBJ
	l8A7367NbvIBi05jXsRqc2y2dgpKhqb20+Ujo7TvtNZIC1q698P8FmPDtiDNXu30
	Nwtoxao7BlIqyo9xRCjMkNyhl50gJryrTtYhjqpozShC1Agmz0gjmcR04z94iTa6
	yzHNIUPwikupOAsVn8Eq4sOdgCDuT2xnvUyFHDSuQDQHkR/G7ZbkaSqpoyk3ITUj
	dY64v0CQI/rmnZ1DjrCFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719494496; x=1719580896; bh=4KbB6tEIppaeu+O5uCFPldgsfTP1
	h3ugpnHp8fkzIwc=; b=ugd8S80YQxcdvijyqknDpj8t90iv3EEebfk3tDKkjDsN
	MhncbMwn1eoxhnb149xGQkKDvk9EUNMWCrM1iFodxwRdGZBqcwlKkotcQ5FdCQSv
	Ip6T5f8AMVIqh7EzlDfAKy+t+h2JGJdcvrCUox0PhTVi31MR0CLaaUjk7HaKicG8
	MbRf57y1LiKhGoDjHOG56UCXuDQwzFDfdLJsMNNOZeJxlHqgxPGDuzqKPPcaoJrV
	GDwH8f9+1G3O36B/1P0xkdDOqxeSj9PM3/2I1Fl8xvMZ0Muqiei2otbmPqS+CIl6
	LbPwD63QKjkENq/DPiQy976yuk2LH/0eahq5vaHNKg==
X-ME-Sender: <xms:YGd9ZsXl0t075tdWRiM8wlRicdEzoT02fQARt0xl02YCkDNa-7X5ZA>
    <xme:YGd9ZgnvzNyrFuOr9xu6C6UF2eSASw03D3ffnNyQAo260ptqK1MOPnRRR08OOF9et
    qavIvgej4sDSMct8OA>
X-ME-Received: <xmr:YGd9ZgY1sEMK1oKw4b-O0Fi-tP_UhuV5fAsPzrfXCPIcjsu3uczC07F0WpDUZ3AuCSNOCQ1iFbLGtoTdOoU0zcGXdwJPeAIFXms>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtdeggdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhephefhhfette
    fgkedvieeuffevveeufedtlefhjeeiieetvdelfedtgfefuedukeeunecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:YGd9ZrVjFXywwH0ldYYHxdeCXzf-Hn7nZMlB0ovgrhfAmT1W4Tj7cg>
    <xmx:YGd9ZmnWzykEK6WnCDvt6wEiie7rigcov-yaX88V4G5cwO-bWRm3OQ>
    <xmx:YGd9Zgc90799wuNrmJ3GKuJq_PJm0kIpMthksfHJ2fAezsheO4Wctg>
    <xmx:YGd9ZoHX1jyzlACOebZUlM0KjMqpQ0qsCCt9dpgk6H7w7XnOe5Kvqg>
    <xmx:YGd9Zrzn7Wrk4v7Zs_NVMMBCa2LBl4k5SfCDYsFDiYPBlbM9lkit9yXg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jun 2024 09:21:35 -0400 (EDT)
Date: Thu, 27 Jun 2024 22:21:35 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] firewire: ohci: add support for tracepoints events
Message-ID: <20240627132135.GA965648@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240625031806.956650-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625031806.956650-1-o-takashi@sakamocchi.jp>

On Tue, Jun 25, 2024 at 12:18:04PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> 1394 OHCI hardware triggers PCI interrupts to notify any events to
> software. Current driver for the hardware is programmed by the typical
> way to utilize top- and bottom- halves, thus it has a timing gap to handle
> the notification in softIRQ (tasklet). The Linux Kernel Tracepoints
> framework is enough useful to trace the interaction between 1394 OHCI
> hardware and its driver.
> 
> This series of changes adds support for tracepoints events to the
> driver, and adds an event, 'irqs', so that comparison of the event and
> any event in firewire subsystem is helpful to diagnose the timing gap.
> 
> Takashi Sakamoto (2):
>   firewire: ohci: add support for Linux kernel tracepoints
>   firewire: ohci: add tracepoints event for hardIRQ event
> 
>  drivers/firewire/ohci.c              |  4 +++
>  include/trace/events/firewire.h      |  1 +
>  include/trace/events/firewire_ohci.h | 47 ++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+)
>  create mode 100644 include/trace/events/firewire_ohci.h

Applied to for-next branch.


Regards

Takashi Sakamoto

