Return-Path: <linux-kernel+bounces-268810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 556C494299D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A101C2133B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E252D1A8BF6;
	Wed, 31 Jul 2024 08:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y+vl7syy"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3199818CBED
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722415902; cv=none; b=d+V/vZ//uE0Of715pCL5gUZMbjDvecQcthBSovNz2Gmj/8Ra9tUqGfmMb64Igo8wmg6aKfTF8lW2aIzZ5lp2Acp8+vYeKXM8PCOrf1xDTYKoHHywV8aoksn6GT2Anb0vi0NrJ2lhECeAkSel89t+UvVKzPb8HhsJq+9g6p7Atw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722415902; c=relaxed/simple;
	bh=ujry+Wx00x3dTrMyK6IRtY4fGmGxqqwad1ww0cUdjJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jy7vCJeY5KghA+/V7XfQmX+qw/EvkN6fpObsC1z3he0MUYIpg/S8KzTMEeIBMf2nucTNWwoNzzMwWSm776G0YfdT73He11sV9FaCHwRzZ4/WNbotGYZzVvP0rdaxL+DDsRq+4k0cz75q8MY3JsXZ3RM2r6Xk338L474kD0S1Z4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y+vl7syy; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso657285466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 01:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722415898; x=1723020698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wNoo9e14DIpmapZul3KnyFsnnEqyQO+m3ZF4ksesUrk=;
        b=Y+vl7syy/OQKpScVqPZ3MOm3w64ig5+YjNqsN3bLyob9cUEz9zaa8ZJBecHG04EPTr
         ocEvcHV4p3zANac8r3rC50l4Dwb3b9qPmEoVyA4Kp5qFM2FPo9kYiWaHFjRjFrSVJ1VH
         Mx/bEJ8zAZUvY5Yk6TzPip0//jjKscycU1r8XMGro58/5FaRT1xVeVFt0+dj9EuWsL+5
         aUkyDI+kcrJQ7rY6b3ODXUW9pzcrv/aZeFSGn9sip0xMCnAcPH0Pe2MDlGL+zQ5DbYUx
         nU6R939273taUtL5fRzmHIiz/VTTAWqC716palp6XtNOQisjNLuCi0eH/KCjo/yJD/Hz
         fvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722415898; x=1723020698;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNoo9e14DIpmapZul3KnyFsnnEqyQO+m3ZF4ksesUrk=;
        b=jnfdDiwzYaxazL7721KObAq3WbuDSsn+gsje5TMyqX59T4T8sia4AJXustdefu70xi
         o40gtTDh8hlQK+1bs/wKIHVovOfghP2lebHJaBSDfSTCRGzCg3dzH/nAmTdATSCNaOGv
         0ME8uIkyg6SjVlRtM6sOmZB3t5t7cEMX+YaXxMPGhoBJ9yTgzdgpaI2YAsIwADzhc5Iy
         zL4g1k6oYtTG9Q/vssFJKk6vFWdbdkOPiG2CSO0cx/vbJvWZfILFtYe5SmoRKNuxFMS+
         EzPOijyb4SQ7ZPqJm7pdAu0nbi6StuBU5BfegrHnSy9Qq17fQJbehJRE1yaC0p7drQ9f
         tm+g==
X-Forwarded-Encrypted: i=1; AJvYcCV5WvydlHbJqytars3RgETbjV6yZdDdJUu/1ypC9WPjU+/MYkKWOlEz2572xrweBYo6lrfxdV/JujSVpV9ngR4dSk75tTAGPFCyax/E
X-Gm-Message-State: AOJu0YwkXBHVWJl7Wouzf4/wdiilPV6FAtVLn90HeyTpdIpZWhGklmLk
	N0slvLqGhOghx3NPdZAGPLlCRpJ+70WLavcZHjHIUyKZN30jUtnT0VPYjXpmYoo=
X-Google-Smtp-Source: AGHT+IG945t6LY25eGW9SyhtTpAlfIEfUmxmvjqe2lF9c9d0dCEse5FNHlIKVzI0omov5yjI2nDqMg==
X-Received: by 2002:a17:907:3eaa:b0:a7a:a7b8:adb1 with SMTP id a640c23a62f3a-a7d40073465mr920952166b.36.1722415898317;
        Wed, 31 Jul 2024 01:51:38 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.215])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad4acbfsm735831166b.100.2024.07.31.01.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 01:51:37 -0700 (PDT)
Message-ID: <0685ef1b-b0e1-4c53-94dc-4d5de5be8e94@linaro.org>
Date: Wed, 31 Jul 2024 09:51:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: micron-st: Add n25q064a WP support
To: Brian Norris <computersforpeace@gmail.com>
Cc: Michael Walle <mwalle@kernel.org>, linux-mtd@lists.infradead.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Pratyush Yadav <pratyush@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
References: <20240726185825.142733-1-computersforpeace@gmail.com>
 <D32OADQF733D.3CVS3ZRPEBL2O@kernel.org>
 <454deacb-88cc-4ab0-80b4-006d863a56d2@linaro.org>
 <CAN8TOE8-9=P7p8Tkc+5kG5Sqan+RAWAc7k2VH-p5W9hR-bb_Xg@mail.gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAN8TOE8-9=P7p8Tkc+5kG5Sqan+RAWAc7k2VH-p5W9hR-bb_Xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/30/24 6:28 PM, Brian Norris wrote:
