Return-Path: <linux-kernel+bounces-564313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A4FA6528A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4131712C5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB942405E7;
	Mon, 17 Mar 2025 14:13:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF2E20322
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220835; cv=none; b=ZBvT/aSiqHpnONbZ04/9M8ba5YEQxUEWxuAT1Df0JjKRO53zVIjG1SS6EDJZdpF3pQcfLLU+NPeZb/zKu2855Bs+qevHQYSgElAe+zsmAuT0bamJ2eER81BlJ7LM11P/Tys52JM85KrVkmUxZTWlkD/QE+e+r9aBP3k+luQmano=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220835; c=relaxed/simple;
	bh=1qsOHAWD51igFnW0QxJV/k+zKI7q662EOWBaJCGlNLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVRNHKMyY0n8jsbCty6wa/RwX9SYVAXSLiBeRNXY1wlcg03kwVyRz9kibbgSwhfe3Ug39mqN4H0uaXlN4Vay+TY6mNdJ0+qkK97buPLR4CFiTmeB07Sh91h0rqTz9kSwWheQBK/utFlhgmq+b1xBcvGHVmeFDLsxD3PLdFPbHFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 616FF13D5;
	Mon, 17 Mar 2025 07:14:02 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C2683F63F;
	Mon, 17 Mar 2025 07:13:52 -0700 (PDT)
Date: Mon, 17 Mar 2025 14:13:49 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 9/9] regulator: dummy: convert to use the faux device
 interface
Message-ID: <Z9guHSE0nwC1-52J@bogus>
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
 <20250317-plat2faux_dev-v1-9-5fe67c085ad5@arm.com>
 <2025031716-decaf-overhead-c56c@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025031716-decaf-overhead-c56c@gregkh>

On Mon, Mar 17, 2025 at 02:00:04PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Mar 17, 2025 at 10:13:21AM +0000, Sudeep Holla wrote:
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Why are you resending my patch back to me?
> 
> > The dummy regulator driver does not need to create a platform device, it
> > only did so because it was simple to do.  Change it over to use the
> > faux bus instead as this is NOT a real platform device, and it makes
> > the code even smaller than before.
> > 
> > Reviewed-by: Mark Brown <broonie@kernel.org>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Message-Id: <2025021027-outclass-stress-59dd@gregkh>
> > (sudeep.holla: Made dummy_regulator_driver static)
> 
> So this is a new version?
> 

Not really, I pulled your patch as I needed that as well to clean out
all faux device out of platform. I just made dummy_regulator_driver
static back again as compiler was warning. Definitely nothing new.
I will drop it when posting v2. You can probably fix up to make
dummy_regulator_driver static.

> And as was pointed out, this is already in my tree, and there's a
> conflict in linux-next with it.
> 

Ah may be I missed to pull the updated next. I see I was still on
next-20250311. Sorry for that.

-- 
Regards,
Sudeep

