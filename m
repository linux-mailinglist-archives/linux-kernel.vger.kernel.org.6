Return-Path: <linux-kernel+bounces-402292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D48779C25F1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB75F1C235AD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825291C1F10;
	Fri,  8 Nov 2024 19:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4TYQTOF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DAB1A9B52
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731095836; cv=none; b=fKxOyTEt16rbnyVF9uklS7Fr3PTw5J9Kvm7qdqtRouX++aUlH/d4aDK+Rhtwes5jCAoMbsd05NzrHhWK4PfWNH1QqyhA/aNAcgEj9NOUadcyV1WbVkawGvgPiwiuT3PvOBiswOfRAsMOBepGL6M6Z+oPWy3+9TlW0TruoxqPzDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731095836; c=relaxed/simple;
	bh=C1oBhr4X4sSzoQYsQThdqCB6TX9PXM5rv6IJXijNuec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/7q4AD4VXq7kCxSks7TL7rUizuZbTaxTGB0jJLQ4cXVr8F/Sym98lbeN/hEyV6Ob6NbUFj3aiv7xuRHwVMAJbKVIw0pjVvIILnAH1+8C/3gEFTT+b9Y4/L9UI2amG+UdnZhjvFByaeszOZHV5y8/5zuGaVNa+36b3J98sWE5P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4TYQTOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C73C4CECD;
	Fri,  8 Nov 2024 19:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731095835;
	bh=C1oBhr4X4sSzoQYsQThdqCB6TX9PXM5rv6IJXijNuec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D4TYQTOFDWsx+3PU+s6SmftGr2Fo8defaW+FD25/Eb+zCd/JPuwbpzTdoBXrF5elQ
	 HSP0cca+FW1SkVXKCl2iecyisjzhpT4/s7wq091o3b82qCoJno7sk2KzW7HXzDXkac
	 ymbEH9dX/v2L8hVHwYHgbni32T9wwQObeSvPGVwvNEBwX9XPqstoUncPEueSlFqo4h
	 Jmg1bUNRCVMYa2ojA2zmT5Za9lNfuvUYzSwiPhN0D8AbOalhVINMsU+RopqA+AFpbq
	 /qox6jlUaplRZZiRTOGzbGJx5uJWJZDYfyqHaB0hflDnxAcSt/6IrR9yYCD434lnjg
	 m6PId8hKNcZZw==
Date: Fri, 8 Nov 2024 09:57:14 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix incorrect use of bitwise AND
Message-ID: <Zy5tGk1IILMVyAzG@slm.duckdns.org>
References: <20241108195144.55747-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108195144.55747-1-arighi@nvidia.com>

On Fri, Nov 08, 2024 at 08:51:44PM +0100, Andrea Righi wrote:
> There is no reason to use a bitwise AND when checking the conditions to
> enable NUMA optimization for the built-in CPU idle selection policy, so
> use a logical AND instead.
> 
> Fixes: f6ce6b949304 ("sched_ext: Do not enable LLC/NUMA optimizations when domains overlap")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/lkml/20241108181753.GA2681424@thelio-3990X/
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.13.

Thanks.

-- 
tejun

