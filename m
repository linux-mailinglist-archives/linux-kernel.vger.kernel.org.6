Return-Path: <linux-kernel+bounces-216627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F7990A261
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 04:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3766FB21E90
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 02:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EB51DFDE;
	Mon, 17 Jun 2024 02:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XWJ4P1Ca"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9E310F4
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718590525; cv=none; b=h1REL3Hln04RXQ9YkIu9qxezXbL+zkSLQP9BlhEmDt5vraG8MqEM8fo4wMnt/iibU7+b0zzy3BYyg1x7VnAQFST0k8niIKSxVhmcP+MI0h21V3npyxIlKFnuOZRYRA+z1FflFMLN+ywXaWVBBurZqzLnvf+35UOL5U9ey7I6MKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718590525; c=relaxed/simple;
	bh=33+gUd0BUh5twg7E+FkXYihWtxidn7jwrrmJRG8qvzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUmsGJ9ffv3/KmvEHfsEFuUtjQMxqxke3Px1nct+cqq5nxmlXGHi0VVatilAlQ7f8PO5yBLI2cIRTHy27fqQKl8D2CHDy2+Otn6MEPn42HXusKakoDP0imNoE+8YXBkwQnGEj9rsYb7wHISHKFzKME7g616FEjUTAAo5OFe3Fkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=XWJ4P1Ca; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7ec0385de1fso60687239f.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 19:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718590523; x=1719195323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33+gUd0BUh5twg7E+FkXYihWtxidn7jwrrmJRG8qvzY=;
        b=XWJ4P1CaezQhmm6bDyn5dM2HhkmngHYjhJam2MjtQ5odazQGFQ+FpuAopG4HnTGX4t
         1Q8M2iUQtxF9yOB3nZ5/0EfkdyF2xCcPTTiGnVkgRoLHLmHuDihlhpLMWnvCRCJDBVgM
         NZPHjWhi2K9QERviNe4fkYtHATNiLwATBEOhzlj+rwS8nbJRLtQNiQK5qMsRFqaYPctG
         D0bJlK3sezQJe9CopkGcBbEeccrGV1ooZiGwa7AxmFvdbWPEIOSSsRJa1LsMMux/eTTK
         NPw4075QPtGslntSK6cQES1yyaBHBho0zXiP+yu1qIVgl3WsC8tdgMpwZOBN/KBUdOOH
         ptig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718590523; x=1719195323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33+gUd0BUh5twg7E+FkXYihWtxidn7jwrrmJRG8qvzY=;
        b=Wm7e/F3E4ao6tu8M+rh356RKs2mHjI1f7sPu2CAWv39PhD2TROyNMQ6KBwOEXENYxR
         QISv2jmqyHE2v9YdxXLZeeWY+6mDF5/CdoVXum7KKRnXRSLXdlCusP1Ysi7RyHRqNKxF
         6XiZ0/4VlM6c2FcwBmsAtxE+TQqJ2htKHIjtOLa0nJSrnS6lOkec/VG22c2EqV83SvG1
         wBQFjPnq+e0VhUZ/OLISjLh5dLiAF4KPGRZkzOBAOW5nT63eFD7jP6zou8R0iZB5TOb6
         QzNDC0Q6+8Yz07etqvv3f1pYKMWb026Gn948n0HHr2kDuTTJOmDBvto/eQ+vhY2/7/u8
         m3qw==
X-Forwarded-Encrypted: i=1; AJvYcCUatNtPP2qpTA2nL18c8mOuTskL3fHVhOlu9NDZu+zGD/NOd0/nUzncqTBL7UStb7xO/YPX6OmF3/yNpEv0cRkxMku/gbFr+jrboMs1
X-Gm-Message-State: AOJu0YxaPQR9VhUUmfCwKSrBNLw3h6dfhWIxW2dnVrW6RHn6Ydsy/M9W
	jv1oxflZ8wKMPOiAvvC1R60OU5CMHicTN07Ij1nDKuTKErprgppjilv6tA+zJnApx5ks7Oqb9JW
	2gCHWWv3+fucKRPi0mk4B9RVCo1tE3Ffg23yWXw==
X-Google-Smtp-Source: AGHT+IEXfvyKaGcOxkCTeIcxMYWxqVnan6HZPo3dOL51Q5uIxGPz0RzQEZinChIpjeGp349yqoA/StIWD6aWJiVwPU8=
X-Received: by 2002:a05:6602:1549:b0:7eb:c972:dee2 with SMTP id
 ca18e2360f4ac-7ebeb4923c5mr971786539f.3.1718590523416; Sun, 16 Jun 2024
 19:15:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614142156.29420-1-zong.li@sifive.com> <20240614142156.29420-10-zong.li@sifive.com>
 <ZmyIASyk5pfm8hwa@Asurada-Nvidia>
In-Reply-To: <ZmyIASyk5pfm8hwa@Asurada-Nvidia>
From: Zong Li <zong.li@sifive.com>
Date: Mon, 17 Jun 2024 10:15:12 +0800
Message-ID: <CANXhq0psbMY7B=wBL_K8b5rnsfWaBJk+Ea49BpvLO8Sfwwyz7g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/10] iommu/dma: Support MSIs through nested domains
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, jgg@ziepe.ca, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 2:12=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
>
> On Fri, Jun 14, 2024 at 10:21:55PM +0800, Zong Li wrote:
> > From: Robin Murphy <robin.murphy@arm.com>
> >
> > Currently, iommu-dma is the only place outside of IOMMUFD and drivers
> > which might need to be aware of the stage 2 domain encapsulated within
> > a nested domain. This would be in the legacy-VFIO-style case where we'r=
e
> > using host-managed MSIs with an identity mapping at stage 1, where it i=
s
> > the underlying stage 2 domain which owns an MSI cookie and holds the
> > corresponding dynamic mappings. Hook up the new op to resolve what we
> > need from a nested domain.
> >
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>
> I think there should be your Signed-off line at the end since you
> act as a submitter :)

Got it, add it in the next version, thanks.

>
> Thanks
> Nicolin

