Return-Path: <linux-kernel+bounces-363078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5227599BDA4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751EF1C21743
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787F12D600;
	Mon, 14 Oct 2024 02:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="piCSKsWT"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396BC25761
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 02:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728871729; cv=none; b=Pa17He/qJNXS2BEs4932Xh1nGZZdv5X6fesI+c92i9UaGXuft/XJeC/XTGkzOzfKL7WP2x1TkLdGMczgRbMBHgVwNOFqChC2MFmU8TBKcPJ/nNLULm9/RAjszRloLzJLidL0xW6bb/GSUwbTuFtL8qqrYBUBTPY9cMOmjZNdsyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728871729; c=relaxed/simple;
	bh=sKoT9ubx2MR3FyeYH9iNNnEYGr/zsGQemIq59egXHpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyTXQYp2ooQM5zIVdH/KmhpVsXsTPCxccJ5kB5Us50RjAm/bsNQTvmglz30djye/uHlA7UKso9Bi+SuH2GgIS1kMNV9SmYslMovj7iMI1oMu/lIkb2bids0Bx86KXyMEBliNA5Ftitk+7Gki4H632eYcz11Wc8pV9PhkbWpPym0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=piCSKsWT; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 13 Oct 2024 22:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728871726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wY+ijKXuZt2ojjF9sY4li+YhA/f7UOPAEofiJwS3jCc=;
	b=piCSKsWTpyYrc56O9Fty31hKyS/UmcAPuHEaFC3yEGAp3Oqj4IHVsd5UhxwApkguAg9jfK
	mQuwf8cyO0fG3pxjo1ycCwmwZfpoHqO8sBqNH1PvjOdzHU2cobTW/0SSIpHUAVQoWlblsS
	6HsAREY2u24k+CImBZYk/XmZzIN3OVc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: colyli@suse.de, msakai@redhat.com, corbet@lwn.net, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	akpm@linux-foundation.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, jserv@ccns.ncku.edu.tw, linux-kernel@vger.kernel.org, 
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] Enhance min heap API with non-inline functions and
 optimizations
Message-ID: <lee342z2tyrmmxuqnqb2mg4i4qem6n3ei6ifnuusivxilouqbe@nsbaqry3lchl>
References: <20241013184703.659652-1-visitorckw@gmail.com>
 <uisaqjn2ttzhohe3a5qrdw4x6m7rhuoxxuhfoz5szufynuz5fz@4wicz52jydwz>
 <ZwxXSje3n6lMTbjj@visitorckw-System-Product-Name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwxXSje3n6lMTbjj@visitorckw-System-Product-Name>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 14, 2024 at 07:27:06AM GMT, Kuan-Wei Chiu wrote:
> On Sun, Oct 13, 2024 at 07:05:38PM -0400, Kent Overstreet wrote:
> > On Mon, Oct 14, 2024 at 02:47:00AM GMT, Kuan-Wei Chiu wrote:
> > > Add non-inline versions of the min heap API functions in lib/min_heap.c
> > > and updates all users outside of kernel/events/core.c to use these
> > > non-inline versions. Additionally, it micro-optimizes the efficiency of
> > > the min heap by pre-scaling the counter, following the same approach as
> > > in lib/sort.c. Documentation for the min heap API has also been added
> > > to the core-api section.
> > 
> > Nice, has it been tested - do you need a CI account?
> > 
> > I'd like to start seeing links to CI results in patch postings (and I
> > need to tweak the CI to add git fetch links, as well).
> >
> It would be nice to have a CI account to test my patches. Is there any
> guide available on how to use it?

I give you a config file to edit, it watches your git branch(es), you
watch dashboard

