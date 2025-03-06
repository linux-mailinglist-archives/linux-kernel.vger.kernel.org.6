Return-Path: <linux-kernel+bounces-549156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB1EA54E4B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39FF27A6CFB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2A317C224;
	Thu,  6 Mar 2025 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6Ui8Fyq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46E1502BE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272767; cv=none; b=kPpUMBIByIIDaVBLXqbCdCn6SwZTZqIV16HnBHKYkgU2lcDHpesqx3xA1gitW/QidbK79yhHkDJ8Y8HXzKUm796iYS+fG5sZOmZv/oFDGdAsfTTdyADZS48dVACO+q+6tVKFXh74C8+rlNDwKEnEbWND0ckssVdoXmYjt71qzUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272767; c=relaxed/simple;
	bh=XS3hwENjNCDtV8L+71dZC8w2YiHjzfzQ0f/usLadV+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=su37aljHlH8jPHOanT9h0c9oWlWOQMGg1Qz1IUDKIGgL9ZQCtlVlVFItWJwFoIHZlbg16XsgskKEeq5QmY5eR9pW4wEJPfYM5k/HcnMEKYIm6MmCT+ic6mLl2T2hCOLuByljW+X9gkIfTg8FJt/pUakPPy+Qcm2B9iOC28wVtlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y6Ui8Fyq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741272764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8l7qABKwHCDWfbWvQGzQtXX9iScy9t9j1udXksFnIA=;
	b=Y6Ui8FyqTK+qQaHtbJan3XYzUpsua9aO8cd0QlvWcb223rmFCvJQXLfW3hgLrKS6AjhTTy
	nWGjAd817iVD4qkvCkrFXODJBU1FIfj2qCt16mb1wD40lXD0hyYFinm4GXg05wAQ0pA4ZB
	Z8UY3VFtrxNVhMYkP5mcbL16B3XVtsg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-9LdZRW7-NUigF_n-0Zqi5Q-1; Thu, 06 Mar 2025 09:52:39 -0500
X-MC-Unique: 9LdZRW7-NUigF_n-0Zqi5Q-1
X-Mimecast-MFC-AGG-ID: 9LdZRW7-NUigF_n-0Zqi5Q_1741272758
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5e546b0ce50so960736a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 06:52:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741272758; x=1741877558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8l7qABKwHCDWfbWvQGzQtXX9iScy9t9j1udXksFnIA=;
        b=h9yuDnKBLZHz4/1+ljSYJFjHUdC+POZJinoOSWillpERpU4O580gEKmcGggTwhYTIS
         P3DP3Fopi6HQFoyT0ctl46wvFwY6aOPWxpNge8fvLSAC2FieeBXEVh+m+doMVLG4X4Gx
         sdZjSkAnmUH2p1wU8r/9xpsW0j30ySvBmdCzKodeTg2RBbWBGMFx+gwiS4vdw8hPQiMX
         qHDScp7XBE9ZnUANBBLU4B0cLzpRqyLATPxr68Z5yRga9A1fBq1YCVi8rNSJ5U2oPwqb
         0GGuXSUxGR7zIFe77k/eMmOPhgOplLmae5m8SQVL0+/OSIr8InvhK2sknWf3yUFct/wu
         QRXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMQ+bxaa8/6NInkYAUUn2jNL6gcquWhSwMDiHPHhMi1zi0JMDyFuhuAmnex26NPdEJ0yNtBQ2a8jSFaC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YylcW7uuhL1Ipt7Y5XaERMlOJRfFOD6wx5o43Lz/yfYk5kqT7fD
	3eMSgFdLaZmEZ/kaGgAk9n7dfUERldE4ezcOztBA64v5AHFuhYoCNDxmNMKR87AYvwSa87GZ96i
	vzRWxISzzFk1fe/M/iIIiv47/b0ttDy6lgBtTd0GEaukqXBmGz8FAsod6JDFCXw==
