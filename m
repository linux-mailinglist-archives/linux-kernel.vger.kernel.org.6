Return-Path: <linux-kernel+bounces-263296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F6F93D3EF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50A51C234BC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D22517C208;
	Fri, 26 Jul 2024 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Zhgglsbh"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B7217BB07
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999678; cv=none; b=f7/JmKuuK8Fy30eA9m5/rR/eg9j868zwQ+jqoqhisMOL/iq+Z8ttVwqjGU15iPMZFX2iDecUrJ9ePYUF0XZPs54U+fxTeHRWsFxsqdb6LEzHJWz22Ooi8WwNZBGGvs0KuZbsrY82IzT7D8nhu+bw3dNL5As25pR3M7lpmrcRy1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999678; c=relaxed/simple;
	bh=jFUBWT8bmUMUEw4SMTOCHaB2UOM2Bhfpec937r0gWVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWg/889vVsLxsqEcclz0RDRUTUdzqj8A/OttfK6AjRNEccv/sUCefF7y5vJH2lN0sVSgmN9lisIHDva4x2+fMlf7dEl5jbddMTt8uk/NlXrJU5yD2ITXdyr8ZXlhfzuphXGOgwbP4BTuHuI1yj2yIin+hgemNPyi0ffR5pCtyE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Zhgglsbh; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52efbb55d24so1985436e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 06:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721999675; x=1722604475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cxzpoMfIrx25pag8YNkwLij9eJ33ZK05RxfZtFpb8e8=;
        b=ZhgglsbhnpVIuRIfQfGESM/jFz/paVPx0WZthaF62Hq9jqxlx+qxrQo5jIhrsLITru
         OEcjlPhjs9IAxlYzesuaEDxOTc7edGiajOwiDn/RDqj4sQouBvSsom20ywRUqk6Wt05f
         5p+2dtefktAJ3v64NmQ2Ji+dGfhbqmQZH9FX8fTfLW7xyR59uPQ7Z2x4IVTvHga/d64x
         iq6Hmc0j3A6G6HIOHrbahh4vpj0WxzrLZsqMqqhGnVJ5yr8PeCmyK3p9Bd41CRVx9e0o
         gudqK//5QsLCKp7lfMdSy2Qvr3wCT2JCkM4OimXi5IeJhz5iGfsfL/VRBXrOoq2DuJdw
         gVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721999675; x=1722604475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxzpoMfIrx25pag8YNkwLij9eJ33ZK05RxfZtFpb8e8=;
        b=CeSBL9J5i5a/BL9bBsqXsD+boAb9PDsSoUXG6ZotCjv+RC3kT0yfZN9cueQ/NQdtEl
         K4b+hMFREvEp+7JCV0LzyzVMOEyv1FvMPRzbmTnH9tYNxdOYqDGZWG4hLrC7ceENbIIr
         ywE78q/7JgqOEkj4TSrwp2TBAJJgDaJzGZUyqwy7O9AfdSXzpb8V8PIBUkXpZbhVsR7s
         Sg7ir+1qlAAIkbojDU8WJH6JTa3gPMhFNNx7ftsLi1SzixC8WnGqbVanPEwd5H62/2ou
         s1oQ7TctpNBlcbpOiVdV4V73MqbN4pJp6JDVK9G8xMCwIXrOErA0T0ZY/amcKlbWCqMT
         Wmew==
X-Forwarded-Encrypted: i=1; AJvYcCVPcbfdz32l2zLuX+oBk5fAyRvcHyTq2DdtHGL+lbsWKH+RpQrl7+jLwVzGXUS0f/i9DwDP5Nhy24aQVLN9cMwhhQhIk2HxwXRzwy93
X-Gm-Message-State: AOJu0Yx9AQ/HdRRJjpmNVXRiSj60nqwoAnkBkRJUR1vLfWXfu6tZDeUQ
	fic97dAPSWr4CSRkqGvPawpLfsm111GklcPY4vi1421Dwr4zIAEIZ4LveHIhViE=
X-Google-Smtp-Source: AGHT+IGCJcbvyT/hBO6y4tNf+O3+FuxwKCSsOQsn9w8BwCsbmFOdoLVmkMfn2lDgIxWA+NvJtYQRZQ==
X-Received: by 2002:ac2:5393:0:b0:52e:a03f:ef53 with SMTP id 2adb3069b0e04-52fd6035f1dmr3897832e87.24.1721999674614;
        Fri, 26 Jul 2024 06:14:34 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad9f0d4sm173900066b.185.2024.07.26.06.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 06:14:33 -0700 (PDT)
Date: Fri, 26 Jul 2024 15:14:31 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 05/19] printk: Fail pr_flush() if before
 SYSTEM_SCHEDULING
Message-ID: <ZqOhNwkJKBSU848O@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-6-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722171939.3349410-6-john.ogness@linutronix.de>

On Mon 2024-07-22 19:25:25, John Ogness wrote:
> A follow-up change adds pr_flush() to console unregistration.
> However, with boot consoles unregistration can happen very
> early if there are also regular consoles registering as well.
> In this case the pr_flush() is not important because the
> regular console manually flushes the boot consoles before
> unregistering them.

It is not much clear what the "manual flush" means. Is it
the console_flush_all() in get_init_console_seq()?

I would write something like:

<proposal>
In this case the pr_flush() is not important because all consoles
are flushed when checking the initial console sequence number.
</proposal>

> Allow pr_flush() to fail if @system_state has not yet reached
> SYSTEM_SCHEDULING. This avoids might_sleep() and msleep()
> explosions that would otherwise occur.

What do you mean with the explosion, please?
Does it add some warnings into the log?
Does it cause extra delays?

> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 641c2a8b0a09..39db56a32c5e 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3946,6 +3946,10 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
>  	u64 diff;
>  	u64 seq;
>  
> +	/* Sorry, pr_flush() will not work this early. */
> +	if (system_state < SYSTEM_SCHEDULING)
> +		return false;
> +
>  	might_sleep();
>  
>  	seq = prb_next_reserve_seq(prb);

The change seems acceptable. I just do not completely understand the
motivation.

Best Regards,
Petr

