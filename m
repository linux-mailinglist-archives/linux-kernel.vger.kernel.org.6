Return-Path: <linux-kernel+bounces-367426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B389A0225
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D53B285F40
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F1D433CE;
	Wed, 16 Oct 2024 07:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zra37f99"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B811AAE17
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729062545; cv=none; b=HpD2Dle1Zez+8go/xXspQMNlvjT1SUm4F1NfFELttt1m+b4k3dk/U+/TODDhjnbVfydfAx0pihyumEPCjwP/2ol7GUTzaMD7mzee2I2TuBfH9L9s7s8/KClkgra7VRD966NJdA9jEGUDZFkAYw6Psd8gIPLgZ1E5b2QM0BjHqRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729062545; c=relaxed/simple;
	bh=gcnOGBR9KP/UNGr3AkdELOzAOvVCqPN6A1wxZVJU840=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxY6iP7lojr5uOWN7idfGAQ+fSAhNIM9jbCqKyFFs2x9/vCNjbGx2+SrZfutpa3rJXcCurzcvkZ0Yl4Cv6TFVLmGWerIzGGXzzeCgOHDkMFvFesupWO+dt7IpN6pbTZ8fAw3n4lxis5GX0Qz7EuYNVHp6E4wHDPq/AiH+I1YW3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zra37f99; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e13375d3so5100935e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 00:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729062542; x=1729667342; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QCm13YryhPmYIK6474p+L4eQPIt7tXj7ERqjZjp8M3A=;
        b=zra37f9928s/GFWLcEPvjgftC9OYQF614ZE7+0ShisCXcqx5k5rpx0yoHuTWo/rhUz
         Tp9BcpEVTUe/vvoSRaAbGacoueGAN9jG/G6bDgi0LQXCdLzJcurutYS3Roh1Uyqa3k6I
         EF/K0CS2dWtdQzM5vxxhqD7gj1IAeCht19XtTts3pn4xFLTVCtDBtADUu0NWrbDez4o7
         ee1k62k3bM+91iWEKtViQzgyLXZqrdjAKgEJj/HY4xxxa9+sY93/DT03xINLkFudIHAM
         DjHgfi2dqFj5DrtipRJHzI6Pp2eTpKZJC2Q+g7SmDc47u+vcGQyzA2gJ9Pzjob96zbyu
         Z7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729062542; x=1729667342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCm13YryhPmYIK6474p+L4eQPIt7tXj7ERqjZjp8M3A=;
        b=pSqgC7yoep33ndS6dqv1r7SGzV2ANiNyg2gcPpm82tYB5TtS9+vHGLcjbRcIhdaZM6
         zqzy18DbcsvmYtcNB5SgIUwUzPnU8af45B2KLsPpC0OSl2D9Mhs5PBZjpWaGyzoFmSfL
         J1CP2/SHo3c3GpHkYThtjPfCVMXZJUdmh7vqRAw6K1kROKYaTsNj8vfTo0TkcBUTEiYp
         9Aux+KasFxqrfleNe6L/OlaNraik5pkHGdwQlYUPuk6DxFap4Zx6lHZh62GA16VdKT6M
         W04HO/9zgXlAFkt2czSJCnM0sAUsfZ3JgJEDY+2htEDEmaH/yXPwnFF4MI7JjCgN+RQu
         5EUA==
X-Forwarded-Encrypted: i=1; AJvYcCW3B2O+VvU/O5M3YYsaUv8wUpzvusSGrDqgO5tB9dIKDAcT5Of5EC27GtoEuXcrzYI7bFJEzxac10pb9I4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWawckvaLE5efpOoQj18kizoGLRXWbFvQXkgPVZjufECutrjGg
	OACYhAZGUdK4chXttbScSReS5FxFiL8avUH+8cRqDWZVhg2MNtKvEyxvXH2/ZC+I1SaOZnwlprr
	zgOslsFRPn/kVuhkO9FC1tKOU3XkvoPyghovRfQ==
