Return-Path: <linux-kernel+bounces-261848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2BD93BCE3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28ABF1C21068
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310DB16F0EC;
	Thu, 25 Jul 2024 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZSm1lJ5W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6251816D9DC;
	Thu, 25 Jul 2024 07:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721891397; cv=none; b=otYbrsIex7GWSjStTX4cfuhWCawtgh1yacHZ3FHTAaSw9BrsVvUgr02X2u1en+z7BSuPgBtTKWtA+JLz4FOj9IAQG3nVjuOFotsn7GYSlwVvkV8n75cVdaP3XZ5WtRCIxvRIBeMNQ9w+o/MnjQ+/+oUbBjWWhGxW8BZ7Rdy5Yjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721891397; c=relaxed/simple;
	bh=AOP+f1AUPWbz/K5bIAQ4H4snBN1k66lwGOU3Y6KeJdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctILZRvAx2STUy6FO+kvGz/9+86vKmxjV/6o6m/ladoKrUWGn/a9SKKG8uTqbwFhMqXPAEFFmzlqEtVOg2+b3CzDQOtUgH3G9ANFpSknsalmJ98TOhGfBhPQ3kSBpcXNK2DVEIe41SOZ4NCaPAzQR9U5AWGlVMiOa1tfTAr6RIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZSm1lJ5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26ECC116B1;
	Thu, 25 Jul 2024 07:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721891397;
	bh=AOP+f1AUPWbz/K5bIAQ4H4snBN1k66lwGOU3Y6KeJdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZSm1lJ5WbaB5i2Z6zTr8vXmO2M/UbYXBiW3cRqUUBXoE8FqyYJnIYoOfc5fGqniwi
	 BLU8Ucl0cg1p5bXqztW86djfQd8zm3YiWwusl8/M3QWj2gbAbCiWxHoVCIBy79ux6o
	 Vbw0PenUEJzOlsN+kkoEtVtmaw2yviCW689Bay+o=
Date: Thu, 25 Jul 2024 09:09:54 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: "Hall, Christopher S" <christopher.s.hall@intel.com>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Dong, Eddie" <eddie.dong@intel.com>,
	"N, Pandith" <pandith.n@intel.com>,
	"Mohan, Subramanian" <subramanian.mohan@intel.com>,
	"T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"Zage, David" <david.zage@intel.com>
Subject: Re: [PATCH v10 0/3] Add support for Intel PPS Generator
Message-ID: <2024072500-matrix-antivirus-dc61@gregkh>
References: <20240612035359.7307-1-lakshmi.sowjanya.d@intel.com>
 <CY8PR11MB736490B761DBA045513AF078C4DD2@CY8PR11MB7364.namprd11.prod.outlook.com>
 <d463bd28-9890-47a5-97cc-14f96db2db22@enneenne.com>
 <87r0bvqdsz.ffs@tglx>
 <5198a2c2-49b2-4a8c-8d94-d6c9811b645b@enneenne.com>
 <PH7PR11MB6978F12032F4F3EBA83BFE10C2AA2@PH7PR11MB6978.namprd11.prod.outlook.com>
 <c785136d-40bc-4fa3-b982-e9e4417c0b73@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c785136d-40bc-4fa3-b982-e9e4417c0b73@enneenne.com>

On Thu, Jul 25, 2024 at 09:05:02AM +0200, Rodolfo Giometti wrote:
> On 24/07/24 23:39, Hall, Christopher S wrote:
> > Hello Rodolfo,
> > 
> > > From: Rodolfo Giometti <giometti@enneenne.com>
> > > Sent: Monday, July 15, 2024 2:37 AM
> > 
> > > Subject: Re: [PATCH v10 0/3] Add support for Intel PPS Generator
> > > 
> > > On 15/07/24 10:06, Thomas Gleixner wrote:
> > > > On Thu, Jul 04 2024 at 13:50, Rodolfo Giometti wrote:
> > > > > On 03/07/24 16:47, D, Lakshmi Sowjanya wrote:
> > > > > > 
> > > > > > A gentle reminder for the review of the pps patchset.
> > > > > 
> > > > > I already acked these patchset, didn't I? =8-o
> > > > > 
> > > > > Please let me know if I missed something.
> > > > 
> > > > Sorry, I missed that V10 posting. It's too late now.
> > > > 
> > > > Rodolfo, can you pick it up after rc1 for the next merge window. All
> > > > prerequisites should be in Linus tree then.
> > > 
> > > LinuxPPS has no dedicated tree as other Linux subsystems. Usually I send my
> > > "Acked" to Greg Kroah-Hartman and Andrew Morton, and they push patches
> > > by
> > > themselves.
> > 
> > Is the PPS driver on track to be included in the 6.11 release candidate?
> 
> I hope so! ^_^"

Are the patches in linux-next?  If so, what tree did they go through?
If not, they can't be merged into 6.11-rc1.

> Unluckily the LinuxPPS is a minor subsystem with no dedicated tree, and
> inclusion is not under my control.

I pick up many "smaller" driver subsystems all the time, I just have to
be asked to do so...

thanks,

greg k-h

