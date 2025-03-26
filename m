Return-Path: <linux-kernel+bounces-576750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF6BA713F8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118783BC60E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CA71ACECB;
	Wed, 26 Mar 2025 09:43:01 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0DC185920
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742982181; cv=none; b=klZOg+ZYqfnwNpFBhhSwG0j5YmCEIOVyfrrW3H4BSfmxaNO/G9+OU7CVQEVWaW5w9LiHkuW6o9JJ4q4CaxzqbDd1sW3EcH13aWkp/xpGulL9TFJVlwNAYPrPMj5MVTtvQuYfQiT/Q/bIW/e7tbUQ+kM93lhSDTgdHjBwl2aqH90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742982181; c=relaxed/simple;
	bh=/LAxZqDj8tu1aSs17soUOiwln7e2yG6sne2KVzDMxso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCCdT+6yYzqaNLcZ7rt5vUpfxf5rGuL1WlWCAkrvWpmMWxDDjiqpeUh79PuT5dpRJGDn3wtu2jO5vNUP7EfFX6KPtSe2Uk+q6n8mUjUJfzozDB//fiL72CbmlceFHjKu3Zv3+IAzIYoTlPqVyLyWj2XSB/9DTCWPKMKcscPLHmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1txNHc-0002fE-6C; Wed, 26 Mar 2025 10:42:48 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1txNHb-001j3I-0X;
	Wed, 26 Mar 2025 10:42:47 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1txNHb-0004QD-1S;
	Wed, 26 Mar 2025 10:42:47 +0100
Date: Wed, 26 Mar 2025 10:42:47 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: sumit.garg@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org,
	willy@infradead.org, kernel@pengutronix.de,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tee: shm: fix slab page refcounting
Message-ID: <20250326094247.py7q5kbalisduzcc@pengutronix.de>
References: <20250325200740.3645331-1-m.felsch@pengutronix.de>
 <CAHUa44G_z0b42kHcaxvRJOou=pPT+MgWkJ5-5kbEOdJOFLMsAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHUa44G_z0b42kHcaxvRJOou=pPT+MgWkJ5-5kbEOdJOFLMsAA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Jens,

On 25-03-26, Jens Wiklander wrote:
> Hi Marco,
> 
> On Tue, Mar 25, 2025 at 9:07 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
> >
> > Skip manipulating the refcount in case of slab pages according commit
> > b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page").
> >
> > Fixes: b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page")
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> > v2:
> > - Make use of page variable
> > v1:
> > - https://lore.kernel.org/all/20250325195021.3589797-1-m.felsch@pengutronix.de/
> >
> >  drivers/tee/tee_shm.c | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index daf6e5cfd59a..35f0ac359b12 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -19,16 +19,24 @@ static void shm_put_kernel_pages(struct page **pages, size_t page_count)
> >  {
> >         size_t n;
> >
> > -       for (n = 0; n < page_count; n++)
> > -               put_page(pages[n]);
> > +       for (n = 0; n < page_count; n++) {
> > +               struct page *page = pages[n];
> > +
> > +               if (!PageSlab(page))
> > +                       put_page(page);
> > +       }
> >  }
> >
> >  static void shm_get_kernel_pages(struct page **pages, size_t page_count)
> >  {
> >         size_t n;
> >
> > -       for (n = 0; n < page_count; n++)
> > -               get_page(pages[n]);
> > +       for (n = 0; n < page_count; n++) {
> > +               struct page *page = pages[n];
> > +
> > +               if (!PageSlab(page))
> > +                       get_page(page);
> 
> b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page")
> mentions that more page types will have a zero refcount in the longer
> term. So we'll need to add exception after exception here. Is there a
> helper function somewhere to get all the pages we need? Or can we do
> this differently?

You're right, but in the long-term perspective the patch also mentions
"... stop taking a refcount on the pages that it uses and rely on the
caller to hold whatever references are necessary to make the memory
stable."

As you mentioned, in the medium term more pages are going to have a zero
refcount. I think that once mm is starting to add more zero refcounted
page types, they will also add a helper like "PageRefcounted()" or so.

At the moment all users are changed to cover only the slab use-case.
Therefore I would keep it as it is right now and change it to the new
helper later on.

Regards,
  Marco


> 
> Cheers,
> Jens
> 
> > +       }
> >  }
> >
> >  static void release_registered_pages(struct tee_shm *shm)
> > --
> > 2.39.5
> >
> 

