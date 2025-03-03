Return-Path: <linux-kernel+bounces-542368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35045A4C945
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503783A2636
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C3D253B7A;
	Mon,  3 Mar 2025 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="S49PbncO"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AE622D7AF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020779; cv=none; b=pUFKo66bya/ju9euNjbcuGqUVq5qGsFUTkzYX8JjyCIuSLXTIrB5Detrs4EmkRMKLaP32+xi2b17fLfxcnT/iwWIiBXiM8pZeAQi7Jbnt+Iu0/DGqBMHHV6YPsbZSj0iAcU5YtqeHGN3tYSrshrux5EB9MPoMaTpmbVJlb6IG+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020779; c=relaxed/simple;
	bh=NuqR7JI+G2rJv2MIgkxnyc3Wn5VBjRDy4vT8efoQxDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnaNWtnA1F9sIE65xmQGDt0r9osVKcoqFaTacNR/yiKSRCLxZd2bBT61jW5RXvLBuAfbxQpR3EQvrToay2qR2inisG2/LLDoXOPuJ3v14tyfXgBctJ1xEaeWs3V6IiXQ6g5eY0jyo48hq4CodJ5bx9lDMfLZcrABFHKPInfi42w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=S49PbncO; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c0818add57so513319685a.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741020776; x=1741625576; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vVCncQiFroIxYBskOfYoTQ0oTclWTNPxKFNAE95aCHc=;
        b=S49PbncO0J57pjLhZ8BLv8wvvENboFjZvMxdtA59K83dqawqab4O9xg8GgRm0O+u/q
         8RVJJqRlD20BqqzbWzPOJaDRwPYcQgQpuBxhrg9/Xd4AzmUiNvd1YgxgY/HqcDwGXW7g
         FhhZBO0naNjiOIbzLoOsnAONpULk+nbVresWmWWBcHji7PZ1wPxDojirllWkWLAqmJej
         yHiFt6Wd3d+WrbMsHJmi/tc8cEmzNvydOwEFdo0ojtLiZU03OnlM+OjAf1NGhv5B/gg6
         MFMM3MR0S0JFcTu2CvDLog10iNVwHfQXUMf/7yh0mC0xY6p7KeS8c/JM8iHMmNaJXNFS
         4b5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020776; x=1741625576;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVCncQiFroIxYBskOfYoTQ0oTclWTNPxKFNAE95aCHc=;
        b=XKiTJ6u09Dt8s/R+zxNazEeoH0BQGR72WeFM+bIEVM17UPahzuZy9hKeTl/t4UcoQc
         75ADdvjeSpmpOEJDIeIOdZnxhyo7PmJsJYhi+M2+BLLbdaK06qtTv5XPu6HedHr3G4NT
         m9o8y7N3qUyMJZM5zfBtYDPBhByOe7zG/Yn85LOC966vPWfzq4+JQjO3lfqlDPvxFV2D
         oPGODdG6umf5cUPwrSq8FDD2otn2XD7QDap8GPr4zUfHvuFy2mxzp65S/jWaH3x9PtRV
         vKUhlcAQCnOs32MtH6bQOaRPLqbs9Ud9b0PEFSLI9Woa5QsQChoUbINdBCqN+WM8zqJf
         SBSw==
X-Forwarded-Encrypted: i=1; AJvYcCUhgAKftQYsPcqX0gYpzT9HUuMbIaEJzcZtdAp0MwO0d9BdJcoEVrs4VVeNuVtAf7USD5KMnQiCrRmML7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIu0CBTFPS0xUeoQZ/+jcBk1dizDkbeY3rQPaocO5nVytCswe4
	nYS32oS5TsqRN5rKOo0l896fdocvvNT1xnaETB4K94qN2pYWceewds2OpeT7s/c=
X-Gm-Gg: ASbGncs+qIjZNAY4VCPnxIVR+IHC/E8PJ3ert9vP/zdsS23HWZcyKRBz91ORdCXit9F
	NR0DGErtF9tWatTf5p5ai/k+KK3eDt/7WOnIYb1tpb4hhG4+ANfictCPZUIlEv/I67xbOu56Reu
	6GF/ghgCppjrNh20IzJ1nC3feYBgdkqBtdRmQkpYdhNvQOAYwNTm4N1RLtmk3AlMvMRR7iftZMM
	rPy4GWKn+XSOO7GDsIRUD9oQe7azExkzbZb8vDejGV0LXi0lsiEUIadoni3uswxUWAiC57p5n3s
	rAlL7ExTtBN2DM4fb08oAIsdQ+hQLaO8z8z4Z5MnhjItVvNLs6hZW596JOHJCvF8O1Uhx1EbmjB
	lruMjVitETcxRvZ4GZQ==
X-Google-Smtp-Source: AGHT+IFIf6jYsBfdvTc0EikS5Xpb0DbNcOeZPaKcF5x+vop09uaQoyucRacuzLKsWcUPdgqNiYKzIQ==
X-Received: by 2002:a05:620a:190f:b0:7c0:b690:8468 with SMTP id af79cd13be357-7c39c4ca479mr1861404285a.33.1741020776537;
        Mon, 03 Mar 2025 08:52:56 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3b8cd9d36sm165720585a.104.2025.03.03.08.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:52:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tp92F-00000000ok6-047X;
	Mon, 03 Mar 2025 12:52:55 -0400
Date: Mon, 3 Mar 2025 12:52:55 -0400
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
Message-ID: <20250303165255.GS5011@ziepe.ca>
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-6-miko.lenczewski@arm.com>
 <20250228193221.GM5011@ziepe.ca>
 <b23aa37f8e864dea82a6143bece912d6@huawei.com>
 <20250303103102.GC13345@e133081.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250303103102.GC13345@e133081.arm.com>

On Mon, Mar 03, 2025 at 10:31:02AM +0000, Mikołaj Lenczewski wrote:

> > > On such a system it seems like your series would break previously
> > > working SVA support because this patch will end up disabling it?
> 
> Perhaps my understanding is flawed here, but I was under the impression
> that with SVA both the core and smmu MUST support BBML2 to use it safely
> for core translations? 

Yes

But today's kernel does not use BBML2 in the CPU or the SMMU so it is
compatible with everything.

So it is an upgrade issue, going from today's kernel without any BBML2
support to tomorrow's kernel that does then you loose SVA on
previously working HW.

> Hopefully, as you say, the MIDR list restricts the breakage to a limited
> (ideally, zero-size) set of implementations which advertise BBML2
> without conflict aborts, but which do not support BBML2 on the smmu.
> 
> However, if my understanding of the BBML2 feature and how it interacts
> with SVA is flawed, this will obviously be something for me to fix.

Lets hope, I was not able to discover any NVIDIA platforms that have
an issue with this series as is.

But every addition to the MIDR list will require some consideration :\

> On independently enabling BBML2 on the smmu but not the CPU, this should
> be possible.

What about the reverse? Could we disable BBML2 on the CPU side on a
per-mm basis? Ie when an old SMMU attaches with disable the
incompatible feature? Not something for this series, but if we get
into trouble down the road

Jason

