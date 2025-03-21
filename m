Return-Path: <linux-kernel+bounces-571793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14682A6C256
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69EC03BC6A5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F247222FDEB;
	Fri, 21 Mar 2025 18:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="M1IHhNw1"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD09D22E3E2
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581543; cv=none; b=XJvQ/fCQoDjGUvTsUToMSkiECuzQO5tGd4ASwRb0L7XjqkFtqun9xcCAuz8AvgC8gnwr3Pt5mWN3X15pynebmJ3axjVOE3EhB1kvD7jjxih71UPHW1nM8P2+k0LUHraNjHa4UhajSe+zR3C0RF1BvA+jvCG43YfU3XYJF9odtDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581543; c=relaxed/simple;
	bh=jemg1ODGg1pK6bsHf0OEdD0dT3yUnEMJLXk8hBjZYxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2cqi2kCZGKKM3eDjYw9AC5qSuyV6zgD7UZWV3uRtNlw+RQbjrXIHti4npO7odKUD3XA2X9sLOTMfufyz7BosJHwit9+dp5OYrwuFJTN7whLTByJhgnOznMms9BSy4YsiSZaEMapPcgT+QZn2B3s1BLVzeyrtox+k0W+plHEgqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=M1IHhNw1; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-477282401b3so4100101cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742581541; x=1743186341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4DRNDu+mZPYgGquCy2SeZdyPfdQyJHb3d44tNADVang=;
        b=M1IHhNw1R9ZQMCmOQL90iwHYcU1BJw2ArHDDp8y12TvacSzmuiJiPxm4tL5It98war
         MwKZ5fNbPFXORUnQAlA+CN7VUOvL5Ys4TVd0H+Gxh5B+/Xojkt0ouGib6cJoe05lQfsN
         2q+yvGq7jJK3rw+1YSo4BRTmPvGBBguijzYNo5Z7q/Tl5GFwlhTQH0DeNjQ/Q2J2Vv4x
         eHaH1K/Bn3Is7oXTLzD21RTv9yFsHMD/9RpMaMiSmHt+OWI+XwddiKTW3sa0nRc5b/tp
         GBgFxqVO9HkXzirutRhmUk/fU3bBAbF9NspYOpJQY18mTmHtOCaXNasxltcTFRhdB9RN
         R0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742581541; x=1743186341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DRNDu+mZPYgGquCy2SeZdyPfdQyJHb3d44tNADVang=;
        b=qp/QL4V30cKK8JSpJU68wMdGPVTR5mUE2DqfLbCsXlaZTw298zpgdhi2H41pJJHn6y
         cdEFCUXZmzRYzjsHPqOVg5l0pZmKV2CDrCXnHJO02sK1cL58lpC0q/TZhPOWyPwH+xEc
         BGS/vIZdi4By9Hbz/Z3k68vsX72o/Sw9ISYnJWMIEmbKWBrKxEPBKTjrnbk6Ir9hQaR4
         z8cwDcGVzg69R7KfNNXvc5oBM8FyJQQnn6jZKKyI9FwSnqQ2Jy8PbjtwmLAACT/pM3kk
         mvqnOprOcaurY35PY9yMljzIeibSficni8dRC82OiVekaqyxtK+iW34Nr1iBOpE4LZsf
         M16g==
X-Forwarded-Encrypted: i=1; AJvYcCWh5L0EAUphCSrSP/6D2zfLhwTP+zSbhuv4L5Rzm+vgsESiJjNvB537CicSs75/xNQdS7o/ra3D2aXhX/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSFxSPk38xmi4GevfRiq/oO5lg/QVS6CGKsFl46GZhSzedj7j4
	GsHTReMBeGLV8aaH1rXkArJKozOS8BMFP/kgk6NJ6/QLyZv/pkHrICZVU8BrfwA=
