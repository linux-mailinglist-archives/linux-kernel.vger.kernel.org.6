Return-Path: <linux-kernel+bounces-287964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CB7952E9C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21332B240F3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9237419D088;
	Thu, 15 Aug 2024 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Qrlr4qlu"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E231993B0
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723726764; cv=none; b=unIrcYXP48z+irR0LPolEBVl2B1xpm+pDqUxxMX9iBneu761NL4n1DVlEn6Is+VcU95OHBoXfNhdVlxRC34ofN2QzOhw7ebqdekvPHUYTCoKrEIcMwAWyoEJsdVPAC9xlIJi/phB5I8toGy6rL2g3dzn8YSUKPHoTAhcG8XkYYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723726764; c=relaxed/simple;
	bh=jd9sCNQib91dSRC4WlUXNbPpZEpFXamw5HwqjFD74w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjdZUeSAuWyk+uOIs7yarpY1tfWqxjlrv4RwTxBYbqUAFcs+eN07RvTaYHtT6zKmgdFdem/CP9cN5wR79zQ7LbDXTOPABKzTH26LtFjKPHDoBjeGYrTe/Mo7XZP7dLiQyNZuaU9clnH7uMxH8TSwI7pFdpw55NfPtYKYrHVXToc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Qrlr4qlu; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a4df9dc885so66756385a.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 05:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723726761; x=1724331561; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1BcZ11tYjfQmoKlsqbLIVN6wjqaSiTQ9rCV5yk/N8Bo=;
        b=Qrlr4qlu9si7NZkuvogyDsi5CPLbIHGpvf9VB5Wy1ZKSnW+qC5VczP6MGFoJuuAPlM
         U/iUeSzYGOgB0C9w9EBGdmks1Ytm3tW7QvV7murTEdkIDsRjGfXhfOLbRd5t4S1TExQj
         GOnzZXZr3FGkxrTbqmzRnqqZr7hVZJgcHaGw2wBCN+at4bWun2eoGb5/iNioEUJai0he
         03T6BUcIe6avnl5jfpLV9heMbCkVsRamwE29HV00Nz8AE4SRzZaf0ewDAPqsZYIAEaCG
         wHHad23Hlgsl0vEnbzP2dO5C9vqe4B7pY57lY7cVKONotUY/r6F+8YHAfmt052QbBo1e
         8HnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723726761; x=1724331561;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BcZ11tYjfQmoKlsqbLIVN6wjqaSiTQ9rCV5yk/N8Bo=;
        b=g+JKDP5mTAiQjLZpVMDYHKPxGliDx8H5k0ist3RsjRG0s20EYyZJgiNXsTTe5n9ley
         3FBx/pJAKuf3lgF2iZ/A+Z2BBJQ6T+DcRNPmoW/JK95kE8tV6DlBr2w6z+eTvTJ1XdIp
         JcuCw+4WYNnr7CcdeWBA1ovcWIF2QBMquL1QOC8s3tKKCxau4jEmGbl7IkAln6NgxLSE
         3yOjN9LzqCFRJd6yO1BD+nlsQfJxiRmWIzM4a8h25RDzMGIaPQdCOB0X4LxYOMlsyZ+M
         izNViKC/Yj9zDQejqc5IaeenbfRPheZctjRgdhLvHmbl6l3YXB3dxcmQNd8uD7WiUiBQ
         Wigg==
X-Forwarded-Encrypted: i=1; AJvYcCUASeZlcMJF1vS5AxwDGdLbxkRwPoY/XHUvpyBmFnQyWrZp88H93k8BiEm9zlzzS8FvpjlWpV4MlWbQdmz7g/nVd/TlYTiK3CExV0WB
X-Gm-Message-State: AOJu0YwpY8qw1acuNzxQBI9++HMzFyyKFCT46Uz/8M5/wN2AKmdQkze1
	6HE1khMBQ1Pv2KB3XwJqVLXyR1JelhvOnrJsHOWWTRKgZnvvSdXZ/gEfqngePTM=
X-Google-Smtp-Source: AGHT+IFq3SZzxYqjGi+1pTyM3Ksa1yF5302/pJFBXQ96rfVuXA1I3evPnIcdEzygTMhqTm99USXIVg==
X-Received: by 2002:a05:620a:460d:b0:7a1:62d3:b9a3 with SMTP id af79cd13be357-7a4fd1685c9mr505578985a.17.1723726761271;
        Thu, 15 Aug 2024 05:59:21 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e04f6sm60863785a.82.2024.08.15.05.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:59:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sea4V-0030xg-LQ;
	Thu, 15 Aug 2024 09:59:19 -0300
