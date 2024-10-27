Return-Path: <linux-kernel+bounces-383616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D824E9B1E0C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4356C281BBE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5805D165EF8;
	Sun, 27 Oct 2024 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sxkuj1G7"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B9515EFA1
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730038391; cv=none; b=qtrsyp6tHZ/Y2m7EJtBWcohqc22tceor5GRDnJ2yUolV0JMvrsGDWgDgNeboaz6bsaX5aH60CT/T4g8my01fwgYt7JnRV+6JLNzj0KGz70NeNWJNVh8op3by4ng6eXMw2YvDG8Pw1SxuLw1zQNkx5KkAtIDyaOMAYN6VZSuX1ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730038391; c=relaxed/simple;
	bh=NuJVWMDK6/NmMLATecVP6fHMJcRsxCQ6vGdOe7SC6Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9U4qiUpQFHe/vQf8W8a7Qht6eQwD6LIvt12qouU9dK0L48kVeo0AG7qsTfaXgfcnvFi11e0fNS5ZCX78EXlOcARAnkTqQSqZ6BMKdN0uUDiDeLrOY1R357aWO1vubav6RONbAjT4+q1R1vnLds9T4cAhjL7GwVYIwXMJT6CV1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sxkuj1G7; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so4770373e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 07:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730038388; x=1730643188; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mY015nA+JmXHvPrUJpYeYBU2P2Uf8UWr8WMYD7k1UEk=;
        b=Sxkuj1G73tKdsQyZ6pQ6RYfz1aBK/91UGiVAE28rkeOOY0r1sTFEtj8m/175gdo93a
         2JHtHHuzBhr57rN0SKsLfysMtHh1T15oEqVLh2iLjgqpQqCiy5EgAPeugGaSLdiG8lMj
         jTelkqzibgD2U35FRNtGJvC0uan80Vv3wVNIwwGtIMXGi92TTI5npBV14ohJbI2ggvtj
         4nfmgJ3l0jSz4WhjVtaGmp7+MNSSiMx/Xpag7oersrNQMa/ywJfrD+bicjozuLk7KW52
         mAVPF0OwsHxY+KHTi8D8/XS8Okpveqm23o0GD6D9m7UhpHpLE8v4RqtAzHnATslgfAxY
         C/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730038388; x=1730643188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mY015nA+JmXHvPrUJpYeYBU2P2Uf8UWr8WMYD7k1UEk=;
        b=e5Xvnwu+FktjQQ8/I9he7+ATEaosFFuHzaBCl90c23Pm3gQP14jhEi+YeRIHfNaGYa
         vq6YIV7/emDe3Em9RbydZlmOYiV6R4Htln/gC/XxCou/l66+AEOZ2RMIFkUvo537wUwY
         eJl4Jyv/jHaU5QPhpZltsG6LTKbYo9h1bTnBJ5KEHD7z0g0f6qM4jjYo6aNMPUSX7rlt
         tQcoOX129z1ld/b+qhQ/D/8/RJYSvxUxMHjytcMzz750QL3fD312uM/MHGlTUGicuxOB
         MDGk3PdbmTQYPniFMekuW1qrDcktORbA1SMgbqZfjgoXKo/mAff1ZWN/bJcTlAv2f9ZS
         EfqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0U+fR5BuWfOYNPQMPyCmSXkiNwhpCxYre8l7Lf83q8F76KZTtsh/9cDajsm+oFt81IkRaK9sVAl3Ii8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YypEddetbuCWheojn+bYdZGwYzVs8TE29E40TnJ11buUuuGfWdc
	gumOoqVfarW0ncK79/nKUDDQ234LMYfnMEIefbKY+beWzecZ1XyvIXLht6tVDq4h+C7BHgTNYpu
	UIuExLwf21G0oXzb29PU6zxp+vSxbHWoxGJ+ggQ==
X-Google-Smtp-Source: AGHT+IG4rD8sxA4zeN56s3nv4eo2saz2wQJT8dqXvPZ5lIrF4A6ASYbFn9RyJjsRApMWKVy/sZQFavLyt3vl81pP7/0=
X-Received: by 2002:a05:6512:3b27:b0:539:de9c:c890 with SMTP id
 2adb3069b0e04-53b34c5f9b5mr1778649e87.42.1730038387547; Sun, 27 Oct 2024
 07:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com> <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca> <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca> <CABQgh9FCJcOa0G0Kj__NUm-Q8C9uH4ud04XcHv+3c48T2qEnug@mail.gmail.com>
 <20241017120518.GI4020792@ziepe.ca> <CABQgh9EnEqDKkxg3VUgjSqBzz27h8B3Ct4w=A0vR6JK=d7fXHQ@mail.gmail.com>
 <20241017130805.GA926121@ziepe.ca> <f218230c-ae01-4168-b36e-5e502de6b3db@linux.intel.com>
 <CABQgh9GU4xp=7Svs_Ni=bvNKECKKUjHgq4d-FjT5Y_4wu44kDA@mail.gmail.com>
In-Reply-To: <CABQgh9GU4xp=7Svs_Ni=bvNKECKKUjHgq4d-FjT5Y_4wu44kDA@mail.gmail.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Sun, 27 Oct 2024 22:12:55 +0800
Message-ID: <CABQgh9HYDRVOYtL=jgc4CqX0XhNmCtBDOCm8S6_mgBzBtZVk7Q@mail.gmail.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt attach/detach/replace
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi, Baolu

On Fri, 18 Oct 2024 at 10:45, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
> Hi, Baolu
>
> On Fri, 18 Oct 2024 at 09:58, Baolu Lu <baolu.lu@linux.intel.com> wrote:
> >
> > On 2024/10/17 21:08, Jason Gunthorpe wrote:
> > > On Thu, Oct 17, 2024 at 08:35:24PM +0800, Zhangfei Gao wrote:
> > >
> > >> Yes, you are right
> > >>   I am using SRIOV vf and stall feature, so is_virtfn == true
> > >>
> > >> Our ACC devices are fake pci endpoint devices which supports stall,
> > >> And they also supports sriov
> > >>
> > >> So I have to ignore the limitation.
> > > I see, so that is more complicated.
> > >
> > > Lu, what do you think about also checking if the PCI function has PRI
> > > ? If not PRI assume the fault is special and doesn't follow PRI rules?
> > >
> > > Or maybe we can have the iommu driver tag the event as a PRI/not-PRI
> > > fault?
> >
> > This limitation applies to PRI on PCI/SRIOV VFs because the PRI might be
> > a shared resource and current iommu subsystem is not ready to support
> > enabling/disabling PRI on a VF without any impact on others.
> >
> > In my understanding, it's fine to remove this limitation from the use
> > case of non-PRI on SRIOV VFs. Perhaps something like below?
> >
> #include <linux/pci-ats.h>
> >         if (dev_is_pci(dev)) {
> >                 struct pci_dev *pdev = to_pci_dev(dev);
> >                 if (pdev->is_virtfn && pci_pri_supported(pdev))
> >                         return -EINVAL;
> >         }
>
> Yes, this works on our platform.

Will you send this patch?

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Thanks

