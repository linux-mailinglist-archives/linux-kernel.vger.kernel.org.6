Return-Path: <linux-kernel+bounces-171724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D68B58BE7CE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633291F289D4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FA4168AEA;
	Tue,  7 May 2024 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="D9O+KEzz"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682B2155A55
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097148; cv=none; b=er9vMLnB4BFIImNjv3Pp4TIYo+7+CJ/JmDQCLy3EAtoFup/uaOgEoigOSf546EgqQFzktB828NzShNObDQ74EQTTIPc677HwJoYr2BipquXIc9gg/bNKxVAtbvjBK3xsMNXSBKWUg8oUPYgNPYXmRTKZNGLCYllKeWYsmBC8CrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097148; c=relaxed/simple;
	bh=1Rv56/oBFuyRJwYgTZCyvFrjtKjGcVyqzKsoClMQ1k0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrfFLIs9CCP00HwrhJTMyfJXd4qI4REKRIwCzRRNq/q8huawmt63ky4wUhndt7kJJbw3gSYte0C+NKw7SIMjfxRiRbysMaaqtMEvJSdLqhen6khuYeX93o/o+nIZQBGwjdYsPyMpZF5TnsWaRqdu0bk0+DT3K24zHQ86n15ZH58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=D9O+KEzz; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7e1835a9339so20558239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 08:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715097146; x=1715701946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdwrYxvKykWEvU1ciSRbQbFvSgqU+2A+2xiS1iPvfJQ=;
        b=D9O+KEzzVVmVQHUbR5HU6mdo0t7mCbBTNdJi0ZEchfD/TX6uWe2UEgE6ro7+YjuQcA
         T8iIxlX+7Qh/3crxvEoSSyyRzDqT269gbkEiZP4mSsW32/pDSR4uigEQebxm/g2Oeicq
         DWxHralEairhoiyPIZ0+NfcisYCQdIi5vDqMI64wcX3UfOHJ11P3Z/7XvJjqDLY7sjQD
         +I51Wxop1uGfo64e3NUXrXsBbMsECyF6SVj8Yo2dwJL02ETGpcCOBnOULhHt+M+pER0Q
         awRvsQNgeGP7oeVo+bVCYfsZt4im48A6F4zLfOb1kjbz9QJ3qS9Vh8ARhdd+fNUu+l4E
         uUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715097146; x=1715701946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdwrYxvKykWEvU1ciSRbQbFvSgqU+2A+2xiS1iPvfJQ=;
        b=mdjefqpqW6UocLOG4wBa5fw7okkQtNR75NiPlHsqYR6Sq4LT6w4CdNjwToz3TXFToI
         BQCABkTNL/8myhMWDGTmIvmqpCZMj0H+5l2+eoGxKj86Qykid2ywdby+IJOVUP4l418m
         nps/h2WcWUJrrFUbnfdEMZaxbNVQQyJxpZSK1qpF/3i5xIqNj3OqgtdjTm8vtMOTDwC0
         xd6Rzp+hurI54JFFXzlThT/l8C6lSub4vk7XCCgHUED13Wj89G7XCIP9mRGebXAF5bdB
         Xb4DrvFCD4E0Nw7jEXjaG9lTRZZic+tsSy5RlauXf+Qs2I1syUOWKXcy8Gk5uy+W49oA
         XIag==
X-Forwarded-Encrypted: i=1; AJvYcCVLVMcSS/fEWC9gt8Sua5rukLMnm//ieTOcwjWCOM4qL2BbE/cTWv4swk9EAV7hiih0GlFeQhfDiZ2sKM7WodgkPaKtGYdrFLw1fAFB
X-Gm-Message-State: AOJu0YxqECCfgtSELd+Fza9+zBx4B8kOwZfC8/j5Q+x7QdF7RdroO0Z8
	N3CAyXZz+3E55IXkl/Lw9XJqul5jdC7QroUIrBIf7d/ygZGRaaQiDMXY9dMKnqVxlzchbluTA6D
	1o5ly5NRNxrQw7IsuzdPxl+MIaSiMkCpV8r0SWg==
