Return-Path: <linux-kernel+bounces-397724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C27E9BDF92
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B289C1F217AF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5646A1D0169;
	Wed,  6 Nov 2024 07:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JXZRGDX5"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8331D0E36
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 07:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730878862; cv=none; b=ZtCapAkbatLoUyUSgdSKW1KykqAxl43jEfbTqa636KMMtELIdvTZDk+jRdFgnpuJILnU9iH6tegEKF1OrkqdO+W8cGraZzpD6ORkC0uivhW6/JeH4QPyMZOZsciE3QLUBrnJn7vA17bQAijWwpDXzhE6avVPTlfDSXNAyUx/L2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730878862; c=relaxed/simple;
	bh=HQqOgF25zZrRJJrEPpwoe06g0XjJyk/IFMS5AN9Z/eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sG3c3kQ9VD4dwk/6QvEh/m2dASjS03yiOp8Ot4EwR7MvbtWzVAW4Q2FxGg5KMYnPnLmiS/hsAqCu1N4ETEs2ZOgiTjyAMcrRMSIkYSjj42xwsmB7GVKvajj6wIMz9MHWTb5VdUuoEgwoFKVOr749qP42buYM20ZIwsd/58TlCik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JXZRGDX5; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53c73f01284so65440e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 23:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730878857; x=1731483657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tXO9RRbs3HveLlIZZM8HN1XONyaSb0qVhG5bV+yNI6E=;
        b=JXZRGDX5W3F7ubX+PJuuAD0A8Sh6KqJAolXsyJ3BcRImJEIPneZ0NHSW6jphXC4Nnl
         AAXzawdfeRe8XDq9R897eJeYP1fGNAhEoQFCneFTgTLXcN+4qhe3/uwP5qOHWnDshov0
         xQ5N0jl7q6Qo5BahUeGZDuXWVeq0HCEYNZim2Y+H3sQXsoMtHU2AdjMuiJCmj+87BnOr
         StJ1h6gchk53m50L+EqTDEk+EjlLUiqut2JgAusfCmIBZnNL15kwevpyGcm9Dnz67MHe
         1n8/AgE1aCyTCw7Rd46CqAYRyUhi+ybbBLLsi0yIcYeuLhztzpfN7MO7eP/w2MP4lp4t
         6Xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730878857; x=1731483657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXO9RRbs3HveLlIZZM8HN1XONyaSb0qVhG5bV+yNI6E=;
        b=q++golgLg0lXEo7HwGW/0QScUNigMHAJiYBVJpQpAzTA5n/tqDG9L3M9o+a/jk+c41
         dsW4m99+kTCXjV5oVl6YaZBwkofSEKKT8NRp07QdKdXS7VWvA2ARsQ0I0eXSSmhsyxi0
         zz91USzviCpGJgwtKXPl7w49ees5p3RkOyca/02BbwmLkCOtWArjdGJDxTGVD7vekcdO
         Oxxwi99asPkw9cHtFxJ+DUkYh9gesdM7n5cEdmCYlHlRozoB4SGqrH+6tqf2SYtptZ8N
         zl8Cg4+fjr3nZvuaGEbctGB7nDwuuB0WpyMOXAhcEr24IDHIBEFVc3QThKP+DmtXzW9l
         CojQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnFbtQGw2y4EJW1UP8CqHOXdH57bpthICgF52BwHuKUSzGx42AEnBQgPjqtm3YC8Q3KiPESUOekW0IXDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPYsD8Do+J7qSQ8O3yleqvy76SH5rRd5zJ3FODR5A6WgG/1YSH
	ocg8ENlVKHFp9U5DaaBr2SzIgiDsIfzzfG5sP8h2C/rREIoCgD2SOTATKd6RxQg=
X-Google-Smtp-Source: AGHT+IF0FcdGuJ0vO+niOKjEmLBEPpJB40aDmUzjOkTIqMnmTG4s9w+mRinnl+QEkzIM6X2Ng1KY4A==
X-Received: by 2002:a05:6512:3c88:b0:539:e9f8:d45d with SMTP id 2adb3069b0e04-53c79ea6c5dmr10858734e87.52.1730878857022;
        Tue, 05 Nov 2024 23:40:57 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc9c043sm2398395e87.102.2024.11.05.23.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 23:40:55 -0800 (PST)
Date: Wed, 6 Nov 2024 09:40:53 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Will Deacon <will@kernel.org>
Cc: Bibek Kumar Patro <quic_bibekkum@quicinc.com>, robdclark@gmail.com, 
	robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, jsnitsel@redhat.com, 
	robh@kernel.org, krzysztof.kozlowski@linaro.org, quic_c_gdjako@quicinc.com, 
	iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v16 1/5] iommu/arm-smmu: re-enable context caching in
 smmu reset operation
Message-ID: <uroldzsi6n7b6hyiutanqfqyqsny65zr4fzyggsmvqsmyfayrp@u5c27k3yi5cf>
References: <20241008125410.3422512-1-quic_bibekkum@quicinc.com>
 <20241008125410.3422512-2-quic_bibekkum@quicinc.com>
 <20241024125241.GD30704@willie-the-truck>
 <092db44e-f254-4abd-abea-e9a64e70df12@quicinc.com>
 <20241029124708.GA4241@willie-the-truck>
 <ygd6bryp73jgsm5zggy2jz4uc42dehht2e6ht5f6yowf74c6ns@u6dul4rnybt6>
 <20241105113723.GA12600@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105113723.GA12600@willie-the-truck>

