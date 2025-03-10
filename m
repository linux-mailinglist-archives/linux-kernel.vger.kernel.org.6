Return-Path: <linux-kernel+bounces-554603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCECCA59A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC9A3A642F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E64E22DFE5;
	Mon, 10 Mar 2025 15:50:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377B422332E;
	Mon, 10 Mar 2025 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621823; cv=none; b=SRwP5uaJPoIxhPBu1+gE/qbXFcCYrbEp5twdebpHmPEEsQUUAUKmgtvOn4ho5jevtqMMs4opnqUcvXJSbT7/cOaaArqlKPumMtxF5dxMlXb1DQvowqQV9vqqN/Fy5phQLKDDtjMNrtwt/yiP1pWROHYuasRWhOeRViOGzfV6/Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621823; c=relaxed/simple;
	bh=iS9+vSvOzrqV62mxwznPJsltsTrjWHcYTR8pofdi0Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHPyqYZQsfMe8tdvpFaRz/YFP/A2Iej5dXnxtxSRTjOknZRqnYDvTV+DO26nMhh8FBi1sslqZxuLDvoOoNS7pKazUn9VD+E4nkXTwlPqyVmvrOkrkQbHGJLj5c+KX/M6qezmdgjqfQA1VkRRDdUb7xh5uBKhaSmUDdEPTOQ0snI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EF4E1692;
	Mon, 10 Mar 2025 08:50:31 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96B003F5A1;
	Mon, 10 Mar 2025 08:50:19 -0700 (PDT)
Date: Mon, 10 Mar 2025 15:50:15 +0000
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
Subject: Re: [PATCH v2 5/8] coresight: etm: Add an attribute for updating
 buffer
Message-ID: <20250310155015.GG9682@e132581.arm.com>
References: <20250310104919.58816-1-leo.yan@arm.com>
 <20250310104919.58816-6-leo.yan@arm.com>
 <d8b1cf1f-1996-4d9c-9f1a-fad556f91577@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8b1cf1f-1996-4d9c-9f1a-fad556f91577@arm.com>

On Mon, Mar 10, 2025 at 01:29:26PM +0000, Suzuki Kuruppassery Poulose wrote:
> Hi Leo
> 
> On 10/03/2025 10:49, Leo Yan wrote:
> > Add an attribute for updating buffer when the AUX trace is paused.  And
> > populate the value to the 'update_buf_on_pause' flag during the AUX
> > setting up.
> 
> Do we need this attribute in the uAPI ?

This uAPI allows users to perform AUX pause and resume without the long
latency caused by copying hardware trace data.

E.g., a user can specify a large AUX buffer size using option "-m,128M".
If the buffer is considered large enough to accommodate hardware trace
data for a small program, the 'update_buf_on_pause' flag can be set to
false, the copying will be deferred until the end of the perf session.

I am bias to keep this uAPI.  If you prefer to remove it, I am also
fine with that.

> Could we do this by default for
> sinks without interrupt ? This definitely improves the quality of trace
> collected for such sinks and the driver can transparently do this.

How about we dynamically set the default flag in the Perf tool?

- If users set explictly the 'update_buf_on_pause' flag, then the
  setting will be respected.
- If users don't set the flag, perf tool detects it is TRBE sinks,
  then it can set 'update_buf_on_pause' flag as false.
- If users don't set the flag, perf tool detects it is ETF/ETB/ETR
  sinks, it sets the flag as true.

Thanks,
Leo

