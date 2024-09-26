Return-Path: <linux-kernel+bounces-340238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E1198705C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A894282A6F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9E51AC8A0;
	Thu, 26 Sep 2024 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KBXY/dib"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1487224D6;
	Thu, 26 Sep 2024 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343293; cv=none; b=Y3+RMyVJtf7ZZn4P2FF/XmjmD6kbW6V8R0QCaASoAkWE4smGRSq3UE06EakNvyHahLkeUL4D62eOaXxwVSNgUNzB76gp3sQOZdTgbMAkqnHBqalU5moNIuG0WCaU5ymwl7OrLd20088ydxi/UyQFt2WAG9pJP+Ulhjx0mYz2UdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343293; c=relaxed/simple;
	bh=aBxzhfOzuC9ptbUK/5GQcxNABiudJtiN+C1y90whjiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kV5Tgz0z69AFHY3p7Px33nfvC0p4N6uROEPULMzqWsFrfrZ2zwxEWZRgkZktX60symXMNyOdr5EVM0X6w8nhOWSyGPYKNQvLZThOicDDz5bwd17fq1uW2sb7jFB9tl2oeaboaeEvnzmfwwjddhEjYUh/OacjrR7AjPGHWMZPUJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KBXY/dib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E484C4CEC5;
	Thu, 26 Sep 2024 09:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727343292;
	bh=aBxzhfOzuC9ptbUK/5GQcxNABiudJtiN+C1y90whjiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KBXY/dibcC9Nu38dW83jeRQfvs/pw+9sNqLxYhdBFoVktmsg1jlNygnF3sTxCk92e
	 2W0VmoJ4+ZsQwKLG4Zs/cPp6pqRMgOk7wYIXzK6JhyFH5g80Li8IAieYlkStXdy+YR
	 oXbQCexqz9OrntpbsWX6mDjfpsVxF6n6F0NBFTTg=
Date: Thu, 26 Sep 2024 11:34:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: "Hall, Christopher S" <christopher.s.hall@intel.com>,
	"Mohan, Subramanian" <subramanian.mohan@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"Dong, Eddie" <eddie.dong@intel.com>,
	"N, Pandith" <pandith.n@intel.com>,
	"T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
	"Zage, David" <david.zage@intel.com>,
	"Chinnadurai, Srinivasan" <srinivasan.chinnadurai@intel.com>
Subject: Re: [PATCH v12 2/3] Documentation: driver-api: pps: Add Intel Timed
 I/O PPS generator
Message-ID: <2024092624-stapling-clock-5fe0@gregkh>
References: <20240823070109.27815-1-subramanian.mohan@intel.com>
 <20240823070109.27815-3-subramanian.mohan@intel.com>
 <2024082456-kitchen-astride-7892@gregkh>
 <801c7a93-667b-4c23-9493-4cbe979847a2@enneenne.com>
 <2024090304-viewing-lavish-c05e@gregkh>
 <PH7PR11MB69787046B1F9CDA610523FE5C2692@PH7PR11MB6978.namprd11.prod.outlook.com>
 <e88f2d6f-033a-41b5-afdb-8a3f6bcf3d06@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e88f2d6f-033a-41b5-afdb-8a3f6bcf3d06@enneenne.com>

On Thu, Sep 26, 2024 at 10:46:54AM +0200, Rodolfo Giometti wrote:
> On 25/09/24 23:55, Hall, Christopher S wrote:
> > Hi Rodolfo,
> 
> Hello.
> 
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Tuesday, September 03, 2024 3:25 AM
> > > To: Rodolfo Giometti <giometti@enneenne.com>
> > 
> > > Subject: Re: [PATCH v12 2/3] Documentation: driver-api: pps: Add Intel Timed
> > > I/O PPS generator
> > > 
> > 
> > > > If you are willing to stop the inclusion due this fact maybe its time to add
> > > > such PPS generators interface... on the other hand, if you agree for
> > > > inclusion we can do this job as soon as the code has been included, in order
> > > > to fix this anomalous status.
> > > 
> > > Please make a generic pps subsystem for this, it would make it simpler
> > > for everyone.
> > 
> > What is required to move this? We can certainly test the code and do some
> > of this work, but I would look to you to define the interface.
> 
> The problem is that a pps-generator has no related device, then no sysfs entries.
> 
> I think the right-thing(TM) to do is adding a new class named
> "pps-generator", so we will get the directory /sys/class/pps-generator with
> several devices as pps-generator0, pps-generator1, etc. For each device we
> should add at least these sysfs entries:
> 
> - system       : This file return "1" if the generator takes the timing from
>                  the system clock, while it returns "0" if not (i.e. from a
>                  peripheral device clock).
> 
> - time         : This file contains the current time stored into the generator
>                  clock as two integers representing the current time seconds and
>                  nanoseconds.
> 
> - enable       : This write-only file enables or disables generation of the
>                  PPS signal.
> 
> - period       : This file defines the period for the generator signal. When
>                  read, by default, it returns "1 0" which represent the period
>                  second and nanoseconds (i.e. a PPS signal). When written, it
>                  sets the period accordingly or ENOTSUPP if not supported.
> 
> - start_time   : This file defines the starting time for the the generator
>                  signal. When read, by default, it returns "0 0" which means
>                  "now". When written, it sets the starting time accordingly or
>                  ENOTSUPP if not supported.

This seems sane to me, thanks for writing it up!

greg k-h

