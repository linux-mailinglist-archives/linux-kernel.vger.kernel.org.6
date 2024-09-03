Return-Path: <linux-kernel+bounces-312876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6776969CDF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A291A281358
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833F41C9854;
	Tue,  3 Sep 2024 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jR3vbKun"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0141B12C9;
	Tue,  3 Sep 2024 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725365169; cv=none; b=dN+LVu1Rr2dlbOMLLvP9PjfdFo/r79wOIKfmucFmTA8jTjj1ZHD2288iYeMBbmNI+q1xOVBoT3iaTwV5smSKI9gi2Z3AnWAf7D3do8JrzuiTJSG14tRluqPxI+ooog+uxWBTSSh63MB76AhMP3HZbZPP3wQFF2cX1JOPcsEIsYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725365169; c=relaxed/simple;
	bh=6ns+CNOslyrIe4px7RaNrndB3EuzN63fKkYymGYsRLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnLOVtfClsU8QJIJf75TDjq3AicgUSHHtKS5u0Pn9VJFxtJBKuMZRNb9r7Abjt1t+IRfR0rvX++kqqSsgHa1veK5PZ8TWTfzXXjzfBt2Bzj78gFZBfZRNs5QTukEnt6XED5tgt0S7jpDH4iKLPPpeJGt0tdHt4RPlRlvrwoNRXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jR3vbKun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DECDC4CEC4;
	Tue,  3 Sep 2024 12:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725365168;
	bh=6ns+CNOslyrIe4px7RaNrndB3EuzN63fKkYymGYsRLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jR3vbKunal6cgH6N4GUoVpVE+d9fqBrwEAKXcvtkoJy8NI1F5A9Ir2HDjnQX0GTg8
	 z4bjGYF0ZTWXgdsN7JWzZE1nCz7qDNJg6PJVHdAl0CUT9U8jucXhoEDgsTlCA3B4/L
	 lSl25O/fmrahGfY7IdqmdPBrehiZ7WArFGm5CBvQ=
Date: Tue, 3 Sep 2024 14:06:05 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	Prashanth K <quic_prashk@quicinc.com>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"opensource.kernel" <opensource.kernel@vivo.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjldIHVz?=
 =?utf-8?Q?b=3A_gadget=3A_u=5Fserial=3A_Ad?= =?utf-8?Q?d?= null pointer check
 in gs_read_complete & gs_write_complete
Message-ID: <2024090346-bottling-mashing-e84e@gregkh>
References: <TYUPR06MB6217DE28012FFEC5E808DD64D2962@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <2024090338-nutlike-oxymoron-90f0@gregkh>
 <TYUPR06MB6217CE82501927931D973EDDD2932@TYUPR06MB6217.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYUPR06MB6217CE82501927931D973EDDD2932@TYUPR06MB6217.apcprd06.prod.outlook.com>

On Tue, Sep 03, 2024 at 11:58:37AM +0000, 胡连勤 wrote:
> Hello linux community expert:
> 
> >> From: Lianqin Hu <hulianqin@vivo.com>
> >> 
> >> Considering that in some extreme cases, when the unbind operation is 
> >> being executed, gserial_disconnect has already cleared gser->ioport, 
> >> triggering a gadget reconfiguration at this time and gs_read_complete 
> >> gets called afterwards, which results in accessing null pointer, add a 
> >> null pointer check to prevent this situation.
> >> 
> >> Added a static spinlock to prevent gser->ioport from becoming null 
> >> after the newly added check.
> 
> >In looking at this further, shouldn't we just be moving around where we call usb_ep_disable() in gserial_disconnect()?
> 
> >Can't we shut down the endpoints _BEFORE_ we set the port structures to NULL?  After the endpoints are stopped, then we know that there is no outstanding i/o possible and then we can clean up properly?
> 
> >Not to say that your change doesn't fix the race condition here, but cleaning up things in the proper order might be the better way as then there can not be any race conditions at all?
> 
> >Have you tried that?
> 
> Thank you for your guidance, we studied and tried.

I'm confused, you tried what and what happened?

greg k-h

