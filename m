Return-Path: <linux-kernel+bounces-191019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D608D059D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9784A1C2144C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E52515FD07;
	Mon, 27 May 2024 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OCyUgVho"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A6B15FCF5
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716821701; cv=none; b=QaF2UG59HYQcPWq8eV0PmdZpg0/z++b7ZxHgYjK+ukwZxAZDoeecY2SdmywB4RIezqyak5jQScLPrbcXmbk2P3ZpBwFrpGD2Elq1fIz3Lu+gB+dKliCDGi6HnuAiukBfga6mvwSGNG02lJxR0lhxCfq09mMmnWV0Hzm/If/+8fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716821701; c=relaxed/simple;
	bh=rxNoykyrgmE+ykXiTgwE+amgfPWMp+eHsqYoLpCLE2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pr30wktYCGmkXQmROAb6rkULv7ycCrywth1d9HX8R6t2/UJBoP8U/r8uiGxdTHQKCiv5EblCJBL5PsPSgTQIVLNJj19/LcHxAuhe/cQpc1x7CyNtqG5z9s7tTyAGbyhLPQUdpc79jH6mk8W2QRkQ8MbV3QB9IUaLCrJi21B1MkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OCyUgVho; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6267639e86so384098866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716821698; x=1717426498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fovS7e3KM/LcT9QtzEodGZIjj0DUcgpQyzljDo7RuCQ=;
        b=OCyUgVho1XA6FAXmFcs+wNtRcOLtVUWucKghPk15LR2p4EYdFsN6noulKndjQcROiV
         Msc27HA++C6pCDVCroszTI/XZ1pZoPjgapgCcpcVCAFRiYrinsDCrEoqdBZQJ8rLF8RQ
         LeOT7PmW2m1QD48nS3lvScyTEj1RKQCu2SdqEFKgbBoHBxX41KfTgevyJ7RQxE91GYyV
         uLRpaq1y06iTXhl/cUlgW9JcXVd4SDBBacqwM57VWpzGpIh6Lm0TziB8Adkzl0QWHGkF
         ypPijbd/yNKoaHRFBTCjiWWRKEWDRug8RUU9GDYU1Nw94xLqp/KC3AFUPqAkv52Mfzhm
         DrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716821698; x=1717426498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fovS7e3KM/LcT9QtzEodGZIjj0DUcgpQyzljDo7RuCQ=;
        b=mnlbiFJgWOQZWFLLqB8UNgaQYAytp+rAGIvw9pe7jlSMv45aKh07rs4u6bpYyXIf3m
         gASUfNpDR2FMlVIlTO782+NLE+NZP34D3Q+U4h+dA92jPLb4K6cOrWZ4fZi5loRSAsys
         c9Nv7d6afzoU+SaKLBJIWzHp/ZAm5doZ89vxvLteEGq8J0NbYsSRwfoRTDRoDoCz4h8v
         ex17ZlYEYCdBxF0zMQx7lh+B2FnsNN9r0UF4TebqHKg3VQNigMGcSZhMgRnaRYqTcjko
         isFA/x2tqXvLPvUlPWLS4W8hMxAa1/r34r33PQ4Nvae7jkroD1kg9JIWkm1HlUrXVSlY
         Wj6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2AeKhEcR0Z9wXzS52iJkrbRbJQOPKDnThN/jvl5jEaDW1mcLvZlllybEhW+e3YT7is9iO8Y74qkAOrTTJFjKdwQs9DWHtmvtpMuir
X-Gm-Message-State: AOJu0YwVJ6eqAUJ5NqRLxgmkeiIE/DeHlNfs/vtwfEbgTRSOv27LnMHK
	Q4wSapMTE6HvezqWBQeSTMfVig7nIHPhEJlDdBT+2HxB+iVqtyHQu0G7m3/3cSk=
X-Google-Smtp-Source: AGHT+IGo3H94dZVgD3Oj0JZFgaCwoWp8yWWSpLeBEfysv4WM0NLTjl+TNS8hNQyVGKq/HRHAP/vAhg==
X-Received: by 2002:a17:906:7c98:b0:a59:beb2:62cc with SMTP id a640c23a62f3a-a62651469a3mr631672666b.61.1716821698131;
        Mon, 27 May 2024 07:54:58 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c934fd8sm496587566b.47.2024.05.27.07.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:54:57 -0700 (PDT)
Date: Mon, 27 May 2024 16:54:56 +0200
From: Petr Mladek <pmladek@suse.com>
To: Xiang Gao <gxxa03070307@gmail.com>
Cc: rostedt@goodmis.org, john.ogness@linutronix.de,
	senozhatsky@chromium.org, linux-kernel@vger.kernel.org,
	fengqi@xiaomi.com, xiaoa <gaoxiang19870307@163.com>
Subject: Re: [PATCH] printk: Increase PRINTK_PREFIX_MAX and the buf size in
 print_caller.
Message-ID: <ZlSewPTyQ-jMpW5n@pathway.suse.cz>
References: <20240527091929.316471-1-gxxa03070307@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527091929.316471-1-gxxa03070307@gmail.com>

On Mon 2024-05-27 17:19:29, Xiang Gao wrote:
> Sometimes we need to add our own hooks to carry more caller information
> to improve debug efficiency, but currently the buf in print caller is
> too small.

> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -23,7 +23,7 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
>  #ifdef CONFIG_PRINTK
>  
>  #ifdef CONFIG_PRINTK_CALLER
> -#define PRINTK_PREFIX_MAX	48
> +#define PRINTK_PREFIX_MAX	64
>  #else
>  #define PRINTK_PREFIX_MAX	32
>  #endif
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 420fd310129d..2d7f003113f7 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1331,7 +1331,7 @@ static size_t print_time(u64 ts, char *buf)
>  #ifdef CONFIG_PRINTK_CALLER
>  static size_t print_caller(u32 id, char *buf)
>  {
> -	char caller[12];
> +	char caller[32];

Could you provide more details, please?
How exactly do you add your own hooks?

If you need to modify the code to add the extra info, you could also
modify the buffer size.

The buffer is big enough for the info printed by the upstream code.
I do understand why we should do this change upstream.

>  	snprintf(caller, sizeof(caller), "%c%u",
>  		 id & 0x80000000 ? 'C' : 'T', id & ~0x80000000);


Best Regards,
Petr

