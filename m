Return-Path: <linux-kernel+bounces-400223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D6B9C0A93
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A77B1F23BA3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892E2216A2B;
	Thu,  7 Nov 2024 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LUTFAnTN"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E593B215C7D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995063; cv=none; b=HP1twVKuS82Ro6LMSJG6GkrCAzEl4VdDzAv5l0E1H68IoeAgq8okJkJGOuXrnfNWS7DEAAKFlI6kz/iAIa9g0rJXWhiJFS7vytdTV+nHvQmKpVvodaC+U6HH4fdAIYLa4GB2iggCqzRr41dCx4HXmRRiPP0lN7va2aqnq/Sf9UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995063; c=relaxed/simple;
	bh=l+DObQasvi/6Xq2khmhmb4dZWgP734wHYsM7eTH33dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1+fUQYud4ILCj/5ciWxmdKbeWpLE4+yHihsoqV5zT1/WlMLfCp2JboWIXmB8Hlm6KVhY5D5ZJahnzb1awode3UgOFDFVy/PpjDnaq16AUhE4UMdMI9NyMkrlADPBkU6jxth9dhxtFm598pzaJ3hdtw7cfdZAlh5ekDaw+pIcnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LUTFAnTN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3807dd08cfcso1006940f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 07:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730995060; x=1731599860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dYaS5I93b6CHSzPlC1ZkED66zJbctl9+EXrmhFffef4=;
        b=LUTFAnTN7nR3i16CP4F+/6UCkiBJc84BPHmTVIUkMwU1gmpv2/0SgJkHP303FYjO3Z
         xwquHTEs6evXEaG4KD7M8yhT8awRsJyQn21v2BYJ8qlE9JvGwSS2eLyCF9irC4dY/uWx
         vUcYpEKYLBx545iIBdogPnV+mPEPr6mNfqBOl/cMLFlRDLkYJobCRQ7jE7rQqcP8YeAy
         6Yi3sppXqJshgVpTyNm89fBYV4PieyQTyF4thOi5tXS11inqngD/FpKXVyWx0ZmMMSZG
         icIsINxoZmYEjZTdgiyAkmlq4vzW8G9PwUpMI+aB3yMEX3CNszA1ekwhMMFoYfBabFm+
         N+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730995060; x=1731599860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYaS5I93b6CHSzPlC1ZkED66zJbctl9+EXrmhFffef4=;
        b=hLvoeWcpcMRl5Cn1YTvAY/azRlowjHFMerQXJqvAR2IK7+e7ShHNk/cxWBGJ3xbJIa
         jXoGGvC7UyiJ2kvpmTOPK5Hke+AweQ1xXZm/oXgpstv7fo3r8EOC+/T7UzmdccP1G5XF
         9ombI+EXNbDRxBDYbZMLCf1IkJwLKpFz9dtPUa3p00d5jKZoZ931I6eT0hbvwdVzoHhN
         lkFFwpeI1SX2yC0H2bkBjW+MVGjjfFXqDIHEcAGcKwTv0G/bU8U5l/WBXesgnSgITY8e
         q9mLeJqVjuUgQMtmrYL4k8LZFHf6MP6jgPpVhf9CZt+4OFQ10MUx72z1bb7zdJkHTKuM
         E7Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVyfItaaF4OYUpzPpYOqimhIAUqXqKatOa1aXpKHrt4Aae0Crj3DI7Kc02y7SxhmR7X0gzr5JCqJrWVPDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqG5qdkQWIDMtQgs2y1gAO5ufQIXLJdPbhqY8gvUEe6JH1L6vr
	1t8ERBRFFnjQEe368+50YEVeIYSFES93/tfsbHHYMzcBOKbWWD2p+EslDGBay24=
X-Google-Smtp-Source: AGHT+IH16H440EzuwjvLQ01EZNJRi+gf45PSJTUyeL/cdhOUV+eoPSl0kyjyS2/6msX16cFMoq4JXA==
X-Received: by 2002:a5d:6d0f:0:b0:37d:9565:4db2 with SMTP id ffacd0b85a97d-381c7a469cemr26773698f8f.6.1730995060329;
        Thu, 07 Nov 2024 07:57:40 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b5e8dsm69230765e9.6.2024.11.07.07.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 07:57:38 -0800 (PST)
Date: Thu, 7 Nov 2024 16:57:36 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 0/2] printk: Add force_con printk flag to not suppress
 sysrq header msgs
Message-ID: <ZyzjcLF-wleMTpoY@pathway.suse.cz>
References: <20241105-printk-loud-con-v2-0-bd3ecdf7b0e4@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105-printk-loud-con-v2-0-bd3ecdf7b0e4@suse.com>

On Tue 2024-11-05 16:45:07, Marcos Paulo de Souza wrote:
> Hello,
> 
> This is the second version of the patchset. It now addresses comments
> from John and Petr, while also mentioning that the current work solves
> one issue on handle_sysrq when the printk messages are deferred.
> 
> The original cover-letter in is the v1.
> 
> Please review!
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
> Changes in v2:
> - Mentioned that it fixes a bug related to loglevel= dance (suggested by John)
> - Changed to loud_con to FORCE_CON (John, Petr)
> - Don't skip printk delay if FORCE_CON is specified (John)
> - Set FORCE_CON when LOG_CONT is handled (John)
> - Changed force_con from a per-CPU variable to a global variable because
>   we can't disable migration on the callsites. (John, Petr)
> - Used is_printk_force_console() on boot_delay_msec(), since it's used
>   when the message is stored, instead of setting is as an argument.
> - Link to v1: https://lore.kernel.org/r/20241016-printk-loud-con-v1-0-065e4dad6632@suse.com
> ---
> Marcos Paulo de Souza (2):
>       printk: Introduce FORCE_CON flag
>       tty: sysrq: Use printk_force_console context on __handle_sysrq

The patchset looks ready for linux-next from my POV. I am going to
push it there tomorrow or on Monday unless anyone complains.

There was some bike-shedding about the code style in the reviews.
But the proposals did not look like a big win. I think that it
is not worth a respin.

Best Regards,
Petr

