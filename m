Return-Path: <linux-kernel+bounces-448647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CA59F4368
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F3C1881CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 06:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4484614F135;
	Tue, 17 Dec 2024 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NB1FUitn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD988BF8;
	Tue, 17 Dec 2024 06:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734416262; cv=none; b=r91jXVCa0fA7i6WEHVg7zjsrqQn8RiNcE9uXy8nl8MSeRvOwPBGNiVAoDSHbnLlX8zjEoffzt8EjTqLKyM08AMQHN/ak/X/iSPPZ9onIChNUPgjjFpveRrEa+yGjvh01t3+iQzdnNoyOq6tEhcW9oeiyJCF3luUW9pgxH+CM5N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734416262; c=relaxed/simple;
	bh=bqFlx/NtHYpQLVM2poqHADeVOl1mENwQMtm+Kjkw+DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ez60EQ2w1ggVme+t3GW/l6amqK1AG91amN7oRbHCCvtcDBxRlj0rZNO5S2y0jnnl+GOdlMJgMOpQNb2/urRYcau8VyRrRICly7SBp2ByWQciyP8q64GUXDs4gdQvu+Ltj5HTvUEGANthZD246mOlGoDM3VU4Jkhvm4aVbV5VPOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NB1FUitn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8675CC4CED3;
	Tue, 17 Dec 2024 06:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734416262;
	bh=bqFlx/NtHYpQLVM2poqHADeVOl1mENwQMtm+Kjkw+DI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NB1FUitnRk7zy1AL5nnyddNjDQLekbod9lDP1xpOUI0IJ4xDypjzINITJHpt0TIFp
	 RVMUQFP/3ESJwiTflvN0P76lq52uFPANrh9UNIijAnxqnbQ7kxIUMFuT/BYzbzHzbo
	 ibY4iTW8OK7dA+2zY5kW3/knJEN+RzO6jzghP8cuL0B7VUOBJupyrJBvjpePo7DPj3
	 zr6QLGzqRY3BTFhTY9t3EQSsmlTiVAoTIuHqQzTOU133bQI5BPvHk3bgcjOMSdfcAm
	 s7dzgIaCThPMYkXJ2J4z36DPGvUgybNGnD3sXQJPiGWE/kXSuTK1v8S5H4lxTThtqf
	 Tk/Y/jPLUG3HQ==
Date: Tue, 17 Dec 2024 14:17:34 +0800
From: Peter Chen <peter.chen@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Pawel Laszczak <pawell@cadence.com>, Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Fix USB suspend on TI J7200 (cdns3-ti, cdns3,
 xhci)
Message-ID: <20241217061734.GB13482@nchen-desktop>
References: <20241210-s2r-cdns-v6-0-28a17f9715a2@bootlin.com>
 <20241214090604.GC4102926@nchen-desktop>
 <D6D6NEMYVOBV.3OVBJ77E11A2@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D6D6NEMYVOBV.3OVBJ77E11A2@bootlin.com>

On 24-12-16 15:09:00, Théo Lebrun wrote:
> Hello Peter,
> 
> On Sat Dec 14, 2024 at 10:06 AM CET, Peter Chen wrote:
> > On 24-12-10 18:13:34, Théo Lebrun wrote:
> > > Currently, system-wide suspend is broken on J7200 because of a
> > > controller reset. The TI wrapper does not get re-initialised at resume
> > > and the first register access from cdns core fails.
> > > 
> > > We address that in two ways:
> > > 
> > >  - In the cdns3-ti wrapper, if a reset has occured at resume,
> > >    we reconfigure the hardware.
> > > 
> > >  - We add a xhci->lost_power flag. Identical to the XHCI_RESET_ON_RESUME
> > >    quirk, expect that it can be set at runtime.
> > > 
> > >    At resume, to summarise, we do:
> > >       xhci->lost_power = cdns_power_is_lost(cdns);
> >
> > Is it possible you go to change xhci quirks runtime?
> 
> I always assumed quirks were read-only once probe was finished.
> If I was wrong then we can remove xhci->lost_power and edit
> xhci->quirks instead.
> 

I just want to see if we could avoid change common code, would you
please confirm with xHCI maintainer Mathias Nyman?

Peter

