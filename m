Return-Path: <linux-kernel+bounces-274805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F4E947CF7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CF1284062
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FD713B58C;
	Mon,  5 Aug 2024 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LQNQ4S9N"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84738537FF
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722868775; cv=none; b=TVXnXxrwQFu6lcCBHUZKMD0dIBIT3m5FgHElylIwu1D8wEs7c+1mKqOpqA7lgGYtu3FLRNHYuo2YpVqJXjSKydfvUkPQBytSW/ADucERCRE1uoxxrD5vxTJJX+dS+FQsc36vU6Xtec+sFAoEITu3qXiG5mTPEfy8ngTv04DumLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722868775; c=relaxed/simple;
	bh=Cpafa1edLB4bQmDpQN6KoJz1Poo9BC+yA8OP9Q7cAZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arQTNdlsNI4aA6kFaYuAAzNeFzllV77PZ4YSpqsKCMqVq0c6rKA8eLbXY0hb9+RvXN9OVb/SLx8IMp2Q8HOqqFsnqWWRpLz60wsOUIZuYf8V+7XQPWKSA9lq+1tNY2u2tXCLNz4/Ed/ThIwYwwYpCY05hLQTHpmSeIcJeR0DA4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LQNQ4S9N; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f01e9f53e3so154159941fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 07:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722868771; x=1723473571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dQe6lY5XiKX3XB0Uf6X+xtsfutRXj97hBxe/T/20wTg=;
        b=LQNQ4S9NsiU93mhrwKgFCbF/rFGmKKn+c7XfAYLiLLshTRqSycmxhlNVS4/wVPKOvx
         U/qzP6F/MR95xW2c5Zucwkg44F5SrI0YuFOQTSnfWuWQ2jCpo21GCYOyuikOgSY+o/cM
         Ku6jJMqFeNNC0TlzULEgoO2pnVKi+z1VGBqw/Ta9zjDGfyLfiBOjFSZorj/qYLNgPu9C
         Z/Jt/ZqhS6vYV+yS33BdG8C6i0zdLfXKvsi5zNqV5/HEiYJE2yaDGR1xN1MsE7ZFsRom
         2zXU7SvqgFGNyKEMROdXgZ3Zja2KGFFlsgfIuiNpu1zJ2ve+5XZPxNkzGz6gemMg2tYb
         h7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722868771; x=1723473571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQe6lY5XiKX3XB0Uf6X+xtsfutRXj97hBxe/T/20wTg=;
        b=pkaJnADwWcSxsjj/HiMxhIYR7oQgvR//4w7KywTgM8vDGEPntr4RTjm/CzQfCCE0NC
         fpchzSzRRNm79ZpsHsmL8bFSEc0PBp1X+ekWgUbrAHO78AI5kG35X9G+JiWv6KJIQ/3y
         Or50ryfnMmG/hBP1pxtoduilrPzXStRX8XEsA2fokK8m4OI+QFr/1O6Z81iFSD889qgI
         nPjTXBDdp9/57yL7VUcY77vXWGPeasZTh7JqRvX8hjQM8yYnSLBzQdNtyKFwKAAy2w7S
         UYWcrCXp+b9xtkWVRXIxhgFUzbeWoIt6EPpyzvdOMhm3XdLT72GokD9l4uHTUDemnfdo
         QPbA==
X-Forwarded-Encrypted: i=1; AJvYcCXAVUEyvSx+GtfVuO3shAeELfWRYpeSjwj4yJfreMPp2ZWHo+e0kyozoqdMiK4L3BP+ciFFAMC2UhzsaD5m3Eu9oqPJ5U1P3dId2J+s
X-Gm-Message-State: AOJu0YxagTeyD1O8euWGONC3OOWiQ0oa6KGaNVRYOh4Aq954PriYoCAE
	lbdZn7QnAqOCR2z18mjx9j83o5kf40hxwUcQf5n4pcF7VP/Tq8q35JvXGEVo2wJmUMwnUqtQ1ZI
	d
X-Google-Smtp-Source: AGHT+IHyekXdevofEcLkU7mrqEQ8YNQ0wk22M8Q6p0yRiLMIuRd5MfOr3pvVnChmFc5WQVeFBfylTA==
X-Received: by 2002:a2e:7303:0:b0:2ef:2490:46f1 with SMTP id 38308e7fff4ca-2f15aac47c0mr107177771fa.23.1722868771381;
        Mon, 05 Aug 2024 07:39:31 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e84340sm458920566b.185.2024.08.05.07.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 07:39:31 -0700 (PDT)
Date: Mon, 5 Aug 2024 16:39:29 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v7 02/35] printk: nbcon: Consolidate alloc() and
 init()
Message-ID: <ZrDkIVayLt9d5lq-@pathway.suse.cz>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
 <20240804005138.3722656-3-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804005138.3722656-3-john.ogness@linutronix.de>

On Sun 2024-08-04 02:57:05, John Ogness wrote:
> Rather than splitting the nbcon allocation and initialization into
> two pieces, perform all initialization in nbcon_alloc(). Later,
> the initial sequence is calculated and can be explicitly set using
> nbcon_seq_force(). This removes the need for the strong rules of
> nbcon_init() that even included a BUG_ON().
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