X-Google-Smtp-Source: AGHT+IEc3HtDZMgD9lYvHKiuP10mQcQTLlMzzROBzl6HIMjJA6RX3+ummOZE0ggSdNv9oAbjQQeiq5tKEojMcR8arwc=
X-Received: by 2002:a05:6512:2248:b0:539:fcba:cc6d with SMTP id
 2adb3069b0e04-539fcbacd7amr3773128e87.42.1729062541873; Wed, 16 Oct 2024
 00:09:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <88114b5c725bb3300a9599d3eeebded221a0b1f9.1728491453.git.nicolinc@nvidia.com>
 <CABQgh9Eaj_vy1=sS2Pf7RC7Vy5PopDfwoshECULEU-jK3JF_sQ@mail.gmail.com>
 <Zwn/4m8Ac0xEiJi8@Asurada-Nvidia> <CABQgh9Ft=xxJK-bjS6wCZ5BN4AiKtF9fzdBkevA3x2yb_4O4Kg@mail.gmail.com>
 <CABQgh9HP1M8GAXMwf0ZNn5EpMBAvJU3JLRWcN5H1wfGrqXSe1Q@mail.gmail.com>
 <Zw08z9TOFL57z07O@Asurada-Nvidia> <CABQgh9H-SB7q1v_XtWaO12K7jMMaq8Lj7F4kpDv9sJ5v-F6DZw@mail.gmail.com>
 <Zw3M/h1KYe9MjcZK@Asurada-Nvidia> <Zw64C7bQicoAmAM3@Asurada-Nvidia>
 <CABQgh9Fea006HPwVTAuxk7KGh-7-YbjRhoUttVo_iACjAbr0CQ@mail.gmail.com> <Zw9ijVgDlvRajsSY@Asurada-Nvidia>
In-Reply-To: <Zw9ijVgDlvRajsSY@Asurada-Nvidia>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 16 Oct 2024 15:08:49 +0800
Message-ID: <CABQgh9GAyGNPz1KNCm3ZT9dtECdGyKU-L_aNnahY8K=RG7AODg@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its
 related struct
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, will@kernel.org, joro@8bytes.org, 
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com, dwmw2@infradead.org, 
	baolu.lu@linux.intel.com, shuah@kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com, 
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com, 
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com, yi.l.liu@intel.com, 
	aik@amd.com, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Oct 2024 at 14:52, Nicolin Chen <nicolinc@nvidia.com> wrote:
>
> On Wed, Oct 16, 2024 at 09:56:51AM +0800, Zhangfei Gao wrote:
> > On Wed, 16 Oct 2024 at 02:44, Nicolin Chen <nicolinc@nvidia.com> wrote:
> > >
> > > On Mon, Oct 14, 2024 at 07:01:40PM -0700, Nicolin Chen wrote:
> > > > On Tue, Oct 15, 2024 at 09:15:01AM +0800, Zhangfei Gao wrote:
> > > >
> > > > > > > iommufd_device_bind
> > > > > > > iommufd_device_attach
> > > > > > > iommufd_vdevice_alloc_ioctl
> > > > > > >
> > > > > > > iommufd_device_detach
> > > > > > > iommufd_device_unbind // refcount check fail
> > > > > > > iommufd_vdevice_destroy ref--
> > > > > >
> > > > > > Things should be symmetric. As you suspected, vdevice should be
> > > > > > destroyed before iommufd_device_detach.
> > > > >
> > > > > I am trying based on your for_iommufd_viommu_p2-v3 branch, do you have
> > > > > this issue?
> > > > > In checking whether close fd before unbind?
> > > >
> > > > Oops, my bad. I will provide a fix.
> > >
> > > This should fix the problem:
> > >
> > > ---------------------------------------------------------------------
> > > diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> > > index 5fd3dd420290..13100cfea29d 100644
> > > --- a/drivers/iommu/iommufd/device.c
> > > +++ b/drivers/iommu/iommufd/device.c
> > > @@ -277,6 +277,11 @@ EXPORT_SYMBOL_NS_GPL(iommufd_ctx_has_group, IOMMUFD);
> > >   */
> > >  void iommufd_device_unbind(struct iommufd_device *idev)
> > >  {
> > > +       mutex_lock(&idev->igroup->lock);
> > > +       /* idev->vdev object should be destroyed prior, yet just in case.. */
> > > +       if (idev->vdev)
> > > +               iommufd_object_remove(idev->ictx, NULL, idev->vdev->obj.id, 0);
> > > +       mutex_unlock(&idev->igroup->lock);
> > >         iommufd_object_destroy_user(idev->ictx, &idev->obj);
> > >  }
> > >  EXPORT_SYMBOL_NS_GPL(iommufd_device_unbind, IOMMUFD);
> > > ---------------------------------------------------------------------
> >
> > Not yet
> > [  574.162112] Unable to handle kernel NULL pointer dereference at
> > virtual address 0000000000000004
> > [  574.261102] pc : iommufd_object_remove+0x7c/0x278
> > [  574.265795] lr : iommufd_device_unbind+0x44/0x98
> > in check
>
> Hmm, it's kinda odd it crashes inside iommufd_object_remove().
> Did you happen to change something there?
>
> The added iommufd_object_remove() is equivalent to userspace
> calling the destroy ioctl on the vDEVICE object.
>
Yes, double confirmed, it can solve the issue.
The guest can stop and run again

The Null pointer may be caused by the added debug.

Thanks Nico.

> Nicolin

