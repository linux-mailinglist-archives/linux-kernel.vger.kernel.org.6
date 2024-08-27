Return-Path: <linux-kernel+bounces-303294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AFB960A4F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E24DB249E8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A86B1B9B44;
	Tue, 27 Aug 2024 12:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANXjkYD6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AEA1B86FF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761850; cv=none; b=I4/kx3PaXOzh/j26l/sAbP5lV0KZxLVN8knBNVnk7jxzybDbBH6CXlSWeWtq1gcG827KmDxCm2vhjespexlHWQKwcByLe8R71W3SAGR4ANEMIeejqOUiRHXDbgvAfKOoB6B+L91n/7jb61It/gZcGlRqhRPUjKMvUwOvLR9leS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761850; c=relaxed/simple;
	bh=2yh5vhfyIPxRTXHV/fSp3x4mj2cm7R/8NBWmhYVPJxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7TXoy+rLsy/AV5FlbAlvBzaqRydWi3QjKX2xZfp3O84s0NElHcTVISDddRCaX0W5LZ7UXMexDY1+cJNfUTmzPczteg7vR8RVVaoJjmpbn/IyGDcfDxtOdi2dMNwOl7uBNiEB1mdLK67u5msDEgtkGC0MyRpTqHpzaspl+hChlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANXjkYD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18C8C61049;
	Tue, 27 Aug 2024 12:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724761850;
	bh=2yh5vhfyIPxRTXHV/fSp3x4mj2cm7R/8NBWmhYVPJxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ANXjkYD6sl/zwNvyJmC5vDlEEtooIlOCYwgX4sTPWJdnGSq0qflSHn/L4cbRw9C6h
	 1btyDC+OLpGku/rxjiNMFXub4q+vMhx5vI2HCVWcRQv7RqwbGGBIsUeFHmlG3yeXDa
	 SIQY100CNvuFSuE8pdaOCigGQVmr+l928qWmZkHe1BgQo+JIyacHuAlwexK5Wq9J/3
	 bVBSmYVC/AfPGDpGDaQ0DXuMPOM24rDE/aekE0QvMPjzgDN3Y2TrZ+8hPXNbq0QxZm
	 HXtHZVJCaZrDi0j7wNtLOxsuEMup5FVN+x/8BWG/kUHaCcIMMKqAX/xHiI+T6rG/ht
	 OSCShdb9EtZUw==
Date: Tue, 27 Aug 2024 13:30:45 +0100
From: Will Deacon <will@kernel.org>
To: Liao Chang <liaochang1@huawei.com>
Cc: catalin.marinas@arm.com, ptosi@google.com, oliver.upton@linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Return early when break handler is found on
 linked-list
Message-ID: <20240827123044.GB4679@willie-the-truck>
References: <20240827110046.3209679-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827110046.3209679-1-liaochang1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Aug 27, 2024 at 11:00:46AM +0000, Liao Chang wrote:
> The search for breakpoint handlers iterate through the entire
> linked list. Given that all registered hook has a valid fn field, and no
> registered hooks share the same mask and imm. This commit optimize the
> efficiency slightly by returning early as a matching handler is found.
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  arch/arm64/kernel/debug-monitors.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> index 024a7b245056..fc998956f44c 100644
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -281,6 +281,7 @@ static LIST_HEAD(kernel_break_hook);
>  
>  void register_user_break_hook(struct break_hook *hook)
>  {
> +	WARN_ON(!hook->fn);
>  	register_debug_hook(&hook->node, &user_break_hook);
>  }
>  
> @@ -291,6 +292,7 @@ void unregister_user_break_hook(struct break_hook *hook)
>  
>  void register_kernel_break_hook(struct break_hook *hook)
>  {
> +	WARN_ON(!hook->fn);
>  	register_debug_hook(&hook->node, &kernel_break_hook);
>  }

I don't think we need these WARN_ON()s. This API is pretty limited and
passing a NULL callback doesn't make sense.

Rest of the patch looks fine.

Will

