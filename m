Return-Path: <linux-kernel+bounces-438159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F45B9E9DA1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A813E1632AE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55DD1ACED0;
	Mon,  9 Dec 2024 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhtJN7R2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2016113F43B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766999; cv=none; b=O3ZEYe0c/+4ie9Uau0on8t3b+cFNdVim1vZPSL9XO/pTLhTEEyly+bB6izmEJ3fzwy802VpoRNmxp3DfmzC7/4r1tSDNGtup9MSlNDA4bVuhQphjBy/byWFGhyziVN7D3zMULSgkFuSlvnIsGhxcVEc17pQP5NPBrCe6MvFIWBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766999; c=relaxed/simple;
	bh=X9gMNmE0IOIkjEHG7kKIQF3PqGtvIv+QeqCxkaR2ID8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1GB2Gpey+cnyAe5O2yL0lt0YQQE1n0UR/ABdMOCCu/ntwtVMXGg39KBDlFYITeehbPSnY+De4jVmZ15lFTfSaINTO23FR2DfjZs2oGtYzVct7y9P+DuDBcUQqEZo62voElLWhgXg5v9Hl/zhCxPJnZzL+4vbdEOl1dhkvOwmXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhtJN7R2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93E0C4CED1;
	Mon,  9 Dec 2024 17:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733766998;
	bh=X9gMNmE0IOIkjEHG7kKIQF3PqGtvIv+QeqCxkaR2ID8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=BhtJN7R22W9dmel1V1N440dElIbBLX+vDfcdd/xrbxr5dX3mpcbHB1vc8yjsrGzNd
	 esPgw8PmyqhQ8Ey0S4bHXqoOV7nvEDuFFSp/tpu1TIBrLgBrjjYEC8L5HVu71rvwEc
	 6rCBLO3E2C3H6YvOEbrGqMhVCXM0lRYr+FErtWjHFrKit582HTVuUIxZhC/YNM50g8
	 HOyYUU876N5Eb1LXAVcul2+IzhRrG6Q1Jzjr32qHB/zQPaakdsD2RPNYjAVQ326Gbb
	 5U3fIDzOPDxo10uvB/Xo4abk+Ii6pCEBajaDrpNmVsgZGzCcHj4ElIkjJSUg/bM2CY
	 YO2jop84Zztbg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4110FCE0BC5; Mon,  9 Dec 2024 09:56:38 -0800 (PST)
Date: Mon, 9 Dec 2024 09:56:38 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] locking/csd-lock: make CSD lock debug tunables writable
  in /sys
Message-ID: <5b53408d-80a1-4f33-9a15-12c80f736b76@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241209124411.5b588faa@fangorn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209124411.5b588faa@fangorn>

On Mon, Dec 09, 2024 at 12:44:11PM -0500, Rik van Riel wrote:
> Currently the CSD lock tunables can only be set at boot time in the
> kernel commandline, but the way these variables are used means there
> is really no reason not to tune them at runtime through /sys.
> 
> Make the CSD lock debug tunables tunable through /sys.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>

Good point, and queued for v6.14 merge window.

Unless someone else would prefer to carry it, in which case:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/smp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 27dc31a146a3..a33e575f97ab 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -170,9 +170,9 @@ static DEFINE_PER_CPU(smp_call_func_t, cur_csd_func);
>  static DEFINE_PER_CPU(void *, cur_csd_info);
>  
>  static ulong csd_lock_timeout = 5000;  /* CSD lock timeout in milliseconds. */
> -module_param(csd_lock_timeout, ulong, 0444);
> +module_param(csd_lock_timeout, ulong, 0644);
>  static int panic_on_ipistall;  /* CSD panic timeout in milliseconds, 300000 for five minutes. */
> -module_param(panic_on_ipistall, int, 0444);
> +module_param(panic_on_ipistall, int, 0644);
>  
>  static atomic_t csd_bug_count = ATOMIC_INIT(0);
>  
> -- 
> 2.47.0
> 

