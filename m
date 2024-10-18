Return-Path: <linux-kernel+bounces-372180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128939A4559
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6CC92812ED
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE17204012;
	Fri, 18 Oct 2024 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wNAZAOF3"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383872038B8
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729274317; cv=none; b=oCujP9eOPbPX6g/IvWHHt82ufNO6awXPyzWzBmX1kxsr0gMs4BoN1OIYiZZen9l9VjP6Abwm7UnNfNk6VxrLxFAhOtGmcwgzbk1l1S7nbo4AkP+PJJIiOCVgv4sOJuDWUp/ImmZjtKbrtgGIPRS4LmPR19zyiG0CLuZK4Kfl0uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729274317; c=relaxed/simple;
	bh=oHgvB2cXKEMPeb1/CIHBwhI6gydtE+LOSyagYqAN2Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsidcWz60ZGCNmtDVy2f/riHlU1xADgjurqc6cVPIpZPg66Nsi4GB3J4IcUbrars8Q6Od4rSEyQGTFovhKQ5G5uA3FjBcM8lLi44Oe5ZkQfYXiIziAM4IWNOAQio04E8cWQui+vNfrdAwrLHzykHCncwKBRmwrro+tTGukBld8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wNAZAOF3; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 18 Oct 2024 19:58:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729274313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6SSCJKGNmaYNr86sLhzC8X3qGmGJ7Vg1vqzbd8IA33U=;
	b=wNAZAOF3vWyBtZerOPiHjHkzEz84HJaEbiFQHSNAQ2nMibq+GuE8wBwjZ5P8XQOOol8nLN
	iPVk8Z1s6zIEq2UdlP84rVb4askv6GJlpuOtCvECKAucuaSO6nPF4tD5N/LhhCYkgN5Aa/
	iFVhVRi3TJ7rmIwjHOHalBWfcFuCs9I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrea Righi <andrea.righi@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: improve WAKE_SYNC behavior for default idle
 CPU selection
Message-ID: <ZxKhxaM8Wv8EEXMd@gpd3>
References: <20241018094033.160188-1-andrea.righi@linux.dev>
 <ZxKdAvnLOmzPH4in@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxKdAvnLOmzPH4in@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 18, 2024 at 07:38:10AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Fri, Oct 18, 2024 at 11:40:33AM +0200, Andrea Righi wrote:
> ...
> > +	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
> > +	 */
> > +	if (wake_flags & SCX_WAKE_SYNC) {
> > +		cpu = smp_processor_id();
> > +
> > +		/*
> > +		 * If the waker's CPU is cache affine and prev_cpu is idle,
> > +		 * then avoid a migration.
> > +		 */
> > +		if (cpus_share_cache(cpu, prev_cpu) &&
> > +		    test_and_clear_cpu_idle(prev_cpu))
> >  			goto cpu_found;
> 
> Shouldn't this do set cpu to prev_cpu before jumping to cpu_found?

Ah! You're absolutely right!

Let me send a v2 (and test it).

Thanks,
-Andrea

> 
> Thanks.
> 
> -- 
> tejun

