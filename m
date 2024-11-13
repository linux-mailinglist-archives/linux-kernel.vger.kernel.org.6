Return-Path: <linux-kernel+bounces-407216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C63E09C6A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41C23B24557
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FB9189F25;
	Wed, 13 Nov 2024 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V4Id+QWF"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25081189BA3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731485151; cv=none; b=fcuYIAexthIkSErEdqhijl3Fjb7TIcN6gadChlizrpgrkDVGQBf+cSeoxTmKvsh8nOKWOp2Det0F/fGdWQVDzJ1u56Vwb6xgXRXY5ZeNQkPO3Q1T4cWNPPqiU7EGiUhtiefREdZm/tMho9ZeEotw/v/HANKIyV6PId9izbskJIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731485151; c=relaxed/simple;
	bh=iOCvd4apf2fOf50P5zWtor8GI7BamKiw4nxqd7xVMso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHEuMIDDPd9qnFjcj0DcE/eNlEhCxhXBj1wwOjdQVPdQvEi9eWaowf8D7E6DXy29HCD8TKautmm9l1v0yHT8vftPBk+/AfrfPsGBz7e7MFpuaQ8SCjWUXYpgLqXzxzgwW4An0VnPyBmoN+LQFCIzvmAf3sUeVL+gk6oF/GDpzs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V4Id+QWF; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7eae96e6624so4514248a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 00:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731485149; x=1732089949; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hlw6kUSyPp5tLgtfsZkFNg3PR6lL49gz78ER/JqTsTQ=;
        b=V4Id+QWFBGPnvrtRAz3F14zckWtNPf4mzPlv5iKLz7zdVcZRD2RP08/7ELMGli76S7
         u3mC5R0RMrGszWDt5VdvCdaJGmCMIFGdDXJrUf7JcIXf/uqZMJWQUUAZ0i6stGxsdJFE
         jfvxJOLZg231lUf043YdPKp42MH9dfhU8Wq3CHC4QUli7ALsV8VkFI1IGPrv/lyfWDi2
         6GDT6CCZYAy+m0OEYcZLM/Vx/71Nv6uRoGgCcodmuAYUUx6p+4rEJHMfnVbgtmGZkbKm
         ks8pzUS2D9++YfJ1+KlLgGW8tKukHi986C+DUHZxKkbuPNgG0dZS26z7FaepXnNrMA2k
         j5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731485149; x=1732089949;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hlw6kUSyPp5tLgtfsZkFNg3PR6lL49gz78ER/JqTsTQ=;
        b=GTKvBnhy2KUNW9j7bADH2F11MJLV6LCcT3gVhApYdatc5UzfHsfsJ8SldrjKFWpXLT
         TUS3fNZdssG0c5M7W5AiF9u3IsG68QJne4MzswMFq1Nr8aHfNCZLUdV0IEgYxTArn2es
         H3quOCplI7mLs3WjwpwCUzcusic30uRyMBI65M3D/Q/3LwKgUAuHHupAC74ag8mkPJIU
         N1VgipTfobPFjIB1PJixsO8tso3k3Ogetpn2HvaoXSaFXPC3EIKVmHfiZWmucc/A7qbJ
         cG//JSH8N2aFaB6tKLc1ppD7F8FReX6qgIMOqQodDcpx4Qp4ZTHrILN50ErjjFlECk21
         AtWg==
X-Forwarded-Encrypted: i=1; AJvYcCU9DC5cNEdRc5161+/CIbC0+XAiNUX9s4xFFDKjXxEulys1CRXGLrArltzx/cczRgmkCjB/pgsU4awfwEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmeVEE+9NNDB0Idws4Occ4zTEiSpRFlq6RvdMN0IO7ppYu57p3
	X1TW+QzsnmURxXjKvEhgv3YUjOptzWCpZ/+6jpNKB/jHbZjYCDZDoq+5nK1hHw==
X-Google-Smtp-Source: AGHT+IEjDnxKhbCCSCBWYLn3McpIR9HgecocJsUDjXO9Dqd9HW2AhapmTEwblwCMv1Z5Ny/KnEVQ9w==
X-Received: by 2002:a05:6a20:6a20:b0:1d9:3957:8a14 with SMTP id adf61e73a8af0-1dc228b0182mr24476009637.1.1731485149130;
        Wed, 13 Nov 2024 00:05:49 -0800 (PST)
