Return-Path: <linux-kernel+bounces-513090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C3DA3417F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C3B3ACB36
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D97124292D;
	Thu, 13 Feb 2025 14:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jGBtmAOT"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1841C22154F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455619; cv=none; b=JnRLtI3ROX4IOPYbyyGykPjI5CVlxfnxRC7wXEr1DWD1hLrdot6t+dboEYDleVumGQQDXg5gxIvVufQh+AehpqlXBEDxEjg9QvtaL/YRtmd0ggR2HZLxyr0pp1ER+I+AB01Yrr6SyY7NKAah8Y8dayqD6qi65RnvmhkWcG3XDao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455619; c=relaxed/simple;
	bh=RhLnZ4v0ULKWu0iDwJ0sh3qj5XEB/ULxdttsDFS1KZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGQoDSyyESaXouiAGw4dU9urHcp7q9flQR+o+cQyeQiLlm/lafpLUc6oZrbnOA7lnk5CC0wDepRftK2wTrK5bsAubo8sqh2a8y6EFgUp1Cs5aoA51yr6zILm8PxNpfP4EeOg4O5UmUgqIgvs38n7K6/DKZFkexTFHfJPwqmiP80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jGBtmAOT; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e46ac799015so718897276.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739455616; x=1740060416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+s+afruOes/BeN3oETSozjf5b7KtJvFcnsAPWmxBXE=;
        b=jGBtmAOTh3l67r1MgaI3mBZy/RhqISfjGT4PcnhGD7V7Vf7uUlAsYY3BnrspP5G3XF
         KfV/QB4hnIfWYWxiOtPesPduvrR+/QeTRxenvXaSLxy/0v8Y1N8YHM7AxLAW+J6QmWZJ
         5fUIq0KZpViP9z+vPmUgIgFgXFxncPAhotgDBDKK9vIkA5YzZUC+FDECkbdI5Xl1dBRX
         fEY4l4rtSfJQx5guiKE/PayDqFnEf85lDaMFegEXBfCVyqZUyiI1ZEft5DQf5X2oGEIw
         B776jlUaDlmCxVStHNih5qLzHhjgD8G9tf6b9Jj5rlrNxbV0OYM8EFX8X6K/tOgXoZSk
         e04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739455616; x=1740060416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+s+afruOes/BeN3oETSozjf5b7KtJvFcnsAPWmxBXE=;
        b=FQqd8Wxh/L8Gqb4tmAbRhZxM42QVTk/1tRYwQnY4IFwFJV7bs4WymS17L9Iw+swcP9
         tLlDnFPONeC2TtYAggvlq7aYHKLk6kklIEmOEHRMT7bxR1hzKpf/6f7Cq5rP9clP17tF
         tMGvvr/sP5hDs07prbAeAuHUAUdoxTYtREgjsSliqKmaPm4GWmieid6OHSnSqY++ekyF
         ZsSPBd8HS+k6YF6uLaR7jVUBXku8XU3eOBeyhDoVMHLxdi+10pRPRK7mSMKEG+FHwWEd
         jvraJzOCo4NWsobDRjYR3zgY7OknCY89BtaOoyV0/tA+1s+YsUaA/f3pWjCuBDVbiSb0
         +l3g==
X-Forwarded-Encrypted: i=1; AJvYcCV4lR1jwwV4WDiQ7DtHbSropHkZCyny8EwrY1ZdZp+9E2ZhtCqzXU7z+sDi2rp2bYSB9TTxJ0zvM8W0So8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya4QwnerYx176MhS0HGMAP7nWN/MBKWhDYQdv29egK+vaFagDP
	4ouD3H1mDv3xuk0yjshYHDiUQrhYrCInZbo/7zHgH0OQW/drFyFMsSREgbha+n2BHs/xpCW/tpE
	pk8S06/KgTaCCGJm0DOyKBQVlptvJ+TTmj4zt
X-Gm-Gg: ASbGnctW9G1KSKQuJJbU6fi3dcEQwkAD4FLJxor5ydTf6J1W8PAOIYBEpuxOb+3FiIf
	XyNk4t+gcF/M9Pce0xe3Cd5yfohWNTAATGtvF2N3cG6yv0mHY5Xp1LBLHXS/yNM6VcIwgLw==
