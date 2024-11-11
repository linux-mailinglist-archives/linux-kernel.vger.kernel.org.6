Return-Path: <linux-kernel+bounces-404217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352669C40EE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9017281A22
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D853C1A0714;
	Mon, 11 Nov 2024 14:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="J2WhhjJG"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FAB19F113
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335388; cv=none; b=j5m+sLd/vx+wK2fLMl+zIUg0VpYcKkW9bGJk0ml3ZKGBq7SMNs1Wd4UqQgaTSsgte3uzUBSf5TtTVLh8/y1KrtwKRu0Jwayfvzdb4WTJBC+kXnzumOVm06M4Bjo8okwsAddwWmcdj60cXQkoJ/DFqGZcOACXX1hNNUSE3pnd1lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335388; c=relaxed/simple;
	bh=YxiyaRh+dLuumDJ5Q6z6ZrAiO9XXZPih+vaeLaU2iBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Laf7PtBEsUd1h6yl4UfHwEHKgl5FlTuGE+YO1/Kx+Ay2++yULD+xDcYZoEyLVPUAI60+10qAAJDyHhr+S2DJ3sbD6jVbsgRQHMD9jNqH4Y2nYTGWrN0r6iutjXmIyU8/ETA2aZe9UyNrlKNjRyn8xTnl9d9jR/+XQeXsWJB7FG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=J2WhhjJG; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-718119fc061so2339524a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 06:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1731335385; x=1731940185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v0qgwq9cSLKXP1AbvdyN/yc07GmYiB7Sf3eWHN2dzII=;
        b=J2WhhjJGZaT2nCcFKLbZsFLiKLyv2ypcFKxBhUyRdJ9i2M+drl+Ho63G44GqEHMxD+
         3k26ccujf4tE+I/D7OF6GH02sGIUzM6VT8A20FwHISETcG6rmBGDPmEEeZhUeIZW738j
         VnXzNgJJHh14YWdF8I5yyK51AKJQCwAzUqBOqiygcyXp3yWl6NB3RUIGQzz0kyvZ+Eqx
         Ohc7BH9Yj8XeB3+M7+x0q3YVR7JspW6o7ge7z7TXr4k+91A6Oejhj5W70XL3386VrO4N
         uRJIBeVP/MWbHycHX+r5ZaxSbTpAEzQYEM+cZtTYps2ApuI+5u739wteP4OWbSB+QQFt
         HKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731335385; x=1731940185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0qgwq9cSLKXP1AbvdyN/yc07GmYiB7Sf3eWHN2dzII=;
        b=Bv9yQU7nlqLiVDrXHxuK9lKS6JPBP6FgzkAvwiqKTkYjC27aFl18+5V953F91knW0t
         7qid2Q4WyYDT+FYt9NFws4NSRqAha0stESl4wupXA3aLt8f8eDtQGyHz3xdctptXtZZ5
         ceHWshPvGJp09t9ro+i8mc4EsscgWD2rBuesQlmzGcvkE7oEDsKPNP6d4rEMrhUPM6PO
         zgHCCVCRqQ+95EQrmpJq8iLBzEHcb6aTjH61jGF4Y/b7vz7MaY4Xf98dQEgpd6FSBxyc
         4RyyV1zSsXPZJHIZ9On61FIRIjyYBccQ2nh+vJQ03Y6DNR6F+BtSOtWi/SdiUUAip0wl
         DRpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP7cE/I29ZGxByoDtDDNJUpQFVjBI3mBybFV7FLY0VIYxgRA/WoL6FpeczAQbqyYU4gCIMLw+vjb1Mmn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBBZFRmlICArifsIcXDHUEyCrNxhtQHI/MC08YtlbI3Ne0Yfs3
	/58ygUdWlFxIGzPHck6XKgSGL9WL2RVblXyEjixKBx4lZ4eW8GPm2EMzgIXfsA==
X-Google-Smtp-Source: AGHT+IHu5vCBmqhTx33Qo98dUbjiKMG4HQP7r84CBNa0nhpxvoLg4YDsIMNnwb+sAPFPLWENHb2DMQ==
X-Received: by 2002:a05:6359:2101:b0:1c3:9d1e:842 with SMTP id e5c5f4694b2df-1c641f5f4d9mr458084155d.20.1731335385482;
        Mon, 11 Nov 2024 06:29:45 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::9dc2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff5d66d8sm63243721cf.79.2024.11.11.06.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 06:29:44 -0800 (PST)
