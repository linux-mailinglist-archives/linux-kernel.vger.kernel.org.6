Return-Path: <linux-kernel+bounces-252756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E143D9317BF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E831F22728
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A5518F2F3;
	Mon, 15 Jul 2024 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ztf7ba2X"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017ABF9EC;
	Mon, 15 Jul 2024 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721057831; cv=none; b=MkIzp0vehXvTb/t++1xZT4F2m/4LgLBYKYL/XLYG7bE89SLtMJY4Nq9flvPqOsk1SlAIy7EL63UpV+kHGhEV3gVziG02+VuZ4tdUjblmKIcIOqpsKGe04ZVH/Q5X34EatijGp+vvfyHPjoGozNHT8i81OSxbn6sQI3iTxkcMZug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721057831; c=relaxed/simple;
	bh=Ue9shyEccR0D4NLMAteVg9HVOTZiJlHb7sLKGHu5KGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRKbVjGYFF2yHl3hyT26j+JRyX3sTVB9JY8vIVJrdmqMaw4+z0J4B091JVsFkGhDVih4LGlTzIfzrqi1EupR4AU9jS/8pe8u6X0H1bxuBK5jRR2jSGR26+0r09LLNn2oKZL0mlBkuFBDo8MN7sp9aFvF0VfhqdkSsxgvg6IKwiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ztf7ba2X; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4f2ee3be492so1291525e0c.0;
        Mon, 15 Jul 2024 08:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721057829; x=1721662629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArOIKD7pHlC5ql37eKTHjT262T0caK8pKp7AZIE6P2g=;
        b=Ztf7ba2Xa/FK+qWMv6wu1YIK0zc8DwOCLymPkwyN7xk/xkRB/Y8zm/XHdgnYGeusnr
         JP0ARP8LWOUJftYcu8Z4F6S4WyDISoPggY2gobvdVnV6ndbFOG5sWfjn3u7EO7Qe1iai
         K2eTDcGcJf0x3rHplWeuvDxeY6aU1f/1LjhINi0aJpmWSIpx6ty0q5Hr2VFR2aqPS4b6
         CZQnp3Hp9U7I94SbyhGki7KcSZJ6e+yypU/4boigwUFMJHBMVosl1ZOxBZ0cRxDi/kAO
         l+nuGwIkRjRl9IcmaWXNMR4lBYGVU28rkSunp/Xa2Wugshd5jjG2/oK9yaSacHo2RdiL
         gvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721057829; x=1721662629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArOIKD7pHlC5ql37eKTHjT262T0caK8pKp7AZIE6P2g=;
        b=eq3rFMzeFldCiWKzePCnM0Nn1bSqqqUwGAhb8zaAJMuvWq4UDqssBVMJY8aieDJYs+
         hZpAdjp7UWCQnuZY3ZPLEgv/cDqn/zg1VPwVFxvT2NFdCqfGlsp646ET/3pyM8LuTIAt
         PjDn6k7Cba4hO8r/j22k2NdjhvhQJADtDOpIJqDKWeetmnrHIzqKd1VmoAp8OBzit/Tx
         aT8jLpmy/cdvfBVuiOPq7mzes9w6vorE0XF5Q3eDjUSXsK7ZCO5LyU7NvQf9E2/qJHQK
         V84w7LnhVIT6Ykw+I+1wCr1ITMHuIdTS/whBxN/Tho8gdvaipW4SRQCIAkTLiuWI2Wq7
         ISmA==
X-Forwarded-Encrypted: i=1; AJvYcCUKL2GYp5qfOoXJM+5sTZ7lTKMnQ0vsQthExxrRttFw7w1uZNO8RDC2jO9tdqmhSH/Z9dmdnc3hp4K9aVRDXhfSqMXoENmR7aHon/XUx2aQwKSIEwz4Y4IVV6KKo32+lIFOn3lDqemM
X-Gm-Message-State: AOJu0YyhE2f5jSlEJIg/FxJQnTHhTpLVVaXOXdQM6hQItFC6v450txTm
	eWEU7RwxuASGCKp9sQV7wihpzxPP+0ZNQ4OnHEUO2gWS1ekezfNJ5I9SybnGJrIgw/HuOW/MqTk
	Q0TF4VTLsJkS2gATd8NXkwKrwTK0=
