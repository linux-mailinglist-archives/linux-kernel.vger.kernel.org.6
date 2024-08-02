Return-Path: <linux-kernel+bounces-273049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AA49463FF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 433501F231C9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC604CE05;
	Fri,  2 Aug 2024 19:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S39XICUF"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9CD481DB
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722627627; cv=none; b=C9OZziU2LiRQieqeZky4L2p4nvG1E6QZGbGLfavoAzV2rTztyCjqVBKCwc4vWz62z95AJDWwseWiOY/vmRcSxTeZ+O8vO1Lnt0KouoIhCOnbB5J7Z0nxD78HRlYAj1JoGBxSe2ggtMpCs7cXM5v+XN0/KnHFgloiDr8G9RSWWP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722627627; c=relaxed/simple;
	bh=o5QBx+htHAnPVYfN9/8cdi/62RKO0vexP2m3msXV46Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvAJql6p8SDopBff8eYjqncEWfKb587jSMDWdlO7gjLmg3Z3mwog+jSxmJltSpH0i1ljnBW7GHqIio/aM1AmHnRrfxRt3DkexVZOG8HbU2FKOGlIhjADvqkMjw/On7xymNQSqSqw9ljQa00JBERfvkIGhAXMIKZoQU7J2jrhBzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S39XICUF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc569440e1so75937525ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 12:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722627625; x=1723232425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FbckP//TA1br3pvTKF63vPDOGFIpMDX91CyVXhvL90E=;
        b=S39XICUFgh34miJgV4wuSlFnqOk4hRgdEISK5yXxE4XeFcyHy+GfFSDQPrAp5Omt1P
         5oLryZva8NJNPfDG1S5sYj5uJIKxG27RjH+f7B9wGoPg43nktNajGI5Xx/V4H6EgfLRW
         v/HP388eFvlJkn44LmielzIrAU1KKe8cdIKT3mHzH65t7HJBwBzG2akwPSYEqGzFJ8sx
         siZMQ84KdAbgDPw7pbIB9n7CovskjSPBSkgsIsZabMYirmI8dfKriCEf5Xjvd1AjdkFf
         kxi0FXEpVAK4sy/frX6GL1jNplclw9Z7GxSft312BHgtSezOB97lG5psHPa2OlrQQXck
         MwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722627625; x=1723232425;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbckP//TA1br3pvTKF63vPDOGFIpMDX91CyVXhvL90E=;
        b=jPp6t2tmrvy3WDLg8KTtMq168TUPP+CVEwfxQvBGb/oOEwvmbWrbmDn7tBc8x774tX
         LxnK3bp8utyvm/S37TJyXShbdrB6KOH/NWtduTZme9tBPXtEpgx+21la+zSHCzI+SwxU
         GzGhQ7VLbuiLPLUhbEw0MdF1ru/LJbK7q5qe2ixT/S5D3r+iHlBEA7wAXLPc/Qs1uQ89
         8SP+lS5ozzq3RFmRhAQF2xcpJ0KziHX8aEe1sllejiKj3bXZ7xqUMGT+Kr12x+we5oeo
         Qk6Pcj2YwDi345EMjty//Y+vPeVRp9nFjN/ehWKKGZ4wYFxr4+hUZeB9AbPyL6iBxnRf
         XdoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQk4/w9kv4wa+Y7ioF1UaVJMIatBEDN/R0WKvajJyax7jIO0JB2GHl3Y/Udk8/KnALWhAmfaiZsBLh4RExmltY4DBUpkiySvV6MdzQ
X-Gm-Message-State: AOJu0YwK+YnF1yTPxL0ypFqkB/9rVxNWMkxCgALaiR4C6e2mYlJL3vMK
	3BTKIipNUv8bNi7TuAnlIFW6TRSaIqMCI53DvyxrQljwlOziQ4nb3R77OA==
X-Google-Smtp-Source: AGHT+IFPMKIbwpqZjey+xC2i7JewOSnPUEUztNooYgJNsC28NJ9KTsYTvGMOzVxa5L35sxDkjQMWXQ==
X-Received: by 2002:a17:902:f54b:b0:1fb:5b83:48d9 with SMTP id d9443c01a7336-1ff572ece93mr57141635ad.37.1722627624735;
        Fri, 02 Aug 2024 12:40:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5916f3basm20945965ad.190.2024.08.02.12.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 12:40:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8476196b-3e15-40e9-8481-69e4548899eb@roeck-us.net>
Date: Fri, 2 Aug 2024 12:40:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.11-rc1
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
 <CACRpkda_Y+M6_fapkxcPHNYSpd+0hicziFKcDTEyTqm_Fq+Svw@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CACRpkda_Y+M6_fapkxcPHNYSpd+0hicziFKcDTEyTqm_Fq+Svw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/2/24 10:35, Linus Walleij wrote:
> On Mon, Jul 29, 2024 at 5:29 PM Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> Failed tests:
>>          arm:versatilepb:versatile_defconfig:aeabi:pci:scsi:mem128:net=default:versatile-pb:ext2
>>          arm:versatilepb:versatile_defconfig:aeabi:pci:flash64:mem128:net=default:versatile-pb:ext2
>>          arm:versatilepb:versatile_defconfig:aeabi:pci:mem128:net=default:versatile-pb:initrd
>>          arm:versatileab:versatile_defconfig:mem128:net=default:versatile-ab:initrd
> 
> I traced these fails down to:
> commit 04f08ef291d4b8d76f8d198bf2929ad43b96eecf
> "arm/arm64: dts: arm: Use generic clock and regulator nodenames"
> 
> The following oneliner fixes it:
> 
> diff --git a/arch/arm/boot/dts/arm/versatile-ab.dts
> b/arch/arm/boot/dts/arm/versatile-ab.dts
> index 6fe6b49f5d8e..289c3d093579 100644
> --- a/arch/arm/boot/dts/arm/versatile-ab.dts
> +++ b/arch/arm/boot/dts/arm/versatile-ab.dts
> @@ -157,7 +157,7 @@ timclk: clock-1000000 {
>                          clocks = <&xtal24mhz>;
>                  };
> 
> -               pclk: clock-24000000 {
> +               pclk: pclk@24M {
>                          #clock-cells = <0>;
>                          compatible = "fixed-factor-clock";
>                          clock-div = <1>;
> 
> (versatile-ab is included by versatile-pb hence it regresses)
> 
> The problem is: I don't know why.
> 
> Rob: any ideas? (Perhaps some uglyhack of mine, I don't know.)
> 

Rob already sent a patch fixing the problem.

https://lore.kernel.org/r/20240730210030.2150467-2-robh@kernel.org

Guenter


