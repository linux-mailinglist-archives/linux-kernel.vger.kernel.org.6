Return-Path: <linux-kernel+bounces-407392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9679C6CE0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E191F211A4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646C21FCF7E;
	Wed, 13 Nov 2024 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="alZC04e0"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ECE1F80C5
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731493833; cv=none; b=SrOFXa+QIm67SRVWYyCrQjmoc18rKg8rDe3t4XmaG8pbanm27TC//ed5K87s11FIkXHxLuFDUZXM6mCBMRr9fRkyxyQ5nq3NigwCDbNEi0DIkNR5aRFgi1w6/JibvhIpLK6sTebzKYXPscYBTulsrlqK7+/l++mkyWF2SSyJqgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731493833; c=relaxed/simple;
	bh=nI2QXRDzyPnMBaJNq4JBRnqkSaWwKlsycEp06ZxVQc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTrv5qsGl4vjoJuZ9SpTwfG+gy+WKrsBiJ0lUjetr413HsOQgpGdNr0UZoh6njJU19anhMh1v4tEJLSqrUr/avKo3f3gGEgVaWtH9aRX3QQSfCtl45NoYGEp8MKMBTi2pkYKA5RBme/07Mo5u48j0Y/2y7TJ2jHpHf4AFtT/2PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=alZC04e0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so56562035e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 02:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731493830; x=1732098630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sQbvCdfXhjIPC76cjEbTBJxaacMeps+mMlD7b48V7zw=;
        b=alZC04e0dA+XlbucA0x1xaXomEBxKzVHRU60lqwtpSHJPqLhhnxTGpzvFvcgvhPG8M
         1nQTj+TTrw6u3aBk44ivvksFoJmHZ9gQqj5vE6i4QnckPaBwqQPQ64ELY2q7hKBoLQg5
         JEV0iSO669ioi84nvwbORNKkN09MH21SQmRkor3nT2FESnqNBAL2gJxDll3plGwFE7HQ
         2ELF48suqQRA+xXtC6uAPsmzs6MabB3LSF2KEsZsmY67zvoLdtSmj2UVERFtBRPybNvD
         6Rvuoj1apUUa1WOEdrpGJTrUHiMph2HqGxio1yDtYKE8qtHM4QYIv0TrX+sGeU2tyWyf
         As0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731493830; x=1732098630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQbvCdfXhjIPC76cjEbTBJxaacMeps+mMlD7b48V7zw=;
        b=vbXkpSCS1qi7XDP1M+/n3xa5dtd+5yOGIQmK0zNVF+hC7xyeGYN7kyyyxiFCOhzdiF
         mHaF4dVE2rw57u3ys7UuEduFm+WYreey32kJKudTPxucvckQoYImvkzPyzYCBnC2d1ii
         qocQOsIPd9eSMpmhJ+59TYDRo//tFy5WFR/x4tF5lqcSN/W22/SVIxDeNnKNfch1F2aR
         a0OHjP74h6cqOzu1rhWWTViRPPPu1oLBv5ZsWI1914Gt+LgzFtHTq76usOw8zKp7uQDX
         BcEpGVJ35S3eTpSb5rNAZn5eAzys4kr72QIb8aY0mM7ASAya8y13KfA7g0MkYDH4ioTh
         YKEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfTkI0oXAETQvhCvr0kyM9JvFpsge5YKsZT0SD/IhNDPscQu6hE8zcWPiBmVSF7VQPrWIAm1IW4YLSXcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYO5/nacClA4Vgh4TBiC8tAtiUs1br7S1iMBYu+olcrMuu/JkT
	4nT91eoU5ilGqPz79e5cvoAZmn6fGbFnESYEHPyEEi5gJOaGSwKAax7vaUUFp/A=
X-Google-Smtp-Source: AGHT+IFUNQ8Zh6sbKj9z0wCIf3In4hLgTckA1X3VX4W7ImZT4cpNZybWG87co6pyVYw41wxIIG7a0w==
X-Received: by 2002:a05:600c:1f1b:b0:431:60ac:9b0c with SMTP id 5b1f17b1804b1-432d4ad33demr19747595e9.20.1731493829988;
        Wed, 13 Nov 2024 02:30:29 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d54e0ee4sm20268395e9.1.2024.11.13.02.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 02:30:29 -0800 (PST)
Date: Wed, 13 Nov 2024 11:30:27 +0100
From: Petr Mladek <pmladek@suse.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: John Ogness <john.ogness@linutronix.de>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] printk: add dummy printk_force_console_enter/exit
 helpers
Message-ID: <ZzR_rDN80j8sD7d-@pathway.suse.cz>
References: <20241112142939.724093-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112142939.724093-1-arnd@kernel.org>

On Tue 2024-11-12 15:29:15, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added interface is broken when PRINTK is disabled:
> 
> drivers/tty/sysrq.c: In function '__handle_sysrq':
> drivers/tty/sysrq.c:601:9: error: implicit declaration of function 'printk_force_console_enter' [-Wimplicit-function-declaration]
>   601 |         printk_force_console_enter();
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/tty/sysrq.c:611:25: error: implicit declaration of function 'printk_force_console_exit' [-Wimplicit-function-declaration]
>   611 |                         printk_force_console_exit();
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Add empty stub functions for both.
> 
> Fixes: ed76c07c6885 ("printk: Introduce FORCE_CON flag")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks a lot for the fix!

I have just pushed it into printk/linux.git,
branch for-6.13-force-console.

Best Regards,
Petr

