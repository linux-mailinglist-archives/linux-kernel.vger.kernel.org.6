Return-Path: <linux-kernel+bounces-329872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD35A9796EA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 15:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 909061F217BC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 13:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A871C689D;
	Sun, 15 Sep 2024 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jlCRY4Cv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422AADDAB
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726408505; cv=none; b=fOPkyCoEx77Z9XdxmHnemF5+XgKeQDJvKajproEpnRkRZpzkpEL0EtTIDS+oNDOCLHo51AMEFvrlfNkd21JGN9+atOFZuL61NqUeLBAbuRk6ODm9lB/Xx7dIyy6VHfSR6ZFXg2zmNUys8JAFKPGeD88M8t1BDrsDuaimi83bkuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726408505; c=relaxed/simple;
	bh=feYcvX92fzhwVgpoLl2/bDUk+ob3518g7/2cknSRsz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JD13bo/hlMJYTCqFZ6DVzOsH9UAqwu6gNtr8RMSlmxRDozD6cl9wdIfy9AwNjzZBjZ8ccOHKl3hRFj/m8Z6ZOz7471ABM5BYACCVTFNcVPtsyeqIQnQO+lu9tYxRbUAkOUDr3dUdlrFTEntE7+OZNpekavPeN/R5J0IG3FZOu8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jlCRY4Cv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1388AC4CEC3;
	Sun, 15 Sep 2024 13:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726408504;
	bh=feYcvX92fzhwVgpoLl2/bDUk+ob3518g7/2cknSRsz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jlCRY4Cv5F8bSz47aSmvYLm6uInqfmO9tZiEbVEhAzGVlDXi+2eHbELwCWqCw9WtN
	 jYbOYrXmu4yVRbAuGzWO052XWaLL43VVoEqNKlyRI2gmZ++BTHaIdzgpkms/TVXCNd
	 Pkvc8lgTjZA3EEeE2BkOT5bNKEtuqHjhiPvOlhSo=
Date: Sun, 15 Sep 2024 15:55:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH] driver core: bus: Mark an impossible error path with
 WARN_ON() in bus_add_driver()
Message-ID: <2024091540-scrubber-navigator-4aae@gregkh>
References: <20240915-bus_add_driver_fix-v1-1-ce5cf1f66601@quicinc.com>
 <2024091530-antacid-magical-8302@gregkh>
 <8620a8a6-9101-4f53-858f-2e09aa310d16@icloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8620a8a6-9101-4f53-858f-2e09aa310d16@icloud.com>

On Sun, Sep 15, 2024 at 09:38:15PM +0800, Zijun Hu wrote:
> On 2024/9/15 21:00, Greg Kroah-Hartman wrote:
> > On Sun, Sep 15, 2024 at 06:22:05PM +0800, Zijun Hu wrote:
> >> From: Zijun Hu <quic_zijuhu@quicinc.com>
> >>
> >> driver_attach() called by bus_add_driver() always returns 0, so its
> >> corresponding error path will never happen, hence mark the impossible
> >> error path with WARN_ON() to remind readers to disregard it.
> > 
> > So you just caused the machine to crash and reboot if that happens
> > (remember, panic-on-warn is enabled in a few billion Linux systems...)
> > 
> are there good way to mark a if condition which is always or mostly
> evaluated to false currently without any side effect?

If always, then remove the code involved.  If mostly, just do it
normally.

> i think this is a generic requirement since readers may not want to
> care about things which will never or rarely happen, below link
> involves such discussion:
> https://lore.kernel.org/all/2024090444-earmark-showpiece-b3dc@gregkh/

Yes, but likely/unlikely is for performance, not for documentation.

> >> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >> ---
> >>  drivers/base/bus.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> >> index 657c93c38b0d..59a48edda267 100644
> >> --- a/drivers/base/bus.c
> >> +++ b/drivers/base/bus.c
> >> @@ -673,7 +673,7 @@ int bus_add_driver(struct device_driver *drv)
> >>  	klist_add_tail(&priv->knode_bus, &sp->klist_drivers);
> >>  	if (sp->drivers_autoprobe) {
> >>  		error = driver_attach(drv);
> >> -		if (error)
> >> +		if (WARN_ON(error))
> > 
> > What exactly are you trying to show here?  If this really can never
> > fail, then let's just remove the check entirely.
> > 
> what i want to show is that this error patch will never happen here
> currently, so readers can disregard it.

Then just remove it, and document in the changelog text why it can never
happen.  But if it can never happen, then why is the function returning
anything at all?

thanks,

greg k-h

