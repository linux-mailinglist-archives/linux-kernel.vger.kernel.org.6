Return-Path: <linux-kernel+bounces-370860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40179A32FA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812DE284C2B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 02:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8C3126C10;
	Fri, 18 Oct 2024 02:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jB4Jqkr1"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714D553365
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 02:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729219526; cv=none; b=B2d8yLET72Kx2aIjEkzEU63F+nq/VOk8x9NeMlOVfYhSyA7f+tcdv3I4CyQfsyINsKuY4z5HVi603V8fJeHwDx1A7buSgRPVBFtDm+P8Zl9EZqSMH7D0owgjMIdHxCrDZou/gVUOqpx1f/zaJXAyWJxDEtyPWvtdahQQ8k8YgLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729219526; c=relaxed/simple;
	bh=kgRRZiy9FfZN7xD7EZSFKYhFZvRCjUnO4G3r4bM18nU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brw4/2Iv79UdUa8yIlVKyXj1sonYu0jMRl/Pc2EV3iDmMM3jhuo5FfOJNmxU8OUVEHQNXRISz8H9nuPJpgDk7jzk0myLhmzwdJ06alsF7TGMTjpKdBQQQFX0tVbw+JgiqgjINRj2LoXMnBf5o9V96tgS84C6Gp9JERuUTRk2R+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jB4Jqkr1; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb501492ccso17677041fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 19:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729219522; x=1729824322; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1sLZ/lXwGBM2rahMvEDIQo5diSLBoxj3foQMEQZCG+M=;
        b=jB4Jqkr1TRNyWa/cE8tP4Yc9lMoHp5I6m1YyRNCWrV1rXWNXH/+rdlkt9CQ7nFqpHC
         0fdwIVJlwysRfpHnC745kKhlL2dMxDZG+n6jLA8rPYCJ1JBZ/eYI0MFi917rO57D+Kyu
         LqRqCMax/kMIt7btXE24P2IlLXn5gj5iXbHQxic0YkgKEbxOxhKSF5cgjp69+iVixjWb
         PGKw4krtcog3JPyi109AhI84LiqrUaEoE53acI3vfAuJTO5zSEhU497EIA9D7vST2bNO
         eMfMeDb01vpAG6Oex5gV3Oik2n3fIhV1rV51eVUxlkHRsPxdcc+CJRkp+KAqHUUG2phq
         Xqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729219522; x=1729824322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1sLZ/lXwGBM2rahMvEDIQo5diSLBoxj3foQMEQZCG+M=;
        b=fOc3P5aCLPWiA4UaieXSwXV5mV1pHTuO4dMphe07BUSAS+OhTubYP7md1YEPaCxTLr
         aEkFIq4bs42hD+im90QCzrJeJX85RMWvhnbhxFmR1fQUBrZ9JHWJB+dtYceyjlNfOsSG
         9l9DzDt3IqoBvQ8UrM6zrDSA0QZP683SoiyEw0l4Y4eq9dNxTAm2my5QvNw7TnKwzuH1
         AuhPJXtC3W1wqa203NVwf2SE9oLyK44/E4bRFzwGzU36qKG+BUEdfGUpRJ11l9hdAIN8
         STuRoY9x1TAby+g3cA4dJrzcsiO1x2/OMGAMTOvLKlymGEsPwkVI8gPr39/xd99bqrit
         So2w==
X-Forwarded-Encrypted: i=1; AJvYcCX/b9uuRLEeQaZ04wLOdRjBHiaIG0CgZ2Ddp4/f0Vm3vU2OwFf+a6/L9A4xUt9fyWM0weBYbXhSbYsxono=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDE0XTe6VjNIU9syMoJXenMtUiQ5VuGI4a9OuA2cpSKBDVYs83
	sd4hKK7tXyZqsnAxsgK3e1G4ACt1vBqNb8GmU3vgkuJScgAVIgYzEZAWV4TzzFpctI8SKtDcTue
	olCbW9YqxoKUk9PdawWDQe6uxTMPlbmhzoenvvA==
X-Google-Smtp-Source: AGHT+IE4lNRH1NWbi5vrC+GoEkZzjuYwAofdC4w+Awg53/xnT+cp6AFOUD/q+symJRS/APkqXdj2/T+NOFXcw+CS00A=
X-Received: by 2002:a05:6512:128f:b0:539:f1ce:5fa8 with SMTP id
 2adb3069b0e04-53a1550b9e6mr438878e87.49.1729219522198; Thu, 17 Oct 2024
 19:45:22 -0700 (PDT)
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
In-Reply-To: <f218230c-ae01-4168-b36e-5e502de6b3db@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Fri, 18 Oct 2024 10:45:11 +0800
Message-ID: <CABQgh9GU4xp=7Svs_Ni=bvNKECKKUjHgq4d-FjT5Y_4wu44kDA@mail.gmail.com>
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

On Fri, 18 Oct 2024 at 09:58, Baolu Lu <baolu.lu@linux.intel.com> wrote:
>
> On 2024/10/17 21:08, Jason Gunthorpe wrote:
> > On Thu, Oct 17, 2024 at 08:35:24PM +0800, Zhangfei Gao wrote:
> >
> >> Yes, you are right
> >>   I am using SRIOV vf and stall feature, so is_virtfn == true
> >>
> >> Our ACC devices are fake pci endpoint devices which supports stall,
> >> And they also supports sriov
> >>
> >> So I have to ignore the limitation.
> > I see, so that is more complicated.
> >
> > Lu, what do you think about also checking if the PCI function has PRI
> > ? If not PRI assume the fault is special and doesn't follow PRI rules?
> >
> > Or maybe we can have the iommu driver tag the event as a PRI/not-PRI
> > fault?
>
> This limitation applies to PRI on PCI/SRIOV VFs because the PRI might be
> a shared resource and current iommu subsystem is not ready to support
> enabling/disabling PRI on a VF without any impact on others.
>
> In my understanding, it's fine to remove this limitation from the use
> case of non-PRI on SRIOV VFs. Perhaps something like below?
>
#include <linux/pci-ats.h>
>         if (dev_is_pci(dev)) {
>                 struct pci_dev *pdev = to_pci_dev(dev);
>                 if (pdev->is_virtfn && pci_pri_supported(pdev))
>                         return -EINVAL;
>         }

Yes, this works on our platform.

Thanks Baolu.

