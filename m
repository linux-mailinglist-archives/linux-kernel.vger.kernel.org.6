Return-Path: <linux-kernel+bounces-257514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31BA937B15
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62B22B22AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19A7145FF4;
	Fri, 19 Jul 2024 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="QRNEilH5"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3145F17BA1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721406834; cv=none; b=GcIKzL7jXipQy1qeA35+ANM+6gMMnXSgv+OeQBPLa3GLVtMpiH5FAAQdI1i/QFbmPnK8RwJ1X50EdfgBAJyvgHEQzrBjwvhfCWRdNt3Dsdf62h1d9/+IJ0E5CoKDTo3k+HfMtbnSR8aT8Ew6iJWnqc81clmUg8dmgVgZKzALY0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721406834; c=relaxed/simple;
	bh=EBP2+SVCmJY54s6wJP89STVcdWhNoQ1uSgiD0EpVwIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+fpi1cqFg5+qOol7xJqI/o5S8hXoNLKHfVXVH7VnKqMXWwtn6SxTlAKBMhclwI0+RO5hMkqMgVLwYINgtmHvFW1WCw2aNLIdIiP6V3SNfD5D7u6D8uHy9Xy+alfNlJ9xfu0l9VMfBX5/iJ5mieQww7d0iknNtIvT6lEXAJ8KzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=QRNEilH5; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1721406821; bh=EBP2+SVCmJY54s6wJP89STVcdWhNoQ1uSgiD0EpVwIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QRNEilH5T9oqFL5EVMkEduK69xsB/0Lh6R3xABk2qa6eGoNof9C6yLthdForW0fzX
	 L3sH9M4pymybn4p/WRFtzevlaAsuzXz2Bb7I89LMxSwLAse/yRt1+UWCXeMfAWtByt
	 lpBGZ7wKNcl6Nt9227izLZcG1O7+k2xn/XajukuM=
Date: Fri, 19 Jul 2024 18:33:40 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Max Dubois <makemehappy@rocketmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, 
	ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org, Dan Carpenter <error27@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Bug related with a 6.6.24 platform/x86 commit signed by you -
 Enormous memory leak
Message-ID: <e1c268df-a0eb-4841-a786-59c3763bf831@t-8ch.de>
References: <9b0e7f6a-0432-46ba-bd75-7ba324934716@suswa.mountain>
 <CBDDDC2F-34FC-42B3-84EF-5F3BEA5AC480@rocketmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CBDDDC2F-34FC-42B3-84EF-5F3BEA5AC480@rocketmail.com>

On 2024-07-19 17:40:59+0000, Max Dubois wrote:
> I’m sorry, yes that file i called ‘working’ contain multiple kernels instances becouae I had to do a path to find out the crash happened at 6.6.24 level and that the last working kernel was 6.6.23. So I did a try to a lot of kernels over and under 6.6.24 to isolate the problem to 6.6.24 and everything after.
> 
> 
> If needed I can try to isolate the instance of the working 6.6.23 and
> I can’t confirm it does NO ERRORS at all like the kernels before it.
> 
> Buggy 6.6.24 log it is corrrext, the real 6.6.24 log with buga on vmalloc.
> 
> If needed I can confirm I can test any possible fix and/or patch against 6.6.24.

Can you try to reproduce the issue with
1) 6.6.41
2) 6.10
3) https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/

If it is fixed in one of them it should also be fixed in the ones later
in the list.

It would be very unfortunate to investigate and fix a bug that has
already been fixed before.

> Thank you
> 
> MD
> Inviato da iPhone
> 
> > Il giorno 19 lug 2024, alle ore 17:12, Dan Carpenter <dan.carpenter@linaro.org> ha scritto:
> > 
> > ﻿On Fri, Jul 19, 2024 at 10:01:14AM -0500, Dan Carpenter wrote:
> >> 
> >> The interesting thing about that is the working kernel had tons of these
> >> allocation failures as well.
> >> https://bugzilla.kernel.org/show_bug.cgi?id=219061
> >> See the attachment which called "This is a session with the last WORKING
> >> KERNEL 6.6.23, NO ERRORS, everything fine".
> > 
> > Never mind.  There are a bunch of different reboots in that file with
> > different kernels.
> > 
> > regards,
> > dan carpenter
> > 
> 

