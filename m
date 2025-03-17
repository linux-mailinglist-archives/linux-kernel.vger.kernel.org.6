Return-Path: <linux-kernel+bounces-565130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 798ACA6617D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE1F23A6A14
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A751C202C47;
	Mon, 17 Mar 2025 22:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SazLihuB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E5F1DDC16
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250156; cv=none; b=ji4wYqCHkVT/kUNTnrN6Lr9Y9E8wwpR/4CsKfFYgkWruyXGtA2LTBNdGcAI4qmrXl0cf8wq2Pue2fiWfc/sAXCLAGOtQKYrHAw60VMRpTwZ2g9Ab2IH/ugR4y7TRi2Ct+7Dlak6XQ+fYkgbOf3nOuhDTqj7gDq62DXPgZ87IT1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250156; c=relaxed/simple;
	bh=UTka+Bwl7U3oXDZYsAkYcn3UttkrMbvEepURyaX8aTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fj8Vhmp3N2xh2YFI31C2AP1DVMYWU4CzTHQLbr9izaWT1AO95mSiZju0nKOvkPhunngs8aYrjQ5CyBx1M57VGZqkq0yKr8aLHwD9j0s7IL4IuUJ1haeOVU6p07oRPDdzoyiJ4WRT5gs5bztvOuVwKKKtZuXz9Sm8B8um9hG6rFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SazLihuB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742250153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5G+gLRdT0H152n57X0RhbxihhCG56hjU9sd24nfwpes=;
	b=SazLihuBtdKYictGVtgsHedE2cq08WyvfIjc1KNAZ/XanWRtnrm+bHZ4VoxI2z3OXTcPAi
	MV5Xoj1Ckl9XWVcIu6xGijFv5loUdmyT3BmKiv0qx+CIuk6HDtVFJuoR/W32azLUuuhOc4
	EW2semdv6z8UEOf1Mv9PfEfUfo9VghM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-5Mh2BIyCMbS7eFJbBnoImw-1; Mon, 17 Mar 2025 18:22:31 -0400
X-MC-Unique: 5Mh2BIyCMbS7eFJbBnoImw-1
X-Mimecast-MFC-AGG-ID: 5Mh2BIyCMbS7eFJbBnoImw_1742250150
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac2815aba51so370520766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742250149; x=1742854949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5G+gLRdT0H152n57X0RhbxihhCG56hjU9sd24nfwpes=;
        b=bBrWzjjEnUF5hmlOv54/mbD7ba6juzfRG1f3wciz8GQG6lFp7mpmoChWyci4/DRkD6
         KRGDN2+EHuol52aThoGYlMPSKCRoVjGOxx/AnrW4fAPlBlSXOVQlIOwhmpLy5vRtc9w3
         8OPTfx3XB1YmE5P3BRIyGkPGknhxl1rARJSk/RGoRF6XXgBYrwPDegCHFVOydcPyeRhT
         KlVPFTaQI9DTnYi8/XTlUSKCysm39jzirQx49O1nr5ffDcCsc66AWMCJZtbbdhZPXKov
         mZxVQY6kLP6PdCUtEM+VyUI/fX/PAHCbKufEtZ4sscctqqbt6i+Na5iME2smiFDmLW+K
         VFjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrlCksXMR+VKDu4YoMpbpTGIHAd/BkJ8UbmM1sJqRUjelOV0hp0xJjZjyuoqpO+ocW0PUBOCB8rdh6FLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDG+GZ8+YmSRqRhUc/bswFTeicsfjz2cANTBmFABGT9VU6aNFF
	mUxr0PlD5EEJCpQ9N2xgz1WBO6a6SJUC0/Z6BlqOgB0CjAIp985yzIGqSjaKsmOp46vMADKeiHg
	JMCLvl5ufvmKY+GpAnTDzkKBQdiNPiQG+xHFHhGqlfFg301UXP2brYZRXmTp8XId2kAPR7w==
X-Gm-Gg: ASbGnctOkLfZhmst/sQBimbi/WXY4rKAaJJaQJ8sJP7ZQDj0+2sduSSmPQRDrUun1Hw
	77dWZNSwF14c/6P2weg69T9vzYzxTmux3Sh7OSwJSMDHgXh6UMRfTqLZ1H1lXebvw76GJSz6V/i
	PwNjGlSa+Q+GjsuHtIhTNlqDj41mGCO05pYyabzJKTbp5HVwWtanT6Ze0QGIdRDX7TbwLAWtASd
	q3vf2JGdGUoN1eZCwoIsZ2Hd9yBKAnRqfKy2i/w2s9Calyg7FtMjkCYbYY4ysxPVwoOIPab3KHm
	Yu/GfB4rzUoNYj3EZg/P3GC9jjKdV/6ioL0dvUaK91NUoV19o1uXY/j1+YjHi9pr2fw/Fa1VxBq
	DN4AF0JCGy++Q4UyKoXVHjcMjX50yuWiPgstw7W5+9T14hGY6zXdlGJ/Jk+SYSUfvjg==
