Return-Path: <linux-kernel+bounces-255922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFEC9346AD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 05:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947D9282FA2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431AC2E419;
	Thu, 18 Jul 2024 03:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD/CBKeb"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0817810FA;
	Thu, 18 Jul 2024 03:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721272995; cv=none; b=En6amxG3XD8f+G+if74aLpR8jY1v0YAPgYTWZwXmR+TMfVdoE98HouXhX+jFOLaKOXGZvkapVt1WOh24+r2sWv1xUh+exG7Bgn3/qOpkd5M3VjVz5Yq/7F/jg3d5SPN1FXkMay4QayPAcUQInLeyB65FbqCGX1V3RcxGGq5DEvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721272995; c=relaxed/simple;
	bh=ocC1OTqw3T1wvfygr2ORlqKY0Usj/NrGbAVbjVYPmEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULygbqytyhRcqDQWVyYIFEXo13J3Mg0wZEfU3duc4yV2fV5sIvsziPwSMAO2nsQuFskENALfUATkK52UswVhBje678LO+88y4vo4yuYBpmikMzhXkIZmSwBHuOPVnOqBcV54dr3l4qrrnMu27apoRX5Ff593nIJ+cjMJ1G4A9d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QD/CBKeb; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5ce739c2650so160468eaf.1;
        Wed, 17 Jul 2024 20:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721272993; x=1721877793; darn=vger.kernel.org;
        h=content-transfer-encoding:fcc:content-language:user-agent
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wmKhCzrI7nozSPGCF6gnN66wwRZauYwlhxHfZZORJFc=;
        b=QD/CBKeb80jsDVtxlgl0tVW9WPuwmQew4tx/ikpV8GRwz3rw0tycRpx7GVjrybrFib
         8lcMKkUpqPtjwF03srlCIkGRSrIbnsvXGuUNe11WQ1LJAjxrrYSOus1eLoDKY2sVM3yj
         vEjR01z/CfRKqE6SQ1INq9ZgHWUfNnOsrTNfAxxw7exu7/RNGzxweJ+hJJEqAVacscUh
         IeNpZ0LA8I4JHfcWfC2Zvd44rnworybvawdlJ0LmRIrqMi1fgl3D63KhIpwAa+EOoBcN
         QSWYmu9CJPxsUCrVAKahW7dMDBOIaVsFrNtPwP5GIdkuhEfoytXcHveqMeGknw/FYB43
         xjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721272993; x=1721877793;
        h=content-transfer-encoding:fcc:content-language:user-agent
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wmKhCzrI7nozSPGCF6gnN66wwRZauYwlhxHfZZORJFc=;
        b=nORbwsHSlA7ziVznCQLJOalac8jGtxKlDhTcc6DTxPs7vm9WFgufvNwxIyUU+k4mPO
         eZTmIkJJ22/Q3MaiPndITfrbXaYgeI22Q+f4Feq788jq2UKNyemCVUZsDCS8/IXmbAel
         JEkL5S+KH9yzV3BmQO/M8PlicXNX3aOC4u5ur8O+plh+JRSOVqPmcuhJ2iXNCIrIvWvV
         kVACwe1eiDY1kp45qSuK6R61MHkjJJ6nlaqLJVIB4x0mZC9P1E9VSnQocy8TjDMRHjX+
         eiGDZCztUb00/d8epWrImpjwxuAeiXGWRDQH6QcaCLHmil6UXMdCtRmTSwMSA2Tx3pXo
         Qemw==
X-Forwarded-Encrypted: i=1; AJvYcCXQEOHyE74tVWrv2laN+kuZ+/9OUVPsbLpbrbJpeWp868hx6JO7lhYu2paoKdWKXOOumXlCb/mLMt8GSn7K/dgRR/TnjyLo9aC7ggHmYFO/rdf1EsutzDfJcw9cmdBAe6nsdT6UfciD
X-Gm-Message-State: AOJu0Ywqji5ZrL+HQpq4VQzkZFClJS2lQsHh60xPlOvcZ2Lh5iUZI7hy
	ZzV9oeHwdWLC8/xdEiqYYlMuTXsADGCUg1v0LapIvZLdF3RoAnN4
X-Google-Smtp-Source: AGHT+IG/ulTlPDzfO2E4rJK0ztjEQZSnQyTBptuASu2KXhLvJ6IJ2s+Sef21KtMIdTTu03BpqcXpcg==
X-Received: by 2002:a05:6870:55d4:b0:254:9501:db80 with SMTP id 586e51a60fabf-260ee7ccf3dmr1221481fac.14.1721272993010;
        Wed, 17 Jul 2024 20:23:13 -0700 (PDT)