X-Google-Smtp-Source: AGHT+IGgeNVgdFJDVuDgv9ivECfpykkOYp4g95K8N5g+DPVmrNpWUToncN7f6H6A1ruTyO44ONnmAEe/3TdfEor5yQg=
X-Received: by 2002:a5e:db42:0:b0:7de:c47d:a740 with SMTP id
 ca18e2360f4ac-7e18f722d8amr13408539f.8.1715097146605; Tue, 07 May 2024
 08:52:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507142600.23844-1-zong.li@sifive.com> <20240507142600.23844-4-zong.li@sifive.com>
 <20240507151516.GK901876@ziepe.ca>
In-Reply-To: <20240507151516.GK901876@ziepe.ca>
From: Zong Li <zong.li@sifive.com>
Date: Tue, 7 May 2024 23:52:15 +0800
Message-ID: <CANXhq0qLbC2RgW04C5DcuzR-kSmT3hA9rWW=w3e3PKHr+QsyzQ@mail.gmail.com>
Subject: Re: [PATCH RFC RESEND 3/6] iommu/riscv: support GSCID
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, kevin.tian@intel.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 11:15=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, May 07, 2024 at 10:25:57PM +0800, Zong Li wrote:
> > @@ -919,29 +924,43 @@ static void riscv_iommu_iotlb_inval(struct riscv_=
iommu_domain *domain,
> >       rcu_read_lock();
> >
> >       prev =3D NULL;
> > -     list_for_each_entry_rcu(bond, &domain->bonds, list) {
> > -             iommu =3D dev_to_iommu(bond->dev);
> >
> > -             /*
> > -              * IOTLB invalidation request can be safely omitted if al=
ready sent
> > -              * to the IOMMU for the same PSCID, and with domain->bond=
s list
> > -              * arranged based on the device's IOMMU, it's sufficient =
to check
> > -              * last device the invalidation was sent to.
> > -              */
> > -             if (iommu =3D=3D prev)
> > -                     continue;
> > -
> > -             riscv_iommu_cmd_inval_vma(&cmd);
> > -             riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
> > -             if (len && len >=3D RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
> > -                     for (iova =3D start; iova < end; iova +=3D PAGE_S=
IZE) {
> > -                             riscv_iommu_cmd_inval_set_addr(&cmd, iova=
);
> > +     /*
> > +      * Host domain needs to flush entries in stage-2 for MSI mapping.
> > +      * However, device is bound to s1 domain instead of s2 domain.
> > +      * We need to flush mapping without looping devices of s2 domain
> > +      */
> > +     if (domain->gscid) {
> > +             riscv_iommu_cmd_inval_gvma(&cmd);
> > +             riscv_iommu_cmd_inval_set_gscid(&cmd, domain->gscid);
> > +             riscv_iommu_cmd_send(iommu, &cmd, 0);
> > +             riscv_iommu_cmd_iofence(&cmd);
> > +             riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_QUEUE_TIMEO=
UT);
>
> Is iommu null here? Where did it come from?
>
> This looks wrong too. The "bonds" list is sort of misnamed, it is
> really a list of invalidation instructions. If you need a special
> invalidation instruction for this case then you should allocate a
> memory and add it to the bond list when the attach is done.
>
> Invalidation should simply iterate over the bond list and do the
> instructions it contains, always.

I messed up this piece of code while cleaning it. I will fix it in the
next version. However, after your tips, it seems to me that we should
allocate a new bond entry in the s2 domain's list. This is because the
original bond entry becomes detached from the s2 domain and is
attached to the s1 domain when the device passes through to the guest,
if we don't create a new bond in s2 domain, then the list in s2 domain
would lose it. Let me modify the implementation here. Thanks.

>
> >  static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
> > -                                  struct device *dev, u64 fsc, u64 ta)
> > +                                  struct device *dev, u64 fsc, u64 ta,=
 u64 iohgatp)
>
> I think you should make a struct to represent the dc entry.
>
> Jason

