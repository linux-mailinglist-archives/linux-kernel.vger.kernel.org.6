Return-Path: <linux-kernel+bounces-518862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D35CA39588
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2200B3A1A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8FA22B8C4;
	Tue, 18 Feb 2025 08:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="G9Ixn6WA"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEF214A614
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867514; cv=none; b=Fa9pUrjTE/0oYDyJ/Ks+DO3hMP4bBP9WL9ahxKgdg8U93XOh3ZjZP1nJLw0j8JxLVnAsVp+SNvSDcSqhcON/pI0hR7cZY0q2jLFgEPjN9bC+N9O1HxvRS1Hyjylv1e2bFFSBk5EpMe+VSaVGf8canTBajpRgTnjtRryw5PiwqMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867514; c=relaxed/simple;
	bh=SsbAnIdLUxCmvoZx0vz9iFZutB0fWqPdzrUOPpXqTJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNCe9GpV7riqeMiqYURLZIKyIpwXSzfSc28HQ713+oFM7RPX8MMm12nCpfGjrvCIRO/aW2bd+YijH3CKtsjVAgjTrv88U+dyiqG8u8Y7S+BkOQ+lJfFP692GKk8Qbol37zhpzTP2LUa26sxAyBLJDmzGpkEvvkhw9Q5nFJjNNuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=G9Ixn6WA; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2bcca6aa8e1so444948fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 00:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739867511; x=1740472311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgMKlsrMP1eBCbeaAVjxhZXck6mumn4aUs8hwiTVomI=;
        b=G9Ixn6WArpM9qHIJScfIHBYv5Q0u79tZoRzugjjrjAghOXer3nJwvwdGYGQWu/ziJK
         rOKTde9GXEn08c+rFiZj+QY5nf6ba6DOFB0uwbPjSuyCp0MtRM0+EBFaQAjN8G/S83ha
         uqSGqFO7xPqpk+QIrCDKETw+bp+0QAA3pqL/Oq9iwNMS/Q9ttmCrHkjmUsdq3L+fiSIf
         dDtc1yhSQw/SIeolULO7f8XGDZ7crQJsE/C3y0n53jgqexkOUNLOBXBYT82s5lhVLeJs
         0uIZhbjqeBo2FsUlW0JXd2tHJVuClZlhlBfWNVJnI/vGfCvYQ8s6hQN77darTlKTetfp
         6TpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867511; x=1740472311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgMKlsrMP1eBCbeaAVjxhZXck6mumn4aUs8hwiTVomI=;
        b=vowmiHcT+qzwSKcu10tdvIAR+ZUwm/CaKMevLUenTYa4cvckls2BhJtYP4PtITFAI8
         IFMjwPHHfq62QNP4Jn3XZ+CNe5GryZ7ryam1TEGqdV4a1+czE0RnfZNhUg2Dpwqx/AvF
         3WC1aDdpsrwzqi3SunihzpCg4y3WfMcwJIYn5WciDL65f3NhjYo8aOPZ58n9uAU5b3Gy
         yJOPYPvRldylGGadeUXWGEor1tQiUAHxlXMvtoOqNAsstna0IEqqNigBnUdfS3eRMYdi
         hoHi0NU39taDscmR0szcIkfyLLc0pVoB/7gt7FFL+8Ri78hznjWX48ZRZURYz73X3UJy
         rCMA==
X-Forwarded-Encrypted: i=1; AJvYcCVHXz2tccl/5Np/j8s+wNNm+172SLVpfnPWbammskSmeLrupXnufxrQnAAgwetnq/2L7UTRbeZIgNsO/sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlexf4wY5JdJ/SjkGlJj1f8nhTPFGYPaBQwuTk0AesNqWKkXlT
	oKlJgWzKQiMi7pA7w3ISWYtpVIh5onnnhcjPPrtVhjO8rfuQxD93h2aYR/tR7d4vIGYaNMPWxSo
	yUeEcbUzkl14FYMdlFpVbiOLz4XPr567DMw9+Iw==
