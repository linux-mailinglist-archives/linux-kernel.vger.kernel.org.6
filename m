Return-Path: <linux-kernel+bounces-314914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F18A96BAF4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7624DB2500E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA271D0169;
	Wed,  4 Sep 2024 11:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZUBYXBC0"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391111CF7AC
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449957; cv=none; b=Mpe0cJvSrRSXx3JreMwpgAAr+T5VaLHLop0q8U0mUjVb8qW9i10Z7kjao8P4NmfjdVGYlsPI33BS4W5GIylhpAE4euPPPF+N6Bn9jxMl3KK6i7bQw73CZBPYSSVlzKkV6d82F2oCzjXSX1YeiZ14Z8kOsgEEhpGiqHjSY7kYMNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449957; c=relaxed/simple;
	bh=XavpJsnh34eefCMApdNRk43izI1ZC2052HhAi88XK90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZM9q5eRFjJxQsr+RxAnctAXYe2tvgEqKhuFtdUvZM5MEdKA9OhXFc5jhgYJOfRO3CHDsMaeki5xWHY3ZXJFkSklc/WKJM2D66zV7DOerWowdpetim65s4QsOA//jQqprgQPJPvQxmpDA3ygjajkl+zJ1ZLsnmOi9gSVpXgpS3Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZUBYXBC0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1rE/FFpjeNfOvNwU1UVNjerJRacfvhEURZT1lEeJSMY=; b=ZUBYXBC0ML4e8Msk4ZJqGqjlr0
	XQT3Wm5Tjo60DycTx7fcuIApyAmpKIKkH47of7PemMNzoFz401aA25u4rSH1Zquwp2vuDfg87ujvt
	Baxyvyu8s47jGIeypssRTKs0Iper82XjiORBz8adjqkt0SivYRnvfQRcx5OqdXCaJbkQs4CzkqJSf
	ZcEC5EZeRkXx4Qqn3BKhbAuji23Eqf71FU8dFspnCTipzVRKvUE9/ECPWFsHNtqk+lmPgRiKrJyQL
	+/YTgDZZVInOyNZ36HBj0QBZrooRg3go338cXlidFOaL84haWArU+bkhm4DFfKMudA8z0Ike3S0+F
	cUB/uPBw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sloLr-00000000mnP-12CV;
	Wed, 04 Sep 2024 11:39:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2A54B300642; Wed,  4 Sep 2024 13:39:08 +0200 (CEST)
Date: Wed, 4 Sep 2024 13:39:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [RFC/PATCH 4/4] perf/x86: Relax privilege filter restriction on
 AMD IBS
Message-ID: <20240904113908.GG4723@noisy.programming.kicks-ass.net>
References: <20240830232910.1839548-1-namhyung@kernel.org>
 <20240830232910.1839548-5-namhyung@kernel.org>
 <20240902091232.GB4723@noisy.programming.kicks-ass.net>
 <CAM9d7cg-7USE-Ofusc1VDpr3qtviX4xZmoKmBjmEfBDw9XJ+nw@mail.gmail.com>
 <20240903085454.GR4723@noisy.programming.kicks-ass.net>
 <CAM9d7ch8fwk-o7W6KrTgtJ5n8-oVMGqzxvW_zd_hrcWFoE2AHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ch8fwk-o7W6KrTgtJ5n8-oVMGqzxvW_zd_hrcWFoE2AHg@mail.gmail.com>

On Tue, Sep 03, 2024 at 09:34:58AM -0700, Namhyung Kim wrote:

> > While the IBS thing only sucks when you use exclude_[user,kernel]
> > things. Stealth suckage is bad and enrages people.
> 
> Right, let's make it explicit like the above.

Given Ravi's concern, perhaps a whole second PMU instance 'ibs_swfilt'
or so? Might have more problems than its worth though, but perhaps
something worth exploring for a bit.

