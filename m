Return-Path: <linux-kernel+bounces-535953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E63A479BB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852F23A203B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4552D229B0B;
	Thu, 27 Feb 2025 10:04:43 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE74227594;
	Thu, 27 Feb 2025 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740650682; cv=none; b=PZ63Nz4jwSfTbRjqJFn4Whee9CvpYYfc/ZEi6e9mIdsWN55KK5ipNZO/0OuHOftz/2XFv0suNCoX1av8d6VZsSkhHzzx4sTxovvQY3tFuJvyHnSLBr6Gacu/+vxFAyU5iJr51v3eqAU3WT0v1FPcYrfH40NVGWZSIGsUlg/iAZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740650682; c=relaxed/simple;
	bh=OBfaFWKEcoXSbgAaGDPG0wuvgeDiYepY4HcU+XFamUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RT0cKa4J+VSBC0wpytDL2ihMHSgT0EJtc1Zrn4FKYHsKPN+9KliPQmoJ0pYAuVyTGcbzUBwAuM/qDu9rSmJzd3+Yam7dVv1FAz2k3dHqlNB0cYtnd+ZilUhmRy8PWSj5UHCFTp5+vKs+Gw0FLsxI/DZw2mqUrKBCcb4eJPYoE8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1tnakv-0007xW-00; Thu, 27 Feb 2025 11:04:37 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 20FB4C0135; Thu, 27 Feb 2025 10:45:09 +0100 (CET)
Date: Thu, 27 Feb 2025 10:45:09 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: WangYuli <wangyuli@uniontech.com>
Cc: chenlinxuan@uniontech.com, guanwentao@uniontech.com,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
	macro@orcam.me.uk, niecheng1@uniontech.com, zhanjun@uniontech.com
Subject: Re: [PATCH 2/7] MIPS: dec: Create reset.h
Message-ID: <Z8A0JeFYfBxXOFCD@alpha.franken.de>
References: <487CE8AA937621E2+20250218125101.663980-1-wangyuli@uniontech.com>
 <65F124DA37C9CC6A+20250218125633.666501-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65F124DA37C9CC6A+20250218125633.666501-1-wangyuli@uniontech.com>

On Tue, Feb 18, 2025 at 08:56:33PM +0800, WangYuli wrote:
> Declare externally used functions in reset.c to resolve compilation
> warnings.
> [...] 
> -
> -extern void dec_machine_restart(char *command);
> -extern void dec_machine_halt(void);
> -extern void dec_machine_power_off(void);
> -extern irqreturn_t dec_intr_halt(int irq, void *dev_id);
> -
>  unsigned long dec_kn_slot_base, dec_kn_slot_size;
>  
>  EXPORT_SYMBOL(dec_kn_slot_base);
> diff --git a/arch/mips/include/asm/dec/reset.h b/arch/mips/include/asm/dec/reset.h
> new file mode 100644
> index 000000000000..5e7b27561fbe
> --- /dev/null
> +++ b/arch/mips/include/asm/dec/reset.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Reset a DECstation machine.
> + *
> + * Copyright (C) 2025  WangYuli

I don't think this copyright is appropriate, you are only moving code
you haven't written.

Thomas.

> + */
> +
> +#ifndef __ASM_DEC_RESET_H
> +
> +#include <linux/interrupt.h>
> +
> +extern void __noreturn dec_machine_restart(char *command);
> +extern void __noreturn dec_machine_halt(void);
> +extern void __noreturn dec_machine_power_off(void);
> +extern irqreturn_t dec_intr_halt(int irq, void *dev_id);
> +
> +#endif /* __ASM_DEC_RESET_H */

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

