Return-Path: <linux-kernel+bounces-284222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7FC94FE99
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1541F24195
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C22132464;
	Tue, 13 Aug 2024 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ecwCe+17"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECFD54759
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 07:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533626; cv=none; b=VWYXiVndYXN6nJGtY1NcbqVraDFbMxaFUisHM0oEqDn2JSJmQVbj4EZEgqHUucwMJPwDMo2if2aBdS2XBFXRw3UH5Ux1jF/yxv2paTm0cTxTn7OHk1o5XBkpIN+6qM67Z1Ks0dXHTS/ffqMMBJiHFcXi5GNHvpxudpmiWKiAM3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533626; c=relaxed/simple;
	bh=UN0ZpGxw47ixND5peqiv9fX6/ccnQ6AxWsy9hjTfGfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ud7IjJ8iGUmRBgc/mUFKQTudzfo4O4jRuPkryUi0vgjK/qJEbMgF1QxJ9Mj0JKlM29l/ZPOIsir1WNjarcs2xvRscETTMR4mAIT42cXVxSQ5WEoUU/mrmkph8uUoBn9tRryFIDbYmB/hb962hyVbyLHYYWT1Q3gBFVF4/juBPm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ecwCe+17; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fd7509397bso63435ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 00:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723533625; x=1724138425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JRqfFafHF5XewBUoy5tZuHbvr8oDZuevEuG5wBULNKA=;
        b=ecwCe+17ES+VVEjbD+vxXrZ4DsbGhO7cL+zhi4/Iz/pAxk/GBh8wRac6ATbbXCSmTz
         yrmAFus2bf5jSufmhx/zxauVmKfgDT1BuRw0DKIBPPVOznl86utlF+4TWtz8NOTeh8rT
         1f9MoxNibpUHDH5afrsPdtvMAan1pNXqSgacPoSCo7+6L8qL+fR3QtvYgC6wzNFP1UVe
         rILgBagd1ysjc7ayCfkP5/hWJNjJULVX9vMD52BxLDOL39EhA87Owe8adkPOCDXP3fKJ
         ei3SMPJUaIgqkFlDtE1N7eZc0SZQy9fa0bcoHEvXsgORiquErld9Oe6U5QXm8K8YfWk4
         kjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723533625; x=1724138425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRqfFafHF5XewBUoy5tZuHbvr8oDZuevEuG5wBULNKA=;
        b=epndRWUELI5duXnjefU3/b+9exQxHOYktqI0knqUEags/MDDgRwsaSjjbC2c2W0JdQ
         8eqxedH9a1i2CBPEmq+iaa9ZIDGfbk/hCL60OjNSXbs4HaiPUFl07BpCIiDz+EygjnyH
         aNqI6+edjXsuSUOif8q5KVivDBUyHs9ZhvqH+biAejkO66uyG+i4WV/oUK8f7Rs6F1fZ
         2tqocklUF9Jw4FXeo12UcScBQF7o1b67uVqvlqszJF1W3Rn8XJuOGik34BUBCXbKBKaN
         zh2ZXs0nkQLBci4GinzY6G8Kf9Xt7mhaaGsod8kTrlnBuy4y39uvD8FcsFJm4IQEr+SI
         9vwA==
X-Forwarded-Encrypted: i=1; AJvYcCWvzbA/15wkPiBtDj2ic98T1c/m/8IC7rd6IZJwOrX+AyfzzuWI/+RGDc95o3flj9q61CUM39oZuNFSkkqNT1FANqGaKa37qpXyWee9
X-Gm-Message-State: AOJu0Yzbn/YI0GTSvcsA8yPowb3XB9o9BbZ8RYK42Q5tS0mMiPJq397D
	vfevl8ZIl0mSx0/viIK7WP3vXe8QU/FeKfheVMio6HryjIZhK0hGrGWS5gzhncayWxUrHVjjIl0
	rM4IP
