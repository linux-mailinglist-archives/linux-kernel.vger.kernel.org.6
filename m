Return-Path: <linux-kernel+bounces-309428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAA9966A56
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224591F23905
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF4D1BF33D;
	Fri, 30 Aug 2024 20:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DJR7ml/y"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E11E1BDAA8
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725049255; cv=none; b=HHyO1K6+GCQnYqULHkqzUZNZnmSJQaU+0+aPG55IG8sz3JL/dAVKrxRBRidsqJiDu7trJ9Y5xojTegztIYbT0K5lo6goHFwqFBY5LqNcdmc173EEF+ho5mH4a7hYkpMSVNIPQT/eT/hYln/FhxJBDgLh7ZfXmpLBPs8He7aLDpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725049255; c=relaxed/simple;
	bh=x940T/CWdOLitdTMf0+Kq/bsjfn2qskNi3/i39EhhZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIzdSwcGESM6Ie7Zf5SpB3/Rp/SRlZFS7KXyuUxlCRyPpH4XP3BQd7Q89fg9jFZxsAxVolf0DqyHcNYp0/j6LmMqbLmMXRcLGfnVdxhzZNQLgo2BxF71rlZsKnJQcSv+eoG9XwYOH9N9zBuFa3DFm3Att2w1Y3P5qvfRyHU11Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DJR7ml/y; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a8160a7239so60774385a.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1725049252; x=1725654052; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C3rag6kG53WcMSHubZMStlK3s50dmNUdZFfCovwHxTw=;
        b=DJR7ml/y5teNufK29OtCsgOpYX1QrzZHdXx3YC7luV6svo7BqKoDxH8eakcP0Br274
         pQlzSPZISHvtv/S3BkGkHtq2+zwNQJhKH+GTwb7yJi3qCe41iWKy+jEfD8hyrfjDDkH0
         88k8PuB5ynTs0fnQbfQjl8wP5sBm3YNgorwJy6/Z5hVJR4wGxGzsePfyqTxz/eYdUk2G
         QCw7BT/FPUDy82E53hJscfv826sdmwbihI7axkrP7+L7T7oOsfGh4oHJHyunfoppMblx
         vfz+OmDWaC4EZVz9hIS5ny/KkkFzAOpCNGO5PS2m7crTHI8RxS2r4RSaf3d6Nx2We7Lm
         KFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725049252; x=1725654052;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C3rag6kG53WcMSHubZMStlK3s50dmNUdZFfCovwHxTw=;
        b=qlZrXy+IIl+7Y25CHFQ+9Z83GiG3YILECliO0mFe2mTtPKse761kMUgj+0J8vjIRtx
         s01TIP/hSKPuetMc2P+Y7s7iXDJmcGRTRYvQBjGl92RcDKzazOmJxltSJF5WN1Db0NzX
         30HvpqF9NjKYr+jv3/X5rNUFYKHuKeoaMj+aE+e2RgPjXSvl1LP7ROLiuStEbau4eiRd
         pY3asfBOHtRPcVMdwjb03/S01vmS8wYoIprWUujDqYk3dhAtyQ7Bbk9rmDk7lwDQl0PV
         nj8i744xrScb3Y0o2EQ4rM2jERin6wl8PsIDSWTUZPL32QMq9q4RgOCOxotrlTkNaBB/
         OVeA==
X-Gm-Message-State: AOJu0YwfTQMX5bxH4aKgaFS+0pfl4zZJ/OLYbUB8+iJer6vEa+09whgs
	2J1Ua9z4hbh/IXcGKFkEnkXpzgh2q3/8XjaI1dEyJSpVyizi1AM/9R8TFSzqmbM=
X-Google-Smtp-Source: AGHT+IGa8ZC6ULosslU6KxF4lsKV5fNNPBipe3IFWTAzo3iClKo/pIRjeGZnnW+uV6FdOsonKj5d1Q==
X-Received: by 2002:a05:620a:240c:b0:7a1:e001:bb1b with SMTP id af79cd13be357-7a80429221amr701958385a.60.1725049252392;
        Fri, 30 Aug 2024 13:20:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806c4cd7csm175949185a.69.2024.08.30.13.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 13:20:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sk871-00GaTI-1j;
	Fri, 30 Aug 2024 17:20:51 -0300
Date: Fri, 30 Aug 2024 17:20:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, jean-philippe@linaro.org,
	nicolinc@nvidia.com, mshavit@google.com
Subject: Re: [PATCH v4 1/2] iommu/arm-smmu-v3: Match Stall behaviour for S2
Message-ID: <20240830202051.GA3468552@ziepe.ca>
References: <20240830110349.797399-1-smostafa@google.com>
 <20240830110349.797399-2-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240830110349.797399-2-smostafa@google.com>

On Fri, Aug 30, 2024 at 11:03:47AM +0000, Mostafa Saleh wrote:
> According to the spec (ARM IHI 0070 F.b), in
> "5.5 Fault configuration (A, R, S bits)":
>     A STE with stage 2 translation enabled and STE.S2S == 0 is
>     considered ILLEGAL if SMMU_IDR0.STALL_MODEL == 0b10.
> 
> Also described in the pseudocode “SteIllegal()”
>     if STE.Config == '11x' then
>         [..]
>         if eff_idr0_stall_model == '10' && STE.S2S == '0' then
>             // stall_model forcing stall, but S2S == 0
>             return TRUE;
> 
> Which means, S2S must be set when stall model is
> "ARM_SMMU_FEAT_STALL_FORCE", but currently the driver ignores that.
> 
> Although, the driver can do the minimum and only set S2S for
> “ARM_SMMU_FEAT_STALL_FORCE”, it is more consistent to match S1
> behaviour, which also sets it for “ARM_SMMU_FEAT_STALL” if the
> master has requested stalls.

Hum, that is looking a bit out of date
perhaps. ARM_SMMU_FEAT_STALL_FORCE should definately set stall, but
for stall-optional it should probably only be set if a faulting type
domain is installed (probably on a PASID)..

Still looks Ok

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

