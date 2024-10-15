Return-Path: <linux-kernel+bounces-365261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D36699DFA3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517E5280C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C00A1AB6CC;
	Tue, 15 Oct 2024 07:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g9rf4uN4"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAD3139578
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978542; cv=none; b=uteqz+hiWuvW98XFYxAH4LFh1pazDHKtQx8hrPsxOnhkAs41DWoioDbvp72EZ2g9fYcygfrVu+07gA/Eo7lRuK85sI7tDhB1LW+Y4PnaQ1FBxpmn4VW9vTe2+Bm3UqQwVPFBhL1C2s56zVd7sVXx2LM/u/KhJT+xg7Rh9G79vuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978542; c=relaxed/simple;
	bh=iIUbLt9kvCLkI557/g86IlmJZITOMGz9tInCY/BfK5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ie8QSm8Unh7kja8Iz0wRrTSM5JPoeJ0LfOajP2K2VFrEBRmsx7iAeg8mhzOfaTFPPAGHcd706lD/cZ8+86TrRG2GrKwZgwPU3ym6tw0vePIA2NjBCMcqXDgGrJ5TFP4V7AAlpODSLk4r83btW1VOIIL8F30aCguISXTZ4pXqnxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g9rf4uN4; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c94dd7e1c0so5112164a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728978539; x=1729583339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BOJdjyePrT3s5NTIWoXorfasxWwZGTRkmpxbaaJbdio=;
        b=g9rf4uN4DvBBRZl/2u+qMWZjF5FZW+DwlJRM5k46w6uHk08rqfwT3xlAyEPTZz5jLw
         wzHMHZQxCSKv+2OoOBZinRtO/hg7H8C97o2D7UYS1lXpw9R80DmceN5VSOR56n+tWqgk
         JjBXEytnAwF/Mj/2K3ubRi27tMhCTRfNdWIHP3eBKRiC6LzdDTAbbrtelfHw+8GJkLjT
         lu54Jf2ECUaQuD8m6FfAQEoVVFViI4/zLYZOakWFlcDy9LA6IiCRGurhoBsod8Qb08n/
         6kIlW20p49DVMmk7ErdpcGUj5UT0OgBbEUmd6UDaB/v/UtoOuTSZigOo/RXAYmjOoaIG
         ebOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728978539; x=1729583339;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BOJdjyePrT3s5NTIWoXorfasxWwZGTRkmpxbaaJbdio=;
        b=fFRO4vHQ1pot5ph/eOr5fxYhdIrontXkznRISxz635EkcQx37zQlO5oOA056TZPplz
         /twaHqnrkX2/WpfCdrh2se07iWSNnlanPXLeJJBuWwQP5djq4s3qkSxZ7ataCNvLdXn8
         2yCtVv6+axwC4rG7BT4bjYtvXELbsGoEFDN8qnnWDYOf3VThjjDIUg/DbmIBYfhaFDZy
         7tfRsdgP3y/NyRLpquHdsw2UCUM3DPprCBbN9/fkHQc6cNAFUuH4VDcOVtehGIKzve5P
         pfYbsDamONsxMrpBSBOisvPTVx5sQh6hJ4zaRMp97KKWDY+/9wDwrROb95zkK9Pbg/R/
         0OrA==
X-Forwarded-Encrypted: i=1; AJvYcCU6btU9JO5oTNE5O4RZQYs1PPukAXlY5T9wlUVMG8k9jQ7rWIVmkGP4Gyc1t4iBkv9lTB+QnJ4AMgOLWBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgVAKMfAuoeDr8QRqLMQ9ln4OmDMpBLck8f+/ZrTMYMFifpg5b
	ThwJixK+HsXQGjOg1tEUqlu0KKg+dJgITdIfd5n7ymXT97WFthZ2RRv2IuHnuzE=
X-Google-Smtp-Source: AGHT+IGtJZCKtA9eEpUdQE2A13JrPU/h/W+a6q4VltO9TMaYnvQRXRkysIb/+243uS0AJxvtyHBoHQ==
X-Received: by 2002:a17:907:1b24:b0:a99:4601:b9d8 with SMTP id a640c23a62f3a-a99e3ea6502mr1121252966b.63.1728978538888;
        Tue, 15 Oct 2024 00:48:58 -0700 (PDT)
Received: from ?IPV6:2001:a61:13a7:a01:4f03:92b2:1779:9aa4? ([2001:a61:13a7:a01:4f03:92b2:1779:9aa4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2974db0fsm37838966b.83.2024.10.15.00.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 00:48:58 -0700 (PDT)
Message-ID: <93a8a951-7e0f-4504-8407-15d920236f9c@suse.com>
Date: Tue, 15 Oct 2024 09:48:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net] usbnet: modern method to get random MAC
To: Eric Dumazet <edumazet@google.com>, Oliver Neukum <oneukum@suse.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@kernel.org,
 John Sperbeck <jsperbeck@google.com>, Brian Vazquez <brianvv@google.com>
References: <20240829175201.670718-1-oneukum@suse.com>
 <CANn89i+m69mWQw+V6XWCzmF84s6uQV15m_YdkPDQptoxUks4=w@mail.gmail.com>
 <fd906211-7f31-4daf-8935-2be1378a75f8@suse.com>
 <CANn89iJWATVhMVDgq3fcV9zpZRt8nd_bWp3=qRHo8L3tJP==Kg@mail.gmail.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <CANn89iJWATVhMVDgq3fcV9zpZRt8nd_bWp3=qRHo8L3tJP==Kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15.10.24 01:00, Eric Dumazet wrote:
> On Tue, Oct 15, 2024 at 12:24 AM Oliver Neukum <oneukum@suse.com> wrote:
>>
>> On 14.10.24 21:59, Eric Dumazet wrote:
>>
>>> As diagnosed by John Sperbeck :
>>>
>>> This patch implies all ->bind() method took care of populating net->dev_addr ?
>>>
>>> Otherwise the following existing heuristic is no longer working
>>>
>>> // heuristic:  "usb%d" for links we know are two-host,
>>> // else "eth%d" when there's reasonable doubt.  userspace
>>> // can rename the link if it knows better.
>>> if ((dev->driver_info->flags & FLAG_ETHER) != 0 &&
>>>       ((dev->driver_info->flags & FLAG_POINTTOPOINT) == 0 ||
>>>        (net->dev_addr [0] & 0x02) == 0))
>>> strscpy(net->name, "eth%d", sizeof(net->name));
>>>
>>
>> Hi,
>>
>> you need to have a MAC to be an ethernet device, don't you?
> 
> Before or after your patch, there was/is a MAC address, eventually random.
> 
> The problem is about the test, which is now done while dev->dev_addr
> is full of zeroes, which is not a valid address,
> as shown by :

Hi,

I am sorry I misunderstood you. Yes, I overlooked the test for whether
the MAC has been altered. I am preparing a patch. Could you give me
John Perbeck's address, so I can include him in "reported-by"?

	Sorry
		Oliver


