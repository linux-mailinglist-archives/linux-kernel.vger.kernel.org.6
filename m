Return-Path: <linux-kernel+bounces-254593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5308933509
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 03:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D681C21606
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 01:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AE33D69;
	Wed, 17 Jul 2024 01:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ek3sWB3W"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB7117FF;
	Wed, 17 Jul 2024 01:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721180632; cv=none; b=d/4Bv8dWRsxcOftiKLaywewwdszlgvGCR0KhxCUUProSQMRg4/99BY/LeBAxJtvNFXzBfl1YBoqd4rmp4yQKwnhElDF6nR2jEPL98Z5yTS9XWECpsK3UtvbVzCQBSQBrfq4mXvYkQb9BAHfv6IMtJElBxdVmxS3rnxQutDiCyFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721180632; c=relaxed/simple;
	bh=cmDEuRloobJ18dzvZzxTGqeo3pfTsVhdb8xHIz80QNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N32ky5Acbon2oCTfhRjdbENQyRDweDe6CwTfBKC5myIKKpyUxKELWKIMlFvtfiu2dzezjJc1Mav1dvuAVaf7YR/CUdnCejQdaXdlFy50BJw6SaF/yLKEBr/qY2+HcUrx+3kdZawBSJYaNMbQulnjCgqP0Wtx6EHBXNc+iDGjkdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ek3sWB3W; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-708b273b437so3297470a34.0;
        Tue, 16 Jul 2024 18:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721180630; x=1721785430; darn=vger.kernel.org;
        h=content-transfer-encoding:fcc:content-language:user-agent
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RmwDYdeep5GJOFZw/qEgyPPFqrMPZdXrwL7yQulcuSI=;
        b=ek3sWB3WctLaIX1LHnwwI9AvRSauwk13LE/iS+9CW7K8Z3KR+OfzJi9HvRVjHzoGx3
         MoIpA7xrxs1pGuCxx3pQ63mkBOJwDoqWddOopS7dPqRlkrBeDC3r71aT7XgIdR0hWtJ3
         roNDNdypx7s806rDLWrWvdUVqmjac1BNfVILaj9L11QEvV40kFQc70dorihjSbU8O7Aj
         yISm68c9NOXF+dWyP1W2jMlQ6SbauAU5rNJlJUhTTBuUNofw+lhsb8zJkDEq0mDeLkn9
         PFOsgvhuAOjeMarjn6BeH8rQITUqYC5Ck8QOLH54v9oo56F6tR4MHKDkJH1OimTsAFCd
         VBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721180630; x=1721785430;
        h=content-transfer-encoding:fcc:content-language:user-agent
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RmwDYdeep5GJOFZw/qEgyPPFqrMPZdXrwL7yQulcuSI=;
        b=Rmqpafyguwim9Q9tTLeFf3yIdvAN3/z7YPlNGAP5hCOwqxqMVC+JAlVdOMZWFT4HFw
         jqrocA83CxUPG2b0oGkWc8betZIusG/4sEGwOjeHg8GUx/Jo6qdJUFdJokTiJXQmc2Bh
         UP9fmbeDIZdnZUj+1IzThUDmMsJEGwtCCLjmoSauKBaU5wn4FNkKgCqGEAqNnY7JSemC
         ykMF4z//Y/2C4/2/+W/xjQcBIJa3fv3abutOtYiTI/ng+rUCfive1KKNi4xg6+4Z3QpQ
         j5rqyMa3Hum5IdWvqMLilCtI76U2lFwEclDioZlEYb9iFbnDqWIR+UqljKWNDhme8wCd
         lu7A==
X-Forwarded-Encrypted: i=1; AJvYcCVnQjla57OALVzLaHO48/tNnQAowpRtg9sF7Z2kJHepzqHQXt3VoFuKTq0Cig+FSq9qqdEI4C9uYo29jkRv71PV2/pfVOAKm+rj/SkQ3n4aB+cFfbndIdzEq4t2/NpdaufBvxfOMb1r
X-Gm-Message-State: AOJu0YyX5HsnUeCvelR0D4yxkbYvu4FUEKf9Rg5hza4ROcJJGKskQLUq
	isPH07CFL5a2BwEuD1UhXGrNoYTSTQvFkPSz9OuHlWDkDeXIeJjJ
