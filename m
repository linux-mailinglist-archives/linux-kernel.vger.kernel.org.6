Return-Path: <linux-kernel+bounces-178451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630C28C4DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50D41B219CB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 08:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EDC208CA;
	Tue, 14 May 2024 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o6wW9Zr3"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6756F17BB9
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715676325; cv=none; b=Qjm3JoQ2YxvWoyNIjNfDaAY1/BXpzBNCyYiW9LDFEgtreRAVTEM1eLcwCkid59N8Lj/xqOwAGIIbMWolpUFrx4WBTsiL5kAAiMsj3oKa6WPsMKzeO0yG3zSIqgM8EPZwwQtZB+nKxVbVm1HClOmX/Ph6QJtj5L6+z5ktrTx5Bx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715676325; c=relaxed/simple;
	bh=rJIazF0uPRtHdaouZBgz7iYU/9TUHu8dIhCf/WYXSRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGcu5EQpIPtl70N1ofx1Z4L0KS4xp6vRWRomUaXMSsy11JcHAXnmj9HfZOMHA5f+oxOdpgZEUKirpqKpnwu11ypP+yrCXbMTesuFbL8lqVqZZgIJ2wQd0Ct0DEakDzDRuXoH3CQwhKfdZJdr9QUGWvSgJxbSa5Kls/XIanfom1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o6wW9Zr3; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59c5c9c6aeso1308234366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 01:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715676322; x=1716281122; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S5pgGNiE0yFh18inZjwCGMxdi3PkHuc9sldyTkkwOOw=;
        b=o6wW9Zr3LSurg6H+4qb/PCdmOYq8EkMjlrUjb71Hb5UECF11nnNrxGcIwc0pXXdDZD
         enJ3lDnswVGrxWLU60OkL8ICqIBSJqkM/wZefUD9iyfjo22OlJxbBzxng4WMSkZLAsWs
         yS5qaLHWJ5G+cMp4ermyC0SkMwxKMv/Z3kW2ZwVckh8kjqjKb/zTfKk90fDFty4igwjt
         FIY/RBIzW5/EfinmLbMC0TicpXjJVfniyyQK58cXKnJjcQ8fnNr6c++3XROCOOXPtpnf
         b0RiddJ79i0WyafolGafYngkYpwIc3N+DmMW6HBbZjorwe54TPREft09QHC87XSfCYQe
         B8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715676322; x=1716281122;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S5pgGNiE0yFh18inZjwCGMxdi3PkHuc9sldyTkkwOOw=;
        b=AnDqrQEUoET72Dof39yVZHk0X2AwUVQwsSa4VWUDuL67XfKBAYG/z4ypJujF/Phryj
         w2W/m5KzSqU1oad8hoNdsKmPZhKx69Yr4I+GduAxeonFErzehlZ+FcFYVz2p2Ou70Vao
         kubVBcL1fFTm2ZDjUENoFyGXyYr+qd53D50Fb0/qOJFVpNIVbM9NYZPa7lLgdSwknAHd
         6NTS8hY26YtgSZP1gOOPdW8mutHD9IBhNdq318YeyLsfnYuxf/R+YdZFUcicQ7A9Zp37
         8zq6nLjCJ7yP2UyEay7Dvm3TQsBU5WLunm6jH7+YJNFn5Vr8Yu1sDvcftqvnmrJ/gplI
         yflg==
X-Forwarded-Encrypted: i=1; AJvYcCVN8xcUMbQp/CUtPf3kSHcPciPUk2saxbojBk0/ayZoX0dgpr87QmHV6E6LOBetYJPoE9wdoSX3I0IcDKwOrMcLk6Vdp9X//2Gtn8F9
X-Gm-Message-State: AOJu0YxiZ+821UzlxCjW9ZuFQSRlmNzRnElyqFAZHJzMzlRjKvio2XMo
	uykIS5wJKPgFGe7E/Zte/o/V6yN4XhKV8hZYhdibWdHTWCuRaAmEMykS7SX4nIqByx8Bcif7c57
	p
X-Google-Smtp-Source: AGHT+IG/veYk/QiA4TlT19kc88WgCw8A4K1JllN2RbIelSwgiXW/5LElmvH1TSH3Org6cXh64TlRvQ==
X-Received: by 2002:a17:906:2b0d:b0:a59:be21:3575 with SMTP id a640c23a62f3a-a5a2d672ee4mr894591566b.51.1715676321589;
        Tue, 14 May 2024 01:45:21 -0700 (PDT)
Received: from localhost ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17892450sm700476866b.63.2024.05.14.01.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 01:45:20 -0700 (PDT)
Date: Tue, 14 May 2024 10:45:19 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Justin Stitt <justinstitt@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
Message-ID: <0480d602-3ad7-4f8e-a480-9860d56eab30@suswa.mountain>
References: <202404291502.612E0A10@keescook>
 <039d54d6-8aa2-4e5b-829b-69002cff35d3@moroto.mountain>
 <202405131203.F7B97F5E38@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202405131203.F7B97F5E38@keescook>

Snipped all the bits where you are clearly correct.

