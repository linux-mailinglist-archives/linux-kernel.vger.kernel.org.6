Return-Path: <linux-kernel+bounces-434872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3418D9E6C39
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5356B18889D7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A0B200129;
	Fri,  6 Dec 2024 10:24:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2024F1FC0E1;
	Fri,  6 Dec 2024 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480673; cv=none; b=e/RMwDTQ44+IDwJxGIXzRCdTFUuyYcI7QmiAc3HD+PL3OaQbkbDCL5RFFy4U4kc0nSBDOTc9ty0LpHR6eKqAbkoUj12W+C/59Kvm/t1q4j54m+hheSJuQAy3sfYUdFdpkjz6Cb89h6Pcr9OvYtlcc0S0yoZS8R5lzMTCI35RIHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480673; c=relaxed/simple;
	bh=kcUa+zTRzcdPhK9IlN/bpQh3o7vKfSJFKnw4RPuVXwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOkgCG+1iiQrAHFYfsHPZSXq0m+aTYjI6xVNPAC+ys5JzmsuRD7sHfYAPH+fRdIfE8sqAGMb8HhGCZpfvDwht6ZqN9/IURi+3l+P2uBAUhCwDFBoBO+GxLL3CrNXiaRseJcDRIcZZqW4q9636lVweRbqaCo7mUCDoiCjZ/68hB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F10D12FC;
	Fri,  6 Dec 2024 02:24:52 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B87B3F71E;
	Fri,  6 Dec 2024 02:24:22 -0800 (PST)
Date: Fri, 6 Dec 2024 10:24:19 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 3/3] firmware/psci: Allow specifying an S2RAM state
 through CPU_SUSPEND
Message-ID: <Z1LQ0-3AVkVHgPaY@bogus>
References: <20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com>
 <20241028-topic-cpu_suspend_s2ram-v1-3-9fdd9a04b75c@oss.qualcomm.com>
 <ZzSiM6Pn6A9e1QUD@lpieralisi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzSiM6Pn6A9e1QUD@lpieralisi>

On Wed, Nov 13, 2024 at 01:57:23PM +0100, Lorenzo Pieralisi wrote:
> On Mon, Oct 28, 2024 at 03:22:59PM +0100, Konrad Dybcio wrote:
> > From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > 
> > Certain firmware implementations (such as the ones found on Qualcomm
> > SoCs between roughly 2015 and 2023) expose an S3-like S2RAM state
> > through the CPU_SUSPEND call.
> > 
> > This works exactly like SYSTEM_SUSPEND. The PSCI spec describes that
> > call as optional (and only introduced in PSCIv1.0), so not all
> > platforms expose it.
> > 
> > Marking a DT-described "domain-idle-state" as such isn't currently
> > well accounted for in the PSCI idle topology infrastructure: the
> > cpuidle and genpd framework are deeply intertwined, and trying to
> > separate them would cause more havoc than good.
> 
> I don't understand what you mean here please elaborate.
> 
> The part of the story I understand is that you have a system (well,
> firmware for an extended set of systems) that does not implement
> SYSTEM_SUSPEND but can reach a S2R like system state through the
> CPU_SUSPEND call. Firmware works in OS-initiated mode, idle-states
> should allow you to define idle states that allow the system to
> enter the S2R state through CPUidle.
> 
> Please explain to me what's missing.
> 
> > Instead, allow the specifying of a single CPU_SUSPEND sleep param
> > under the /psci node that shall be treated exactly like SYSTEM_SUSPEND
> > from Linux's POV. As a bonus, this way we also don't have to fight
> > with the genpd idle governor to avoid taking the S3-like state into
> > consideration.
> 
> That's not acceptable. I want to understand what's preventing this
> system to enter that state through suspend2idle and the mainline code.
> 
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > ---
> >  drivers/firmware/psci/psci.c | 36 +++++++++++++++++++++++++++++++-----
> >  1 file changed, 31 insertions(+), 5 deletions(-)
> 
> NACK
> 

+1, will wait for the response here before adding any more questions that
may lead to more confusion or discussion churn.

-- 
Regards,
Sudeep

