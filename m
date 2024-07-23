Return-Path: <linux-kernel+bounces-260307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A30993A607
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315562842BF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4865158A03;
	Tue, 23 Jul 2024 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Uqj5nVBU"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBB013D24D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759454; cv=none; b=WacIkJdaC3fLDHVur6zBZz2lG0Qt/q1js4dk2li7Rp+mfjZ3EuffNX9p+h03evJPVwD5uax7JYjrSSA4F3i1C8UnpZ2f59NX5UY5s07MPt72mqcpBgrmBhIEL87oqL5I6hrfjA+boLt75zaVyz3+0V6/t7T7OumcRe2z4N6heZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759454; c=relaxed/simple;
	bh=Pp3VZCk6dq4+5Vpj+kfpnKF3kGHUtiSO1r77QnLX328=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSlhbGxFJk0uPwiiRYa5guESGc1qftGucV5suJ6exibRuInzZXvJGfCgkUwrI0WKoGQoF8xKIM2jYcZESKc+vPRmVO3vUGavdivfWTQtHKPP7bwJjxc2tjLi8EhQDmQlu3KIQq3EAsLS9r0KFii2uvBAJMZD8cKQigRcxhTlBzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Uqj5nVBU; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so79413431fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721759450; x=1722364250; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hbXsSOOY+gKi86u1NQNhucpEoLXztu3BNQ9K2X48C04=;
        b=Uqj5nVBU7Bn/TNuydEGRewUhk6xYLTh7bh/+y/BedcKtRNX1sL0f3HIb5e6PvUNcIr
         O72G47BuYMAClR2SaDrawb+rFR8z1PxgxrJUshYYo2ApixOmfkZXwk0s+eEf3lkzWtyE
         QY4V+dYqGi8cBu5ctuePXlSTECFICtSq5iYOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721759450; x=1722364250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hbXsSOOY+gKi86u1NQNhucpEoLXztu3BNQ9K2X48C04=;
        b=oEDphvntR/SHQHdbHWJkOOrpxQyQ3XXi6KGk87U7qgq93E9E+cXPRgw4hedqTaN2jJ
         5NfgibfjM+KmLTk1qYYaY2erB8CSFUaCIonLs2vJLr7T98jjabwgJptIdz5jEXfsEymG
         w4awNLlYOF1Y4tkFzu/Xa9n8J+/Lo4EUEbrR4xxcn28+xWvPpT19vU77FjlRuWUW82X/
         eD4mAJrfmHv5VMbm/tXoSVzqPSpJdxeFUROGxwCEfJvHlw8jqK9YxfgSYtnO8UA6TkOP
         e94JdAK1IGO22PrCAy00q00FjnJcqLXkfPY6mWnNc/R7pEHsWhejmA+GpyMBahaHTvbd
         QSbg==
X-Forwarded-Encrypted: i=1; AJvYcCV+sG1EtQLcXHHuxJlq1J2hP3O8OqaiP56YRMn3ac4ubBzcCE55CLc6lvzo+qL8k3HbNijht1VF6w8t3Bh3dDGEAstTHBxXquZWMGgS
X-Gm-Message-State: AOJu0YzU1Xx52GOUZQwEZVCiyC2KuU3z5dRhXbpbwt2LKpAGdhrj9qMh
	ROefVvKxtw0UjrSGUcxdIU6KPSoaPifr0UT6QUHCLbJv3gaoNoDT2WD2/uXyAz36JVL4HPorjXk
	wsyQ=
X-Google-Smtp-Source: AGHT+IGUMCezrruOXOIdfIVHcA+p08MkKy7xt8AeEkZ1M02e2cSix1QfCZMNZT6XpkUIjii99BgRDQ==
X-Received: by 2002:a05:6512:3ca1:b0:52e:9b92:4999 with SMTP id 2adb3069b0e04-52fcda17d15mr351212e87.2.1721759450486;
        Tue, 23 Jul 2024 11:30:50 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52f00f52ab3sm1060708e87.184.2024.07.23.11.30.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 11:30:49 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52f025bc147so3855340e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:30:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLKrOydC8WIT7gIhr1M0QpmqRngCR3KcHIUr4+dGpIupF1+CfIIJ7rGtmdBllhMhFsxdjNZ8xSSTirTXOHLo4vTJBNLZt6XxyM9wf9
