Return-Path: <linux-kernel+bounces-364623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B51099D70E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED16EB21E6B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE86231C83;
	Mon, 14 Oct 2024 19:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jhfch4yd"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86CD1CB317
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 19:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728933106; cv=none; b=jvp1X9B0x5nQD4iYPm+N6uPrJv+JpqjoMYEMv9WJ7yGtUv+9gcNpPSTjNwjiJl3v4D1Th4uCAvI+xz+UzLk6p8D32tipZuPhfB1M6NsWXX/NYAKIXVJXNTdVVcbD4TgGMrXW2s+HeyB2epyBTccvbeNOaoDNvtAOKAcZOVd8+BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728933106; c=relaxed/simple;
	bh=nwizG6mqRE2854KPUqSzzUqYQM4nVYxF3OQVzRAeClg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPcMP+vTjNjwKEKUD4C7ZoKVj3T6qDvYQOxxq0XauIIefcOfvEJ+cjPUSt/cXxNyelghJfI+IyAO1kt9zoORYLkMXP7aK8A5eji9gP24gHlP5ZK2XGlPXiUSxWb+3vzNdqOLGWvNheO0OwtEyQrk5x0KoYRiEtEA6pGpW70X9/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jhfch4yd; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460395fb1acso485821cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728933103; x=1729537903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zLwez9U/Rf9TUUbuSEBVO/KMWXtq4q4eYvg4v5pyKRo=;
        b=Jhfch4ydOdNIpl/T+aJAHte6AShzDMeX0QO0MFu1sFklxDZllG/pl30l0RKEYIE1d7
         iP9mQ5grqhkPF1c3YcQFfrU8sgYCH7JQoNT8JJNZwiQZgTLoytPL25NfzIPLVjp80Mp/
         /R5rBm48nTMcQqhH6IAzresMzLeXxQ407MIJ2SVWIYADZYh+XdngueLcO9hta2PnUk2b
         YJpfc48D7DqKEcdyTk0aae2nF2OpAhJj/YG9IKIc2oBunZlDaaLliclRAwHcLVAOzWLs
         dQZw4hbV/RjPnDsDoQjFxRPvWv9hz1Gajbz86gpheua+BwWMlb/msyeY65u4vKEgXp6L
         JDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728933103; x=1729537903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLwez9U/Rf9TUUbuSEBVO/KMWXtq4q4eYvg4v5pyKRo=;
        b=BpcS1ZsT7UAtzodPKAqd37x6Go/J3wInhG+OXr2C5JnH0cNtEd5yky4+r6mn2zuVqC
         Iy//BGBE3kcE6SpnpC7q+K7eIvW57wfxS+4SUtZMFJjV4sfMoz54+NyklfWIzZtqJeMd
         mmFF+uTJ7PhqFpnrYmN4dlUTzuFNyELSFrGwL5Uj4/1lKTrZQMc3g6tJVzFgTOFnh8oC
         CIERZzO27f0ug1/dRkD82zLM1chXYkq8gkXiL9k2ksdhQdx9pgKHqYXCkyX7xkATeb14
         XVjqKCrNWm/bHH8+vVufZ/eO5FDKalvReghLNTiFAOvRbEUWeV6TIzH2F/nt15CuOCXK
         1xdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLs23zn2WMyssCc3fdQGjxtjB0Tfdg3OvoEPErUhFyLF/xwh7/BG1G+MBU6lfH+Yg9YQYuHwWOHpcKflc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsGqfa6T/tDW75NwF4KpVNGebeSuhHafmpHOTbq58eFe3OCwZ4
	oU19g8ZyEg/Q5taeVwFLI1jM196cJRnVOg+0/elKAAcqPguLjD68yv/q9r2EvtmInkT0Or8bq+r
	QuQ==
X-Google-Smtp-Source: AGHT+IGxqYSZMH819sU9pVr5rCKmGz4yklMO6Z50t21K79cjnrKV+8lZhxm6MfvKN7OgKdc3YVFdHA==
X-Received: by 2002:a05:622a:4e0f:b0:460:4638:78c0 with SMTP id d75a77b69052e-46058ee04e8mr5618541cf.14.1728933103342;
        Mon, 14 Oct 2024 12:11:43 -0700 (PDT)
