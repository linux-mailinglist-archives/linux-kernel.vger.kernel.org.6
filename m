Return-Path: <linux-kernel+bounces-181567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF20A8C7DBB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 22:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 367DD28398C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 20:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4195938F91;
	Thu, 16 May 2024 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gcn7AMav"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A786A208A8
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715891529; cv=none; b=o3WpTFJ9SE73lBzfItAfe8x/56nsBV6670Qh8zoJy2Q58+b93RnXr5O+t/Cbeg9skuX7wRBxzl+68w/X568CR/SQHnk4YNJ+SZkObIaubdNi9xv/AzRKvRyvV5QrP9UnTUpC2uNPbnme31WZMVpQuRva3aiTvvnFnc123rOt0Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715891529; c=relaxed/simple;
	bh=LuSL1Mpx4KPw1l3VT+HJPO9KvbyA0LOeza7avB0qiVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eW1oXJvPpq3ScM27MkueW4u1Sa4CZPJqPIxdNRE8cIb5oSnFKMn7bZ6Sl78SM4coM+JlgtJmXZBveGbMaMnsZDAMSyiiH6WYQMZMFOqNWwSH/MoyMgQryQAY+bC4/h3WzSTnPhxyCix48p5KSTtw2drw3oWaBwAnd0z/472AdGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gcn7AMav; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715891526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ttpHvlXmiMi2UVt0UbQVx/o7cd/ODV6RN79VD1fX8s4=;
	b=Gcn7AMavAJeWUQ4C60OLOeLAe8R2Rfgc4XOhvHBcMKsbrjQN+HlzUZc3Uq+90L4mca4FQX
	w5VrG7PUwf9YF2FBE0/Zqp/XLUo6SLyDLXbmmo8THhhBMu6cni7fC1RXmKiO6mitG/3NcX
	bUxzBc9Tiu7wE1/SwfN8QRNwFr95XS0=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-T7mKjD12PKeR-R0JNBqa3w-1; Thu, 16 May 2024 16:32:04 -0400
X-MC-Unique: T7mKjD12PKeR-R0JNBqa3w-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e1bdfff102so770224939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715891523; x=1716496323;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ttpHvlXmiMi2UVt0UbQVx/o7cd/ODV6RN79VD1fX8s4=;
        b=LNVjF5PTF7TmkG6m9rHdpcOU05/VdGzFFGVRQx4SZmFxWrNg8xOBtRE84vzCOtdWUe
         gUjyfyuj6xF2ToH79YHWggluGrKAw536/3EIcTUntCO7ZvRqJfp09235VPj95KMP7UL7
         H12P6FMQLPvltEbO6L/Bc8n71Jgo0q3MyU0KywXUOWjaOA5Q/kqYWouXnlrxkVZ/NORs
         aeb8nU1kvrtphGMR7a3vDPODdZFhAHb8B55nnv1pkHTMYjLeZaTJYB/mz8H1T3IHa4sn
         XfYPTWCmDTJ2qOAAem2UUsQ19BXWHg/g8paAJLixHyJF+0zpTaqMAhUbvp6uGAehMxzm
         KImw==
X-Forwarded-Encrypted: i=1; AJvYcCXPjkasOjqUlV0McU+w+m3EOl507IAf97kcd5xBIafYQS6NKPllAUU2Z0XAc6buWaK1bu9RLB2OZmvXISD6GqF6md+utEgM1TFRbN5u
X-Gm-Message-State: AOJu0Yzem1kk6lJlFii5gGaVc9ejIEuLs4t0Pch9dTKhBixwjQLKCX4h
	ihOoWchs9RxMliKD+4LaC8sCUR9xY85p9vYkdPX9aK7OHaMY9nZ9BCgny1p2lTYADG1HBw++8m7
	nzcIgXiAgTfIFvmGEZg+GHQmk51ntVaEnzfytdmheLi9KyaIh/rzDtqQ6jnuyPQ==
X-Received: by 2002:a5d:9489:0:b0:7e1:c607:ec47 with SMTP id ca18e2360f4ac-7e1c607ed07mr2036729539f.17.1715891523203;
        Thu, 16 May 2024 13:32:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDFnryyubjbN4uSOQA4friH279aw51l08N5liWIry0q3EK3fPSx3KYy87j9W0K7dR91RTAmw==
X-Received: by 2002:a5d:9489:0:b0:7e1:c607:ec47 with SMTP id ca18e2360f4ac-7e1c607ed07mr2036726039f.17.1715891522839;
        Thu, 16 May 2024 13:32:02 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7e1bdc94fa4sm356294239f.48.2024.05.16.13.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 13:32:02 -0700 (PDT)
Date: Thu, 16 May 2024 14:31:59 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Zhao, Yan Y" <yan.y.zhao@intel.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "seanjc@google.com" <seanjc@google.com>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "luto@kernel.org" <luto@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
 <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>, "corbet@lwn.net"
 <corbet@lwn.net>, "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org"
 <will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>
Subject: Re: [PATCH 4/5] vfio/type1: Flush CPU caches on DMA pages in
 non-coherent domains
