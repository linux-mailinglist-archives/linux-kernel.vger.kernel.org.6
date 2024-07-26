Return-Path: <linux-kernel+bounces-263030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC1F93CFFF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A2D91C20D76
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0368A176FC0;
	Fri, 26 Jul 2024 08:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dWWnsgXE"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F40628
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721984251; cv=none; b=t0bH1UgzSH5iERT43GKS43omkVBFKAoagCuh/3B3H/0WPULchRApvzhuXi9aRnQnwZLgRH7W3jYGhSuNAXn7+kvxwGRCZ6yXT6ol/jgajulZj8BN0J2gLHsz3WXLb/PCgAZ9IRAfG3qJ1nBgGG4q3d2cjN7OIYz3Mxr1xq7smjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721984251; c=relaxed/simple;
	bh=1aDJ7nZxKFbTpx0ukM2Aj7I6O1HA6CzOUyqqGi3Y0oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIyGRD1XPHRb1RPm1WhpdzzeBrQr3Pi4Hodr6SgLOMO2MdL1u9RN8JZLItGZJfwrrqgAwslx+eTOaH4m0FcgXYH+4f8akJO80Vk1DI3ECZgFUMxuqRw1NYyElQmjysJWOgr0ba1u8jBVsQFp0PT01a4ycp0c5WSBEW2hHre0e6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dWWnsgXE; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7a8a4f21aeso185977566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 01:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721984247; x=1722589047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pmt707orOoZdSC2lFcoFo6RtvOXcqY2kR62zKo/ynnA=;
        b=dWWnsgXElZatF9HlutpdfC3LKvHUNOEmY5e9iriCQGP4efeta66bPeE2zyAFNmouY5
         GY2cuEiT/eK9w0MhhH0ArrPqQ+s7MS9kjBDyY+IIC2sjZYzag1lKz2yghVmgzuM+eRbV
         dtPbma0Uuicmsrn58vQh+He4G/EW9cK0mo5K7sHxM43gEs83RkYrgRnf4VKvhjYnQyRc
         7Iv6ZlLYd18Maf/W5MTxxouC75i3BUnLxoLKEQp0YIrQpGHYywvofD8LryEoYmhqLPRY
         nBfHsYwa184/RCkEEsrkje5Ra0oBEd8fB4AlbyBRgyL121pFJwtz7/4Il2Y7EWh1tXcq
         uFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721984247; x=1722589047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmt707orOoZdSC2lFcoFo6RtvOXcqY2kR62zKo/ynnA=;
        b=vyg7ibg/2MDS3gcQCB2CGxVJscyZmiMnxVBz0DyngbJm8tG1fI8RkXk9dqWlMl5lDC
         yhd0eMaNzcVhs5JlqEOPvxOvjfcNREZEixTftK1NP6Hco2v8F+4Y8+9p1BI/OApcS5Al
         XKw1ZBYCXtUog4JXu12+uidd8As6cxHGniyDc+ofjBTDCxIVe3ZfYSD74Mlmel92SdFj
         sXmQQWQURy7SEYeF4cim54QgtC7shLU4Y6bLykgEQLAtZH2SoaoqEU5VY5LYjq8Sorg1
         2uZANAHsVjx66LTjeintWmc21F8CadCmmeYmR2HZq7kA2BpE7XE2ttgv3E3JvQwghBYR
         HLlA==
X-Forwarded-Encrypted: i=1; AJvYcCVd0tVRMfBur74JkSASVHEPP8b7cAnyvSqPAKF1i20AN6PGbcoBtYoijGsyQj+QlUfjiXvKtdMOceNrcf8LJv8mt7sm91madLyeBkT4
X-Gm-Message-State: AOJu0YyG/AdpBql6Tg9jR4nf8+Ty8qSYcikbliIkXmOjuUhLfZgjgKK+
	nnUM3FM7oxEPR2zGJiWW7yp8sbj6teYiEiKM2cE7o6lAydlrLUY/nw/ReyMBRag=
X-Google-Smtp-Source: AGHT+IGKQNTyXNpI7dG70xL9jHH0b6IGRNP8L39YxDtb9MzS4x/xVMmuJP0NcbFmcn8/PL/EU7D14Q==
X-Received: by 2002:a17:906:c156:b0:a7d:26ff:aeb0 with SMTP id a640c23a62f3a-a7d26ffcf5dmr193424066b.30.1721984247402;
        Fri, 26 Jul 2024 01:57:27 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad40cb9sm149844966b.120.2024.07.26.01.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 01:57:27 -0700 (PDT)
Date: Fri, 26 Jul 2024 10:57:25 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 01/19] printk: nbcon: Clarify
 nbcon_get_default_prio() context
Message-ID: <ZqNk9Y5lZm1Wl4Fr@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-2-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722171939.3349410-2-john.ogness@linutronix.de>

On Mon 2024-07-22 19:25:21, John Ogness wrote:
> Correct the kerneldoc and code comments that claimed migration must
> be disabled for nbcon_get_default_prio(). This is not true.
> 
> Add the explation in the kerneldoc.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/nbcon.c  | 5 ++++-
>  kernel/printk/printk.c | 2 --
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index ef6e76db0f5a..d8388faa6500 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -970,9 +970,12 @@ static __ref unsigned int *nbcon_get_cpu_emergency_nesting(void)
>   * nbcon_get_default_prio - The appropriate nbcon priority to use for nbcon
>   *				printing on the current CPU
>   *
> - * Context:	Any context which could not be migrated to another CPU.
> + * Context:	Any context.
>   * Return:	The nbcon_prio to use for acquiring an nbcon console in this
>   *		context for printing.
> + *
> + * Allowing migration enabled relies on the fact that a context cannot be
> + * migrated to panic or emergency state CPUs.

The sentence sounds really cryptic to me. I personally prefer
straightforward descriptions for dummies ;-) What about the following?

 * The function reads per-CPU variables but it is safe in any context.
 * The CPU migration is disabled in panic or emergency CPU context
 * by definition.

>   */
>  enum nbcon_prio nbcon_get_default_prio(void)
>  {

I do not resist on the comment update. Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

