Return-Path: <linux-kernel+bounces-573011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7FAA6D173
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3196F3B3664
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BABC1487D1;
	Sun, 23 Mar 2025 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="za8yqTkV"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41F129405
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742769035; cv=none; b=qomr8Ij49/LerwwNJQZ/ededgmlXwPviKUv0ni2WOA/rUu33QfHeFfBAyVEFtwYVJWEPj/wz5MJeV+Vqe7ZsJthFDaHfRftiTXg8J5cR1qP+P3mXik5JL57vmGzXiG0fgfbO2fix660zj8comgaf4papf0q0NDA0/gljrRBC4Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742769035; c=relaxed/simple;
	bh=1b3NqGhZ++VNtWquMWADqKAovnA8dxvjiZY17polxNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJQLpIunJNnr7GW83120u0i86vCl98GNRo1CF8EPdH42dHsRg6z+7lLq4FYiVmBlhr4NxYGFed4lpVQBAyBn+IFuRolERq6IZpQsqQJy8p1K+bAR2dgI2LXmcp4wXo2Jf2ijBGOalu3MmFhllpZChTzqehpS8cE8jnAoJZVXjT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=za8yqTkV; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d434c84b7eso28924515ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 15:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1742769033; x=1743373833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nTRlExMDyawWBV8YJuZYM4CxYbcHVqfU+45dmVV3tsQ=;
        b=za8yqTkVfMyFHwD1+oWYC+gKzg5VhwhXkvOmBnIq9CC/T8XxO4JrmDhP5r3zfnG+Fd
         UJbzZ4vgqLt3cJFNpaxpXoI2olejHL+IF86y72vmUgNIv4wdU6oOgG7stFfKQlji5asp
         KQbf2X6w+2zsM3DXr6nR/BtieR6h5eaYh72zewIQB9b4Q1rLWOuKiWSttSl8ngsFQPRi
         UkTsRvqFul0xUDU9qHgoxls/KCVFSuRWyAslygBaCRn1BLEgmB77vweODSDpqOlXR0vX
         JNmISd+QebuZFN93XZJvSBAzEZKKhlBHiPP/vMZtR65cfgNbMElU16pJ4n41z7BSF1nM
         T6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742769033; x=1743373833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTRlExMDyawWBV8YJuZYM4CxYbcHVqfU+45dmVV3tsQ=;
        b=s4c951t9iqXL+RUCxiLz+AyWd6Qh2iBx+jVdXwF9IzIDgA6lgyU4Z7crwIFBAuTmdy
         xyDZfGsot2x96LbdVEAchaMGS95mAwETTLW/DOsitdcqh8LldXJJGZ3cQX3USSxtzz7p
         fx6JspDDeICuqrJUiNkm4L2e3zAMH01vfHJSIlWvzEDBHffmQITS1RbQVTJZuMA3mz8U
         IYJPdvTsV9OpfhmYCvgxZLT3fvCbZNj7fcH5eH93wyhTnxTBiNbOvBEqOs1DMe1LEi7Z
         mO5hQKvvPvnMg61oJJBbPltxlstlV+6bseYWrsml9HKKCb6GBZxf9+l9clS+LNYXdMXk
         DKBw==
X-Forwarded-Encrypted: i=1; AJvYcCUZkXwdwxw+Wdn9eVTfeR9IC1rwgK8puNJP2MdGokhxznTfmGbBz6grlPzCAhW7U3kNbEBrvyxAN9tJmLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRPX1qGL5+XhWmxfQCFqDwPZV8bog9oUWH3dkBKI8zlriIn6t5
	Rn7P0VcA6fVexPoweiP0DAiod8riXXD1Qd66lN02yu0cVyvAMynCLklwi3a440E=
X-Gm-Gg: ASbGnctF6kzkI+PR8f8J6dBmCcIMCPq25IZPrKYcxeDrtey5h+HgO3GSmtCnYStOA39
	2kgAZU08uYJRAY3rG8V3dcPcsrlMSXwocpAn+ege0ZngVPP3qRsUKVfHbZISZyES97ArVokwMc0
	1ZmnRtjI1fXwlE7o7BuIAVYtXkxERxVVaZWVkwu7DhtrgIXa8SuYjLie8XyymbGlKxHtfIDfP+5
	IdagMnMDn4jpXnvHHV+64TZbhJgxCizjCJieICbKQV6NuIEsdApeJLOhLZMC3qAFfB0kW7FbYd8
	XTBQui2HK68NKQtfiuVlepN1USDjs9KEWUOAQx7cy55+CNAUmgTZ+0rbSbw54BZ7BPDSDGAN7FP
	KsR6UiS5BsWUUNeHgoQ==
X-Google-Smtp-Source: AGHT+IGH7axJe7eTCwDAhgnxz/2TT8RhnJt+UseNxV/R3diYZCOSlRPsij/3sX+uVBgUHGoEXTkhpw==
X-Received: by 2002:a05:6e02:3e03:b0:3d0:239a:c46a with SMTP id e9e14a558f8ab-3d596114994mr121950535ab.9.1742769032889;
        Sun, 23 Mar 2025 15:30:32 -0700 (PDT)
Received: from [10.211.55.5] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbeb52f9sm1538014173.130.2025.03.23.15.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Mar 2025 15:30:32 -0700 (PDT)
Message-ID: <661457f2-aad9-4b3c-926a-6ee021355dac@riscstar.com>
Date: Sun, 23 Mar 2025 17:30:30 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2/7] clk: spacemit: define struct k1_ccu_data
To: Yixun Lan <dlan@gentoo.org>
Cc: p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heylenay@4d2.org,
 guodong@riscstar.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, spacemit@lists.linux.dev, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250321151831.623575-1-elder@riscstar.com>
 <20250321151831.623575-3-elder@riscstar.com> <20250322155034-GYB11633@gentoo>
 <45526855-17b2-4de4-8e12-6320b7d84c8e@riscstar.com>
 <20250323130430-GYB15267@gentoo>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250323130430-GYB15267@gentoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/23/25 8:04 AM, Yixun Lan wrote:
> On 07:43 Sun 23 Mar     , Alex Elder wrote:
>> On 3/22/25 10:50 AM, Yixun Lan wrote:
>>> Hi Alex:
>>>
>>> this patch change relate to clock only, so how about let's fold
>>> it into clk patches (which now has not been merged), so we make
>>> the code right at first place? cause some moving around and renaming
>>
>> No I don't want to do that.
>>
>> The clock patches are Haylen's and the are getting closer to
>> acceptance.  Let's not confuse things by adding a bunch of new
>> functionality.  Get those patches in, and mine can follow not
>> too long after that.
>>
> 
> I only mean patch [2/7], not all patches, as it's still clock related
> but, either way fine by me if you insist

I see.  It would be great for Haylen to implement this, it's a
better way to do it anyway--you can define the number of
elements in the array using ARRAY_SIZE() this way also (rather
than having to count them at runtime).

Haylen is welcome to use my patch as the basis of this, but
if it doesn't get into that code I'll add it.

					-Alex

> 


