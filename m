Return-Path: <linux-kernel+bounces-362846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0334099B9E7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 17:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BFEB1C2091B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 15:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BB814659C;
	Sun, 13 Oct 2024 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yo7opBI/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720FF1EB2E
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728832070; cv=none; b=fCzJ/wsOdd7qQun+Z8IXlieOBaQXIcN2Bakv0eD0mwXZzj3OGfvZABBWwOoCTBZ8Tywo0dbOo+e/ogkgQ0gk2QPP7bjwpsSMhcmEGQICrFi+K6jE4ECXcM243zUIXavqCZGsnu5voQmVMlwDyCvDJCFqc8wMjbANsjdW1x7aFP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728832070; c=relaxed/simple;
	bh=+9lsLz8Gssy1cecV0idLd9NgfYmUHL4MDkvljQ/XcFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdrevS/O9F8Dj4DdtcNLKLeVXvYI1VWdKOtjoSaVhB/VtzfDFzzE/DKgC5p//k+Z7m7liLSF5hZn0HFAQX2ZJh5toKNQXAK+Fl03KngMBc8TaDcoi3yNLUB0YVmNr+oSPZbUojKkuSmMDXV4i9XpJjk91haTMSNMv5qFKWo9Cl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yo7opBI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0433C4CEC5;
	Sun, 13 Oct 2024 15:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728832070;
	bh=+9lsLz8Gssy1cecV0idLd9NgfYmUHL4MDkvljQ/XcFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yo7opBI/3GRkTacSceFMlnM/1S8g7WRjTHfQZIsbo+pnXGeyV0RxqlPoD2tCIb740
	 yv0GgmBDpXPWl+NT17r82UL+Ha++EpU0Sqsnvps54vst8cM3zYg+iHJJPq/i/6xBHd
	 iI1K0lezMiAe4XnQVy/3xtQW2YWmuJ63RaNED+JU=
Date: Sun, 13 Oct 2024 17:07:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc: "Weil, Oren jer" <oren.jer.weil@intel.com>,
	Tomas Winkler <tomasw@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [char-misc-next] mei: use kvmalloc for read buffer
Message-ID: <2024101335-turbulent-smelting-00f2@gregkh>
References: <20241013115314.1290051-1-alexander.usyskin@intel.com>
 <2024101343-proposal-gatherer-8c43@gregkh>
 <CY5PR11MB63665F42CE8EDCD3D48D2A27ED7B2@CY5PR11MB6366.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR11MB63665F42CE8EDCD3D48D2A27ED7B2@CY5PR11MB6366.namprd11.prod.outlook.com>

On Sun, Oct 13, 2024 at 02:22:27PM +0000, Usyskin, Alexander wrote:
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Sunday, October 13, 2024 3:14 PM
> > To: Usyskin, Alexander <alexander.usyskin@intel.com>
> > Cc: Weil, Oren jer <oren.jer.weil@intel.com>; Tomas Winkler
> > <tomasw@gmail.com>; linux-kernel@vger.kernel.org
> > Subject: Re: [char-misc-next] mei: use kvmalloc for read buffer
> > 
> > On Sun, Oct 13, 2024 at 02:53:14PM +0300, Alexander Usyskin wrote:
> > > Read buffer is allocated according to max message size,
> > > reported by the firmware and may reach 64K in systems
> > > with pxp client.
> > > Contiguous 64k allocation may fail under memory pressure.
> > > Read buffer is used as in-driver message storage and
> > > not required to be contiguous.
> > > Use kvmalloc to allow kernel to allocate non-contiguous
> > > memory in this case.
> > >
> > > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > > ---
> > >  drivers/misc/mei/client.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > What about this thread:
> > 	https://lore.kernel.org/all/20240813084542.2921300-1-
> > rohiagar@chromium.org/
> > 
> > No attribution for the reporter?  Does it solve their problem?
> > 
> This patch is a result from non-public bug report on ChromeOS.

Then make that bug report public as it was discussed in public already :)

> > Also, where is this memory pressure coming from, what is the root cause
> > and what commit does this fix?  Stable backports needed?  Anything else?
> > 
> The ChromeOS is extremely short on memory by design and can trigger
> this situation very easily.

So normal allocations are failing?  That feels wrong, what caused this?

> I do not think that this patch fixes any commit - the problematic code exists
> from the earliest versions of this driver.
> As this problem reproduced only on ChromeOS I believe that no need
> in wide backport, the ChromeOS can cherry-pick the patch.
> From your experience, is this the right strategy? 

No.


