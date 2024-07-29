Return-Path: <linux-kernel+bounces-265676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0550393F44A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F311F227EF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27A1145B16;
	Mon, 29 Jul 2024 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DeMed2O3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KnHBcMJh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64AC13AA26
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253226; cv=none; b=B2g76BCnBxiwD7Q1pllYoIGRN1usqfhi0/qy3eh8zUH2iJa56T/CHnfbgKLVMnZHzifiGJZjlSv1XimHcbMZpN2qRg+lE9NH8oaTv2xC6kDZA7wmuAfEOmUY7wJVyzuSVqqyoMNlmaBKJYlF3N7SPltUcG6QMNOE7ujdOsVBWlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253226; c=relaxed/simple;
	bh=u6PeKF92llI1DdNMZvjP1sdulzCRGYxmKMJErbhj+wU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SRbzYXE0MroVi4V7Ww3XZY0Xi/hnLe95WRLt+FRJb9k5YPpF2M8v8cpHW5o/QL51aHM24G4ImF9pQphBl2WKykqt19tWULV6AgnBCuwL/lG5v1unLTaBy46aGDc6F3tmOyOAlw5VmjFK8xfzsmGquGKxZbEHQNo8qrw0NqRDans=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DeMed2O3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KnHBcMJh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722253216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=94M1ZHgpWiyBrLavpWVI1M/6xVg1GAI3Q3mDFVuUqsU=;
	b=DeMed2O3bIGHSsOeMP2yVVapGbMCQoMEtCp1rFpDSafgSOc78P5nYbHoTVpmLP3n5dfRHU
	+Z6BpbtQigjY7JU0i4GtWPK349Q2YAeTA0BVz13fysqPxfkVPR+xR1r8BbBpAPzFHNSH00
	NTHkRr2t1vFyCHJa2emRHRtSlK44pvQbxPQm7NuWWP883OyKTJiT0EEEGnbc4hKKUA0dyp
	W27KCJnO6YNv7x7VSnd0/gDV5MYspCvKK1K1TNkBJMvjftR8vGc2K3O6MIGGMu5zvNIVtN
	YHe9UEOcG3sd5C7lytW/8Znf/dESpZhOzXlwcBCzlWDuLV1gFmDIEc7HClqflA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722253216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=94M1ZHgpWiyBrLavpWVI1M/6xVg1GAI3Q3mDFVuUqsU=;
	b=KnHBcMJhHHOX/OiJv7nWbU1GdA2qpdn3yHzkqY5SZonany/sgX/UIb2D8YZbkwRfpse2DP
	eB+AgzX156FjotAw==
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Mikhail Gavrilov
 <mikhail.v.gavrilov@gmail.com>, rafael.j.wysocki@intel.com,
 catalin.marinas@arm.com, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, Terry.bowman@amd.com
Cc: linuxarm@huawei.com, guohanjun@huawei.com, gshan@redhat.com,
 miguel.luis@oracle.com, Linux List Kernel Mailing
 <linux-kernel@vger.kernel.org>, Linux regressions mailing list
 <regressions@lists.linux.dev>, shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH] x86/aperfmperf: Fix deadlock on cpu_hotplug_lock
In-Reply-To: <20240729105504.2170-1-Jonathan.Cameron@huawei.com>
References: <20240729105504.2170-1-Jonathan.Cameron@huawei.com>
Date: Mon, 29 Jul 2024 13:40:15 +0200
Message-ID: <87ikwo8m00.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 29 2024 at 11:55, Jonathan Cameron wrote:
> The broken patch results in a call to init_freq_invariance_cppc() in a CPU
> hotplug handler in both the path for initially present CPUs and those
> hotplugged later.  That function includes a one time call to
> amd_set_max_freq_ratio() which in turn calls freq_invariance_enable() that
> has a static_branch_enable() which takes the cpu_hotlug_lock which is
> already held.
>
> Avoid the deadlock by using static_branch_enable_cpuslocked() as the lock
> will always be already held.  The equivalent path on Intel does not
> already hold this lock, so take it around the call to
> freq_invariance_enable(), which results in it being held over the call to
> register_syscall_ops, which looks to be safe to do.
>
> Fixes: c1385c1f0ba3 ("ACPI: processor: Simplify initial onlining to use same path for cold and hotplug")
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Closes: https://lore.kernel.org/all/CABXGCsPvqBfL5hQDOARwfqasLRJ_eNPBbCngZ257HOe=xbWDkA@mail.gmail.com/
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

