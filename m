Return-Path: <linux-kernel+bounces-227738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B29C91560A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B1628BFA8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE0319FA89;
	Mon, 24 Jun 2024 17:56:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDCF13B59C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251797; cv=none; b=BSlTls1F2Me4ZFjiyOGCIXqJZs1fdMVGxzYSK9cHS97g3oFXGqtCbm7UkAYuQwxvPAE2+tJxfMMNsORem3vbwbVFzqRVVMc5zP80JZ16lDDXsIyDABdi7nZyq/uTdouDnpjagXx7aqjdTLkU52pHDhreaz49ulPE6qAsxpcisOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251797; c=relaxed/simple;
	bh=/wpYBNZFJmTpYVPuTdtV3SzVXrrToCuc2Umdr/kHbBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n26e6FV7F+N+TPCMKp7sPKtfZdDPy16XngHp2b7AmnA6kZMbHrOQR8GN9KquFdE/dXukzEoyHdI0Ay7DtT+vLsvGBt92GTp/7zeq/snYtErn01XMMR3m7ibbxLyucATP3VhgSwOhN5INuVQsRvQ16dNdwProJGM1ovPwTpV8UxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE0BC2BBFC;
	Mon, 24 Jun 2024 17:56:35 +0000 (UTC)
Date: Mon, 24 Jun 2024 18:56:33 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/lib: copy_page: s/stnp/stp
Message-ID: <ZnmzUa2D_wWXAlJl@arm.com>
References: <20240613001812.2141-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613001812.2141-1-jszhang@kernel.org>

On Thu, Jun 13, 2024 at 08:18:12AM +0800, Jisheng Zhang wrote:
> stnp performs non-temporal store, give a hints to the memory system
> that caching is not useful for this data. But the scenario where
> copy_page() used may not have this implication, although I must admit
> there's such case where stnp helps performance(good). In this good
> case, we can rely on the HW write streaming mechanism in some
> implementations such as cortex-a55 to detect the case and take actions.
> 
> testing with https://github.com/apinski-cavium/copy_page_benchmark
> this patch can reduce the time by about 3% on cortex-a55 platforms.

What about other CPUs? I'm also not convinced by such microbenchmarks.
It looks like it always copies to the same page, the stp may even
benefit from some caching of the data which we wouldn't need in a real
scenario.

So, I'm not merging this unless it's backed by some solid data across
several CPU implementations.

-- 
Catalin