Date: Thu, 15 Aug 2024 09:59:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	will@kernel.org, joro@8bytes.org, jean-philippe@linaro.org,
	nicolinc@nvidia.com, mshavit@google.com
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Match Stall behaviour for S2
Message-ID: <20240815125919.GH3468552@ziepe.ca>
References: <20240814145633.2565126-1-smostafa@google.com>
 <20240814155151.GB3468552@ziepe.ca>
 <Zr3m4YCY7Ape3R6y@google.com>
 <91d6574d-c67e-484c-ad96-91c9fd3d0c43@arm.com>
 <Zr30BjAcVDKJPv3B@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zr30BjAcVDKJPv3B@google.com>

On Thu, Aug 15, 2024 at 12:26:46PM +0000, Mostafa Saleh wrote:
> Hi Robin,
> 
> On Thu, Aug 15, 2024 at 01:16:19PM +0100, Robin Murphy wrote:
> > On 15/08/2024 12:30 pm, Mostafa Saleh wrote:
> > > Hi Jason,
> > > 
> > > On Wed, Aug 14, 2024 at 12:51:51PM -0300, Jason Gunthorpe wrote:
> > > > On Wed, Aug 14, 2024 at 02:56:33PM +0000, Mostafa Saleh wrote:
> > > > 
> > > > > Also described in the pseudocode “SteIllegal()”
> > > > >      if eff_idr0_stall_model == '10' && STE.S2S == '0' then
> > > > >          // stall_model forcing stall, but S2S == 0
> > > > >          return TRUE;
> > > > 
> > > > This clips out an important bit:
> > > > 
> > > > if STE.Config == '11x' then
> > > >    [..]
> > > >    if eff_idr0_stall_model == '10' && STE.S2S == '0' then
> > > >        // stall_model forcing stall, but S2S == 0
> > > >        return TRUE;
> > > > 
> > > > And here we are using STRTAB_STE_0_CFG_S1_TRANS which is 101 and won't
> > > > match the STE.Config qualification.
> > > > 
> > > > The plain text language said the S2S is only required if the S2 is
> > > > translating, STRTAB_STE_0_CFG_S1_TRANS puts it in bypass.
> > > 
> > > Yes, my bad, this should be for stage-2 only which is populated in
> > > arm_smmu_make_s2_domain_ste()
> > > 
> > > > 
> > > > > +	/*
> > > > > +	 * S2S is ignored if stage-2 exists but not enabled.
> > > > > +	 * S2S is not compatible with ATS.
> > > > > +	 */
> > > > > +	if (master->stall_enabled && !ats_enabled &&
> > > > > +	    smmu->features & ARM_SMMU_FEAT_TRANS_S2)
> > > > > +		target->data[2] |= STRTAB_STE_2_S2S;
> > > > 
> > > > We can't ignore ATS if it was requested here.
> > 
> > I don't see much value in adding effectively-dead checks for something which
> > is already forbidden by the architecture. The definition of STALL_MODEL
> > explicitly states:
> > 
> > "An SMMU associated with a PCI system must not have STALL_MODEL == 0b10".
> > 
> 
> Ah, I was expecting that as otherwise it's contradiction, but couldn't
> find it while searching. Thanks for pointing it out, I will drop all
> references to ATS then.

I was thinking this was also protecting against buggy FW since
stall_enable can be set by:
    device_property_read_bool(dev, "dma-can-stall"))

Alternatively we could directly prevent the clash even earlier:

@@ -3292,8 +3292,13 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 
        if ((smmu->features & ARM_SMMU_FEAT_STALLS &&
             device_property_read_bool(dev, "dma-can-stall")) ||
-           smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
-               master->stall_enabled = true;
+           smmu->features & ARM_SMMU_FEAT_STALL_FORCE) {
+               if (!dev_is_pci(dev))
+                       master->stall_enabled = true;
+               else
+                       dev_err(dev, FW_BUG
+                               "A SMMUv3 is required to run in stall mode for a PCI device\n");
+           }
 
        if (dev_is_pci(dev)) {

Though I have no idea how the GPU driver that wants to use this
works - it doesn't seem to be intree :\

Jason

