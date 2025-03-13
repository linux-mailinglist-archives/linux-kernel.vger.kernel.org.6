Return-Path: <linux-kernel+bounces-560428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B06A60403
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E7C175130
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A8F1F7095;
	Thu, 13 Mar 2025 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikLIFDkK"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C514D1F0997
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741903921; cv=none; b=foqcYWNeqLu5ixSTLU71P5fSmEqkNr6TkIIO3c56IfReNIgLGRiDSEJVdplFPh8HL5IkEi8yh0TZVdmW9JhLuUYOKRJjzL2f72QxFNzr4ZqP1Vgmlzm7iWPXjahQ/MvGKeEY66slDlrR/KBZiEp+ZZrerGeZI5PmK3vuKnDWX7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741903921; c=relaxed/simple;
	bh=5ouK/wPpkpHGm7CY3mtk7EBZWuz/GzSjK7UEue88WFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5DkvBHHVxQwkr97GlBzSpnHakqYegsOtO7VvgkDXyEs80A8CuayJ2GIsMhvwJIuR9/txNw/3FspAlJ5wdRG3GZcrxfgvtZUQYsqVB9QD2Kil31InI7kvyTOquBlafA5UH1b7vNk0HNkGKl065mblgZW7VGDz5FyH/vEwQf5zoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikLIFDkK; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5499c8fa0f3so1655469e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741903918; x=1742508718; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rz4hBGc0fflF2dR7jCTPC0LTn3X5zKKkGsItFnGOLBc=;
        b=ikLIFDkKlafP74OgdYQSWxFeK2JpYG6vT+As9xwCFg/sgPuNkCB9A86ZcTKizmN+ih
         vYoEsF9Cy7De13670NNZrhGqrxizxP1ld/kaOScIDpUQzSvBKOWKf5OostbDuSSjsSbN
         gy/wm+26gOhyLTkfjXd01GQRD0L/bOLbWA9/PmauyqOkZALeNXoUF49KMM0hJPnPkMbp
         vNG0pg5w9BVp6J56FpJQKGp/dYc4S9ut0FAmu4aemdtM4pkVECzhUkV7e2mW4hkFzLNb
         97UtXtNNF4BgktFUbUh79lx3DVhxtAIqhlTfzs/qyxlXEvi3n/67Sm12kiFaOWoj5xLy
         AF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741903918; x=1742508718;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rz4hBGc0fflF2dR7jCTPC0LTn3X5zKKkGsItFnGOLBc=;
        b=tdda9DsXD82n5kIcY8OOUDoAnmeBj3dG7fC2E8GCHaeYHnpZ8fBxfhABI1FVid40R/
         1LUH26obZrVCcj+FOk19otoZ3DIR1wDmhruwqIMfdVtm0rezJrmjLQbIlqZznW5EAQ8O
         FSio5hDDj2xUMckgimThh5nFP9dm/XDImPs3/bj2Z0dd/lr0rLpLj2qV1KKlYQ45fzG9
         Hd6NnhIhF2kz1N+r3xqd1/jCs7PG7oyxpkm2Q4p4tENill1EQTxgRo5m70oljRKG3R2X
         7Z/FGhiRcGG41QyXLJ6YmddsIC+X4H6XA9r4ne1uqRFfgWRKg7NvRoaKwHFLybNhRM/X
         SE+g==
X-Gm-Message-State: AOJu0YzAuPIpzC13KWpVDDuT55hcbZy6DLR6WuZioofrrwQ1pQdzMHbO
	UV+4jleZOjic6TDj+k3RbOXrZlHQ7sc4IaPssCeuJENBrUwoY5Oy
X-Gm-Gg: ASbGncvkdSsacNFyk+xyeUY6+QcJKs9GACf5JAdWJ1aH/YJ5RktvpzWOcH6twBh9JQy
	laBvlK+rzwoZ6Bsfasno4YsD7tHTf4tRidx214pr81cTqPTUKSFsIdjXbayZtxnCDvVLaY5bqtH
	E6iHsN4eZFJUoKnTZ0cHsfg3/6ogk/hJWnDXAhpU3Pk1Yr+FsM+yam87c4QFJ+lOtGZVfc/9t5O
	vYoDEjSzUDGW18nfyoEKcvqXMeGS6DMZIs5M+Oazs2fovzOrgszKQEQjsPY0TK3d8IZ2Ek7fme2
	fGTBGh5LRVCnGUtHpjQSroWt01BsdlTq8hiwTXtrVU3+/AM=
X-Google-Smtp-Source: AGHT+IEma/geaH0MCYJ+lCgPA/1bY5HI+bW7n6/klBTgfg5rNIWHbu7tMeJOaCwUBitPBy/pZ8pdVQ==
X-Received: by 2002:a05:6512:6cc:b0:549:7145:5d25 with SMTP id 2adb3069b0e04-549c396e1f1mr40642e87.34.1741903917289;
        Thu, 13 Mar 2025 15:11:57 -0700 (PDT)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a7a98sm329070e87.224.2025.03.13.15.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 15:11:56 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 2FDA65A0044; Fri, 14 Mar 2025 01:11:56 +0300 (MSK)
Date: Fri, 14 Mar 2025 01:11:56 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Jean Delvare <jdelvare@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: dmi: Respect buffer size in get_modalias
Message-ID: <Z9NYLCdVfp2Nzet9@grain>
References: <Z7eWSCCqp_HP3iSh@grain>
 <20250313194145.284d7815@endymion>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313194145.284d7815@endymion>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Thu, Mar 13, 2025 at 07:41:45PM +0100, Jean Delvare wrote:
