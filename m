Return-Path: <linux-kernel+bounces-331360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 152C197ABD1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444311C217D9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8946214A0A0;
	Tue, 17 Sep 2024 07:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pi/MiEDF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC74D5C613;
	Tue, 17 Sep 2024 07:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726556905; cv=none; b=tqzgaM4KDVGNJGWQzsam3rikBYO9ZNGo5Cz5umV5y8WcnJ1lXxQRWdtd3puFeJD/xCsHF/l1gmDzDps7xJOUhiMUE+MiRYjme1h2N+5koLO2jb4yhAJ82knImgEqdfbRLC5lHSivsRktp4MQ6e0OMHylhyHRWwm41MfSe0ozonQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726556905; c=relaxed/simple;
	bh=ywDWDT7uwRjpjVeQCDAYEXrWBlGwwNQFLzAouXZ5Fp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qqq3wpSkd1q+72ZUdBPPYiFJ7db5Z8W0NLI1czI1cMoFIMA4rRA0yyW1uJ2H8WzHsm9GciW9Z+slIbhwW8z29YGKYdiJyFHoGqJf88tXxuY9d6I621fZ5Ce6FO0U6KxzRLKPxwbStCGnvzk2ZjLn3P/1UHgQ7AitTcLvcJlAXVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pi/MiEDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF951C4CECE;
	Tue, 17 Sep 2024 07:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726556904;
	bh=ywDWDT7uwRjpjVeQCDAYEXrWBlGwwNQFLzAouXZ5Fp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pi/MiEDFtexiTTgZTDadyhzzx9yFK3hhOqM7BfcZlxJ26q/uLRKBok9H9C9qESr3v
	 H5ajlgnvcMcHZfGn1O/daOMxiV0ixBxf4RuTpR3VB2gtU4YYWxAITapWxgy3SVBZeU
	 YtAL5EeIutyqNbEyrTL2L7KCwzq4ekoYhjfE1HJM=
Date: Tue, 17 Sep 2024 09:08:20 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Selvarasu Ganesan <selvarasu.g@samsung.com>,
	"felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
	"dh10.jung@samsung.com" <dh10.jung@samsung.com>,
	"naushad@samsung.com" <naushad@samsung.com>,
	"akash.m5@samsung.com" <akash.m5@samsung.com>,
	"rc93.raju@samsung.com" <rc93.raju@samsung.com>,
	"taehyun.cho@samsung.com" <taehyun.cho@samsung.com>,
	"hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
	"eomji.oh@samsung.com" <eomji.oh@samsung.com>,
	"shijie.cai@samsung.com" <shijie.cai@samsung.com>,
	stable <stable@kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: core: Stop processing of pending events if
 controller is halted
Message-ID: <2024091758-devotion-clutter-29f6@gregkh>
References: <CGME20240916224630epcas5p42b355e2884c665e19d3c9c3a5afd428e@epcas5p4.samsung.com>
 <20240916224543.187-1-selvarasu.g@samsung.com>
 <20240916230032.ugw23x7gijamrf5x@synopsys.com>
 <2024091716-snide-mashing-2c21@gregkh>
 <20240917054703.w47rfo7x4lhzgccn@synopsys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917054703.w47rfo7x4lhzgccn@synopsys.com>

On Tue, Sep 17, 2024 at 05:47:05AM +0000, Thinh Nguyen wrote:
> On Tue, Sep 17, 2024, gregkh@linuxfoundation.org wrote:
> > On Mon, Sep 16, 2024 at 11:00:30PM +0000, Thinh Nguyen wrote:
> > > On Tue, Sep 17, 2024, Selvarasu Ganesan wrote:
> > > > This commit addresses an issue where events were being processed when
> > > > the controller was in a halted state. To fix this issue by stop
> > > > processing the events as the event count was considered stale or
> > > > invalid when the controller was halted.
> > > > 
> > > > Fixes: fc8bb91bc83e ("usb: dwc3: implement runtime PM")
> > > > Cc: stable <stable@kernel.org>
> > > 
> > > Checkpatch doesn't like that format. Fix the Cc stable tag to below:
> > > 
> > > Cc: stable@kernel.org
> > 
> > What?  Why?  That should be fine, exactly what is the warning that this
> > gives?  That should be fine, as it's what my scripts put into patches
> > that I create :)
> > 
> 
> This is what checkpatch complains:
> 
> WARNING:BAD_STABLE_ADDRESS_STYLE: Invalid email format for stable: 'stable <stable@kernel.org>', prefer 'stable@kernel.org'
> #23: 
> Cc: stable <stable@kernel.org>
> 
> total: 0 errors, 1 warnings, 0 checks, 72 lines checked

Ugh, that's wrong, whatever you want to do here is fine.

Someone should send a patch for checkpatch...

thanks,

greg k-h

