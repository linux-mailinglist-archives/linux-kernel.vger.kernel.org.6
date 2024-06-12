Return-Path: <linux-kernel+bounces-211637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FAA9054BF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0EAD1F2226C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCA417DE0D;
	Wed, 12 Jun 2024 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mIoLAIa7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E549171E70;
	Wed, 12 Jun 2024 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201257; cv=none; b=h7vbNpxrOmPVFrk/zhQ0V6R2ZdSBAwK+VAs59vTSaW1p2BMZkNKslOJHMbNDzG89w75JazX8nfgvyFDErI4hn1vtyJHiEGBMGLjmvG9YcWAsxbPYsazEfZ3aI2UlGUmXyU5mQaJd1MZneyhgLxv5ypo0Xk5LYwlnXJXW/qF9N1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201257; c=relaxed/simple;
	bh=5uWWQPLwAdevF6gA/Ory1j8nYeVrVyX2L84YrDZuGks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7r7yCoD6iILctR4cyjMqelgwwvux5BFVfnfRqFaL2VOmwZNl4pO6Os98DLGSU4YJvMrsge3iq6NiMxKMIi2bAU1bON0EANrh3rR23CPq+4+c0T2rqCx3ORFb0IK2jpNW7FAZbfqAHbP56TWW6byR/EHYbFcXDpXykrR39ywRUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mIoLAIa7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FC9C116B1;
	Wed, 12 Jun 2024 14:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718201256;
	bh=5uWWQPLwAdevF6gA/Ory1j8nYeVrVyX2L84YrDZuGks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mIoLAIa7GluSB4iulnGtmDSLI6HRnoK4MrJxUA4VFEaR4iImmCwNkGOuzLydFXKkr
	 1oSnP2SCEuKYS2g+BeNgDo35J2kyyc7Y+8KOXiJH9FClpWC3PGhvvwJsdSk9KwU1Ky
	 GbhZDNxrwrQhFlF0AOIkb9Zn+Q9Xe5Bjik22VhfQ=
Date: Wed, 12 Jun 2024 16:07:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: joswang <joswang1221@gmail.com>
Cc: Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jos Wang <joswang@lenovo.com>
Subject: Re: [PATCH v3, 3/3] usb: dwc3: core: Workaround for CSR read timeout
Message-ID: <2024061217-haiku-unlocked-9d72@gregkh>
References: <20240601092646.52139-1-joswang1221@gmail.com>
 <20240611142953.12057-1-joswang1221@gmail.com>
 <2024061247-geranium-unstaffed-ff09@gregkh>
 <CAMtoTm32JDwWAjpKJ4TXxA9ROqqr-fNaOR1nqui8ayMHnYzkjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMtoTm32JDwWAjpKJ4TXxA9ROqqr-fNaOR1nqui8ayMHnYzkjg@mail.gmail.com>

On Wed, Jun 12, 2024 at 09:52:04PM +0800, joswang wrote:
> On Wed, Jun 12, 2024 at 3:58 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jun 11, 2024 at 10:29:53PM +0800, joswang wrote:
> > > From: Jos Wang <joswang@lenovo.com>
> > >
> > > This is a workaround for STAR 4846132, which only affects
> > > DWC_usb31 version2.00a operating in host mode.
> > >
> > > There is a problem in DWC_usb31 version 2.00a operating
> > > in host mode that would cause a CSR read timeout When CSR
> > > read coincides with RAM Clock Gating Entry. By disable
> > > Clock Gating, sacrificing power consumption for normal
> > > operation.
> > >
> > > Signed-off-by: Jos Wang <joswang@lenovo.com>
> > > ---
> > > v1 -> v2:
> > > - add "dt-bindings: usb: dwc3: Add snps,p2p3tranok quirk" patch
> > > v2 -> v3:
> > > - code refactor
> > > - modify comment, add STAR number, workaround applied in host mode
> > > - modify commit message, add STAR number, workaround applied in host mode
> > > - modify Author Jos Wang
> > > ---
> > >  drivers/usb/dwc3/core.c | 20 +++++++++++++++++++-
> > >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > Should this have a cc: stable line?
> >
> > thanks,
> >
> > greg k-h
> 
> I have a question here, please help me confirm
> 1. Cc: stable@vger.kernel.org or Cc: stable@kernel.org ?
> 2. Do I need to modify the commit message, for example:
> Cc: stable@kernel.org
> Signed-off-by: Jos Wang <joswang@lenovo.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jos Wang <joswang@lenovo.com>

Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

