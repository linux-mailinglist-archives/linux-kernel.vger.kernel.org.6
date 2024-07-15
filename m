Return-Path: <linux-kernel+bounces-251968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC99930C52
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 03:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08EA1F21502
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 01:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516595221;
	Mon, 15 Jul 2024 01:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKOVGZvI"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3209F33FD;
	Mon, 15 Jul 2024 01:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721006019; cv=none; b=RIe8tHYX9G9uT9yH1f1uQr/8cjg2XVX2w6NTxSj9WLghmz5WmC6GQf0f3846F3QIwXs420S0HYsaT3ma16dmac9k2LNaL8qVqYkHWUgpo3myKB5r1zqfxPbB8LJaw0fpYkn4N+OEXTPvaALiHQZD9xJfUrfmc1bWQ8yApRFpCJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721006019; c=relaxed/simple;
	bh=0tiVr9ft+d4VW7URz78aiory/DaoxqUQ82WWaUeM+is=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmxKBK1/JMaboMJbGFy3Fq8JvlJATanJ3uPTpH5jE50cX83gNoInl4Sfv9e7hTV9eJBMuDnWijw3Ed02oCHyBrk3p5asIPxgsHt285IeA4L6Rt3G3H7pXDrJpWdxqYxjwthn5Jz4NtfFFewpZgtWkSr1nAuGr81Fy8LM4jz1nqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKOVGZvI; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-70df2135426so1979803a12.2;
        Sun, 14 Jul 2024 18:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721006017; x=1721610817; darn=vger.kernel.org;
        h=content-transfer-encoding:fcc:content-language:user-agent
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ab0RdrpdYQHbvAaboTyyMMeYzOEBKTbZYrr/Psc2s2U=;
        b=RKOVGZvIOV2Ka3+plSJJFzZcs8DYjFRx8vBUULMRM3NPJxE+v1ocXXfOzYE/rWTTwb
         AT4ei0e7WYLM1qZaYsFv3owBrCCjBMDQpQudX8X586iZdDVqR8LbToz/aSl6XQfiN8L9
         3B7vX0TBXOygbEZvjIh0SM1lvLJSIWZMXqMjNO7m6U845G7sAuzFpl5sXxS32IVwMp6O
         krKbf/5Qzv5LhhmXLJ7gZWueDQaDzEv739vpLd6zVDPL0L6ryuRwydvYck89J0H6uVRk
         oYI83+/BgOABOThR34xoSbk1C2Hvu9ejbw3Q7UeveXh3VsYtvfLUgdZ+HRgXZoN8qdFA
         B4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721006017; x=1721610817;
        h=content-transfer-encoding:fcc:content-language:user-agent
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ab0RdrpdYQHbvAaboTyyMMeYzOEBKTbZYrr/Psc2s2U=;
        b=VaZp2qgsMBIPEJfjAsYrxFojxrkG/GtTrXG0kLWpGn2J6ofXZODaA/Xw6SU0aJewr0
         ml985KFuqjAHamOfzbkZJD5yZQSWrIGiBjduXE/1py22aNqVi2/rUcTbV7JhDLd7gVSs
         A9AEsyg+2KE19gd2/SNQLr2lbxKKXmuMyronpof0ydeSho9eyU6py0zienPasvG3W7Pr
         r9WC14+ZU+yQaZhnqS9mtiXj7NZ0s0GVutyFOilCPydg+CNnkkMfGt1HUiNhDIA/i3jD
         qsnlpIK8BBcdKZHrn/+MpSNllVWE7IA72P5t807PXJHPD5fhIEWn1fKu/yJiWuifS5d/
         pG4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIyKKgFUEBMc0CRSDJ/natsjjwalsoTNqqqdoktdp+Qq0PW1u38eOo7l5nG9XVvIab4/Ictkf7Gayw7uUtQH9VoeNp40FAciRcHevxKQwGBKNJ8X6aPDObsfZht7OLWDXg7xoV4iUZ
X-Gm-Message-State: AOJu0YwphCr32m6dIQPjjg6etUpCHIWTy1/yyLZVhxZjDmvqkOQIqZYp
	EvK4bhFy39sV0j2BUoZmA9JJNvJNZc6XK9YidzXZuZtk/hn8KFPF
