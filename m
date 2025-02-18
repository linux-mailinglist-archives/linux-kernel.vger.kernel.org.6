Return-Path: <linux-kernel+bounces-519762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1623A3A194
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D0118944EC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BAF26D5CC;
	Tue, 18 Feb 2025 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCGvDAbJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BA923497D;
	Tue, 18 Feb 2025 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893357; cv=none; b=PMjzwaLtrtCQW3Ot7XwzWwyYzUp7xNSboLkkUpah9uZqqddftj121/G0a+98ZcajQflrgZybqq1UvpISASdqyRUQb2NoV+G37prBgy+uHz2JsIAyCVncsDPxzqJLat2ub10sO7zO2rEirXAlH4wnJTZ+WqmE46KmSCQ9LuyxjgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893357; c=relaxed/simple;
	bh=h88y8D02Qk/TX7WCvgXx2cIrrke/kfsKJ5iGeFmkiFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1DRPt7nonc228mn47lrBghlxhIh8c+jVk9SvNszE97vWNZO7uVxlS1xCApo3COo01vNPAHSQ+uYM6GS1/ywctjUljsRJ+tdbIZLyd58DhkiXwMIbgYd1ToB3EBaqCH9mlJNlxaTsSUSbr5KZ9Z31xiOIyPpXNqVtnKtq2idWzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCGvDAbJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2946C4CEE2;
	Tue, 18 Feb 2025 15:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739893357;
	bh=h88y8D02Qk/TX7WCvgXx2cIrrke/kfsKJ5iGeFmkiFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GCGvDAbJHnQxYFlugyZvoMME9inSa/4xrTnP1H/lioBrVzj1bhxN1+/SU8ucSM67Q
	 IfV2auMMAeE/fEKvGu7t8BLa0T/hvrCm1iFOnc2ZguAOychjmKJKsKKH853g37JGLi
	 2AvACw8zqcYNdUam96RBxkuYGCEjEd8SuHqxqTFmP8t5sB1WaVWWhYfTrLG2UWS7nM
	 +gvXuPqxg6+utgTptUkSyogTiRbcuTu0spNTUFFd7pdghrBlfZN+wGXDoz1WWe3YOx
	 Fagu77v9509AAzUwPJYclDu60bjSYeIKqvI/ejNw5Af2sdrsY3QCMwKzpkyDOuyRfB
	 AQdlLwfqjFBOw==
Date: Tue, 18 Feb 2025 08:42:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Philipp Zabel <p.zabel@pengutronix.de>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH v2 0/2] apple-nvme: bug fixes
Message-ID: <Z7SqahA-tuz386FN@kbusch-mbp>
References: <20250213-nvme-fixes-v2-0-a20032d13e38@rosenzweig.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-nvme-fixes-v2-0-a20032d13e38@rosenzweig.io>

On Thu, Feb 13, 2025 at 11:12:57AM -0500, Alyssa Rosenzweig wrote:
> This small series fixes two unrelated issues with the Apple NVMe driver.
> 
> * fix NVMe on certain combinations of firmware + machine
> * fix a power domain leak

Thanks, applied to nvme-6.14.

