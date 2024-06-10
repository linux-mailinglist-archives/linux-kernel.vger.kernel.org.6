Return-Path: <linux-kernel+bounces-208655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C949027C9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69541B22CF8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C28145B09;
	Mon, 10 Jun 2024 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1mMHTT1E"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAD38F6D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718040736; cv=none; b=cIvpfCMY/fcqqs45he0fOHaY9Ax757Kw5ssmIZbLdORkFu/urUdZ8sxfSftyXhP0yITJCMfl0st8VyXBXt7w6k5VqFgrT7vvrA/1xIhOyi5CzFI58rxUR7rbnMbQ+aqTZmCasIiwDtr05FDhMuhbRnQGbDZAcLx2w1TdkWez+yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718040736; c=relaxed/simple;
	bh=mdCAFeHPx4NpqBMAT0N/l5bjvvY8+PJwXH20IS5j9M8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EB27P0I7ZvBoT+/5sgf+1sVle6iA5vrk6a6eyPSsvmH4qzFS+Sy77s/mufQzaaxtQKmXMVHVuCCEmdbcnEjVMqrwQoK7Olo0zp+bzGDhvsgEyffG+U1dT4TERLGAgxPQ76ErU+WMOBwwUzbkUeMyPVeM6SqHhvaD4qXsdc5fU08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1mMHTT1E; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52c9034860dso755437e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 10:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718040733; x=1718645533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imSBpkTzzqUmvIsygsJYdm0FauCtvu9Q1kXsJDVsYp0=;
        b=1mMHTT1EyEL6kYPjxmHuEus15h7hQUtN1dkY7Gpkc/ldqx6M5BwR3FGfslTOpvCbVo
         O+q8YaGqE45WOtWt+lQ301Bpi8i7soqvZULXc6UATRXmgeE31kt0lnHi9JZXA8XkwsjX
         PJe+uBxVCGGGRN668HlSViMZZKIJ7XUV8X4LqNvXabuCqfClJDrZ5ZOqsxWu7E8qMINE
         Cg34mJpVIsmwmQCUGL1q5ElbnrlpzK6Y1gXRuj/nbQlm098IPNKqePtSEd5FiOoA4xmV
         uIoTTDXUrugnwl/v2o+raq8pqEAGA/L8wy95025amWPGAi3w/46wkuaLbJgLA6bybVDi
         mrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718040733; x=1718645533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imSBpkTzzqUmvIsygsJYdm0FauCtvu9Q1kXsJDVsYp0=;
        b=e863eVOvNsfaLt5bLFX/KATtodTRY37dxFQAURVQGadDJnP38w6cinDvRU2S0lNzT4
         IyA1MBNX1iyqB6muVaguhd5e7wy20Sbep7/TS9M5FHcQMHh1FppQMTBRJysIf3OpBP9o
         AuL5LDdER2UfwWCHUqBcmy1Yu03VsXvJTQMnZ5ZSZAbb52UuJ7xAYt+Jfq314JftfPn0
         aNMM/6IlbKu/X90tafjduQYTxI23mK7k2QD8JAztriz0M5RIFRJ2p71Rs377S06/GLqQ
         kPVWA+3KIvaVqPlJSEI3pC6MIKnh2XRuq9PQGGTiLkzuym673dKZ1jztoMYV99e5cmhZ
         4IGA==
X-Forwarded-Encrypted: i=1; AJvYcCV+uuwjK2Ktq60J6hTD65R+Fxgj2+NoOy8qGwYH26AkXlP0BP2zNV2uWr6h8P4ScZNg4ilk3AnV6OK+a9g1kz71KE1eXhLVY1d+af0O
X-Gm-Message-State: AOJu0YxpMn41JnKvSoElTNBWpnDfsoVJWFwx+tChCBuZD0RcUtTY4s+u
	2pp1HLw9g8ZeDYh/JTtND0oN3PiMyE4F9ATHxmznfd97qfAa4b99NSToqx/WHgzpQ5e1YSue+wh
	tlpEL3SE2TgLHCxsVB2Yw/kUPRhgGcwQAA4bw
X-Google-Smtp-Source: AGHT+IFSeNMKWqrQLXEOHa+5P7nb/xJZqIvzN2fuHP58NLsfwKlgg+SFRKV2Ukoyl2SaooUYc/qwxk+POkSzk7Jmi8U=
X-Received: by 2002:a05:6512:10cd:b0:52c:804e:e831 with SMTP id
 2adb3069b0e04-52c804ee8a9mr6407306e87.47.1718040732869; Mon, 10 Jun 2024
 10:32:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610143037.812955-1-usamaarif642@gmail.com>
In-Reply-To: <20240610143037.812955-1-usamaarif642@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 10 Jun 2024 10:31:36 -0700
Message-ID: <CAJD7tkYdTvfO8P+aZNmr7bF7vEetxiqQQ4ML8BcLdmKohT-+Cg@mail.gmail.com>
Subject: Re: [PATCH] mm: Do not start/end writeback for pages stored in zswap
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 7:31=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
> start/end writeback combination incorrectly increments NR_WRITTEN
> counter, eventhough the pages aren't written to disk. Pages successfully
> stored in zswap should just unlock folio and return from writepage.
>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  mm/page_io.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/mm/page_io.c b/mm/page_io.c
> index a360857cf75d..501784d79977 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -196,9 +196,7 @@ int swap_writepage(struct page *page, struct writebac=
k_control *wbc)
>                 return ret;
>         }
>         if (zswap_store(folio)) {
> -               folio_start_writeback(folio);
>                 folio_unlock(folio);
> -               folio_end_writeback(folio);

Removing these calls will have several effects, I am not really sure it's s=
afe.

1. As you note in the commit log, NR_WRITTEN stats (and apparently
others) will no longer be updated. While this may make sense, it's a
user-visible change. I am not sure if anyone relies on this.

2. folio_end_writeback() calls folio_rotate_reclaimable() after
writeback completes to put a folio that has been marked with
PG_reclaim at the tail of the LRU, to be reclaimed first next time. Do
we get this call through other paths now?

3. If I remember correctly, there was some sort of state machine where
folios go from dirty to writeback to clean. I am not sure what happens
if we take the writeback phase out of the equation.

Overall, the change seems like it will special case the folios written
to zswap vs. to disk further, and we may end up missing important
things (like folio_rotate_reclaimable()). I would like to see a much
stronger argument for why it is safe and justified tbh :)


>                 return 0;
>         }
>         if (!mem_cgroup_zswap_writeback_enabled(folio_memcg(folio))) {
> --
> 2.43.0
>

