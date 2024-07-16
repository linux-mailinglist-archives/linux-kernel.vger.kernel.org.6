Return-Path: <linux-kernel+bounces-254534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA5B93346C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 01:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52BC31C209BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 23:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8396014388D;
	Tue, 16 Jul 2024 23:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUg00Jq9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C341821350
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721171110; cv=none; b=ueVDB7/hEZiloKmV1IN+7Y+WMtl6/xz2gtNETHw1oXUHPRM1qS7IZt0nAeLp4sP/EDPu9j4k1AxY/bUDXsZGYlIwl3IAvCGIxRDwjm7rn3pLeb5nf+7ViVh8ZyuM/atKgswT2dmKnnSdNzj66OFEaRJLVaVbAy31VQJee8qLRRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721171110; c=relaxed/simple;
	bh=m+o1u6IYxSTGA883H4AKy1DwnNnt+5ZYesQ3xjJshMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DV4e7medQDyOPT25EhD0idRCEei44hs855U6e9Kx+45kiVxIB0F2gKX99XAohOyBEarzGuIQcphMc/UcPA0lc0UHiWcPQPMlRPkE5q0t/DH4g+WCu2vGKvZYyYZSfYpxRRieguS1PWgxV/Zg0GPGr1uNUpXA2zqv8SSvysdq2LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUg00Jq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C084C116B1;
	Tue, 16 Jul 2024 23:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721171110;
	bh=m+o1u6IYxSTGA883H4AKy1DwnNnt+5ZYesQ3xjJshMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XUg00Jq9C8XzFZMnjqpKsX5MAQ2xn/9ZQ5vdG2XzU1Vv4PCczQyqFEB+FtXXuSrMs
	 5YFd/yfVjwq/MTqiwDMHnkmvU+Zt1G+IXG6beS6ggp+0R9SZ2J2nlOLfjMiL2lDj8/
	 ZepAPrQDecoHzTeB/q1sGgoOTdB1JOgKAhsHfNQmoREAsjQLXEgPBMJkFHqTWCopNP
	 hxGDquXpcCj86xSyRqq9eWFq9Ea6YUr3yRQzQsNbnULu5BWIw5TnRp9v3Rww5oi/zz
	 5BfkHIADiTMGI0Dp4i5zFKz7DzMGIsDDW66SwztCJzE3NrRQCFUQvWEuAEH1Q9wXYO
	 d43hj2GS3HzZA==
Date: Wed, 17 Jul 2024 01:05:07 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/8] timers/migration: Read childmask and parent
 pointer in a single place
Message-ID: <Zpb8o1Nlt21IiNLU@pavilion.home>
References: <20240716-tmigr-fixes-v4-0-757baa7803fe@linutronix.de>
 <20240716-tmigr-fixes-v4-5-757baa7803fe@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716-tmigr-fixes-v4-5-757baa7803fe@linutronix.de>

Le Tue, Jul 16, 2024 at 04:19:23PM +0200, Anna-Maria Behnsen a écrit :
> Reading the childmask and parent pointer is required when propagating
> changes through the hierarchy. At the moment this reads are spread all over
> the place which makes it harder to follow.
> 
> Move those reads to a single place to keep code clean.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

