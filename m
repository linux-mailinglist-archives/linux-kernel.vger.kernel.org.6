Return-Path: <linux-kernel+bounces-294432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A884A958D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529571F21B3B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D6B1BD51E;
	Tue, 20 Aug 2024 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVoye0ne"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8452F18FC9E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724176199; cv=none; b=fYqPt+xddV2KUiIwkndmP1HaIUC7gU8y+G6s7O1/2LabVQay/qABupfp+znOeAMrq3KfRbWpC+r1D4W85M/W0MT+2fXAGJWx7RlROZb8C/Q6rHsyZrezdPRs+FvxbUD4EIthZktsWvscj69b7k2kAnGKujVbEkcihRRjdfTyJfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724176199; c=relaxed/simple;
	bh=u6AL68vRmnB3lVM2SMyw0TcWNwHRhbPqnsc8Voffc60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/FwVUeZPwuWQl7/C45jG/cfR1ltsCENpcBI+r5/gpMQe14CEOMHDDvrTlOnKzWl0k42xlZWqoLoBQ/yfarEaDPZ+iq3EdienGAphWFUifD17OtqoQkBoMMvIUNqYsDanef0BOyE/Ls5E9TZIChqdH+ZOuWgzlt51T+p0IPB6Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVoye0ne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AEAC4AF0B;
	Tue, 20 Aug 2024 17:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724176197;
	bh=u6AL68vRmnB3lVM2SMyw0TcWNwHRhbPqnsc8Voffc60=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=MVoye0ne1OYhloo9+P9jUhJrRXNt87FeRkpqSN4Z0QVfcgepoMuWCjfQLKopDe5Nu
	 W2p/DGvEbUJJm0i9T3YE5sVS3DspH0vgydOF4OVGFWBZ5X5puVAHyBYJ0S84SE/M99
	 oJrNwabQN4wo9RIjHlc4fn9W11Cc3H2dasV/AVngxyESlOzEQkd3g6N3aYHbuYrBNk
	 sdMTvFwH7Qeaw00WpgblXFIes06d/7o58/8b758JJwOn+dmhE/PbcTEV+9EA6r3P1i
	 GWzc2fklfroHin3sQulOFUh3wkAonQ3nheQxuCz+25B4eGm7drWHVpHhfQnlZh1ZPb
	 RmsIiX7o0yL8A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8A48ACE0D72; Tue, 20 Aug 2024 10:49:56 -0700 (PDT)
Date: Tue, 20 Aug 2024 10:49:56 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH printk v8 01/35] printk: Add notation to console_srcu
 locking
Message-ID: <3cd14138-0ae5-4837-9218-5c5b5708fe49@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240820063001.36405-1-john.ogness@linutronix.de>
 <20240820063001.36405-2-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820063001.36405-2-john.ogness@linutronix.de>

On Tue, Aug 20, 2024 at 08:35:27AM +0206, John Ogness wrote:
> kernel/printk/printk.c:284:5: sparse: sparse: context imbalance in
> 'console_srcu_read_lock' - wrong count at exit
> include/linux/srcu.h:301:9: sparse: sparse: context imbalance in
> 'console_srcu_read_unlock' - unexpected unlock
> 
> Fixes: 6c4afa79147e ("printk: Prepare for SRCU console list protection")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/printk/printk.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index c22b07049c38..93c67eb7ca9e 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -282,6 +282,7 @@ EXPORT_SYMBOL(console_list_unlock);
>   * Return: A cookie to pass to console_srcu_read_unlock().
>   */
>  int console_srcu_read_lock(void)
> +	__acquires(&console_srcu)
>  {
>  	return srcu_read_lock_nmisafe(&console_srcu);
>  }
> @@ -295,6 +296,7 @@ EXPORT_SYMBOL(console_srcu_read_lock);
>   * Counterpart to console_srcu_read_lock()
>   */
>  void console_srcu_read_unlock(int cookie)
> +	__releases(&console_srcu)
>  {
>  	srcu_read_unlock_nmisafe(&console_srcu, cookie);
>  }
> -- 
> 2.39.2
> 

