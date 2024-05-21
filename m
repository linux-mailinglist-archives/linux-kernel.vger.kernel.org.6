Return-Path: <linux-kernel+bounces-185319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B854D8CB36F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479351F2278D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF3B148851;
	Tue, 21 May 2024 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFlassp/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8216321105
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716315598; cv=none; b=uHMxSw9KyNoo8ti57dgDK8sv+vjf7GmdPVKgXMKmIvrxOy6FMjjFENLz6Xj9DElj+DPkpAsIwADbPCLteQQi+hFr+CnMpQynVhEKStCJszDInFyPl7KZsRS20qZKf3VfBwaSwxZCgDf5QGc409fZgs5Ce+xTVt6UuM5WU3jKALo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716315598; c=relaxed/simple;
	bh=0dqwcK/XPOcEv1mTsxYC7i1Y/75vW0HO1WRQSYOUEbI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3KZ2RCQYQA47Y/cHQoM1rsF9QwmmMucHRUJlCG2rD92HMne6bYy1jyDqUfBo6k1q1SpyB4bwrsFxVkm5QePuTUPoDPZqN3yNh1tp7N6VWTUHk6Rn+yuo6uEu4iEa56v2nLgcYOv88FKUishd6hHseEM/6B9V3ZogUNpwCbUTjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GFlassp/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716315594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Isde2dh7/647rfx8u6foFeQh7vHwio2r62p6n+pus0=;
	b=GFlassp/6UCRwOXSNDQ3oCV6r6V3UQ/A1XCXDjVMCvjMGOv7PYlqCh7tioHhTmreoo98pf
	Tg1o7GwuJeQN/3TbcfWFFkgHq0XWcFc7fa4vJugAvC6wRBQNhYB8LtH2HT3EpGpM97q6gI
	L5afy5B9dSiCpvD+xtEy0VNlB7g5jwQ=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-MtO88H13POyAmI-gUFNAvg-1; Tue, 21 May 2024 14:19:51 -0400
X-MC-Unique: MtO88H13POyAmI-gUFNAvg-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7da42114485so1527168039f.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716315590; x=1716920390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Isde2dh7/647rfx8u6foFeQh7vHwio2r62p6n+pus0=;
        b=Ot9h7zmThAcpqYvdOzb6jWYWGyXA1w7TvKKbv29FzL5GhrpTr1HgrjQMdG1gUdWRXD
         XtBqhoad7mOm+jXbu9+lUVxTA7Xb/vvkoqHiHNSqSVs+Rr6JnOX3EqYinpwn5U6nJhWW
         lemjRKK1xfveXm0hTtHeRxxRgVlQRJOOAferMYZxAWXI3NgONg/jTgsI1rI+URSC7gs6
         kawOLeBZtsD9qF4CikV9+h5jcEu5BIDdtD0A9IVGWlBUN/Slt141QB6ruKsBFuU2clKi
         AOO/Xzb8HqrBeS3zpZwV0+JnlnARDoIEUlTdbLHYoeHJTf1kytWP7Z5IUQJ3+uhYi6DW
         QjEA==
X-Forwarded-Encrypted: i=1; AJvYcCVJRLxTsZ23ZUwMpGQ7c7XJ7d+eF+pCJuUyS05kZArefTuaSWdz6pA42RW/SAqTsnahtzaYFUk1x7zfvzEJ9AWrP6OI8T4kPmbfFPTX
X-Gm-Message-State: AOJu0YyU/fFFhGq5AhuHKZ8vbHTCp1eH49eNqkjoC1WRfounIsfRMjoz
	rZ/I2EExF9GIar1JRDA8lC1nar2GeSGx7BgpzRhlF3/chUYoPhxXoeBpu0B3rBr7KWV5e+gnG77
	cDO221BbWPe0wyxHbJB40IJX0dTEf1RRqbe7vCEhxxnWcF+k2d4zQ/qXSaNyaYA==
X-Received: by 2002:a5d:9553:0:b0:7e1:973b:fbfc with SMTP id ca18e2360f4ac-7e1b520c7b7mr3444746039f.15.1716315589610;
        Tue, 21 May 2024 11:19:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4dEPJMmyq53uNgsrumO7N0Qr7jKz/Z8GDsO+x2zbKwDnCjIJWu7WA5azwt4gAJaAXiGpCZA==
X-Received: by 2002:a5d:9553:0:b0:7e1:973b:fbfc with SMTP id ca18e2360f4ac-7e1b520c7b7mr3444744239f.15.1716315589310;
        Tue, 21 May 2024 11:19:49 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489376de0e3sm7019591173.146.2024.05.21.11.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 11:19:48 -0700 (PDT)
