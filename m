Return-Path: <linux-kernel+bounces-404812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9119C48DC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 23:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F5D2B30349
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9741BBBEA;
	Mon, 11 Nov 2024 21:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7DI2uWT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A908838F83;
	Mon, 11 Nov 2024 21:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731361943; cv=none; b=KpicagwdJe93AblWdyU9odhAK5zwaTYrTw8lWv1gH0YvsTT7v+aaYLk/D4ZCMUcuf2YvAI+GbXKZ1JWYHsm4uLuZYZDnsS4BD6TsXgI6eYrlRAoUarLAemfQjsR15kuxKkA3A15MUYJZF6imFxNQ693eSkEJ1siTKEBJlnxqTvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731361943; c=relaxed/simple;
	bh=4gGY0BakKCULl1EI2o6BesQyxfC5cfKegCtI7RsK0Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2c/okH91noZ77Voc3GfJphHAuZBuDK7Uip2bbMdlIpeAC3FtHwc3lxMRqcHAWdKxJQygijSzekApZdc+l8pf/eyFg2z/uyxt+SfjUX7YhSvvLDaEMGlHD2K21m1s5G5J9Tuu6+FzksGEqISe+AT8QC2O93TaJHC08VAPu9zB6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7DI2uWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1604C4CECF;
	Mon, 11 Nov 2024 21:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731361943;
	bh=4gGY0BakKCULl1EI2o6BesQyxfC5cfKegCtI7RsK0Xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s7DI2uWTRzBMis8GWa0zWTWnE0IX4lkODgsn+ZUirM+/6DIJHVSlfaxw/u5LCNXdX
	 yjvtnWzP7pdNBs8E3jy8G7k+ayEd5JI+xOaZ5VcRMsn6uehLPkQ+qRyxVSmVaTtCVj
	 l/umt6fk+5tiOtqSE4Vqq4xMgZ/gDqTEVg1HyiY4sPyfNUMyNv2KbCc7rgZKPSkPsm
	 Li27Q/BLdcO68ZlqBUzcdAiUttWxP66HjIC4/TwkXtHeRTB2pBRQ758ZWVLBC9ug7Q
	 GGlnyYH0T5lItmc/57NEm3n8DUbkuwKvyFVyPlO49jbhjFZtfxN2YXjXM1xXrjNOfZ
	 UrUBXGaVJre9g==
Date: Mon, 11 Nov 2024 15:52:20 -0600
From: Rob Herring <robh@kernel.org>
To: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	ycliang@andestech.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	peterlin@andestech.com, samuel.holland@sifive.com,
	conor.dooley@microchip.com, alexghiti@rivosinc.com,
	ruanjinjie@huawei.com, takakura@valinux.co.jp, conor+dt@kernel.org,
	jassisinghbrar@gmail.com, krzk+dt@kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/4] riscv: export __cpuid_to_hartid_map
Message-ID: <20241111215220.GA1993016-robh@kernel.org>
References: <20241105183513.1358736-1-valentina.fernandezalanis@microchip.com>
 <20241105183513.1358736-3-valentina.fernandezalanis@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105183513.1358736-3-valentina.fernandezalanis@microchip.com>

On Tue, Nov 05, 2024 at 06:35:11PM +0000, Valentina Fernandez wrote:
> EXPORT_SYMBOL_GPL() is missing for __cpuid_to_hartid_map array.
> Export this symbol to allow drivers compiled as modules to use
> cpuid_to_hartid_map().
> 
> Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
> ---
>  arch/riscv/kernel/smp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index c180a647a30e..d58b5e751286 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -43,6 +43,7 @@ enum ipi_message_type {
>  unsigned long __cpuid_to_hartid_map[NR_CPUS] __ro_after_init = {
>  	[0 ... NR_CPUS-1] = INVALID_HARTID
>  };
> +EXPORT_SYMBOL_GPL(__cpuid_to_hartid_map);

Why can't riscv implement cpu_logical_map() like other arches?

We really should have a common implementation too, but that's probably 
too much to ask I guess.

Rob


