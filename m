Return-Path: <linux-kernel+bounces-565131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C22A6617F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17841887569
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEC78BE5;
	Mon, 17 Mar 2025 22:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2aRkBWi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7326B1C6FF1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250227; cv=none; b=np1wrPgiXSKCWiG/SUW45u61FZomkdoCdJ1YVrJgw68FYtac1RgWjvCqhQwwIFoc/V/Ckbnf9ts71CfPuTESzUZMR3EBjFGVk33egA1Mm+VKjIm590SePsor50ntOj9v/Zy6Li1mugM8M6nYGVixnyU6VRZ53acTcvxYXII1hiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250227; c=relaxed/simple;
	bh=qOBL8abCZ+DPrUe5SzCaYB3GqooW5w/t+KRdMC+tS7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OY4bIERwFS1cpa7JgnkHOEgbsYzc0iOdKH48UWtugIPUDwRnivZLEvLIp6Vyc1h70YYbT/RZ2WeYmEjswn4TN3e7SMw0m4Fu7Jm//0BilSZzPmUo8qYTtqcMGIQOhx+mvUd+1vVlIzj4V20y/VpWQt3V0tGmphbPnz1yI+kmhag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W2aRkBWi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742250224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ypzfvWknX9NmdbuGXtvnIjLZ0pscGe7eRm486DVoM6Y=;
	b=W2aRkBWiCdjcuMB/tKPhZ3+KSoT+yGzpKkxviMCwh+PFcp81/cc7KwJ0rZSbtgVwS5507M
	XRIiII5C4dLU+KOi84TEK0oF+oszLW1s77gfiuHwXfxz+l84n03Dz368tjznzl9Vk7jPHt
	c18jMNvhyHqHz/4QvSgDmSNxiDVJjHU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-r_UPE6i7Nja87BR7ukJUug-1; Mon, 17 Mar 2025 18:23:42 -0400
X-MC-Unique: r_UPE6i7Nja87BR7ukJUug-1
X-Mimecast-MFC-AGG-ID: r_UPE6i7Nja87BR7ukJUug_1742250222
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e83e38d21aso5098306a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742250221; x=1742855021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypzfvWknX9NmdbuGXtvnIjLZ0pscGe7eRm486DVoM6Y=;
        b=L1nJZ/0Qhh8oqnPHatcs53ciTUP4DevHaV/KHXeGH8hRPNzQjLY//tuwp8dBT56ApG
         C4ueVcrYJxIGC8Z05SHoh10BGwnuP/NlEM6H99NBrLkJKuK70riQAA2aYysz+qRgB+Cq
         Izzcq3EMPr0I9UiEWZ0CVWI8X1vCIULO4S30SYhlItFgKZuhJVkoWPVfWz0br+ZUaGdz
         Q1rP62JyoFQAnFVsTGAxe2dFvHva4aQMnl/oAsa98vyPIh2Xq44C59UnnkD071k+Zdx6
         F+8NkG8pgz8ImjQ/WfRVzUQAJiOGpTcReUTQbb214hrmnuQsAHWY8vC93atpHCCCdVXn
         O0dg==
X-Forwarded-Encrypted: i=1; AJvYcCURzA8ZieApwoBGk3tBh6nfzzSLNW34LgBzPPp6bUfAAigAVii4liAaBAuYLGo/Kkz5s7F1f7xAXHyR0Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDgmbvx3scdcAkvHe2CyLs9ueMQ7q62vRFG8igDqllicX//uMG
	XEAeDP0DtBZtEn4pDTOssEGHTGkcqmEaecRLF0srRZynS5B5VJXr/5XJsaCrMidxmfZQjK7CtBF
	1JKhS2dGJ9HES2XpOSAnPOmcRnco2fwIcEHnOTDjlkSInJtF3/lujpc6wpRipOw==
X-Gm-Gg: ASbGnctRF+MtbYbQbt4+ich553GDe2gF/Jwfc7wsSYjQCMkerwJcO1rnp3677ivy0Xh
	ulv2NVCay7AOu3PIe73BjG7DT7lOqS6w6pWO05Rx5yeqh27JOCOx7SOxlwYqiuGX9dcosBkKOSl
	4PbH2zEjaxPsGUs7ooiPefVMdEULnrVEiq4umCIC58rfbXtz7oz8WS8fP6bRPvHmuw+WmK4JiJ1
	jBD1uL94yDuALVdAsOf9RF6b/6cMN8CFd5GhbZbH6QGWDRcANUDtxTrAOY9bZdSSoxVsh/Mlf26
	UCx4C2LSEN2S08JcjcXFUjmACeK5fanPs/m+ahXtSKRCrUsH5qd5YE8hHtSXGItFfCzJr71c9Fb
	n92tO3fdU0cvH7LJ5RlHxMkM6HbioS8keV7MYKVV6gQLi4LvJTHe9unINqSZBBS0AMg==
X-Received: by 2002:a17:907:868e:b0:ac2:c1e:dff0 with SMTP id a640c23a62f3a-ac38d405dc7mr128282866b.19.1742250221560;
        Mon, 17 Mar 2025 15:23:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnx3tTbnPNibxhllxurHdd8mGoxavBaNeUmJVl8iuJ7TCzMANf3gUFSzFxuhrkSoc2i9Y1tA==
