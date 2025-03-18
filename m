Return-Path: <linux-kernel+bounces-565561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47866A66AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58A6F7A7337
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA771D90C5;
	Tue, 18 Mar 2025 06:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pyD3dKuo"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB48E1B0405
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742279934; cv=none; b=N+O4Dyo71tkkzvLOX15/n6mj6hixVs3gu3176cbnQxfXNGsacLIIYuj5FHiu/YWYImUX7om40Z5L+DEtvsjH12PdtpI2Hy09zmuyk0esy1PyL+qpJ3WdrgYrj2Sh4BPp34erlKKhPJ5Ae91NMgyaAMVU0vsLtLmE/gpVQx/5MVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742279934; c=relaxed/simple;
	bh=Xkd1W54+skof31D5Vc9HPZLsP4UXaU3m4a6f14pbjC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+ugPx79xw4j++gep8LagkghMtwHCpJH0iVMoA5f+Yp6vxATNlRs9XtphQysCdL3NWpmUumjbM3olk4NVzszJqChm8fefiN4i2rJcJ/clDf+uKTu9QJwnWA49PhhpqUGfpMVr8zHdiwaT3pKU3A6ompBQ2aERtcE35DVeYXUNbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pyD3dKuo; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NoDvENuzewtlToC01BvX2rAwwlEM3FbInPo863Y2sHc=; b=pyD3dKuoMptDM5o7Pm/lyoi78c
	pX62Vrp6GOagk2NJA/OUX5gpKZyJqMvMqyfmEcnL9Io05cgPNDsxYkRKzo/Fsy6/ZDm4MZXhZXOJI
	CdB+dDdEw+azE9JRP9w7ykHbnRpDFnzoI076TcP7F1A3RJE04ff+LOfpttR05xBBCfqrYuteCh/XL
	gfOHG8dk7VZa+Hnm0IBp+yRracrRDWB/W6NRpiXpWQBNXxvLOkT9gqIJjxi1Du7LW9rSIhvFU75sE
	Zwi/LsLlUiUGCldHaQR9fCooMHV6aJqRXGIGsrAl+liyhDrJq6BX7gQV3IWsZScbWuRrba9LfR4JV
	Owwzlygg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tuQbA-00000003hUU-1g21;
	Tue, 18 Mar 2025 06:38:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F26E0300783; Tue, 18 Mar 2025 07:38:47 +0100 (CET)
Date: Tue, 18 Mar 2025 07:38:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jianyong Wu <wujianyong@hygon.cn>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, jianyong.wu@outlook.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SCHED: scatter nohz idle balance target cpus
Message-ID: <20250318063847.GA25930@noisy.programming.kicks-ass.net>
References: <20250318022358.195154-1-wujianyong@hygon.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318022358.195154-1-wujianyong@hygon.cn>

On Tue, Mar 18, 2025 at 02:23:58AM +0000, Jianyong Wu wrote:

Re subject; if you look at other patches for sched, you'll note that we
do not capitalize it. Also, what you're doing is not scatter, it is
rotation.

> Currently, cpu selection logic for nohz idle balance lacks history info
> that leads to cpu0 is always chosen if it's in nohz cpu mask. It's not
> fair fot the tasks reside in numa node0. It's worse in the machine with
> large cpu number, nohz idle balance may be very heavy.

Since you seem to care about ilb and numa; there is this _very_ old
patch set that never got finished:

	https://lore.kernel.org/all/20091211013056.305998000@intel.com/

IIRC there was a problem where it would simply stop running the per-node
ilb when the node went idle, leading to node level imbalances. This
should be curable by picking one such idle node and keeping its ILB
active or somesuch.

Something to poke at if you're interested..



