Return-Path: <linux-kernel+bounces-435824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DA99E7DA8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 02:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74262286918
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 01:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DB38467;
	Sat,  7 Dec 2024 01:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="fgjYJARg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lKAhxmXN"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289134C79
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 01:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733534005; cv=none; b=ozPj5QvyjZmkYZag1JXW/ZE5TFi7AATtdnQHZZUuvX4lI78DUZVbPUu9+cj25/VK/wRDr7GkIAgV7HowmDQfq/gJMm2WPDslG9f/dokMDZEP1uMlIGtC3y/b6jeyfQmT4b6TMq8f+8sMQ5EK/Fpo/RJGodCofUaIrGCuk5M4Z6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733534005; c=relaxed/simple;
	bh=AYoHdGQowcWo9x3vDT2j/hIca5ZEUEnEFJHZj/2mLGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkYf8VbbR9Y8TccVfer4CCHPvOvekCMeR08OAkQbbw0bf5IiHfEezZfChEMlyGmLoL3elB8GCzwzYBscEtWjRIbpe/y1uuxE9W/NxDA7gIeMLoMeqA8cKh95n7TqGX74DK74UN+2bAPWFhS5rb015buRK+A6BlaLoFDscE+Y3Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=fgjYJARg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lKAhxmXN; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E610E11401BF;
	Fri,  6 Dec 2024 20:13:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 06 Dec 2024 20:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1733534001; x=
	1733620401; bh=g7z1jVtmM7j1+OaUW/MUyU9UTEWnAzeQ4ULDFVf3T88=; b=f
	gjYJARgaAAUx45IrJLKp3Pajs8OlZ49IYPytf6I2u/EPzkwG0m2Wktp6zQi3Z03T
	7XDtVRbd/kINubttopLzejkTXYdGNnUxkayHLq94+qN51iOr5uvbIralyb7Butxx
	4S2ZSXOKc0tPsRnuOWiLgm4KmMr5co1zSIPcwu682dz0OMbNv6iTfwZjBDJPRyM+
	sfv1seReAGpb8UsTw412L97lnplrEuKHH3q9Sn/DcAWVBc0RvrkUA1wleGsjleNt
	O6nqbZp4cl53HnqdXefe85/2ZP9FCFNfBY1b7tarXUHiGJjxok4Rp22QEATA6YFj
	HyAACcZCUc9p61AOaPR6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733534001; x=1733620401; bh=g7z1jVtmM7j1+OaUW/MUyU9UTEWnAzeQ4UL
	DFVf3T88=; b=lKAhxmXN9IqjDz02bvfwla2x4yr7r+CAOJde6np4NhaoshsEgDc
	yYqCTst63+bi33GT/B+hSbR1eM/CDRXQiOXN9WOE0ITs6AfMJueFzKhin4qiciWd
	s0MUsy9qakgi33ucpFDG1Sqkp2u2bdYmnzWgd01utwP1TYswpxhe92GApA5e1Vft
	TLrWx5tgwWfRNR7W/eVPYjtS5t9i6wlpZqQhYlbtIVrYG78YWc48gP3bKDG0ztDW
	KP/kHzMZlKE64YYr2fmyZWDbTXuPLZ7BAYNq2abPfscuqUVDz6pPhLbABXEOH73G
	PVd5h54zHkFfmanSvIR4D3290Z4QdwYWmdg==
X-ME-Sender: <xms:MaFTZ9A_glOoSnrux4PTfH2hO0yRAdOONQV1mCHIHzKFss4mrj9ylQ>
    <xme:MaFTZ7gngA9QjeVB7xJwP_35K6CFUp_scQ2ACgmKapVapz02uzGDKYxwbygMxQtE0
    Gy5rNonZyKh35SEyTA>
X-ME-Received: <xmr:MaFTZ4mRQOKqZZG6POTkdLS8LUGpqsSHntwIy0O1ZzhcZj0q4acTesC3LR7jt8V1fCXjCHO4WLfbAWWvY0Mo48odPfD4-SkYN0M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjedtgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeehhffhteetgfekvdeiueff
    veevueeftdelhfejieeitedvleeftdfgfeeuudekueenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgt
    tghhihdrjhhppdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehvrghisghhrghvghhuphhtrgegtdesghhmrghilhdrtghomhdprhgtphhtthho
    pehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigudefle
    egqdguvghvvghlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:MaFTZ3x5bpVxUY06GYMmyjwTlauOCN33DSY-dIchJg5LcaBEEqTNuw>
    <xmx:MaFTZyTmwqNXsU6xRgc2vyurX8NCJgBC79zhMa0L_3SN6lj0pV1Yag>
    <xmx:MaFTZ6bx1rY-w1D8AqbfPNG3w7VgmuwaEQteQGCjtzzkX7Is_9DTcQ>
    <xmx:MaFTZzSZRSIXmRfFh_8ia2QwUt8wcJs3jHg47EOAKDfldD9i6DejIw>
    <xmx:MaFTZ4OalWqTpUzHhOKT8ZDsoeG70GHqYL6A-spJufsxevF4Gq3-Vc6d>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 20:13:20 -0500 (EST)
Date: Sat, 7 Dec 2024 10:13:16 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] firewire: ohci: use generic power management
Message-ID: <20241207011316.GA148867@workstation.local>
Mail-Followup-To: Vaibhav Gupta <vaibhavgupta40@gmail.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20200720150715.624520-1-vaibhavgupta40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720150715.624520-1-vaibhavgupta40@gmail.com>

Hi,

On Mon, Jul 20, 2020 at 08:37:16PM +0530, Vaibhav Gupta wrote:
> Drivers using legacy PM have to manage PCI states and device's PM states
> themselves. They also need to take care of configuration registers.
> 
> With improved and powerful support of generic PM, PCI Core takes care of
> above mentioned, device-independent, jobs.
> 
> This driver makes use of PCI helper functions like
> pci_save/restore_state(), pci_disable_device() and pci_set_power_state() to
> do required operations. In generic mode, they are no longer needed.
> 
> Change function parameter in both .suspend() and .resume() to
> "struct device*" type. Use to_pci_dev() to get "struct pci_dev*" variable.
> 
> Compile-tested only.
> 
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> ---
>  drivers/firewire/ohci.c | 43 ++++++++++++-----------------------------
>  1 file changed, 12 insertions(+), 31 deletions(-)

Although it takes a long time since the patch was posted, I applied it
now to for-next branch with my handy changes to optimize to v6.13-rc1. 

I still have a slight concern about the operation specific to powermac
platforms, however let us fix when receiving any reports from the users.


Regards

Takashi Sakamoto

