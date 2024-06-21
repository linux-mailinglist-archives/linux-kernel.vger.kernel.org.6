Return-Path: <linux-kernel+bounces-224075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C41BD911CE5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E1C1F2216D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A702116C864;
	Fri, 21 Jun 2024 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UkqfHd6g"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789FD3AC1F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955180; cv=none; b=gB/YR4rW3X/52YpjnjtLC7qL68dluQRzvZ7EDFuNMsobIG7zFzbjrk4mX0DkzfwK+K0C8hg7KSnZ+P6a0K+QdG2SIJgQihus2/mXTLwSBuJnYD8lHgn6eVw1dnwStYrniepHpVa71s2vQlFeBuzEhAJzxJudm/SDEnFw2jtcaJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955180; c=relaxed/simple;
	bh=Nc6TqAf/Y2o3KcUZLNmuYOweaa2c9DWtB9Prmytsiy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sah+3HVh7DB4qNTZgaE4rADHHxsGVsFq9Oic3j+X/G3BWdrXFnpuHX44veQpyuILN17weMKYeTUii+7egIxjKD8a3YQ6I+6ZUYa0UnVNdubLIJl7ZyVIGHfzYnt2HIvusEUAORShOpjgyg9I9XhNf25VI8WUHY3J0O7Z6Mbvaa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=UkqfHd6g; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7ebc67365e3so63482939f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 00:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718955177; x=1719559977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVfCPcleGZb0eMzqXi7Vsq/j2SxIArSsk0slGEmGrA8=;
        b=UkqfHd6ge8VWb0XpJn6Xredg1HVrlJWcAEg4a8VgnSlLuM3FQH6DuXGqFVLkxPxQoa
         wbDxs7rnF34y1BKdkbMXkrMfBJWFXEIiiwjYHSGVvDEi7Rx9LfJDAEhWZY6APjlDmE+e
         Rf/o/6EZB/3Mj38blgt1zL1P+t7D5izxHLqW3JAERQmbHVJbr6c7QtXVXLgE63xPtZwF
         0vWS7P5hHtB3JCN9Ce+IRAHKGyUjAn/vwiwoVP6iVtaYLjfeyEygEON7E3dAev8MIcpV
         TOl6Go8s3xBjvS+YIUvUSo2yQ6fhgmVEfVWEcVhK3QHozATrnfQZdBUOBNFc2G9TnmuL
         YfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718955177; x=1719559977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVfCPcleGZb0eMzqXi7Vsq/j2SxIArSsk0slGEmGrA8=;
        b=i0oQOf5jCQH9QOD3nDm8QkaASGiHVHNPd/70qiIWQF/ZFlk8ASJ0E0vUbS/aCgJMq6
         UDrN8BYnt5fFxsMDsUzZHR6jyoxz6pZA8Oh0a8gj6dLWgPXRe2yWYDXsH8c+RJy/pUQI
         DRjfsrOn6i8KtZFz6KblEzdUIjCdI7j24UcjLzULmymTT39gj4+emENi6aezaeaYbnwX
         SWa+Oz2C3g/YrP39M20qIt22hxHC7In75Ee2JWW6WQcA8zZzBiyT5xRwu95uSdKs8Mar
         0Ulp4mMTpFpAR3zoybHEnaqRUTxeolumXq+NApzpRf0oXzJitvMdnv3vMErSE1Xsnjw0
         XtPw==
X-Forwarded-Encrypted: i=1; AJvYcCUPzmq2tNKoZI3IVfQc/yoCK5xKtlEwv15d9KwEDrcFDygM+4nAhBcCFTUqlGI7pNfea82vTr/EO4aaK0whNDK6bhpN7oWpA48Y7v7K
X-Gm-Message-State: AOJu0Yz7LZ8QM4PqkC4HQJQMo02t75cQPDH+HyhcZGXu/bKz91s5Bei0
	EOQ49u5x6F6dd8ZvfuBUHar/KovE+mYm1gZa0iv6UQ3GZaTHKtTwsHWyPzkgS8nWOlB0wiiurGL
	xCenrpjo+u7/zDwPDA1EK4tyDGPkVcAKZiPnbvg==
X-Google-Smtp-Source: AGHT+IEu4dzZYkNTMX3+BfnbcWOAfXALbnMrAKJ+znJ39Y2amlEx+w3//cBWxFx/TUtSBRZyaVePY5uzyySauxGMR6c=
X-Received: by 2002:a05:6602:2cc5:b0:7eb:af88:1e3a with SMTP id
 ca18e2360f4ac-7f13ee86867mr811509939f.14.1718955177505; Fri, 21 Jun 2024
 00:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614142156.29420-1-zong.li@sifive.com> <20240614142156.29420-7-zong.li@sifive.com>
 <20240619154901.GN1091770@ziepe.ca>
In-Reply-To: <20240619154901.GN1091770@ziepe.ca>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 21 Jun 2024 15:32:46 +0800
Message-ID: <CANXhq0qts90x4L6gOhrAx0dMpX1UbPqEAK6QK9fshgso+Pxk3g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 06/10] iommu/riscv: support nested iommu for
 getting iommu hardware information
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, kevin.tian@intel.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 11:49=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Fri, Jun 14, 2024 at 10:21:52PM +0800, Zong Li wrote:
> > This patch implements .hw_info operation and the related data
> > structures for passing the IOMMU hardware capabilities for iommufd.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  drivers/iommu/riscv/iommu.c  | 20 ++++++++++++++++++++
> >  include/uapi/linux/iommufd.h | 18 ++++++++++++++++++
> >  2 files changed, 38 insertions(+)
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>
> >  /**
> >   * enum iommu_hw_info_type - IOMMU Hardware Info Types
> >   * @IOMMU_HW_INFO_TYPE_NONE: Used by the drivers that do not report ha=
rdware
> >   *                           info
> >   * @IOMMU_HW_INFO_TYPE_INTEL_VTD: Intel VT-d iommu info type
> > + * @IOMMU_HW_INFO_TYPE_RISCV_IOMMU: RISC-V iommu info type
> >   */
>
> Is there a more formal name than "RISCV IOMMU" here? It seems like you
> will probably have a RISCV_IOMMU_V2 someday, is that naming OK?
>

RISC-V IOMMU currently doesn't have another name. If we are really
unfortunate enough to need to overhaul the entire structure, maybe we
can give it another proper name. But personally, RISCV_IOMMU_V2 is
fine with me.

I have also taken a look at comments on other patches, please allow me
a moment to digest that, I will reply to them later. Thanks

> Jason

