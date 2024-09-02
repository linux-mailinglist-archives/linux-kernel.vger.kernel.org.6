Return-Path: <linux-kernel+bounces-310648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB92D967F9E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD671C21DFB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DDF155759;
	Mon,  2 Sep 2024 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4tGjHf1Z"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C661547DB
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 06:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725259463; cv=none; b=YN7FyXC6HlfozvZdaadCv99HtyWl0tTxXs2Si8Ewg9IIlG6dyRdzHuCEkyeEIwLgcOHAhZJ3Bkn/djx1wcfy5oLHEKed/CPhjDapRT/xyR2RrWE8LlZtjxAZmPBhFIOKdZLh6mtfq242yQtkz4NRbYvxjoMUkgsgVSl2sZvWI+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725259463; c=relaxed/simple;
	bh=R7aTkSK8LzamfibqPPRgrapEWH4gpUvYnVlGUh0t8VE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEt8c4m36klFm0jn7pzmBoftGiBWVePZ+C8jdsIUTxaznBDpi5f22a66EJkownPXmxZedsKxrmUzcNM/QHnebmnAAUSni4mAdNKcUPg7naOy8DjPcouUonMCmmhsEcxMf+MyMxEl12gyGfm/pOOMoWbnbm9ujO0pEQzt/jHSIno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4tGjHf1Z; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f406034874so45181531fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 23:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725259460; x=1725864260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lH7RzCro9KR4PRaykVwLoW43L7IaVQTY4cssEPtIQ48=;
        b=4tGjHf1ZQRfTHzkDn8YKN1MuTeYllLopUSeLNunZ9usToQBp4BdsHzdLc4RX5dExxT
         SIKvAIcJ8OoF32YwNtd0P5UR+mBEkVCs8jpJjgV/b0w8DRfWqIA7cT/WREhvQFZ1LAaw
         tOo+PwcUM/Uq709I5B9vgIfGTlSSRrnK3AqmWQGwQjMqwLxLeu8RYgyXbtTEDQyINxX1
         Ws2DQZlhz4bHAB+7GxIFHeQhGcqBKg4Een5INVRAmrQjkRvEmgrrRq0+OnZQxDL2P2UK
         oplBJzqq1SaASws5wb9bZI3y9aqQ6UP8HGTM+ZFp26HlOurTlX37NWFP07X1RMWjME3m
         9SXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725259460; x=1725864260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lH7RzCro9KR4PRaykVwLoW43L7IaVQTY4cssEPtIQ48=;
        b=ftF5NHZ2qz0RvtkOtOayvgejQteD9P3HvG/1WM6MkDiUi3t63bW1WmUO2A5/bWiC3B
         eTi/WiQpIh58SUPdaOzNmshUpiU6D8RoUjATpHzvrOIot+AOXTWmVvMyYyIuM8yUy9ou
         T35pcpR+u9VgrRETShFaWDdTZMp7MAcKKAdgoekCkQYDRsWGcqPlk5rsRbqsLKWWhRTh
         SuUEYvxRr4raJFTw5eUTrEsn3h2CeuolGGY9cOpfSiD9B26aeZv6eYqxCTRR4MMrSXAS
         82uOfQCkh0NnaIAIvM4u18LX8Y+qzcs3oALhci2diZst41bZDERD3mUtwQkwmGr95r/C
         DmUg==
X-Forwarded-Encrypted: i=1; AJvYcCWXD/j1Jk7KJcz+ZJ/1eOFkeC9EDTZi5yfKWfRf6jax0udWoxYII/pRjXA6vUxVBrgMOEZNk6v8fjRCfUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCzuQBpjf45GluBGMQVk0kXAj3u1cHeaAhZZmeFQfhtJbBIQG0
	Fu6uyTIiLjNZkS5bjgo5OFLCeHwB7rTvgKWdql1+NC2kHAH29Wxt9GELUX8G/epRlh2XuI2+snh
	jGJ8DXe2bojTErhlM4CYP0cRGk7O0r42kqiZp
X-Google-Smtp-Source: AGHT+IFbawU2TahiECCxc4cujiBXi/0Uu1UqBdaFktG1PDxaMqgHctbDawA3cYVC2uTrs+onJIsV86/d0GK9AwaeNlg=
X-Received: by 2002:a05:6512:3054:b0:52e:767a:ada3 with SMTP id
 2adb3069b0e04-53546bab7a7mr4884671e87.47.1725259459240; Sun, 01 Sep 2024
 23:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829120504.2976612-1-sachinparekh@google.com> <2024082941-lagging-escapade-d9d8@gregkh>
In-Reply-To: <2024082941-lagging-escapade-d9d8@gregkh>
From: Sachin Parekh <sachinparekh@google.com>
Date: Mon, 2 Sep 2024 12:14:06 +0530
Message-ID: <CAHH62BpRkkAE_c9KC-D=OXh0j7SME=FSHGN0Y8C7C6naW=NvnQ@mail.gmail.com>
Subject: Re: [RFC PATCH] driver core: platform: Call iommu_release_device in dma_cleanup
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, will@kernel.org, robin.murphy@arm.com, 
	lokeshvutla@google.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 7:22=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Aug 29, 2024 at 12:05:04PM +0000, Sachin Parekh wrote:
> > Installing a kernel module that has an iommu node in its
> > device tree increments corresponding iommu kernel module
> > reference count during driver_register.
> > Removing the same kernel module doesn't decrement the
> > iommu reference count resulting in error while
> > removing the iommu kernel module
>
> Please wrap kernel changelog text at 72 columns like your editor asked
> you to :)

I had wrapped while creating the patch but I suppose it got messed up
somewhere. Sorry about that, I will fix it next time.

> >     $ modprobe arm-smmu-v3
> >     $ modprobe test_module
> >     $ modprobe -r test_module
> >     $ modprobe -r arm-smmu-v3
> >     modprobe: can't unload module arm_smmu_v3: Resource temporarily una=
vailable
>
> Does this happen for any in-kernel driver?
>
> Why has this not been noticed before?
>

As per Robin's explanation, IOMMU drivers are not intended to be removed so
that could be the reason why this hasn't been noticed.

> >
> > Cause:
> >     platform_driver_register
> >         ...
> >         -> platform_dma_configure
> >             ...
> >             -> iommu_probe_device (Increments reference count)
> >
> >     platform_driver_unregister
> >         ...
> >         -> platform_dma_cleanup
> >             ...
> >             -> No corresponding iommu_release_device call
> >
> > Fix:
> >     Call iommu_release_device in platform_dma_cleanup to remove the
> >     iommu from the corresponding kernel module
> >
> > Signed-off-by: Sachin Parekh <sachinparekh@google.com>
>
> What commit id does this fix?
>

I think these two commit IDs are relevant in this context:
512881eacfa72c2136b27b9934b7b27504a9efc2
07397df29e57cde5799af16e8f148ae10ed75285


> > ---
> >  drivers/base/platform.c | 3 +++
> >  drivers/iommu/iommu.c   | 3 +--
> >  include/linux/iommu.h   | 1 +
> >  3 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 4c3ee6521ba5..c8125325a5e9 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -1467,6 +1467,9 @@ static void platform_dma_cleanup(struct device *d=
ev)
> >
> >       if (!drv->driver_managed_dma)
> >               iommu_device_unuse_default_domain(dev);
> > +
> > +     if (dev_of_node(dev))
> > +             iommu_release_device(dev);
>
> Are you sure that all devices that pass this should have this call made?
> How well was this tested on different systems?
>

I am not sure hence I created this patch to understand if this is the
correct approach.

Thanks,
Sachin

