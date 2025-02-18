Return-Path: <linux-kernel+bounces-518941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B127AA3964A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7B018893C1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1D92343AB;
	Tue, 18 Feb 2025 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NgCyuku9"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B02522FF55
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869088; cv=none; b=GJrY95pP1FqbGCduzGFTA/SlHhGsIvUfghe6jRkF+N9V9LMDTNTS2IDqN8TV5k47hnYgiHE7nMWTJ2EerRe2IGQbnu74EZ/keDQt1He9E4AsVROEmHkYS0+59e19H4/ffep/s3+vGnUdplKjNJDFRU7549EVNednxgJjOAeKVYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869088; c=relaxed/simple;
	bh=OyAnmBjaHUZcFsMsEw63Uv32r7ZHuHh2rGeXIQyNl/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKrVcq+qQLwfsDTHeGtZwgYdBmpkCDNAkvw0Y7IsmlhApHBBwf+fXmhwY0m5eo0xk1DdE9Exwohcj9N+EymMhJkl3v8pljC5RXshW8Idj1r0zRMIcEFpYt1ojuN0/DO9rsqzZiC7/x+Vydu1jXKaFU+NFs2StdHqr2p6RS0jcRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NgCyuku9; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e5dd164f03fso2161321276.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 00:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739869085; x=1740473885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WiV88RuMX52VqCnbJqBbwtStRRNrClMaC5QzgRj89Y=;
        b=NgCyuku9/qgheDn5M4AcDO0rpIQ7we6s2fI+hrP7/IVD1PY+t2eEFUlDgCbvGTAMzi
         lTtn4doq9FOuq/DQaxHkmhTXBL7S4bpaQaggl/pZ2cliWqMD4SQSanwH+TB4znQsDL3g
         3VQ+XW0K1n/TsA5iNsTuf8wdByIahjSgB4lYW1N7xAI1XUa0hBsoxL9ZC1sF72NGmKE3
         1v9tcV1o1bHQr5FKz2ncx96EXW2MTHnmjralRbx6TBZ5aj+rRM3Os5dIaA6fdCY1oOhY
         38MRGx8ZDfq6B5JjPuOUzQ38colL9+v0U5CnHYGeDNJx7xzcVI3xRkFyhFNxgBSFSZrK
         CbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739869085; x=1740473885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WiV88RuMX52VqCnbJqBbwtStRRNrClMaC5QzgRj89Y=;
        b=WH/7GxVXSWIDwNjmim/YSQOvgap5v/tRsJeUKYqTf8Ky2INqXWeH09rMPicSpQcCHu
         Jab6b3583BU535ptNr2cJXF8eMqx0i4XkGhCrgeqtFj2K8ocFRmt2vJtKHZk2CtO09fX
         hNo1Y8znF7NzQ8RNcQyREw7omobKZNG7/YR9jDJw/lacchyj/WJ/Ged5W99FvG0p46Gn
         eQtSqTFB38ZLfnpQ7OCp6FNbwd9BQBpAgjKdsnTuxCsWos8waCnC9TZDsfF4f40MLXmg
         K3l+d2sLE/gHdAsNaUZVuibqwMfuQW0tx1Mb8PKjzYoHOBKOBPLToJ68NFT740e6mCrD
         tLMg==
X-Forwarded-Encrypted: i=1; AJvYcCWvBFY/a42LoAwHT9uVvo7M/4BlXY5ztOS4SJJJWTFmTqKJJ2bMa4oOwfTZBlSwUxq3U3Wt5Td8Jy9Iupw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2bL0jxfgcHDJwndeE+5rMGDnzqFjcKNT+Hh+cy51kljWsbLrq
	96oIqzF+vTjfIh7u5vUI+fr+s0+O+1ckZe+7GK5nNOFQd5xqiQGADasFnT+c2oZs6bDCn6puC8a
	xZafMsbixeL4BZpbxnIX0t88DIJwGjrx0E0VW
X-Gm-Gg: ASbGncsMBBN8AVBJ+GVD/YLVwC20BziRpFLviwtnIi2LWSa/BlsiESpS9aisvKVJEa7
	fcN8+LkmirnnKUuRYFJdYQjOQgE7Ec2f4Mop/1wsjFeOlv9ZGAylFJL066wf9Xn78otlxI8Z3sA
	==
