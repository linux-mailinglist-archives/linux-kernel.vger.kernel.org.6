Return-Path: <linux-kernel+bounces-440573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325B59EC120
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8521683FC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D937E5789D;
	Wed, 11 Dec 2024 00:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aReVojtl"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7293FB1B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733878604; cv=none; b=Wv+Wzr2CFD/pPzfi555qGEZCOVALP+9c0uaS04Z8NWtPu4spCeMveFZqRh7Umn9LDFRa5trht5GRcqvk7vCqcrtQ5nRA0bWwNHYJcqKywG/Fu4yBFfN2c496bscUSmnH26KRW63Myex+P/Ogr+FrX0CHSwnUD8cMe/Ep1vph+DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733878604; c=relaxed/simple;
	bh=+tqG6dDgI5ZECQUoZaF2RNQQgrvqwXZYwBQ6bTd178g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fBh3cFx8ZgRTkfFY+vXOp4P+9PL/TLoVnSl1G9G+KdhBaRqcBXAMWE25hIkQr3rG+4ISglGTCzA1AcO8ni2V4Dimut61vZY/GDBAV5JhT0LQuVRAEOcJ2AW6Axv8PAfm45iJvLZ32vL4Y8cnW493ByEqUkNXfvhO2ZdOQBvNYGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aReVojtl; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-723f37dd76cso5476824b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733878602; x=1734483402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dyOaRuwM/cxVLrFIRDebfypb6KNC0dUwFTakk4Ga8N8=;
        b=aReVojtl6mmbQ89tbBIU+de0Z0RC5hpxomqs4euRvyD0aabz/L2CAVplrlg7pLFGl3
         PI2QHi//hhwPbpSU06TUncJRq10kkQuPogn02Rz619bs5w2V0Z5z3HVuzcV7vYX179o3
         YqHh+chk6e/ZvTR1CshNcMGTD0O/Oa1h6AoZa6xMjhhs3032B9kNDjJX+2+PoqExSJFH
         bP1TAoLD3yVqA5pgDJWxo+sfVX0Wo8o0rGxhWEnT6a8xMyfp6jd3gPYZ0qhjGoZUZf69
         fBsWZ9gSsaOCpxFFvAv1LmAswxcdbO+aZfGc5IKHGMNdS41IWdcgbETsYDJ7OcF5bua3
         7JWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733878602; x=1734483402;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyOaRuwM/cxVLrFIRDebfypb6KNC0dUwFTakk4Ga8N8=;
        b=nUMhwEaJepZuUXRPKDsUzHh9jv/kspLV9NNpxx2mJatg+qcEv5NMNIT0GV16x1G3OV
         7hBgQh7aIDv5xu8XDjQCO5gmv/eJAvbxnvDzMGilEKxG6yoJRBo4VKxWjrmU1EIeHigO
         bUpmk12bDzg85rs8cVudTxRj3447yaui/CO9FpVK/lDmCE5GdJj2SYtCarcdh3NDgtTS
         cfozLwJgNmqCje3VBNknTP4FECoYuEovjf6Vc4ab023Sx8pcLeMk0trznOzD1UyPzdT4
         DSHOUNtHXa6SpoXJluywThZ1NFRrztDQljcyUi7htDG7q0ZAwQmvOIRCEiK+jDdX51fu
         BgRg==
X-Forwarded-Encrypted: i=1; AJvYcCXU1II7uXavQnT4/ZhSkvJU9gqWapGaOPegiY10pNkAnlTG0ZwpsIJQQjS3F2KCiEPafiCuogEvqn1p2YA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtd4/0PHHRjk94mevR6O/oIvvQLyZRVtik/lMQHiCkTQ/i3O+s
	gaQNGZjy6Xu0RbsnN4phxeoSss36JtVPPy/jWhxr+mZbUJlYZCxw
