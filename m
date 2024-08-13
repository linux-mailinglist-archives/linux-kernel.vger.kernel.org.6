Return-Path: <linux-kernel+bounces-285236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4A2950B04
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75FCC1F2371A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F4C1A3BB9;
	Tue, 13 Aug 2024 17:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bNcRVM/8"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B2C1A3BAF
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568496; cv=none; b=OnxFDqTr1m2NXVbPXV49f0OG3dDjIuF21gMhdIx2psXZ6AlFf4Cey0Ti0dSd02kvUC6X3qSVqdtmJsf0kq9mqOfFEO4xdlTuXdV05VdC5LLhDCqsXkAwpsx4hgJL6B5OGoprqNyv8UeQffIj7h6u08IsFzGvuCa+zO8i8eKReWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568496; c=relaxed/simple;
	bh=qK7H9c8ScAhkcm7a+Iyl1+AnmCsHVRrU+XjzmjpeyjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VK2IsX1CuaH9lvWfCXmKOGik9lDLVI39+UkT0SdyhB94x4fqwjxgJxqCguMcA9wq4/pI+sy1WpJzdvhnx+PaPznQCDzv7hqW2RnUTw8Fyt1WM8lk5EMrP3zxPfJFbaZ4coGDhguDIsGT5EO9rpcZ6RZyVstoljj/w5ymYiEpi+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bNcRVM/8; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a1dcc7bc05so379830585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723568493; x=1724173293; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zqcYDyfx63llFdcrlT+i8nPzWoVuQ+JI9Z24vWzRXhc=;
        b=bNcRVM/80gGoqc7xJG1M8OMBcvi2AiFWp0C3FJRDWGkUxzcREv4bRiFszh7fgZFAuI
         R5zVEWOt07kuXWOQAQ7uVKrL63s7jWUpDsA25aaf7Mpbj42H6j7LJBflGLX5yFTyf42B
         8ZhFSHliaPqPTnvzGFiFy5jafr23+S9vA87zATH46P7flUTYAD9mAfZqB4Sc6373X2o9
         NdwvDAxiZ5XMurdPLyzBYIJ9RDP+HU6mZjDyx+Frrs149ing6qwYvc9IPP6emjsMuLIm
         rhe/FtXJTsgTca1fcu+M+F6kRXDvrY6xdFKShCCQMEp/iMq5F+brK/eGlYtPy8hbIqxB
         Gk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723568493; x=1724173293;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zqcYDyfx63llFdcrlT+i8nPzWoVuQ+JI9Z24vWzRXhc=;
        b=dGxj2PdLeUJtsJqkwLQOxs5ryNPmmjuZgg0CMdiOp702RMPC/4qxr3Fg/MKgXxc+sN
         kxXm7b7WeWkijXs/qWea7UWPmGVx7SVQwwxHNyF+GQg4dsmNp4fFlzS7xHGwU2LKfGk9
         I9KYuu4WghbLe0d/w3qd+fiiDab3lKEB5LJrbTuF0nSh3Io9+0bHJqysA6H5v7qizSHq
         1HdfD1VeiZ19vThfpYTHIZ0hP15fSM4KfD5+aAiDoxCalHudHcg2+akOsEFh+br0WEET
         UU3ny6yGnoWo1tE7a0EDoBJPYYXLzp0iblpKp7Wvh80T9EpO5LsiJI7jmvMnlYxVxA4P
         TWCw==
X-Gm-Message-State: AOJu0Yw2lc/n0zqZ+NRDIcozI2S6hvzNdtp2yOTYvmTD4RTemEebQurX
	agYXD0VXNX5HloHP40FQBOMXHA1ldASjUB7SMr5O5Z52iQq0zUrJsirwfh5SypA=
X-Google-Smtp-Source: AGHT+IH9qH6c+uE5D7rTpZcL15JqZ+BNudgq7vqqsZepyxSSqNlsyYLjo+0/hLQXF6OoqZycQcsP+A==
X-Received: by 2002:a05:620a:40d5:b0:7a3:6dd9:efa6 with SMTP id af79cd13be357-7a4ee33e36fmr32897085a.33.1723568492820;
        Tue, 13 Aug 2024 10:01:32 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d7122bsm354386885a.40.2024.08.13.10.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 10:01:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sdutm-008ZLC-Ba;
	Tue, 13 Aug 2024 14:01:30 -0300
Date: Tue, 13 Aug 2024 14:01:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, nicolinc@nvidia.com,
	mshavit@google.com
Subject: Re: [PATCH 1/2] iommu/arm-smmu-v3: Match Stall behaviour for S2
Message-ID: <20240813170130.GM1985367@ziepe.ca>
References: <20240812205255.97781-1-smostafa@google.com>
 <20240812205255.97781-2-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240812205255.97781-2-smostafa@google.com>

On Mon, Aug 12, 2024 at 08:52:54PM +0000, Mostafa Saleh wrote:
> S2S must be set when stall model is forced "ARM_SMMU_FEAT_STALL_FORCE".
> But at the moment the driver ignores that, instead of doing the minimum
> and only set S2S for “ARM_SMMU_FEAT_STALL_FORCE” we can just match what
> S1 does which also set it for “ARM_SMMU_FEAT_STALL” and the master
> has requested stalls.
> This makes the driver more consistent when running on different SMMU
> instances with different supported stages.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 +++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index a31460f9f3d4..8d573d9ca93c 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1562,6 +1562,11 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
>  		(cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
>  		FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdmax));
>  
> +	/* S2S is ignored if stage-2 exists but not enabled. */
> +	if (master->stall_enabled &&
> +	    smmu->features & ARM_SMMU_FEAT_TRANS_S2)
> +		target->data[0] |= FIELD_PREP(STRTAB_STE_2_S2S, 1);

The style semes to be to just use

target->data[] |= STRTAB_xx

For single bit, not FIELD_PREP, even though it does work.

And as Robin noted it is data[2], the naming is supposed to make that
apparent with _2_ indicating the word.. But it is quite easy to make
this typo.

Jason

