Return-Path: <linux-kernel+bounces-259077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C08719390ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416F21F21C9F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF6E16D9D7;
	Mon, 22 Jul 2024 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XOYweopR"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3914DC8C7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721659639; cv=none; b=cHGbe0tG6GaBSIsl5vUvRf9iK2hAHXOj26qS7WaIpmbaHsFQgAtIbn+376GxL9bATGU/P5qOt6YMks0tHzCzDrg1ihXAcB0TRNspTqGIAskX76AdQRXB1JRaq6V9T4wgx6auZbwvzH03hS/+/yDzA2zK4A/gK++Dxi2dsoyAekk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721659639; c=relaxed/simple;
	bh=OUMNNCR39NfCOHTmzz2B3xu9QZ2bD3hDkBbPR+hwUSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExxZgqxK8rQ6wuxtb+D5CqQvLY+sJowsHimgjHQCCJXzCS1BSuMnVrttUFCnlkpwVsrry3xkdeDAqPk2qdrFHx3xaRW5pj6LMqCMgc8XNqC3LLxkTRGD1Z6W9c92qnt/fA+5MfJvMR5uCI5co6e8FRvzYWmQfrutgOBoBp05Iq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XOYweopR; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a843bef98so31686466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721659635; x=1722264435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gfDTHBCuRohEK0ncm3xzBbUnv8j4LdhEVL2pu4g/bkQ=;
        b=XOYweopRECfWN7exCnq9GDUKjut7L6w/6TJBx46y9VJcz3XYr8xExd1NBxef8jV5IG
         2jx3JzdDrse3fDitWCcZSb3XSI7fiZhQ/8vOdjy37H8rVQ3gwnRDL0L2CARxvOrKGSs7
         9OpTzTTi9a0aSq4f1oKFerV637WHYI68UzkSBaOB4lXlQMmI6jJUB5UWB9dnHb+j/7N/
         aEIF0Zb5pXbcqc/AHC8QFFfd2C60YCMPr8SBabpgZRFoChQLJa5bkxql9H4uWuLDmkXP
         U6tyF1iqlNS+nzAJeLpIyE/kuJx/9EdcFGVN2X4e4werBwubqIQPEzdOhozNXsmlrMYd
         ROoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721659635; x=1722264435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfDTHBCuRohEK0ncm3xzBbUnv8j4LdhEVL2pu4g/bkQ=;
        b=qi3Q7sRnz9DeAypRf2+eiyPv1EFVUJgcRXvdyLahPHox8TM3bJ/jMpWwsyjk1xE/Fo
         JRlddEMXiCUOOfdqsuV0UZMMoD/C+FvPbrGw/Cx8KH9e9FWMdbEt8wvNcLu5SE4+eSQE
         9G/Ril3qitBtfg6oKn4uEQ6vbrAYxq/iUwZwdaeY5Ex5C+csYdpxsT8joeP/8bG+FxQY
         PAjjqLkITl3+hEShOZgBtgOxo4nxbBScby+UjoXhOiJZeaOkNFtPmUgJDWyTSrDPWE0J
         C1OirD8rDOnr3MpDDev0SEsKmMF4MdZNSvTWatkxi5m9NDzfMBt/rYiuic43T3VmYpHH
         JQ4g==
X-Forwarded-Encrypted: i=1; AJvYcCVGAj9qey021LR110b/CbyiTD/NFzOnqT9AjgCzTpEehWgthdsXnuYZ+d8aB1xG3Mi0hu0iPgnqLDgxAZkml9LEl7MSsThNif5issJ2
X-Gm-Message-State: AOJu0YwEXbHY2SMiGYm2jBZRk1I/e/CL983PhMnbXkOielq/7TvkHNBW
	VZ13lbcRTkNorlj9pGKLhJ9j2lnj7Vp3EJsWkQEjckwZtJalMgzKg0GMpfThLg4=
X-Google-Smtp-Source: AGHT+IE/V1ysK9/7OluPGIkN0XxqlvLcHiyifibp3AqEmHQQVIDrvMt+Q9jhUgW5HQKnT40KciPX5w==
X-Received: by 2002:a17:907:7209:b0:a75:3627:fccc with SMTP id a640c23a62f3a-a7a4c446614mr523305966b.51.1721659635495;
        Mon, 22 Jul 2024 07:47:15 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c922cb5sm431561366b.162.2024.07.22.07.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 07:47:15 -0700 (PDT)
Date: Mon, 22 Jul 2024 16:47:13 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH printk 0/1] alternate fix for nbcon_cpu_emergency_flush()
Message-ID: <Zp5w8Z0DHJ8v9ORh@pathway.suse.cz>
References: <20240719134818.3311665-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719134818.3311665-1-john.ogness@linutronix.de>

On Fri 2024-07-19 15:54:17, John Ogness wrote:
> Hi Petr,
> 
> Currently in linux-next we have commit b955f0eead54 ("printk: nbcon:
> Fix nbcon_cpu_emergency_flush() when preemptible"). But as you
> pointed out [0], there is no need to disable preemption at all if
> we only need to know if the current CPU is in emergency state.
> 
> Here is an alternative patch that correctly addresses the issue by
> avoiding the migration checks.
> 
> Since the previous patch is not yet mainline, perhaps you want to
> use this one instead in order to avoid a revert. Up to you.

Makes sense. I have replaced the commit b955f0eead54 ("printk: nbcon:
Fix nbcon_cpu_emergency_flush() when preemptible") with this new patch
in printk/linux.git, branch rework/write-atomic.

> [0] https://lore.kernel.org/lkml/Zn7b8g1HtuTIAwyi@pathway.suse.cz
> 
> John Ogness (1):
>   printk: nbcon: do not require migration disabled for
>     nbcon_get_cpu_emergency_nesting()
> 
>  kernel/printk/nbcon.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Best Regards,
Petr