Received: from js-pc.. ([116.162.132.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eca7794sm9205580b3a.149.2024.07.17.20.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 20:23:12 -0700 (PDT)
From: Hongyu Xie <xy521521@gmail.com>
To: stern@rowland.harvard.edu,
	oneukum@suse.com,
	xy521521@gmail.com
Cc: gregkh@linuxfoundation.org,
	brauner@kernel.org,
	jlayton@kernel.org,
	jack@suse.cz,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiehongyu1@kylinos.cn
Subject: Re: [PATCH next] usb: usbfs: Add reset_resume for usbfs
Date: Thu, 18 Jul 2024 11:23:02 +0800
Message-Id: <987f97f4-293a-42f0-a9f5-9d67b6db2ce5@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <a648a2b3-026a-445c-8154-2da43b641570@suse.com>
References: <20240711084321.44916-1-xiehongyu1@kylinos.cn>
 <527927b8-9475-47da-bf2b-7a5d9e81e470@suse.com>
 <9ef72886-13b8-46cf-a0aa-54dad36102e9@rowland.harvard.edu>
 <2a80d11d-029f-4e7e-9a8e-3abae1034add@suse.com>
 <429eb27a-578a-4208-8ce1-89434b8d739f@rowland.harvard.edu>
 <3073c8ce-1923-4816-a442-41b4cc333af9@suse.com>
 <6419a4e9-e084-4eb6-8376-9202930ea8be@kylinos.cn>
 <a648a2b3-026a-445c-8154-2da43b641570@suse.com>
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
On 2024/7/17 15:42, Oliver Neukum wrote:=0D
> On 17.07.24 03:43, Hongyu Xie wrote:=0D
>> From: Hongyu Xie <xiehongyu1@kylinos.cn>=0D
> =0D
> Hi,=0D
> =0D
> sorry for being incomprehensible. I'll try to do better.=0D
> =0D
>> =C2=A0From what I know, that CONFIG_USB_DEFAULT_PERSIST is enabled by =0D
>> default. Then udev->persist_enabled is set to 1 and this causing =0D
>> udev->reset_resume set to 1 during init2 in hub_activate.=0D
>> During resume,=0D
>> usb_resume_both=0D
>> =C2=A0=C2=A0 usb_resume_device=0D
>> =C2=A0=C2=A0=C2=A0=C2=A0 generic_resume=0D
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usb_port_resume=0D
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 finish_port_resume=0D
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usb_reset_a=
nd_verify_device (if udev->reset_resume is 1)=0D
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 hub_port_init=0D
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 hub_port_reset=0D
>> =C2=A0=C2=A0 usb_resume_interface (udev->reset_resume is 1 but usbfs doe=
sn't =0D
>> have reset_resume implementation so set intf->needs_binding to 1, and =0D
>> it will be rebind in usb_resume_complete)=0D
> =0D
> That is correct. But even if CONFIG_USB_DEFAULT_PERSIST were not set, =0D
> losing power=0D
> would just lead to reenumeration by another code path. Devices reset =0D
> themselves=0D
> when they are power cycled. There is no way around that.=0D
> =0D
>> Even before usbfs->reset_resume is called (if there is one), the USB =0D
>> device has already been reset=0D
> =0D
> Yes, it has been reset.=0D
> =0D
>> and in a good state.=0D
> =0D
> No, it is not. Or rather, it is in the wrong state. This is not a =0D
> question of good and bad.=0D
> It is a question of being in the same state.=0D
After resume, it's in USB_STATE_CONFIGURED state. But here I'm guessing =0D
you mean not in a good state from user-space's point of view, right?=0D
> =0D
>> After all that thaw_processes is called and user-space application =0D
>> runs again.=0D
> =0D
> Yes. And user space does not know what has happened.=0D
>>=0D
>> So I still don't understand why "the race necessarily exists". Can you =
=0D
>> show me an example that usbfs->reset_resume causes race?=0D
> =0D
> Sure. Let's look at the example of a scanner attached to the host.=0D
> =0D
> OS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Scan=
ning process (in user space)=0D
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1. Se=
t a resolution=0D
> 2. Going to S4=0D
> 3. Returning to S0=0D
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4. In=
itiate a scan=0D
> =0D
> As you can see the system would now scan at the wrong resolution. Step#4=
=0D
> has to fail. As there is no synchronization between S4 and user space, =0D
> initiating=0D
> the scan can always be the last step.=0D
> For this to work, reset_resume() would have to restore the correct =0D
> resolution. The kernel=0D
> cannot do so.=0D
Now I can see your point. And I think with or without =0D
usbfs->reset_resume right now, Step#4 has to fail.=0D
> =0D
>  =C2=A0=C2=A0=C2=A0=C2=A0Regards=0D
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Oliver=0D
Regards=0D
Hongyu Xie=0D

