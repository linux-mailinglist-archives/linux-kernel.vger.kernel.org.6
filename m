Return-Path: <linux-kernel+bounces-514683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC3BA35A38
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 565171891A03
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F22D23A9AA;
	Fri, 14 Feb 2025 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jg1jwCFm"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F018C21CA1A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525097; cv=none; b=c/7psP1hySrKW8W9RNEU35DLnFXtTpkrbJnhVTR1zH34Akz/MRvrYtZ02CMd+LHPVXCsVo2ha9BpVONocq3DD1byfAnA574GzKytk0ig4ZgxklvUqBJGngzgtueLWvfLwnDHZLPLmtjlgcIfXVu7fM53jrUUvcvcC7OKQEgMp/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525097; c=relaxed/simple;
	bh=d1wlMH588Z6yDEP1MFtLtFRjpV2D0arHjgG/BXApk7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CeIxluoGp5WXFyrpoUV/lTbpnvyymDuuU7je7RQWU1p2uwLa1Uz4ygeT/I2+PVTS7/wBYEoY59vh8m/+XTF4J2IUEUKVLZUcRCrn8n3DVY/OBiGMMax5+1IG/MgfsPS3HEZIW0PMJasDMbs/76gaSCtlBQ4fyYvyMT0hsZy/ORY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jg1jwCFm; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3061513d353so19686571fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739525094; x=1740129894; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+8xrkm9mttHMT5UbPbCNDDmwidLeRPd7KRTfBhHPCas=;
        b=Jg1jwCFmrYBkxLqgHGpdsY2ZOQY6/glX1HneQCh7RHgYMiSOJIKnnYiEA2V/olKljC
         XlTYK33UTu4zFlB5c0GT9J1DgpTyUMcrIYV5t3XQ6bqnGrFT3EWbdyMf2mVxVuK/p0Tk
         NgPOd3XQjAnuvsrS7sOmRZeGn+tAyuDr1VvMx8qEyi9PpPRdYzRoADdkpmWY4WTP9XWc
         mWvHCnNsoK7z95WWrCYmHMtyT+75CiMfuhBoAOWo/gqYLCidfqQ23eZl0FJXLYSu0sxB
         i1N0QpXEZC2c1OgLC06QYWQexmzXD5oQDDIilfb3ll0DdnX3bPbBYYUWRe2HAJ7TReuP
         OnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739525094; x=1740129894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8xrkm9mttHMT5UbPbCNDDmwidLeRPd7KRTfBhHPCas=;
        b=Q/rs4BAudP6EJPENAhBTCW2whobLmNdvaNg3n4kKZ0lraqA2+ddlSsCSlpp+3Slrlu
         awe6zdu2EdtsP+Bi+E0alOlFFrh0ewTemq9fZ7pd1PiHeie7YngRsssY6Gg4IuXwURU0
         lc6XTjkI41/8j0BcYFgGOXsqUBxWeffExvVUFFaugEYF1WX11XBvz+UhANkMCTcB3kXy
         z5Qwh+Mst7K4H50UuEDJPZiTjV8axUIALphUdZgAcqFMV1imucmmDMt2lqWWladtufXO
         NjRSvhgiC6/CJEsyAW7Zfs0mHna73rELDiURrHb6qDHC/zjlocVW271fo+Lc4kuXu59E
         9cYg==
X-Forwarded-Encrypted: i=1; AJvYcCWnXy8f/GbBzqEF7U9UFOk+9ysYEfTddFNQ7A5UclSdqzymB17pnRjGQMxWTb6KzFHpPuICnNMjN0KR3Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwofW7+6Il1eM5MOmBdrAP6ysvUFOP34Uyw4urrIVZGeET8HPq+
	u+ROK18gQ5XC4RIKXLLEYQvzY6sAlij9iEKrKVzArhmCM/OuN2IFF6Brkumro03+qOmQjCmoEmM
	5jgrZWaUwEKpnYMSajnSefAnagLS0+0wNkHVH+g==
X-Gm-Gg: ASbGncvPaYIxFnaIvz/GcTLCEFQfeJiEXhN+kFsz1B59Y3zz9JFxJE9zyq9qD2Q4BKN
	BKUSaUTbuQIn3OmqTNW4bjMaFeaorBfGVzcYCnhgD04BsLESaEX+spImecPa2jDd1hIbCqRc=
X-Google-Smtp-Source: AGHT+IFWV1F2V+9LL8q2W9e+NB5QweZAcTYLtOomoEx+6dpIzsXrtn4v0Oy/tpP4l9Wn5FZ6Y5Eo1ipBdEkZ0Chsm7I=
X-Received: by 2002:a05:6512:e97:b0:545:2b24:c711 with SMTP id
 2adb3069b0e04-5452b24c92cmr353044e87.21.1739525093936; Fri, 14 Feb 2025
 01:24:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com> <CABQgh9FMy7oVt9+enSpJxXvkux+czMFqbsPZVgmBV+rFWWvhGA@mail.gmail.com>
In-Reply-To: <CABQgh9FMy7oVt9+enSpJxXvkux+czMFqbsPZVgmBV+rFWWvhGA@mail.gmail.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Fri, 14 Feb 2025 17:24:42 +0800
X-Gm-Features: AWEUYZm4VYXZs9D9gG1u5f1QdB-hm7ET9-KXeIGkEb4d3KyyjUcKgmCuOU2-Pdc
Message-ID: <CABQgh9HTCN8mgZhUc1+oNGPK4Pcw-iuQAyiVqTYnegCq4gDfpQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Feb 2025 at 16:43, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
> Hi, Baolu
>
> On Fri, 14 Feb 2025 at 14:11, Lu Baolu <baolu.lu@linux.intel.com> wrote:
> >
> > The new method for driver fault reporting support relies on the domain
> > to specify a iopf_handler. The driver should detect this and setup the
> > HW when fault capable domains are attached.
> >
> > Move SMMUv3 to use this method and have VT-D validate support during
> > attach so that all three fault capable drivers have a no-op FEAT_SVA and
> > _IOPF. Then remove them.
> >
> > This was initiated by Jason. I'm following up to remove FEAT_IOPF and
> > further clean up.
> >
> > The whole series is also available at github:
> > https://github.com/LuBaolu/intel-iommu/commits/iommu_no_feat-v1
>
> I quickly test this branch
>
> 1. host test is OK
>
> 2. qemu boot one device, test ok,
> though reports this when guest bootup.
> vfio-pci xxx: resetting
> vfio-pci xxx: reset done
>
> 3. qemu boot multi device,  test fails, host kernel reports [Hardware Error]
> qemu can boot no problem
> Test fails.
>
> Will do more checks without these patches.

Test on 6.14-rc2 without this patch set

1. qemu boot multi device,  test OK

2. log "vfio-pci xxx: resetting/reset done" also exists.

Thanks