On Tue, Nov 05, 2024 at 11:37:24AM +0000, Will Deacon wrote:
> On Mon, Nov 04, 2024 at 01:10:12PM +0200, Dmitry Baryshkov wrote:
> > On Tue, Oct 29, 2024 at 12:47:09PM +0000, Will Deacon wrote:
> > > On Fri, Oct 25, 2024 at 07:51:22PM +0530, Bibek Kumar Patro wrote:
> > > > 
> > > > 
> > > > On 10/24/2024 6:22 PM, Will Deacon wrote:
> > > > > On Tue, Oct 08, 2024 at 06:24:06PM +0530, Bibek Kumar Patro wrote:
> > > > > > Default MMU-500 reset operation disables context caching in
> > > > > > prefetch buffer. It is however expected for context banks using
> > > > > > the ACTLR register to retain their prefetch value during reset
> > > > > > and runtime suspend.
> > > > > > 
> > > > > > Replace default MMU-500 reset operation with Qualcomm specific reset
> > > > > > operation which envelope the default reset operation and re-enables
> > > > > > context caching in prefetch buffer for Qualcomm SoCs.
> > > > > > 
> > > > > > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > > > > Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> > > > > > ---
> > > > > >   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 45 ++++++++++++++++++++--
> > > > > >   1 file changed, 42 insertions(+), 3 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > > > > index 087fb4f6f4d3..0cb10b354802 100644
> > > > > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > > > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > > > > @@ -16,6 +16,16 @@
> > > > > > 
> > > > > >   #define QCOM_DUMMY_VAL	-1
> > > > > > 
> > > > > > +/*
> > > > > > + * SMMU-500 TRM defines BIT(0) as CMTLB (Enable context caching in the
> > > > > > + * macro TLB) and BIT(1) as CPRE (Enable context caching in the prefetch
> > > > > > + * buffer). The remaining bits are implementation defined and vary across
> > > > > > + * SoCs.
> > > > > > + */
> > > > > > +
> > > > > > +#define CPRE			(1 << 1)
> > > > > > +#define CMTLB			(1 << 0)
> > > > > > +
> > > > > >   static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
> > > > > >   {
> > > > > >   	return container_of(smmu, struct qcom_smmu, smmu);
> > > > > > @@ -396,11 +406,40 @@ static int qcom_smmu_def_domain_type(struct device *dev)
> > > > > >   	return match ? IOMMU_DOMAIN_IDENTITY : 0;
> > > > > >   }
> > > > > > 
> > > > > > +static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
> > > > > > +{
> > > > > > +	int ret;
> > > > > > +	u32 val;
> > > > > > +	int i;
> > > > > > +
> > > > > > +	ret = arm_mmu500_reset(smmu);
> > > > > > +	if (ret)
> > > > > > +		return ret;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * arm_mmu500_reset() disables CPRE which is re-enabled here.
> > > > > > +	 * The errata for MMU-500 before the r2p2 revision requires CPRE to be
> > > > > > +	 * disabled. The arm_mmu500_reset function disables CPRE to accommodate all
> > > > > > +	 * RTL revisions. Since all Qualcomm SoCs are on the r2p4 revision, where
> > > > > > +	 * the CPRE bit can be enabled, the qcom_smmu500_reset function re-enables
> > > > > > +	 * the CPRE bit for the next-page prefetcher to retain the prefetch value
> > > > > > +	 * during reset and runtime suspend operations.
> > > > > > +	 */
> > > > > > +
> > > > > > +	for (i = 0; i < smmu->num_context_banks; ++i) {
> > > > > > +		val = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
> > > > > > +		val |= CPRE;
> > > > > > +		arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, val);
> > > > > > +	}
> > > > > 
> > > > > If CPRE only needs to be disabled prior to r2p2, then please teach the
> > > > > MMU-500 code about that instead of adding qualcomm-specific logic here.
> > > > > 
> > > > 
> > > > Doing this on MMU-500 code would make it generic and reflect for SoC of all
> > > > the vendors on this platform.
> > > > We can make sure that it won't cause any problems in Qualcomm SoCs as we
> > > > have been enabling this since for some years now and could not
> > > > observe/reproduce any issues around these errata.
> > > 
> > > Unless you can explain definitively hy that's the case, I still don't
> > > think we should be second-guessing the core SMMU driver code in the
> > > Qualcomm backend.
> > > 
> > > > But we won't be able to guarantee the same behavior in SoC for other vendors
> > > > where these errata might still be applicable as per [1] and [2].
> > > > So as per my understanding it's safe to include in Qualcomm specific
> > > > implementation and not changing the default behavior in all other vendors'
> > > > SoC even if they are not prior to r2p2 revision [3].
> > > 
> > > If you want to gate the errata workarounds on policy, then please follow
> > > what we do for the CPU: add a Kconfig option (e.g.
> > > ARM_SMMU_WORKAROUND_BROKEN_CPRE) which defaults to "on" (assuming that
> > > the relevant errata aren't all "rare") and update silicon-errata.rst
> > > accordingly.
> > > 
> > > Then you can choose to disable them in your .config if you're happy to
> > > pick up the pieces.
> > 
> > Is it actually going to work? For most of the CPU errata we can detect
> > and limit the workarounds to some class of CPUs. For SMMU, if I'm not
> > misunderstanding something, the errata will be enabled by default for
> > all SMMU-500 implementation, so only very few kernels, targeting only
> > the Qualcomm hardware, can get that disabled.
> 
> We can add checks based on rXpY per the erratum documentation, but Robin
> was saying elsewhere in the thread that some of them are still open (i.e.
> unfixed).
> 
> So ultimately, the decision to disable workarounds for known errata on
> broken hardware is going to be a niche sport, yes.

Yes, I understand that. I'm just trying to understand if we can have a
better solution than having errata workarounds enabled on a majority of
the kernels (which means less testing for the non-workaround-enabled
setup on Qualcomm devices).

-- 
With best wishes
Dmitry

