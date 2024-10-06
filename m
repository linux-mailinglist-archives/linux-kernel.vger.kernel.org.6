Return-Path: <linux-kernel+bounces-352258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84288991C8F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 06:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC6A1F21DA8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 04:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E020015623A;
	Sun,  6 Oct 2024 04:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gj+RNT/+"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72214136A
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 04:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728189239; cv=none; b=PZvIr7cCSKJ76Y0LmzYGTtQtJajOejnqGltdgpZGmO5aZ2ZX9Qt4JoFUZMIKROd0NRy+n7dyQtf7Q2l+OSFv90snn5E/SL0inqQb2oHDtkgP5jwYqYTT1QUrrNX5lxSJ9ov24iDypgjdsuPQoKr92yip3npeqHCpcsYSbwWpy94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728189239; c=relaxed/simple;
	bh=WVcCE2sim6v+IZFNjDwjs5bsLKqaeRgzWiRtf4qAB1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOD2F5mxsvGsFBcfuPQ7d7YVT41eWl1XmM9Jn+rE60N3OqdVNCExLE7T7v3hyT8ri60rPEcUYBQqb6vw951MU/ncbSz1lYqiTelypwQ3I8+ZAloX+VfAaSiTqnaliHZ6OUrbsg1gn6JZQAq1EVUXDnYt5RgfziwrEwImhOgigfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gj+RNT/+; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 6 Oct 2024 00:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728189234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wnfhMk/3cBVNeBtBJ/GLOCkJvZam9zsro2DCVrs52v8=;
	b=gj+RNT/+1CkLanzJq9x7++ZSoiIUPco7dne5G7WleTjPXYp7fcfaC3UDXZ+KpdrKhz44F3
	YeuITZUBkRXnSacaAcOt6a5r+WQBu6KEeniUJiCjvZl9zy+43FWjEMXgMcBPVDc9qzDCo6
	15ruFLC6lGo/d1dk3iy72lvQxj4Ijso=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
Message-ID: <jhvwp3wgm6avhzspf7l7nldkiy5lcdzne5lekpvxugbb5orcci@mkvn5n7z2qlr>
References: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
 <CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com>
 <x7w7lr3yniqrgcuy7vzor5busql2cglirhput67pjk6gtxtbfc@ghb46xdnjvgw>
 <CAHk-=wi-nKcOEnvX3RX+ovpsC4GvsHz1f6iZ5ZeD-34wiWvPgA@mail.gmail.com>
 <e3qmolajxidrxkuizuheumydigvzi7qwplggpd2mm2cxwxxzvr@5nkt3ylphmtl>
 <CAHk-=wjns3i5bm++338SrfJhrDUt6wyzvUPMLrEvMZan5ezmxQ@mail.gmail.com>
 <2nyd5xfm765iklvzjxvn2nx3onhtdntqrnmvlg2panhtdbff7i@evgk5ecmkuoo>
 <20241006043002.GE158527@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006043002.GE158527@mit.edu>
X-Migadu-Flow: FLOW_OUT

On Sun, Oct 06, 2024 at 12:30:02AM GMT, Theodore Ts'o wrote:
> On Sat, Oct 05, 2024 at 08:54:32PM -0400, Kent Overstreet wrote:
> > But I also have to remind you that I'm one of the few people who's
> > actually been pushing for more and better automated testing (I now have
> > infrastructure for the communty that anyone can use, just ask me for an
> > account) - and that's been another solo effort because so few people are
> > even interested, so the fact that this even came up grates on me. This
> > is a problem with a technical solution, and instead we're all just
> > arguing.
> 
> Um, hello?  All of the file system developers have our own automated
> testing, and my system, {kvm,gce,android}-xfstests[1][[2] and Luis's
> kdevops[3] are both availble for others to use.  We've done quite a
> lot in terms of doumentations and making it easier for others to use.
> (And that's not incluing the personal test runners used by folks like
> Josef, Cristoph, Dave, and Darrick.)
> 
> [1] https://thunk.org/gce-xfstest
> [2] https://github.com/tytso/xfstests-bld
> [3] https://github.com/linux-kdevops/kdevops
> 
> That's why we're not particularly interested in yours --- my system
> has been in active use since 2011, and it's been well-tuned for me and
> others to use.  (For example, Leah has been using it for XFS stable
> backports, and it's also used for testing Google's Data Center
> kernels, and GCE's Cloud Optimized OS.)
> 
> You may believe that yours is better than anyone else's, but with
> respect, I disagree, at least for my own workflow and use case.  And
> if you look at the number of contributors in both Luis and my xfstests
> runners[2][3], I suspect you'll find that we have far more
> contributors in our git repo than your solo effort....

Correct me if I'm wrong, but your system isn't available to the
community, and I haven't seen a CI or dashboard for kdevops?

Believe me, I would love to not be sinking time into this as well, but
we need to standardize on something everyone can use.

