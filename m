Return-Path: <linux-kernel+bounces-286796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDF6951F19
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9216F1F231ED
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F881B5830;
	Wed, 14 Aug 2024 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="E9p4kYGS"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F041B4C3F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650717; cv=none; b=hUSnpKUj6V2SctQrXcG+7dRE1kU6dk8ietUEcgeHfwguruWqtAPKnH1pSkWuRXiTKS5loqqXP3fOm/T06vPFVsECHQSXul63VzGPy5fsxykfl/3uGqxdfElkEZ/NoqQroFTVcRUQswdyBdFeCypRB2nwNCGaxgvwmW9OrPRuEig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650717; c=relaxed/simple;
	bh=8LF8erteSYXqEQ+sv6uPPqfX6ExaNFAVtl6+SQyrxXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulZCNZ+8NXwCrqoZC8NAo2H9ZPSQwK3NgiyO0S60L9JNugCCHFVxuqz8xq8YN8xq1O39nX/nCk8xnRAiJFgrvslhonxWQSnHpFit47GzdwYFBxQEpSYasHK/dajKD8h5WlNKvvaFHiswKl8YbomY8z9s1Xl6IdbekHTwkXDa4tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=E9p4kYGS; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4f6d35d59ccso17698e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723650713; x=1724255513; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T1s0TehfVbhq0HZGHpkiDt/kqWMCBY7b6/k82SpXX8k=;
        b=E9p4kYGSsdpYR3fB2JvtIWOxb08mt3wozqtMSba3LzZ1Oj6vB5mn1filkEjADlvoXC
         xYyDeJQRAu7EGlH4E/pP6yZLGxV973KdOcmc3cHKb/ammVLMCJNfAalIThVOztiv9M9a
         JS5kFRWZ43m64lMzjPW5IzHjkpMYJFMhyqRVBQ+/Db2xS/58RJ+PRTzWa7iVIkLMTmgz
         NADdcH9BTcMiCayAHOTNgNC2ScKKEL4YY3WIOFyB+V53XeBTH/EkBZqUZUBp09xWZ/Bd
         ro8C3+zmjZBv1ff6kQn6iIYAdufdrAuRjqlmJ17KGVbnmAf0FKqhSuxdz9n8OvqtQyh4
         PBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723650713; x=1724255513;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1s0TehfVbhq0HZGHpkiDt/kqWMCBY7b6/k82SpXX8k=;
        b=aN05DFITd3XJSZyGHhzJ4fm8ApJ9FQV3mVq4SlRePCL4NozOq311mdPO53t1p6Aq38
         FkDFsv3UWec8e6aFZrBSZdq+zYWBUMAr1K2NuIX/IlN6OK/ASW1vEm5xrvJ0EVZckAcj
         qDXCVE33cXZw1hFVt4b6PYtw+ZhCBqPzBpcxUjGw3SPD+l7vUTw7DpggdW5VEqMYC0fX
         7EpcqlU6O3DkpHP56WrBXa3jzjLsK0OKpnIZ0flgzbkpv2hL0fzMbST+VRyKVfWL+9PX
         rhkm7+HGe9/5nZwfO9pNa6961wh/5yyMBVH5J3RW0ZA+9R5Fwz/OGSbiyz4k38PZCCGT
         h1nw==
X-Gm-Message-State: AOJu0YymN2jV1zwidD+m51iD4XGI1FFbbUe9cMpN0qq+lCOa/4VSGZgd
	rfuhOkBJUJXIe/l71KTqWy5poFrylhfsipX2nfFA2JcKoWDHWCmKUfO8ocMJvD1g1veH1EBhoBC
	j+to=
X-Google-Smtp-Source: AGHT+IFg6veGNaLgvSE2E0usRoXPVwYia2SifqmSnbsKggLRSM6+BzNLtJNR7f5jIMVRK1+Y/tX3XQ==
X-Received: by 2002:a05:6122:1348:b0:4f2:ea44:fd2b with SMTP id 71dfb90a1353d-4fad1780186mr3878368e0c.0.1723650712608;
        Wed, 14 Aug 2024 08:51:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf5fa8fc5esm7797076d6.103.2024.08.14.08.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:51:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1seGHv-00EnrX-F2;
	Wed, 14 Aug 2024 12:51:51 -0300
Date: Wed, 14 Aug 2024 12:51:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, jean-philippe@linaro.org,
	nicolinc@nvidia.com, mshavit@google.com
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Match Stall behaviour for S2
Message-ID: <20240814155151.GB3468552@ziepe.ca>
References: <20240814145633.2565126-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240814145633.2565126-1-smostafa@google.com>

On Wed, Aug 14, 2024 at 02:56:33PM +0000, Mostafa Saleh wrote:

> Also described in the pseudocode “SteIllegal()”
>     if eff_idr0_stall_model == '10' && STE.S2S == '0' then
>         // stall_model forcing stall, but S2S == 0
>         return TRUE;

This clips out an important bit:

if STE.Config == '11x' then
  [..]
  if eff_idr0_stall_model == '10' && STE.S2S == '0' then
      // stall_model forcing stall, but S2S == 0
      return TRUE;

And here we are using STRTAB_STE_0_CFG_S1_TRANS which is 101 and won't
match the STE.Config qualification.

The plain text language said the S2S is only required if the S2 is
translating, STRTAB_STE_0_CFG_S1_TRANS puts it in bypass.

> +	/*
> +	 * S2S is ignored if stage-2 exists but not enabled.
> +	 * S2S is not compatible with ATS.
> +	 */
> +	if (master->stall_enabled && !ats_enabled &&
> +	    smmu->features & ARM_SMMU_FEAT_TRANS_S2)
> +		target->data[2] |= STRTAB_STE_2_S2S;

We can't ignore ATS if it was requested here.

I think that does point to an issue, ATS should be fixed up here:

--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2492,6 +2492,9 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
        if (!(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS))
                return false;
 
+       if (master->stall_enabled)
+               return false;
+
        return dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev));
 }

And your hunk above should be placed in arm_smmu_make_s2_domain_ste()
not arm_smmu_make_cdtable_ste()

Not ignoring the event still makes sense to me, but I didn't check it
carefully. We can decode the S2 event right?

Jason

