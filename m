Return-Path: <linux-kernel+bounces-343506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6B0989BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2E31C213D2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971651684A5;
	Mon, 30 Sep 2024 07:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McsR8LKq"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53461158DB1
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682434; cv=none; b=kVY5MMGKtF9+3nQkdhnQXg5aacReMewHx8W2jlGJw3Xzh4Z60a2PHcG+EInpxS0k6Xe/i4Zgu20E6P/f5qmRme9KI+tNeOdeU4IhsMW5mz7L3S2gdqHDGELCclbJLErejoIKt1dMHaXTL2EOuxxqEv2glh6Xy/BcE+wpDibUMfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682434; c=relaxed/simple;
	bh=qTXCl7jkU7qj2qIV9gSYqUUPOQwXWOyMHjHHkE7sD3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tE9Z3XytIBaFruS4ZqYAEMuhqE99GLKnpHscSodb0dpyMMBJe64GCcX5aHjfSSyarpwpI7chVMOy0mROulOJ8zJyjwbpl6IIETOR98hCDtLd7zXcSLctVozxcLZB/0TDOQGEXusPJ4xv8tCngG3VLxllbPa54f7sR8ow8BOGV5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McsR8LKq; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e042f4636dso2662912b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 00:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727682432; x=1728287232; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KVOqlKSKUGPN4TK8Dqm9vQi76XiRZyWkboZFUbk1UY4=;
        b=McsR8LKqmqazPwdsMaJvCiLqVczaoLTKUCzKbBrndjqS94C5TSUZ1dTkdgUYqghsCj
         3UW4PWsiw3/nxYb0JEmVIE3J7lWxpvVaBsMzFtJ7S8TX21WRgLrCQZyrLa/FJwVb9As2
         lirKWqNf35MUj23DlggxLFjOXrTF5QiPZRIjuPGkuUJSrqXCZrj5OSq2LB798/20I0YH
         Q9e4sFOHNaZIwUyS/uPwTZIW8QqjThVHCn2FCK5nHr6/IG4SZMaw6yYhsHsPi/DDRfTO
         4Q3ax/VxzAuFIt3koxbFDpKiQtzreCu7TrbAC9nYTWZcy2fNqOtISOICijQkzz0Xl/5F
         TE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727682432; x=1728287232;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KVOqlKSKUGPN4TK8Dqm9vQi76XiRZyWkboZFUbk1UY4=;
        b=xVXmEM36uSnJ2XG0MIrlKWqh9KQ02jdRbXxVwZLW0TOzsVoJOhg+ztFnjUlNO3rKZg
         L/Hvvu3vTbbmGWbiCxWzMKVbCiWiWZFg420bkSrShicJqN+pXX76r8irXMZBkhq0TY/Z
         /BohjdO8rbZxJeM75JbFe3I8VeXojM0Kcd9D+ic9vsks/lHE5Xh0937F/ClO6w7nkfeZ
         4hpAAyG+MQ7G7lZ5MVCv0TmjIhR9tZgqyL2/4hu656dvosboUb4PeiRksuHaa/fX70PM
         lOO45tU72eD0G7RTXDsXRZBTBMt0Gr/eEnMNFABnj5pcHZNPVuG0u/Hfxvz5H1SmJrKU
         /ojg==
X-Gm-Message-State: AOJu0YwxvMpeym8K5rOUhzCE9P3tTZibNyhUtJ7Zk47weI6aA15cIT3W
	UUXJEX9IEt0rwUg3mPI0CMBqnMHJJ7DJBVJAN0U9n2Yf2eFQNN9W9t2Svzed
X-Google-Smtp-Source: AGHT+IHWJ41COZoQ4hZQibBG9GESrm2+QaiU+OrzikP449ZW6otKwrzP34+2bkFZHzrJAZECpRnilg==
X-Received: by 2002:a05:6808:210b:b0:3e0:48b2:3f40 with SMTP id 5614622812f47-3e3939e3127mr5808744b6e.45.1727682432140;
        Mon, 30 Sep 2024 00:47:12 -0700 (PDT)
