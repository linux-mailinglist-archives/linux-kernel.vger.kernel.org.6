Return-Path: <linux-kernel+bounces-518662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C538A392BE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 06:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8693A8D21
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 05:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC1F10E5;
	Tue, 18 Feb 2025 05:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qPRY7nXQ"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8721ADC7B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 05:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857050; cv=none; b=OpOMSQzXHDxJgmaPRYK1JQtQ9EEENgN5lx99UuqQg2tVlT4tGpY7sn/AgXSFkO/VEo/h7wK2IbwjrlkE3cKU6PU42ut24q/E2TebvInFEvgvQ/CgDvUO8CeleWJOsrBbj3mH50Lvr7/QoYyKW/5s593/2PG/nqCbJcC3TG4XSOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857050; c=relaxed/simple;
	bh=ydcfEgpFmy0Opc0kYIKrMFDGRcZX7PpHaaVEPyf3deU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmV4tu9pyTGwL2hJ581zLlkhrv7K0n4sezGxF8tw8GOIwg8EZlE1CivuigDhaBHnVXbCwY/EyDxT4Y5ZShbnvSVebJkx/ahnXdWF/xHROOrkL7Gb30JKUl6YvZhP5hTyMQR8SIC/7CumYiLWct6JEoTpzgK37/YPhhe6oA96g8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qPRY7nXQ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fc1843495eso6480560a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 21:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739857048; x=1740461848; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E3LgCwwHrSVBw8VcF/VUH5CZH7PQnHAbf7XzteETMfM=;
        b=qPRY7nXQhY5qrBPyY4k+f/sAZKUX/waABeGqUl5h2T1JXPXP3hz+vTIn1ih5ebx44S
         JM7IkhYln4P5nfM2ne8KwnGw1tok6VRO5emUqzifDEEUZLJjmQjIKQRBC5g8czYnVWF1
         qGncF1g1RiCxqsc+toJmPuPS96sc1oxUj8JWTukCg/julTSQyDPMFiZI0EoQYbsEffAl
         HvXfGARMbsUQoM/ZEtEnEUKNAIvg6+7kyGX6eU10LBnoTpq8+sC0AothWG4MXeu+1dEW
         poKKENsjsGf1BkUd5Mair/PJRbe+jaLZ1/D31pBKRHE+fr4fMl4g30NCP/VhcWnhU8Vc
         HWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739857048; x=1740461848;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3LgCwwHrSVBw8VcF/VUH5CZH7PQnHAbf7XzteETMfM=;
        b=NDbz4Y8P9k2rXfGx6dnLpNsMUPJ0IZHEiVznEmsFRnohuJTnEKpWdhDbFP0xDeo5Cp
         AzOOaZFytu/o5zwWemolVT5SeGaqFKq7Q0yj6zhZXi6Oi1UqQ/TbFRui36DsOSlMxQa6
         40zHO3zzqykGuHrQhyf4KHIaKOzB8hTwEejaswl1KCy0QQ37eexOZ0q86FCjLX83qpMj
         Av/4/GZ0yZZi7zOzQxJG2Fg0wN7IhqJXySqw5iDFWllPNYp/LjC8rPaq6gbm7mfmRt8S
         pPr9DEVcHozu/jbK9a6hxgHkkXzIKo44T6yya1beUHbuBNZQE9yAT08LIHgK2+0UW0Rv
         eOrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXO1Kjg/mNXjx4UAMLDVWUVPJUqZXncsudfQh8dNhBH+foeUYm7WizzRlgB4hQjfrZezhzfsj/YObvGR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHaKwJ2YZk5rgcmR3Z9Tn3NisyuG8OfRTjqriatL7aRVoQUvDd
	/UjIcigSyKBiUGew3yGR1z8T8XrQc6jMFpthpEkX7hcRSpddkiY7c+/H5Wk46w==
X-Gm-Gg: ASbGnctikCRK+U137MFdzEjqTKiWNH/aEctrGciq8Owf35SuGUP1aBEFWuIiMKZ0mTG
	56PqyOPQKdqplTy8nOBRi9IxT/N8uaPt/pz31bwApXp+J7B6yGBoMga4k4b+PVMWOuBg00VqZTy
	Zw4NcWmaDKR/+ylmVefdD/8vElzMzWrd9RLolpbSN0XMq7SS0418q20dn0MZCP9OjMCCOL822n5
	7fGGENzUfHO0yteIf73qyfF1JBO8ZGg/sLHhf4mkJH4lnwBtQkGDMD9xo/LlickQ32Vht0RpZTH
	vyoitKmVvKGAVzjSzN1aAlv4ghx6nwvab7g8aZKjkVD1QlP9JQZEtOZcug==
