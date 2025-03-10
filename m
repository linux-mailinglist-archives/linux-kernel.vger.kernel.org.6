Return-Path: <linux-kernel+bounces-554130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF95A59354
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9C81892012
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F340E227E96;
	Mon, 10 Mar 2025 11:59:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AD7227E93;
	Mon, 10 Mar 2025 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607959; cv=none; b=nFcfDcDWVXKiAH2CYRXR5ViqeZq2QmH3F9twlmAnNG5SnXeZSp7O9s13dalz7B/z5DKUr9vfZ0fzQMsREM1N2elTRRVi8oqMhgZPqSMkzSqeQKGZR7sUSPfgu4WlaLY+LBENga8WoLaKuU/ltHdzISBm0yC6OmWePhpyQOJeqrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607959; c=relaxed/simple;
	bh=KC5pKqOzGgVNKOXPAtwWabEu17rmUsNvJIq9RJpZ1uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVrUjhveVBGc1DqlldSd13QipVUU6Z84sURAYPWysRthncsOuVGKU5EyMvKjiyUDofSwoDyXLertySy6NBI8KaXibdcsR1ohPov//W2Mn3xmQ37n0Lok34vNBZm2b+6EPlZVXQDQnMlsB4zqvWflaerwUtQ70pXcRvw5VYH1gwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C61151516;
	Mon, 10 Mar 2025 04:59:27 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E145A3F5A1;
	Mon, 10 Mar 2025 04:59:15 -0700 (PDT)
Date: Mon, 10 Mar 2025 11:59:11 +0000
From: Leo Yan <leo.yan@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/8] coresight: etm4x: Extract the trace unit
 controlling
Message-ID: <20250310115911.GE9682@e132581.arm.com>
References: <20250310104919.58816-1-leo.yan@arm.com>
 <20250310104919.58816-2-leo.yan@arm.com>
 <bb390d95-7f2b-4327-a809-9e4cdbd1a1bc@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb390d95-7f2b-4327-a809-9e4cdbd1a1bc@arm.com>

Hi Suzuki,

On Mon, Mar 10, 2025 at 10:57:25AM +0000, Suzuki Kuruppassery Poulose wrote:
> Hi Leo
> 
> On 10/03/2025 10:49, Leo Yan wrote:
> > The trace unit is controlled in the ETM hardware enabling and disabling.
> > The sequential changes for support AUX pause and resume will reuse the
> > same operations.
> > 
> > Extract the operations in the etm4_{enable|disable}_trace_unit()
> > functions.  A minor improvement in etm4_enable_trace_unit() is for
> > returning the timeout error to callers.
> > 
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> 
> fyi, this area of code has changes significantly and will cause
> conflicts, due to the introduction of synchronization after
> each access to the TRCSTATR. Please rebase your next version on
> the coresight next branch to avoid the conflict.

Sure.  Will rebase on CoreSight next branch [1].

Thanks for reminding.

Leo

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git/log/?//h=next

> The changes as such look good to me.
> 
> Suzuki

