Return-Path: <linux-kernel+bounces-310624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FEA967F3A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7541C21C15
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A602154C0B;
	Mon,  2 Sep 2024 06:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wLCXooyd"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A847E3B182
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 06:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725257838; cv=none; b=m9qczjekSzzO/s/Yn9WmOmdhnGBMxi4UGznY0YNnlEdN84PL6UP1bP4rqFxf6d8p54nWTUu21sfO8T9vJCPtEISyCWD/+hDTdC2K2YpPEcp9V0L9qCZmpFgKfNKgqNd1bvSvcAZ0rlRMR8MJRehhZBLuy3KLDSOR06oAaYfTWIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725257838; c=relaxed/simple;
	bh=baCX1MPF/4BgGnjF3EVpOqVJcObJ/nlrrBIjMmp8wyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKkDvASP1xUMaHyDL476Yxyo4QPpkY5H6+wxEb7B7Ox6IDLAUs7MCnf9oBjVHFsrpbY4RfNdlQuv3afKYtmcETaNczKavgQ+2dbnJqljLSrm6vV99i38+Nnn8fPqyp63DNa6Dgvn4k17cQ4Z3ku2hs/zZtZ3v+YMjKMBDa+rmhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wLCXooyd; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53345dcd377so5228690e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 23:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725257835; x=1725862635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sL4q+3BknQF/110uoiRGGVb9lWKaIF7svW7iIAJ6GMo=;
        b=wLCXooydHDdAew2HOqYfl3Xi6eOeK5avJrQxnJJyTJRPuasW8hNN5SqeQgOLlwzyGK
         FLeA8S8OkFxglfyJTp1FW5R18U3egDP2ceEuVUHok2nCZCLecHTiYqmOsCLacNCTmkfT
         rgYwfWLyq7T6uLjjDGaP7nD6BE23X2Et/SekWfN2ygRqsRDDUBgXBoMkopgNYfMr1BhH
         Moaq9KWNhfeYu2xj5aC+ud39tkchwICldq+VaeWFhOfsUOFj2xkectOJR1WrLsLKkJJg
         q8NyjsGG3sLW4TiaT49eplGGJYEwIQPdoH2rkKOiks7EwSiujhBprWnbCGuysZlNEE+z
         yS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725257835; x=1725862635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sL4q+3BknQF/110uoiRGGVb9lWKaIF7svW7iIAJ6GMo=;
        b=oxUXO7zTw1fBPYHfyNw9Sqf94hrKs2Gnk8H/EVdaPuSMySqqxcEkNTtZ0VN2waToPk
         nredj9o+1Kp1MrkZucgkEQcH8Fl/CBGJiDPcPC9jwWpI0E5v6LD0cfnJTdw4euqNDrLF
         o87mQZU1WhkcuGnCwHi35cEG2gVfTW6hE3woHtutXoOBtsb3eZ467vKaTDjLwS3l2En6
         owtzjSpkBfDc46ClTOxqWH7P42aGT+wVtcZKSxeZ/Pi3rU++/poqCpbCVcqjW10E9ekm
         uIaSnTCnb5U7t2TdURrOmRIev78J3gyhfgPW0MULFnBoYwTJz+i5jx0C6lQRXdSyh317
         JZJg==
X-Forwarded-Encrypted: i=1; AJvYcCXQkmqe52M30SVMTP+Lss54xEplUrlCHuPlGDC5O0sK5A1TateJoyOoRl5+0kFG2LdiKcf/y+r2j0XVPiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs3w5wFrLhjIwJBi7wKhwhxypViPs1Yk4CvaaS0vYS6xomv3fc
	W+WQwHCXcxAKQ06va/npN383fPamd7TtIzjMljMHANFAULV8OXBmvtemNQLoQVcCxfchyjxd+/Y
	Tizy9e0Z10Pir1WHkSUslBHAzGi2rg5cOu6AD
X-Google-Smtp-Source: AGHT+IEbBITume0dWKu89jJ/2Yb30U0ruu03X8UrKO5gPC9Y4Z9AcvlzOsu5BI+GMZD9wKi9n1eSprT5dMlhZ33lcbY=
X-Received: by 2002:a05:6512:2309:b0:52e:9b68:d2d4 with SMTP id
 2adb3069b0e04-53546bb8200mr5393539e87.56.1725257834075; Sun, 01 Sep 2024
 23:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829120504.2976612-1-sachinparekh@google.com> <ecf53bd6-6047-4ce5-92e9-41651e7ade15@arm.com>
In-Reply-To: <ecf53bd6-6047-4ce5-92e9-41651e7ade15@arm.com>
From: Sachin Parekh <sachinparekh@google.com>
Date: Mon, 2 Sep 2024 11:47:00 +0530
Message-ID: <CAHH62Bqm57DECYakBWCyWbKHQTs9jnvxMBjJsrnEhnumj+VsEQ@mail.gmail.com>
Subject: Re: [RFC PATCH] driver core: platform: Call iommu_release_device in dma_cleanup
To: Robin Murphy <robin.murphy@arm.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, will@kernel.org, 
	lokeshvutla@google.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 7:28=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2024-08-29 1:05 pm, Sachin Parekh wrote:
> > Installing a kernel module that has an iommu node in its
> > device tree increments corresponding iommu kernel module
> > reference count during driver_register.
> > Removing the same kernel module doesn't decrement the
> > iommu reference count resulting in error while
> > removing the iommu kernel module
> >
> >      $ modprobe arm-smmu-v3
> >      $ modprobe test_module
> >      $ modprobe -r test_module
> >      $ modprobe -r arm-smmu-v3
> >      modprobe: can't unload module arm_smmu_v3: Resource temporarily un=
available
> >
> > Cause:
> >      platform_driver_register
> >          ...
> >          -> platform_dma_configure
> >              ...
> >              -> iommu_probe_device (Increments reference count)
> >
> >      platform_driver_unregister
> >          ...
> >          -> platform_dma_cleanup
> >              ...
> >              -> No corresponding iommu_release_device call
> >
> > Fix:
> >      Call iommu_release_device in platform_dma_cleanup to remove the
> >      iommu from the corresponding kernel module
>
> There is nothing to fix here, the current behaviour is correct and
> expected. It appears the comment in of_iommu_configure() got lost, but
> the equivalent in acpi_iommu_configure_id() is still there - the dodgy
> iommu_probe_device() calls at those points still logically represent the
> same operation which should have happened via iommu_bus_notifier() or
> iommu_device_register(), it's just being replayed later for hacky reasons=
.
>
> IOMMU groups are supposed to be tied to the lifetime of the struct
> device, and unbinding a driver does not make the device itself go away -
> if the devicetree says it exists, then the IOMMU layer knows that.
> Modular IOMMU drivers are still not really intended to be removable,
> unless all their client devices can actually be removed form the system
> (and/or the IOMMU driver is being tested without any clients present).
>

Thanks Robin for explaining the intended behaviour and the context.

Does this mean that the iommu reference count should not be decremented
when we call platform_driver_unregister ?
In my scenario, platform_driver_register is incrementing the reference
count so I expected platform_driver_unregister to decrement the reference c=
ount

Even if the IOMMU drivers are not intended to be removed, the reference cou=
nt
should be in accordance with the drivers that register the iommu group ?

Thanks,
Sachin

