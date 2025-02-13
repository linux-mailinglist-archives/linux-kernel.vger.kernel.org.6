Return-Path: <linux-kernel+bounces-513340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BDBA34922
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4365B16412C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731341CDA3F;
	Thu, 13 Feb 2025 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="kw6jO4Ia"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1F81E766F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463001; cv=none; b=M0aWx6ldhEeQHeFuw4mSyGwcXgR8zxRCVHdV6NKKvIYrxnSZg93LA1LSE7O017dS+1pXsSRakSV6g44e9V1MBExU8jRQsSnf/OvO9J27B7xO6XabidoD31HdUyEE8uPXZB/GZ/Ru0XIdRBRIe2gWjaDG8RDnCoCkYVLJwdv5qFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463001; c=relaxed/simple;
	bh=t68uEDgIGoe+yAJpf2dEUXHWJ6C+k/fUENdM9MvG5HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqrjW8O25vYS378jMt45dSZUkTSYoGmhDkCAPyF+Usk8vYhABB7CePkx6VYpZJcYo/TEKr6KYF0TEHhFE5JJ3jB6Qj0jHEj5zyNb98s/q1S1knyJAZhO7ewMCfvZRnTQs2++RRU5QBvrwm4VmKzjfLg5Ng+ppA/T1of0rje9EdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=kw6jO4Ia; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Thu, 13 Feb 2025 11:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739462995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LMYKZBB6Lwu1KXc2pApJntLSaHOHjeDAYKss1JDPqUg=;
	b=kw6jO4Ia+fc0+hRWz5NBslXI4AxoBaap9J7j7JkJr3oMdJIAlggaIP9jQkT7m8adeZE3u4
	sjozzu76MUWQ6UMRI9BhHg26Alhi4Ih0SG5fEqiUOzLNOmTs4Lq7SlpIRIhzJs7KxFKZxr
	mp6GUpgBVFLkQanqmK3JiLm7hzJwiR//QPm3gyRiAz2m3icIQbtPiTaz7sL8GyJBBSbhsl
	gQkq4x/O9/KpG3O5/yVyOEKB3llflHo1gZXdWWB370m4lHBMVz4ZXyMtFLvC2/ajDbFKD0
	uhuS6+r7ShCjjTAPcMRDTM6HguF3fS3DdTKOHbrnC/KPr2T8h1buvoCQJrJdcw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Christoph Hellwig <hch@lst.de>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Philipp Zabel <p.zabel@pengutronix.de>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] apple-nvme: defer cache flushes by a specified amount
Message-ID: <Z64ZTixWKoYdF8KN@blossom>
References: <20250211-nvme-fixes-v1-0-6958b3aa49fe@rosenzweig.io>
 <20250211-nvme-fixes-v1-3-6958b3aa49fe@rosenzweig.io>
 <20250213062013.GC19608@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213062013.GC19608@lst.de>
X-Migadu-Flow: FLOW_OUT

> > Cache flushes on the M1 nvme are really slow, taking 17-18 msec to
> > complete. This can slow down workloads considerably, pure random writes
> > end up being bound by the flush latency and hence run at 55-60 IOPS.
> > 
> > Add a deferred flush work around to provide better performance, at a
> > minimal risk. By default, flushes are delayed at most 1 second, but this
> > is configurable.
> > 
> > With this work-around, a pure random write workload runs at ~12K IOPS
> > rather than 56 IOPS.
> 
> Just as last time this really is not a driver feature.  Cache flushes
> are slow on consumer hardware, it's just apple is worse than usual.
> Breaking file system transactional guarantee by ignoring data integrity
> command in the driver is a no-go.
> 
> If we want to allow an opt-in policy for those whole feel adventurous,
> it belongs into the core flush state machine.  Fortunately the patch
> author seems qualified to touch that :)

Fair enough. I didn't realize this patch was previously discussed, my
apologies. I'll drop this change in v2, and hopefully somebody is
inspired later to do that 'adventure'.

