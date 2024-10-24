Return-Path: <linux-kernel+bounces-380597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F189AF325
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D654F1F223D9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0BB2003AA;
	Thu, 24 Oct 2024 19:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tPILtAAX"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60A11F80AD
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 19:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729799878; cv=none; b=r2ukj3nMXQa5jwpn8h8bHr4hjoD+RBkFtu9pcnZm6TjpjwfQlV86aZ3/vfGTNsy4sH50vaHYg/kbz0kk0gD/ZJsZ5Z2Au/BR2nZTx+rltP7ph/AsvcAgDAKZBPAarh9Sxuh/QK7/tEHhTQdc5n+0L9Hit3kXTk8Y+5w2n+pr2VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729799878; c=relaxed/simple;
	bh=bTSZ+AIYW4PtKktAhtWQiw/nwwUpqv9LctwwUYhZcYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TY4AJDvaQGy9Y2qNBE6kXPSfC1PVZiDmbNO13UKIWEND8II4t49nqwfHEn2vEX/wLcInIDTrdGGVpD5LSHWv76dD3XJnlVBL4D7LiA9Wml4TBfsFdVKnnWzmMd2kruLWi8hEaaSaljx79ZQcV5bTWjj+Y0WUJvaWUFxwfsjpZnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tPILtAAX; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 24 Oct 2024 12:57:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729799868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8BK0ZcosXDoOXzSbDL6svDcVkcl94/C1ybPNkAKv7is=;
	b=tPILtAAXE+IgUeUPC4X+luEap2SlsyS17q2HLFknCMik+U8I3s2RvzCZUnSAzQqNJDKt9e
	M/MTZyMVUnCKCJYUBNzj0u5ZsYLzm6ShCLECXJkxN//oG4dDtOWhz5P9RCDzSDwfta6E2h
	1b0NgK8VyuKZarNkmkLJPSv4ZjfS/hI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Miguel Luis <miguel.luis@oracle.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Shuah Khan <shuah@kernel.org>, David Woodhouse <dwmw@amazon.co.uk>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	Francesco Lavra <francescolavra.fl@gmail.com>
Subject: Re: [PATCH v6 6/6] arm64: Use SYSTEM_OFF2 PSCI call to power off for
 hibernate
Message-ID: <ZxqmsiXV6ZYTANKY@linux.dev>
References: <20241019172459.2241939-1-dwmw2@infradead.org>
 <20241019172459.2241939-7-dwmw2@infradead.org>
 <23C91005-7304-4312-A5E0-F5E6C05B3209@oracle.com>
 <ECD0CA58-2C3B-48F3-AF12-95E37CB0FC48@infradead.org>
 <ZxprcWDe2AXuLhD_@linux.dev>
 <691447A1-8F3F-4890-B00F-8068A14CA126@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <691447A1-8F3F-4890-B00F-8068A14CA126@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 24, 2024 at 05:56:09PM +0200, David Woodhouse wrote:
> On 24 October 2024 17:44:49 CEST, Oliver Upton <oliver.upton@linux.dev> wrote:
> >IIUC, you're really wanting to 0x0 because there are hypervisors out
> >there that violate the final spec and *only* accept this value.
> >
> >That's perfectly fine, but it'd help avoid confusion if the supporting
> >comment was a bit more direct:
> >
> >	/*
> >	 * If no hibernate type is specified SYSTEM_OFF2 defaults to
> >	 * selecting HIBERNATE_OFF.
> >	 *
> >	 * There are hypervisors in the wild that violate the spec and
> >	 * reject calls that explicitly provide a hibernate type. For
> >	 * compatibility with these nonstandard implementations, pass 0
> >	 * as the type.
> >	 */
> >	 if (system_entering_hibernation())
> >		invoke_psci_fn(PSCI_FN_NATIVE(1_3, SYSTEM_OFF2), 0 , 0, 0);
> 
> By the time this makes it into released versions of the guest Linux kernel, that comment won't be true any more.

Then does it even matter? What is the problem you're trying to solve
with using a particular value for the hibernate type?

Either the goal of this is to make the PSCI client code compatible with
your hypervisor today (and any other implementation based on 'F ALP1') or
we don't care and go with whatever value we want.

Even if the comment eventually becomes stale, there is a ton of value in
documenting the exact implementation decision being made.

-- 
Thanks,
Oliver

