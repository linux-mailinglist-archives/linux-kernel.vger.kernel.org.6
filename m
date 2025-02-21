Return-Path: <linux-kernel+bounces-525532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0A0A3F0ED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27AF57ACF96
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B43B204695;
	Fri, 21 Feb 2025 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ObBU6+rH"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6191EB18D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131202; cv=none; b=KRH5i4keHCqqJITH/5MV9+IXpNW5v5j0qLPHug71Nt6oPfv+2NMXeaOMmQ18d8O8+asud9k7yYkuTZPCy34m5HGawrmjPOt6nsWKwDyTcPYOJHCjTaRtgxWhAggVD/I11qHfpbTy7j3F0ngAIrx/ojaS8jP7jpQoK44GwLBfi+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131202; c=relaxed/simple;
	bh=eQJL+meMUpiM4NI7kP2j/MMgufqHNxN/rIC7ZWyqMl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9J/tRcdUd6Vi77H8JUFhEiMDKDkA9dlqCZ892fzwTpjOCJBhfkH1cjGBQuBe4hk5iRvsI0ohxARTBDPPpPEdVavgxPTTlRUWERDBKtu8O4fmgZ9hLobEG7AMsbyQ4qDSSJdxxOppOgSXp7iER2xzMoV41tStKeDU7kZA/vjm88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ObBU6+rH; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f40a38cb6bso849413b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740131199; x=1740735999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FK9YWaslx6HNqwJPESJVhu2TqR0s7ppmYvVLNX5onZk=;
        b=ObBU6+rH6vq686YOlNh48lPFBn8Rv86Pj2NKxOo8xxKU3KUYC5h3OaXqNAcbhCPYFp
         0OTvlg7hTtBeXx7/RDdGx+JmrpcqrIY8WlgmyxDXrDB05x4Jlqstsq+wCa/9fkd4qdzP
         HkjunBYv/eNa0FEDzHgJdo/gChplqqE8Q1klrvzzoClk58h35QLqauACSEBOwhiqqYrt
         ElmK8jMXxIX+7H60VLBF1yIVus7Obwt9VC17dZlHikiHfJTl1JBvGWjrPfZUvjhFSOvR
         qr+ps9iYX4w3UAg6S7GL/BXKmfOznrisYhp4und22NUPtZMHRM6zb8jhqeZe8xyq/Y/b
         AIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740131199; x=1740735999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FK9YWaslx6HNqwJPESJVhu2TqR0s7ppmYvVLNX5onZk=;
        b=j4PMQAR28wVvXeEUgZCGHTbzecO0nVgKHDHxTr+eAsvZN93DqBSOqaiQ7OqF5GDnK1
         Y8hAPEE/Ehv9wJcy+qe7FO7CHvoAPSypeinB5nAO43N6MPBsL+oXzxs9RBo8ErgkGC/4
         sqzsMaPN8JaNusXMUgdiKlEas4p2hR4JGczkzycTOmT8LZAnK450eZwqcSxnBxbzOBId
         f6u19lWJmfF1iBFKZBIVq05mku45i0kIHgK+6xT7VtfhtWH9/rN0i6kiS/N3tHD2GGil
         AXKs1cOBLVsaTt4scYBEOFklrodLkbKwrXqjaSlFx60hhHx39T5QTzc0aqOBDjfcqaVI
         STQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+FPayOLpKYwG1UheZiOjHQyquUQdLPccD/2BOonRSGEkSkI5f6rdnSoNZZAda4/pbE1K3cSJZXVbohck=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMwc0dq5H6uYFF5SeGVraArFnt9Rn+4bq5hdOfnq3T2BUkic4g
	gpycgg6/BweihkM27tQ90QQ8UCkWLosDlEIKAcsPEcMw2pYnmQotvKTKofcFfhXVrJ/GVdHlOVB
	Owc6Qh1G2IWjG0tGwv2Ts5Vu4Iq7na1x8Ag5R7g==
X-Gm-Gg: ASbGncvEpbhrMsbaqzjeI90JXKhJWlNAhlpUr07OJ+pn8zbwUHZCquPRbXi6KhxFFlV
	71TFxMMNrip7arszmAWFTpO435qkUdRMmYcmgTExhh1F9c06YYWoR1i9Yemj/HR9200JfjNy0Al
	Sh4jvmuhrMvA==
X-Google-Smtp-Source: AGHT+IGKyiCnfDfAcOf96/Pz2fYUxZ2ya298ZCqluJV66qLCCSHa32SRsS9lfGx93hGxLg3TS7OQXnUDo/JPgXH6CeY=
X-Received: by 2002:a05:6808:15a8:b0:3f4:ed9:d4c1 with SMTP id
 5614622812f47-3f4246e1bfbmr2178808b6e.22.1740131198879; Fri, 21 Feb 2025
 01:46:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220101511.37602-1-cuiyunhui@bytedance.com> <ba2a6295-7983-4701-8c42-797efe22ecb7@linux.intel.com>
In-Reply-To: <ba2a6295-7983-4701-8c42-797efe22ecb7@linux.intel.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 21 Feb 2025 17:46:27 +0800
X-Gm-Features: AWEUYZkJqSgMY7u4dhOrvQExbs4Qf6MpItdHGfjihq8Thi_KuEFs--dsdZv-1_4
Message-ID: <CAEEQ3wkygXexsu9x16Q+6yMtmtM+9aD=-DH1tMVNq1yuyZ7Dcg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] iommu/vt-d: fix system hang on reboot -f
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ethan,

On Fri, Feb 21, 2025 at 4:40=E2=80=AFPM Ethan Zhao <haifeng.zhao@linux.inte=
l.com> wrote:
>
>
> =E5=9C=A8 2025/2/20 18:15, Yunhui Cui =E5=86=99=E9=81=93:
> > When entering intel_iommu_shutdown, system interrupts are disabled,
>
> System interrupts were disabled ? you mean all interrupts were disabled
> when entering intel_iommu_shutdown(), perhaps it is not true, at least
> for upstream latest code.
>
> > and the reboot process might be scheduled out by down_write(). If the
> > scheduled process does not yield (e.g., while(1)), the system will hang=
.
>
> No NMI lockup watchdog jumping out here ?

Steps to reproduce:

1. Avoid return in:
if (no_iommu || dmar_disabled)
    return;

2. Write a.out with while(1).

3. ./a.out &; reboot -f.

4. Observe. Send NMI via BIOS to check system response.

5. Add console=3DttyS0,115200 to cmdline to increase reproduction chance.

Let's continue discussing based on the above.

>
> Thanks,
> Ethan
>
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >   drivers/iommu/intel/iommu.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index cc46098f875b..76a1d83b46bf 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -2871,7 +2871,8 @@ void intel_iommu_shutdown(void)
> >       if (no_iommu || dmar_disabled)
> >               return;
> >
> > -     down_write(&dmar_global_lock);
> > +     if (!down_write_trylock(&dmar_global_lock))
> > +             return;
> >
> >       /* Disable PMRs explicitly here. */
> >       for_each_iommu(iommu, drhd)
>
> --
> "firm, enduring, strong, and long-lived"
>

Thanks,
Yunhui

