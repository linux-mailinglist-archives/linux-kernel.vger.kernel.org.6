Return-Path: <linux-kernel+bounces-443851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 144499EFCB2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF181631C3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB67319C543;
	Thu, 12 Dec 2024 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="A1C0asuM"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39E118A6B5
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734032679; cv=none; b=ElKDMf82X5CHN8n+79LvB1My6bMSmN/2PGZd35bTiDjB5rglbA6NbbtVQKciST8amfW0gg6gDCg1CRezj9klCFHiiKTyeD7mHW8kZmQAW5SdBZYVImAMsz2FDfFLFxofvtrbg5V7vzNT3UqN5YVsDLQ0ZOpbVVPO61TibM1IOcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734032679; c=relaxed/simple;
	bh=45Ud0Mn2aNdFEQLclVcWubuH1Q8UAhrJeGlwWksFBLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sz7pQcKOaWDkjpii4eOE8i3Tt+1JZSLiKYg/wd0g6M6WYuh/BwOtJ5qIMHU/BLYIsFsUdhZeKf9/vo6PBi2txqCG0iuX9EWr1OvrPJIj4ZsRnwI8NYmi+kg2AkZ0QEo9C3uw0tl93YAl/CBIrShIjUkKsenHt6sqMl7pJAmGXZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=A1C0asuM; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46772a0f8fbso8667491cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1734032677; x=1734637477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mtig8lXsoUwLD51T1aq3aT1xZ4mrN3No+06U1nAA6eA=;
        b=A1C0asuMT0apj/rmDRKm1EeIV96/ox1RZo6u0NfCJMQulFp/7GpQt1YlqLDARmDf7O
         Fx5TRsTxGiYuDwVdItnhbHQQM4B+SE/3InHTclNpLpzQHkLBHpjtfUEps3yxVrNUTYrj
         F5p6kX/dw25Ao9af1aOviwzxQ1jS4ylVTeB804aiZGeBUPwN3X+hpROPI6Ss7u5dWiBp
         Jng7mI3UEw9Y28NwONbsyRJNqaYuD+Qb9oqSOVexDfKGNx0JNdsahMw0VVQaj+98CsHC
         i8LPyXh60av8j0FQzYZ75y37jTAtVPSoGzOgS3Rva36z8c6eU46clLeHXyqgs3pS+XJI
         DC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734032677; x=1734637477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mtig8lXsoUwLD51T1aq3aT1xZ4mrN3No+06U1nAA6eA=;
        b=DQaTw/Gei3cA1BUv4XOw+3RYEv4Y1AP32j2UWzQcikPT+jUvviXJxKzumvpo844xy9
         xSZWe9sJ0Gio9kgwTkYgCjviiykOvZlAYh7614UrxlKfefFyk3lJPGtALI1CFHx5vO4z
         zazXBCj2ZMgbT76Xa4x6abB6aTiPTuGwuHYGmrUQYPFMOygLzN14tayteilXpK9I1W4W
         +TW/whCFZUViOMyPanVSHm3MgjtKYc6lvLUDkth73Qa8hRkmhF2vAcVkh+27uonbdUr+
         g64C0G2pH1bqzUn79DqlZNSA8rhahh1TbqLy0XCU84/haFRpv5ZthzMhNuqFgX3rXwf9
         vx9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFQtTSVrohe8w+Df85XfmNCe/NAhK7tvPLD00WAqxl7AS/OvoSWTonEAByhgNRo4SGrevaZ26v3kfGANA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCZmKYugMGuXvtRFHDhu61GgLJB5dqDFBXzCqRAdRThm3NyAwU
	hY+lNB0UU/fSECGA6KMIJ6obX6XWSvDyBQ2DVu/yKRkkFEjl9g2G2MQPA57Zwns=
X-Gm-Gg: ASbGnctLSDH9ZSTRq3axpg/nqIURyFv4XJd4fSf+nEJA+5tQFsH1dUInFfOBOdwN/y8
	0Agka08u9Hm8dykhh5k4lsSGXaq6kOvS2oj5+W1Ir575/ZYVDvB7a0vXejsIuaWotY+edQ9zs32
	zp9zMLWLf47RH0/cXQ3TRtZySvc6enpzk2haHJCXuOCYgbL1iG4I5e+fJ6OwIv7VYTTdTG4DYQv
	c+50bhPkojJ5+3u9A4CqHt6CAqShsCjO0FqAmoIqNiAVxDUNrxz4SEkr8gzBAyIy6lMAB+fYKm7
	bGZHo3elqI7NjzRZ9H6QuPLSV5SiYw==
X-Google-Smtp-Source: AGHT+IE1sxaWouFki1wTNuqW4Mldx9O5wExQbsXpYwJ4pEsT62nJIL+C/8F//xL6ak8oICXCgpkwJg==
X-Received: by 2002:a05:622a:1114:b0:466:9f89:3d6b with SMTP id d75a77b69052e-467a156ffb2mr26650471cf.24.1734032676656;
        Thu, 12 Dec 2024 11:44:36 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46783eb0d91sm28376531cf.63.2024.12.12.11.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 11:44:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tLp6x-000000001Zr-0B7D;
	Thu, 12 Dec 2024 15:44:35 -0400
Date: Thu, 12 Dec 2024 15:44:35 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, robdclark@gmail.com, joro@8bytes.org,
	robin.murphy@arm.com, jean-philippe@linaro.org, nicolinc@nvidia.com,
	vdonnefort@google.com, qperret@google.com, tabba@google.com,
	danielmentz@google.com, tzukui@google.com
Subject: Re: [RFC PATCH v2 40/58] KVM: arm64: smmu-v3: Add map/unmap pages
 and iova_to_phys
Message-ID: <20241212194435.GA5484@ziepe.ca>
References: <20241212180423.1578358-1-smostafa@google.com>
 <20241212180423.1578358-41-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212180423.1578358-41-smostafa@google.com>

On Thu, Dec 12, 2024 at 06:04:04PM +0000, Mostafa Saleh wrote:
> Add map_pages and iova_to_phys HVC code, which
> mainly calls the io-pgtable.
> 
> For unmap_pages, we rely on IO_PGTABLE_QUIRK_UNMAP_INVAL, where the
> driver first calls unmap_pages which invalidate all the pages as
> a typical unmap, issuing all the necessary TLB invalidations.
> Then, we will start a page table with 2 callbacks:
> - visit_leaf: for each unmapped leaf, it would decrement the refcount
>   of the page using __pkvm_host_unuse_dma(), reversing the what IOMMU
>   core does in map.
> - visit_post_table: this would free any invalidated tables as they
>   wouldn't be freed because of the quirk.

I don't know if the timelines will work out, but the pagetable stuff
I'm working on will let you write a much more appropriate
implementation for pkvm's usage than trying to hack it into the
iopgtable code like this.

Even the iommu focused routines I have got now would solve this
problem because they allways spit out a linked list of all the memory
to free after map/unmap and never internally free it..

Jason

