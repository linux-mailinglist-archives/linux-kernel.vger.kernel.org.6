Return-Path: <linux-kernel+bounces-340604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB84C9875BD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DBB71F2310E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6321E148833;
	Thu, 26 Sep 2024 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cANt2Bfn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331472B9CD;
	Thu, 26 Sep 2024 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727361333; cv=none; b=JxVWRnjo6rWhmdMCOxqDgSr1XOjNBQLk37xKm1GFzEtRbu5rQvjaqvM33BWlNohnXZpXNGmRpqOQ52dfxPpn/L14JegH3rlSFCr5jQTYJzvDoVoZe/udZwy9pOyo7Rfjna/AiyDpshyQ34I9Pfd9mWFBnKfFyi1Vh31nHYnpBO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727361333; c=relaxed/simple;
	bh=E/1Oouo5LowP0y9PwY3f7uLqc/wmVvfD0VxV/7H9+jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKnCH3FcQwVMrcCn1Pibpafsg01JUdlJzeEL0mK/a/YvSgjgQ6O4yQlw7m1b1l3mvG3/iCLTOZuUv7pKDQu3f9Qnmfs4jzIWAseBTwCxyxGPWav8q+6vMLnYFU3vGYueBA7Fy/sBngGwwlz/eDEIeRovP9EeCnVfWztGBkyE5lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cANt2Bfn; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727361332; x=1758897332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=E/1Oouo5LowP0y9PwY3f7uLqc/wmVvfD0VxV/7H9+jc=;
  b=cANt2BfnOXM+inmWpVkRNitDRVc3i3Yq8hdKlsyycc0X0wOqWnTlsNUJ
   gpkFUcKcGctRX82EnLu6KCHzfjWiXhPkRDcNf0VsuZOR45kqMuux9RnUu
   g0vKNQE3zlkBwCKZInIFDLcX8XC9V5rX0pEtuuA4dF+bO94T9TTBYtFak
   JWl5PqGHtI0INHNi42baWaq/BC+acOk3T3Vb5fTnVRP5VThmVLl8HiQKm
   8tQb6bpBiRhYUVEFeQbUfTeYeFD2+HV4FpbNj1oeNZGkq1PPlk7I9nQJU
   s4YFZjMjefDTKqb+N/YObMI1Z/MM9lsgf2yrCsI0KPf2cC7XRQUJfKIXJ
   w==;
X-CSE-ConnectionGUID: g7Qiwo9lR2iJKYSYxhywsg==
X-CSE-MsgGUID: bNwP28xtRSaSRIMUINAbYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="51876939"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="51876939"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 07:35:31 -0700
X-CSE-ConnectionGUID: UJ80HjgtQu6IQ1PQgO3KUA==
X-CSE-MsgGUID: du8I75TFQTa8vYoWFdylYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="71782103"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa006.fm.intel.com with SMTP; 26 Sep 2024 07:35:28 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 26 Sep 2024 17:35:27 +0300
Date: Thu, 26 Sep 2024 17:35:27 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, tzungbi@kernel.org,
	jthies@google.com, pmalani@chromium.org, akuchynski@google.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/8] usb: typec: altmode_match should handle
 TYPEC_ANY_MODE
Message-ID: <ZvVxLyQUE9oCJSgU@kuha.fi.intel.com>
References: <20240925162513.435177-1-abhishekpandit@chromium.org>
 <20240925092505.2.Ie0d37646f18461234777d88b4c3e21faed92ed4f@changeid>
 <oedfq4fkjlbalytba7fxg462tyutgxxk5wnhg2mhkfevclv33q@ugc472nkwpo6>
 <CANFp7mXEx370EpWPcsFpiN9jW0iJzjr1povO89bTRX91dZ3XQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANFp7mXEx370EpWPcsFpiN9jW0iJzjr1povO89bTRX91dZ3XQQ@mail.gmail.com>

On Wed, Sep 25, 2024 at 10:31:33AM -0700, Abhishek Pandit-Subedi wrote:
> On Wed, Sep 25, 2024 at 9:54 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Wed, Sep 25, 2024 at 09:25:03AM GMT, Abhishek Pandit-Subedi wrote:
> > > altmode_match is used when searching for the first port altmode that
> > > matches the partner or plug altmode. If the port registered with mode
> > > set to TYPEC_ANY_MODE, it should always match if the SVID matches.
> > >
> > > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> >
> > Fixes?
> 
> This is new for Thunderbolt which registers as TYPEC_ANY_MODE so
> there's no FIXES. I think Heikki may need to chime in on how the
> `mode` is supposed to be used.
> 
> IMO, it may be appropriate to get rid of the mode check entirely.

It's probable okay to just drop it.

> >
> > > ---
> > >
> > >  drivers/usb/typec/class.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> > > index 9262fcd4144f..179856503d5d 100644
> > > --- a/drivers/usb/typec/class.c
> > > +++ b/drivers/usb/typec/class.c
> > > @@ -230,7 +230,8 @@ static int altmode_match(struct device *dev, void *data)
> > >       if (!is_typec_altmode(dev))
> > >               return 0;
> > >
> > > -     return ((adev->svid == id->svid) && (adev->mode == id->mode));
> > > +     return ((adev->svid == id->svid) &&
> > > +             (adev->mode == id->mode || adev->mode == TYPEC_ANY_MODE));
> > >  }
> > >
> > >  static void typec_altmode_set_partner(struct altmode *altmode)
> > > --
> > > 2.46.0.792.g87dc391469-goog
> > >
> >
> > --
> > With best wishes
> > Dmitry

-- 
heikki