Message-ID: <20240516143159.0416d6c7.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB52766D78684F6206121590B98CED2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240507061802.20184-1-yan.y.zhao@intel.com>
	<20240507062138.20465-1-yan.y.zhao@intel.com>
	<20240509121049.58238a6f.alex.williamson@redhat.com>
	<Zj33cUe7HYOIfj5N@yzhao56-desk.sh.intel.com>
	<20240510105728.76d97bbb.alex.williamson@redhat.com>
	<ZkG9IEQwi7HG3YBk@yzhao56-desk.sh.intel.com>
	<BN9PR11MB52766D78684F6206121590B98CED2@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 16 May 2024 08:34:20 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Zhao, Yan Y <yan.y.zhao@intel.com>
> > Sent: Monday, May 13, 2024 3:11 PM
> > On Fri, May 10, 2024 at 10:57:28AM -0600, Alex Williamson wrote: =20
> > > On Fri, 10 May 2024 18:31:13 +0800
> > > Yan Zhao <yan.y.zhao@intel.com> wrote:
> > > =20
> > > > On Thu, May 09, 2024 at 12:10:49PM -0600, Alex Williamson wrote: =20
> > > > > On Tue,  7 May 2024 14:21:38 +0800
> > > > > Yan Zhao <yan.y.zhao@intel.com> wrote: =20
> > > > > > @@ -1847,6 +1891,9 @@ static void vfio_test_domain_fgsp(struct =
=20
> > vfio_domain *domain, struct list_head * =20
> > > > > >  		break;
> > > > > >  	}
> > > > > >
> > > > > > +	if (!domain->enforce_cache_coherency)
> > > > > > +		arch_clean_nonsnoop_dma(page_to_phys(pages), =20
> > PAGE_SIZE * 2); =20
> > > > > > + =20
> > > > >
> > > > > Seems like this use case isn't subject to the unmap aspect since =
these
> > > > > are kernel allocated and freed pages rather than userspace pages.
> > > > > There's not an "ongoing use of the page" concern.
> > > > >
> > > > > The window of opportunity for a device to discover and exploit the
> > > > > mapping side issue appears almost impossibly small.
> > > > > =20
> > > > The concern is for a malicious device attempting DMAs automatically.
> > > > Do you think this concern is valid?
> > > > As there're only extra flushes for 4 pages, what about keeping it f=
or safety? =20
> > >
> > > Userspace doesn't know anything about these mappings, so to exploit
> > > them the device would somehow need to discover and interact with the
> > > mapping in the split second that the mapping exists, without exposing
> > > itself with mapping faults at the IOMMU. =20
>=20
> Userspace could guess the attacking ranges based on code, e.g. currently
> the code just tries to use the 1st available IOVA region which likely sta=
rts
> at address 0.
>=20
> and mapping faults don't stop the attack. Just some after-the-fact hint
> revealing the possibility of being attacked. =F0=9F=98=8A

As below, the gap is infinitesimally small, but not zero, and I don't
mind closing it entirely.

> > >
> > > I don't mind keeping the flush before map so that infinitesimal gap
> > > where previous data in physical memory exposed to the device is close=
d,
> > > but I have a much harder time seeing that the flush on unmap to
> > > synchronize physical memory is required.
> > >
> > > For example, the potential KSM use case doesn't exist since the pages
> > > are not owned by the user.  Any subsequent use of the pages would be
> > > subject to the same condition we assumed after allocation, where the
> > > physical data may be inconsistent with the cached data.  It's easy to=
 =20
>=20
> physical data can be different from the cached one at any time. In normal
> case the cache line is marked as dirty and the CPU cache protocol
> guarantees coherency between cache/memory.
>=20
> here we talked about a situation which a malicious user uses non-coherent
> DMA to bypass CPU and makes memory/cache inconsistent when the
> CPU still considers the memory copy is up-to-date (e.g. cacheline is in
> exclusive or shared state). In this case multiple reads from the next-user
> may get different values from cache or memory depending on when the
> cacheline is invalidated.
>=20
> So it's really about a bad inconsistency state which can be recovered only
> by invalidating the cacheline (so memory data is up-to-date) or doing
> a WB-type store (to mark memory copy out-of-date) before the next-use.

Ok, so the initial state may be that the page is zero'd in cache, but
the cacheline is dirty and is therefore the source of truth for all
coherent operations.  In the case where a device has non-coherently
modified physical memory, the coherent results are indeterminate, the
processor could see a value from cache or physical memory.  So these
are in fact different scenarios.

> > > flush 2 pages, but I think it obscures the function of the flush if we
> > > can't articulate the value in this case. =20
>=20
> btw KSM is one example. Jason mentioned in earlier discussion that not all
> free pages are zero-ed before the next use then it'd always good to
> conservatively prevent any potential inconsistent state leaked back to
> the kernel. Though I'm not sure what'd be a real usage in which the next
> user will directly use then uninitialized content w/o doing any meaningful
> writes (which once done then will stop the attacking window)...

Yes, exactly.  Zero'ing the page would obviously reestablish the
coherency, but the page could be reallocated without being zero'd and as
you describe the owner of that page could then get inconsistent
results.  It doesn't fit any use case that I can think of that next
user only cares that the contents of the page are consistent without
writing a specific value, but sure, let's not be the source of that
obscure bug ;)  Thanks,

Alex


