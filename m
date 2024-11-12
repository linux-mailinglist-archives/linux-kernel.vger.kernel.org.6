Return-Path: <linux-kernel+bounces-406707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DB89C6397
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8277BB8182B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A273F219CAB;
	Tue, 12 Nov 2024 20:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="qBC7WSoW"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30352219CA4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 20:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731443159; cv=none; b=cmdp7Y6Lf+SV0LevE3CfbBQBknhEk32kz7IsdMUPzV1hF8a3Qqab16iwDq29+WFwjp7naz8GGm1AGXSyQmiiXWWS9bZBHNDAjeiE8/5qiuDf5Op8oLLQxjL2Ih0HvYr1VisPW92jdZk8szH9mGpwDL9nAk/1XyY1S0A7krYfnUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731443159; c=relaxed/simple;
	bh=MdTfH+E7fr989/AY5JdLMHr+uSfW5aVjwietaX7i8EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+wAdvwrUqaDnTbLREIeNzYDQlcE7+xnTO2Bg+kmko9z5K57JYFFc8L8NQfpXcSP6oQBEZNBx/H/VTpXCglSxr/pEMapk4NCb15EBg8pMR/3MX5UwYmS1YisjXKxOTzTWwibSA5rRtHlsXQ55Ca+I36hrEBijFym8wZUaPxf770=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=qBC7WSoW; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b18da94ba9so3278885a.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 12:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1731443156; x=1732047956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T4Y8BC5cx/asz6XOBwxn/nus2x9aqEp8mBzAEquRJAk=;
        b=qBC7WSoWHTVCN4B7KQMvlvFLV36a5ADKu/2jUIPQqTUZO/awjyOL3+9/X92f+iresV
         g2OGvP9eO2voL6Y5d9mcVrW4SIArMfqHxKrzgJpvztIOfkSEOBq+HDyjOCa2FnT0srC8
         6UMLmdn3fzePoycH3j2zrnEpDkznhaz4EIQFXCBltWHZFmFCDBYdsFounb34+q3L6ZGU
         8Yb3IaeXmjqA30JFQ/W/SscGlmQ7cRnb6Jn3S+W0qBl3zWOuDkXewsVBgWPKexA6BZQq
         5ua4DKWl5rKjzbxzSyuDVuIZq+j0yziswF6XYSVNBT5dGKx0G0OcVFziTATr2D+97YZu
         Lm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731443156; x=1732047956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4Y8BC5cx/asz6XOBwxn/nus2x9aqEp8mBzAEquRJAk=;
        b=WSgKuLUXz9Ujq4+0LlD6uajrv9HFk80138iCug+d2Nn4T1MHdmeH6P3E1S6K9/nlDW
         Xvye8cr3eJ9L2SYZ8kZWgRa19BUMWUW8N7aPqYBalUkkC3jpbQHpu0gQd1RBq/8et9jY
         0bFjzEeuVDYf+yh/oOEyVnYOasmshUS08trNcGXBpQvM3mLqAZHIdlQqTwB46hmJ/01T
         KjaRYNI54suTDHk5DxTKioFfqyHTZ3vJgdcTmHTlZ43bnZ+wZqMV4zzl3lWaKy/9xMyI
         kYGmqreAXhmkAeGNmWrXTwwwB6ng+Ym/G3yjIqxo/h9f2tQy1o8ArZFXYNm1wwBZTX7R
         1s/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvBfABGzFHHozq2/kj6wd9wdrP6pI7DCzaz6f1NwJt5mCEkXLcCleAPbOZVfSWDzOnk4TAwPLF8UmrwVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK5fCWPqGso4JoBtnsWw9iHINUdz+BzHLC0+jKIP1WzPv3/tWl
	WZLKt9Ecbm76DZxhmp9sG5/RP/IixeDZj70FmBLZ25jUuPRRorzFJpzGGzo6HA==
X-Google-Smtp-Source: AGHT+IEFVux3HN6tJzgVu7E2X1lRQvRziWl9XkNXgBuYbREjGETu2ERXVJqnkgV7yVGCEPshcAVYSQ==
X-Received: by 2002:a05:620a:29d0:b0:7b1:4a2a:9ae0 with SMTP id af79cd13be357-7b3318d0163mr2813162085a.9.1731443156081;
        Tue, 12 Nov 2024 12:25:56 -0800 (PST)