X-Google-Smtp-Source: AGHT+IExailEPeo6zwb75eK0kxwZxSCnRhpGcfk5hrLTaUErqRNCeQP1p6aR9rrQXpbsQhOlNUOR1w==
X-Received: by 2002:a05:6830:7199:b0:703:5efa:3ce4 with SMTP id 46e09a7af769-708e376741fmr250464a34.4.1721180629879;
        Tue, 16 Jul 2024 18:43:49 -0700 (PDT)
Received: from js-pc.. ([116.162.95.36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eca8c12sm7230360b3a.171.2024.07.16.18.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 18:43:49 -0700 (PDT)
From: Hongyu Xie <xy521521@gmail.com>
To: stern@rowland.harvard.edu,
	xy521521@gmail.com,
	oneukum@suse.com
Cc: gregkh@linuxfoundation.org,
	brauner@kernel.org,
	jlayton@kernel.org,
	jack@suse.cz,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiehongyu1@kylinos.cn
Subject: Re: [PATCH next] usb: usbfs: Add reset_resume for usbfs
Date: Wed, 17 Jul 2024 09:43:38 +0800
Message-Id: <6419a4e9-e084-4eb6-8376-9202930ea8be@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3073c8ce-1923-4816-a442-41b4cc333af9@suse.com>
References: <20240711084321.44916-1-xiehongyu1@kylinos.cn>
 <527927b8-9475-47da-bf2b-7a5d9e81e470@suse.com>
 <9ef72886-13b8-46cf-a0aa-54dad36102e9@rowland.harvard.edu>
 <2a80d11d-029f-4e7e-9a8e-3abae1034add@suse.com>
 <429eb27a-578a-4208-8ce1-89434b8d739f@rowland.harvard.edu>
 <3073c8ce-1923-4816-a442-41b4cc333af9@suse.com>
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

=0D
=0D
On 2024/7/16 20:44, Oliver Neukum wrote:=0D
> On 15.07.24 16:22, Alan Stern wrote:=0D
>> On Mon, Jul 15, 2024 at 10:53:14AM +0200, Oliver Neukum wrote:=0D
>>>=0D
>>>=0D
>>> On 11.07.24 16:41, Alan Stern wrote:=0D
> =0D
>>>> Agreed, but the solution is pretty simple.=C2=A0 Because the device wa=
s=0D
>>>> suspended, the userspace driver must have enabled suspend via the=0D
>>>> USBDEVFS_ALLOW_SUSPEND ioctl.=0D
>>>=0D
>>> The whole system could have been suspended, in particularly to S4.=0D
>>=0D
>> You are right.=C2=A0 I was thinking of runtime suspend, not system suspe=
nd.=0D
>> My mistake.=0D
> =0D
> This is at the intersection of several scenarios. That is a good part of=
=0D
> what makes this difficult.=0D
> In principal I think we could get away with checking for a flag to be set=
=0D
> at reset_resume() before each operation. Elegant this is not. Yet, it see=
ms=0D
> to me like the race necessarily exists and is unsolvable in user space.=0D
> =0D
=0D
 From what I know, that CONFIG_USB_DEFAULT_PERSIST is enabled by =0D
default. Then udev->persist_enabled is set to 1 and this causing =0D
udev->reset_resume set to 1 during init2 in hub_activate.=0D
During resume,=0D
usb_resume_both=0D
   usb_resume_device=0D
     generic_resume=0D
       usb_port_resume=0D
         finish_port_resume=0D
           usb_reset_and_verify_device (if udev->reset_resume is 1)=0D
             hub_port_init=0D
               hub_port_reset=0D
   usb_resume_interface (udev->reset_resume is 1 but usbfs doesn't have =0D
reset_resume implementation so set intf->needs_binding to 1, and it will =0D
be rebind in usb_resume_complete)=0D
=0D
Even before usbfs->reset_resume is called (if there is one), the USB =0D
device has already been reset and in a good state.=0D
=0D
After all that thaw_processes is called and user-space application runs =0D
again.=0D
=0D
So I still don't understand why "the race necessarily exists". Can you =0D
show me an example that usbfs->reset_resume causes race?=0D
=0D
> Furthermore in the long run, if we want to use D3cold in runtime power=0D
> management, it looks to me like we would want a second permission ioctl=0D
> for that.=0D
> =0D
>  =C2=A0=C2=A0=C2=A0=C2=A0Regards=0D
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Oliver=0D
> =0D
Regards=0D
Hongyu Xie=0D

