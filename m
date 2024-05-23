Return-Path: <linux-kernel+bounces-188125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C484B8CDDC9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 01:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F3A1F23F82
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1401292C2;
	Thu, 23 May 2024 23:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LV+YjtPX"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8683A127E28
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 23:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716508159; cv=none; b=HKrHnSm1UpNQB6noD9zAlfkGXqr3uY1oGgeeAeELSvYOQ9lXrQZ75s5Y9vtY8QyMYhFhoDp5NfiObYzaqf5snG7gBcv8XPtXK4B3zfCZDbT6Xo7RjyJECwz78B+BMAcxKdEWgqGG8XJ8CkoUpEO8GiiIN4As4rHy7ghjumnyeOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716508159; c=relaxed/simple;
	bh=f14zzgUE4RpNE/ENjRASf+ipA6iu8BQvstQoxLsQmxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1R/6nw7fWJMaj97pDbwHmE8WbXVpCz/mfp6UoYT0Dwj/qwU6fbMX67x/W/8aURyI8IQczSOCgNCOFd8naDRiO3enN7/6RvhONWDj+/9jqUCYo1dLQbXQaQWKPVB/XLl8fxaQS7NPPfwHadGceIsSTiZEsR/nXvy5s9QtgN4OEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LV+YjtPX; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f8f34cb0beso187345b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 16:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716508158; x=1717112958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1uIS3HZKU6NCDT1trnq/4hta3P9vI5FJKrJfEbB/tpM=;
        b=LV+YjtPXgbb/L6ClgB/41htWhjJnbTlRAmiQFSMeqTLVDL8EAARikLt0zG3BIgk4VX
         2Ch2TVOEvJ7+POR+Z7hX3kGMhehXVr31wKhy4eNBGYpfIixbkTrAbRZsnnkJzYQ2MYLH
         8EuiglEYSUJi4qTs310q3tKATEZISAhYiJ0NM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716508158; x=1717112958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uIS3HZKU6NCDT1trnq/4hta3P9vI5FJKrJfEbB/tpM=;
        b=BrZGxfz2G5h39qgVROypbkzbla8CAK5L/qNjHzHHaijGnoSLVrmLgSECkR3WQ9cIa8
         bMJS+pwRtN85D9lIfMLmuTvx3jLKnwfESdbRkg8uas2mh+yh0+wzFWR8uRlmzCzDcCb3
         cdzE5Ctx0qaInKSkx+mJJkfVCa9Ai9ULrqu4lyqaTv0v1c8ABgDsjHLieIY/0Crktshv
         /EfgMcARMb4K4jsOz2Mq9EGoTwATmMmOWjIN8l5IDkZzMqC/nFQFFRpckf73SA4o0mBe
         7RU+NftTGSyAuAVdcr6Pn1xxKECnzfhe2GO2zAX2kP/suleKNYWOHznvSKjOt79R1bT0
         AUpg==
X-Forwarded-Encrypted: i=1; AJvYcCUexN5sTn5j9AL0aEeJ/SIKfDdNGtRAs0zreeLRbidi1GpwtHXkNSf6mj0dZnO9iJr5+j1qTTcqmAWIwpHICkhHs7Wjnb8aOt+U9F3X
X-Gm-Message-State: AOJu0Yxu2+d55XTEd4viZ/FNYiGy2ppSaWag0Svs20K89EDMf44FIn7G
	NjM2OGTgCerUVuZ5SGllaCNZuJt75zQGhlsuGU/akPSpZI31ChUTcqFtvP9vBg==
X-Google-Smtp-Source: AGHT+IF9gMMldiKXPn103xSNzm5h3lWwxxnQr7d6oU1kzXIcMvbxWqKETvebkWBqarV+LQyRu7xdMQ==
X-Received: by 2002:a05:6a21:6da1:b0:1af:f50f:cbe5 with SMTP id adf61e73a8af0-1b205c8ad56mr5421013637.8.1716508157798;
        Thu, 23 May 2024 16:49:17 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-682274bbbddsm107706a12.92.2024.05.23.16.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 16:49:17 -0700 (PDT)
Date: Thu, 23 May 2024 16:49:16 -0700
From: Kees Cook <keescook@chromium.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: mattst88@gmail.com, linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Regression bisected to f2f84b05e02b (bug: consolidate
 warn_slowpath_fmt() usage)
Message-ID: <202405231647.69CAA404D8@keescook>
References: <20200602024804.GA3776630@p50-ethernet.mattst88.com>
 <20240521184652.1875074-1-glaubitz@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521184652.1875074-1-glaubitz@physik.fu-berlin.de>

On Tue, May 21, 2024 at 08:46:52PM +0200, John Paul Adrian Glaubitz wrote:
> Hi,
> 
> Replacing the calls to raw_smp_processor_id() in __warn() with just "0" fixes the problem for me:
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 8bff183d6180..12f6cea6b8b0 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -671,11 +671,11 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
>  
>         if (file)
>                 pr_warn("WARNING: CPU: %d PID: %d at %s:%d %pS\n",
> -                       raw_smp_processor_id(), current->pid, file, line,
> +                       0, current->pid, file, line,
>                         caller);
>         else
>                 pr_warn("WARNING: CPU: %d PID: %d at %pS\n",
> -                       raw_smp_processor_id(), current->pid, caller);
> +                       0, current->pid, caller);
>  
>  #pragma GCC diagnostic push
>  #ifndef __clang__
> 
> So, I assume the problem is that SMP support is not fully initialized at this
> point yet such that raw_smp_processor_id() causes the zero pointer dereference.

But how does the commit change that? It called __warn() before too.

Is this an inlining bug?

-- 
Kees Cook

