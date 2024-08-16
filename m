Return-Path: <linux-kernel+bounces-289636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01273954891
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A3F1F23424
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796511DDF5;
	Fri, 16 Aug 2024 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qiP+UVf2"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C985618FC83
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723810629; cv=none; b=QdJVY/p6PawaNbgHo1YeAfyCroYsE7tyHXxIMY/AmyG8LO9/1F0xqsYlzOkPnwkot5BUpGwvI9upgXbUJ8Rxn+7+R1Xda4h/UsjSQl7KV62PZyWg92cUGlhLVsEYc4L4xBOqO7w4o2AVHHasKkm/l0NSB7ZqSbjHxsWj3HFrAUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723810629; c=relaxed/simple;
	bh=8EU799ei68CoKIZqdtSo/a+H89MPF5foH6vgKKKIh+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btTR7UPuUvUMktT9IVCDnrEgBbNqC+Bdjv+eUHwue6zeO2xfsYZPwyCjXolJQ9JgyCt991886GPNaXyXF77sIQx5ZbMX78nPvOYjrOPlvO+RsGuubUjsecBkYsSl5UHN5MGb8jMw8iJi/XnCD4E9SC5qIJoAVIQlG+RkI6mDjRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=qiP+UVf2; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8384008482so181405866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1723810626; x=1724415426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPRwfrSooDRx9c1YQ60wUHqZBmSWFNZI1yGMvcPp51U=;
        b=qiP+UVf2eGieSdjF6mDcu558I1fKfon09ClkBGHKhyPYNssEvSVxwQZNecuPhayBuk
         6sm32n8nRcit3dUFPWSptG/DWxpbBfgeGW/OyRAstr4zpfmyfk2zyFNraP6KyzyIDPWR
         WjSkuNkVLwH45MeFCl6tzAXfY+iLQGOxfoNsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723810626; x=1724415426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPRwfrSooDRx9c1YQ60wUHqZBmSWFNZI1yGMvcPp51U=;
        b=mdV0SG8M1XoBkTnShmImaY7cHKbeWKfgyiDAa6Nx8KMJcwPtD8H0pnIrS7Y/UKeuiL
         ibZsyVHhUPhKMILqs4DgQnLoHcYiJrpIvnm1Omw+JMROKBTMrveiUE2zdFulRcdpel9l
         3TvJmLe8UIe+Zeyn4lQRxQFYRny6gCEuqjFgQ5j7sH+5fIF4OMFp4/UvjFyF2lLpTmPT
         Gi7VqNA1smTsk6HjFMunrHB6SsIbkDH5B+R6+9CJxJu0ELpO0XU3i41/yYGjYRRrbMZd
         dcF+U3Zv5SOGYHvtM+gkBWNywDRHNbMo5rcsRjfKKFguC2N+uplftNJNXQAlMmRlhWWM
         w4mg==
X-Forwarded-Encrypted: i=1; AJvYcCXxyC8jN/dec/xLJLtBD57effDhOFyTKk9zbczmcDe/S+buwCcgYlWsQz+eqctN7k5w//SoQ4FfrSbo+1M981VVd6sIf3X59DOjk5u4
X-Gm-Message-State: AOJu0YyHp/vqow/AZV8s+EFpBrWaIRZ1XlByol0y33m0If6RR5fERlvq
	ued0FeHMQNF+Bi/Fmh2ZC9GalX3tF10bcSvTL7WHTBGKmHswf+yGk7yuGMGqqrWYB8Q/YWF3f3Q
	IKgwPO85xjegrJD5YKnG8Fv6qxiRGZO90LQRBdg==
X-Google-Smtp-Source: AGHT+IG8jMhlf8o6NwqmmGkfRlnWGnP4SJ0hc1r114kJFMVJYo26Lg45pfhyhHKtBt6nUBeLXh8Drr5zN2/rGI7Fu9s=
X-Received: by 2002:a17:907:d848:b0:a77:cd51:3b32 with SMTP id
 a640c23a62f3a-a8392a650dfmr224291566b.62.1723810625574; Fri, 16 Aug 2024
 05:17:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TYUPR06MB62177737F0054278B489962BD2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <2024081608-punch-coherent-d29e@gregkh>