X-Google-Smtp-Source: AGHT+IHp4oKPpDwKn7fG2TZzfyhaRjClxyo44F1t8DHE32SHPkpBM0l/RG3OXzwrkmmXl3IBHPn6cwzhD7yCo0ce5l0=
X-Received: by 2002:a05:6902:168c:b0:e5d:a934:701e with SMTP id
 3f1490d57ef6-e5da9347252mr2175525276.45.1739455615450; Thu, 13 Feb 2025
 06:06:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213114400.v4.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <2025021352-dairy-whomever-f8bd@gregkh> <CADg1FFdez0OdNDPRFPFxNHL_JcKmHE6KNxnYvt4sK7i+Uw6opA@mail.gmail.com>
 <2025021347-washboard-slashed-5d08@gregkh> <CADg1FFdbKx3z+SPWFmY4+xZmewh0MnnZp_gmYEdY0z-mxutmEw@mail.gmail.com>
 <2025021318-regretful-factsheet-79a1@gregkh>
In-Reply-To: <2025021318-regretful-factsheet-79a1@gregkh>
From: Hsin-chen Chuang <chharry@google.com>
Date: Thu, 13 Feb 2025 22:06:28 +0800
X-Gm-Features: AWEUYZk7KS1Z1NcVHtfdSpQsvsw9_eZGxVqxrJuVNvRinHaH1zuC1_kaAxufDe4
Message-ID: <CADg1FFf5hGrMM8fxiKFF5ZqEMZbsJzByp6+VuaXjJZnDPN2oUg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] Bluetooth: Fix possible race with userspace of
 sysfs isoc_alt
To: Greg KH <gregkh@linuxfoundation.org>, luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ying Hsu <yinghsu@chromium.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 9:45=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Feb 13, 2025 at 09:33:34PM +0800, Hsin-chen Chuang wrote:
> > On Thu, Feb 13, 2025 at 8:10=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > A: http://en.wikipedia.org/wiki/Top_post
> > > Q: Were do I find info about this thing called top-posting?
> > > A: Because it messes up the order in which people normally read text.
> > > Q: Why is top-posting such a bad thing?
> > > A: Top-posting.
> > > Q: What is the most annoying thing in e-mail?
> > >
> > > A: No.
> > > Q: Should I include quotations after my reply?
> > >
> > > http://daringfireball.net/2007/07/on_top
> > >
> > > On Thu, Feb 13, 2025 at 07:57:15PM +0800, Hsin-chen Chuang wrote:
> > > > The btusb driver data is allocated by devm_kzalloc and is
> > > > automatically freed on driver detach, so I guess we don't have
> > > > anything to do here.
> > >
> > > What?  A struct device should NEVER be allocated with devm_kzalloc.
> > > That's just not going to work at all.
> >
> > Noted. Perhaps that needs to be refactored together.
> >
> > >
> > > > Or perhaps we should move btusb_disconnect's content here? Luiz, wh=
at
> > > > do you think?
> > >
> > > I think something is really wrong here.  Why are you adding a new str=
uct
> > > device to the system?  What requires that?  What is this new device
> > > going to be used for?
> >
> > The new device is only for exposing a new sysfs attribute.
>
> That feels crazy.
>
> > So originally we had a device called hci_dev, indicating the
> > implementation of the Bluetooth HCI layer. hci_dev is directly the
> > child of the usb_interface (the Bluetooth chip connected through USB).
> > Now I would like to add an attribute for something that's not defined
> > in the HCI layer, but lower layer only in Bluetooth USB.
> > Thus we want to rephrase the structure: usb_interface -> btusb (new
> > device) -> hci_dev, and then we could place the new attribute in the
> > new device.
> >
> > Basically I kept the memory management in btusb unchanged in this
> > patch, as the new device is only used for a new attribute.
> > Would you suggest we revise the memory management since we added a
> > device in this module?
>
> If you add a new device in the tree, it HAS to work properly with the
> driver core (i.e. life cycles are unique, you can't have empty release
> functions, etc.)  Put it on the proper bus it belongs to, bind the
> needed drivers to it, and have it work that way, don't make a "fake"
> device for no good reason.

Got it. Thanks for the info.

Hi Luiz, I will work on v5 to make btusb resources managed by device.
Any concern?

>
> thanks,

>
> greg k-h

--
Best Regards,
Hsin-chen