X-Gm-Gg: ASbGncspipC5OZE30AHYmtOYSzpzgExN1Tgv28sH3VO/ypgHYUNSZp8sWdyivIHNLEu
	oHxE6ePg9djS56OmXgof9savYdWMa98FAPXaIVq8bvPP/smihDZapMkKodKd93N+ejw8MeasUn2
	xqnN1etRdhWzTBbeY0GRTqTtgoCyME+K2vwkoCoJiCdvta7tmnEUO0OleAZ4A+s49hh66CuJ7/a
	lq1PeR39mdM/xbtOe7tMU6jN/48R6T78+wQjhePQPQBT5tjAhsQ1uRxc2x9SyUCViknO6V0VbHj
	1TIjnF8X7XCKwB0dLlLlzGxN1ZNto8dp55W/cuQCcrH+wALYFnVnJjgDpldKQUHX5QlCSELOEQu
	ybux0uzegvwHA7OuNZEQ7JhyNNKuJhrQMwJDlstGAeUrCljqg1ni/Fq/Tj+5soHzMLA==
X-Received: by 2002:a17:907:3e21:b0:abf:6a53:2ce0 with SMTP id a640c23a62f3a-ac20d8bc92dmr662636766b.14.1741272758054;
        Thu, 06 Mar 2025 06:52:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTtG9PqamppLgHCSkLHkN2yXFS67KMnQIn5wc46xN5pe/wvFgmTNUvin6PAc6j/i10zXOkTw==
X-Received: by 2002:a17:907:3e21:b0:abf:6a53:2ce0 with SMTP id a640c23a62f3a-ac20d8bc92dmr662633666b.14.1741272757677;
        Thu, 06 Mar 2025 06:52:37 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23988830csm106500166b.131.2025.03.06.06.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 06:52:37 -0800 (PST)
Message-ID: <e6dc530d-b7dd-43f6-8dcd-f9188000d279@redhat.com>
Date: Thu, 6 Mar 2025 15:52:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: amd: Add ISP platform info
To: Mario Limonciello <mario.limonciello@amd.com>,
 "Nirujogi, Pratap" <pnirujog@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 benjamin.chan@amd.com, bin.du@amd.com, king.li@amd.com,
 gjorgji.rosikopulos@amd.com, dominic.antony@amd.com
References: <20250228170238.3484860-1-pratap.nirujogi@amd.com>
 <cd25d131-bead-4a38-98dc-1011c2843286@redhat.com>
 <3d57b624-7753-4a4d-9051-0a55cbdff1ec@amd.com>
 <9b8c9eb7-c8d5-4c12-9ce5-c4b4df3b4223@redhat.com>
 <5909d7b0-8cb2-4aa9-b717-9b85a1b2a96e@amd.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <5909d7b0-8cb2-4aa9-b717-9b85a1b2a96e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mario,

On 5-Mar-25 4:42 PM, Mario Limonciello wrote:
> On 3/5/2025 09:26, Hans de Goede wrote:

<snip>

>> Thanks.
>>
>> So looking at this there are ACPI devices for the sensors, which
>> unfortunately lack a _CRS with an I2CSerialBusV2 resource pointing
>> to the ISP childdevice as bus-controller. So that i2c-client
>> instantiating would be instant.
>>
>> +Cc Mario
>>
>> Mario any chance that for the next (or the next-next) generation of
>> AMD devices we can get the ACPI tables fixed to properly describe
>> the sensors as having an I2cSerialBusV2 resource, just like how e.g.
>> I2C touchpads / touchscreens have this ?  I suspect this will benefit
>> Windows too. Likewise any enable GPIOs for the sensor really also
>> should be proper ACPi Gpio resources in the ACPI device describing
>> the sensor.
> 
> Due to the architecture of how the ISP is accessed "through" the GPU, I'm not sure it's viable and furthermore if it actually changes anything for Windows.  But the ISP team and BIOS team can certainly discuss it for future designs.

There could be an ACPI child device under the ACPI device / fwnode
for the GPU which models the ISP, this could have its own _HID
to allow the ISP driver to find it. If the I2C adapter part of
the ISP driver then sets the fwnode of the adapter to that child
fwnode, it can be used as the I2C controller reference in
I2cSerialBusV2 resources for the sensors.

This is how I2C devices generally are handled / enumerated under
ACPI and I don't really see why future AMD designs could not
follow how this is all supposed to work under ACPI instead of
having drivers need to manually instantiate the i2c-client.

This also allows putting things like the sensor i2c-address
(and GPIOs) in ACPI instead of having to hardcode this all in
the drivers.

And as mentioned before I think this would benefit the windows
drivers too, for similar reasons (not needing to hardcode
things like i2c-address and GPIOs which really belongs in
the ACPI tables).

Regards,

Hans



