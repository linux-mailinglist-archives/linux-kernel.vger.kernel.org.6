Return-Path: <linux-kernel+bounces-211649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9729054DE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B1D5B23BB9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C123B17E465;
	Wed, 12 Jun 2024 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0khO82C"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22D917DE21;
	Wed, 12 Jun 2024 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201769; cv=none; b=EsZfnK3IRFvxr8PkYS4kKaoLCwCX5S2VWuSBtqiIpzGJNHU3clLSfSSe4xB6srCbg1329MiZSYJ0YgS2SE2wAA+YnwK+mJ2Tstp0nMy+Toh+SSSLeQJMuWQV474HX5DGIGrATEbTf3BI+j7Vy5oyS5m0GmGXzDfZcRT3x8ZOnMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201769; c=relaxed/simple;
	bh=lS4Q64mUZkPtGZTGN1Vvs1emIda9a/KP8HYXBdNQGHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMINyZCEGMjW1hQrAASSErLd7ZJwYCJQsAPMDL6ttbqOxRQiRfj6t6C3um0xwToTInBuqVk05Gsa/r+mgQWS7HgoWgYGhQc1m3JWeMhtWkzdxPgVzZeDJAum0BV5ggfyh2zPUHbVCF+O64SRwCHTaBzIyh9dx4MezQ5BarTXPHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0khO82C; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-35f06861ae6so4444685f8f.2;
        Wed, 12 Jun 2024 07:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718201764; x=1718806564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNJdiRvVFKx+Fq5oad51B9nRPB0lGgFCkitSs5laVyY=;
        b=M0khO82CpfvEDY30HHWAMvM/0ZvaRXSHW0pHS/iuG9/8dXW4IrA0KsOGO9hUTCEeXx
         K03l3XkLflOiTTeu/2RFQmU6vOtzQ7PdUQ2HRMrkB6qidrkLcNjMSm4Tod3oY59DRIwZ
         Q9yuRoDbL7qS06eD6epStZY9Aik8wECohhPr36cxJbL4RQSqWN7eOrhMIng3gln+Vose
         E3RYDHwje3xn82KzmAUFsmOs0cPD3fsgB0Xz6rh23k/7M1xFuLY0pAGk+cHHceYY0hlJ
         RNoUAwZJMYECg3Kn5FQmi8x+nWyONPT+2tRLKkoenJrQfMZsE19Xo37joXmCmmPwvVGv
         7AlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718201764; x=1718806564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNJdiRvVFKx+Fq5oad51B9nRPB0lGgFCkitSs5laVyY=;
        b=UYjJGJ0+vqfWOt03qzMKb69iMCPVrf7gh9i582JRKEOZkXjHBvCzQD0B0sDKlQPdSO
         YGpzthAK15z6zNtKjq80xSeKnEZ1Xsn0B/2K5kD34M2GQGRXey/NlInOEUt4IjgVrUe0
         vNnZgECaROBpRcxK0KAQGCygfrulfcyhHUa12WiKovrhWQbsVgicM8c5zP5YoHS7TM+W
         80qPi+gp39v6VWtITeiWAl5/ZN5yT0WFE9k+kL3Ew/fHE5vxiNgQfy+/yixNZR2zIWKS
         ochMnoiYYSBu9YvsrQ17PGlBhs8TqfcHRuXsyxetB5Ncc+wkizelOgmOD89RJhj51ywt
         emuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVBIgDe46aCoEWyZx6MduNux5VjRs+zlqatYn4YgmPwLxbK7XtKUUxp3LKkzx13FsqtWnBlE/FHBUWYcgH0imrNZjJuQNzUXasLl8Ip7B/Nn/SYSprg4phhbgbLx73q82pNjo1GhsK
X-Gm-Message-State: AOJu0YzRLVgM6vYEQUGISJ+f+Zyrx0jn81FHP2CdJUWDx37jeof5GfOm
	J8i+g68bnL949sbhBaeIiTH092L9XEyEzUjBNGFHHpVPrkmnbL0m3IW6+ICOZzK4fpDTJROFM4s
	V8l4HHHrKRcnENdYWbslgyYTTBEvmqTlAie65dw==
X-Google-Smtp-Source: AGHT+IEAOwXzvDL/aUgGhZr0L8GgFeDp+p5XP45ibYIyQtwVdipelfwhOfbZ6mfhMY8Z9i9VxewbjVBLBySpmdHGsYw=
X-Received: by 2002:a5d:6248:0:b0:35f:122d:a589 with SMTP id
 ffacd0b85a97d-35fe1c0a0acmr1218164f8f.40.1718201764066; Wed, 12 Jun 2024
 07:16:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601092646.52139-1-joswang1221@gmail.com> <20240611142953.12057-1-joswang1221@gmail.com>
 <2024061247-geranium-unstaffed-ff09@gregkh> <CAMtoTm32JDwWAjpKJ4TXxA9ROqqr-fNaOR1nqui8ayMHnYzkjg@mail.gmail.com>
 <2024061217-haiku-unlocked-9d72@gregkh>
In-Reply-To: <2024061217-haiku-unlocked-9d72@gregkh>
From: joswang <joswang1221@gmail.com>
Date: Wed, 12 Jun 2024 22:15:52 +0800
Message-ID: <CAMtoTm0dk2y9XLjABP-O27b37zZfjfVKAGvAootzwAE4aJuUtQ@mail.gmail.com>
Subject: Re: [PATCH v3, 3/3] usb: dwc3: core: Workaround for CSR read timeout
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jos Wang <joswang@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 10:07=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Wed, Jun 12, 2024 at 09:52:04PM +0800, joswang wrote:
> > On Wed, Jun 12, 2024 at 3:58=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Tue, Jun 11, 2024 at 10:29:53PM +0800, joswang wrote:
> > > > From: Jos Wang <joswang@lenovo.com>
> > > >
> > > > This is a workaround for STAR 4846132, which only affects
> > > > DWC_usb31 version2.00a operating in host mode.
> > > >
> > > > There is a problem in DWC_usb31 version 2.00a operating
> > > > in host mode that would cause a CSR read timeout When CSR
> > > > read coincides with RAM Clock Gating Entry. By disable
> > > > Clock Gating, sacrificing power consumption for normal
> > > > operation.
> > > >
> > > > Signed-off-by: Jos Wang <joswang@lenovo.com>
> > > > ---
> > > > v1 -> v2:
> > > > - add "dt-bindings: usb: dwc3: Add snps,p2p3tranok quirk" patch
> > > > v2 -> v3:
> > > > - code refactor
> > > > - modify comment, add STAR number, workaround applied in host mode
> > > > - modify commit message, add STAR number, workaround applied in hos=
t mode
> > > > - modify Author Jos Wang
> > > > ---
> > > >  drivers/usb/dwc3/core.c | 20 +++++++++++++++++++-
> > > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > >
> > > Should this have a cc: stable line?
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > I have a question here, please help me confirm
> > 1. Cc: stable@vger.kernel.org or Cc: stable@kernel.org ?
> > 2. Do I need to modify the commit message, for example:
> > Cc: stable@kernel.org
> > Signed-off-by: Jos Wang <joswang@lenovo.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jos Wang <joswang@lenovo.com>
>
> Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.ht=
ml
> for how to do this properly.

Thank You

