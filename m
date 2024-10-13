Return-Path: <linux-kernel+bounces-362867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA5799BA51
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 18:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 993C3B20EE4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 16:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F714146A60;
	Sun, 13 Oct 2024 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u0UfIuQr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32F712C54B
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 16:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728836668; cv=none; b=QdHel68GC5tQm4hCbLSXuXscsH8GFJ/fdIUv+a9MhQFPqvaf8dTsm5bsUzzlyUKBP7D67Qis53pi074ni+4kOxPHUMkicJHf2vEBSmg6Fg+/4jxk2iKFBzJb0VBFp7HEuqdb4ugjZPgagwSxMWoOhBjpiUJSIgrzwOGRIDo5HT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728836668; c=relaxed/simple;
	bh=2MDbvElUTPCRau+GZFKoCTd7OYJPyEVhG0DQsIzkMHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMZp7eePasplo02M1e39pM1FX0mb56XeFrK0E2hFazDUm4M+9pPRAa4/ssBVI71eXsm3YWOMVrU5WB0OFF9rcidWtZU6k6jJCaggodn7vKJOySutQUo9Vp6hnT3zlFy5XhqM8c5aHnuNuCWXOn240MhiA2jUFkTtjHhou4yn2nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u0UfIuQr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C0DC4CEC5;
	Sun, 13 Oct 2024 16:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728836667;
	bh=2MDbvElUTPCRau+GZFKoCTd7OYJPyEVhG0DQsIzkMHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u0UfIuQrJSe79e1pMWux8bKfeJ9sMPUWfFtvyHXQ0fkJY2nwwfkE9cE2GMI4pXd7R
	 4U+NP75BYZjPgIbX3adoA8GQVf8vJhAgTZfwzsQXuXMta83CW2PyYcA1EHlC9uuuQK
	 6i2SgKoOdhXRNbmr8rB2RMHoN3DSlSWR5R7J6O6w=
Date: Sun, 13 Oct 2024 18:24:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v2] driver core: bus: Remove an impossible error handling
 path in bus_add_driver()
Message-ID: <2024101349-handpick-cozy-f19e@gregkh>
References: <20240917-bus_add_driver_fix-v2-1-a94026443444@quicinc.com>
 <420b202e-e094-4e82-bf77-dd1c62119aa7@icloud.com>
 <2024101316-designing-renegade-6f00@gregkh>
 <c155f97e-b466-4740-ae8e-ce56bcdddf65@icloud.com>
 <2024101333-unrented-bobsled-3ec6@gregkh>
 <fa08e89d-40d0-41b9-8542-f37f1f716b56@icloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa08e89d-40d0-41b9-8542-f37f1f716b56@icloud.com>

On Mon, Oct 14, 2024 at 12:13:30AM +0800, Zijun Hu wrote:
> On 2024/10/14 00:00, Greg Kroah-Hartman wrote:
> > On Sun, Oct 13, 2024 at 11:46:46PM +0800, Zijun Hu wrote:
> >> On 2024/10/13 23:02, Greg Kroah-Hartman wrote:
> >>> On Tue, Sep 17, 2024 at 02:53:32PM +0800, Zijun Hu wrote:
> >>>> On 2024/9/17 14:49, Zijun Hu wrote:
> >>>>> From: Zijun Hu <quic_zijuhu@quicinc.com>
> >>>>>
> >>>>> For the following function call chain:
> >>>>> API driver_register() -> bus_add_driver() -> driver_attach()
> >>>>>
> >>>>> There is an error handling path for driver_attach() returning non-zero
> >>>>> or failure in bus_add_driver(), remove it with below reasons:
> >>>>>
> >>>>> - It is impossible for driver_attach() to have failure in bus_add_driver()
> >>>>>   For int driver_attach(const struct device_driver *drv), the only factor
> >>>>>   which makes it failed is that bus_to_subsys(@drv->bus) is NULL, but
> >>>>>   the factor has been excluded by bus_add_driver() before calling it.
> >>>>>
> >>>>> - driver_attach() is irrelevant with driver_register(), so the former's
> >>>>>   result should not also have an impact on the later.
> >>>>>
> >>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >>>>> ---
> >>>>> Changes in v2:
> >>>>> - Remove the error handling path instead of WARN_ON() it.
> >>>>> - Correct title and commit message
> >>>>> - Link to v1: https://lore.kernel.org/r/20240915-bus_add_driver_fix-v1-1-ce5cf1f66601@quicinc.com
> >>>>> ---
> >>>>>  drivers/base/bus.c | 4 ++--
> >>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> >>>>> index 657c93c38b0d..54ff92aece92 100644
> >>>>> --- a/drivers/base/bus.c
> >>>>> +++ b/drivers/base/bus.c
> >>>>> @@ -674,7 +674,8 @@ int bus_add_driver(struct device_driver *drv)
> >>>>>  	if (sp->drivers_autoprobe) {
> >>>>>  		error = driver_attach(drv);
> >>>>>  		if (error)
> >>>>> -			goto out_del_list;
> >>>>> +			pr_warn("%s: failed to attach driver '%s' to bus '%s'\n",
> >>>>> +				__func__, drv->name, sp->bus->name);
> >>>>
> >>>> driver_attach() has __must_check attribute and this error may be
> >>>> inconsequential for driver_register(), so give pr_warn() here
> >>>
> >>> Yes, but you  now ignore the error, so someone will come back and add
> >>> that error handling in.  I'd just leave it as-is.
> >>>
> >>
> >> driver API driver_attach() may ONLY have below error -EINVAL.
> >> is it worthy of a __must_check attribute ?
> > 
> > Yes.
> > 
> >> i agree with you to leave it as-is if your answer is "YES".
> >> otherwise, i would like to also simply remove __must_check attribute.
> > 
> > Please don't.  If you do that, then callers will end up not checking the
> > results, and we do not want that.
> > 
> okay.
> 
> but as 2nd reason of commit message explained:
> driver_attach() failure should NOT cause driver_register() failure, so
> should ignore driver_attach() failure here.

How could driver_attach() fail and it still be ok to continue?

thanks,

greg k-h

