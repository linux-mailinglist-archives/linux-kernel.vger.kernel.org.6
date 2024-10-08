Return-Path: <linux-kernel+bounces-355594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F4B99547B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295931C20AEA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670731E0DE2;
	Tue,  8 Oct 2024 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SfW5zJgk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YFPa+3Ep"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBA476048
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728405197; cv=none; b=VeFgBuIifX7dzNIG7hvVwDb2Z0NB+fz2Zzw6XD0LOphdspYCBsIhT/90tI/JjSmpLLwTQWAQjeD+BbjM/70/iTpO6oYLKEK+m/eXgw/fOoMZZty/LB8mvaH5l0+3RQ22Go6EclHAm7529F+ZkBDhHdvxHnwBgcq2LuwGKo9vaps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728405197; c=relaxed/simple;
	bh=NPHlF3U9EDjmlP5C8GgRljogQLh6ZSFABCIY9YnkpmY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cKMkw/akbuADOcktMu80blsH5GVR8B9RDWowSeBvQyKIWSOthkQR2xwMrln5cQDdIdI7tAcaeBinxyQ7Z3qHtLp1csGo6/R52xdKcuvk3IP/a+CP5xPMxrSrVAn6VHYindAePq66Pf1tDM6GYoM5a/t3W99mCdr+XGFbZoWpGWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SfW5zJgk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YFPa+3Ep; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728405194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WJXzQd5oDtRgpEULpu6QHJU6slB/L2DXRJ17F/8tCx8=;
	b=SfW5zJgkEI377NnOt+OozAwdHy1R7BYu01OAvdqQ2KGYfpTjOFE0L9YEkeaRjEc6Pp4kLt
	HqxB2DlanlN+fn6t1Tgc9r6R7vHAbGhie5pY+exL6XyJDrSnPbK8R4kCvzx8Rxf6C2BQdH
	0FaK2HB5wnI3gOYGTQtdCtXojc/2ub2z8U0mXmWvG+R1rPza05taQXOqDRnqUhrLjIGP4e
	n89uZVawfQ3XTjZ2Tl8ci/O+zUTjuOaejoiW2J1uVsRp0SjmSe9LMWl9hgJWj1YwBIImbe
	TpHEVIKe5/gUWSknRXT7/tFlo81O3ZUlTE7LX4VQZA2gprFipWh2zcGhOAq3pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728405194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WJXzQd5oDtRgpEULpu6QHJU6slB/L2DXRJ17F/8tCx8=;
	b=YFPa+3Ep64DZ4alR4own23b6l0GKWYcGc1L6FkD6PAgjP1vPjp5bSWgPgtpWA5cfrjGCnS
	DLPxJyZL2W5Ga6DA==
To: kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
 linux-kernel@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>, Oliver Sang
 <oliver.sang@intel.com>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH 1/2] perf/x86/rapl: Move the pmu allocation out of CPU
 hotplug
In-Reply-To: <20240913171033.2144124-1-kan.liang@linux.intel.com>
References: <20240913171033.2144124-1-kan.liang@linux.intel.com>
Date: Tue, 08 Oct 2024 18:33:14 +0200
Message-ID: <875xq2tv05.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 13 2024 at 10:10, kan liang wrote:
> +static void __init init_rapl_pmu(void)
> +{
> +	struct rapl_pmu *pmu;
> +	s32 rapl_pmu_idx;
> +	int cpu;
> +
> +	cpus_read_lock();
> +
> +	for_each_cpu(cpu, cpu_online_mask) {

How is that supposed to work, when not all CPUs are online when
init_rapl_pmus() is invoked?

Thanks,

        tglx

