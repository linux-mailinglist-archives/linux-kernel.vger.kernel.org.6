Return-Path: <linux-kernel+bounces-544417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2A8A4E0F0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C195177768
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7502066C8;
	Tue,  4 Mar 2025 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="W4C0W04C"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2862066CC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098398; cv=none; b=BYsp5xhUgTna4qGk/Aj0Lt6GxCuxGVw/PSdJbLcnB2QT45sUT12pjMcO2iPO8slcqIFBn9RpLb1fkM9+AOLwhiaImVE8+Hvk5FLpwTahJbHXzb5qIQltTvx2AUZF/ElJL3MGrFo5Z4C26Y2zAXNISyld6pa95uwMk21bsUd1nOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098398; c=relaxed/simple;
	bh=ZZ7KMHGJDKL1wdw85tJIpxyh4i61E6zj6IeC9gOCMHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLeBqEB1qXNZWF8msCiJiejJWpJVcwBZbyU1z0gA4YpElILsQ+C7smAZUlz/49F/Z99Q/jIFN7To8KynNwPVY/04M7JRbZK0YgrZEcX0mQKA4HiS9PxZXX6kskTzWiv9iTaEGD98bsWiFcKR2MFeSP+lJ6tOsXQu9bOu8A1xJMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=W4C0W04C; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-474f8d2f21aso12541141cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 06:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741098396; x=1741703196; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZZ7KMHGJDKL1wdw85tJIpxyh4i61E6zj6IeC9gOCMHg=;
        b=W4C0W04CM9pZEXP8wsmDtSIgVd0Pz9LmwYz6riJMbWCq4lqgcf+mlBO26ZHK5QzmqS
         A+pY+Eb6kced0DsTFDKrPqgfHmYqJqA3OYj5OY04yXCuVKGooWw3n8OU/xRISmIo6aSm
         k8XWNK2ram1eDH43i25jy8SAfhfpnNwB8/sIEmLaCEe0NcdKUKxVQqaytVn/7CeGfLDk
         D2QH4XfDuyRtfHfnrpjpDBGQf3wo29VF2tiPYdRPCrQnU36GpoVQctVMRMMdxu3l+TbB
         78hTE0l2PQsxjZ6gfLEjf76dGBg05dk3f4Q0SiOkkKGGuR7BaqZmSHBBUV1ChE1EVAwc
         z4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741098396; x=1741703196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZ7KMHGJDKL1wdw85tJIpxyh4i61E6zj6IeC9gOCMHg=;
        b=PAENWkgC7miSoC2CYUS4WtZXyXsXna+7/87QsEqIvASFlfUgnIkuRQTCAEgUlMYVTN
         S/VfPfPZnwxM78hM2pqkMRq99OmekG2tERg3XqvsEzKdnHGNeBkDsPvKxRaD2mt5RrEJ
         7kYMl4faT6RMvW327txNw2daV5q41V1UUxeBbgbar0/JPQgeogOhlXnJ9ueAABsoHR7n
         qGvdyMe2RdmzxwbJEabuPR5Xh17krFu6bMP0bq5l/UkhTV4WVGYmID92Z7BfVBvxL0Bg
         ZsHpisSu94mUrVmeB5DJJ0Srl4K7ZFi7MgJn7S8hArlFLjpmEkNBrDvSlZeAP62mVr8T
         xvCg==
X-Forwarded-Encrypted: i=1; AJvYcCX2jlm0mQyh0eUek3RWuGtODLESCYAY3btdHKBTbYsEpzKTvsCIG5RvYPYSqxDsiVGA1RkAgUysRsNzWFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAtIxqb1H19r6BgtILDjNZlXuQl0rRT6ALltFN7D6FJ73M3tHM
	/ORlfWB9hgBu2Yvj4c5mjU02z1M7SQPXoYxhA8PToLQjQFBgoEDsubL3mMk+H0s=
X-Gm-Gg: ASbGncu8SOGxXuGRUwO74VB42m1B74CTHePB8hmjswMdkr9qrWm4ZZBm1OEKtHaivh2
	va66RNUKAKL4M7b+QEOmR0+wpVcBP5/Hm0vCSp/iDm88+ohhhfOUoC+O0TM1CPEqXMV1TcC83Wb
	p4Yj1rTWKCZUQATck9hWHel/YU67W2ptdZq4CzE9YljrsOyoraB3dm+KgCN3dA+lER3bItEhihY
	912wqTu60EDw/4cILK5tFnDdScnsnj8JR1v0H63oFpHY0H666IYqLJ9/pk8YPanKCh28VXhoyV0
	3+gaHj/JhDu67e+2iHcXGVGzGcpczleBL8tFM5vtYSpzSrh7jyHNrQrEp8ROvNOesVH4c+ZB/BS
	nwfnv1eOeM2sd5TE6dA==
X-Google-Smtp-Source: AGHT+IGpGwzh4Elz0HvbqFWhkWlBebcf1jH6YCXchA+m15FaB7zfVQNpWK5QB2cePx+kDOFF5fxCRg==
X-Received: by 2002:ac8:57c2:0:b0:471:f482:bba7 with SMTP id d75a77b69052e-474fbd559afmr45366221cf.22.1741098395939;
        Tue, 04 Mar 2025 06:26:35 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474f2875726sm21811991cf.8.2025.03.04.06.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 06:26:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tpTEA-0000000179G-3zqe;
	Tue, 04 Mar 2025 10:26:34 -0400
Date: Tue, 4 Mar 2025 10:26:34 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"maz@kernel.org" <maz@kernel.org>,
	"david@redhat.com" <david@redhat.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"mshavit@google.com" <mshavit@google.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"smostafa@google.com" <smostafa@google.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v2 4/4] iommu/arm: Add BBM Level 2 smmu feature
Message-ID: <20250304142634.GC5011@ziepe.ca>
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-6-miko.lenczewski@arm.com>
 <20250228193221.GM5011@ziepe.ca>
 <b23aa37f8e864dea82a6143bece912d6@huawei.com>
 <20250303103102.GC13345@e133081.arm.com>
 <20250303165255.GS5011@ziepe.ca>
 <20250303190330.GA426248@e133081.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250303190330.GA426248@e133081.arm.com>

On Mon, Mar 03, 2025 at 07:03:42PM +0000, Mikołaj Lenczewski wrote:

> For example, if we use BBML2 for kernel mappings, does that require us
> to repaint all kernel mappings when disabling BBML2 on smmu attach? I
> am not sure, but definitely something to be worked out.

No, it would be a per-mm_struct basis only if we did something like
that

When the SMMU driver puts a SVA on top of the mm_struct it would
disable BBML2 usage only for that mm_struct and it's contained VMAs.

Kernel mappings are never made into a SVA so are not effected.
Userspace only.

Jason