Date: Mon, 11 Nov 2024 09:29:42 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Oliver Neukum <oneukum@suse.com>
Cc: Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
	syzbot+9760fbbd535cee131f81@syzkaller.appspotmail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] usb/cdc-wdm: fix memory leak of wdm_device
Message-ID: <9447f943-5172-4386-b159-f6b37735fe13@rowland.harvard.edu>
References: <000000000000e875fa0620253803@google.com>
 <20241109152821.3476218-1-snovitoll@gmail.com>
 <825be5e2-31b2-4cd6-a283-05935ea6161f@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <825be5e2-31b2-4cd6-a283-05935ea6161f@suse.com>

On Mon, Nov 11, 2024 at 10:44:43AM +0100, Oliver Neukum wrote:
> On 09.11.24 16:28, Sabyrzhan Tasbolatov wrote:
> 
> Hi,
> 
> > syzbot reported "KMSAN: kernel-infoleak in wdm_read", though there is no
> > reproducer and the only report for this issue. This might be
> > a false-positive, but while the reading the code, it seems,
> > there is the way to leak kernel memory.
> 
> As far as I can tell, the leak is real.
> 
> > Here what I understand so far from the report happening
> > with ubuf in drivers/usb/class/cdc-wdm.c:
> > 
> > 1. kernel buffer "ubuf" is allocated during cdc-wdm device creation in
> >     the "struct wdm_device":
> 
> Yes
> [..]
> 
> > 2. during wdm_create() it calls wdm_in_callback() which MAY fill "ubuf"
> >     for the first time via memmove if conditions are met.
> 
> Yes.
> [..]
> 
> > 3. if conditions are not fulfilled in step 2., then calling read() syscall
> >     which calls wdm_read(), should leak the random kernel memory via
> >     copy_to_user() from "ubuf" buffer which is allocated in kmalloc-256.
> 
> Yes, sort of.
> 
> > -	desc->ubuf = kmalloc(desc->wMaxCommand, GFP_KERNEL);
> > +	desc->ubuf = kzalloc(desc->wMaxCommand, GFP_KERNEL);
> >   	if (!desc->ubuf)
> >   		goto err;
> 
> No. I am sorry, but the fix is wrong. Absolutely wrong.
> 
> Let's look at the code of wdm_read():
> 
>                 cntr = desc->length;
> Here the method determines how much data is in the buffer.
> "length" initially is zero, because the descriptor itself
> is allocated with kzalloc. It is increased in the callback.
> 
>                 spin_unlock_irq(&desc->iuspin);
>         }
> 
>         if (cntr > count)
>                 cntr = count;
> 
> This is _supposed_ to make sure that user space does not get more
> than we have in the buffer.
> 
>         rv = copy_to_user(buffer, desc->ubuf, cntr);
>         if (rv > 0) {
>                 rv = -EFAULT;
>                 goto err;
>         }
> 
>         spin_lock_irq(&desc->iuspin);
> 
>         for (i = 0; i < desc->length - cntr; i++)
>                 desc->ubuf[i] = desc->ubuf[i + cntr];
> 
>         desc->length -= cntr;
> 
> Here we decrease the count of what we have in the buffer.
> 
> Now please look at the check again
> 
> "cntr" is what we have in the buffer.
> "count" is how much user space wants.
> 
> We should limit what we copy to the amount we have in the buffer.
> But that is not what the check does. Instead it makes sure we never
> copy more than user space requested. But we do not check whether
> the buffer has enough data to satisfy the read.

I don't understand your analysis.  As you said, cntr is initially set to 
the amount in the buffer:

	If cntr <= count then cntr isn't changed, so the amount of data 
	copied to the user is the same as what is in the buffer.

	Otherwise, if cntr > count, then cntr is decreased so that the 
	amount copied to the user is no larger than what the user asked 
	for -- but then it's obviously smaller than what's in the buffer.

In neither case does the code copy more data than the buffer contains.

Alan Stern