On Mon, May 13, 2024 at 12:43:37PM -0700, Kees Cook wrote:
> > drivers/usb/class/usbtmc.c:852 usbtmc_generic_read() warn: potential integer overflow from user 'max_transfer_size + 1'
> >    842                   * wMaxPacketSize – 1) to avoid sending a zero-length
> >    843                   * packet
> >    844                   */
> >    845                  remaining = transfer_size;
> >    846                  if ((max_transfer_size % data->wMaxPacketSize) == 0)
> >    847                          max_transfer_size += (data->wMaxPacketSize - 1);
> >    848          } else {
> >    849                  /* round down to bufsize to avoid truncated data left */
> >    850                  if (max_transfer_size > bufsize) {
> >    851                          max_transfer_size =
> >    852                                  roundup(max_transfer_size + 1 - bufsize,
> >                                                 ^^^^^^^^^^^^^^^^^^^^^
> > This can overflow.  We should make it a rule that all size variables
> > have to be unsigned long.  That would have made this safe on 64 bit
> > systems.
> > 
> >    853                                          bufsize);
> >    854                  }
> >    855                  remaining = max_transfer_size;
> 
> Again, do we _want_ this to overflow? It looks like not. I'm not sure
> what this code is trying to do, though. The comment doesn't seem to
> match the code. Why isn't this just roundup(max_transfer_size, bufsize) ?
> 

roundup() has an integer overflow in it.


> > drivers/usb/misc/usbtest.c:1994 iso_alloc_urb() warn: potential integer overflow from user 'bytes + maxp'
> >   1974  static struct urb *iso_alloc_urb(
> >   1975          struct usb_device       *udev,
> >   1976          int                     pipe,
> >   1977          struct usb_endpoint_descriptor  *desc,
> >   1978          long                    bytes,
> >   1979          unsigned offset
> >   1980  )
> >   1981  {
> >   1982          struct urb              *urb;
> >   1983          unsigned                i, maxp, packets;
> >   1984  
> >   1985          if (bytes < 0 || !desc)
> >   1986                  return NULL;
> >   1987  
> >   1988          maxp = usb_endpoint_maxp(desc);
> >   1989          if (udev->speed >= USB_SPEED_SUPER)
> >   1990                  maxp *= ss_isoc_get_packet_num(udev, pipe);
> >   1991          else
> >   1992                  maxp *= usb_endpoint_maxp_mult(desc);
> >   1993  
> >   1994          packets = DIV_ROUND_UP(bytes, maxp);
> >                                        ^^^^^
> > The issue here is on a 32 bit system when bytes is INT_MAX.
> 
> All of these examples seem to be cases that should be mitigated. The
> earlier check should be expanded:
> 
> 		if (bytes < 0 || bytes >= INT_MAX || !desc)

This doesn't work on 32bit systems.

> 
> > 
> >   1995  
> >   1996          urb = usb_alloc_urb(packets, GFP_KERNEL);
> >   1997          if (!urb)
> >   1998                  return urb;
> > 
> > 
> > drivers/char/ppdev.c:344 pp_set_timeout() warn: potential integer overflow from user 'tv_sec * 100'
> >    343  static int pp_set_timeout(struct pardevice *pdev, long tv_sec, int tv_usec)
> >    344  {
> >    345          long to_jiffies;
> >    346  
> >    347          if ((tv_sec < 0) || (tv_usec < 0))
> >    348                  return -EINVAL;
> >    349  
> >    350          to_jiffies = usecs_to_jiffies(tv_usec);
> >                                               ^^^^^^^
> > 
> >    351          to_jiffies += tv_sec * HZ;
> >                               ^^^^^^^^^^^
> > Both of these can overflow
> > 
> >    352          if (to_jiffies <= 0)
> >                     ^^^^^^^^^^^^^^^
> > But they're checked here.
> > 
> >    353                  return -EINVAL;
> >    354  
> >    355          pdev->timeout = to_jiffies;
> >    356          return 0;
> >    357  }
> 
> This doesn't look like a wrapping-desired case either, but just for fun,
> let's assume we want it.

The original programmer assumed it would wrap so it was intentional/desired.

> (And why are any of these signed?) Annotation
> is added to the variables:
> 
> static int pp_set_timeout(struct pardevice *pdev, long __wraps tv_sec, int __wraps tv_usec)
> {
> 	long __wraps to_jiffies;

Sure.

> > drivers/i2c/i2c-dev.c:485 i2cdev_ioctl() warn: potential integer overflow from user (local copy) 'arg * 10'
> >    478          case I2C_TIMEOUT:
> >    479                  if (arg > INT_MAX)
> >    480                          return -EINVAL;
> >    481  
> >    482                  /* For historical reasons, user-space sets the timeout
> >    483                   * value in units of 10 ms.
> >    484                   */
> >    485                  client->adapter->timeout = msecs_to_jiffies(arg * 10);
> >                                                                     ^^^^^^^^^
> > This can overflow and then the msecs_to_jiffies() conversion also has
> > an integer overflow in it.
> 
> If we want these wrapping:
> 
> 		unsigned long __wraps timeout = arg * 10;
> 		client->adapter->timeout = msecs_to_jiffies(timeout);
> 
> and:
> 
> static inline unsigned long _msecs_to_jiffies(const unsigned int __wraps m)
> 
> 

Here we don't care about wrapping, but I wouldn't go so far as to say it
was intentional...  I guess this silences the warning.


> > drivers/hwmon/nct6775-core.c:2265 store_temp_offset() warn: potential integer overflow from user '__x + (__d / 2)'
> >   2251  static ssize_t
> >   2252  store_temp_offset(struct device *dev, struct device_attribute *attr,
> >   2253                    const char *buf, size_t count)
> >   2254  {
> >   2255          struct nct6775_data *data = dev_get_drvdata(dev);
> >   2256          struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
> >   2257          int nr = sattr->index;
> >   2258          long val;
> >   2259          int err;
> >   2260  
> >   2261          err = kstrtol(buf, 10, &val);
> >   2262          if (err < 0)
> >   2263                  return err;
> >   2264  
> >   2265          val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), -128, 127);
> >                                                   ^^^^^^^^^^
> > Overflow and then clamp.
> 
> Looks like DIV_ROUND_CLOSEST() needs to be made sane and use more modern
> helpers (it appears to be doing open-coded is_signed(), wants
> check_*_overflow(), etc).
> 

Sounds good.

regards,
dan carpenter

