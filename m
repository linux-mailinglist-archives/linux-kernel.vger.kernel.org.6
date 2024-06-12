Return-Path: <linux-kernel+bounces-211506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FB89052D1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F02A281CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1CC172762;
	Wed, 12 Jun 2024 12:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqLHufmt"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963A916F0D4;
	Wed, 12 Jun 2024 12:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196302; cv=none; b=LrxHEdNtzrihKxJszOIm/GLoJOjE2IGpLhtjuLU2du86h1+8+bZg5F41mY4oGAeoNzwfuVwUfsilzeSjQ4atIJSTmzasunIbnpoYW4y3aqDVx7hmuDVk6zlMQfchkcFaDkrqDaE6VhKtFpB8JTFojs3oolpFoC6I5Fh0N7GQ2GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196302; c=relaxed/simple;
	bh=ToG6BzHtI/rb2S4dySACsofNTnEPMpjXjIAcAeo94XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oaQ7Cqv8znsg3MBakCd706b4XMRp2nV09QlcZwtAw9VnT51Srsm2w21KwMsd3+qVeDyH3zHmac8AqGgFkUjkeT81x73q64NIr+HIlWR3XnWvPz/UuOP19bo168ZRe9dPMViX7TRH6FwI6v9lEbneQ2o0SOc3bz3Td3lIHeyu0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqLHufmt; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57ca81533d0so1341992a12.0;
        Wed, 12 Jun 2024 05:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718196299; x=1718801099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFz7E97KT/QfrEMFbCJhoNnw2GGkEahMUEAz9KOKeB4=;
        b=VqLHufmtBBuLVOG+MY7fLSsEPudjWGeNke5mPcQJZS/KfqrLQasOxaxRTA0NFv/5vy
         Fh2RmxEMxg/0xnii0D8uDPNs+zzplqW0j+Z1fmXEnKi/frU+/SD0tzT61zt3OHKkUlTD
         Jm5f3HPiGYFDnzeCQqZbv2Wb5qYTn6ZD60ZlLeGmLHFboLb1OBWpEW4YOcq/vVNVvjkE
         2rf7YCfuoZ8bkPYrJW+FMhemvU7Rv97s0pKLv1yNTJEfJ7NMy4nq8AjP2nWBQbUTxBaX
         hSzcLVyf8wpikOwgz9ugz8cA06ZTKdFqPBD7WJ89WX/oz21BLT2sQMTGhBZ7VJIlvR58
         wXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718196299; x=1718801099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFz7E97KT/QfrEMFbCJhoNnw2GGkEahMUEAz9KOKeB4=;
        b=Sczok4wNFeSq6sK49/CS3e54w87lMM1uXgEIYtfmWFwF8fywRK7AQzvqrKzPUHheYW
         qPlpXq9aVonTo0paGVLRhyIOcdVKsKBMrc5M37vKGXDOQddNGNnEIraDtFZgGPG1eLE/
         s9pBJ47KdfrI0/i8aa4SuRWLb1wwj0S9s6nmtbHlmuiukr1zmUwgO0n0lhN3CmCplluT
         WjxImgVBFXtPpv4ijnTXGfxEs8EpUPUrBxp6EXDrKK08zLUCTWycWV5BgOprKbqWhPTM
         65CnkEQQsvuN9JZYIAVrKWJC9V8Y8myW4Sdva1EK6SFLtGvw4MmFZp/mhMpMp8Z3d17F
         5HGw==
X-Forwarded-Encrypted: i=1; AJvYcCVPAsUJeJrokL+AWTntN5hp/d6oLaeWEyppiy5dXOGMgmkcvd+MDQriEnzE60ZakiHfoDBwxY+ZvUk+eVpkPQotLt3+xmN/RGgZk5CMngUh479foDFoIYcWZ240rUmgsSeqoBcMQYr9
X-Gm-Message-State: AOJu0YwUOG/snunSxYdMFNeucEpBOInjEl7HU+ixR7MZcTYZ2JQW0ogU
	lbqPTAYkmpmfK3gYUyVnj+aLyQjLLcWNI6SbYs44ZGvd8AbFEUrdGn5MIFpWj/FuGZ9MMQ5ysii
	3GeO5uC+iNsRTUNS2I3o8wch5GXE=
X-Google-Smtp-Source: AGHT+IHcci7QpGj3bZnXK1M4+y8pE5RZBZzm+luYAOhm6VIvB2UmcoMk/VPkQ/0Dd9mLOBnqDtVCAqa4hFVvtxtb6EU=
X-Received: by 2002:a05:6402:34c3:b0:57c:7cff:6c7e with SMTP id
 4fb4d7f45d1cf-57cac8905a4mr1155336a12.12.1718196298548; Wed, 12 Jun 2024
 05:44:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601092646.52139-1-joswang1221@gmail.com> <20240611142953.12057-1-joswang1221@gmail.com>
 <2024061247-geranium-unstaffed-ff09@gregkh>
In-Reply-To: <2024061247-geranium-unstaffed-ff09@gregkh>
From: joswang <joswang1221@gmail.com>
Date: Wed, 12 Jun 2024 20:44:46 +0800
Message-ID: <CAMtoTm1_2+oiLeMFLWyUHutAts3=+HLWSKWim6h1vVK9Lq7b8g@mail.gmail.com>
Subject: Re: [PATCH v3, 3/3] usb: dwc3: core: Workaround for CSR read timeout
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jos Wang <joswang@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 3:58=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Jun 11, 2024 at 10:29:53PM +0800, joswang wrote:
> > From: Jos Wang <joswang@lenovo.com>
> >
> > This is a workaround for STAR 4846132, which only affects
> > DWC_usb31 version2.00a operating in host mode.
> >
> > There is a problem in DWC_usb31 version 2.00a operating
> > in host mode that would cause a CSR read timeout When CSR
> > read coincides with RAM Clock Gating Entry. By disable
> > Clock Gating, sacrificing power consumption for normal
> > operation.
> >
> > Signed-off-by: Jos Wang <joswang@lenovo.com>
> > ---
> > v1 -> v2:
> > - add "dt-bindings: usb: dwc3: Add snps,p2p3tranok quirk" patch
> > v2 -> v3:
> > - code refactor
> > - modify comment, add STAR number, workaround applied in host mode
> > - modify commit message, add STAR number, workaround applied in host mo=
de
> > - modify Author Jos Wang
> > ---
> >  drivers/usb/dwc3/core.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
>
> Should this have a cc: stable line?
>
> thanks,
>
> greg k-h

Thanks for your help in reviewing the code.
In the subsequent v4 version, Cc: stable@vger.kernel.org will be added
to the patch approval area.

Thanks,

Jos Wang

