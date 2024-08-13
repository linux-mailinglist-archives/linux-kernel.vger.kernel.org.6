Return-Path: <linux-kernel+bounces-284607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A46C2950302
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517841F23016
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E028819AD48;
	Tue, 13 Aug 2024 10:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IiJD61xr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32682191489
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546379; cv=none; b=hTHZ2yQO0/kA1+vabirQ4NXw3Mh4WcFm1uK6ypp4v9NnFKmDULqhOPYCZSbApGTAJdpS4f70YfJBFruBdE3geMmIELta/yjE5Wt2DabcD6laCq0q0jcyhh4zNGT4vpSmMaY8NQBeru7j4fMWPeMv+O+Nn2A0cjpLNl0u/OZYGM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546379; c=relaxed/simple;
	bh=XM3a8VWak9PxycIbmZCh+wJ2tfXvnwnWWKYdvHzsofM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFyJdv3tlTnYwaTn24crMrLXoi1eVAqTlojAD7hgIyy1KKGB/qme3N81APEtPUNnAllXlEINupvaGe/h7DcPSPyCjDjomELRySX/6WWCrf/SaTenY+HAkOrPlHQ9X4VKt4MLHX6QKFc7Q9y7Cb0hfUFDG80UvIXBW0mbNqMuJvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IiJD61xr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E513C4AF09;
	Tue, 13 Aug 2024 10:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723546378;
	bh=XM3a8VWak9PxycIbmZCh+wJ2tfXvnwnWWKYdvHzsofM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IiJD61xrkx64FeGdy0yKZDwDa/UrP/828KTr1PNtSY9gz4HMwmCmdF6mIkFnDmyvN
	 +VZLbS2n27m8JPVTJKelCbttpYElAufFiFBMw924GMyr2Fe9xoL0l6ZZIFmW8SywM2
	 WemA/cMY2K40OSpYR0uNZ7GY43zYnQH0cGChrMkI=
Date: Tue, 13 Aug 2024 12:52:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/27] driver core: Constify driver API
 device_find_child()
Message-ID: <2024081329-zero-cloud-d7e4@gregkh>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
 <20240811-const_dfc_done-v1-1-9d85e3f943cb@quicinc.com>
 <2024081359-dart-transpire-8143@gregkh>
 <f9cdd4eb-7c2c-403b-bfd2-06b48a7ca92c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9cdd4eb-7c2c-403b-bfd2-06b48a7ca92c@quicinc.com>

On Tue, Aug 13, 2024 at 06:39:48PM +0800, quic_zijuhu wrote:
> On 8/13/2024 5:48 PM, Greg Kroah-Hartman wrote:
> > On Sun, Aug 11, 2024 at 10:24:52AM +0800, Zijun Hu wrote:
> >> From: Zijun Hu <quic_zijuhu@quicinc.com>
> >>
> >> Constify the following driver API:
> >> struct device *device_find_child(struct device *dev, void *data,
> >> 		int (*match)(struct device *dev, void *data));
> >> to
> >> struct device *device_find_child(struct device *dev, const void *data,
> >>                                  device_match_t match);
> >> typedef int (*device_match_t)(struct device *dev, const void *data);
> >> Since it should not modify caller's match data @*data.
> >>
> >> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >> ---
> >>  drivers/base/core.c    | 11 +++--------
> >>  include/linux/device.h |  4 ++--
> >>  2 files changed, 5 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/base/core.c b/drivers/base/core.c
> >> index 3f3ebdb5aa0b..f152e0f8fb03 100644
> >> --- a/drivers/base/core.c
> >> +++ b/drivers/base/core.c
> >> @@ -4062,8 +4062,8 @@ EXPORT_SYMBOL_GPL(device_for_each_child_reverse);
> >>   *
> >>   * NOTE: you will need to drop the reference with put_device() after use.
> >>   */
> >> -struct device *device_find_child(struct device *parent, void *data,
> >> -				 int (*match)(struct device *dev, void *data))
> >> +struct device *device_find_child(struct device *parent, const void *data,
> >> +				 device_match_t match)
> >>  {
> >>  	struct klist_iter i;
> >>  	struct device *child;
> >> @@ -4108,11 +4108,6 @@ struct device *device_find_child_by_name(struct device *parent,
> >>  }
> >>  EXPORT_SYMBOL_GPL(device_find_child_by_name);
> >>  
> >> -static int match_any(struct device *dev, void *unused)
> >> -{
> >> -	return 1;
> >> -}
> >> -
> >>  /**
> >>   * device_find_any_child - device iterator for locating a child device, if any.
> >>   * @parent: parent struct device
> >> @@ -4124,7 +4119,7 @@ static int match_any(struct device *dev, void *unused)
> >>   */
> >>  struct device *device_find_any_child(struct device *parent)
> >>  {
> >> -	return device_find_child(parent, NULL, match_any);
> >> +	return device_find_child(parent, NULL, device_match_any);
> >>  }
> >>  EXPORT_SYMBOL_GPL(device_find_any_child);
> >>  
> >> diff --git a/include/linux/device.h b/include/linux/device.h
> >> index b2423fca3d45..76f10bdbb4ea 100644
> >> --- a/include/linux/device.h
> >> +++ b/include/linux/device.h
> >> @@ -1073,8 +1073,8 @@ int device_for_each_child(struct device *dev, void *data,
> >>  			  int (*fn)(struct device *dev, void *data));
> >>  int device_for_each_child_reverse(struct device *dev, void *data,
> >>  				  int (*fn)(struct device *dev, void *data));
> >> -struct device *device_find_child(struct device *dev, void *data,
> >> -				 int (*match)(struct device *dev, void *data));
> >> +struct device *device_find_child(struct device *dev, const void *data,
> >> +				 device_match_t match);
> >>  struct device *device_find_child_by_name(struct device *parent,
> >>  					 const char *name);
> >>  struct device *device_find_any_child(struct device *parent);
> >>
> >> -- 
> >> 2.34.1
> >>
> > 
> > This patch breaks the build:
> > 
> > ./include/linux/device.h:1077:6: error: unknown type name 'device_match_t'
> >  1077 |                                  device_match_t match);
> >       |                                  ^
> > 1 error generated.
> > make[2]: *** [scripts/Makefile.build:117: arch/x86/kernel/asm-offsets.s] Error 1
> > make[1]: *** [/mnt/fast_t2/linux/work/driver-core/Makefile:1193: prepare0] Error 2
> > 
> > How did you test it?
> > 
> > And as you are changing the parameters here, doesn't the build break
> > also because of that?
> > 
> 
> it seems these dependency patches listed within [PATCH 00/27] are not
> picked up.

Of course not, please send stand-alone series if you need them to be
applied in a specific order.

thanks,

greg k-h

