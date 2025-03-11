Return-Path: <linux-kernel+bounces-556130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7486A5C14B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240DD1637C7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90FF256C85;
	Tue, 11 Mar 2025 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lvv53IZ+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218A9253B5C;
	Tue, 11 Mar 2025 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696407; cv=none; b=VFIEAG9PXpv2eboPFOAIP959oBS0pDe0Y6SjJxdp3f9b5I3YN9lUxFhBzkbBtjHmqNQwvTmeaLcFGI1FrrdlCbUKC40xpvxXdgG7F3mH/NCJrvq9TwSpBQy9Gmzi12iCaP5T5aY6txSIO6gJ+70qeZuDehe4P2uE9e+lge77sV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696407; c=relaxed/simple;
	bh=6sk3JXmr83vP2HTVckDzIW0yBIvG5WhKLbVadL39CzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoxhvOSU9eOA/R83zFffpegNB/SZ8cXOlbPMCrWQo3bpFWeKwuP2jtvv89BWveX/6zgT9tRi8yfRYvhM7sBZI2dV0w/2ZbtEhQ5VLkSGEoGd0szJuBpgAyBRnowjPtiWHIiBFVItpoBdIxpLTCw45YRDWwgM2PU4SDLBz7CeWGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lvv53IZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8FDC4CEE9;
	Tue, 11 Mar 2025 12:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741696406;
	bh=6sk3JXmr83vP2HTVckDzIW0yBIvG5WhKLbVadL39CzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lvv53IZ+xvUMPfHrYVBM9OcHNxVFOboZzF2gZzbxHFvo1DMWLOr95aME4R1LtQDPL
	 OAu7QMxFg4YGxxJHtEvEFEny9Nrk0M82/tVeHQEn5YwdsgrVWk5X8Ysl2LPv6FotKc
	 5lZn0Wf47JLPdEVltJbp7Qs/s+Pc4zQCBoUIfZb1FBNIrdilg7MoW89tUVJYcQ5sWt
	 wokXQM/8sZNU1pVmrXt+bFaAsA+aADyiRNRMEAUtHf6d21NKukpgEnTrJwGOPnGxTf
	 CEnyByLN3afwvdYwwGcEjk+Hk47VZQExG+0YK/aGvsWGJp+ktRAtcTVLUz9TjQU1RF
	 CgobVTPLwPmGA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1trynR-0000000005R-2vLA;
	Tue, 11 Mar 2025 13:33:22 +0100
Date: Tue, 11 Mar 2025 13:33:21 +0100
From: Johan Hovold <johan@kernel.org>
To: "Ng, Boon Khai" <boon.khai.ng@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb <linux-usb@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Tien Sung Ang <tien.sung.ang@altera.com>
Subject: Re: [PATCH v2] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Message-ID: <Z9AtkeGJqFTGMyTB@hovoldconsulting.com>
References: <20250307154355.30772-1-boon.khai.ng@intel.com>
 <Z8_tDGssqs9DBaPU@hovoldconsulting.com>
 <DM8PR11MB5751B33EF33ED26FD8E63508C1D12@DM8PR11MB5751.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5751B33EF33ED26FD8E63508C1D12@DM8PR11MB5751.namprd11.prod.outlook.com>

On Tue, Mar 11, 2025 at 10:34:33AM +0000, Ng, Boon Khai wrote:

> > These configurations were not mentioned in the commit message. Are they
> > also used for embedded designs?
> 
> Looks like the table I provided in the commit message is mismatched with 
> the one that I intended to check in for upstream.
> 
> Let me correct this, the one that I published for upstream was the actual tested
> code, whereby we want the UART to be exposed to the ftdi_sio driver.
> 
> Below is the updated table, 
> 1) PID 0x6022, FT2232, 1 JTAG port(Port A) + Port B as UART
> 2) PID 0x6025, FT4232, 1 JTAG port(Port A) + Port C as UART
> 3) PID 0x6026, FT4232, 1 JTAG port(Port A) + Port C, D as UART
> 4) PID 0x6029, FT4232, 1 JTAG port(Port B) + Port C as UART
> 5) PID 0x602a, FT4232, 1 JTAG port(Port B) + Port C, D as UART
> 6) PID 0x602c, FT4232, 1 JTAG port(Port A) + Port B as UART
> 7) PID 0x602d, FT4232, 1 JTAG port(Port A) + Port B, C as UART
> 8) PID 0x602e, FT4232, 1 JTAG port(Port A) + Port B, C, D as UART
> 
> Since we need UART to be exposed to the ftdi_sio driver and the cable USB Blaster
> does not support UART, will reword that on the commit message to remove the 
> cable USB Blaster and left only the on-board USB Blaster.

It may still be good to mention the cable in some way as it's not
obvious that there are both standalone (cable) and embedded variants.
 
> Will submit a v3 on this, with the reworded commit message plus the change log.

Sounds good. I'll wait for the v3.

Johan

