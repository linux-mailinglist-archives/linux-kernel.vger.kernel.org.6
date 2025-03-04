Return-Path: <linux-kernel+bounces-544927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E45EA4E69C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018DA1770FC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2072BEC4D;
	Tue,  4 Mar 2025 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YJXc87oG"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FE42BEC36
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105187; cv=none; b=cYn6DQZdai3N6VA8e7NBv8F1lZwHfSxR13YC/Wm8TYXkeOwRiPFSzR4+vAkXw9XzK3RYEoBWGorcDsBL1727P3plNbNWRu3gXriODz2CwMMEWtyyaYanBJlVfUNmMZA3B6kkX3zZrNSiJPr8Z3PIrQLRES6DZPs7HM4uE3ja3Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105187; c=relaxed/simple;
	bh=BEQy1uoQGIdDIi3PrKYRnsp/aLnLk9DPsaBIdyAvs4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaVmFm4pjjwHydXTLPsUKl0eubjG+MrbDT18kmk38geozdWTXXYaAZAwLUoWmN1pgl1aV0hpsTXZetO4bF+H2Jw741cbtbaSv2uvjtwqIbpK59Ptgv0OiQ4ZqisuOPKNZOuTG5gZy3rB9WnOcQxfDnY9Ulmb0I98QmVHp8ojDtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YJXc87oG; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-474f836eb4cso13259951cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 08:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741105185; x=1741709985; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+QyCC8CcTX+xQp+BLqbobfaOcWMa+Lol1b2+RKYTYvw=;
        b=YJXc87oGp1EljRkk6moYTp4Qg1P3mn3h3EeR0Mk3EZMmxNLwKXQaZIoLTe57pKHlBa
         kOal4OEEKy/Ij3LpNbkL43BbKCaZt/zNhgArx0txOuL5ywEuXCVbxgBdpE1vh169cqd+
         QyACnsFDgIy35K2zMBbbmXfDv8P67ceXbjoOMToZaC6xE4439d9Nbeu+1NxFnbFbY93Z
         qZ1sDDlmacW5CIF1CcwLVuIhbGZSDS+erpBCrqLh8LCYZtGy7TGPsgClRDjD0zhaNBUS
         OrKoceSJyPNE7eYucGo72FgNyO4a6pq2PB2X8KrmRIA5qUEvrlq1dRWf+yFTw5eWq4gu
         jRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741105185; x=1741709985;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+QyCC8CcTX+xQp+BLqbobfaOcWMa+Lol1b2+RKYTYvw=;
        b=QCEBmJVsFysO5m3O5jrQAvr35C1tN0A1QcFF8wkPTvT9qb7rJ2DIsg00qWgx7J0p/V
         LtFL485Opec9fT2rEDoUBxbSwiDtKzSSKW1VECWApmykqAoLHi/o+ncYiDCMzu6fzPbj
         MKlD3IprWx3uTcH+5Z1iLunxgysD1Kc92bVtiAf3Ll4Ez74/7TSgwDMR/VM17funvTGb
         tZ6lc/l6pjDAbuyLl3GF2VN71BLrVWmkPm/bkkkqfidR9O3xw63GWJuIzCOccPqhKxf5
         rWIJEzRl3voNbDRqj0zMaQYOiSXX5Ig4qxhSCVZIqQ7vPOP+UCKcKqv+naeEMmzT/qmq
         Gx1g==
X-Forwarded-Encrypted: i=1; AJvYcCULoImbn/MTB6zOaEUissJmWwQxoOVNGj2h3TCEJHv9Xuv+pPcegtn7JgxjaqFqPjpqRBSXsIn8mHNNgXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDHwYUCg9QWjGOx4UGQh3SrJgTiyhv4PrcJOmvDXhRsaIOor9N
	PxI1162PpGt7fpfMAw9EZ+vMhZrlZsO11tSemQNsr6R2//Z0JMaGlS7iwEB+GKc=
X-Gm-Gg: ASbGncvDPFplugeYGiO6J2Bs/u3r5HmF5cZGWyOqa9EyeTroiz7CEmiRNzfCo7ZDdLe
	w6sKYXwvB4x/1X1s0QoKKZGshByEqaO3hr/FKTZce8I2GvqLInMDozeMic/Ud/Wg05jQKlYv18u
	TpXEhNx4eMTDmitpwUeLogMlBfXMOcRxKXV+lhP1v9osIkTZ2UOAs3FSnfxG/OZ3w/e04kLQDs9
	4qWl3sqPKU37b/MlVHjlhreJ6fpxsFm0UGgA6UVJx1LEdpFRDuie0inycoCwCNLGgVn9LlLioBM
	vtO5SedTayvL2kZZXvffgKYOMQ61Y7inmQdNHPg53yn+G1wBUabU48B3awDvstV7JR3zEhcYDlG
	wh3OTnRlvNmUCr8k2SQ==
X-Google-Smtp-Source: AGHT+IEh35K+Rji/J97KgXv7b0qtNlNusVFI1SmT/EdTjyyFjXOLkEHdIcDO3dFOzig1wg6gty4MyA==
X-Received: by 2002:ac8:5dd1:0:b0:472:15a8:4021 with SMTP id d75a77b69052e-474bc100267mr252633741cf.37.1741105184975;
        Tue, 04 Mar 2025 08:19:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474f9a4f6a2sm17784561cf.1.2025.03.04.08.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:19:44 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tpUzf-00000001Go8-445C;
	Tue, 04 Mar 2025 12:19:43 -0400
Date: Tue, 4 Mar 2025 12:19:43 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
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
Message-ID: <20250304161943.GD5011@ziepe.ca>
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-6-miko.lenczewski@arm.com>
 <20250228193221.GM5011@ziepe.ca>
 <b23aa37f8e864dea82a6143bece912d6@huawei.com>
 <20250303103102.GC13345@e133081.arm.com>
 <20250303165255.GS5011@ziepe.ca>
 <20250303190330.GA426248@e133081.arm.com>
 <20250304142634.GC5011@ziepe.ca>
 <67fbe3f4-4fb6-4753-b34c-320b7897fd16@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67fbe3f4-4fb6-4753-b34c-320b7897fd16@arm.com>

On Tue, Mar 04, 2025 at 04:02:20PM +0000, Ryan Roberts wrote:
> On 04/03/2025 14:26, Jason Gunthorpe wrote:
> > On Mon, Mar 03, 2025 at 07:03:42PM +0000, Mikołaj Lenczewski wrote:
> > 
> >> For example, if we use BBML2 for kernel mappings, does that require us
> >> to repaint all kernel mappings when disabling BBML2 on smmu attach? I
> >> am not sure, but definitely something to be worked out.
> > 
> > No, it would be a per-mm_struct basis only if we did something like
> > that
> > 
> > When the SMMU driver puts a SVA on top of the mm_struct it would
> > disable BBML2 usage only for that mm_struct and it's contained VMAs.
> 
> I guess we would need to figure out some synchonization mechanism if disabling
> BBML2 dynaically per-mm. If there was already a BBML2 operation in flight would
> want to wait for it to end. But that's a problem to solve if/when it's shown to
> be needed, I think.

I have a feeling we can piggyback on the mmu notifiers to achieve this
as all the changes to the PTEs should be bracketed by notifier
callbacks..

Let's hope it isn't needed.

Jasob

