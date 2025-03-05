Return-Path: <linux-kernel+bounces-547394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 338C3A50685
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C9007A3539
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11720251786;
	Wed,  5 Mar 2025 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iD1GZqBD"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D322512ED
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196262; cv=none; b=vDCwgLiGIzQapW7qBntbO5RSITRzOwkYFJKg+dzDO9CZ/fVk52My+029mYZTAFmZB7LXyyTBq+SSkrTr4pmcvpuf6Idebs/k4anvmZLybHCKPCUF8QyA7rf3oRgFuXCR8eeGm1IVXP1kNbDWy1uBGnesnCiCGtn2tYka7373TQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196262; c=relaxed/simple;
	bh=WoETCVGjy2RB0OfNlCtwUP4FVXQH9u/7ZsiErTsMbeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOxZW44HQ5UIxAUoFN8wIu09jIgUuJPzd1G8iRgNcPHnwztz9Gz65KFwHw10XzrBhnHZSQL9kYt2Kdj7JLO/GcPT/Ly+IWFi9MvcVenNJt4+Tgo3uVl/SbrNI+k72wUQ42ouXktpwubMxvuhpnom9/F7By5chBMKbBvRf3J+yYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iD1GZqBD; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e89c11fd8fso86682836d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 09:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741196260; x=1741801060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0Exo55ZhAA6D8yt4iRmZ74A0IWU7oplT8SFT87a4mo=;
        b=iD1GZqBDG2BSE3cbS22oQ/nh9J9c//9poEJra5TIeU2BqRsbSOkHZwYKjCc238cwZx
         bxdFAdM3LPCcWpcNZxTRhKN6PlVqOaVIqtIW0o+vQpjvZxmofPibV6qR2EsLtd5DA1kt
         pxipeIBEBBQ5TEY6LbSQQXth5aPPyysqVux/xz24upVjTlLnM1Kl62uF0H7N+rrL29kr
         4/9be93OlPWfXx6srIUXWWeOsAg6HQXxnxgr/uCAaQosvkBftVhXzaZ7GTvcd2SpvQWx
         VfbYfquIsPxYr0iDaN2Ogw5A0/sl2fI0aS2PNzd0yy5ReacbWjKu5FRSRRV59SsdeIGv
         4g1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741196260; x=1741801060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0Exo55ZhAA6D8yt4iRmZ74A0IWU7oplT8SFT87a4mo=;
        b=YGBJAtAe+9dZpwFuU+VwzCu2QU4oGzS/A14DjVRe33XdjneMBdjWy8MxJij3Zxz7ty
         kJV0dgTb57zNuRCoGShBOVBNc1804rsWaDrjpWI436DeoHta1qf+//s+gLLZukiMRVw2
         ql65KTtA0Umu04B6gksI1IU9yDZt9gjDO2rOQ+tgUaxMDNLCVezT3tB78uN1D4v1KaS5
         4wx1Qb73K3SBa6gLCzaorgfnunodr5P/MkwvofSY7FMXCltsfXh+bOrNWgrK1o7IYfX+
         GtrP/msWkWzfIq546UVh1ermw6RN57nNVsQkNgx+AZOTSfCzD6rCtfWnNlUe2VDAOoBq
         wwLA==
X-Forwarded-Encrypted: i=1; AJvYcCUUuQ7cze9cih8mmF5dvanmJJjoWpSdhCD8ckBv9H+VZ+LBujpcETsBL1cbOj8b0P8WiNd9YnaCGBbC32Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqX/u612Zp4etsB4e97U8X+RkFDNGq3G1/vxTk6WZxZrngECMf
	cKa/6JVB/YSznm5vMpCorU+esJlmi9QQqJEcqIM6nvnOE7Dkdck/kRKqYadZZuNZMt9U5pf2za1
	qEqoriK0hvX4SeC7uzbv6EzRkHEY=
X-Gm-Gg: ASbGnctJbYr2282B/ngZYQDvxubsXeBXST6k+l9Tg+crOpbJ6x0m1pD6ZPv854DJK+O
	wqpRDA162WlVIfHp5FaA/fHOBcjrYaKsjJoX4y/rMcT17szqrfpL/XGZxMX5D2vdXdoCfFjRxWm
	LdIrpjulRM+x6ppntPCNzO6C261OkkEym+IZ5WPZjPGPnv1MupDlBebp5hjg==
X-Google-Smtp-Source: AGHT+IFXq1Qt7qSOR1SddnxMSiwsdgkK6jpiep4gMHSnVkr29YyR63W1kpAAGy8xRdnyaaLBauYz3Og1FfzRaiYUdpo=
X-Received: by 2002:a05:6214:11aa:b0:6e8:f2d2:f123 with SMTP id
 6a1803df08f44-6e8f2d2f16bmr12009826d6.13.1741196259853; Wed, 05 Mar 2025
 09:37:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305061134.4105762-1-yosry.ahmed@linux.dev> <20250305061134.4105762-4-yosry.ahmed@linux.dev>
In-Reply-To: <20250305061134.4105762-4-yosry.ahmed@linux.dev>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 5 Mar 2025 09:37:29 -0800
X-Gm-Features: AQ5f1JoDi9AXmdLOq8AjB7DnKNJ0e605ZNQ_mcNBTaRF1Wm_vWesyalZpAU8HPM
Message-ID: <CAKEwX=N+xxipdugTWjZcvw=hS6TmcE2f-yASq5tSm7gPNyD9jg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable 3/5] mm: zpool: Remove object mapping APIs
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 10:11=E2=80=AFPM Yosry Ahmed <yosry.ahmed@linux.dev>=
 wrote:
>
> zpool_map_handle(), zpool_unmap_handle(), and zpool_can_sleep_mapped()
> are no longer used. Remove them with the underlying driver callbacks.
>
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> ---
>  include/linux/zpool.h | 30 ---------------------
>  mm/zpool.c            | 61 -------------------------------------------
>  mm/zsmalloc.c         | 27 -------------------
>  3 files changed, 118 deletions(-)

Me see deletions, me likey. I've never liked the object mapping API anyway.

Acked-by: Nhat Pham <nphamcs@gmail.com>