X-Google-Smtp-Source: AGHT+IH3c19ieOFuxpG9Od28VUkUNWd5p7w4JT1Tcj/IJODP0Cw03Yuz3owloBqLlS4SpQoR2wasig==
X-Received: by 2002:a17:903:646:b0:1f9:d111:8a1e with SMTP id d9443c01a7336-201ccbc957emr1049735ad.26.1723533624423;
        Tue, 13 Aug 2024 00:20:24 -0700 (PDT)
Received: from google.com (202.141.197.35.bc.googleusercontent.com. [35.197.141.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd12f5d5sm7442055ad.19.2024.08.13.00.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 00:20:23 -0700 (PDT)
Date: Tue, 13 Aug 2024 07:20:14 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: robdclark@gmail.com, will@kernel.org, robin.murphy@arm.com,
	joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, quic_c_gdjako@quicinc.com,
	dmitry.baryshkov@linaro.org
Subject: Re: [PATCH 1/1] iommu/arm-smmu-qcom: remove runtime pm enabling for
 TBU driver
Message-ID: <ZrsJLqTnq6tG2xp4@google.com>
References: <1722335443-30080-1-git-send-email-quic_zhenhuah@quicinc.com>
 <ZroNUGkKuC1L7Qfr@google.com>
 <cca690c3-916e-43b6-b2a5-eca4f2eb838e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cca690c3-916e-43b6-b2a5-eca4f2eb838e@quicinc.com>

On Tue, Aug 13, 2024 at 10:37:33AM +0800, Zhenhua Huang wrote:
> 
> 
> On 2024/8/12 21:25, Pranjal Shrivastava wrote:
> > On Tue, Jul 30, 2024 at 06:30:43PM +0800, Zhenhua Huang wrote:
> > > TBU driver has no runtime pm support now, adding pm_runtime_enable()
> > > seems to be useless. Remove it.
> > > 
> > > Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> > > ---
> > >   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 6 ------
> > >   1 file changed, 6 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > index 36c6b36ad4ff..aff2fe1fda13 100644
> > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > @@ -566,7 +566,6 @@ static struct acpi_platform_list qcom_acpi_platlist[] = {
> > >   static int qcom_smmu_tbu_probe(struct platform_device *pdev)
> > >   {
> > > -	struct device *dev = &pdev->dev;
> > >   	int ret;
> > >   	if (IS_ENABLED(CONFIG_ARM_SMMU_QCOM_DEBUG)) {
> > > @@ -575,11 +574,6 @@ static int qcom_smmu_tbu_probe(struct platform_device *pdev)
> > >   			return ret;
> > >   	}
> > > -	if (dev->pm_domain) {
> > > -		pm_runtime_set_active(dev);
> > > -		pm_runtime_enable(dev);
> > 
> > I assumed that this was required to avoid the TBU from being powered
> > down? If so, then I think we shall move it under the
> 
> Hi Pranjal,
> 
> In my sense, this was giving the TBU ability to power down when
> necessary(through pm callbacks)? While I haven't seen any RPM impl for TBU
> device.. hence having the doubt..
> 
> Thanks,
> Zhenhua

Apologies for being unclear. I just meant to ask if there was a reason
to add pm_runtime_set_active & enable in the tbu probe previously? And I
*assumed* that it was to set the device state as RPM_ACTIVE to avoid it
being RPM_SUSPENDED after enabling pm_runtime. 

I agree that there are no pm_runtime_suspend/resume calls within the TBU
driver. I'm just trying to understand why was pm_runtime enabled here
earlier (since it's not implemented) in order to ensure that removing it
doesn't cause further troubles?

I see Georgi added it as a part of
https://lore.kernel.org/all/20240704010759.507798-1-quic_c_gdjako@quicinc.com/

But I'm unsure why was it required to fix that bug?

> 
> > previous if condition, i.e. CONFIG_ARM_SMMU_QCOM_DEBUG?
> > 
> > If not, we can remove it give that the TBU would be powered ON as needed
> > 
> > > -	}
> > > -
> > >   	return 0;
> > >   }
> > > -- 
> > > 2.7.4
> > > 
> > > 
> > 
> > Thanks,
> > Pranjal

Thanks,
Pranjal