X-Google-Smtp-Source: AGHT+IEOFCUt2fEoTGuhtkT6gsU7m7ZPjwbIWDV001siJUDEHcwNviFcdoNhxdMX4BwXeZIt7qtHww==
X-Received: by 2002:a17:90b:1e4f:b0:2fa:13e9:8cb0 with SMTP id 98e67ed59e1d1-2fc41153fe0mr16845463a91.31.1739857047838;
        Mon, 17 Feb 2025 21:37:27 -0800 (PST)
Received: from google.com (49.156.143.34.bc.googleusercontent.com. [34.143.156.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13aafebesm9050586a91.4.2025.02.17.21.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 21:37:27 -0800 (PST)
Date: Tue, 18 Feb 2025 11:07:19 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Brian Norris <briannorris@google.com>, Oliver Neukum <oneukum@suse.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Joy Chakraborty <joychakr@google.com>,
	Vamshi Gajjela <vamshigajjela@google.com>,
	Manu Gautam <manugautam@google.com>
Subject: Re: PM runtime_error handling missing in many drivers?
Message-ID: <Z7QcjvKRGKgrI8EC@google.com>
References: <4ca77763-53d0-965a-889e-be2eafadfd2f@intel.com>
 <1937b65c-36c0-5475-c745-d7285d1a6e25@suse.com>
 <CAJZ5v0j0mgOcfKXRzyx12EX8CYLzowXrM8DGCH9XvQGnRNv0iw@mail.gmail.com>
 <5c37ee19-fe2c-fb22-63a2-638e3dab8f7a@suse.com>
 <CAJZ5v0ijy4FG84xk_n8gxR_jS0xao246eVbnFj-dXzwz=8S9NQ@mail.gmail.com>
 <Z6lzWfGbpa7jN1QD@google.com>
 <Z6vNV8dDDPdWUKLS@google.com>
 <CAJZ5v0i83eJWV_kvWxZvja+Js3tKbrwZ8rVVGn7vR=0qLf1mtw@mail.gmail.com>
 <Z7Kx2RN35QVyg8nP@google.com>
 <CAJZ5v0hom5Ex9xCfd_qD7XyFxie1iy2L_T8vDNWF-xBMmq=9aQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hom5Ex9xCfd_qD7XyFxie1iy2L_T8vDNWF-xBMmq=9aQ@mail.gmail.com>

On Mon, Feb 17, 2025 at 09:23:18PM +0100, Rafael J. Wysocki wrote:
> On Mon, Feb 17, 2025 at 4:49 AM Ajay Agarwal <ajayagarwal@google.com> wrote:
> >
> > On Wed, Feb 12, 2025 at 08:29:34PM +0100, Rafael J. Wysocki wrote:
> > > On Tue, Feb 11, 2025 at 11:21 PM Brian Norris <briannorris@google.com> wrote:
> > > >
> > > > Hi Ajay,
> > > >
> > > > On Mon, Feb 10, 2025 at 09:02:41AM +0530, Ajay Agarwal wrote:
> > > > > On Wed, Jul 27, 2022 at 06:31:48PM +0200, Rafael J. Wysocki wrote:
> > > > > > On Wed, Jul 27, 2022 at 10:08 AM Oliver Neukum <oneukum@suse.com> wrote:
> > > > > > > On 26.07.22 17:41, Rafael J. Wysocki wrote:
> > > > > > > > Well, in general suspending or resuming a device is a collaborative
> > > > > > > > effort and if one of the pieces falls over, making it work again
> > > > > > > > involves fixing up the failing piece and notifying the others that it
> > > > > > > > is ready again.  However, that part isn't covered and I'm not sure if
> > > > > > > > it can be covered in a sufficiently generic way.
> > > > > > >
> > > > > > > True. But that still cannot solve the question what is to be done
> > > > > > > if error handling fails. Hence my proposal:
> > > > > > > - record all failures
> > > > > > > - heed the record only when suspending
> > > > > >
> > > > > > I guess that would boil down to moving the power.runtime_error update
> > > > > > from rpm_callback() to rpm_suspend()?
> > > > > Resuming this discussion. One of the ways the device drivers are
> > > > > clearing the runtime_error flag is by calling pm_runtime_set_suspended
> > > > > [1].
> > >
> > > I personally think that jumping on a 2.5 years old thread is not a
> > > good idea.  It would be better to restate the problem statement and
> > > provide the link to the previous discussion.
> > >
> > > > > To me, it feels weird that a device driver calls pm_runtime_set_suspended
> > > > > if the runtime_resume() has failed. It should be implied that the device
> > > > > is in suspended state if the resume failed.
> > > > >
> > > > > So how really should the runtime_error flag be cleared? Should there be
> > > > > a new API exposed to device drivers for this? Or should we plan for it
> > > > > in the framework itself?
> > > >
> > > > While the API naming is unclear, that's exactly what
> > > > pm_runtime_set_suspended() is about. Personally, I find it nice when a
> > > > driver adds the comment "clear runtime_error flag", because otherwise
> > > > it's not really obvious why a driver has to take care of "suspending"
> > > > after a failed resume. But that's not the biggest question here, IMO.
> > > >
> > > > The real reson I pointed you at this thread was because I think it's
> > > > useful to pursue the proposal above: to avoid setting a persistent
> > > > "runtime_error" for resume failures. This seems to just create a pitfall
> > > > for clients, as asked by Vincent and Oliver upthread.
> > > >
> > > > And along this line, there are relatively few drivers that actually
> > > > bother to reset this error flag ever (e.g., commit f2bc2afe34c1
> > > > ("accel/ivpu: Clear runtime_error after pm_runtime_resume_and_get()
> > > > fails")).
> > > >
> > > > So to me, we should simply answer Rafael's question:
> > > >
> > > > (repeated:)
> > > > > > I guess that would boil down to moving the power.runtime_error update
> > > > > > from rpm_callback() to rpm_suspend()?
> > > >
> > > > Yes, I think so. (Although I'm not sure if this leaves undesirable spam
> > > > where persistent .runtime_resume() failures occur.)
> > > >
> > > > ...and then write/test/submit such a patch, provided it achieves the
> > > > desired results.
> > > >
> > > > Unless of course one of the thread participants here has some other
> > > > update in the intervening 2.5 years, or if Rafael was simply asking the
> > > > above rhetorically, and wasn't actually interested in fielding such a
> > > > change.
> > >
> > > The reason why runtime_error is there is to prevent runtime PM
> > > callbacks from being run until something is done about the error,
> > > under the assumption that running them in that case may make the
> > > problem worse.
> > >
> > > I'm not sure if I see a substantial difference between suspend and
> > > resume in that respect: If any of them fails, the state of the device
> > > is kind of unstable.  In particular, if resume fails and the device
> > > doesn't actually resume, something needs to be done about it or it
> > > just becomes unusable.
> > >
> > > Now, the way of clearing the error may not be super-convenient, which
> > > was a bit hard to figure out upfront, so I'm not against making any
> > > changes as long as there are sufficient reasons for making them.
> >
> > I am thinking if we can start with a change to not check runtime_error
> > in rpm_resume, and let it go through even if the previous rpm_resume
> > attempt failed. Something like this:
> >
> > ```
> > static int rpm_resume(struct device *dev, int rpmflags)
> >         trace_rpm_resume(dev, rpmflags);
> >
> >   repeat:
> > -       if (dev->power.runtime_error) {
> > -               retval = -EINVAL;
> > -       } else if (dev->power.disable_depth > 0) {
> > +       if (dev->power.disable_depth > 0) {
> >                 if (dev->power.runtime_status == RPM_ACTIVE &&
> >                     dev->power.last_status == RPM_ACTIVE)
> >                         retval = 1;
> > ```
> >
> > I think setting the runtime_error in rpm_callback, i.e. for both resume
> > and suspend is still a good idea for book-keeping purposes, e.g. the
> > user reading the runtime_status of the device from sysfs.
> 
> What would be the benefit of this change?
The benefit would be that the runtime_resume would be re-attempted even if
the previous attempt failed.

