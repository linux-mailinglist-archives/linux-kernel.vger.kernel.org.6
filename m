Return-Path: <linux-kernel+bounces-343663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBD7989DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267ED1F233D0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18741865F1;
	Mon, 30 Sep 2024 09:17:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AE615F3F9
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687830; cv=none; b=Qj5EF5jKuKJPeqwfoNlAHTTuJYGS+5EQIECivQSg7uZA67YFhh4XxNPwgexdtHm2OhKcZoBhlEClEjU71o5if/GTLPOGAp7nuhJie6758Flx9GBl3DHuc63NjLY4Bdr1RlgCzqim4HRGrQJnGI7mX4XzP7dAkwhktCVBBPU0IoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687830; c=relaxed/simple;
	bh=fv3P//tYxLBjWUgxef3YEpOIIsmKMNGy4KoBSNM0dPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7iWLanCtPsblVs5RvV1AEh8sHRQFQRQlwPCmdpjVc7uYyhTPoAxHKknXl881BNder4jJYZEtoq6Ex6NxA7qs/TJVds7Y+XMd4BkqYTiEyIhXi43xLMig/wPsZbSTVmy8LMuIrNgtwxa56n4YtVN5ev3SsqJVlWaUG+syHLj2JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74A66DA7;
	Mon, 30 Sep 2024 02:17:36 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE0043F587;
	Mon, 30 Sep 2024 02:17:05 -0700 (PDT)
Date: Mon, 30 Sep 2024 10:16:58 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"peterz@infradead.org" <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Yury Norov <yury.norov@gmail.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Question about num_possible_cpus() and cpu_possible_mask
Message-ID: <ZvpsikythXnvZ7V_@J2N7QTR9R3>
References: <SN6PR02MB4157210CC36B2593F8572E5ED4692@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157210CC36B2593F8572E5ED4692@SN6PR02MB4157.namprd02.prod.outlook.com>

On Wed, Sep 25, 2024 at 04:04:33AM +0000, Michael Kelley wrote:
> Question:  Is there any intention to guarantee that the cpu_possible_mask is
> "dense", in that all bit positions 0 thru (nr_cpu_ids - 1) are set, with no
> "holes"? If that were true, then num_possible_cpus() would be equal to
> nr_cpu_ids.
> 
> x86 always sets up cpu_possible_mask as dense, as does ARM64 with ACPI.
> But it appears there are errors cases on ARM64 with DeviceTree where this
> is not the case. I haven't looked at other architectures.
> 
> There's evidence both ways:
> 1) A somewhat recent report[1] on SPARC where cpu_possible_mask
>    isn't dense, and there's code assuming that it is dense. This report
>    got me thinking about the question.
>   
> 2) setup_nr_cpu_ids() in kernel/smp.c is coded to *not* assume it is dense
> 
> 3) But there are several places throughout the kernel that do something like
>    the following, which assumes they are dense:
> 
> 	array = kcalloc(num_possible_cpus(), sizeof(<some struct>), GFP_KERNEL);
> 	....
> 	index into "array" with smp_processor_id()
> 
> On balance, I'm assuming that there's no requirement for cpu_possible_mask
> to be dense, and code like #3 above is technically wrong. It should be
> using nr_cpu_ids instead of num_possible_cpus(), which is also faster.
> We get away with it 99.99% of the time because all (or almost all?)
> architectures populate cpu_possible_mask as dense.
> 
> There are 6 places in Hyper-V specific code that do #3. And it works because
> Hyper-V code only runs on x86 and ARM64 where cpu_possible_mask is
> always dense.

Maybe that happens be be true under Hyper-V, but in general
cpu_possible_mask is not always dense on arm64, and we've had the change
core code to handle that in the past, e.g.

  bc75e99983df1efd ("rcu: Correctly handle sparse possible cpu")

> But in the interest of correctness and robustness against
> future changes, I'm planning to fix the Hyper-V code.

To me, that sounds like the right thing to do.

Mark.