Received: from google.com (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe8630423sm48703326d6.112.2024.10.14.12.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 12:11:42 -0700 (PDT)
Date: Mon, 14 Oct 2024 15:11:40 -0400
From: Brian Geffon <bgeffon@google.com>
To: "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Weil, Oren jer" <oren.jer.weil@intel.com>,
	Tomas Winkler <tomasw@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [char-misc-next] mei: use kvmalloc for read buffer
Message-ID: <Zw1s7BTZrFOq3Xqf@google.com>
References: <20241013115314.1290051-1-alexander.usyskin@intel.com>
 <2024101343-proposal-gatherer-8c43@gregkh>
 <CY5PR11MB63665F42CE8EDCD3D48D2A27ED7B2@CY5PR11MB6366.namprd11.prod.outlook.com>
 <2024101335-turbulent-smelting-00f2@gregkh>
 <CY5PR11MB636626DB1AB4507D847E21CEED442@CY5PR11MB6366.namprd11.prod.outlook.com>
 <2024101439-vagrancy-cubicle-77e0@gregkh>
 <IA1PR11MB6370FC19D0985EF452C12156ED442@IA1PR11MB6370.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR11MB6370FC19D0985EF452C12156ED442@IA1PR11MB6370.namprd11.prod.outlook.com>

On Mon, Oct 14, 2024 at 02:43:31PM +0000, Usyskin, Alexander wrote:
> 
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Monday, October 14, 2024 4:25 PM
> > To: Usyskin, Alexander <alexander.usyskin@intel.com>
> > Cc: Weil, Oren jer <oren.jer.weil@intel.com>; Tomas Winkler
> > <tomasw@gmail.com>; linux-kernel@vger.kernel.org
> > Subject: Re: [char-misc-next] mei: use kvmalloc for read buffer
> > 
> > On Mon, Oct 14, 2024 at 01:15:49PM +0000, Usyskin, Alexander wrote:
> > > > -----Original Message-----
> > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Sent: Sunday, October 13, 2024 6:08 PM
> > > > To: Usyskin, Alexander <alexander.usyskin@intel.com>
> > > > Cc: Weil, Oren jer <oren.jer.weil@intel.com>; Tomas Winkler
> > > > <tomasw@gmail.com>; linux-kernel@vger.kernel.org
> > > > Subject: Re: [char-misc-next] mei: use kvmalloc for read buffer
> > > >
> > > > On Sun, Oct 13, 2024 at 02:22:27PM +0000, Usyskin, Alexander wrote:
> > > > > > -----Original Message-----
> > > > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > Sent: Sunday, October 13, 2024 3:14 PM
> > > > > > To: Usyskin, Alexander <alexander.usyskin@intel.com>
> > > > > > Cc: Weil, Oren jer <oren.jer.weil@intel.com>; Tomas Winkler
> > > > > > <tomasw@gmail.com>; linux-kernel@vger.kernel.org
> > > > > > Subject: Re: [char-misc-next] mei: use kvmalloc for read buffer
> > > > > >
> > > > > > On Sun, Oct 13, 2024 at 02:53:14PM +0300, Alexander Usyskin wrote:
> > > > > > > Read buffer is allocated according to max message size,
> > > > > > > reported by the firmware and may reach 64K in systems
> > > > > > > with pxp client.
> > > > > > > Contiguous 64k allocation may fail under memory pressure.
> > > > > > > Read buffer is used as in-driver message storage and
> > > > > > > not required to be contiguous.
> > > > > > > Use kvmalloc to allow kernel to allocate non-contiguous
> > > > > > > memory in this case.
> > > > > > >
> > > > > > > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>

Tested-by: Brian Geffon <bgeffon@google.com>

> > > > > > > ---
> > > > > > >  drivers/misc/mei/client.c | 4 ++--
> > > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > What about this thread:
> > > > > > 	https://lore.kernel.org/all/20240813084542.2921300-1-
> > > > > > rohiagar@chromium.org/
> > >
> > > [1] https://lore.kernel.org/all/20240813084542.2921300-1-
> > rohiagar@chromium.org/
> > 
> > Yes, it's a problem, I don't understand.
> > 
> > > > > >
> > > > > > No attribution for the reporter?  Does it solve their problem?
> > > > > >
> > > > > This patch is a result from non-public bug report on ChromeOS.
> > > >
> > > > Then make that bug report public as it was discussed in public already :)
> > > >
> > > Unfortunately, it is not my call.
> > > For now, I'll anchor this on [1]
> > >
> > > > > > Also, where is this memory pressure coming from, what is the root
> > cause
> > > > > > and what commit does this fix?  Stable backports needed?  Anything
> > else?
> > > > > >
> > > > > The ChromeOS is extremely short on memory by design and can trigger
> > > > > this situation very easily.
> > > >
> > > > So normal allocations are failing?  That feels wrong, what caused this?
> > >
> > > 64K is order 4 allocation and may fail according to [1].
> > 
> > And what changed to cause this to suddenly be 64k?  And why can't we
> > allocate 64k at this point in time now?
> > 
> > > > > I do not think that this patch fixes any commit - the problematic code
> > exists
> > > > > from the earliest versions of this driver.
> > > > > As this problem reproduced only on ChromeOS I believe that no need
> > > > > in wide backport, the ChromeOS can cherry-pick the patch.
> > > > > From your experience, is this the right strategy?
> > > >
> > > > No.
> > >
> > > Sure, I'll use
> > > Fixes: 3030dc056459 ("mei: add wrapper for queuing control commands.")
> > > where the first time such buffer allocated and add stable here in v2.
> > 
> > So the problem has been there for years?  Why is it just now showing up?
> > 
> 
> I suppose it is the combination of some fairly new FW that requests 64K buffer
> for content-protection case, underpowered ChromeBook and ChromeOS running
> content-protection flow.
> All three conditions should be met to trigger this failure.

That's correct we've seen this on kernels as old as 5.4. I have
personally reproduced this issue and can confirm that vmalloc does fix
it.

> 
> > thanks,
> > 
> > greg k-h
> 
> - - 
> Thanks,
> Sasha
> 
> 