Date: Tue, 21 May 2024 12:19:45 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Vetter, Daniel"
 <daniel.vetter@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "luto@kernel.org" <luto@kernel.org>, "peterz@infradead.org"
 <peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "hpa@zytor.com" <hpa@zytor.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 4/5] vfio/type1: Flush CPU caches on DMA pages in
 non-coherent domains
Message-ID: <20240521121945.7f144230.alex.williamson@redhat.com>
In-Reply-To: <20240521163400.GK20229@nvidia.com>
References: <20240509121049.58238a6f.alex.williamson@redhat.com>
	<Zj33cUe7HYOIfj5N@yzhao56-desk.sh.intel.com>
	<20240510105728.76d97bbb.alex.williamson@redhat.com>
	<ZkG9IEQwi7HG3YBk@yzhao56-desk.sh.intel.com>
	<BN9PR11MB52766D78684F6206121590B98CED2@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240516143159.0416d6c7.alex.williamson@redhat.com>
	<20240517171117.GB20229@nvidia.com>
	<BN9PR11MB5276250B2CF376D15D16FF928CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240521160714.GJ20229@nvidia.com>
	<20240521102123.7baaf85a.alex.williamson@redhat.com>
	<20240521163400.GK20229@nvidia.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 May 2024 13:34:00 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, May 21, 2024 at 10:21:23AM -0600, Alex Williamson wrote:
> 
> > > Intel GPU weirdness should not leak into making other devices
> > > insecure/slow. If necessary Intel GPU only should get some variant
> > > override to keep no snoop working.
> > > 
> > > It would make alot of good sense if VFIO made the default to disable
> > > no-snoop via the config space.  
> > 
> > We can certainly virtualize the config space no-snoop enable bit, but
> > I'm not sure what it actually accomplishes.  We'd then be relying on
> > the device to honor the bit and not have any backdoors to twiddle the
> > bit otherwise (where we know that GPUs often have multiple paths to get
> > to config space).  
> 
> I'm OK with this. If devices are insecure then they need quirks in
> vfio to disclose their problems, we shouldn't punish everyone who
> followed the spec because of some bad actors.
> 
> But more broadly in a security engineered environment we can trust the
> no-snoop bit to work properly.

 The spec has an interesting requirement on devices sending no-snoop
 transactions anyway (regarding PCI_EXP_DEVCTL_NOSNOOP_EN):

 "Even when this bit is Set, a Function is only permitted to Set the No
  Snoop attribute on a transaction when it can guarantee that the
  address of the transaction is not stored in any cache in the system."

I wouldn't think the function itself has such visibility and it would
leave the problem of reestablishing coherency to the driver, but am I
overlooking something that implicitly makes this safe?  ie. if the
function isn't permitted to perform no-snoop to an address stored in
cache, there's nothing we need to do here.

> > We also then have the question of does the device function
> > correctly if we disable no-snoop.  
> 
> Other than the GPU BW issue the no-snoop is not a functional behavior.

As with some other config space bits though, I think we're kind of
hoping for sloppy driver behavior to virtualize this.  The spec does
allow the bit to be hardwired to zero:

 "This bit is permitted to be hardwired to 0b if a Function would never
  Set the No Snoop attribute in transactions it initiates."

But there's no capability bit that allows us to report whether the
device supports no-snoop, we're just hoping that a driver writing to
the bit doesn't generate a fault if the bit doesn't stick.  For example
the no-snoop bit in the TLP itself may only be a bandwidth issue, but
if the driver thinks no-snoop support is enabled it may request the
device use the attribute for a specific transaction and the device
could fault if it cannot comply.

> > The more secure approach might be that we need to do these cache
> > flushes for any IOMMU that doesn't maintain coherency, even for
> > no-snoop transactions.  Thanks,  
> 
> Did you mean 'even for snoop transactions'?

I was referring to IOMMUs that maintain coherency regardless of
no-snoop transactions, ie domain->enforce_cache_coherency (ex. snoop
control/SNP on Intel), so I meant as typed, the IOMMU maintaining
coherency even for no-snoop transactions.

That's essentially the case we expect and we don't need to virtualize
no-snoop enable on the device.

> That is where this series is, it assumes a no-snoop transaction took
> place even if that is impossible, because of config space, and then
> does pessimistic flushes.

So are you proposing that we can trust devices to honor the
PCI_EXP_DEVCTL_NOSNOOP_EN bit and virtualize it to be hardwired to zero
on IOMMUs that do not enforce coherency as the entire solution?

Or maybe we trap on setting the bit to make the flushing less
pessimistic?

Intel folks might be able to comment on the performance hit relative to
iGPU assignment of denying the device the ability to use no-snoop
transactions (assuming the device control bit is actually honored).
The latency of flushing caches on touching no-snoop enable might be
prohibitive in the latter case.  Thanks,

Alex


