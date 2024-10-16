Return-Path: <linux-kernel+bounces-367096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6363099FE93
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B8B1C24288
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0407314D718;
	Wed, 16 Oct 2024 01:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NhacXfMr"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A262214A4E2
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729043826; cv=none; b=JBVBc3iYr0T1Gc06rCFEYlJv+BvQkJq3FqdN1Gzz3mRVJHRcsUt/UBOYxDGOHQwLbqcmyoar8cHyRYig/zhdAIcJmosCJmJHHzBMTG+YrcxRBPATr9H8erQFbK8E1epavuxhWLvhQtM1zPodCWo8fj6W2M6kGOzF1rQDnjzvRxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729043826; c=relaxed/simple;
	bh=6btI4iopsKLLKW9bPf4SycRrF9fzH3XxNtDWeivhWT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNuqo6W4vWE4vCsO7SE5PkmLLebZ2BFg/uhXH/XqYf/uTh2Y2RJUgW3QnsAAQ03P6/bE80Uxy3DivxOSGBiThho2wY8W1GdVo6Yv+f1guT6FMMEkvKbeqVOZmLB9mP3hwkw490L5m91VvBdnPftGx/3zOVdJksaYHBV40m1xpP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NhacXfMr; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f1292a9bso3788930e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 18:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729043823; x=1729648623; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+FelR6GsDdJRo+uFPqIYovXFoQ6VzTQQEO/rkc9OHfQ=;
        b=NhacXfMrqyoW+7ASnk7MafafV/I1sQDmsvIltGYGaKJo5own1YXgQZgHMPn9L5W7HF
         JQwQMu1RYaRmPvSCNnrlHOpwknzuPKmg7GUAlUUOFrilLMiBXZklCLEg10kb91LeewKj
         NFa6V3z5+/vzQyxOw3lTLKlsIkSWl33yl37NTfpe9FDf4ncaQcdzMIL1Pm8g2WHw+8Hn
         ZfSguM0jXCu4/5AYAdymcI/fQR8OK2jIAJMescj/EvR1ASDnMS25odi/EszM9KUjoEnM
         zZ7xkfOf2+zHn0b1XZJLdo3JEbCg3m62Jagugv53phOs1pRNrFAdonN2kEOixBDdOiUL
         Q/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729043823; x=1729648623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FelR6GsDdJRo+uFPqIYovXFoQ6VzTQQEO/rkc9OHfQ=;
        b=hliWMP8T5z58guIV6RnPosArOJZ7MFgKbKuWA2jxl7JlpCKdTK2QsBq5h5HCzm8PhP
         F/SYwfpFI02ozY6agaeaJEOdCBb9KIGYj66POX4GG/KwltmSIdTEAFJ8GgA77AU0uQcu
         jGuEW7SJaXf2HYCZ8tOhRHxvxcycDbv/sQDhaeeZ86JhV0j/NY2Iw/75NLXh/z7E6V5x
         q4+8JjMBd0DpPAe7f5KJAdomigRqMlXRXvk0zHWFy8rsfNVlliNdLERWyOF6taQruy3S
         jjNC5DOdMiaaDXeoEsz6aWiblmFOmvcg5TftR9MNQ+pvKqx6x8lXZoAkmnorRhQZVGFK
         Cc7w==
X-Forwarded-Encrypted: i=1; AJvYcCXRPltntkJYomHGtWhXtFR2QhItXXVdvrwAN6E/ZlOch07aTv2KCwwJ934yJXZk7dzUl3r5GlZXU9q7yXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz9lQvqFXarRq7RHo5pIDzMNcA8Dk1DEjVO/Wet5O+ftABqPo5
	ck4cIATpYrUnYiAyUdzFni011fjGjQI1f36Dg1N6ez17fQno28xyKcZ6GKX22f7bZAdnK/eH3jU
	ld2Y1CVfYZ6nOCGG6SlsduRpey8UStR+whRVKqT+bZESxWtTSVQIeZFJVs2Q=
