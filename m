Return-Path: <linux-kernel+bounces-548547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93902A5464F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDBB3172120
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F4F209F2E;
	Thu,  6 Mar 2025 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGwx2MSc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5F520101A;
	Thu,  6 Mar 2025 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253391; cv=none; b=dkRghubvn8VJOmy7Ibwzrpp81oPnksGjwFJ9lXyB3w64pIH7xRrw7o/hQFRt+aZixppdQGrpl0nZLfypxVWa+myLVJHNyPyr5eWZm2mrWhC3mDxoLamgh327ZZY0NE5QYA+RZer7rgdCXmQwWBhM+4vR1afT1Z3yb7Rpwb3Blio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253391; c=relaxed/simple;
	bh=45B4iTBjRVH1+hcUqu65iU9QqVOLI288FZMeusN7ybU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhsrHxQDUQ03eVM5Hklq0Ditr7YIjeHVONzFL/UPQWVKKS11/kYxc3xbGSyp5tPRKzJzQDVMopw7/79S28Q1SwoaU3qrxsDhRAz5sKQws5jC5WLCSHPDZIzOoZKZLzDO54fwbxqqigfCPFblMoOWK9VDxX5Nbb6e1ncTJG2g5WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGwx2MSc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB693C4CEE0;
	Thu,  6 Mar 2025 09:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741253390;
	bh=45B4iTBjRVH1+hcUqu65iU9QqVOLI288FZMeusN7ybU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGwx2MScrLRJ/mqZQe0KVZZoR7rv3sfYJeV3uvIbhJudtoQOZe10jE5HyCJA7WRkK
	 qpQeB0YNuXTN0GLc6NzSkxUYSC4bNA9dgjbNLsefVWHqDxZmvonnifW7Ix+dB9xUVb
	 TH4VfTImfNEBoqDP78nP0WONOMxSmc76cmerP7TWL7b9zq5b/pM/+mFL2v9b7FqCe2
	 C6I/PrAygELgpDGRykifiAZknYHmtcpv9CIJEXPBLcMRn/FvXSdk8NCpOdghg57xPg
	 LCF7xbi/7uGPOEycFFKLRoM+UjpjLoC1+fV+ze0273B+718NyeHQrq1bZYTS+Pz0Jl
	 NDiLhN4i878Rg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tq7Y2-000000001ov-31TS;
	Thu, 06 Mar 2025 10:29:47 +0100
Date: Thu, 6 Mar 2025 10:29:46 +0100
From: Johan Hovold <johan@kernel.org>
To: "Ng, Boon Khai" <boon.khai.ng@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Ang, Tien Sung" <tien.sung.ang@intel.com>,
	Tien Sung Ang <tien.sung.ang@altera.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>
Subject: Re: [PATCH v1] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Message-ID: <Z8lrCnCie923f0-_@hovoldconsulting.com>
References: <20250203084822.18356-1-boon.khai.ng@intel.com>
 <Z8hetcRinFXXVAdy@hovoldconsulting.com>
 <DM8PR11MB5751D2151A9FAC30E8647389C1CA2@DM8PR11MB5751.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5751D2151A9FAC30E8647389C1CA2@DM8PR11MB5751.namprd11.prod.outlook.com>

On Thu, Mar 06, 2025 at 03:22:53AM +0000, Ng, Boon Khai wrote:
> > I assume it's either an FT2243 or an FT4232 and not both?
> 
> Hi John, you are right, it is either FT2243 or FT4232. Will re-word that
> 
> > Can you say something more about these devices? I guess they are used for
> > programming FPGAs? Are they embedded in other products? 
> 
> There are 2 type of designs, USB Blaster 3 cable or On-Board USB Blaster 3.
> They are mainly used to connect debug or configuration software. Supported host
> software includes Quartus programmer, System Console, SignalTap, 
> Nios debugger.

Thanks for the background. It would be good to have something like this
in the commit message.

> > And can the
> > same PID be used for more than one type of device that they are embedded
> > in?
> > Or are the PIDs tied to different types of "USB Blaster 3"s? If so this, should
> > also be reflected in the naming of the defines.
> 
> The PID is associated with how the ports are connected, and
> which FDTI Chip are used for example:
> 
> PID: 0x6020
> Description: One JTAG Port
> FTDI Chip FT2232
> Port A: USB Blaster 3
> Port B: Not used
> 
> PID: 0x6021
> Description: Two JTAG Port
> FTDI Chip FT2232
> Port A: USB Blaster 3
> Port B: USB Blaster 3
> 
> ...
> 
> PID: 0x602E
> Description: One JTAG Port + UART (Port B, C, D)
> FTDI Chip FT2232
> Port A: USB Blaster 3
> Port B: UART
> Port C: UART 
> Port D: UART

Got it, thanks. Also here it would be good to include something like the
above, or a compact table like you provided in your reply to David, in
the commit message to have some overview of the configurations that the
patch is adding.

> > > +#define ALTR_UB3_6022_PID		0x6022
> > > +#define ALTR_UB3_6025_PID		0x6025
> > > +#define ALTR_UB3_6026_PID		0x6026
> > > +#define ALTR_UB3_6029_PID		0x6029
> > > +#define ALTR_UB3_602A_PID		0x602A
> > > +#define ALTR_UB3_602C_PID		0x602C
> > > +#define ALTR_UB3_602D_PID		0x602D
> > > +#define ALTR_UB3_602E_PID		0x602E

> > But depending on the answer to my questions above, either these defines
> > should be renamed to reflect the Blaster type or product they are part of, or
> > just be dropped.
> 
> The PID are not tied to specific product, however it is tied with how the Port are connected
> and how which FDTI chip are used. (FT2243 or FT4232).

Then it should be fine to keep the PID in the define name. Just replace
"ALTR" with "ALTERA" for consistency with the renamed VID define.

Johan

