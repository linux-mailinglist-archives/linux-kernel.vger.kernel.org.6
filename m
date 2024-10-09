Return-Path: <linux-kernel+bounces-356990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6819D9969FA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB681F23CC7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF67193432;
	Wed,  9 Oct 2024 12:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="G7roxMPG"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26689192D89
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476913; cv=none; b=jeVlelnbU2qiZkLy8Ypy1pBT8OqVqNMDMEaluLBQXfH5/3Q8t+YpqZg+3n8tiE7RSp4a0BH4ArDOofBnhpx6jPuuSMwaiY2qFtoQkenqQMKC86q4nO08KCghegR0vCKXz5oYcGztz4SX7J+28QvIAgQCzgm7blBj0cl8rV1BjNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476913; c=relaxed/simple;
	bh=Gzx6Tff6kWJAkjIvdlqgZZEQEP/NO+3/o8Nw1OSn6K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIfqh1f0IcP95INgrvvg4tgE9tmPb1hOPbcHBINWAP8MurzccoBxss5zqlsxZvid9xG0ydK8dO7BQ2MFMUPMNHr0hBOi324eH6aqFRPhdPmC0FNq5rrmHdwtTXwyoCCmInFvo2F7vOvmEOtlcBUnVHzAB4qFUs/RuFsxVrA9ZRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=G7roxMPG; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cbd12b38b4so2668576d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 05:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728476911; x=1729081711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MKqGDgbkoJQfv2NqdExgjdbBR1Qs6LC6CGaIz0B3LL4=;
        b=G7roxMPGszQPdvSOgf9be826gadNJXGu4Jb2qZvm3tEyrWFbOyV8sjlvcNfIKBQiVx
         yxvn0xXLU6wqvFZF1nUX83HCP2d1opeCyKBbEQmwuPdAVpPPmsPixkNwaRO4ohpsVdKJ
         F3vfBXyzlCOhLIZlfgUcGs1prSarsNYHk5g/DGqn3PYW52Xa649o8wHM2xa94ok+QZMb
         53HCdUhcdZNoN5EEVItpuW5ENsiu0NCBawn1VBQ5VeSoMfHduXiEmebc4w4XpPATypAn
         2JXYCJEDv1qFPyalO9HIcntdgjlp1n2hgTtUkN334MzrHh3dHNMnNGOQVKV4Xix5up7e
         PNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728476911; x=1729081711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKqGDgbkoJQfv2NqdExgjdbBR1Qs6LC6CGaIz0B3LL4=;
        b=DdFJj+CYOcHYQOn0aBZLkEJu6tEs86giLFMEJisMj7v5+ti8XiK7QsNcN2/QuGfEaV
         EsSJe3eMkeWGkRw8sWPxUOy6H7QufUwJBJmVWaMVtQoSkrQs6IBWEDszuSsjkaMwXE8z
         3b821I+NYhJiVmKAZCQyfc53m0aE4zbiDA4wEmNsKWotUDq6oso0nF3IYVnW+Av05I5K
         Tyz/iP0n9doxs7Aftm3h78aUDWn/NQr8wjPt4mmQw+FdyvooFqoXqz9VCLiqKX6TwztM
         nt5V9WyXFkkaenomaATtl0QbSh+rlOOy27ud7rwPsRSNgp2YEG1sQxvJGWQAC+wu8Hu6
         0boQ==
X-Forwarded-Encrypted: i=1; AJvYcCURpJu3x9cHYd7mq7Ccfo4fKrUUbRHAbnTGmQTmFM32QD7V7OhPBdBFtNpOLNW4cX1+XuWOkThRtT24Qsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqhSN3RAei7vJ/lqIOSDlfD+ZObX7/+KecHJkmz28Wm3PdghKS
	Uf0sYwIIHUmoE4mUNMiERi8O53Np/TVtmhJBa7WAlEsNCoqVQy7PnAGTWND3LIw=
