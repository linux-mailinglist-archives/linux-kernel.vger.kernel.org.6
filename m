Return-Path: <linux-kernel+bounces-422885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8D19D9F4C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 23:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 775A0B250AD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 22:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5203B1DC04C;
	Tue, 26 Nov 2024 22:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="annjVlWD"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FE011185
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732661332; cv=none; b=r5y68yCkrd07C/eYZ3h/homRTkJtzA2nWzUZ9sziGp0LAHQ0P8Chqd+TqK1UAQa8muUB/19j1JGY/QpUpZUSDZ7EF++raWQWMlIQIGybqrfeZqblS7SjdjtloSl6T0J4oD+cJQ3vet86tgLK7pT7/FBcXnpSs6lupfFWdjZVKfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732661332; c=relaxed/simple;
	bh=ue9/q48ijbVccEx45BqkCTqgBqs5YXFOO7SM6td5oqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbbOcNKQ9+5kDtws+92+TuQKxqA2vEai2qAQCd9H08rSFCrQhOhnWdLtc1r4XDartsQbItzNJrvPJHzapMq0W2uF8ygxnjUhsOHETIcU+hezxSlZ45/R2LlRJHwrXl7tLD+evI56Fqe/wMJwguA8MZ33FjPcqEByklP9pCAPiD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=annjVlWD; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9882D20002;
	Tue, 26 Nov 2024 22:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732661320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B2fuJFpQkZX4WZzslAJSPKPwZmnXfglGpxbbC1xma2g=;
	b=annjVlWD820NC18XLR/zqORSa4BucF3Le6YVCk/slxRyvuKjj7krI//DfYirSrF9c9Hb6v
	/zVLrtTKGfDk2sGp11AckelLn5z4F19xzZ+KNDLMQl60AiT8ZH+7uC4K1e033DGcA+7bPf
	Zwxv/7YlGGDPgFzHJZwpg/vAoX0LI2i5t+NVeaFl5njoNKDH1hcCcOtwySRAOyW/1/s59Y
	pt1I8yDcLsQd/6LbCUn6FXiQFfQLPBYSXKYmcfo62hUFXv4s5LZYO+C7S/TjYf/W8EL0wf
	k+oxtt5xCRc1gQB8c3YvfRCCZlSS2cFiUXurujGIQg04d+SWe0n6TevD6CUIjA==
Date: Tue, 26 Nov 2024 23:48:39 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Advait Dhamorikar <advaitdhamorikar@gmail.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH-next] i3c: master: Fix potentially uninit variable
Message-ID: <202411262248395277af39@mail.local>
References: <20241119153941.8307-1-advaitdhamorikar@gmail.com>
 <CAJ7bepJ9vd8s4Yd+HpvGyZG3PE8oK8YPMFxtkPRO-W-t-Pe63Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ7bepJ9vd8s4Yd+HpvGyZG3PE8oK8YPMFxtkPRO-W-t-Pe63Q@mail.gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 27/11/2024 01:26:08+0530, Advait Dhamorikar wrote:
> Hello,
> 
> I would really appreciate it if I could get some feedback on this patch,
> I would like to know if this approach is the right way to proceed.
> 

Yes and no, I don't think -ENODEV is allowed here, see platform_uevent
and i2c_device_uevent.


> Thanks and regards,
> Advait
> 
> On Tue, 19 Nov 2024 at 21:09, Advait Dhamorikar
> <advaitdhamorikar@gmail.com> wrote:
> >
> > devinfo is uninitialized if the condition is not satisfied,
> > add an else condition to prevent unexpected behaviour.
> >
> > The variable will contain an arbitrary value left from earlier
> > computations in `i3c_device_uevent`.
> >
> > Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
> > ---
> >  drivers/i3c/master.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > index 42310c9a00c2..7594d3793eb0 100644
> > --- a/drivers/i3c/master.c
> > +++ b/drivers/i3c/master.c
> > @@ -284,6 +284,8 @@ static int i3c_device_uevent(const struct device *dev, struct kobj_uevent_env *e
> >
> >         if (i3cdev->desc)
> >                 devinfo = i3cdev->desc->info;
> > +       else
> > +               return -ENODEV;
> >         manuf = I3C_PID_MANUF_ID(devinfo.pid);
> >         part = I3C_PID_PART_ID(devinfo.pid);
> >         ext = I3C_PID_EXTRA_INFO(devinfo.pid);
> > --
> > 2.34.1
> >

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