X-Google-Smtp-Source: AGHT+IHynsSEDIWYpIz5Okhvtk+ZuNA2LvL6tTH2oOnecRTIUi1tcEAmS92HFnG2upt9gnk9ocH1U1yxsKLLzscsTiM=
X-Received: by 2002:a05:6122:3d15:b0:4f3:799:8b91 with SMTP id
 71dfb90a1353d-4f4cd37d756mr273119e0c.9.1721057827233; Mon, 15 Jul 2024
 08:37:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710231606.3029-1-ryanzhou54@gmail.com> <f0c789d8-8ae0-4a46-a5b3-aa9a5a758915@rowland.harvard.edu>
 <2024071104-rental-bleak-b273@gregkh>
In-Reply-To: <2024071104-rental-bleak-b273@gregkh>
From: ryan zhou <ryanzhou54@gmail.com>
Date: Mon, 15 Jul 2024 23:36:57 +0800
Message-ID: <CAPwe5ROTfQVQ2fF3ab05E51X+_5zFpSNK-qrEh-ev-WWBzY+DA@mail.gmail.com>
Subject: Re: [PATCH] hid: usbhid: Enable remote wake-up based on device configuration
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, jikos@kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 3:41=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Jul 10, 2024 at 09:47:39PM -0400, Alan Stern wrote:
> > On Thu, Jul 11, 2024 at 07:16:06AM +0800, ryan wrote:
> > > According to the USB protocol, the host should automatically
> > > adapt the remote wake-up function based on the configuration
> > > descriptor reported by the device, rather than only the default
> > > keyboard support. Therefore, it's necessary to support other hid
> > > devices, such as digital headsets,mice,etc.
> >
> > It's true that the host shouldn't try to enable remote wakeup if the
> > configuration descriptor shows that the device doesn't support it.
> >
> > However, it's not true that the host should try to enable remote wakeup
> > for devices other than keyboards with boot-protocol support.  History
> > has shown that quite a few HID devices don't handle remote wakeup
> > properly; the decision about whether to enable it should be left to the
> > user.
>
> I agree, this patch isn't acceptable.  Ryan, why do you want this
> applied?  What userspace control is missing to allow you to do this
> today on your systems with no kernel changes for devices that you know
> will work properly?
>
> thanks,
>
> greg k-h


Many thanks to Greg KH and Alan Stern for reviewing the patch and
replying to me.
I'd like to start by asking Greg KH's question.

A1:This patch is expected to be applied to the USB digital headset,
mouse, and keyboard,
and we expect to wake up the system by operating them when the system
has suspended.

A2:I've verified that user-space control does the trick, but
Personally speaking, it's not a good solution.
For each device plugged into the host, the user space needs to check whethe=
r
it is one of the three and to enable wakeup.It may be better to enable
wakeup when loading
a HID class drivers, from my perspective. Could you please give me
some advice if possible.

I have spent some time studying your responses, and learned a lot. I
absolutely agree with many
of your points, but still have some doubts.

Q1 for Alan Stern: Boot device includes a boot mouse and boot keyboard,
why the patch(3d61510f4ecac) only enables boot keyboard by default,
and in addation boot
protocol is used in BIOS,why is it used as a wakeup judgment condition
in the OS?

Q2: for Alan Stern:  As you comment 'History has shown that quite a
few HID devices don't
handle remote wakeup properly'  I consulted the USB20 Spec in Chapter
9.2.5.2 and it has
this description:'If a device supports remote wakeup, it must also
allow the capability to be
enabled and disabled using the standard USB request'  So these devices
that you're talking about
are not compliant with the USB20 protocol specification to my mind. If
so, shouldn't we
support these non-standard devices.


Thanks

ryan

