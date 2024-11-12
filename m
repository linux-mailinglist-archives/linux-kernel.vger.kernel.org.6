Return-Path: <linux-kernel+bounces-406702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 984269C648B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB2CBB65EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B326219E26;
	Tue, 12 Nov 2024 20:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="L5ANW0Ru"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B928D20ADFA;
	Tue, 12 Nov 2024 20:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731442872; cv=none; b=AKyyE6vA9GOYDHX757G0b9dBzjJuNEMQqCjct3RLgfszddQGz99tiKJEjmDBu7cEy1TzhlwxxO1M7HoSXGBeYx3HCki7xvvtbp9a47orDS72/ha271wi2StFOvdnW/x9vDk19reqIDuv6gduesUGZprLXyzBRDT9HHCFsnPS/Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731442872; c=relaxed/simple;
	bh=sZLRFip0WWER1UnnWi7uDm4cse+z8//yycBkrNH22Oc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RhUfGl9Sf7Q/THbnvYMc1dlhvNAeCL8mJvJLP1xXmgwjB2c73LO9eUSFUwHpzmw0GMISkhzEtwoI6plj3sa7XJnRxYtmZwGKsdM3E2WSDKkpT369rXBnFzoVbZHiMrEySSesuvyPq9zBF5kdKd8LPBEb+Ni0QeJFQumaAqNsvRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=L5ANW0Ru; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F304D403E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1731442870; bh=FAKz9b0tJ0dvVcQnknK5tsZIfkPzhBw83aE+S0A/TOE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=L5ANW0RudfhXJ/4Scu4FJ6w7/s+idHB5y5g9dZd/izMqonwLQ2OupMK/iKAjji5rG
	 Dxh1XQDfb9zi2VsxchAVMWySJ7Xu8hlZVW+foKURa/EKQ2IBqzokbE/JOQ+Rfd3Vpn
	 egSN/jwEm6+LJEfP63WAsxPbbvrAXDyVou7mVH70LaaXa4AmjpOUlqz87FqvGYq57W
	 H0+n8wwLRS4VfJtGCSWLMOjFEPU7XWEBadVOwW5wsG3mTrAg+mqCsjrYjYwYvc0ZiD
	 iOjoJITfxI/WTsm0rWQvmgdoDOYGO8yhPKu2dy/Za8BQ8W1E0Fwe0+00qDIh3AOOhU
	 Yp/unkbGI1Mgw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id F304D403E4;
	Tue, 12 Nov 2024 20:21:09 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: anish kumar <yesanishhere@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, anish kumar
 <yesanishhere@gmail.com>
Subject: Re: [PATCH] drivers: core: Clarify EPROBE_DEFER retry mechanism
In-Reply-To: <20241105045535.84071-1-yesanishhere@gmail.com>
References: <20241105045535.84071-1-yesanishhere@gmail.com>
Date: Tue, 12 Nov 2024 13:21:09 -0700
Message-ID: <875xosqk3u.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

anish kumar <yesanishhere@gmail.com> writes:

> The existing documentation for EPROBE_DEFER explains its purpose
> and usage, but does not specify when deferred probes are retried.
> This patch adds information about the retry mechanism to provide
> a more complete explanation of how EPROBE_DEFER works.
>
> Specifically, it clarifies that:
>
> 1. Deferred probes are added to a pending list
> 2. A successful probe of any device triggers moving all devices
>    from the pending list to an active list
> 3. A workqueue processes the active list to retry deferred probes
>
> This additional context helps developers better understand the
> behavior and implications of using EPROBE_DEFER in their drivers.
>
> Signed-off-by: anish kumar <yesanishhere@gmail.com>
> ---
>  Documentation/driver-api/driver-model/driver.rst | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/driver-api/driver-model/driver.rst b/Documentation/driver-api/driver-model/driver.rst
> index 06f818b1d622..c86b948d0dfe 100644
> --- a/Documentation/driver-api/driver-model/driver.rst
> +++ b/Documentation/driver-api/driver-model/driver.rst
> @@ -171,10 +171,13 @@ released all resources it allocated.
>  Optionally, probe() may return -EPROBE_DEFER if the driver depends on
>  resources that are not yet available (e.g., supplied by a driver that
>  hasn't initialized yet).  The driver core will put the device onto the
> -deferred probe list and will try to call it again later. If a driver
> -must defer, it should return -EPROBE_DEFER as early as possible to
> -reduce the amount of time spent on setup work that will need to be
> -unwound and reexecuted at a later time.
> +deferred probe list and will retry again as and when a device or driver
> +gets added to the system. A successful probe of any device will trigger
> +moving all devices from pending list to active list. A workqueue processes
> +the active list to retry deferred probes. If a driver must defer, it
> +should return -EPROBE_DEFER as early as possible to reduce the amount
> +of time spent on setup work that will need to be unwound and reexecuted
> +at a later time.

Honestly, I don't see how this improves the situation?  How does this
improve a driver developer's work?

jon

