Return-Path: <linux-kernel+bounces-575087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85994A6ED5D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51005188F966
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB1719004B;
	Tue, 25 Mar 2025 10:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fc6lIOAK"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74631C84A6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742897725; cv=none; b=aJ7zYNHIOmifA7dRULjqTCYMcqjIxqznjc1Bio71evBioNyBr7BCeLkTC0jlhCWAlxFuRq6oNlUc+M65Z+/kdubQNYTvuIjouJytVluB+/ChANHbl2/cRe5ZE0SX1OvSTRNOASV2Uvf/3kmWu1oO3ltwNyB66ByddBA45DyObBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742897725; c=relaxed/simple;
	bh=gBxlLT5ivpGDh72oKPJ3CBVf2yMPWUqCIsclGPiI0ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9OFwLS4oc+TqEGQQX1kvTKAGg6vwMc4AqSub0ANdUF5eyvly7GQu0WsmThfToOi6hoEHCx9YQ64i3eNcZZX50uxZYcxfXmE+/qio3tZoJUiYGGtR5jhxf/aDRVCVHh0FlXUkyz2Y6cOWMY/TbXAIPK0EZuP/VAtgq7bCTbBaUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fc6lIOAK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso57920675e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 03:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742897721; x=1743502521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VSbCNl4BxWO8IbyHRgNtn/a7Rf0u1sJorrF8gojdNyo=;
        b=Fc6lIOAKpCOraZEvR/fbMV5DPHBT9DVzUJxny4j4iSVPija1FrydvR31VLyl9m0P+3
         st+zmzGmXGZ73QIc3dXalcaw91I5w3P7vT426vY5pUqgLyziJcfoqOdbgodK+8P9vKh6
         2poKQl7dd/2hNfG2GG3wenA7LXBMeIIyOACwJ+eEviS/HHsqvObC7FX5QZ7PwDsX+Wpj
         xH2NV4KxrEtTLzbDlFjxSAs+SxBRrlgSfl3ccvgU+0qneT8Vu/5toPBGhYI2TQvWUr5X
         UiwNQkLTv+lMQGSVrABaVF55REQI17nfgtaAtzXZoZM225/5YsKBN92o01tcCHg2RT0S
         9/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742897721; x=1743502521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSbCNl4BxWO8IbyHRgNtn/a7Rf0u1sJorrF8gojdNyo=;
        b=mKnrm7Eh+p7WjdMRVVVHVs91PZO837f4pr9QJqa+zw7HyKMkhO+NTYf7oyfqohCoR6
         0MCtaK6NH8FBY7GSLhG/WzSAhyWuo0SaRpPJ/tcGlhebAMFD+OFofHhKC6PuRPcUnMxt
         pZBPrzlfCq/ABEyc2OJN8FuKh1bPUaBcrbk7/n8tmw0OpLNT8hW7ffkSlSu1JI0kB5A8
         TNgbs5JLsxYdkfcOA8kEnJ1l41GX5dI1oFqtvUFZpwo56slobJrie6Ghxdt/nWPwmHgw
         8c794MEaVYaH6rHTAXpqStgCNjUjbrn6xSF4jKcjFIbwi5nKpiFXhWDh9aZWD14SUzBy
         z3Hg==
X-Forwarded-Encrypted: i=1; AJvYcCW4TyRyE/7AaxujycqJNFnrQ7Ryjd9iSBMf/zY81j11zDcj03Z7E0vNjkw8S8n46C+TqvsdbkyRD4V03Xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ45OJZCI2nOqEPRTsvqnedWUXADAgG6uu8pyxvEPiV0UFg7BF
	8nnm1XiwvDQ0mArLEDdcvxOhAO1RC1HXbOO22si+1OnN+2Z+kmBfFe6Ia7wcFuI=
X-Gm-Gg: ASbGnctbptjkCZhByFZfSg7r30kFQoPIHRpVkisjlUwcU+1SjEgC8VsVMfvDN32I+Y8
	/lHwMFCpeXk2bMCGxWP4dIoayCEV4tMkgGp8h/fE5Y4vSp1gEe4TNWCmDcRRkcfYYTPL5VVmqt1
	5ZivnBiu8f44nVmxHgcluYbhxJ1i2/MrcSTcycjwDYM6mQyUyyfGasr08dowL2jroD3W/rBM/CE
	LP+vFmawPNO7cWY4p/yY/VkAbJNTrWe8epjJlHFPot8OXAiWBd4d75ms6GF8cEg+AkkILB3qiZE
	1yl7FAlK502RDT9LQoqPB3AeYNWppVt57Gl2ETrKO2Aq
X-Google-Smtp-Source: AGHT+IEHsfS3jwIQd3DXLtKs6BlMXePkgOPcd8GrAW7V3JTw8OOWk8DEnFNJlXsh14KOgVQNsnrCHg==
X-Received: by 2002:a05:600c:4584:b0:43c:efed:733e with SMTP id 5b1f17b1804b1-43d509f58b4mr147592855e9.14.1742897721087;
        Tue, 25 Mar 2025 03:15:21 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fceb780sm149735745e9.4.2025.03.25.03.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 03:15:20 -0700 (PDT)
Date: Tue, 25 Mar 2025 11:15:19 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 0/6] vsprintf: Add __printf attribute to where it's
 required
Message-ID: <Z-KCNy7Qu2vFdwVx@pathway.suse.cz>
References: <20250321144822.324050-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321144822.324050-1-andriy.shevchenko@linux.intel.com>

On Fri 2025-03-21 16:40:46, Andy Shevchenko wrote:
> This whole series started from a simple fix (see the last patch)
> to make GCC (Debian 14.2.0-17) happy when compiling with `make W=1`
> (note, that CONFIG_WERROR=y and all warnings break the build!)
> down to a rabbit hole.
> 
> However starting from v2 the last patch doesn't require the first
> part, I prefer still to have them since the functions, while being
> _binary_ printf()-like, are still printf()-like. It also puts in align
> the tracing stuff with the rest and fixes the wrong parameter value.
> 
> These first 4 patches are organised in a strict order and can't be
> reshuffled, otherwise it will produce a warnings in between.
> 
> I believe the best route for the series is printk tree with immutable
> tag or branch for the others.
> 
> Alternatively the first 4 patches can be applied first as they
> are pretty much straightforward. They also can be squashed to one
> (as the same topic behind), but it all is up to the respective
> maintainers.

The whole series looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

I am going to push it via the printk tree. I think about doing
so as a second pull request by the end of this merge window.

Anyway, I am going to wait few more days for eventual feedback
or push back.

Best Regards,
Petr