X-Gm-Gg: ASbGnctCaTkr3CU/oFtXNknK7kfp4j/Alz674kbj5f2if8dN4LFM2zSR68uqY7zfzjm
	y/idE8Y23yA8M7RnnEaH5svZQDCzsapxeQF+El89EGfSIKFQK65BUXiTFQSTWran+sUMFmca2gV
	Y=
X-Google-Smtp-Source: AGHT+IGHJuM9IfNPGlGcPH7aa44uhxOWYRwrS2rEKmNkeW+giAvfsVbkjj5RarhaVn+9MIgY3oxSFWNSlHJgrM3c2SI=
X-Received: by 2002:a05:6870:be8b:b0:29e:3531:29da with SMTP id
 586e51a60fabf-2bc99a937bdmr9235473fac.9.1739867511250; Tue, 18 Feb 2025
 00:31:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208104002.60332-1-cuiyunhui@bytedance.com>
 <20250208104002.60332-2-cuiyunhui@bytedance.com> <d1db3047-f478-4d8f-b9f6-e7a5820d5a29@linux.alibaba.com>
In-Reply-To: <d1db3047-f478-4d8f-b9f6-e7a5820d5a29@linux.alibaba.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 18 Feb 2025 16:31:40 +0800
X-Gm-Features: AWEUYZkcD7V4dyG01R1nkwYjrYmf-ApvAaWIkuajdXDd_s9zqaV_RoEhFC_HhyY
Message-ID: <CAEEQ3wmaD61DMV0nXrQeVEk6r-J3JYxFceXZmH=t0aQrESqJew@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 1/2] perf/dwc_pcie: fix some unreleased resources
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: renyu.zj@linux.alibaba.com, will@kernel.org, mark.rutland@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

On Tue, Feb 11, 2025 at 4:05=E2=80=AFPM Shuai Xue <xueshuai@linux.alibaba.c=
om> wrote:
>
>
>
> =E5=9C=A8 2025/2/8 18:40, Yunhui Cui =E5=86=99=E9=81=93:
> > Release leaked resources, such as plat_dev and dev_info.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >   drivers/perf/dwc_pcie_pmu.c | 33 ++++++++++++++++++++++-----------
> >   1 file changed, 22 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> > index cccecae9823f..19fa2ba8dd67 100644
> > --- a/drivers/perf/dwc_pcie_pmu.c
> > +++ b/drivers/perf/dwc_pcie_pmu.c
> > @@ -572,8 +572,10 @@ static int dwc_pcie_register_dev(struct pci_dev *p=
dev)
> >               return PTR_ERR(plat_dev);
> >
> >       dev_info =3D kzalloc(sizeof(*dev_info), GFP_KERNEL);
> > -     if (!dev_info)
> > +     if (!dev_info) {
> > +             platform_device_unregister(plat_dev);
> >               return -ENOMEM;
> > +     }
> >
> >       /* Cache platform device to handle pci device hotplug */
> >       dev_info->plat_dev =3D plat_dev;
> > @@ -730,6 +732,15 @@ static struct platform_driver dwc_pcie_pmu_driver =
=3D {
> >       .driver =3D {.name =3D "dwc_pcie_pmu",},
> >   };
> >
> > +static void dwc_pcie_cleanup_devices(void)
> > +{
> > +     struct dwc_pcie_dev_info *dev_info, *tmp;
> > +
> > +     list_for_each_entry_safe(dev_info, tmp, &dwc_pcie_dev_info_head, =
dev_node) {
> > +             dwc_pcie_unregister_dev(dev_info);
> > +     }
> > +}
> > +
> >   static int __init dwc_pcie_pmu_init(void)
> >   {
> >       struct pci_dev *pdev =3D NULL;
> > @@ -742,7 +753,7 @@ static int __init dwc_pcie_pmu_init(void)
> >               ret =3D dwc_pcie_register_dev(pdev);
> >               if (ret) {
> >                       pci_dev_put(pdev);
>
> Should we get a reference count of pdev in dwc_pcie_register_dev and put =
it in
> dwc_pcie_unregister_dev?

Personally, it's not an issue because RP devices are generally not unloaded=
.

>
> Thanks.
> Shuai
>

Thanks,
Yunhui

