Return-Path: <linux-kernel+bounces-206778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4915900D90
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 23:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A241F22F3C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC7B155323;
	Fri,  7 Jun 2024 21:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqz7kHBY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A7A155341
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 21:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717796055; cv=none; b=M1wz5ptAqOKekwP1cNQV9KvRwJE3QY4jUtcGs6gWx5XPwceXFbO0nRxQWytRnqyWVU3hLJ3ll7qReqPC/4jh8iLRErWA7dDY4UftRvgwAMOJgAq/uzwY5fTYpw1NnK40kE7kqV9TWo/36eyCtSS5YTBAsmeoO/iSgPhM5mw7fUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717796055; c=relaxed/simple;
	bh=cYsT0tM9d4orTtOiW3/EAkmjNwaChdXp7xaUoORONng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W4TQo7n0Td3Txa0bn0ANiOaYQPz/dVYY8/9zOqZzP/i4tUXau79GLMglIosx6qQP0GMe3UUK4jmx3/NESj3BH0nf74rrtkC/JN9kuqUrzURtYmFOUgHUN5yDSYEJqYUSeGu1Ue3FpVZkKq9XQdsaCkpeK8tqGpNzUtUgUsfJmI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aqz7kHBY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717796052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ks6Mblf6LFbqf1AYdlbF1eql1nbrqV8sks5KKNLnj54=;
	b=aqz7kHBY8OmFoNKPITzgaCPEb59KTBaNbBHISxrJZxBAvy/wCqf4h1/nzY9x5MfAOOpExz
	vMIodgKuUwi9WUeQMrWmR3YKfTS6d+WfnAAHnC4X5en7LIyqFhV7RAfp9lmVAebacpxdbJ
	WPuV/y3pFL2ZbYXp1xC8rAXLiafwN0s=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-JmgytAo8MuGml1W51gCOPw-1; Fri, 07 Jun 2024 17:34:09 -0400
X-MC-Unique: JmgytAo8MuGml1W51gCOPw-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7eb3978abc6so305099339f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 14:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717796048; x=1718400848;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ks6Mblf6LFbqf1AYdlbF1eql1nbrqV8sks5KKNLnj54=;
        b=j8tX1+6qn9NboGQaHUgd3Y82GgdYViBhac9dAYxX686X96JnAruBYHRtt1tir8WkDO
         /F9xYV0cAsrqL6y167HEmHhIBjINGmS4pQUW2UZ3Bxvcgpvr8qMDsXkR6SW60+BIOBHI
         zguBmvFfBiCoVfWb235RCGf3DmNOoXj4/EBGxv2XsKczbeDUbIDlrdldKN/3hc5oqS55
         Uvso2fwjNIIwX4vB4+KnJPOQXIUjxlaNkkDFvXpqehl/UhsIKjbDoxo0yWau5PgTpj+4
         mxTvxXw4SHO7IREnJthNaVCpEDudkt9Eq4vnI50F0XuOM6DHD8dj8nmvmuE0gSGeeJpd
         NO/w==
X-Forwarded-Encrypted: i=1; AJvYcCWNCW67H57B21nqvqvVWEG3VxJeKY5WwyXCPkzf0l7PzJwgS3XWeW0ONSzM81kYZBO38UaGGFX9Pa0X9o5wHr00dJDi57nR8EL6aYnH
X-Gm-Message-State: AOJu0Yzfvqm/CLnjS0jdvc4E1kXExFkAOH6M7qBABY5GTRu2VFFao6zd
	z5kdCyse624W7Ay27C9KfWSwVfk+I38BGorTeos5NevQaMUSli3DoEcN9DEjATYm0EvI1tHaB9g
	sMX4qnHIBfiMLcGo5afkBEbguP8niUiinn2AGLRdXqdDeGsgFSyzQOepN+iBbVQ==
X-Received: by 2002:a05:6602:3f94:b0:7e1:79e8:d671 with SMTP id ca18e2360f4ac-7eb5724adc6mr458169939f.14.1717796048490;
        Fri, 07 Jun 2024 14:34:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO0WMUh0lNCHTe8ZHkKnWOcJw/B79V9jbHlRGWij/etIT/6UowckVzjO7CWnh2PMVwyJPhdA==
X-Received: by 2002:a05:6602:3f94:b0:7e1:79e8:d671 with SMTP id ca18e2360f4ac-7eb5724adc6mr458168939f.14.1717796048181;
        Fri, 07 Jun 2024 14:34:08 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b7a2244a77sm1055724173.40.2024.06.07.14.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 14:34:07 -0700 (PDT)
Date: Fri, 7 Jun 2024 15:34:06 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Zeng, Xin" <xin.zeng@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Jason Gunthorpe <jgg@ziepe.ca>, "Yishai Hadas" <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, "Cao, Yahui"
 <yahui.cao@intel.com>, "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, qat-linux
 <qat-linux@intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfio/qat: add PCI_IOV dependency
