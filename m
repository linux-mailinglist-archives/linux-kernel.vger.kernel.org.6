Return-Path: <linux-kernel+bounces-532138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FEAA44923
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008161677D0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0918D19A298;
	Tue, 25 Feb 2025 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OWgpDTiP"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC87E199FB0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506242; cv=none; b=lsO0tKbskiY5hd4QOLIR9bLg/o4mnVvk6/OnV9ENDsJf1JGX3TWrobXowQWPBPkbGCy7K4SWakids0c1QrWfz0CfmassQ3aHJd049ZeGXIcTbSfJG2lYn2Z0S1krkQ3e8CQmuWoHDu0e3b3v1BTMGn91R93N8Xken8RW5itWr5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506242; c=relaxed/simple;
	bh=31zc1XueM/rGKJ6c+/BQITCsz1wXw3/IbeSan2eXnK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4K4ZzTFlgulGOtPpOdn7zB4OM5E0PJSAV6XDXMww/djCCyze7nhyKqzbKkTIwwAymECYvVMb3MXAjVbW8Uyxmtxb5Ln8pzENaSbLSsBOvUwZm8EncJyaLwR1c51maKFbtC53UATtMnkHHa/CwTHMzZQmkXA1x2w2TKpuHQ9Al8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OWgpDTiP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220e0575f5bso5325ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740506240; x=1741111040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zHaAT6T+XlWe+89P2zugxKrlYk7TledH0w0ahGQr4YM=;
        b=OWgpDTiPQBDBTZcpLxbeBSONYJUditH8XQiAsLTPx1LtKTeeMPuaTc8MGqF/AiMzUf
         nwmXoaHMlhPnsKVfBSWO7DJfNDoqXrIGi0TF63AmmXbFP94rXJydx610p+5CEGHD08Oe
         KhqlANFWKKDMHgSx/SEMc4vAi+PldaiR2ROu5yHq5VRALiRyTLLGKpIXnzMoUmCTqYPp
         IAe4OxcnDait8wAzACbPfLRMfF1rgtD0k4MQX1c6zIUWtCqghWUOnDA9t7uWMluU6HS8
         I9DUw1CUm3tRnL3BpIujyA5sJPsRfm+hKJGDntSdeHRHWCZ1q79wObE2PGoJvzYdCPOM
         JqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506240; x=1741111040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHaAT6T+XlWe+89P2zugxKrlYk7TledH0w0ahGQr4YM=;
        b=scqJaF1tE4MN2RavhUJA2falMAnuLnRrzwuZUEclr2eh70LtX/RKs/V8OPYH430NuQ
         Ko2mkZLCSnKF7CpA700IByAFSz+yS4k6/eFVklib3mONJCACTaSaB/m8AGysG4KJ+Fax
         d145pkIHkENB7yMPY3ibQRpRhsMunX/qTaJPQUCxXgJ2XKnSSOQuDx1+T01kuObAy2uu
         rVPppI4UrIDwfv1hsHfr1T26ClE/hTgW31jSDNrQN62hopnYEcsxwDGjNIihJ5zTbG5T
         cu1heZ2z42gSKI3XgGOGmEzD5//ozpV3Gi072QXDSU/uhy6LRZsXRtDAzPCe4HVrI4RT
         zsdg==
X-Forwarded-Encrypted: i=1; AJvYcCXdy+Ruikgx1omuAGLk6u2h5hihPNrHjprAaTdjBhMzkg3DJQdfLMUn/MKgJYwS2cTJmbFcwsTjqFbvR30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/WGuQaRc4Bp/7zuhBSd6QF4WqVyRdjgr0uTSJtcgyBiOftNSB
	wVFBWgWkQJnWCg2P3VV/nku1PApI0rwwCYOiCySu2Jm6Ko/w6g8M+ygZwhsAsg==
X-Gm-Gg: ASbGncvi/QhnYoldpMLbIAGqYe7v+BDwRf5o/7TdkbnTarURh1YHGKMtJNcd+ni3K8N
	bCrQTK7ruxWQUWaDbKFS/PXFzh7RUTRoP9NkqYiuIbU2SRcZ3U0N76BOsD+9y2myJH7ro0P8igI
	iSB2o0dxP9cbDk3E8Lkn2VBpLU47MhGFYO4zG3gPem1DdxAxjCWnRJY4bmdCfLRrNTmAmXdz/0V
	4ec49bqMFbMyu5b+Nb/aSlwODa0y8jj9JlmoGW58zWTZXQmDwRRo8reKoOQySf8M8eYdIO0c6Jc
	rCOIMfOaE6pnm60B5MKsFi5bARpKa1PoCZT38UpEarTyetGbDl8Kl+zw09AxIhw=
X-Google-Smtp-Source: AGHT+IG02bNp0tkxmXxczB6ZSntt4wfTEWTePiQeT76QafmUXS7ThOKjH22xno2GMa6y5FkJX+V2yA==
X-Received: by 2002:a17:902:c40d:b0:220:c905:68a2 with SMTP id d9443c01a7336-22307a2c777mr3852445ad.5.1740506240014;
        Tue, 25 Feb 2025 09:57:20 -0800 (PST)
Received: from google.com (169.224.198.35.bc.googleusercontent.com. [35.198.224.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0a61fcsm17251405ad.191.2025.02.25.09.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:57:19 -0800 (PST)
Date: Tue, 25 Feb 2025 17:57:09 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v8 13/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
Message-ID: <Z74EdXC5YzvmJokk@google.com>
References: <cover.1740504232.git.nicolinc@nvidia.com>
 <7f6813dc2b62f5f396ac3172dc2a7d9bf3b47536.1740504232.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f6813dc2b62f5f396ac3172dc2a7d9bf3b47536.1740504232.git.nicolinc@nvidia.com>

On Tue, Feb 25, 2025 at 09:25:41AM -0800, Nicolin Chen wrote:
> Aside from the IOPF framework, iommufd provides an additional pathway to
> report hardware events, via the vEVENTQ of vIOMMU infrastructure.
> 
> Define an iommu_vevent_arm_smmuv3 uAPI structure, and report stage-1 events
> in the threaded IRQ handler. Also, add another four event record types that
> can be forwarded to a VM.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Pranjal Shrivastavat <praan@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  7 +++
>  include/uapi/linux/iommufd.h                  | 23 +++++++
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 17 ++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 60 +++++++++++--------
>  4 files changed, 82 insertions(+), 25 deletions(-)
> 

Apologies for my spelling error in [1]. It's supposed to be:

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Correct spelling in [2].

Thanks,
Praan

[1] https://lore.kernel.org/all/Z73zvIbsXzJMCaNt@google.com/
[2] https://lore.kernel.org/all/Z730M3XptvDRObBp@google.com/ 