Received: from rowland.harvard.edu ([140.247.12.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961df9f1sm76132086d6.23.2024.11.12.12.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 12:25:55 -0800 (PST)
Date: Tue, 12 Nov 2024 15:25:53 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: oneukum@suse.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	syzbot+9760fbbd535cee131f81@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v4] usb/cdc-wdm: fix memory info leak in wdm_read
Message-ID: <4ea9e56b-0941-4ea4-8cf3-b62facdbff53@rowland.harvard.edu>
References: <2024111232-relative-bottom-4995@gregkh>
 <20241112132931.3504749-1-snovitoll@gmail.com>
 <824e839d-ee72-4923-bc88-e9cc58201b07@rowland.harvard.edu>
 <CACzwLxgVJ2jROr8RWHXv++2m2tD9fvskp_MqTL7VhCPr-Eeeiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACzwLxgVJ2jROr8RWHXv++2m2tD9fvskp_MqTL7VhCPr-Eeeiw@mail.gmail.com>

On Wed, Nov 13, 2024 at 12:30:08AM +0500, Sabyrzhan Tasbolatov wrote:
> I've re-read your and Oliver's comments and come up with this diff,
> which is the same as v4 except it is within a spinlock.
> 
> diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
> index 86ee39db013f..47b299e03e11 100644
> --- a/drivers/usb/class/cdc-wdm.c
> +++ b/drivers/usb/class/cdc-wdm.c
> @@ -598,8 +598,11 @@ static ssize_t wdm_read
>                 spin_unlock_irq(&desc->iuspin);
>         }
> 
> -       if (cntr > count)
> -               cntr = count;
> +       spin_lock_irq(&desc->iuspin);
> +       /* Ensure cntr does not exceed available data in ubuf. */
> +       cntr = min_t(size_t, count, desc->length);
> +       spin_unlock_irq(&desc->iuspin);
> +
>         rv = copy_to_user(buffer, desc->ubuf, cntr);
>         if (rv > 0) {
>                 rv = -EFAULT;

You seem to be stuck in a rut, doing the same thing over and over again 
and not realizing that it accomplishes nothing.  The spinlock here 
doesn't help; it merely allows you to avoid calling READ_ONCE.

> > Since the new code does the same thing as the old code, it cannot
> > possibly fix any bugs.
> 
> Without the reproducer I can not confirm that this fixes the hypothetical bug,
> however here is my understand how the diff above can fix the memory info leak:
> 
> static ssize_t wdm_read() {
>         cntr = READ_ONCE(desc->length);
>         if (cntr == 0) {
>                 spin_lock_irq(&desc->iuspin);
> 
>                 /* can remain 0 if not increased in wdm_in_callback() */
>                 cntr = desc->length;
> 
>                 spin_unlock_irq(&desc->iuspin);
>         }
> 
>         spin_lock_irq(&desc->iuspin);
>         /* take the minimum of whatever user requests `count` and
> desc->length = 0 */
>         cntr = min_t(size_t, count, desc->length);
>         spin_lock_irq(&desc->iuspin);
> 
>         /* cntr is 0, nothing to copy to the user space. */
>         rv = copy_to_user(buffer, desc->ubuf, cntr);

This does not explain anything.  How do you think your change will avoid 
the memory info leak?  That is, what differences between the old code 
and the new code will cause the leak to happen with the old code and not 
to happen with your new code?

Note that if cntr is 0 then nothing is copied to user space so there is 
no info leak.

> > (Actually there is one other thing to watch out for: the difference
> > between signed and unsigned values.  Here cntr and desc->length are
> > signed whereas count is unsigned.  In theory that could cause problems
> > -- it might even be related to the cause of the original bug report.
> > Can you prove that desc->length will never be negative?)
> 
> desc->length can not be negative if I understand the following correctly:
> 
> static void wdm_in_callback(struct urb *urb)
> {
>         ...
>         int length = urb->actual_length;
>        ...
>        if (length + desc->length > desc->wMaxCommand) {
>               /* The buffer would overflow */
>              ...
>        } else {
>               /* we may already be in overflow */
>               if (!test_bit(WDM_OVERFLOW, &desc->flags)) {
>                      ...
>                      desc->length += length;
>                      desc->reslength = length;
>        }
> }
> 
> urb->actual_length is u32, actually, need to change `int length` to
> `u32 length` though.

You don't really need to change it.  urb->actual_length can never be 
larger than urb->length.

Alan Stern

