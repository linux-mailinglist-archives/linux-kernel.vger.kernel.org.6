Return-Path: <linux-kernel+bounces-222142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1875690FD48
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE83D1F274B2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18A64205D;
	Thu, 20 Jun 2024 07:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tzx2EuTB"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FF63A29C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718867223; cv=none; b=GFs1cwDHAUBioDlzmXlJ0/hWlyX6IO7xtMv6A4EclizE46pXTPCcf+EeLenD5DK5sx1Tdey2pNpw4dFbRyVoPpbeL3YAK3Hwx0WaaPdM0b/EzhVgM79Y6xM0AZ3mBW8aL8rCBd1JksNnbFi/1SvVeZbj2zSJKicZSuToUq/0q/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718867223; c=relaxed/simple;
	bh=DcXWz5CFlIefWzpMkSREPj4zJjtH7hdSQdnWOWBmvag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/ZiOgu5Q4Exe4P8bQrhRSqdXPDspBxbHwKHFlfGBeLoJ3eKzC3ZTyOOMHHqMrPmyyQfx8KvKPEq8RnHO0dx6z1fXwLqHyItASjbQRDfA1HqhxjO8QVLm91IwnUDUYK0y7vePKs5gU4CFEAwziROVxo2mehzOqO0tMdF+jDpEIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Tzx2EuTB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0bI0KYtYLgbIVuLBFhEqyPOqQn0oDhTYfdh+JVuiqCY=; b=Tzx2EuTBDE17mtzqb5hEmUJvT4
	9n1RuHuJ/CmcRL33Hpx3wng4XmJB3O97HHo8DuPega1Gmpjd/gCigueYEwwznex0ZEkEXiW+H9pB7
	0gSGHHdDzG+GuiU9+yQua5yRrfgWoPEurf6EiGcu5O1gH9DvqMrRXOiqOCOE97UERm5gNef79LSfT
	QXVqlWmgwsXrqWDxhj/zRX7542hzdjAtrY4yVJ6NpgPv4roLfxlJ7IIV5n/0kdKgd9OQoaXho+qGp
	dk8DN5g6aNB4nYk4GavynYl+V/GgtKCxaJ7eZiv7cYfEaM2KBhvkWANkjP68hSiPeji1m6psfT39n
	2qUrAx5w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKBsg-00000007Vu9-2NnJ;
	Thu, 20 Jun 2024 07:06:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 128F9300CB9; Thu, 20 Jun 2024 09:06:50 +0200 (CEST)
Date: Thu, 20 Jun 2024 09:06:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
	ak@linux.intel.com, eranian@google.com,
	Sandipan Das <sandipan.das@amd.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	silviazhao <silviazhao-oc@zhaoxin.com>,
	CodyYao-oc <CodyYao-oc@zhaoxin.com>
Subject: Re: [RESEND PATCH 02/12] perf/x86: Support counter mask
Message-ID: <20240620070649.GQ31592@noisy.programming.kicks-ass.net>
References: <20240618151044.1318612-1-kan.liang@linux.intel.com>
 <20240618151044.1318612-3-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618151044.1318612-3-kan.liang@linux.intel.com>

On Tue, Jun 18, 2024 at 08:10:34AM -0700, kan.liang@linux.intel.com wrote:

> +	for_each_set_bit(idx, c->idxmsk, x86_pmu_num_counters(NULL)) {
>  		if (new == -1 || hwc->idx == idx)
>  			/* assign free slot, prefer hwc->idx */
>  			old = cmpxchg(nb->owners + idx, NULL, event);

> +static inline int x86_pmu_num_counters_fixed(struct pmu *pmu)
> +{
> +	return hweight64(hybrid(pmu, fixed_cntr_mask64));
> +}


This is wrong. You don't iterate a bitmask by the number of bits set,
but by the highest set bit in the mask.