X-Gm-Gg: ASbGncuSh/5i39wYgroD21f9OCDNW5geoD6duwXYytMJ+KPPuqljZTheNTbkm6ei4kG
	SBEri+aDnuQbfs1YLD1Otc4viARj5jh0FoMTQCss1YaVQtJMABDDNB8Wzc5MCgZt+zD2WYy5+Rz
	ENTIFbijDdAphVE7v4Wmi969zlFx8tyk7uxJaFIne420mmEA6s6DtV+FA5lcEs1l0d4w5QUtp44
	3zoyyCXonA38cESSXKVfuMCKxsv9li5rvKkBDBx5lmJJJ2pYRtpiM9diTntlhmDecSAkUjjBvnW
	1L+vf0Bx8esl/XwXm3LsQ+TnOCg=
X-Google-Smtp-Source: AGHT+IFHnTZ/EafV3t2c0yujPmfjIiCMMq7G1FHXSYYD3G3tUbUQ5D9YjE+e/XlRSCCHYFkBtrUZDA==
X-Received: by 2002:a05:6a00:99f:b0:71e:4930:162c with SMTP id d2e1a72fcca58-728ed3db503mr1699108b3a.6.1733878601767;
        Tue, 10 Dec 2024 16:56:41 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e8177c7esm5098284b3a.108.2024.12.10.16.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 16:56:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2c6c7e9d-ca10-47a9-82a7-a2e26b1f51ef@roeck-us.net>
Date: Tue, 10 Dec 2024 16:56:39 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] staging: gpib: Fix i386 build issue
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: Dave Penkler <dpenkler@gmail.com>, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20241204162128.25617-1-dpenkler@gmail.com>
 <CAMuHMdVUnr4iAZmuy8Z3S+sCYN4P26RdpPwXevwiJrh+KN025Q@mail.gmail.com>
 <ddc720b2-8bb4-4a07-8280-dadeb2de5b26@roeck-us.net>
 <CAMuHMdUb-tpmTiKV5BFopCWoY96D_HYNG60Kv+wVRKnDFF+COA@mail.gmail.com>
 <2024121051-snowiness-sampling-2fe2@gregkh>
 <CAMuHMdV2Nh6ZZ-0tW0dCt5OoBH5_OrcpON32X1YJBQYgF=eywA@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAMuHMdV2Nh6ZZ-0tW0dCt5OoBH5_OrcpON32X1YJBQYgF=eywA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/10/24 01:02, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Tue, Dec 10, 2024 at 9:39 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>> On Tue, Dec 10, 2024 at 08:52:08AM +0100, Geert Uytterhoeven wrote:
>>> On Mon, Dec 9, 2024 at 5:18 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>> The underlying problem is that the code uses a pointer to store the physical
>>>> address. That doesn't work if sizeof(pointer) < sizeof(physical address),
>>>> which affects systems with X86_PAE enabled. I have not seen the problem
>>>> anywhere else.
>>>
>>> I could reproduce the build issue on ARM, with CONFIG_ARM_LPAE=y,
>>> which is not enabled by allmodconfig.

I think it may actually also affect mips (CPU_MIPS32_R5_XPA) and arc
(ARC_HAS_PAE40).

>>
>> So does that mean this patch is incorrect?
> 
> Purely from an arch-agnostic LPAE PoV, it should be:
> 
>      depends on 64BIT || !PHYS_ADDR_T_64BIT
> 

Dave, would you mind submitting another version of your patch with the above
dependencies ?

> However, that assumes the driver actually works on 64-bit or non-x86.
> Perhaps people keep an old i386 to control their GPIB gear?
> 
> The drivers do not use ioremap(), but just cast the PCI resource
> addresses to void * pointers. No idea if that works on x86_64.

I did wonder about that as well, but unfortunately it isn't easy
to change, and would most definitely require testing on real hardware.

> It will probably crash spectacularly on non-x86...
> 

I'd guess so. However, that isn't something we can address here.
All we can make sure is that the code compiles.

Thanks,
Guenter