In-Reply-To: <2024081608-punch-coherent-d29e@gregkh>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 16 Aug 2024 14:16:54 +0200
Message-ID: <CAOf5uwnsgcJjp1=RLa7qx9ScQY5rZvwX-Zu6BOqxBBhBCz+CFQ@mail.gmail.com>
Subject: Re: [PATCH v1] usb: gadget: u_serial: check Null pointer in EP callback
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: =?UTF-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>, 
	"quic_prashk@quicinc.com" <quic_prashk@quicinc.com>, 
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"opensource.kernel" <opensource.kernel@vivo.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lianqin Hu

On Fri, Aug 16, 2024 at 1:58=E2=80=AFPM gregkh@linuxfoundation.org
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Aug 16, 2024 at 11:21:24AM +0000, =E8=83=A1=E8=BF=9E=E5=8B=A4 wro=
te:
> > From: Lianqin Hu <hulianqin@vivo.com>
> >
> > Added null pointer check to avoid system crash.
> >
> > Unable to handle kernel NULL pointer dereference at
> > virtual address 00000000000001a8
> > pc : gs_read_complete+0x58/0x240
> > lr : usb_gadget_giveback_request+0x40/0x160
> > sp : ffffffc00f1539c0
> > x29: ffffffc00f1539c0 x28: ffffff8002a30000 x27: 0000000000000000
> > x26: ffffff8002a30000 x25: 0000000000000000 x24: ffffff8002a30000
> > x23: ffffff8002ff9a70 x22: ffffff898e7a7b00 x21: ffffff803c9af9d8
> > x20: ffffff898e7a7b00 x19: 00000000000001a8 x18: ffffffc0099fd098
> > x17: 0000000000001000 x16: 0000000080000000 x15: 0000000ac1200000
> > x14: 0000000000000003 x13: 000000000000d5e8 x12: 0000000355c314ac
> > x11: 0000000000000015 x10: 0000000000000012 x9 : 0000000000000008
> > x8 : 0000000000000000 x7 : 0000000000000000 x6 : ffffff887cd12000
> > x5 : 0000000000000002 x4 : ffffffc00f9b07f0 x3 : ffffffc00f1538d0
> > x2 : 0000000000000001 x1 : 0000000000000000 x0 : 00000000000001a8
> > Call trace:
> > gs_read_complete+0x58/0x240
> > usb_gadget_giveback_request+0x40/0x160
> > dwc3_remove_requests+0x170/0x484
> > dwc3_ep0_out_start+0xb0/0x1d4
> > __dwc3_gadget_start+0x25c/0x720
> > kretprobe_trampoline.cfi_jt+0x0/0x8
> > kretprobe_trampoline.cfi_jt+0x0/0x8
> > udc_bind_to_driver+0x1d8/0x300
> > usb_gadget_probe_driver+0xa8/0x1dc

Are you running a mainline kernel?

Michael

> > gadget_dev_desc_UDC_store+0x13c/0x188
> > configfs_write_iter+0x160/0x1f4
> > vfs_write+0x2d0/0x40c
> > ksys_write+0x7c/0xf0
> > __arm64_sys_write+0x20/0x30
> > invoke_syscall+0x60/0x150
> > el0_svc_common+0x8c/0xf8
> > do_el0_svc+0x28/0xa0
> > el0_svc+0x24/0x84
> > el0t_64_sync_handler+0x88/0xec
> > el0t_64_sync+0x1b4/0x1b8
> > Code: aa1f03e1 aa1303e0 52800022 2a0103e8 (88e87e62)
> > ---[ end trace 938847327a739172 ]---
> > Kernel panic - not syncing: Oops: Fatal exception
> >
> > Signed-off-by: Lianqin Hu <hulianqin@vivo.com>
> > ---
> > v1:
> >   - Optimize code comments, delete log printing
>
> This is "v2" not "v1".
>
> Also, same comment as before, what:
>   - causes port to be NULL
>   - prevents it from changing to NULL right after you check it
>
> Both need to be answered before we can take this change.
>
> thanks,
>
> greg k-h
>


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

