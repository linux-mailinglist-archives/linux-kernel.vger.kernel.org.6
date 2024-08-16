Return-Path: <linux-kernel+bounces-289738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC583954B3B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24F51C22627
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B931BB692;
	Fri, 16 Aug 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="NqbCeoB2"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B041B9B2A
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815504; cv=none; b=ugoZi8UwIyIQ2KBrilKiagUzYsf4dJUyaVB11VAA1ime/2OgQOGH58g8E/qpLE0U0TawMAO0l0AfOixrevEA/1IofSYabX8mpvaEF9o4vUrfHTTbRRu03394KqIIQBiCJtaD90XBegVe1f3zmoWTe1V2N0jUYXpCUo7+ATI9RPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815504; c=relaxed/simple;
	bh=QCAlw2oghjkltEmxv5i9Ilzo1xh2iP+HaMnE05qA5zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tp+oyKFwABDVWRDJgEt9zOPFB2IeWCbC3JAvDCY12aFGgR80lnKZrLy0kihzhYP1RCLxSJKJsP7PGYpdUWolAU3EkF9SDLfZwboRN1ELtM5ak+YNEN0Y6ixUSdgYMpimGzWwqOdkmoIvMr5fUuCpmzsTzGP1mI2eDxeb4BctZEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=NqbCeoB2; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso2003559a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 06:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1723815501; x=1724420301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=862XZmQiMW9Oj4bvDULTbAVEBtndO7jJky7jaB+8yC0=;
        b=NqbCeoB2RudqjJuE7YOGrfgKvJdGx8LNwEHdEAiHMciVYEFv1M8Jv0RmvAT9VYGyH1
         OLikEmUNOId2FQfqWOLHRKxJEK7pHESr6wm3SUylg9fJiE91PRPdJ/6XhpR/mE+L44q4
         7mTO2slVUfkCti9OXstt1V504vhpaDdA3m8uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723815501; x=1724420301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=862XZmQiMW9Oj4bvDULTbAVEBtndO7jJky7jaB+8yC0=;
        b=OOpeDXTNHjlOfIT3KVe9sOmQh1DGpCfK47MNSOt/sUP8K3CJLWb4IG2mqw0y18SgEv
         gFAczr83FInqPBDbkooyJO4GApa0SaNCxM528ogfULeHBWC45evbvY9K2J6uJOuVIMCS
         dD/gYZly0VmgoSALM0+/g7SLyLbq2vOR2yxYM+O8pzC6R6W6Q0znpHFSQ2BLZrFRG4+H
         e9KLU+ocz8I+ByLNCr9EPnowxTTXII6tzQuraQgcUkOd5vmJljtRCaA4E8ZlFZhIdTqj
         Sgnp33rnJm+6fGHTQhaQwJ8Xqq03dO65xyWxDpRIpPLhd+fWYF5Jyj//Dj+H7YCd/wGD
         xZ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkdezgLkk6SmtIvzTDVPOlLTH20/hW67sAxfvvldaBj4+iTByJlVzew/cGc0CHxe75HomoaPn7T4N4LPidtDgkSHhlyII0VFAq3Ic8
X-Gm-Message-State: AOJu0YxLhbEt1ipi6RswkriIGwX90eEg8wFrGjUWzPuTNDRi3btM5Vel
	g7HJCZNF8wC4qd9oQLJVwgnEtJg1kgB6p50Lw+o1SrDscq3Je2KtvYCwzvSlK1egjHU247Jb69N
	XDd069dc1aYlKNpXDvQ+OsHJ2OvMLRMmdZFzmRg==
X-Google-Smtp-Source: AGHT+IF8kkkqnFsB29nYi5J4Z/UxfYBK80tqZbvVdIA7iIMe4cls3oVhjg9SRgUTjeT8phaUAJ1KjDqBV0NsaWpyK/k=
X-Received: by 2002:a17:907:3d8c:b0:a7a:c812:36c5 with SMTP id
 a640c23a62f3a-a8392a11128mr196622766b.46.1723815500788; Fri, 16 Aug 2024
 06:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TYUPR06MB62177737F0054278B489962BD2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <2024081608-punch-coherent-d29e@gregkh> <CAOf5uwnsgcJjp1=RLa7qx9ScQY5rZvwX-Zu6BOqxBBhBCz+CFQ@mail.gmail.com>
 <TYUPR06MB62177BCD4AB43C19E38990D3D2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
In-Reply-To: <TYUPR06MB62177BCD4AB43C19E38990D3D2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 16 Aug 2024 15:38:10 +0200
Message-ID: <CAOf5uwm65Cw-V+td_=6QAGUF+Uisueqcm0z=1zFaNTisAJnSFQ@mail.gmail.com>
Subject: Re: [PATCH v1] usb: gadget: u_serial: check Null pointer in EP callback
To: =?UTF-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"quic_prashk@quicinc.com" <quic_prashk@quicinc.com>, 
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"opensource.kernel" <opensource.kernel@vivo.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Aug 16, 2024 at 3:30=E2=80=AFPM =E8=83=A1=E8=BF=9E=E5=8B=A4 <hulian=
qin@vivo.com> wrote:
>
> Hello linux community expert:
>
> Q: Are you running a mainline kernel?
> A: Yes.

You should reply without top posting (refer to [1]). I'm trying to be
helpful to you but it's not easy. The question was
if your on some 6.10.y or older version of the kernel, the step to
reproduce it, and if you have any automation to test it

Michael

[1] https://subspace.kernel.org/etiquette.html

