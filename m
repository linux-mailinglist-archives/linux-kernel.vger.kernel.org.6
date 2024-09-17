Return-Path: <linux-kernel+bounces-331900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D546697B2A2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13EB41C208C2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 16:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F7217BEB0;
	Tue, 17 Sep 2024 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8aoETVF"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B778248C;
	Tue, 17 Sep 2024 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726589360; cv=none; b=LcPD8hO/QVaVftcGaSkQwNRSWPqE8m6r2e/ECIXkcnin175cbgruh0l8oq1jtvwjQHBx6aS7ZxJrYkNb5iSq0ykrwX8WgzcpnE59056ztGbE11eAWAaifoN93uu8tDefho7eYoPu7+8ldp5imnd5hXKIA0pv2s2jqGkYjCgWK48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726589360; c=relaxed/simple;
	bh=BELhoByfq/OOJDZzH14bHenPNHWdoqYvOyKGjkRQKi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kd0wGdPf4zpwA9afy981NyaRtKfSc3LtlLn7jCTnxR4u5uaSof2EddUDtcErreX79L4gKnHB1znfErN/AUIg7w3elIeQuWGWiBIkvVKMUoD0QlDzeAlL0pFuCDEs84/f6dokzVHG84yu32vYeeUvdWW7TaV0nus3BE5uiKiPNrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8aoETVF; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d889207d1aso3980925a91.3;
        Tue, 17 Sep 2024 09:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726589359; x=1727194159; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3H06y1U1cap7HmC9Kj3KwaZVLwBBdwCGozszPGEgWks=;
        b=h8aoETVFyCEVqx3TAGdgLu4z3BF7CHCara1NdGPVhJFJ+qHG5NIJ78v5HFtzAD9t6X
         sRzG0jdvbPua90Jws77XQRD0o7l2JnBr+oX7mbezKQkhkPWwsyTLw968N5dRIS3xbqVV
         eUub/i+HYdz6M+TLNzQuZMZWMJBjZ+0E7gLd/gpeVQEVmVDtMNJMWoym9Rq74uq5A4mU
         T4oNxAB1qI03117sE9gcLl0OOFPpUD6BlS7mIi5Kj447B1T2kD61lsQzzJ5BSnroosx3
         iqX6WDK2kX/O5WrinsgZFCGp8kLlcNV1MpHqoUS1TSUmLdezVkDc5xmQAc4nnfsmLjD4
         Bb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726589359; x=1727194159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3H06y1U1cap7HmC9Kj3KwaZVLwBBdwCGozszPGEgWks=;
        b=RS2ZAAQTfAOS7H6J5Q6AGwWno1FL+LvjL5ApdppIsUDAbcqhzkrcbmp9dik1/tp2gY
         HsIsl2SxyCn0I0VEenDzj1GZ3p/7Om8vb/RgN/6LiKkRxX8pVtMiHymYkFfx/qtW7a48
         He9GuBz4CxGi2yEBv7bbtp7F9zCQOCk2h2owVhEUbcBGH4pNibwGcIzzAY77SgYH6Xli
         zO2sw4vDrNhaoAlE9K47uDJl/jwCiUZge51BKh70T9amIjqg+hFtQvBCoDT33mQwJvEH
         VsCzs//quXg0GXMNlT/kdfzZZWX7VMz6g4UPkcX03NdeAqkH78CJiOE/DNSXfmWsk+Xb
         RqDg==
X-Forwarded-Encrypted: i=1; AJvYcCVGwPzG7vabPxmZMBsJy3hvW4qh39D0lO3SQWzEY0GzqE5N+ryBFHt3/Cd0PRVeA3J9NQvxQ5dgJrDm@vger.kernel.org, AJvYcCWtXBxcEgd95WXb+WevwqSQX+g8zJrmeUx+mdGdpTTj1zDYgj9K18hhWVDv3ugeiT2lOucJ0xTVb45NAOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwyvaPKNq5tIOXZuELiaaAorxeJ6l/TR2KKPC2Q/Ym/8cVOE28
	ijwzHBPFfLbmRHidazHd626/zXTq6dWHF15WIcqstOciGyd2Q6PD2OYtFotBYY1Os6c1qWPOFsL
	WmO0O+o3qFh5OvBIgn0vUoCaGbus=
X-Google-Smtp-Source: AGHT+IGqh87nNg8jg1Ud364Rnd5Pc+JSrzq06UGYIArerA2z7jFgxhV2KPrwrAu6kXnE9vCVQ9UbwmqkyyM/IinLJSU=
X-Received: by 2002:a17:90b:1804:b0:2d4:924:8891 with SMTP id
 98e67ed59e1d1-2dba008587emr19169750a91.38.1726589358709; Tue, 17 Sep 2024
 09:09:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d88289f9-e22a-4960-9b3b-ad0b3ab17a89@suse.com>
 <20240917154107.137653-1-aha310510@gmail.com> <64dfb120-3a95-44dd-a50c-c4818baeb833@suse.com>
In-Reply-To: <64dfb120-3a95-44dd-a50c-c4818baeb833@suse.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Wed, 18 Sep 2024 01:09:07 +0900
Message-ID: <CAO9qdTFc9jhOQYbXnES_HkfOPsH8vuZz0nEwzhgQZ3nerW0wKQ@mail.gmail.com>
Subject: Re: [PATCH] usb: use mutex_lock in iowarrior_read()
To: Oliver Neukum <oneukum@suse.com>
Cc: colin.i.king@gmail.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Oliver Neukum <oneukum@suse.com> wrote:
>
> On 17.09.24 17:41, Jeongjun Park wrote:
>
> Hi,
>
> comments in line.
>
> > ---
> >   drivers/usb/misc/iowarrior.c | 46 ++++++++++++++++++++++++++++--------
> >   1 file changed, 36 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
> > index 6d28467ce352..dbf0ed04f7c3 100644
> > --- a/drivers/usb/misc/iowarrior.c
> > +++ b/drivers/usb/misc/iowarrior.c
> > @@ -277,28 +277,45 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
> >       struct iowarrior *dev;
> >       int read_idx;
> >       int offset;
> > +     int retval = 0;
>
> Initialization is useless.
>
> The rest is fine.

If so, I will modify only that part and send it to you as a patch.

Regards,
Jeongjun Park

>
>         Regards
>                 Oliver
>