X-Gm-Gg: ASbGncu76Qjr2vLrRdmYj8YyF/xDAewQ42nx+2uvjcyWP22s3qYmwTOUb98yZxp8Lq4
	bvVjpmamdTknwCx7yE+GBCvAuE0GS8sFI+vyeVsZAGJw7wN+6JEC4MRXAkceL0IJ0T0jPl5M2DN
	SxU5qsOOXbsRNdon37iH9yzCyh8lzvQlsOxCopRmNSHbK5HwvWHx7F5Gg++1Ryn6bxDKm2+dzFg
	zwu/utHDxb9jPCNUJfhZYJtoIfDEkRXzjFQM8/HG2apGpLXIz7rSty1uoz4Gx9FSRsIHGquOvGO
	WwSYJMcec5gkoH/KNtKDqiFDcnAsshVZfgnc9c0I3jIPTqoqKjNaK4qcXMMFXc0OXZDcyf3qYPm
	2t7GqcKoHz19nn3FWJMYbwxA=
X-Google-Smtp-Source: AGHT+IFpNIlarhIX3KQ1uNeuExxcnUQwaoKxWUOhP9ifvqi6wUM9+9o3gFTu/dM5lv3aP3HzJCq1dQ==
X-Received: by 2002:a05:6214:268f:b0:6e8:ddf6:d122 with SMTP id 6a1803df08f44-6eb3f294de9mr65457026d6.3.1742581540524;
        Fri, 21 Mar 2025 11:25:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efda6ccsm13609536d6.113.2025.03.21.11.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 11:25:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tvh3r-000000016XB-1iiC;
	Fri, 21 Mar 2025 15:25:39 -0300
Date: Fri, 21 Mar 2025 15:25:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
	dakr@kernel.org, robin.murphy@arm.com, aliceryhl@google.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v14 02/11] rust: add dma coherent allocator abstraction.
Message-ID: <20250321182539.GP126678@ziepe.ca>
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
 <20250311174930.2348813-3-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311174930.2348813-3-abdiel.janulgue@gmail.com>

On Tue, Mar 11, 2025 at 07:47:58PM +0200, Abdiel Janulgue wrote:
> +pub struct CoherentAllocation<T: AsBytes + FromBytes> {
> +    dev: ARef<Device>,
> +    dma_handle: bindings::dma_addr_t,
> +    count: usize,
> +    cpu_addr: *mut T,
> +    dma_attrs: Attrs,
> +}

I'd like to point out how memory wasteful this is from what real
drivers are doing today when they use the coherent API. Let's compare
against SMMUv3's use for the CD table..

This would be the code in arm_smmu_alloc_cd_ptr()

It is making a 2 level radix tree.

The cpu_addr is stored in a linear array of pointers:

			struct arm_smmu_cdtab_l2 **l2ptrs;

The dma_addr is encoded into the HW data structure itself:

		arm_smmu_write_cd_l1_desc(&cd_table->l2.l1tab[idx],
						  l2ptr_dma);

The size of the allocation is fixed size:
			*l2ptr = dma_alloc_coherent(smmu->dev, sizeof(**l2ptr),
                                                                ^^^^^^^^^^^^
						    &l2ptr_dma, GFP_KERNEL);

It doesn't need a struct device pointer or reference because this uses
the usual kernel 'fence' reasoning for destruction.

It doesn't even use dma_attrs. (why is this in a long term struct?)

So, smmu manages to do this with a single array of 8 bytes/entry to shadow
the CPU pointer, and recovers the dma_addr from the HW data structure:

			dma_free_coherent(smmu->dev,
					  sizeof(*cd_table->l2.l2ptrs[i]),
					  cd_table->l2.l2ptrs[i],
					  arm_smmu_cd_l1_get_desc(&cd_table->l2.l1tab[i]));

Basically, it was designed to be very memory efficient.

If we imagine driving the same HW in rust the array storing the CPU
pointer would have to expand to 40 bytes/entry to hold every
CoherentAllocation. This means rust would need a new high order memory
allocation to hold the CoherentAllocation memory array!

Jason

