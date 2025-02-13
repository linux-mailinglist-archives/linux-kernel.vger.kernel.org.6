Return-Path: <linux-kernel+bounces-512345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A6BA337D1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3123F188BA78
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 06:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A048E207677;
	Thu, 13 Feb 2025 06:20:20 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EE920764B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739427620; cv=none; b=FQmyptrWtsp/MoSt1wHlXBRXagYNsmk5pyjT9qHhMgTKDf/Y+WBx2Jd3a923+XfAVGGgQg8Cr4VEjjHxkA544ugJRtACtNGfKD2q0WjyhyqXySY2Q0yCJx0PdQaMI72UYyVbN4nG8sZtpT7eN9Aruai03dPPhfqHtPJRnec3alg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739427620; c=relaxed/simple;
	bh=JcPbCi8v7vjRRdWdEiD4vFs61V4kvXHIdIROuoagHfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2SIK66645YwQGHfL8oWCYXrTCgjrqruaKpdywYYBs0hPJemlwbLlIJtN2zSmv4bx41ikF/igUqI7zdpq8Y4gTsqttvWskrey4usEqfThQZZeY+1vvyhgHY8SRJifmu44PftdnkFf0iPjdqSnoFN8kpaf5tQq1ad0eK1no9Z6B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 75A1C67373; Thu, 13 Feb 2025 07:20:13 +0100 (CET)
Date: Thu, 13 Feb 2025 07:20:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Philipp Zabel <p.zabel@pengutronix.de>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] apple-nvme: defer cache flushes by a specified
 amount
Message-ID: <20250213062013.GC19608@lst.de>
References: <20250211-nvme-fixes-v1-0-6958b3aa49fe@rosenzweig.io> <20250211-nvme-fixes-v1-3-6958b3aa49fe@rosenzweig.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211-nvme-fixes-v1-3-6958b3aa49fe@rosenzweig.io>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Feb 11, 2025 at 01:25:59PM -0500, Alyssa Rosenzweig wrote:
> From: Jens Axboe <axboe@kernel.dk>
> 
> Cache flushes on the M1 nvme are really slow, taking 17-18 msec to
> complete. This can slow down workloads considerably, pure random writes
> end up being bound by the flush latency and hence run at 55-60 IOPS.
> 
> Add a deferred flush work around to provide better performance, at a
> minimal risk. By default, flushes are delayed at most 1 second, but this
> is configurable.
> 
> With this work-around, a pure random write workload runs at ~12K IOPS
> rather than 56 IOPS.

Just as last time this really is not a driver feature.  Cache flushes
are slow on consumer hardware, it's just apple is worse than usual.
Breaking file system transactional guarantee by ignoring data integrity
command in the driver is a no-go.

If we want to allow an opt-in policy for those whole feel adventurous,
it belongs into the core flush state machine.  Fortunately the patch
author seems qualified to touch that :)



