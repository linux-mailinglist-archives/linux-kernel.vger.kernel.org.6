Return-Path: <linux-kernel+bounces-561130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE57FA60DE5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5845F4605CB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691631EF368;
	Fri, 14 Mar 2025 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uH1z7qZF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA931EE7A8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945877; cv=none; b=kAKreWK7/TjxGnjE23CZqOlrt94KvNYTgMuJ5ZtCmoYUj7UC+lA65cZlBSIVPCxl/g7a84GsSXr3fnfzW+zBQwuxuTLgCaQm6RqH3PoDfrRseaQEkrNHhN+04M1cmJY5d13pOrDUaTJ9fKFlb9BqNIlxHqAqOAeiJjinwJd/nUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945877; c=relaxed/simple;
	bh=oBzN6jT/B2XBG+KQWQLjx5+/3J5yCTkKB+ABrkG8spE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+pVZ0ef11FArn3MVP98n0OdHGYDiQUjU+2NcdmyxbZGY6DFzEXBOeWHsOEgXDzqnS9R54y29ordjPmuB1lmQXg/QMPklVX/TKsntjzFiG59tsJVP7dU7xBxMy+QeZ5Agr7rnZwYqOY2gNPK5iY1ce9nMFshwIyZds6uQxI6mIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uH1z7qZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89CCC4CEE3;
	Fri, 14 Mar 2025 09:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741945877;
	bh=oBzN6jT/B2XBG+KQWQLjx5+/3J5yCTkKB+ABrkG8spE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uH1z7qZFYkDVEhlDziVZzEKNqYLCHKs8iiT2xTGtlKLzY9tHOPI1fPSrV9/DwHf60
	 6nTvl/TgIheU/roMm5VU8dldnQSW4eS5bHEBC7mDwD4NhB3dVWFL5iZbp3/mVAzXgq
	 XqybVnv8ZBdeJX1dmuri+qOvWAXvx6GzceIFNdygQN8o8XjUm+iz611irmiB5NUoyR
	 fg4BOEObJGgPy0wSc5flTe7+N+++0AoD5laO8yoKzMrdWdjao75xGUcs/w8LXA7XWB
	 0HRZ29rS/8PfoYrSaBTtMAPI6inPGwVZkfigLEHquLvL/bTWA/2u5eGiL4hYWGxlY4
	 fYVV1ZatXV1ug==
Date: Fri, 14 Mar 2025 10:51:12 +0100
From: Ingo Molnar <mingo@kernel.org>
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com,
	linux-kernel@vger.kernel.org, eranian@google.com,
	thomas.falcon@intel.com
Subject: Re: [PATCH V2 0/3] Support auto counter reload
Message-ID: <Z9P8EDcGv0m__WiN@gmail.com>
References: <20241010192844.1006990-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010192844.1006990-1-kan.liang@linux.intel.com>


* kan.liang@linux.intel.com <kan.liang@linux.intel.com> wrote:

> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Changes since V1:
> - Add a check to the reload value which cannot exceeds the max period
> - Avoid invoking intel_pmu_enable_acr() for the perf metrics event.
> - Update comments explain to case which the event->attr.config2 exceeds
>   the group size

> The 2498 samples are all from the branch-misses events for the Loop 2.
> 
> The number of samples and overhead is significantly reduced without
> losing any information.

Ok, that looks like a pretty sweet PMU feature.

What is the hardware support range of this auto count reload feature, 
how recent CPU does one have to have?

The series has aged a bit though, while a variant of patch #1 has been 
merged already under:

  47a973fd7563 perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF

... but #2 and #3 don't apply cleanly anymore.

Mind sending a refreshed series perhaps?

Thanks,

	Ingo