Received: from thinkpad ([117.213.103.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f7127f3b01sm960520a12.84.2024.11.13.00.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 00:05:48 -0800 (PST)
Date: Wed, 13 Nov 2024 13:35:40 +0530
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
Message-ID: <20241113080540.mtm7nu7nqrfz27yj@thinkpad>
References: <20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com>
 <20241112180118.pcn7sf6r3mswwwxf@thinkpad>
 <ce1d2196-cf09-4d27-8b41-372948a59e89@gmail.com>
 <20241112184301.6mlwpfzzowut36pn@thinkpad>
 <eeec6eea-edb4-414e-9c11-88054e3624e4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eeec6eea-edb4-414e-9c11-88054e3624e4@gmail.com>

On Tue, Nov 12, 2024 at 08:04:34PM +0100, Konrad Dybcio wrote:
> 
> 
> On 11/12/24 19:43, Manivannan Sadhasivam wrote:
> > On Tue, Nov 12, 2024 at 07:32:36PM +0100, Konrad Dybcio wrote:
> > > 
> > > 
> > > On 11/12/24 19:01, Manivannan Sadhasivam wrote:
> > > > On Mon, Oct 28, 2024 at 03:22:56PM +0100, Konrad Dybcio wrote:
> > > > > Certain firmwares expose exactly what PSCI_SYSTEM_SUSPEND does through
> > > > > CPU_SUSPEND instead. Inform Linux about that.
> > > > > Please see the commit messages for a more detailed explanation.
> > > > > 
> > > > 
> > > > It is still not PSCI_SYSTEM_SUSPEND though...
> > > 
> > > It *literally* does the same thing on devices where it's exposed.
> > > 
> > 
> > But still...
> 
> Still-what? We can't replace the signed firmware on (unironically) tens
> of millions of devices in the wild and this is how it exposes that sleep
> state. This is how arm platforms did it before the PSCI spec was
> updated and SYSTEM_SUSPEND is *still optional today*.
> 

I never asked you to replace the firmware in first place, so don't quote the
fact I never said. I see this approach as a way of abusing/faking PSCI system
suspend.

Moreover, I heard from Bjorn that Qcom doesn't want to put the PCIe devices into
D3Cold during system suspend for future platforms (based on their
experimentation). So if drivers rely on this static information, then even Qcom
cannot achieve what they want.

> 
> > > > > This is effectively a more educated follow-up to [1].
> > > > > 
> > > > > The ultimate goal is to stop making Linux think that certain states
> > > > > only concern cores/clusters, and consequently setting
> > > > > pm_set_suspend/resume_via_firmware(), so that client drivers (such as
> > > > > NVMe, see related discussion over at [2]) can make informed decisions
> > > > > about assuming the power state of the device they govern.
> > > > > 
> > > > > If this series gets green light, I'll push a follow-up one that wires
> > > > > up said sleep state on Qualcomm SoCs across the board.
> > > > > 
> > > > 
> > > > Sorry. I don't think PSCI is the right place for this. Qcom SoCs have a common
> > > > firmware across all segments (mostly),
> > > 
> > > This ^
> > > 
> > > > so there is no S2R involved and only S2Idle.
> > > 
> > > is not at all related to this ^, the "so" makes no sense.
> > > 
> > > (also you're wrong, this *is* S2RAM)
> > > 
> > 
> > What? Qcom SoCs supporting S2R? I'm unheard of.
> 
> Maybe you're thinking of hibernation, which is not widely (if at all)
> supported.
> 

Not hibernation. The Qcom platforms I've aware of all support only S2Idle. I
don't work for Qcom, so I may be missing some insider information.

> 
> > > > If you use PSCI to implement suspend_via_firmware(), then all the SoCs
> > > > making use of the PSCI implementation will have the same behavior. I don't think
> > > > we would want that.
> > > 
> > > This is an issue with the NVMe framework that is totally unrelated to this
> > > change, see below. Also, the code only sets that on targets where such state
> > > exists and is described.
> > > 
> > 
> > Well, you are doing it just because you want the NVMe device to learn about the
> > platform requirement.
> 
> And I can't see why you're having a problem with this. It's exactly how it
> works on x86 too. Modern Standby also shuts down storage on Windows,
> regardless of the CPU architecture.

It is not just my problem. I'm expressing the concern that NVMe folks have and
already expressed over the similar solutions I proposed. And I cannot just
overrule them.

> > > > For instance, if a Qcom SoC is used in an android tablet with the same firmware,
> > > > then this would allow the NVMe device to be turned off during system suspend all
> > > > the time when user presses the lock button. And this will cause NVMe device to
> > > > wear out faster. The said approach will work fine for non-android usecases
> > > > though.
> > > 
> > > The NVMe framework doesn't make a distinction between "phone screen off" and
> > > "laptop lid closed & thrown in a bag" on *any* platform. The usecase you're
> > > describing is not supported as of today since nobody *actually* has NVMe on a
> > > phone that also happens to run upstream Linux.
> > > I'm not going to solve imaginary problems.
> > > 
> > 
> > Not just phone, NVMe device could be running on an android tablet.
> 
> 'Could' very much makes it imaginary. There are no supported devices that
> fall into this category.
> 

Agree that there are no products in the market (yet). But having NMVe on
handheld devices is not something I would quote as 'imaginary'.

> > I'm not
> > talking about an imaginary problem, but a real problem that is in a forseeable
> > future
> 
> Keyword: future. This issue has been on hold for years because of 'issues'
> that are pinky promised to happen eventually, without anyone suggesting any
> actually acceptable solutions. This just undermines progress.
> 

Not true. There are solutions suggested, but then it always takes time to reach
consensus. One of the approach that I'm about to propose is to have a userspace
knob that specifies whether the device can be powered down or not (leaving the
default behavior to put them in low power state). Because, the decision to put
the devices into power down or low power state sounds more like an userspace
policy. It was discussed at LPC 2023.

> > (that is also the reason why NVMe developers doesn't want to put the
> > device into power down mode always during system suspend).
> 
> This is the current behavior on any new x86 laptop, and has been for a
> couple of years.
> 
> > And with this change, you are just going to make the NVMe lifetime miserable on
> > those platforms.
> 
> Fearmongering and hearsay. See above.
> 

I can only wish you best of luck with this approach!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