X-Received: by 2002:a05:6512:3d26:b0:516:d219:3779 with SMTP id
 2adb3069b0e04-52fcda6533cmr227963e87.58.1721759448531; Tue, 23 Jul 2024
 11:30:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723171753.739971-1-adrian.ratiu@collabora.com>
In-Reply-To: <20240723171753.739971-1-adrian.ratiu@collabora.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Jul 2024 11:30:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJL59WxvyHOuz2ChW+Vi1PTRKJ+w+9E8d1f4QZs9UFcg@mail.gmail.com>
Message-ID: <CAHk-=wiJL59WxvyHOuz2ChW+Vi1PTRKJ+w+9E8d1f4QZs9UFcg@mail.gmail.com>
Subject: Re: [PATCH] proc: add config & param to block forcing mem writes
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	kernel@collabora.com, gbiv@google.com, inglorion@google.com, 
	ajordanr@google.com, Doug Anderson <dianders@chromium.org>, Jeff Xu <jeffxu@google.com>, 
	Jann Horn <jannh@google.com>, Kees Cook <kees@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 10:18, Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
>
> This adds a Kconfig option and boot param to allow removing
> the FOLL_FORCE flag from /proc/pid/mem write calls because
> it can be abused.

Ack, this looks much simpler.

That said, I think this can be prettied up some more:

> +enum proc_mem_force_state {
> +       PROC_MEM_FORCE_ALWAYS,
> +       PROC_MEM_FORCE_PTRACE,
> +       PROC_MEM_FORCE_NEVER
> +};
> +
> +#if defined(CONFIG_PROC_MEM_ALWAYS_FORCE)
> +static enum proc_mem_force_state proc_mem_force_override __ro_after_init = PROC_MEM_FORCE_ALWAYS;
> +#elif defined(CONFIG_PROC_MEM_FORCE_PTRACE)
> +static enum proc_mem_force_state proc_mem_force_override __ro_after_init = PROC_MEM_FORCE_PTRACE;
> +#else
> +static enum proc_mem_force_state proc_mem_force_override __ro_after_init = PROC_MEM_FORCE_NEVER;
> +#endif

I think instead of that forest of #if defined(), we can just do

  enum proc_mem_force {
        PROC_MEM_FORCE_ALWAYS,
        PROC_MEM_FORCE_PTRACE,
        PROC_MEM_FORCE_NEVER
  };

  static enum proc_mem_force proc_mem_force_override __ro_after_init =
      IS_ENABLED(CONFIG_PROC_MEM_ALWAYS_FORCE) ? PROC_MEM_FORCE_ALWAYS :
      IS_ENABLED(CONFIG_PROC_MEM_FORCE_PTRACE) ? PROC_MEM_FORCE_PTRACE :
      PROC_MEM_FORCE_NEVER;

I also really thought we had some parser helper for this pattern:

> +static int __init early_proc_mem_force_override(char *buf)
> +{
> +       if (!buf)
> +               return -EINVAL;
> +
> +       if (strcmp(buf, "always") == 0) {
> +               proc_mem_force_override = PROC_MEM_FORCE_ALWAYS;
 ....

but it turns out we only really "officially" have it for filesystem
superblock parsing.

Oh well. We could do

  #include <linux/fs_parser.h>
 ...
  struct constant_table proc_mem_force_table[] {
        { "ptrace", PROC_MEM_FORCE_PTRACE },
        { "never", PROC_MEM_FORCE_NEVER },
        { }
  };
  ...
  proc_mem_force_override = lookup_constant(
        proc_mem_force_table, buf, PROC_MEM_FORCE_NEVER);

but while that looks a bit prettier, the whole "fs_parser.h" thing is
admittedly odd.

Anyway, I think the patch is ok, although I also happen to think it
could be a bit prettier.

            Linus

