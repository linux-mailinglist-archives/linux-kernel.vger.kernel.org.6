Return-Path: <linux-kernel+bounces-364106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5580D99CB34
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E8E1F22743
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB68E1ADFE9;
	Mon, 14 Oct 2024 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/N1SIdC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBE51AD9F8
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911448; cv=none; b=XmEKjsWtwqsx4x2KKbGXtAHjZi7rMDBRG4AY7XMvbXhX+sn8y9kiwLxlD5+boLL/xYogU2tkCcBGrrgAJvAKOWdVIITD0O6QkEHX6uTe1vUSLaQ/ORM2eqBEph+eCVtxBKfgV5nC53CDTf0SQza5G4wWvDijeRnznebdKR/g5I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911448; c=relaxed/simple;
	bh=YlnMitl1nLOteyh8gA+2LBlWbZHa6L6A0MLvuZ7ayak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlzDtrjKbXEmDxwzRmPNLmntNwu4WnAqp7wgTCPy1SawPD+ADAIVdhtY1lKKtVRirOupG69Awex22T1hZGqrd++APnaBWFdSN9Ez0pT6LObz6whBYe6+oIZ6U0bxJs1Hk1ZVonMkEWuZylpXxpCcgOggW9/a1FoMdDawLmNwZe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/N1SIdC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECABC4CEC6;
	Mon, 14 Oct 2024 13:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728911447;
	bh=YlnMitl1nLOteyh8gA+2LBlWbZHa6L6A0MLvuZ7ayak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W/N1SIdCG1aBBJJORv5NeHppZz0CcrlCsVaqL5XsMwJANKnLFSeaDYGJ28SVevTtA
	 wmKbAXRv5Almy7vC5SHjDBZdkkuIkqCds7XUaM1ThVIAG28grmZWopCIPlyJZ1tIHn
	 98oMgDpG3uPPMlDcuMf1NPMmPgGHkBCDoBEz5ABEzvkwhXzDqndK+aeT0Bc3HmgaJ7
	 YcfkwnBl3mpkIHkOoHWgYCJnuC1CEU+Jmae/cVLN497GcfhnYmGV1j5Z8j94VckNHi
	 5jNv6/yR/V9vb2l5fIobcC2d7EhHnD7q5TKQOCnoqxvmy1N1ZJRB4rw0CJm0iHIjXD
	 OlQ5X7OZCT2NQ==
Date: Mon, 14 Oct 2024 14:10:43 +0100
From: Will Deacon <will@kernel.org>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: catalin.marinas@arm.com, broonie@kernel.org, mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Remove the check for CONFIG_TINY_RCU
Message-ID: <20241014131042.GA17353@willie-the-truck>
References: <20240914090040.166671-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914090040.166671-1-ryotkkr98@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Sep 14, 2024 at 06:00:40PM +0900, Ryo Takakura wrote:
> Since the commit 4b3dc9679cf77 ("arm64: force CONFIG_SMP=y and remove
> redundant #ifdefs"), arm64 defaults to CONFIG_SMP but TINY_RCU is cofigured
> only for !SMP systems.
> 
> Remove the check for CONFIG_TINY_RCU as it should always be false.
> 
> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
> ---
>  arch/arm64/kernel/entry-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index b77a15955f28..a9765364fc67 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -40,7 +40,7 @@ static __always_inline void __enter_from_kernel_mode(struct pt_regs *regs)
>  {
>  	regs->exit_rcu = false;
>  
> -	if (!IS_ENABLED(CONFIG_TINY_RCU) && is_idle_task(current)) {
> +	if (is_idle_task(current)) {
>  		lockdep_hardirqs_off(CALLER_ADDR0);
>  		ct_irq_enter();
>  		trace_hardirqs_off_finish();

I think this code was deliberately written to follow kernel/entry/common.c
as closely as possible, as we should be able to switch over to that at
some point.

Come to think of it, Mark, what work is needed before we can move to the
generic code? Is there anything you need a hand with?

Will

