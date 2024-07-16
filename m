Return-Path: <linux-kernel+bounces-254387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC0E9332A6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0439D283AD3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388FA19B3EE;
	Tue, 16 Jul 2024 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oDGmCwWn"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0881B57323
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 20:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721160656; cv=none; b=UfnG5HfGU1farUH7ueA8c9ex/XQjoZCkoaWo/m+bvUBLiUYje/dia+5S8efB5gKSJ6KHOted6rUfVmT2cUQFoVZJooIa0RHfEv5kOALyOKxi47BYs62kQ6otLo2WAm/VlDqGdCiP/emrt3/F5rPJToxEcKhVsG1oHb8xZ25strA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721160656; c=relaxed/simple;
	bh=6e4uF3PDb6zCI/M1+hUeYkltQ9Exj2kKi2I18RA898Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwtg1Oksm2H0IBxKdJgEFAQNkM+UWONs7pMk6i/BbRmN3gb7sOyQ9CKx6cWX4LR9W9/ILnBdAC6jsR62MaJd5v1Vd82N69Lo9MTcR9BD6TAydt4Q3H/EwtxJpq9S816AUm+LuN1ZIGV4KfyDv+mlSSTalFl8qIEKAQAfoHa2xLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oDGmCwWn; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e04196b7603so5974853276.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721160654; x=1721765454; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k6o0C+IKAqmJeb1QfPBhGO124UhbiVtdAxc9Xgn0aeM=;
        b=oDGmCwWn90HZFDned1OEPULKTS6RdHg4aLAsL8NSbuZQo2gRJVGEoZg3z1pSFFY96c
         gZ55uAflIamFCRftlzVhG4Ii15r2GIY43H3LmU+FFrYAXn3rewy1PvXeZ9U3PWWQG/6z
         CIyviRjddmto9SGiFAyDVCwxr/MJOTZH9LPSGoW2MA+IBowjn1i5nwE5WqP8iOKMaViU
         L7eCAQSb/ru2efPANWHUV14bCfifv0dzUdSX8Z8+QEbbIrJiGAzHi0cMj2oH7MkpaRT9
         1OMZeV+B4NnT4TIVTOjX0lm6sXep/xYvll1hDSEvvIWIq8WU8kl/e+tY782lfZCiIOw1
         mNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721160654; x=1721765454;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k6o0C+IKAqmJeb1QfPBhGO124UhbiVtdAxc9Xgn0aeM=;
        b=GO1nNjKEDkeBZDPMq8amUas1+aNQ4N6fOk+hYlS9nA3cCzqDjRNacSck8fh/omNLLt
         rtVqkOENBybeDbFsdsufXv00PfhkhrDBRBemMUdi4oEJMSPJSaAxOee4HZTIBgUCzhQ4
         aDrUh6DL8yJdUzyDA1lNt4Jepr0Dhq403YNGhNffeICNKOMTWG5IfnZiAtlaThAJjNG9
         u4l2cuYXQ5jwllRPIuntk7SDNukjcHTEvKVwzR1pPiu5KnHTZQ9VcQKfgkDF/TI3MI59
         EycN3ylP4oiLz5FZ4hQInbHD8lEnqoHVx5PXsYsNbsyqOsBycDN7KeXSAZinZ6coL+TQ
         jbWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+N4HRGMXo5MPc6U5udxniF4MollfiaGI1SxerPPjrsjFs45BUPRS1LZG2RpF8BGyCYLmsUQikGZOZZrA89OP7VOqF0/wXNQ7xRlxd
X-Gm-Message-State: AOJu0YxmJa5+B6KHk+GraGrP40/ciVKXXJJ+/lzsngMj13Ym4Bdwg+zH
	VCiPG6t4wS8HatsbHtxryLsUGmewmfKfYsud3l91yUjqv1+QMxRk93mkUHuzRHfmZeMibVBhpaO
	EsjntuGvTAg0td6DUaOVpURJJgHqMHSqjXLvC6w==
X-Google-Smtp-Source: AGHT+IEyWqLHoPQ96lQsYyho252NePtS7Mu7PAoguxVebnklP1PTUgbyzdxEN+r88MBwR5XfMwMKyspOnXw1eHJyDto=
X-Received: by 2002:a05:6902:2489:b0:df7:8f1b:3ea2 with SMTP id
 3f1490d57ef6-e05d56581efmr4135689276.5.1721160654089; Tue, 16 Jul 2024
 13:10:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716152318.207178-1-brgl@bgdev.pl> <CAHk-=wj+4yA5jtzbTjctrk7Xu+88H=it2m5a-bpnnFeCQP7r=A@mail.gmail.com>
 <CAMRc=MemuOOrEwN6U3usY+d0y2=Pof1dC=xE2P=23d2n5xZHLw@mail.gmail.com> <CAHk-=wg-L1K6N+0zZ-bcU7kGZMMDbXj4Z8smrsi1gvbi5U-GiQ@mail.gmail.com>
In-Reply-To: <CAHk-=wg-L1K6N+0zZ-bcU7kGZMMDbXj4Z8smrsi1gvbi5U-GiQ@mail.gmail.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 16 Jul 2024 22:10:43 +0200
Message-ID: <CACMJSeuSS1GBeMP66xt8CP3=6X9xNUZvj9cZHm_Lav6iaw9Gdw@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctl: reduce the amount of Kconfig noise
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 21:02, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 16 Jul 2024 at 11:48, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > But this patch does it. PCI_PWRCTL_PWRSEQ becomes a hidden symbol and
> > the entire submenu for PCI_PWRCTL disappears. There's no question in
> > Kconfig anymore.
>
> Yes, but look here:
>
>         default m if ((ATH11K_PCI || ATH12K) && ARCH_QCOM)
>
> That has at least two issues:
>
>  - what if ATH11K_PCI or ATH12K is built-in and needs this driver?
> "default m" is *NOT* valid.
>
>  - what happens when you add new drivers? You keep making this line
> longer and more complicated?
>
> See why I say "use select" instead? It means that the drivers that
> need it can select it, and you avoid complicated "list X drivers"
> things, but you can also get the *right* selection criteria, so that a
> built-in driver will select a built-in PCI_PWRCTL_PWRSEQ option.
>
>            Linus

Should we do:

    select PCI_PWRCTL_PWRSEQ if ARCH_QCOM

in the ATH11K_PCI and ATH12K Kconfig entries? Am I getting this right?

Because unconditional select here makes no sense - 99,9% users of ATH
drivers don't need PCI_PWRCTL_PWRSEQ.

Or add a new symbol like ARCH_NEED_PWRCTL_PWRSEQ and select it from
ARCH_QCOM (and later from any other arch that will use it) and do:

    select PCI_PWRCTL_PWRSEQ if ARCH_NEED_PWRCTL_PWRSEQ

in ATH entries?

Bartosz

