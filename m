Return-Path: <linux-kernel+bounces-557839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A39A5DE76
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05AB3ABAC2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D876B24CEFE;
	Wed, 12 Mar 2025 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="toNfX+21"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDA124CEDF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741787671; cv=none; b=trGGBm1s7j8o4snNc3CQrc+0mX1Y7a1FVwlzw9wm1zZLv+ZfPQ/C19mZ0G8UgFhfEQQACFuW0cSRRWkmXu+6qhu1PRuVmit9TjUgTx5U8/N4Flvk1max2ZrwHaxr0MqoJ/enlSKuUwCq3n5jiz4xTKvTBOBL9xKbLRwawXAbrH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741787671; c=relaxed/simple;
	bh=Ed0wdEeViwxIbMHQHz+oOPI+iFPQHy3GupPkYoL7b4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/vjBcQ3pYcMI73UyFP52n3wKWnHqc0n69uglzmSVxpobTlfFycP03PNKoihFIIWldnaYr9CJlIbx1scAazqR2t9rrf/EiU+uA3u6Fm/aPQUgnvP4xD2ytADXadBghANx0+5xqOX99qQQ0m0AW/MGYCG7043D8s2jGpe2iQBVMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=toNfX+21; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m1NzlSxeWSKjyMojK2bHdW++RcJCnvmr2KpHmhYq77s=; b=toNfX+21cchlW5V/GpsDXrIP66
	vggJSO10e6fu/q6BtMwC+/rGI0YTKoWomkrBOefhG6w66HJoLjlWNFhz8RoscJNQPa6vO/gLrtkWF
	BCyc2rprSpV7+z+39i6TmeFYAdaaQwfadUdJL2HntfkgeorRgqtP4C9ctkf4gVUTcaTcS3hRtn0Yz
	24Ux2fM1MAw7UD0R8yeD6kHOdFRB6plamWyLtL0SBJe3QOA5vd/N2iG5upFVyVDMlnfADeupToBdd
	5LTaRUDbwdBL/s01cwrs2GUCzH0DyqLduKa+y9zp5bbyRIDkSXQd2Lg1Es+Oen+5mKzHX+Unr0tc6
	9AwhTvcA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tsMXQ-0000000Cv32-0Ru0;
	Wed, 12 Mar 2025 13:54:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 46E2A300599; Wed, 12 Mar 2025 14:54:23 +0100 (CET)
Date: Wed, 12 Mar 2025 14:54:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, tglx@linutronix.de, bp@alien8.de, acme@kernel.org,
	namhyung@kernel.org, irogers@google.com,
	linux-kernel@vger.kernel.org, ak@linux.intel.com,
	eranian@google.com
Subject: Re: [PATCH V7 1/6] perf: Save PMU specific data in task_struct
Message-ID: <20250312135423.GM19424@noisy.programming.kicks-ass.net>
References: <20250312130424.3863916-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312130424.3863916-1-kan.liang@linux.intel.com>

> The whole patch set was posted several years ago. But it's buried in the
> LKML without merging. I've received several requests recently to fix the
> LBR issue with system-wide events. Rebase and repost it.
> 
> - Rebase on top of Peter's perf/core branch.

That branch is older than tip/perf/core, as such things don't apply
anymore :/