>
> Thanks
>
> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Michael Nazzareno Trimarchi <michael@amarula=
solutions.com>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2024=E5=B9=B48=E6=9C=8816=E6=97=A5 =
20:17
> =E6=94=B6=E4=BB=B6=E4=BA=BA: gregkh@linuxfoundation.org
> =E6=8A=84=E9=80=81: =E8=83=A1=E8=BF=9E=E5=8B=A4 <hulianqin@vivo.com>; qui=
c_prashk@quicinc.com; quic_jjohnson@quicinc.com; linux-usb@vger.kernel.org;=
 linux-kernel@vger.kernel.org; opensource.kernel <opensource.kernel@vivo.co=
m>; akpm@linux-foundation.org
> =E4=B8=BB=E9=A2=98: Re: [PATCH v1] usb: gadget: u_serial: check Null poin=
ter in EP callback
>
> [=E4=BD=A0=E9=80=9A=E5=B8=B8=E4=B8=8D=E4=BC=9A=E6=94=B6=E5=88=B0=E6=9D=A5=
=E8=87=AA michael@amarulasolutions.com =E7=9A=84=E7=94=B5=E5=AD=90=E9=82=AE=
=E4=BB=B6=E3=80=82=E8=AF=B7=E8=AE=BF=E9=97=AE https://aka.ms/LearnAboutSend=
erIdentification=EF=BC=8C=E4=BB=A5=E4=BA=86=E8=A7=A3=E8=BF=99=E4=B8=80=E7=
=82=B9=E4=B8=BA=E4=BB=80=E4=B9=88=E5=BE=88=E9=87=8D=E8=A6=81]
>
> Hi Lianqin Hu
>
> On Fri, Aug 16, 2024 at 1:58=E2=80=AFPM gregkh@linuxfoundation.org <gregk=
h@linuxfoundation.org> wrote:
> >
> > On Fri, Aug 16, 2024 at 11:21:24AM +0000, =E8=83=A1=E8=BF=9E=E5=8B=A4 w=
rote:
> > > From: Lianqin Hu <hulianqin@vivo.com>
> > >
> > > Added null pointer check to avoid system crash.
> > >
> > > Unable to handle kernel NULL pointer dereference at virtual address
> > > 00000000000001a8 pc : gs_read_complete+0x58/0x240 lr :
> > > usb_gadget_giveback_request+0x40/0x160
> > > sp : ffffffc00f1539c0
> > > x29: ffffffc00f1539c0 x28: ffffff8002a30000 x27: 0000000000000000
> > > x26: ffffff8002a30000 x25: 0000000000000000 x24: ffffff8002a30000
> > > x23: ffffff8002ff9a70 x22: ffffff898e7a7b00 x21: ffffff803c9af9d8
> > > x20: ffffff898e7a7b00 x19: 00000000000001a8 x18: ffffffc0099fd098
> > > x17: 0000000000001000 x16: 0000000080000000 x15: 0000000ac1200000
> > > x14: 0000000000000003 x13: 000000000000d5e8 x12: 0000000355c314ac
> > > x11: 0000000000000015 x10: 0000000000000012 x9 : 0000000000000008
> > > x8 : 0000000000000000 x7 : 0000000000000000 x6 : ffffff887cd12000
> > > x5 : 0000000000000002 x4 : ffffffc00f9b07f0 x3 : ffffffc00f1538d0
> > > x2 : 0000000000000001 x1 : 0000000000000000 x0 : 00000000000001a8
> > > Call trace:
> > > gs_read_complete+0x58/0x240
> > > usb_gadget_giveback_request+0x40/0x160
> > > dwc3_remove_requests+0x170/0x484
> > > dwc3_ep0_out_start+0xb0/0x1d4
> > > __dwc3_gadget_start+0x25c/0x720
> > > kretprobe_trampoline.cfi_jt+0x0/0x8
> > > kretprobe_trampoline.cfi_jt+0x0/0x8
> > > udc_bind_to_driver+0x1d8/0x300
> > > usb_gadget_probe_driver+0xa8/0x1dc
>
> Are you running a mainline kernel?
>
> Michael
>
> > > gadget_dev_desc_UDC_store+0x13c/0x188
> > > configfs_write_iter+0x160/0x1f4
> > > vfs_write+0x2d0/0x40c
> > > ksys_write+0x7c/0xf0
> > > __arm64_sys_write+0x20/0x30
> > > invoke_syscall+0x60/0x150
> > > el0_svc_common+0x8c/0xf8
> > > do_el0_svc+0x28/0xa0
> > > el0_svc+0x24/0x84
> > > el0t_64_sync_handler+0x88/0xec
> > > el0t_64_sync+0x1b4/0x1b8
> > > Code: aa1f03e1 aa1303e0 52800022 2a0103e8 (88e87e62) ---[ end trace
> > > 938847327a739172 ]--- Kernel panic - not syncing: Oops: Fatal
> > > exception
> > >
> > > Signed-off-by: Lianqin Hu <hulianqin@vivo.com>
> > > ---
> > > v1:
> > >   - Optimize code comments, delete log printing
> >
> > This is "v2" not "v1".
> >
> > Also, same comment as before, what:
> >   - causes port to be NULL
> >   - prevents it from changing to NULL right after you check it
> >
> > Both need to be answered before we can take this change.
> >
> > thanks,
> >
> > greg k-h
> >
>
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL T. +31 (0)85 111 9172 info@am=
arulasolutions.com
> http://www.amarulasolutions.com/



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