X-Received: by 2002:a17:907:9713:b0:abf:5f3c:58e7 with SMTP id a640c23a62f3a-ac3301e0b4cmr1470097766b.3.1742250149310;
        Mon, 17 Mar 2025 15:22:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX3P/YcE4PXvKt4s3YzLuI8eWICwMlFaui05RS2ZN2lx93D9W9d2+yiuWdCPJJlpPqcWVhhQ==
X-Received: by 2002:a17:907:9713:b0:abf:5f3c:58e7 with SMTP id a640c23a62f3a-ac3301e0b4cmr1470096866b.3.1742250148945;
        Mon, 17 Mar 2025 15:22:28 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149cf0a8sm740785666b.97.2025.03.17.15.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 15:22:28 -0700 (PDT)
Message-ID: <bd05271b-eefc-4a4d-90aa-9345e8d01807@redhat.com>
Date: Mon, 17 Mar 2025 23:22:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Input: atkbd - Correctly map F13 - F24
To: Werner Sembach <wse@tuxedocomputers.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250311180643.1107430-1-wse@tuxedocomputers.com>
 <20250311180643.1107430-2-wse@tuxedocomputers.com>
 <83ea44f6-c0ad-4cb0-a16e-dd4fa17b63c7@tuxedocomputers.com>
 <45fff318-7925-4328-9dca-999c00e271d2@redhat.com>
 <f742f82e-d533-431f-bf64-01cec4bead09@tuxedocomputers.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <f742f82e-d533-431f-bf64-01cec4bead09@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 17-Mar-25 5:47 PM, Werner Sembach wrote:
> Hi again,
> 
> Am 17.03.25 um 13:06 schrieb Hans de Goede:
>> Hi,
>>
>> On 11-Mar-25 19:10, Werner Sembach wrote:
>>> Hi Hans, Hi Dimitry,
>>>
>>> resending this too on the v2 to not cause confusion:
>>>
>>> Regarding remapping KEY_ZENKAKUHANKAKU to KEY_TOUCHPAD_TOGGLE:
>>>
>>> Am 11.03.25 um 19:06 schrieb Werner Sembach:
>>>> Currently only F23 is correctly mapped for PS/2 keyboards.
>>>>
>>>> Following to this table:
>>>> https://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-923143f3456c/translate.pdf
>>>>
>>>> - F24 and Zenkaku/Hankaku share the same scancode, but since in real world
>>>> Zenkaku/Hankaku keys seem to just use the tilde scancode, this patch binds the
>>>> scancode to F24. Note that on userspace side the KEY_ZENKAKUHANKAKU keycode is
>>>> currently not bound in xkeyboard-config, so it is (mostly*) unused anyway.
>>> I think what the firmware vendor actually wanted to do was to send ctrl+super+f24 upon touchpad toggle. This would somewhat fall in line with, for example, the copilot key being implemented as shift+super+f23.
>> I agree that that seems to be the intent.
>>
>>> Following this, my suggestion is to do this remapping and handle the rest in xkeyboard-config
>> xkeyboard config already contains mappings for F13 - F18 and F20-F23 in
>> /usr/share/X11/xkb/symbols/inet
>>
>> So all that needs to happen there is map FK19 -> F19 and FK24 -> F24.
>>
>> And then teach KDE + GNOME that ctrl+super+f24 means touchpad-toggle.
> 
> Alternative suggestion, again following how the copilot key is implemented:
> 
> key <FK19>   {      [ F19 ]       };
> [...]
> key <FK23>   {      [ XF86TouchpadOff, XF86Assistant ], type[Group1] = "PC_SHIFT_SUPER_LEVEL2" };
> key <FK24>   {      [ F24, XF86TouchpadToggle ], type[Group1] = "PC_CONTROL_SUPER_LEVEL2" };
> 
> Then only xkb has to be touched again, but not KDE and GNOME.

Ah I did not know you could do this. Yes this sounds like a very good
plan wrt the xkbconfig changes and then indeed we can do all the handling
in xkbconfig.


> 
>>
>> We could maybe get away with also dropping the weird mappings for FK13 - FK18
>> and map those straight to F13 - F18, but we need the special mappings
>> for F20 - F23 to stay in place to not break stuff.
> 
> Good question
> 
> XF86Tools launches system settings on KDE.

Right, but XF86Tools is also send for KEY_CONFIG which makes more sense,
the question is are there any devices actually sending KEY_F13 in
a case where they really should be sending KEY_CONFIG instead.

Note this is unrelated to the XF86TouchpadToggle thing though, just
something which I noticed while looking at things.

> Looking at the links in the git log of xkeyboard-config (commit 1e94d48801bf8cb75741aa308d4cdfb63b03c66c and 01d742bc5cd22543d21edb2101fec6558d4075db) these seems to be device specific bindings that got accepted in the default config because the keys where unbound before.

I see, so it might be worthwhile to try and fix these, but in
a separate pull-request from the:

key <FK24>   {      [ F24, XF86TouchpadToggle ], type[Group1] = "PC_CONTROL_SUPER_LEVEL2" };

addition.

Regards,

Hans



