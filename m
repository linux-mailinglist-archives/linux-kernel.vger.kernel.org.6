Return-Path: <linux-kernel+bounces-406545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAE49C62A5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 21:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF7A9B3EB97
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6F521832C;
	Tue, 12 Nov 2024 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RVLAPlO6"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6814121764F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731436992; cv=none; b=Zq7uG4lEzik3nuy9sEUYunGBJwCZRYfPerHvJbtB6g4uQj+WARZfbkIcbNwfVSkTBOR1cqm6DMJC/yd4D1pJFacT8IiT97A4DstwFftoRICsrtDHDQiI2hTD8rmhnOfgxg4eBnsu8EP03CC4K+cIevndZ+MePflDjK1ZDMzCXrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731436992; c=relaxed/simple;
	bh=RS8LWY4RnDQpWbXC3tLK82nOLtR5D8xPLpwy6E0bPtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuWyCqMVT9oAfyM/B9uHfOLfHTtYffWJttVeHi7/TXO2kaq05z7hUcAEAx2GscMGtSnibw5tM1xm+beO99pCUSDhSl6LQPP0+RND0e6rpLHLh2+SjlqGudYICwWwlR5wlu8NY5xKMSNy1G5XX3omO2Md0XmaIPsFyzajszCdhzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RVLAPlO6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20caccadbeeso65023825ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731436990; x=1732041790; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bvAxizT0+2LKEZU/zIXU+c9h1QMoetzSlOQ8t234HzM=;
        b=RVLAPlO6HV8i9eDTh6TSbmgAdpnJQcH3aKFDbr2HkJc2cRLeTbjgwpV1BDHBYapNYj
         jexUlGl5TqRrq9jYtGvRQaJtEj7KogNF1G130ROffGJbXbtDCN7WXDa4nz8ffeMvyMB5
         ++TMrqOvrrjdxceLPFiU7hO8VOC+/GXJw4OFQZE0v0BVGOQYb9u2xEGFx5xKuL1cImDf
         ft4xfFDlVC8nCfGl8pqPTUhDLtfjUeB7eBjX/dKpD0o1vZyUFPni5iIjp/ARweJ1pAjX
         H4AGxgaeOAk/ObnyNJUEYf4XtFo7XObGoZBGfoPDoFj7UvP28gy8Q6b+m7M3UNZzb6jy
         AEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731436990; x=1732041790;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bvAxizT0+2LKEZU/zIXU+c9h1QMoetzSlOQ8t234HzM=;
        b=hy3VsqHCA4KCcwzsvcDYItt1ZPWVBQtyRDFKVwkycOoY00VshZJt4nRcvOu+LH2RaX
         8QFuayMrwU1Tzsgr2yEV6PESMpPkcPjEaJQCd4VOHd0UiKSMP1hWr7Eq5SrsVbHZMqT3
         x0tIb74KXyfcSBCUA1JZqL7DEp9IJ8cViPLWRnK9JRb6UcwghJWVX4rrc3ZXH3YVsxie
         yrQ/bXTMkFcW1x4eAbkixBW+vAGxhrOBDDP89xDMBGGdc1366juCRvM3OpDw+Dk+XW5v
         SrSov/Ne9E9WTexOXE50O40q3aIH0fYhe4WYmTXCYkuTde3dvuZZumhUWs/H9SI/P9qR
         PUiw==
X-Forwarded-Encrypted: i=1; AJvYcCVdHTLx1hkF9609DzvH1qh9xxTmV79zkoVCqFTjDdDKNShYlaPf511XV0Gc0DstzyRcbBZFFkBxslcixZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnNfSeEIGbACbr/cjk2Nlh+wNkJ9yeMRqi1nM0Vtm5cR5d7Gt4
	l0XSYtACLnBFTmsmlHAXnuUMLVU1JhboEq72U/iCLKwITTXE+edtN2KpYol1hg==
