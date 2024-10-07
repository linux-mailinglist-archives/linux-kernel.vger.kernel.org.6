Return-Path: <linux-kernel+bounces-353971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B63993562
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24E3C1C227D4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CC71D7E52;
	Mon,  7 Oct 2024 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jbvtclPH"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F65A1D54F0
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323436; cv=none; b=DMQx2A1wnYetwBP0HtJ2mr8OFOgEc8eK3Z49PfzE9ykut9ySg1XKkMEK9WR2Rch0+9MgyVu/WXN7gX7Bz9dzDauBpvGW3euOFRTo0phE1Y8iDa4gjfVfY3wDU9NnDHceqEOVHavHA654Dfah2LV+nYc0i4OqZ8ELZbvzop5hiYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323436; c=relaxed/simple;
	bh=VDQOtunXaBm327yhGFJI4mV/zWjpno00O6cueSpmoHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akuvHD5DiokuTGMa34awIHmKDp9dlYYTkso0JPGwOVqbgzmrsiHFQ+WybTJvRud8OIovW/F6J8qF7gEPD/O5SjN63ycXaJcR7z82qOf1Co4h6w/5kdkztEV2ZCkG7k438H3/EhHvzu7NKroL4nB7EgHA6vJAnsK7pRv9TWjjhLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jbvtclPH; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4582f9abb43so33142861cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 10:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728323433; x=1728928233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ic8at5+otSdzszh8Cqp2pOJxMeWQBAZY6eTCFkXBnAk=;
        b=jbvtclPHoZe9lMm5ezElqFd3NWp4/yzGAEXK1mkA5b3PppxxNCpYL8n4+ok3kNI7Cv
         mSekzTAvxRiqAXgG1iz0V94wN3S8vkZrW5O9xUpU1R1MtzUgKoEowBUjnqO1chxzGZtr
         ocBWVd6rhHFasw76vVfqYKRlJZ/01QdvgK5sG4q9QugDMPAwSboDYWYwzqonrERLr7pn
         XERAQRhBkN8WlUS2ARMW3IQwuSbNvek+Qc3dazJz0zKpSvMapJo7TmWSRkHec+aMEIG6
         o6feDjaw98OeguhyJX7tP5VNTxBQT8gL5JfU9dDmVsVrstfvq7qCK7j95j5ykLNsjxbo
         ShyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728323433; x=1728928233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ic8at5+otSdzszh8Cqp2pOJxMeWQBAZY6eTCFkXBnAk=;
        b=hv2gA5RW0A7M7WVotvkmw4zr0QN5lRqZk6B8qJDKgJ/Svs6vCmvFF2Z3sMoGKNBub/
         Yb25Qdl2FwoH0iMnp+/O6V2ocEwGR7f0YWbyfmv7/QgwJir9rKmJ4vh9rGpe8XO3BYU+
         adAJsc6Z+L9yzNDg3cceQjJMvMam/dKs27s2Senu7Od9zrTmnTSpjeVSUaVap4w/ZnZv
         XUPpGrkcb+bktDqXXbCeNY3mocoM7Eu4rEKpFSb0lizQV9Iumk1ZIZBz3UY/V7f2v+S8
         8GQiodSreuUIlx+XC6Y9gD9HcLxCFEHUrNpHG5oDzOufeTp2UQ7aPXyiR6iIlIpDnBmd
         pzlA==
X-Forwarded-Encrypted: i=1; AJvYcCUtTKfm3WSDjNYn6BflkizNGvoIloDPG1cLKrIQx38PMUnOHnj+dveZef8hyLDFvgOuAjLyY03syBq/Q+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/stvzOzMU0HMp+YZ+uFEzlPwVyJIq4EwYgXdIfp/MoO3Cu6xY
	QvW3HcS4AbVSM7MTxLVZO8gY2z8k9I3aWf4O4t/bz+60ihgUeweNDYUwZXmibEQ=
X-Google-Smtp-Source: AGHT+IH8DysIajFIpReTEYO72Lftr4AtqQsuMgp01JqOWKWeypQD47i7esStBCXc03ss2SVLA+5wRw==
X-Received: by 2002:a05:622a:199e:b0:456:937e:2f76 with SMTP id d75a77b69052e-45d9bb5b3f0mr209203021cf.39.1728323433395;
        Mon, 07 Oct 2024 10:50:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da7506d6csm28564521cf.37.2024.10.07.10.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 10:50:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sxrsO-003MTO-2i;
	Mon, 07 Oct 2024 14:50:32 -0300
Date: Mon, 7 Oct 2024 14:50:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: Daniel Mentz <danielmentz@google.com>, nicolinc@nvidia.com,
	james.morse@arm.com, will@kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
Message-ID: <20241007175032.GA762027@ziepe.ca>
References: <20241004180405.555194-1-yang@os.amperecomputing.com>
 <CAE2F3rDH3aK-OLO6TSXgQFU+DDx6Rq+4uwLQb3WZ+CMWWEGCNQ@mail.gmail.com>
 <87ac9686-cffb-43ac-b8f0-ccd3632fe5cd@os.amperecomputing.com>
 <CAE2F3rARZ_qq7MYnAT7nNKcNsL3DzaTH+ehPTNrwaaP20d9Cag@mail.gmail.com>
 <faf12f39-0048-4e47-b600-e686cf82afe1@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faf12f39-0048-4e47-b600-e686cf82afe1@os.amperecomputing.com>

On Fri, Oct 04, 2024 at 06:53:25PM -0700, Yang Shi wrote:

> Yes, SIZE_MAX is ~(size_t)0, but size_t is unsigned long on ARM64. So the
> check actually doesn't do what I expect it should do. U32_MAX should be
> used.

SIZE_MAX is right:

static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
		dma_addr_t *dma_handle, gfp_t gfp)

It is up to dmam_alloc_coherent() to not truncate it's arguments, when
you pass the u64 bounded to SIZE_MAX you guarentee that size will be a
valid value.

> > I think it should be capped to STRTAB_MAX_L1_ENTRIES
> 
> I'm not expert on SMMU. Does the linear stream table have the same cap as
> 2-level stream table? Is this defined by the hardware spec? If it is not,
> why should we pick this value?

Well, the way the driver works is in the 2 level mode it caps the
whole table to STRTAB_MAX_L1_ENTRIES * STRTAB_NUM_L2_STES total SIDs
which is 0x2000000 or 26 bits

I guess there is a reasonable argument that linear or 2 level should
have the same software enforced max size. Though would put it at a max
2G linear STE which is still larger than Linux can allocate, so it
doesn't really make any practical difference compared to SIZE_MAX.

Jason