> Hi Tudor, Michael,

Hi, Brian!
> 
> On Tue, Jul 30, 2024 at 4:33 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>> On 7/30/24 7:51 AM, Michael Walle wrote:
>>> On Fri Jul 26, 2024 at 8:58 PM CEST, Brian Norris wrote:
>>>> These flash chips are used on Google / TP-Link / ASUS OnHub devices, and
>>>> OnHub devices are write-protected by default (same as any other
>>>> ChromeOS/Chromebook system). I've referred to datasheets, and tested on
>>>> OnHub devices.
>>>
>>> Out of curiosity, there is also a hardware write protect switch
>>> somehow, right? At least that's my understanding how verify boot
>>> works.
> 
> There's a whole doc on this:
> https://www.chromium.org/chromium-os/developer-library/reference/security/write-protection/
> 
> Short answer: yes.
> 
> If you want to see how this fits together in practice on a
> non-ChromiumOS system, you can see my companion OpenWrt work here:
> https://github.com/openwrt/openwrt/pull/16014
> 
> Basically, I just try to make it easier for tools (in this case, the
> CrOS vboot tools) to find the write-protect GPIO, and cross-reference
> that with the software (MTD "locked" ioctls) protection status. We
> need to understand and manipulate both if we want to (temporarily)
> remove write protection, while otherwise retaining verified boot
> integrity.
> 
>>>> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
>>>
>>> This looks good:
>>> Reviewed-by: Michael Walle <mwalle@kernel.org>
>>>
>>> But could you have a look whether this flash supports SFDP.
>>> According to the datasheet it looks like it does. In that case,
>>> could you please dump it according to:
>>> https://docs.kernel.org/driver-api/mtd/spi-nor.html
> 
> Sorry, I didn't notice this doc. It's not technically a "new" flash,
> so it doesn't necessarily apply, but for the mail-archive record:
> 
> # xxd -p /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
> 53464450000100ff00000109300000ffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffe520f1ffffffff0329eb276b
> 083b27bbffffffffffff27bbffff29eb0c2010d800000000
> 

Thanks! We keep a database of SFDP dumps and when we touch a flash, we
compare the SFDP dumps of the flavors of that flash ID to make informed
decisions. There are lots of flashes that have wrong SFDP data, so we
introduced some SFDP fixups, where we tweak the incorrect parameters.
Also, we encountered cases where flashes with same ID have different
SFDP data and we ended up differentiating the two based on a SFDP
difference. So we should know the SFDP even for flash updates, it help
us having a more relevant database.

With time we'll add a SFDP decoder, but we couldn't allocate time for
that yet.

A shasum on the SFDP dump would be good to have some sort of integrity
assurance, e.g.:
sha256sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp

>> This would help getting rid of the no_sfdp_flags and size from the flash
>> definition. Another reason is that the SFDP dump can help us
>> differentiate between flavors of the same flash, if it'll ever be the
>> case, and help us keep backward compatibility.
> 
> I wonder, since manufacturers seem to reuse IDs sometimes, is it
> possible (or, likely) for SFDP and non-SFDP versions of the same flash
> to exist? I'm not really sure whether I can truly drop the non-SFDP
> definitions.

It's possible, yes. We lean towards using only SFDP if possible. The
mechanism to determine the correct flash parameters when we have a flash
ID with 2 flavors, one with SFDP and one without, is in discussion,
we'll get to a conclusion soon. I'm willing to break backward
compatibility for non-SFDP flashes, and if/when complains arise, we'll
use the fallback mechanism to non-SFDP params. But after we'll have such
mechanism.
> 
>> Also, if you care, would be good to extend the SPI NOR documentation on
>> how one shall test the Block Protection.
> 
> That sounds tougher. I don't know that there's really a standard
> toolset for handling protection -- I guess the 'flash_{un,}lock'
> utilities in mtd-utils qualify, but they aren't even packaged by
> relevant distros (e.g., OpenWrt; but I guess they're in Debian). I
> typically use flashrom, since that's what ChromiumOS uses, and it's
> available in OpenWrt -- would that be an OK basis for docs?

yes, why not. At least for people using OpenWrt.
> 
> It's also highly conditional on what sort of range(s) the flash
> supports. So it's almost like we might want a programmatic
> write-protection test suite as part of mtd-utils/tests/, rather than a
> bespoke narrative document. Which ... is getting a little larger than
> I signed up for.
> 

Some test in mtd-utils would be good indeed, but narrative shall be also
ok for now. What I fear is that people just use just a flash lock/unlock
all sectors test, which is not ideal. We shall also test locking on some
sectors from the top and bottom, to verify the correctness of the TB
bit, check if BP3 is working by locking some sectors in that area.
Haven't looked at the BP area in a while, but you get my point, I feel
testing is not ideal and a guideline would help.

If you ever feel that you can spend some time on this, help is appreciated.

Thanks,
ta