X-Google-Smtp-Source: AGHT+IGHNJy6WCLVvS1v7p2xUs8DBaNAGSH314OUXrO/87SH8h3u7zNrDy2Yj2k60G+29EMeHRdokeLA3B/2m0BY1IA=
X-Received: by 2002:a05:6512:3a91:b0:539:a353:279c with SMTP id
 2adb3069b0e04-53a03f2d542mr1721990e87.28.1729043822707; Tue, 15 Oct 2024
 18:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728491453.git.nicolinc@nvidia.com> <88114b5c725bb3300a9599d3eeebded221a0b1f9.1728491453.git.nicolinc@nvidia.com>
 <CABQgh9Eaj_vy1=sS2Pf7RC7Vy5PopDfwoshECULEU-jK3JF_sQ@mail.gmail.com>
 <Zwn/4m8Ac0xEiJi8@Asurada-Nvidia> <CABQgh9Ft=xxJK-bjS6wCZ5BN4AiKtF9fzdBkevA3x2yb_4O4Kg@mail.gmail.com>
 <CABQgh9HP1M8GAXMwf0ZNn5EpMBAvJU3JLRWcN5H1wfGrqXSe1Q@mail.gmail.com>
 <Zw08z9TOFL57z07O@Asurada-Nvidia> <CABQgh9H-SB7q1v_XtWaO12K7jMMaq8Lj7F4kpDv9sJ5v-F6DZw@mail.gmail.com>
 <Zw3M/h1KYe9MjcZK@Asurada-Nvidia> <Zw64C7bQicoAmAM3@Asurada-Nvidia>
In-Reply-To: <Zw64C7bQicoAmAM3@Asurada-Nvidia>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 16 Oct 2024 09:56:51 +0800
Message-ID: <CABQgh9Fea006HPwVTAuxk7KGh-7-YbjRhoUttVo_iACjAbr0CQ@mail.gmail.com>
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

On Wed, 16 Oct 2024 at 02:44, Nicolin Chen <nicolinc@nvidia.com> wrote:
>
> On Mon, Oct 14, 2024 at 07:01:40PM -0700, Nicolin Chen wrote:
> > On Tue, Oct 15, 2024 at 09:15:01AM +0800, Zhangfei Gao wrote:
> >
> > > > > iommufd_device_bind
> > > > > iommufd_device_attach
> > > > > iommufd_vdevice_alloc_ioctl
> > > > >
> > > > > iommufd_device_detach
> > > > > iommufd_device_unbind // refcount check fail
> > > > > iommufd_vdevice_destroy ref--
> > > >
> > > > Things should be symmetric. As you suspected, vdevice should be
> > > > destroyed before iommufd_device_detach.
> > >
> > > I am trying based on your for_iommufd_viommu_p2-v3 branch, do you have
> > > this issue?
> > > In checking whether close fd before unbind?
> >
> > Oops, my bad. I will provide a fix.
>
> This should fix the problem:
>
> ---------------------------------------------------------------------
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 5fd3dd420290..13100cfea29d 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -277,6 +277,11 @@ EXPORT_SYMBOL_NS_GPL(iommufd_ctx_has_group, IOMMUFD);
>   */
>  void iommufd_device_unbind(struct iommufd_device *idev)
>  {
> +       mutex_lock(&idev->igroup->lock);
> +       /* idev->vdev object should be destroyed prior, yet just in case.. */
> +       if (idev->vdev)
> +               iommufd_object_remove(idev->ictx, NULL, idev->vdev->obj.id, 0);
> +       mutex_unlock(&idev->igroup->lock);
>         iommufd_object_destroy_user(idev->ictx, &idev->obj);
>  }
>  EXPORT_SYMBOL_NS_GPL(iommufd_device_unbind, IOMMUFD);
> ---------------------------------------------------------------------

Not yet
[  574.162112] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000004
[  574.261102] pc : iommufd_object_remove+0x7c/0x278
[  574.265795] lr : iommufd_device_unbind+0x44/0x98
in check

Thanks

>
> Thanks
> Nicolin

