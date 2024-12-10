Return-Path: <linux-kernel+bounces-439073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1030D9EAA71
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A54164E44
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CAB22F393;
	Tue, 10 Dec 2024 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOqncbPV"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780E3194C6A
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733818800; cv=none; b=le0IQ9piVLyNWsDYhrmbTAYtBzSg2BDafpO3rO68u/BPZlZsZ66O5eOCxeXbOwjiu5dbZlRmOCNzKbx+bGHn0vns7KMK0ULa1vH3/Qs8Hj0LNnS3qpT7MkhzPH68I2tX23k3ahlVSJ0GR7gTa6rLjFHHjckMgq65RQsUrM71Dyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733818800; c=relaxed/simple;
	bh=TunENvFQJiKL5QJo1q95dGaqMkvvGwRGcugQyrvJlbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Fvi2EgKZJ0TpnVkSqzEKWnZQ+ERWHD1IHYVzBK02ypAk97qcSEHfXvGIoT5tMZyLNfTjbUcg0qYMPUa7Zx4Maz2r/QtrzvXzJi9txS06/o93Rre1ScPVLbtOxLnfd88I8Fa3D1bqkYERQTbm0hxilVgeNrIo/YwfQRwmpj+lp18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOqncbPV; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-85bb13573fbso1651115241.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 00:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733818797; x=1734423597; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEo0hKBPA1+uR11BjTf4XYs+5QTI3Psjbtshgr0vOTo=;
        b=SOqncbPVe3YSdHrhR6+HcZ+8lmklehJ91roy9ZXzPZ9EzXyX6sDVRGGuon8q1xY2H4
         +QCeJt48eZ/YUfuMO5cx3oe6sLh+zqP6g24UAzPisut3zaQRLzwT6IE2O+e/852ukC3F
         EBG5p3Q5mnmYs/5Cj1bA1LpYBZwm/Yr9JvjF2spsSC8qSs8mnkJmQ66zgYH3u63brlRK
         tB6RxGEQcoGMh/4HMP+T4Ubo2fmD7QHAvmvVXDjJhkaOJB2yVB6+WQ6cGQ/agpFRkzrU
         up4bHBZJG6wjzWzuIRcknXVb6eQs/6IKXI/196czlALVmmo31f1rB7uNX4aAI7JqfZ+a
         hl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733818797; x=1734423597;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEo0hKBPA1+uR11BjTf4XYs+5QTI3Psjbtshgr0vOTo=;
        b=jZ/24fETHV3aVSL4Qu7bbv2kzWkJ8TZ5g41AjiUvlNmlovt/TxTgBdFN4Adrs1fa9M
         0QJNqqzpy9DpRwcXUz5x19gS//VZxXvpCw7GTaDngJDHP4Jd7r6WT2/gsyptpMJoJoc/
         7d0LjHYpwffhB0cAJFKK1+9tvAUlMciakafYETdcu4vD2gTCTiAGxAUs36rumy5EZrGp
         LoBmqFrSYKSYdZ2CnWLTSGJ5Mbo7fIwNjuyQpaGDGwE9ZRPKKB5UcPG6LPjh4PzeuPB+
         ZZ43oM0qSgq2fT1z5ymDiiWdMKFTXjeGSZxBasQZmeY8SAI1BsetxKRGF/2gbw0VpgTG
         knbg==
X-Forwarded-Encrypted: i=1; AJvYcCWLPjfSB/j5qVgSv20FE9e1hOHoaMhXZH39Q7BxAWTZsbese9t8F1DKC6frFDBQaw3LtIpjM6AIWJkc8no=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZMs6Rrzt2DacF+l8iQUgT0+WetNwmGCcgRXFhBqGkWTOMHocT
	kYtA1wtzangLxLs5LuydQX1DRJE7Fxhiy5GrTOQAVeknB/etwPqy2VGIjA8wsUiwyJpW61NBVIt
	ivlLVtWHLJamN94kGoAlTnHu310P7cQfw
X-Gm-Gg: ASbGncuzZdWuu8+yKDa1EUmotV16KbUsc6YcPV6x34a2XP7mK/g+AedGqRr3aHKww4c
	R2jT7XqXKu5/VpmTzYK2w3poVyA6WDMWz+g==
X-Google-Smtp-Source: AGHT+IG+hVeBegbnA0M7wa+CsxkxSZAxQ/DD0FYTrBQBJHehz5AZ5+0JG/HMloo0neD/Br9tZ0hlmNLz5JLdKCAo4j4=
X-Received: by 2002:a05:6102:162b:b0:4af:b546:51f with SMTP id
 ada2fe7eead31-4afcaa4398bmr15061797137.12.1733818797349; Tue, 10 Dec 2024
 00:19:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20200720150715.624520-1-vaibhavgupta40@gmail.com> <20241207011316.GA148867@workstation.local>
In-Reply-To: <20241207011316.GA148867@workstation.local>
From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Date: Tue, 10 Dec 2024 09:19:21 +0100
Message-ID: <CAP+cEOPs7v3ULnWHgP=_drEpu3GMiQgaNA5tatnZ8rU2qyt5Qg@mail.gmail.com>
Subject: Re: [PATCH v1] firewire: ohci: use generic power management
To: Vaibhav Gupta <vaibhavgupta40@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 7, 2024 at 2:13=E2=80=AFAM Takashi Sakamoto <o-takashi@sakamocc=
hi.jp> wrote:
>
> Hi,
>
> On Mon, Jul 20, 2020 at 08:37:16PM +0530, Vaibhav Gupta wrote:
> > Drivers using legacy PM have to manage PCI states and device's PM state=
s
> > themselves. They also need to take care of configuration registers.
> >
> > With improved and powerful support of generic PM, PCI Core takes care o=
f
> > above mentioned, device-independent, jobs.
> >
> > This driver makes use of PCI helper functions like
> > pci_save/restore_state(), pci_disable_device() and pci_set_power_state(=
) to
> > do required operations. In generic mode, they are no longer needed.
> >
> > Change function parameter in both .suspend() and .resume() to
> > "struct device*" type. Use to_pci_dev() to get "struct pci_dev*" variab=
le.
> >
> > Compile-tested only.
> >
> > Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> > ---
> >  drivers/firewire/ohci.c | 43 ++++++++++++-----------------------------
> >  1 file changed, 12 insertions(+), 31 deletions(-)
>
> Although it takes a long time since the patch was posted, I applied it
> now to for-next branch with my handy changes to optimize to v6.13-rc1.
>
> I still have a slight concern about the operation specific to powermac
> platforms, however let us fix when receiving any reports from the users.
>
>
> Regards
>
> Takashi Sakamoto

Hey Takashi,

Thank you so much! One more step closer to getting rid of legacy stuff.

Yes, I will also keep a look on the mailing list for if someone
reports an issue.

Best
Vaibhav Gupta