Message-ID: <20240607153406.60355e6c.alex.williamson@redhat.com>
In-Reply-To: <DM4PR11MB5502763ABCC526E7F277363888FC2@DM4PR11MB5502.namprd11.prod.outlook.com>
References: <20240528120501.3382554-1-arnd@kernel.org>
	<BN9PR11MB5276C0C078CF069F2BBE01018CF22@BN9PR11MB5276.namprd11.prod.outlook.com>
	<DM4PR11MB55026977EA998C81870B32E688F22@DM4PR11MB5502.namprd11.prod.outlook.com>
	<BN9PR11MB5276ABB8C332CC8810CB1AD18CF22@BN9PR11MB5276.namprd11.prod.outlook.com>
	<DM4PR11MB5502763ABCC526E7F277363888FC2@DM4PR11MB5502.namprd11.prod.outlook.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 May 2024 02:56:09 +0000
"Zeng, Xin" <xin.zeng@intel.com> wrote:

> On Wednesday, May 29, 2024 1:36 PM, Tian, Kevin <kevin.tian@intel.com> wrote:
> > To: Zeng, Xin <xin.zeng@intel.com>; Arnd Bergmann <arnd@kernel.org>;
> > Cabiddu, Giovanni <giovanni.cabiddu@intel.com>; Alex Williamson
> > <alex.williamson@redhat.com>; Cao, Yahui <yahui.cao@intel.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>; Jason Gunthorpe <jgg@ziepe.ca>;
> > Yishai Hadas <yishaih@nvidia.com>; Shameer Kolothum
> > <shameerali.kolothum.thodi@huawei.com>; kvm@vger.kernel.org; qat-
> > linux <qat-linux@intel.com>; linux-kernel@vger.kernel.org
> > Subject: RE: [PATCH] vfio/qat: add PCI_IOV dependency
> >   
> > > From: Zeng, Xin <xin.zeng@intel.com>
> > > Sent: Wednesday, May 29, 2024 11:11 AM
> > >
> > > On Wednesday, May 29, 2024 10:25 AM, Tian, Kevin <kevin.tian@intel.com>  
> > > > To: Arnd Bergmann <arnd@kernel.org>; Zeng, Xin <xin.zeng@intel.com>;
> > > > Cabiddu, Giovanni <giovanni.cabiddu@intel.com>; Alex Williamson
> > > > <alex.williamson@redhat.com>; Cao, Yahui <yahui.cao@intel.com>
> > > > Cc: Arnd Bergmann <arnd@arndb.de>; Jason Gunthorpe <jgg@ziepe.ca>;
> > > > Yishai Hadas <yishaih@nvidia.com>; Shameer Kolothum
> > > > <shameerali.kolothum.thodi@huawei.com>; kvm@vger.kernel.org; qat-
> > > > linux <qat-linux@intel.com>; linux-kernel@vger.kernel.org
> > > > Subject: RE: [PATCH] vfio/qat: add PCI_IOV dependency
> > > >  
> > > > > From: Arnd Bergmann <arnd@kernel.org>
> > > > > Sent: Tuesday, May 28, 2024 8:05 PM
> > > > >
> > > > > From: Arnd Bergmann <arnd@arndb.de>
> > > > >
> > > > > The newly added driver depends on the crypto driver, but it uses  
> > > exported  
> > > > > symbols that are only available when IOV is also turned on:  
> > > >
> > > > at a glance those undefined symbols don't use any symbol under
> > > > IOV. They are just wrappers to certain callbacks registered by
> > > > by respective qat drivers which support migration.
> > > >
> > > > Probably they'd better be moved out of CONFIG_PCI_IOV in
> > > > "drivers/crypto/intel/qat/qat_common/Makefile" to remove
> > > > this dependency in vfio variant driver.
> > > >  
> > >
> > > Thanks, Kevin :-). This dependency is like the relationship between the QAT
> > > vfio
> > > variant driver and macro CRYPTO_DEV_QAT_4XXX. The variant driver  
> > doesn't  
> > > directly reference the symbols exported by module qat_4xxx which is
> > > protected
> > > by CRYPTO_DEV_QAT_4XXX, but requires the module qat_4xxx at runtime  
> > so  
> > > far.
> > > Alex suggested to put CRYPTO_DEV_QAT_4XXX as the dependency of this
> > > variant
> > > driver.
> > > For CONFIG_PCI_IOV, if it is disabled, this variant driver doesn't serve the
> > > user as
> > > well since no VFs will be created by QAT PF driver. To keep the consistency,  
> > it  
> > > might
> > > be right to make it as the dependency of this variant driver as Arnd pointed
> > > out.
> > > What do you think?
> > >  
> > 
> > Following this rationale then we need also make PCI_IOV a dependency
> > for mlx5 and hisilicon given they are for VF migration too?  
> 
> After more thoughts about this, I would agree with your first point that
> PCI_IOV should not be the dependency of the variant driver if we consider
> passthrough VFs in a nested virtualized environment. 
> So decoupling PCI_IOV from migration helpers in QAT PF driver sounds a
> better option. 

Is this then being taken care of in the QAT PF driver?  Are there
patches posted targeting v6.10?  Is there an archive of qat-linux list
somewhere?  I can't find any relevant postings on linux-crypto@vger and
can't find a public archive of qat-linux(??).  Thanks,

Alex


