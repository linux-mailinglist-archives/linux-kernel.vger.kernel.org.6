Return-Path: <linux-kernel+bounces-275283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E902C9482B9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269401C21C5A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CE216BE13;
	Mon,  5 Aug 2024 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DD+k/WVY"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E81D143C69
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 19:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887882; cv=none; b=ZoGVaCQPBLRiTVjcUDGe+F7XdVZcGJz2b4bJ3XNoCKxXG8+MF/oYXLHCaYcUI/SBGqrl2fPjNlk3he6vR1L7smkFNbW64FPH+uDiuZi5ISQ4kKdu+Whcg/N5UcQNU/g6txadEWe9s8TKmt0OFIvF7afR3+1vCcZtENYyNgtEMNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887882; c=relaxed/simple;
	bh=rxeLc0f8DRhPsmh0FjjZBjED0NX11DTdFc6s6f4LPcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXuRzd1DgiH+NFu5/G6vkLxu6jcoEjT8mJxLvSZFvUZafeiRCWEvhjN9iedUZuDZLXeDoZH3z/fK43AG1dIvvyyra9HDagXNyhHCAglbb4LH4q4mrcUHiCuZza1m7NrEpJXY2ILGh9UmmUNygZkoSINlc5Kctt3/yaGqpPmxo18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DD+k/WVY; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-664ccd158b0so91733837b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 12:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722887880; x=1723492680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPPnAP7qxMYZ1TKRWZYPmOYj/E8z7mPvmJgbldEEpHs=;
        b=DD+k/WVYhaPVH6nzw7yZ71iNnISojbXnK81DAfHwDCforJH51cQlzhfHOZNsKK/CjN
         3N/zRIvqXqM7S0kPAGXxYnzygainD+JbcLj+277t6SyFq/xLJhPkCj8QgRwIYufJrNr0
         StHAUREUL7KfZLBM6Oz6JF0sL1qHqspPorYRHhIXhbHt8W+8ZyxgdGx3ng27gZ0EimyY
         LNFopB8Jkoujt5iJBp/Ui4t99kSpYax+PXfgz0v5BhVMl80OhvEqr4jotQ6TZSR3G5MD
         /VE0saSEKp+T7+MRuK7Isleg/NR5EBnxga23qduHr6xufEf/wY2UKbIkQj1CQpVB+ekA
         ezow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722887880; x=1723492680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPPnAP7qxMYZ1TKRWZYPmOYj/E8z7mPvmJgbldEEpHs=;
        b=oF7fM4olx7OXIC5kqI5AXS12CDRJWs7KbkHAAr9MHlCZnRWqrZV5+4zKGFPDNfjDOg
         Z4EC8G9OaZqbhw2v+RSpQZ44+VNn3wVPSFF/bQ+Vu5kF9CP6Nb06zz9YSYrdkzNCxAFa
         9mcylFtBMZWKb0GCc1m0VaMMMgMNsTLKBAuqHvX6McrR+SN74OVwJN2pcfT2ctcQCRkf
         Ye/v2SSqOMwD8RXHi3IO4/CpMTYQUncR0is2Mr8bVltBIbSRkunasXHH81qLCK7VF+w2
         nmstJEpNVmusHSa2vcl7urrbC3XYFBCAFfoKAwapZbLayvgmTJiVx6BvGG4SzwK7oN8a
         N6og==
X-Gm-Message-State: AOJu0Ywk3zsZmXBJIagMLMdBoYVt0+gDbJyqWasWjIKmZNUBREXCVhuV
	KqB4/FHFCUn7QuRtxgw086fkrVncX+h67ExOndKANznBurpfW1eDxXTrlyV8+PnqRSWVJXN7OD8
	zUc54jHIJMKvfG3I+JO1KGJ0G+Sd5bRDQ5KyD
X-Google-Smtp-Source: AGHT+IGa9SUejtgqxNEB5F9IenJObH511HYzk082Jg1xU2pMV2j06uhI6f3vEg6NNtPmhDJjw6qggd3g7GrSoM6h15c=
X-Received: by 2002:a05:6902:725:b0:e0e:65e4:b7ef with SMTP id
 3f1490d57ef6-e0e65e4ba58mr2206966276.51.1722887880428; Mon, 05 Aug 2024
 12:58:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801171747.3155893-1-kpsingh@kernel.org>
In-Reply-To: <20240801171747.3155893-1-kpsingh@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 5 Aug 2024 15:57:49 -0400
Message-ID: <CAHC9VhRO-weTJPGcrkgntFLG3RPRCUvHh9m+uduDN+q4hzyhGg@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: KP Singh <kpsingh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bp@alien8.de, sfr@canb.auug.org.au, peterz@infradead.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 1:17=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
>
> With LSMs using static calls, early_lsm_init needs to wait for setup_arch
> for architecture specific functionality which includes jump tables and
> static calls to be initialized.
>
> This only affects "early LSMs" i.e. only lockdown when
> CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is set.
>
> Fixes: 2732ad5ecd5b ("lsm: replace indirect LSM hook calls with static ca=
lls")
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  init/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Considering the problems we've had, I'd like to hear more about how
you've tested this and I'd like to see some reviews/ACKs from some
arch people too.

> diff --git a/init/main.c b/init/main.c
> index 206acdde51f5..a0e3f3c720e6 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -922,8 +922,8 @@ void start_kernel(void)
>         boot_cpu_init();
>         page_address_init();
>         pr_notice("%s", linux_banner);
> -       early_security_init();
>         setup_arch(&command_line);
> +       early_security_init();
>         setup_boot_config();
>         setup_command_line(command_line);
>         setup_nr_cpu_ids();
> --
> 2.46.0.rc2.264.g509ed76dc8-goog

--=20
paul-moore.com