Received: from rigel (14-202-6-222.static.tpgi.com.au. [14.202.6.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bb9f4sm5674377b3a.72.2024.09.30.00.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 00:47:11 -0700 (PDT)
Date: Mon, 30 Sep 2024 15:47:07 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-kernel@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH v5 8/8] pwm: Add support for pwmchip devices for faster
 and easier userspace access
Message-ID: <20240930074707.GA57004@rigel>
References: <cover.1726819463.git.u.kleine-koenig@baylibre.com>
 <657876d1321467a2b23060ac15924aed8c423390.1726819463.git.u.kleine-koenig@baylibre.com>
 <20240929044828.GA21440@rigel>
 <hgoario7a2x6zoyjy5frbjmxla5vzkbucos55gsjycvxudue65@xqdta7kezomc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hgoario7a2x6zoyjy5frbjmxla5vzkbucos55gsjycvxudue65@xqdta7kezomc>

On Mon, Sep 30, 2024 at 08:01:45AM +0200, Uwe Kleine-König wrote:
> Hello Kent,
>
> On Sun, Sep 29, 2024 at 12:48:28PM +0800, Kent Gibson wrote:
> > On Fri, Sep 20, 2024 at 10:58:04AM +0200, Uwe Kleine-König wrote:
> > > +static int pwm_cdev_request(struct pwm_cdev_data *cdata, unsigned int hwpwm)
> > > +{
> > > +	struct pwm_chip *chip = cdata->chip;
> > > +
> > > +	if (hwpwm >= chip->npwm)
> > > +		return -EINVAL;
> > > +
> > > +	if (!cdata->pwm[hwpwm]) {
> > > +		struct pwm_device *pwm = &chip->pwms[hwpwm];
> > > +		int ret;
> > > +
> > > +		ret = pwm_device_request(pwm, "pwm-cdev");
> > > +		if (ret < 0)
> > > +			return ret;
> > > +
> > > +		cdata->pwm[hwpwm] = pwm;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> >
> > Allow the user to specify the consumer label as part of the request rather
> > than hard coding it to "pwm-cdev"?
>
> I considered using the process name, or pwm-cdev:$(pidof
> userspace-program). And I'd like to have a possibility to specify names
> in dt (that then could be used to lookup a PWM, too). I think these two
> are better than having userspace provide a name. What do you think?
>

Are we talking the PWM device or the consumer?  Or both?

Wrt the consumer, For GPIO we don't provide a useful default, though perhaps
we should. Instead we rely on the userspace library to provide one - if the
user hasn't.

I'd go with the pid option - that is more unique than the process name.

It could still be useful for the user to be able to provide a label,
especially if you are going to allow arbitrary labels via dt.  Though as
often as not the user doesn't know what name to provide and fills it with
something useless, so I don't think there is any clear winner here.

> > > +static int pwm_cdev_free(struct pwm_cdev_data *cdata, unsigned int hwpwm)
> > > +{
> > > +	struct pwm_chip *chip = cdata->chip;
> > > +
> > > +	if (hwpwm >= chip->npwm)
> > > +		return -EINVAL;
> > > +
> > > +	if (cdata->pwm[hwpwm]) {
> > > +		struct pwm_device *pwm = cdata->pwm[hwpwm];
> > > +
> > > +		__pwm_put(pwm);
> > > +
> > > +		cdata->pwm[hwpwm] = NULL;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static struct pwm_device *pwm_cdev_get_requested_pwm(struct pwm_cdev_data *cdata,
> > > +						     u32 hwpwm)
> > > +{
> > > +	struct pwm_chip *chip = cdata->chip;
> > > +
> > > +	if (hwpwm >= chip->npwm)
> > > +		return ERR_PTR(-EINVAL);
> > > +
> > > +	if (cdata->pwm[hwpwm])
> > > +		return cdata->pwm[hwpwm];
> > > +
> > > +	return ERR_PTR(-EINVAL);
> > > +}
> > > +
> > > +static long pwm_cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > > +{
> > > +	int ret = 0;
> > > +	struct pwm_cdev_data *cdata = file->private_data;
> > > +	struct pwm_chip *chip = cdata->chip;
> > > +
> > > +	guard(mutex)(&pwm_lock);
> > > +
> >
> > Coarse grain locking of the whole of pwm for the duration, where some
> > calls my sleep, feels excessive. Is it really necessary for all of the
> > ioctls?
>
> This might be improvable a bit indeed. I think we won't come around
> holding the pwmchip lock, but that would already be nice. I'll invest
> some brain cycles here.
>

That can always be a later refinement - better too much locking than
too little.

> > > +/**
> > > + * struct pwmchip_waveform - Describe a PWM waveform for a pwm_chip's PWM channel
> > > + * @hwpwm: per-chip relative index of the PWM device
> > > + * @__pad: padding, must be zero
> > > + * @period_length_ns: duration of the repeating period
> > > + * @duty_length_ns: duration of the active part in each period
> > > + * @duty_offset_ns: offset of the rising edge from a period's start
> > > + */
> >
> > While you have added some documentation, this is still lacking compared
> > to the corresponding in include/linux/pwm.h.  e.g. zeroing
> > period_length_ns to disable a PWM...
>
> Ack.
>
> > > +struct pwmchip_waveform {
> > > +	__u32 hwpwm;
> > > +	__u32 __pad;
> > > +	__u64 period_length_ns;
> > > +	__u64 duty_length_ns;
> > > +	__u64 duty_offset_ns;
> > > +};
> > > +
> > > +#define PWM_IOCTL_REQUEST	_IO(0x75, 1)
> > > +#define PWM_IOCTL_FREE		_IO(0x75, 2)
> > > +#define PWM_IOCTL_ROUNDWF	_IOWR(0x75, 3, struct pwmchip_waveform)
> > > +#define PWM_IOCTL_GETWF		_IOWR(0x75, 4, struct pwmchip_waveform)
> > > +#define PWM_IOCTL_SETROUNDEDWF	_IOW(0x75, 5, struct pwmchip_waveform)
> > > +#define PWM_IOCTL_SETEXACTWF	_IOW(0x75, 6, struct pwmchip_waveform)
> > > +
> >
> > A brief description of the ioctls and their semantics would be handy,
> > either here or as full blown documentation in
> > linux/Documentation/userspace-api/pwm/...
>
> Ack.
>
> > PWMs are automatically released when the pwmchip file is closed?
> > And the state of the PWM line after release (or _FREE) is indeterminate?
> >
> > Is it possible that the underlying PWM chip be removed while the user has
> > the pwmchip open and/or has pwm devices requested?
>
> I guess these questions are hints about what to describe in the docs to
> be written and not actual questions. I fully agree that the
> documentation front isn't optimal yet.
>

Yup, and as per the locking, the documentation can always be a later
refinement - so long as your intent is clear now before the ioctls get
chiselled in stone.

> > Provide some ioctls to aid discoverability, e.g. for pwm chips exposing the
> > npwms, module name.  For pwm devices the label, if the PWM is requested and
> > the consumer's label (similar to the GPIO chipinfo and lineinfo)?
> > Unless that information otherwise exposed to userspace?
>
> Most of that is already in /sys/class/pwm. Duplicating that feels wrong.
>

Depends on whether you want the interface to be standalone or an
addition to the sysfs - and that is your call.

> Thanks a lot for your feedback

No problem, and again sorry for not getting around to it earlier.

Cheers,
Kent.