X-Google-Smtp-Source: AGHT+IHqDpkY+mRg2Ha5q1sQX6FtYMn1hW0ifNoGKKJt6xh4S+l7ugsqUarGr6URlqQ7kAWTMypwag==
X-Received: by 2002:a05:6214:2b86:b0:6cb:600f:568b with SMTP id 6a1803df08f44-6cbc92af8acmr31847046d6.8.1728476910952;
        Wed, 09 Oct 2024 05:28:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbc90a5e15sm7860066d6.98.2024.10.09.05.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 05:28:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1syVnq-00BKDa-14;
	Wed, 09 Oct 2024 09:28:30 -0300
Date: Wed, 9 Oct 2024 09:28:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Gowans, James" <jgowans@amazon.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"rppt@kernel.org" <rppt@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"madvenka@linux.microsoft.com" <madvenka@linux.microsoft.com>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"nh-open-source@amazon.com" <nh-open-source@amazon.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"Saenz Julienne, Nicolas" <nsaenz@amazon.es>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"maz@kernel.org" <maz@kernel.org>
Subject: Re: [RFC PATCH 05/13] iommufd: Serialise persisted iommufds and ioas
Message-ID: <20241009122830.GF762027@ziepe.ca>
References: <20240916113102.710522-1-jgowans@amazon.com>
 <20240916113102.710522-6-jgowans@amazon.com>
 <20241002185520.GL1369530@ziepe.ca>
 <d6328467adc9b7512f6dd88a6f8f843b8efdc154.camel@amazon.com>
 <e458d48a797043b7efc853fc65b9c4d043b12ed4.camel@infradead.org>
 <1d331c55a299d414e49ba5eb6f46dccb525bf788.camel@amazon.com>
 <20241007150138.GM2456194@ziepe.ca>
 <b76aa005c0fb75199cbb1fa0790858b9c808c90a.camel@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b76aa005c0fb75199cbb1fa0790858b9c808c90a.camel@amazon.com>

On Wed, Oct 09, 2024 at 11:44:30AM +0000, Gowans, James wrote:

> Okay, but in general this still means that the page tables must have
> exactly the same translations if we try to switch from one set to
> another. If it is possible to change translations then translation table
> entries could be created at different granularity (PTE, PMD, PUD) level
> which would violate this requirement. 

Yes, but we strive to make page tables consistently and it isn't that
often that we get new features that would chang the layout (contig bit
for instance). I'd suggest in these cases you'd add some creation flag
to the HWPT that can inhibit the new feature and your VMM will deal
with it.

Or you sweep it and manually split/join to deal with BBM < level
2. Generic pt will have code to do all of this so it is not that bad.

If this little issue already scares you then I don't think I want to
see you serialize anything more complex, there are endless scenarios
for compatibility problems :\

> It's also possible for different IOMMU driver versions to set up the the
> same translations, but at different page table levels. Perhaps an older
> version did not coalesce come PTEs, but a newer version does coalesce.
> Would the same translations but at a different size violate BBM?

Yes, that is the only thing that violates BBM.

> If we say that to be safe/correct in the general case then it is
> necessary for the translations to be *exactly* the same before and after
> kexec, is there any benefit to building new translation tables and
> switching to them? We may as well continue to use the exact same page
> tables and construct iommufd objects (IOAS, etc) to match.

The benifit is principally that you did all the machinery to get up to
that point, including re-pinning and so forth all the memory, instead
of trying to magically recover that additional state.

This is the philosophy that you replay instead of de-serialize, so you
have to replay into a page table at some level to make that work.

> There is also a performance consideration here: when doing live update
> every millisecond of down time matters. I'm not sure if this iommufd re-
> initialisation will end up being in the hot path of things that need to
> be done before the VM can start running again. 

As we talked about in the session, your KVM can start running
immediately, you don't need iommufd to be fully setup.

You only need iommufd fully working again if you intend to do certain
operations, like memory hotplug or something that requires an address
map change. So you can operate in a degraded state that is largely
invisible to the guest while recovering this stuff. It shouldn't be on
your critical path.

> then it would be useful to avoid rebuilding identical tables. Maybe it
> ends up being in the "warm" path - the VM can start running but will
> sleep if taking a page fault before IOMMUFD is re-initalised...

I didn't think you'd support page faults? There are bigger issues here
if you expect to have a vIOMMU in the guest.

Jason