> Hi Cyrill,
> 
> On Thu, 20 Feb 2025 23:53:28 +0300, Cyrill Gorcunov wrote:
> > When we collect data from DMI data the result is accumulated either
> > in a page buffer from sysfs entry or from uevent environment buffer.
> > Both are big enough (4K and 2K) and it is hard to imagine that we
> > overflow 4K page with the data, still the situation is different for
> > uevent buffer where buffer may be already filled with data and we
> > possibly may overflow it.
> 
> Would it not be a concern if that ever happened?

Sure it would. Still at the moment a "page" for sysfs buffer is rather
hardcoded and a huge amount of other code relies on this size, some brave
soul need to spend vast slab of time to review each sysfs writer. Actually
I would not touch this code if get_modalias been used by sysfs only.

> > Thus lets respect buffer size given by a caller and never write
> > data unconditionally.
> 
> On the principle I agree. On the implementation, not quite so.
... 
> > --- linux-tip.git.orig/drivers/firmware/dmi-id.c
> > +++ linux-tip.git/drivers/firmware/dmi-id.c
> > @@ -103,8 +103,12 @@ static ssize_t get_modalias(char *buffer
> >  	char *p;
> >  	const struct mafield *f;
> >  
> > -	strcpy(buffer, "dmi");
> > -	p = buffer + 3; left = buffer_size - 4;
> > +	l = strscpy(buffer, "dmi", buffer_size);
> > +	if (l < 0)
> > +		return 0;
> 
> If function get_modalias() now has a return convention, it should be
> documented. But I see a problem which is that the return convention
> isn't clear. It *may* now return 0 on buffer overrun, but not
> necessarily. The rest of the function is best-effort mode and will
> silently drop a part of the modalias string if it doesn't fit. This is
> not consistent.
> 
> This is not caused by your patch, but this could actually cause false
> positive matches, so it may be a good idea to fix it while you're here.
> And in my opinion the best thing to do is to return an error rather
> than an half-baked modalias string. If the string doesn't fit as a
> whole, it's going to cause trouble at some point anyway, so we better
> learn about it early and do something about it. And that would be
> consistent.

The problem is... userspace. I'm not sure what is better -- return
an error and empty data or trimmed strings. If you prefer error instead
of course I can make it so.

> 
> I'm also curious why you chose to return 0 on error, rather than the
> more conventional -1 or -ENOMEM?

To match snprintf api when zero size is passed ('cause for udev we will
pass 0 if buffer is already exhausted).

> 
> > +	p = buffer + l; left = buffer_size - l - 1;
> 
> Please split on separate lines for readability. I would also appreciate
> a comment explaining that the "- 1" is to leave room for the trailing
> ":" (if I understand that right).

Exactly, I was scratching my head first too figuring out why additional
char is needed here.

> 
> > +	if (left < 0)
> > +		return 0;
> >  
> >  	for (f = fields; f->prefix && left > 0; f++) {
> >  		const char *c;
> > @@ -135,7 +139,7 @@ static ssize_t sys_dmi_modalias_show(str
> >  				     struct device_attribute *attr, char *page)
> > {
> >  	ssize_t r;
> > -	r = get_modalias(page, PAGE_SIZE-1);
> > +	r = get_modalias(page, PAGE_SIZE-2);
> 
> Why? As I read the code, get_modalias() returns the length of the
> string, excluding the trailing '\0'. So it will be, at most, one less
> than the buffer size we passed. So if we pass PAGE_SIZE-1, r is at most
> PAGE_SIZE-2, which leaves exactly the 2 bytes we need for the two lines
> of code below. Am I missing something?

Yeah, I managed to overcounting here, page_size-1 should be enough.

> 
> (The last line of get_modalias would probably be clearer as:
> 	return (p + 1) - buffer;
> or if p was increased beforehand to actually point to the end of the
> string.)
> 
> >  	page[r] = '\n';
> >  	page[r+1] = 0;
> >  	return r+1;
> > @@ -163,7 +167,7 @@ static int dmi_dev_uevent(const struct d
> >  		return -ENOMEM;
> >  	len = get_modalias(&env->buf[env->buflen - 1],
> >  			   sizeof(env->buf) - env->buflen);
> > -	if (len >= (sizeof(env->buf) - env->buflen))
> > +	if (!len || len >= (sizeof(env->buf) - env->buflen))
> >  		return -ENOMEM;
> 
> I do not like the fact that we check whether get_modalias() returns an
> error here, and not in sys_dmi_modalias_show(). This is inconsistent.
> IMHO both functions should check the return value and return an error
> code on failure.
> 
> As a side note, I can't see how the second condition could be true. We
> pass the buffer size to get_modalias() exactly to make sure that it
> won't write past the buffer's end.

I just added !len here, which didn't make code anyhow better, good point!

> 
> >  	env->buflen += len;
> >  	return 0;

So Jean, do you think it worth to rework this patch and add an error in case of overflow?
To be honest I made this patch simply because I miscounted PAGE_SIZE-1 case here (probably
should stop reading code at deep nights :) Since we never ever hit buffer overflow so far
neither in sysfs or udev it obviously not critical. Still if you think it would worth
to address a potential problem I'll rework it and resend addressing your comments.

	Cyrill

