Return-Path: <linux-kernel+bounces-367273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D4A9A0063
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4273B24494
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8A6189B9F;
	Wed, 16 Oct 2024 04:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FO4z3HSJ"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDB91885BB
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 04:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729054655; cv=none; b=rZ1oOzQsZ5pfC7uhMGebL0OVLJsTJXs884xV+dKy0LI+BTAyeh9jKo+PEAuQjjZjfEr9jIu3bt7bZDBLBOSSI3O+xm70vq5JsN12DLJNCBWK+db/4nGrLWA1BpUsPBCfcUd+XRfuph903DQxtnC9LZUxlLVO1tQFoxCUmTmUAk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729054655; c=relaxed/simple;
	bh=AVP1RfT9txKDO8nNgMJXWw2Ulp1YRLyNDJUgwUF5ol0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXVTJwsjX89b1q/ZXFwmPdwaS3zx7/ZcTN7ysEoM3eKIryHDqaetdxJREGJRvyMvYNtUJeJPeV3EeZfJWLjO08dxECeH6WWWtEic89fZezU4Uy7SsKHh1zVEJMrwkWS8PznjD4UX8Gvs20gsXt4WHGknAqYyCGmTVrXEbZPO2yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FO4z3HSJ; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-84fcfe29e09so1789511241.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729054653; x=1729659453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vU4qjeo8nOa6YMk+qiXCTLI5pZ4+2YEJYeF56gJAK9c=;
        b=FO4z3HSJJ+NAxtWOhcdusK4ETHfCO1gLSb8hdCKBDCG2xJZn+wQvH1l5d0OBp6MAHg
         bR9OhosPPjOhZN3A0nLOUiWtaSp9vhDX6W6CWwuOCmYTgPNfY8lBrRHbPGJQWzRmA1my
         m1XRtfdj1GxQ+wIEx4276tJbGYM9YHqh5ci3h9r0z2nCjtxmI0Bszw4++CWoXKwuv/a3
         FCjoJJqpSEnjHBhwjz/zAPQiBBhe77QnS5H3bbN9ZfJb2V2UU37CXa820Rxzavtdle2K
         xEd2Pk72FVoNfG+p7PkRaafO3bCj1WD2r1MNEl8Sy+yeGyn4PDLJxtbFu8yg+xW+NwxX
         DCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729054653; x=1729659453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vU4qjeo8nOa6YMk+qiXCTLI5pZ4+2YEJYeF56gJAK9c=;
        b=BVMCxc9n0XxL/yfpJJZpLoTWC+iJ7Mz1zb93yTT6pTfU/IcHvuTTZhPeJBtL3s9a7l
         UfCfb71OqExSf/pbnTwOxsTfxFyKzb4iYl7j4amUQGhMjMEC3yD9Qigii8imiOlE1rvt
         2OlBSif9kTCK1t3nPVZFQg2IQwjQauupaqGHgPGOStYq8VLEBO5Ulux1h5PXmAUt1d2w
         rzS2+hpaDiPpVMQcfEXhoCOPZKpAqGAuVFEGUu8mEpj44VZEPr955IiS+63A/M95SOgE
         9wJREDpuGAjgUNtbbw5rQcCchf9cAFWR2pPgWO9tdSTGcy3F3PxAP32Q8gJypuaiFv0R
         Fqbw==
X-Forwarded-Encrypted: i=1; AJvYcCW/r3Hu/rGChwFdTiM51t3H0yBOFWSsCZHZtx15jfY9RkOc2X61W62hUTBUKPzjkwFFoi3DMnwejbTHScY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi6jUHFW6RJMV0LUOJhV7E/joxP29ScXesdT2CS4Qk9+VHR9vd
	Zq9JEO8+jvX5u5pJJykkPvOFYKMIl4l0EqDOkMQq1isVTHIZ5t8wyl67XHo7pTTjhHdzeV8OZ89
	ocM+Pb/jcFRwUsCpzzlr0pDTr7KTBJwKzQ4aF
X-Google-Smtp-Source: AGHT+IHMy8fRwC65EG2pqht5x6EMu4hfjHzbFfFB6UJ9MtCEo/SHqcxsyUXhSzYDiQ5LzZxMT6VNeDeWsGcu3Z8UDjA=
X-Received: by 2002:a05:6102:950:b0:4a4:9363:b84c with SMTP id
 ada2fe7eead31-4a49363da7emr8108794137.6.1729054652793; Tue, 15 Oct 2024
 21:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014221211.832591-1-weixugc@google.com>
In-Reply-To: <20241014221211.832591-1-weixugc@google.com>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 15 Oct 2024 22:56:56 -0600
Message-ID: <CAOUHufZcmS-RCBf7dY5C5HYXp16GZC0WiaNPugfgTA0XXjMVgQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/mglru: only clear kswapd_failures if reclaimable
To: Wei Xu <weixugc@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 4:12=E2=80=AFPM Wei Xu <weixugc@google.com> wrote:
>
> lru_gen_shrink_node() unconditionally clears kswapd_failures, which
> can prevent kswapd from sleeping and cause 100% kswapd cpu usage even
> when kswapd repeatedly fails to make progress in reclaim.
>
> Only clear kswap_failures in lru_gen_shrink_node() if reclaim makes
> some progress, similar to shrink_node().
>
> Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
> Signed-off-by: Wei Xu <weixugc@google.com>
> ---
>  mm/vmscan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 50dc06d55b1d..9d1e1c4e383d 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4970,8 +4970,8 @@ static void lru_gen_shrink_node(struct pglist_data =
*pgdat, struct scan_control *
>
>         blk_finish_plug(&plug);
>  done:

Nit: the "done:" isn't used anymore, so better just remove it.

> -       /* kswapd should never fail */
> -       pgdat->kswapd_failures =3D 0;
> +       if (sc->nr_reclaimed > reclaimed)
> +               pgdat->kswapd_failures =3D 0;
>  }
>
>  /***********************************************************************=
*******
> --
> 2.47.0.rc1.288.g06298d1525-goog
>
>

