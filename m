Return-Path: <linux-kernel+bounces-275857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679C6948B14
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22620286569
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0291BCA1C;
	Tue,  6 Aug 2024 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJ6lBs9a"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9BE166F19
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722932320; cv=none; b=A91VsrDqOzu+uJYJ0FsozSspSvQwcDv8jmjZOJHNkVuxmaOQX3qi+XAuu+d3wVAlm7TkAzjWPmNRUAp1SMlwmMggSbBn1CYuGlBEmA43SigO5C0Cf79+xALjW4Xi/oDz1QyR3Fkdbh0Z8FzE7PQg/EQ/xCAM8FdYt7x6QDpXA5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722932320; c=relaxed/simple;
	bh=QyCE/uUU3yt8EzWomhk5uMhp5Yq3D0+NGDYpDzHolVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=salEvRbyvg6U0Z4r6dGYt7q6Wju88HSQVCnKV/ZXKp+MKDk6D65xIn5amfdmMdKog2lJwECSfQpuCicEprUzbXRV3oGUcQIsvCeaoPjLsPuviUqDhJ1nTZ/Juk/esOeT/OMh82xV/VroKPn+EP5yCMw2XH8ll4iUMnDqiYzo1vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJ6lBs9a; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f189a2a841so3052211fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 01:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722932317; x=1723537117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pdaYiU6TA3sxGpWccnkRIY5dniHV0/PLzplS0d18FZ8=;
        b=HJ6lBs9aVRzjTVQbhp4ALtIpimfOnaNW0fRE6wtXSZQHQ1QssMMwECmkHuyLME0JzZ
         Qzu6BnGD3YjVCB7HxkLKNIiM2V/EwXWzDpmm9QWhvKhHnzDRRqMmc5ZUjPvSStu6XrAA
         w4rPhJ+lLtwTMuW4KK3SK506vJ9zLgeaRDP+XXy2HQ25yJ7yVEqtHBk18+k5l1nKEJqq
         cGdQkBV2AncsRvIi2tLVlVTMa9VITq50YnYSf//8gyRcjxSkgcf3f/qWcpbqU4z2P3qq
         QJLcUK823uAmf0zk0oC9UZ0QxoKZhiUrdq8488ub07y3VvbXoSpxjShtjQOD1YAEfPhJ
         svPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722932317; x=1723537117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pdaYiU6TA3sxGpWccnkRIY5dniHV0/PLzplS0d18FZ8=;
        b=NyqJ5kjEVyVAUjuCGnrB9aWiy/dRydIS5jrdrKjWW1lEcdXMv0djz2UcKiHKIA/+06
         DDzPlnmE2wyKgdMIlyHi23Qfd+ILWxgL1RonhyepM3rAlNcKTJdBHEcSak2MQPR/VTDJ
         1RRJdqa7hleY2DFGaMudZ7YBvT/KRsRGssrFjTjOC61k6/bbWxPSRPyl5TMJeC8D5HCp
         +LvetUSTRLD0ORNr0wygJ+et51o3KsV+oXZ/r1wDZM3eB6iM+sJ4gM/A5KnVV2zZu2gV
         DktfxVoPZMgOpBTmn/5myvFQRdaWsU2q/lR+1iTh+CUdCR6Etz8qF2JOvXgyCqH87qXc
         6EEw==
X-Forwarded-Encrypted: i=1; AJvYcCUSwBPjsIuPPPzuLxsA5VxiJOQzx3Vu/8iMnlO9koAq4C4TBuYLQi3/VYiQaLKoEkwN7w9dDTFSaEeZgkh6aRk6tMSddvHSBYpLv/4d
X-Gm-Message-State: AOJu0Yw5Fm0tahZIMukp8NKezPuTO4XHNlQ8Yy8P8Yf7zVy7tl3g7Gz2
	GV6vY8MV4OZNHC/lGfNE7UDYwDbqxL5NuvLBgPHvnoxA4RBkdYC6
X-Google-Smtp-Source: AGHT+IEeVOq7+cZ+dHSYnQ6EarVpMFsJIKxpE+xSZDbU2cnocYZUNB2eIjkdgNkHndMYe2wYIzgtJw==
X-Received: by 2002:a2e:979a:0:b0:2ef:2b53:c785 with SMTP id 38308e7fff4ca-2f15ab35233mr90242731fa.41.1722932316328;
        Tue, 06 Aug 2024 01:18:36 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e186f67sm13145041fa.18.2024.08.06.01.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 01:18:35 -0700 (PDT)
Message-ID: <cb944855-0277-4267-9c6b-449c7879a1c7@gmail.com>
Date: Tue, 6 Aug 2024 11:18:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] regmap: Allow setting IRQ domain name suffix
To: Thomas Gleixner <tglx@linutronix.de>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
References: <cover.1719830185.git.mazziesaccount@gmail.com>
 <fd13fcc9dd785d69b8450c8e9c26d860fcab7da8.1719830185.git.mazziesaccount@gmail.com>
 <87plrpvzmg.ffs@tglx> <12228ec5-cf2f-47b2-842d-ce336d921260@gmail.com>
 <87jzhpscql.ffs@tglx> <dd2f4a1e-1861-4838-9ba2-668bcde0e2b5@gmail.com>
 <877ccv5d2x.ffs@tglx>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <877ccv5d2x.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/24 16:11, Thomas Gleixner wrote:
> On Mon, Aug 05 2024 at 16:04, Matti Vaittinen wrote:
>> On 7/13/24 15:22, Thomas Gleixner wrote:
>>> Something like the untested below should work.
>>
>> Sorry for a very late reply. I have tried to minimize my "computer time"
>> during the last 1.5 months (I really needed a break) - but now I'm
>> getting back to the business...
>>
>> I used your patch below with the BD96801 driver and tested the changes
>> to the extent that the IRQ domains were successfully created and names
>> and numbers seemed reasonable. (I didn't yet try to make the PMIC to do
>> a real IRQ though although it should be doable using the WDG.)
>>
>> Do you want me to include this in my series (keeping you as author), or
>> do you prefer going through the patch process yourself?
> 
> Just pick it up. Make it work and add a change log.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> is good enough.

Ok, thanks. I'm on it :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


