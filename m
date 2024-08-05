Return-Path: <linux-kernel+bounces-274910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD43947E24
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1BD1C21EC8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFBC15B10C;
	Mon,  5 Aug 2024 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XpB8Y2sc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC6115A874
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871896; cv=none; b=lznoX+cSAojWpvwMRwWcP6FidMbdzIJd8aIXI1O8qk5HEgmOvkXY7JC+SNwMcAiev8Vvwnx/2e9na8PSBqo4TSBThWJUIJOn++VJBqBFvwLq4g4WLuRHjPdL8GUpHKnvjjLqA2TPTDGi4IQCMByCTmSkHTTSQv7IzuLBvKguhnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871896; c=relaxed/simple;
	bh=LujCxIzyXRjwhPlqP8whLTzqd1Iwo0W1UDi1/ERk5Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XtU8D1itR4OqMrRdI/tw7idixgY1mmYGci8CG4mV8BBlLMKW3SLFvkNjd8nhtyfEDJI+nmBz7xuyIlica5k5TQXvXhEUQmjKlErZlxg4IlGSpQP16kVgNLYsdSemM+SlyBK58I/a0hUltbPDONGaWsZyJw9uzcnDWF781q/KWIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XpB8Y2sc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722871893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g6h3TlWGTE1+WlvLS85nPM+6D3cqZx0X5zf2j2PeJ3w=;
	b=XpB8Y2sc+ZcRQJg/8Lt1v9S7TP9qe0zqUyek6g6hF7Jro2xGsRE5uagcduQyPnGZOWlWPn
	7CP3i0z+J6EBPNAMCOYkLZxUk6XhdwPTJuhfqa8NRc3O/9HXtwLz5Hgm+KebG3Fbx5mF9K
	qf8B4B7PLzqsuA0i/dzscOsrKajw0+A=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-Xk8j2wfjO0mCJgIYY58vzw-1; Mon, 05 Aug 2024 11:31:32 -0400
X-MC-Unique: Xk8j2wfjO0mCJgIYY58vzw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52f0108a53dso14022304e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 08:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722871890; x=1723476690;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6h3TlWGTE1+WlvLS85nPM+6D3cqZx0X5zf2j2PeJ3w=;
        b=DzGP24ydd15rUpPKZDrg9anFFdfXoVPN8zbvMgO3mdYuIx5fIOnd6s1fJY9oFY87jV
         bQeglNg6V4Mxjih4zqC5V38QBUzL4lijIEb2kwQRYGcG3sdgeMzD0KKzLu/nobijU6yc
         S5uzogkUDAOaaRj0Fwg0DHu1nRLxur8KmNBtO4Yap6L7jsxLWkqkENqsicQofuQxciMi
         p+HJQ1nUEesK3FCHJ/RdllNMoi9RfTQI4C/VfTNNivLuzM8gqEsUl+2R51vwqPG2kX0e
         Po/X0dA/2uUH64GhOoqBMxzs9tJKI+G6qzgvK+CtVL7Wszv2UmYtotuMKpZEjSo5q9wA
         5+VA==
X-Forwarded-Encrypted: i=1; AJvYcCVDyr6ZUT9TCt2CEWPD7V4PjZThrXnsxB58wmbsuCXOhTBQrKEahlD/Q0wNrPNN57eDtj4TBJ3C0SpgNmQjbbvFVBwows8/gf93bsAd
X-Gm-Message-State: AOJu0YwZWX86RJR5gpHqGXzzmtMuzxLsDwAnFeunH2ap16boL3nfvnm/
	ZN+eHm4uhVAVtTsMoDmTunvl884lNv/BYax4n69DT6tOuweO+d3iULCYF2pjtrJ7Mqqi7P5F75c
	5zzGK+T4hCCXBAkOKnBbZScp/RNQQgNQmS14OOFGC1gzELRhrh4IlEktiVyB8qg==
X-Received: by 2002:a05:6512:6c2:b0:52c:e1cd:39be with SMTP id 2adb3069b0e04-530bb366423mr8255146e87.8.1722871890549;
        Mon, 05 Aug 2024 08:31:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxZ6chdviq5hamliBqyoWz+o5DUn/+8ZWwmK9zqpFBDa2VFpbqPj1SixEfhXHWy5MD7/IH3Q==
X-Received: by 2002:a05:6512:6c2:b0:52c:e1cd:39be with SMTP id 2adb3069b0e04-530bb366423mr8255104e87.8.1722871889911;
        Mon, 05 Aug 2024 08:31:29 -0700 (PDT)
Received: from [192.168.211.203] ([109.38.139.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83bf3b99dsm5009113a12.91.2024.08.05.08.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 08:31:29 -0700 (PDT)
Message-ID: <3dba67bc-fb22-41af-b9b9-3746c94cc1a1@redhat.com>
Date: Mon, 5 Aug 2024 17:31:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] platform/x86: Add wmi driver for Casper Excalibur
 laptops
To: =?UTF-8?Q?Mustafa_Ek=C5=9Fi?= <mustafa.eskieksi@gmail.com>,
 ilpo.jarvinen@linux.intel.com
Cc: jdelvare@suse.com, linux@roeck-us.net, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
 pavel@ucw.cz, lee@kernel.org, linux-leds@vger.kernel.org,
 rishitbansal0@gmail.com, bahaku@elrant.team,
 carlosmiguelferreira.2003@gmail.com, alviro.iskandar@gnuweeb.org,
 ammarfaizi2@gnuweeb.org, bedirhan_kurt22@erdogan.edu.tr
References: <20240713163521.21958-1-mustafa.eskieksi@gmail.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240713163521.21958-1-mustafa.eskieksi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 7/13/24 6:35 PM, Mustafa Ekşi wrote:
> Hi, I apologize for the delay. I recently saw Carlos's patch and your
> reviews, so I improved my driver according to it and made it ready for
> another version.
> 
> I didn't include the documentation for the new zoned keyboard backlight
> naming since Carlos is going to do that. However, I changed the naming of
> corner led because it isn't affected when other zones' brightness changes.
> And one last reason to not name it kbd_zoned_backlight is the fact that it
> isn't on the keyboard, it's on the two corners of the laptop. I'm still not
> sure how to name it, so I named it 'backlight'.
> Here's a photo of the laptop: https://imgur.com/a/JEqMiGL

Thanks for the photo very helpful.

I see these corner LEDs actually illuminate the table, not the laptop
itself, a bit like ambilight on Philips television sets. According
to wikipedia the vendor neutral not trademarked name for this is
bias-lighting:

https://en.wikipedia.org/wiki/Bias_lighting

So lets name it "casper:rgb:biaslight", which I admittedly is a bit
weird, but backlight for LEDs which are not actually a backlight for
displays or keys is confusing, so IMHO biaslight is best.

Regards,

Hans


p.s.

I'm also doing a review of the patch itself, but I likely will not finish
that today.






> 
> Mustafa Ekşi (1):
>   platform/x86: Add wmi driver for Casper Excalibur laptops
> 
>  MAINTAINERS                       |   6 +
>  drivers/platform/x86/Kconfig      |  14 +
>  drivers/platform/x86/Makefile     |   1 +
>  drivers/platform/x86/casper-wmi.c | 656 ++++++++++++++++++++++++++++++
>  4 files changed, 677 insertions(+)
>  create mode 100644 drivers/platform/x86/casper-wmi.c
> 


