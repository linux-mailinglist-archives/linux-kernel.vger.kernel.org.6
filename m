Return-Path: <linux-kernel+bounces-403812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEE19C3B29
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8177CB20CD6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D20C155359;
	Mon, 11 Nov 2024 09:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BA5lv5ac"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D13D224D6
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731318289; cv=none; b=N4FYTXstd8tLMHMVDzPib/G8/XYkpxVz4+G5G4vLDB/dXMTm07iBomh67kbHNPzaD32XzJV0M1QefN5rrVRaH1c0q61ltkSMym26NiXeslwBh78GtkOMFHp3oZGBcITeGod/IiFvNgb5zxmjjOj0ubG0Ev3fVgeR9rMwgnFZg+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731318289; c=relaxed/simple;
	bh=Y8VkXg5N4fjvLMeubnNBYWRYj1+b5e3Ehqe5iTDD1Jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rr2GiUfu0Jvy6Zpvrbiwb9+gSwam60788pIXEVCuIMTHSgA1ACJ9FHdanZKlSggJAY9w/eWAIBgdEGlVNQ/F2IUy1n0B9YW3Z+94MqhiizM7j4DCpaV+PkPCrVfSj4t6LR9+ArCzeo04Yt62nG+/CcRzHZMIHRn+wkl0tCq7MTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BA5lv5ac; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539fb49c64aso6093942e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 01:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731318284; x=1731923084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wYdHFQll/Jvx2aqgW7/Di3dB8XVUvFfsGgA/LhZ5sYk=;
        b=BA5lv5ack7m3e6k+7MGybq0hU6NMLa+nmpHfKNXzDzMTh/eCj7lYCW7yCMq+8WelsY
         a0z8Wugt3UyDy8V3jVmbJDW37BaOGN4DJCl0aLf8IAGr1jdT8cMubQHu93awsG77Fg4r
         ND/hOGTUL3cU2B4eafp7y74vQXO785rMJShAB4hj7i4lSqMn4tRNdYjb3J/a4G8OUVdc
         H1pAHKyysqpTQDXS4GZ+vwc6VACUmg63aBZjAqhDIyNDmXiNsP2wz3vYiZevNQJtUw9D
         rGSPq/ax2CJg2nefQ1jNS1zdYn9rpxiJbIduD743ewTk/n6jtzqZvrkObsr+H2KKByRq
         DQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731318284; x=1731923084;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wYdHFQll/Jvx2aqgW7/Di3dB8XVUvFfsGgA/LhZ5sYk=;
        b=cte9N4RKKdvTg0glCORlLX3GQROFQQrJ3dRtRPWMxfAM+/3Qfx3jh4hZ7N/sY9IOpn
         5wKkJWU05oNHKkMqSlZIfwvQmgkqtBAppsqnvuX7aTvVx4uLsauk07SqOjthHLJRSHUy
         nPEc9fh8tCKlHnSn0uCXWm3nInf4FaeHo+3TT00bjvvl7inbYR+N/JdsqF3h9oIQAdZ0
         NnIGqGzefq8cH5dXI5+ooiTkFNOQAyApYlGPfB+NyeBTR6qksPM2ye3HBO7fZvyjHs94
         2roqCDM1RHo7mBIvzozoCEwmVhf1CKq28kx1nHdGdK0/RXlHH+ObqvSN4qv1jCWHjKHu
         GGXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB32uIm1WkhTf6Lu9kPiAtUsYCiXkd8hH7/lFR9qlUUYCuN4hEv2pXN33z9FL1M+WGGRbofiYZ+l90S9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YykIPTaH1ldfUImPYwwMVE9jrQor/DFO8VC/ih7aOMN7uS6mfJM
	uEFTE1x2F1EfWFqt/IrdguzyMECP2TSLRnNlV7G+LTRacirO2QmfCsSSoZp5D2k=
X-Google-Smtp-Source: AGHT+IHK4vdhia2NXp3GYgdHBXfS5JmphfkYhtaQbxfub0asvj1UBs6mvIxTwhKb1VDqrzP+d2MjPA==
X-Received: by 2002:a05:6512:6d6:b0:536:54ff:51c8 with SMTP id 2adb3069b0e04-53d862c6fa8mr6556182e87.17.1731318284409;
        Mon, 11 Nov 2024 01:44:44 -0800 (PST)
Received: from ?IPV6:2001:a61:1361:b001:5d85:e56f:d14e:8442? ([2001:a61:1361:b001:5d85:e56f:d14e:8442])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc4c97sm570367566b.131.2024.11.11.01.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 01:44:44 -0800 (PST)
Message-ID: <825be5e2-31b2-4cd6-a283-05935ea6161f@suse.com>
Date: Mon, 11 Nov 2024 10:44:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb/cdc-wdm: fix memory leak of wdm_device
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
 syzbot+9760fbbd535cee131f81@syzkaller.appspotmail.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com, oneukum@suse.com
References: <000000000000e875fa0620253803@google.com>
 <20241109152821.3476218-1-snovitoll@gmail.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20241109152821.3476218-1-snovitoll@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.11.24 16:28, Sabyrzhan Tasbolatov wrote:

Hi,

> syzbot reported "KMSAN: kernel-infoleak in wdm_read", though there is no
> reproducer and the only report for this issue. This might be
> a false-positive, but while the reading the code, it seems,
> there is the way to leak kernel memory.

As far as I can tell, the leak is real.

> Here what I understand so far from the report happening
> with ubuf in drivers/usb/class/cdc-wdm.c:
> 
> 1. kernel buffer "ubuf" is allocated during cdc-wdm device creation in
>     the "struct wdm_device":

Yes
[..]

> 2. during wdm_create() it calls wdm_in_callback() which MAY fill "ubuf"
>     for the first time via memmove if conditions are met.

Yes.
[..]

> 3. if conditions are not fulfilled in step 2., then calling read() syscall
>     which calls wdm_read(), should leak the random kernel memory via
>     copy_to_user() from "ubuf" buffer which is allocated in kmalloc-256.

Yes, sort of.

>   
> -	desc->ubuf = kmalloc(desc->wMaxCommand, GFP_KERNEL);
> +	desc->ubuf = kzalloc(desc->wMaxCommand, GFP_KERNEL);
>   	if (!desc->ubuf)
>   		goto err;

No. I am sorry, but the fix is wrong. Absolutely wrong.

Let's look at the code of wdm_read():

                 cntr = desc->length;
Here the method determines how much data is in the buffer.
"length" initially is zero, because the descriptor itself
is allocated with kzalloc. It is increased in the callback.

                 spin_unlock_irq(&desc->iuspin);
         }

         if (cntr > count)
                 cntr = count;

This is _supposed_ to make sure that user space does not get more
than we have in the buffer.

         rv = copy_to_user(buffer, desc->ubuf, cntr);
         if (rv > 0) {
                 rv = -EFAULT;
                 goto err;
         }

         spin_lock_irq(&desc->iuspin);

         for (i = 0; i < desc->length - cntr; i++)
                 desc->ubuf[i] = desc->ubuf[i + cntr];

         desc->length -= cntr;

Here we decrease the count of what we have in the buffer.

Now please look at the check again

"cntr" is what we have in the buffer.
"count" is how much user space wants.

We should limit what we copy to the amount we have in the buffer.
But that is not what the check does. Instead it makes sure we never
copy more than user space requested. But we do not check whether
the buffer has enough data to satisfy the read.

You have discovered the bug. If you want to propose a fix, the honor is yours.
Or do you want me to fix it?

tl;dr: Excellent catch, wrong fix

	Regards
		Oliver