X-Google-Smtp-Source: AGHT+IHW7hcorvi/Z4pW7Liu6vMe0qflJ4S1oTRxHJ48MkfOjV9pPI2tf+xCe4vxHYzdvw7/e7DzaA==
X-Received: by 2002:a17:902:f651:b0:20c:aed1:813a with SMTP id d9443c01a7336-211834fcd5bmr269519355ad.14.1731436989357;
        Tue, 12 Nov 2024 10:43:09 -0800 (PST)
Received: from thinkpad ([117.213.103.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e86e30sm94690045ad.281.2024.11.12.10.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 10:43:08 -0800 (PST)
Date: Wed, 13 Nov 2024 00:13:01 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Konrad Dybcio <konradybcio@gmail.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 0/3] Allow specifying an S2RAM sleep on
 pre-SYSTEM_SUSPEND PSCI impls
Message-ID: <20241112184301.6mlwpfzzowut36pn@thinkpad>
References: <20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com>
 <20241112180118.pcn7sf6r3mswwwxf@thinkpad>
 <ce1d2196-cf09-4d27-8b41-372948a59e89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce1d2196-cf09-4d27-8b41-372948a59e89@gmail.com>

On Tue, Nov 12, 2024 at 07:32:36PM +0100, Konrad Dybcio wrote:
> 
> 
> On 11/12/24 19:01, Manivannan Sadhasivam wrote:
> > On Mon, Oct 28, 2024 at 03:22:56PM +0100, Konrad Dybcio wrote:
> > > Certain firmwares expose exactly what PSCI_SYSTEM_SUSPEND does through
> > > CPU_SUSPEND instead. Inform Linux about that.
> > > Please see the commit messages for a more detailed explanation.
> > > 
> > 
> > It is still not PSCI_SYSTEM_SUSPEND though...
> 
> It *literally* does the same thing on devices where it's exposed.
> 

But still...

> > 
> > > This is effectively a more educated follow-up to [1].
> > > 
> > > The ultimate goal is to stop making Linux think that certain states
> > > only concern cores/clusters, and consequently setting
> > > pm_set_suspend/resume_via_firmware(), so that client drivers (such as
> > > NVMe, see related discussion over at [2]) can make informed decisions
> > > about assuming the power state of the device they govern.
> > > 
> > > If this series gets green light, I'll push a follow-up one that wires
> > > up said sleep state on Qualcomm SoCs across the board.
> > > 
> > 
> > Sorry. I don't think PSCI is the right place for this. Qcom SoCs have a common
> > firmware across all segments (mostly),
> 
> This ^
> 
> > so there is no S2R involved and only S2Idle.
> 
> is not at all related to this ^, the "so" makes no sense.
> 
> (also you're wrong, this *is* S2RAM)
> 

What? Qcom SoCs supporting S2R? I'm unheard of.

> > If you use PSCI to implement suspend_via_firmware(), then all the SoCs
> > making use of the PSCI implementation will have the same behavior. I don't think
> > we would want that.
> 
> This is an issue with the NVMe framework that is totally unrelated to this
> change, see below. Also, the code only sets that on targets where such state
> exists and is described.
> 

Well, you are doing it just because you want the NVMe device to learn about the
platform requirement.

> > For instance, if a Qcom SoC is used in an android tablet with the same firmware,
> > then this would allow the NVMe device to be turned off during system suspend all
> > the time when user presses the lock button. And this will cause NVMe device to
> > wear out faster. The said approach will work fine for non-android usecases
> > though.
> 
> The NVMe framework doesn't make a distinction between "phone screen off" and
> "laptop lid closed & thrown in a bag" on *any* platform. The usecase you're
> describing is not supported as of today since nobody *actually* has NVMe on a
> phone that also happens to run upstream Linux.
> I'm not going to solve imaginary problems.
> 

Not just phone, NVMe device could be running on an android tablet. I'm not
talking about an imaginary problem, but a real problem that is in a forseeable
future (that is also the reason why NVMe developers doesn't want to put the
device into power down mode always during system suspend).

And with this change, you are just going to make the NVMe lifetime miserable on
those platforms.

- Mani

> Besides, userspace already has sysfs to tune device power state knobs. Which
> Android uses very extensively on market devices.
> 
> Konrad

-- 
மணிவண்ணன் சதாசிவம்