X-Received: by 2002:a17:907:868e:b0:ac2:c1e:dff0 with SMTP id a640c23a62f3a-ac38d405dc7mr128281266b.19.1742250221123;
        Mon, 17 Mar 2025 15:23:41 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314aa6083sm726182766b.182.2025.03.17.15.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 15:23:40 -0700 (PDT)
Message-ID: <de3969b9-7134-4bfd-bc65-9d5b7e53a31c@redhat.com>
Date: Mon, 17 Mar 2025 23:23:40 +0100
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
 <76c57b22-04d3-4331-a10c-b210db5f9055@redhat.com>
 <9da24c58-25ab-4b21-b0ed-f777970affe7@tuxedocomputers.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <9da24c58-25ab-4b21-b0ed-f777970affe7@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Werner,

On 17-Mar-25 6:00 PM, Werner Sembach wrote:
> Hi,
> 
> Am 17.03.25 um 12:58 schrieb Hans de Goede:
>> Hi Werner,
>>
>> On 11-Mar-25 19:06, Werner Sembach wrote:
>>> Currently only F23 is correctly mapped for PS/2 keyboards.
>>>
>>> Following to this table:
>>> https://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-923143f3456c/translate.pdf
>> That is a very interesting document, good find!
>>
>>> - F24 and Zenkaku/Hankaku share the same scancode, but since in real world
>>> Zenkaku/Hankaku keys seem to just use the tilde scancode, this patch binds the
>>> scancode to F24. Note that on userspace side the KEY_ZENKAKUHANKAKU keycode is
>>> currently not bound in xkeyboard-config, so it is (mostly*) unused anyway.
>>>
>>> * Qt on Wayland and therefore KDE on Wayland can see the keypress anyway for
>>> some reason and it is actually used in a touchpad toggle shortcut, but this is
>>> currently being fixed in both KDE and xkeyboard-config to make this less weird,
>>> so it could directly be fixed to correctly handle the F24 keypress instead.
>>>
>>> - The scancodes for F13-F22 are currently unmapped so there will probably be no
>>> harm in mapping them. This would also fix the issue that some of these keys
>>> can't be mapped as the target from userspace using the `setkeycodes` command.
>>>
>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> Thanks, patch looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Thanks for reviewing.
> 
> Should I resend the patch standalone because the first of this Patchset will likely be rejected?

I think this one will apply cleanly without applying patch 1/2
first, so no reason for a resend / v3 AFAICT.

Let's wait and see what feedback Dmitry have once he can make
some time to take a look at this.

Regards,

Hans




>>> ---
>>>   drivers/input/keyboard/atkbd.c | 12 ++++++------
>>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
>>> index 3598a21d9d014..4bd6e6ef0715e 100644
>>> --- a/drivers/input/keyboard/atkbd.c
>>> +++ b/drivers/input/keyboard/atkbd.c
>>> @@ -84,12 +84,12 @@ static const unsigned short atkbd_set2_keycode[ATKBD_KEYMAP_SIZE] = {
>>>   #include "hpps2atkbd.h"    /* include the keyboard scancodes */
>>>     #else
>>> -      0, 67, 65, 63, 61, 59, 60, 88,  0, 68, 66, 64, 62, 15, 41,117,
>>> -      0, 56, 42, 93, 29, 16,  2,  0,  0,  0, 44, 31, 30, 17,  3,  0,
>>> -      0, 46, 45, 32, 18,  5,  4, 95,  0, 57, 47, 33, 20, 19,  6,183,
>>> -      0, 49, 48, 35, 34, 21,  7,184,  0,  0, 50, 36, 22,  8,  9,185,
>>> -      0, 51, 37, 23, 24, 11, 10,  0,  0, 52, 53, 38, 39, 25, 12,  0,
>>> -      0, 89, 40,  0, 26, 13,  0,193, 58, 54, 28, 27,  0, 43,  0, 85,
>>> +      0, 67, 65, 63, 61, 59, 60, 88,183, 68, 66, 64, 62, 15, 41,117,
>>> +    184, 56, 42, 93, 29, 16,  2,  0,185,  0, 44, 31, 30, 17,  3,  0,
>>> +    186, 46, 45, 32, 18,  5,  4, 95,187, 57, 47, 33, 20, 19,  6,183,
>>> +    188, 49, 48, 35, 34, 21,  7,184,189,  0, 50, 36, 22,  8,  9,185,
>>> +    190, 51, 37, 23, 24, 11, 10,  0,191, 52, 53, 38, 39, 25, 12,  0,
>>> +    192, 89, 40,  0, 26, 13,  0,193, 58, 54, 28, 27,  0, 43,  0,194,
>>>         0, 86, 91, 90, 92,  0, 14, 94,  0, 79,124, 75, 71,121,  0,  0,
>>>        82, 83, 80, 76, 77, 72,  1, 69, 87, 78, 81, 74, 55, 73, 70, 99,
>>>   
> 


