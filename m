Return-Path: <linux-kernel+bounces-230435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25B1917CCD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7026E284B12
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E7516EB4A;
	Wed, 26 Jun 2024 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fXFrLmYD"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664F716DC02;
	Wed, 26 Jun 2024 09:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719395078; cv=none; b=ksXUf7PKxHuZjgHHE2C5EyUPchPCe4xN4piwafvNIZ6cXX6gIM7sQD00PBc1Snm2MS1J0aGDd8tRowXfIuxLzDN+3dMZaIWGQGzjI5YdCWmHpttp76jqrNSj1kWv0Xqgad7JMXKWcP0PFcbf/cArU0m9q/bsmN/WpUjGNOsLoNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719395078; c=relaxed/simple;
	bh=BEyHuN9KYaz/HgLYtzWccIdPuHn7PvQuBdSB2pJ8+dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLCx6Hmu5EhsEmtogx+xLk6zZaEcju+4gSaXAn+2k8QIqjSocVREUUQoZrxZyxDb7OCHBtLBIvmzjWSMgHAXazI6XhNM9/dqdIY2LAXMUmXe1uiF7cW46RvKmUQ417HB3TZlYo76qexuaaut//+4BpERdMA/lqbxQXQ4FNvAQQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fXFrLmYD; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XzfMdj8RGEXjKOpU3zqHY7Vw5JxOu6m7qj04nFi/KTU=; b=fXFrLmYD4+4DSzF+sPAyI4PYMs
	MQWE0ReZKAfC+5fkT+sdd+u8LYbumJ/AoYgCW0BewpVHIbh2FNmpeJQQZSY4JqniXLmD6KW+OcAYs
	HxYtNKvVN0T7akfHN+2LMSKfOCKZ3bN3Jzxt429WJSOx4cbvQb0c0TZOKqiFj4aOPei6ehJr+Qogl
	xT6qtP47UQ92MhXEMWjiRQhwtzoEvI7CIgWknb6zOdyCl5Ww/4lfSNAKjx7CuB1S0V8t3oEaiGuO5
	h6MR06GEChqELdPObj0CNUl7JeEYC9bTLMWvmLj9jPTYZZ0/Fw+9YTK2+37z0rlzazchYrZk3VOB7
	QEY6kAdw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMPAy-00000008YjG-36PX;
	Wed, 26 Jun 2024 09:44:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 138CD30057C; Wed, 26 Jun 2024 11:42:45 +0200 (CEST)
Date: Wed, 26 Jun 2024 11:42:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly
 requires more registers than available
Message-ID: <20240626094245.GD31592@noisy.programming.kicks-ass.net>
References: <CAFULd4YR-VkAOKiS5yxSUYi0YMzY1p=pkYe4dOkgFs+A=9AFFA@mail.gmail.com>
 <CAHk-=wi_KMO_rJ6OCr8mAWBRg-irziM=T9wxGC+J1VVoQb39gw@mail.gmail.com>
 <CAHk-=whPqqZVSeJiQsMvsAxtAmtR9iAuB4gg_1sUK2D-uBPpLw@mail.gmail.com>
 <CAFULd4YAeF7=q7DYUh016kabxS8b32qRbFqDBJQrvLq6RjwEVg@mail.gmail.com>
 <CAHk-=wiHo2YeA=TOUf8vxFLOc0+BoH8USaiT25fnX2ynXbrZkg@mail.gmail.com>
 <CAHk-=wgdCs0883dpvZpyna76q9eVcTMvvUVAaBuJMPyrgOhNig@mail.gmail.com>
 <CAFULd4ZW23_RNye6YGbsT0Uo-vOQBM_tBbSJRhh=0HZzXuC_8Q@mail.gmail.com>
 <CAHk-=wiWEgSo2Tb_bih7mnS27zAPL+RGg_7yX4qK1f710-j-Ng@mail.gmail.com>
 <20240626092841.GC31592@noisy.programming.kicks-ass.net>
 <CAFULd4ZUBaK+FNSKfiJzzZNFQM1bWorZGmaY=fb-sFN2uPK4MA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFULd4ZUBaK+FNSKfiJzzZNFQM1bWorZGmaY=fb-sFN2uPK4MA@mail.gmail.com>

On Wed, Jun 26, 2024 at 11:33:09AM +0200, Uros Bizjak wrote:

> Please see the thread at [1].
> 
> [1] https://lore.kernel.org/lkml/CACT4Y+bG+a0w6j6v1AmBE7fqqMSPyPEm4QimCzCouicmHT8FqA@mail.gmail.com/

Ha, handy these archives, much better than my memory indeed.