X-Google-Smtp-Source: AGHT+IHgZG1Z4tS58RVhBhcyC6w59l8QMeEQ6gnMAJuMQfC9XNlQPiHR8pyP0jPDsktx8TjSIEI9Uw==
X-Received: by 2002:a05:6a21:99a1:b0:1c2:8e77:a825 with SMTP id adf61e73a8af0-1c29820ed74mr18385956637.3.1721006017373;
        Sun, 14 Jul 2024 18:13:37 -0700 (PDT)
Received: from js-pc.. ([2408:8453:34:fd09:b556:142a:5aad:f587])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb6fe52sm28761475ad.21.2024.07.14.18.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 18:13:36 -0700 (PDT)
From: Hongyu Xie <xy521521@gmail.com>
To: stern@rowland.harvard.edu,
	xy521521@gmail.com
Cc: gregkh@linuxfoundation.org,
	oneukum@suse.com,
	brauner@kernel.org,
	jlayton@kernel.org,
	jack@suse.cz,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiehongyu1@kylinos.cn
Subject: Re: [PATCH next] usb: usbfs: Add reset_resume for usbfs
Date: Mon, 15 Jul 2024 09:13:30 +0800
Message-Id: <b15d0ba0-e133-4df7-8371-a701ec5005fb@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8a16e1c2-fd59-4279-8b36-806a214385b6@rowland.harvard.edu>
References: <20240711084321.44916-1-xiehongyu1@kylinos.cn>
 <527927b8-9475-47da-bf2b-7a5d9e81e470@suse.com>
 <a782c5bc-fc8b-43ad-9c6e-1e6799243364@kylinos.cn>
 <8a16e1c2-fd59-4279-8b36-806a214385b6@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;
 attachmentreminder=0; deliveryformat=1
X-Identity-Key: id1
Fcc: imap://xiehongyu1%40kylinos.cn@imap.kylinos.cn/Sent
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

From: Hongyu Xie <xiehongyu1@kylinos.cn>=0D

On 2024/7/13 10:22, Alan Stern wrote:=0D
> On Fri, Jul 12, 2024 at 11:10:57AM +0800, Hongyu Xie wrote:=0D
>> From: Hongyu Xie <xiehongyu1@kylinos.cn>=0D
>>=0D
>>=0D
>>=0D
>> On 2024/7/11 16:59, Oliver Neukum wrote:=0D
>>>=0D
>>>=0D
>>> On 11.07.24 10:43, Hongyu Xie wrote:=0D
>>>> During hibernation, usb_resume_interface will set needs_binding to 1 i=
f=0D
>>>> the usb_driver has no reset_resume implimentation. The USB interface=0D
>>>> will be rebind after usb_resume_complete.=0D
>>>>=0D
>>>> Normally, that's fine. But if a USB interface has a matched kernel=0D
>>>> driver, and a userspace driver or application is using this USB=0D
>>>> interface through usbfs during hibernation, usbfs will be=0D
>>>> detatched with the USB interface after resume. And this USB interface=
=0D
>>>> will be bind with a kernel driver instead of usbfs.=0D
>>>>=0D
>>>> So add reset_resume to fix this.=0D
>>>=0D
>>> The device has lost all settings, yet we continue like nothing=0D
>>> changed. That strikes me as a very bad idea. If a device has undergone=
=0D
>>> a reset user space has not requested, we need to return an error upon=0D
>>> the next interaction.=0D
>> Sorry I don't understand your concern.=0D
>> When will "a reset user space has not requested" happen if there is a=0D
>> reset_resume in usbfs?=0D
> =0D
> That's what a reset-resume is: a reset that occurs when the device is=0D
> resumed, rather than when the driver has requested a reset.=0D
Right now this reset_resume did nothing, it's just an empty function to =0D
prevent rebind after resume.=0D
Maybe I should filter out usbfs in usb_resume_interface when setting =0D
needs_binding to 1?=0D
> =0D
> Alan Stern=0D
> =0D
>>> I am sorry, but this implementation has some fundamental issues.=0D
>>>=0D
>>>   =C2=A0=C2=A0=C2=A0=C2=A0Regards=0D
>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Oliver=0D
>>>=0D
>> Regards=0D
>> Hongyu Xie=0D