X-Google-Smtp-Source: AGHT+IFDAv+Ww5Ff98rM498LWZrMYVGA7SxrEKpXl53VPNF2TtUIGFalfKMi0kzAC0F6424I9hSryLL8fES2qf4u6tI=
X-Received: by 2002:a05:6902:102c:b0:e58:341d:50d6 with SMTP id
 3f1490d57ef6-e5dc91ed41fmr8784581276.35.1739869085379; Tue, 18 Feb 2025
 00:58:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214191615.v5.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <2025021425-surgical-wackiness-0940@gregkh> <CADg1FFd3H0DLV-WX8jTB1VGyOZYEzchP99QvYxWmg1XCOo1ttg@mail.gmail.com>
 <2025021717-prepay-sharpener-37fb@gregkh> <CADg1FFf7fONc+HJT8rq55rVFRnS_UxnEPnAGQ476WVe+208_pA@mail.gmail.com>
 <2025021829-clamor-lavish-9126@gregkh>
In-Reply-To: <2025021829-clamor-lavish-9126@gregkh>
From: Hsin-chen Chuang <chharry@google.com>
Date: Tue, 18 Feb 2025 16:57:38 +0800
X-Gm-Features: AWEUYZm1tDse1ET3a-jgOK_9kE2iguqODg5oqAc57Y_gfIfAsF1oYPN_93ho47Y
Message-ID: <CADg1FFd=PbnNSBWk4KGV85jvvRQBBGG4QD2VHM6ABY-mqC8+Lg@mail.gmail.com>
Subject: Re: [PATCH v5] Bluetooth: Fix possible race with userspace of sysfs isoc_alt
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ying Hsu <yinghsu@chromium.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Tue, Feb 18, 2025 at 4:23=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Feb 18, 2025 at 12:24:07PM +0800, Hsin-chen Chuang wrote:
> > Hi Greg,
> >
> > On Mon, Feb 17, 2025 at 4:53=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Mon, Feb 17, 2025 at 04:44:35PM +0800, Hsin-chen Chuang wrote:
> > > > On Fri, Feb 14, 2025 at 7:37=E2=80=AFPM Greg KH <gregkh@linuxfounda=
tion.org> wrote:
> > > > >
> > > > > On Fri, Feb 14, 2025 at 07:16:17PM +0800, Hsin-chen Chuang wrote:
> > > > > > From: Hsin-chen Chuang <chharry@chromium.org>
> > > > > >
> > > > > > Expose the isoc_alt attr with device group to avoid the racing.
> > > > > >
> > > > > > Now we create a dev node for btusb. The isoc_alt attr belongs t=
o it and
> > > > > > it also becomes the parent device of hci dev.
> > > > > >
> > > > > > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to =
control USB alt setting")
> > > > >
> > > > > Wait, step back, why is this commit needed if you can change the =
alt
> > > > > setting already today through usbfs/libusb without needing to mes=
s with
> > > > > the bluetooth stack at all?
> > > >
> > > > In short: We want to configure the alternate settings without
> > > > detaching the btusb driver, while detaching seems necessary for
> > > > libusb_set_interface_alt_setting to work (Please correct me if I'm
> > > > wrong!)
> > >
> > > I think changing the alternate setting should work using usbfs as you
> > > would send that command to the device, not the interface, so the driv=
er
> > > bound to the existing interface would not need to be removed.
> >
> > I thought USBDEVFS_SETINTERFACE was the right command to begin with,
> > but it seems not working in this case.
> > The command itself attempts to claim the interface, but the interface
> > is already claimed by btusb so it failed with Device or resource busy
> >
> > drivers/usb/core/devio.c:
> >   USBDEVFS_SETINTERFACE -> proc_setintf -> checkintf -> claimintf
>
> Ah, ok, thanks for checking.  So as you control this device, why not
> just disconnect it, change the setting, and then reconnect it?

After dis/reconnecting, a Bluetooth chipset would lose all its state:
Existing connections/scanners/advertisers are all dropped.
This is as bad as (just an analogy) "Whenever you access a http web
page, you need to bring your ethernet interface down and up, and after
the page is downloaded, do that again".

>
> Also, see my other review comment, how does BlueZ do this today?

BlueZ handles that in their MGMT command, that is, through Control
channel -> BlueZ kernel space code -> driver callbacks.
Once a Bluetooth chipset is opened with the User channel, it can't be
used with the Control channel simultaneously, and vice versa.

--=20
Best Regards,
Hsin-chen

