Return-Path: <linux-kernel+bounces-297132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6BE95B38C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7CD1F238F1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8D0183CC3;
	Thu, 22 Aug 2024 11:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hsDWw8tt"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855ED181BA8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 11:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724325138; cv=none; b=UuywIkyghfWlQBNU+ARIVOzPshXngGclDLAeRdW41HL2bHg/GIuWIlcKC5/gxtU4j1xAB037EQGXh3Aa641SQId8NFmD/Vyw15YPo+NiHWuwIxXcHjp2ztZN8uvMyd+DJkzX6Cvga6fptpuB+p2+VA8jQagIffU7yci0Cvw9rvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724325138; c=relaxed/simple;
	bh=vi9h1FidMBka1pRgw2AnPFKWunRB65e+lyirWA4Ekmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKY/gsYT+TtGvHPJ8ujdIGkm040JF3K0UVhYP2jWOY90T72S7nowCEYb7lmfdGlWDVV3j6i+4fq/FcCCh5cHak3tVVuQgllKwcCHGrGcJ3BZsmbz1L31XF5G3EbOxa5dotu0tBOCFivQVqyLja6jeD6MpAfAlBZNnUpKTSNosNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hsDWw8tt; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7bcf8077742so488354a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 04:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724325136; x=1724929936; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BbJ9Z+sMrkclfRagtYJm2Qhjn1slaJi07OZtLt0xRqg=;
        b=hsDWw8ttWVsaIp7qwC4SQh5i2dVzC10WKYFKvavGOvPcQVb80pUDxO4ayhlYf5Khi+
         m8oNPAKdZFQsFJKhsNAWCt5C+GZioz3NKxhkSZUfihESrwwXRuCfIOEp2t9+Xylsx0ON
         4mSUa8Oyc1s5pD7WbkQPDWzD1CZYYJrRxEEAlICodsMJjY6yH12T3GK3t+5+LaQl3hgI
         abxt+1nVk/vL+Zpz3xH1N4GqaOiju2s9KKqbmEz+pOU+ywBHZB8fSUWIKRRfyJ2rwHSF
         fLH5IiefzED3eBmMUw+6KrrpH3kE7fL7jIf5jmnh0mg9814fPxaRtd9+YXGYHsvDYBL5
         DDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724325136; x=1724929936;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BbJ9Z+sMrkclfRagtYJm2Qhjn1slaJi07OZtLt0xRqg=;
        b=I7XwC5v4P2byoPeLnTqnH5f0YVXHpZqfKzQTlbM3DfkrbMAVKxohIB0s5JzVwBqHve
         EHrTwAsyC46+u8n/y4uuqMoClF0xw1cdkHOM8jvtI9xm3SEaKOVgCMdvPfZ4htUrN+V/
         2t21gcA4TpfUwuLfixC1qFAXOdtwW9LJCaSVSYr0jwinw+ujYuE8vfpQi4mII4f2kXrO
         S/k912xKngmT/XR8/WDy3TtUWKRGKs2trnZwUpu54X0k3wu6+khw1xDfvBO4yjGuKOsV
         gPdC25t5uCjHoAHei5VmtfwwGd+/CGzod8sFtYhqgZuGfIbPkkD6NCD1r4NHVNiz60Xi
         4mEw==
X-Forwarded-Encrypted: i=1; AJvYcCVuFhxLMyWvgDUyZ6R6p+bWwaRwTEti8iF8uiSrZ/b5nCbSh+CRsD8KVZ+PCOI6xtcYFEf2O1PPquqftyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb4qiLz3lpCJQR2/iWdpIDH4/WgK7GR+m+b4TMWwnXJnDraajd
	5ilAo9TOhH2EbhePyd9owaqDY5Gd6h4+t/1JPcuIu+vLEpJM2RRWkhbFwTY8KA==
X-Google-Smtp-Source: AGHT+IGzybvAIUuXxPl7dmKySzy1eKxeJTiu0SQmcSr83L0+MazI/R/cvJax85qZEJ7fPuLq07i6aA==
X-Received: by 2002:a05:6a20:9313:b0:1ca:da6d:675f with SMTP id adf61e73a8af0-1cada6d79e0mr4593437637.0.1724325135657;
        Thu, 22 Aug 2024 04:12:15 -0700 (PDT)
Received: from thinkpad ([117.213.99.42])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9acdc7c6sm978832a12.46.2024.08.22.04.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 04:12:15 -0700 (PDT)
Date: Thu, 22 Aug 2024 16:42:07 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Rob Clark <robdclark@gmail.com>, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Georgi Djakov <quic_c_gdjako@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu: Pretty-print context fault
 related regs
Message-ID: <20240822111207.vbotlrtw72vflefj@thinkpad>
References: <20240701162025.375134-1-robdclark@gmail.com>
 <20240701162025.375134-4-robdclark@gmail.com>
 <20240822100941.3tfqpjskzq43slfw@thinkpad>
 <ZscTkTOa8UPZtwRU@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZscTkTOa8UPZtwRU@google.com>

On Thu, Aug 22, 2024 at 10:31:45AM +0000, Pranjal Shrivastava wrote:
> On Thu, Aug 22, 2024 at 03:39:41PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Jul 01, 2024 at 09:20:12AM -0700, Rob Clark wrote:
> > > From: Rob Clark <robdclark@chromium.org>
> > > 
> > > Parse out the bitfields for easier-to-read fault messages.
> > > 
> > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > ---
> > >  .../iommu/arm/arm-smmu/arm-smmu-qcom-debug.c  | 52 +++++---------
> > >  drivers/iommu/arm/arm-smmu/arm-smmu.c         | 70 +++++++++++++++----
> > >  drivers/iommu/arm/arm-smmu/arm-smmu.h         | 21 ++++++
> > >  3 files changed, 92 insertions(+), 51 deletions(-)
> > > 
> > 
> > [...]
> > 
> > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > index 23cf91ac409b..79ec911ae151 100644
> > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > @@ -405,32 +405,72 @@ static const struct iommu_flush_ops arm_smmu_s2_tlb_ops_v1 = {
> > >  	.tlb_add_page	= arm_smmu_tlb_add_page_s2_v1,
> > >  };
> > >  
> > > +
> > > +void arm_smmu_read_context_fault_info(struct arm_smmu_device *smmu, int idx,
> > > +				      struct arm_smmu_context_fault_info *cfi)
> > > +{
> > > +	cfi->iova = arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_FAR);
> > > +	cfi->fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
> > > +	cfi->fsynr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSYNR0);
> > > +	cfi->cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(idx));
> > > +}
> > > +
> > > +void arm_smmu_print_context_fault_info(struct arm_smmu_device *smmu, int idx,
> > > +				       const struct arm_smmu_context_fault_info *cfi)
> > > +{
> > > +	dev_dbg(smmu->dev,
> > > +		"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
> > > +		cfi->fsr, cfi->iova, cfi->fsynr, cfi->cbfrsynra, idx);
> > > +
> > 
> > I just happen to hit an IOMMU fault in 6.11-rc4 and I did not see the 'Unhandled
> > context fault' log, but just the register dump in dmesg. Tracking that lead me
> > to this patch.
> > 
> > May I know the reasoning behind making the actual error message _dbg()? It is
> > intentional first place?
> > 
> > - Mani
> 
> Hi Mani,
> 
> That was a miss in this series, but it was fixed recently in [1].
> I think it should land soon.
> 
> [1] https://lore.kernel.org/linux-iommu/172381862229.1794487.17068761066364130246.b4-ty@kernel.org/
> 

Cool, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

