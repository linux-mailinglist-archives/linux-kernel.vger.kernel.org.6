Return-Path: <linux-kernel+bounces-210632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 417AF904671
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 23:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0DE31F238CE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AEE15382E;
	Tue, 11 Jun 2024 21:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+2VhSRM"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914233A8E4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 21:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718142839; cv=none; b=n29kOxZNiIFzDGKQ+k+3vK6Dv/REmzbMbDHDmYGxdEx3BZPR8dwIY/ghd2HLJ57buwSggtp/qq/HIDWLCQ8qI41+nFrfPxrb6IwivYvPVlHxFNoEE8xQlNDIpPXhlxs70af0RKzz2XFC3XzazVEAzus/aWIK9bsgLH2omvNbMGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718142839; c=relaxed/simple;
	bh=+EQcsvXJKqutx43vXNEbqseQhjWiPnfjwaeLyKyhuXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/EpcbEtRzRRl/yUx30Swk1/pVRqm85bvXCQkhb9Ixcfc1LEFcr6xgtVr9Dx+WKfXyTtKZQLxonYaTKyNtadi414KcIdPBXtPOA/ZALIVHjG6eArzI/1il9a5HKi2SmzlRvRKufXaRBKnZsMrQP2phDOuaCQo0oPlUXDX4reYzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+2VhSRM; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7954f8b818fso96678085a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718142836; x=1718747636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5d01611+s7Xb0N0mhw0XzV1Vwp+Vhr/5Uvqz7D0Dto=;
        b=e+2VhSRMUBbYZXg/pflCS2ALYBvMNF2hm/LvVUQzD3gE4T7Ylb5bxvHUfc+j24Sf1Z
         nSujNbTR8Y50sClSpLo40KoWQJP9H1c85mA7Be3bPiLHRG6UMjP4evefEO+QovIkzJP+
         Ld57hDVTe3R/NHAA2VBkOkq8h0s8BUGawd5t3NobMKncB1L6v2o9aEzgaD5Yh0V7e2M4
         oF3p5jZFkwEK72VL+N0ukC3LSakCP1R2hrGlhJEHDpwTgZht4eb1ay3H72YQkcML8Hp2
         Li3rKhp36Zsmn/wlZHkGYDtiG8bBZuIOSppdoTwXKWysgVA+wKIU03/xCvJomsVppvqY
         2WAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718142836; x=1718747636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5d01611+s7Xb0N0mhw0XzV1Vwp+Vhr/5Uvqz7D0Dto=;
        b=SURzmS8jLYwyVFP+zBBVVPU18IVSN9wzx/Plka4vZ5kjzmBZmQWjrC52XdkqIyLrUN
         ds4In0YoRGRR73FXXUerqN1sIfYYciBKDamCzylTgnmfPVIcXt/CUAAq+Et18z4Jj+Ie
         WLRAIqBoxS9yocURYFiBp6+Ymi1CbR8qKy4DEeaLnQfcDcpKDyzQ3zVn3uH26Q/cPHQi
         IjgheRTjKqyMYfOcLUIBBz8IuJz3fMdRds+atzXgajSwhzU+mpBHAQJ8s1jMrP/hAo9V
         RwK5jnBYBCzbcQjJLCbdpZrVOjAmbKYFCh5+f5X8yLqXiclZ5h14O9/EUhFFEGc6wHCM
         SBbg==
X-Forwarded-Encrypted: i=1; AJvYcCUt2XWIECF5SaL4X/4xwn60nHzp4XqjkclarA1GTki+JQIKX2GiVm2ycGom/T2ewRfutmO8o3cNd2lMp1sC1An8kCwx3C7TQFg5gyb5
X-Gm-Message-State: AOJu0YzIJdiloMBjRC/V1sX0Xr0Vz7yT2B5Np9n2wksb68MSAdH7Jcmc
	hCDrv6yeMG46f5js3gSOOYrjrb40Q9tQdZU2l/539YH1IwSyvwVg37wq7lunRQlxqOiwTG+QA2d
	CIBBMTx6Mn56u12fjabukkScKWsU=
X-Google-Smtp-Source: AGHT+IG2isAk+u7iGcE1PquKuBa2mn/tq79TS9J3aMIhPNvA0rM0lFh/dMtC+oQv7YCsHuZmdCLiZ2Uh/ofn/7+BItc=
X-Received: by 2002:a05:6214:3186:b0:6b0:8b2d:b6e with SMTP id
 6a1803df08f44-6b08b2d3a43mr33068216d6.63.1718142836484; Tue, 11 Jun 2024
 14:53:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611024516.1375191-1-yosryahmed@google.com> <20240611024516.1375191-2-yosryahmed@google.com>
In-Reply-To: <20240611024516.1375191-2-yosryahmed@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 12 Jun 2024 09:53:45 +1200
Message-ID: <CAGsJ_4w3LDE1OuDiX_LAeTxEGUFPVOwqMxoOF+Dr55bdLUZQ7w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm: zswap: add zswap_never_enabled()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chris Li <chrisl@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 2:45=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> Add zswap_never_enabled() to skip the xarray lookup in zswap_load() if
> zswap was never enabled on the system. It is implemented using static
> branches for efficiency, as enabling zswap should be a rare event. This
> could shave some cycles off zswap_load() when CONFIG_ZSWAP is used but
> zswap is never enabled.
>
> However, the real motivation behind this patch is two-fold:
> - Incoming large folio swapin work will need to fallback to order-0
>   folios if zswap was ever enabled, because any part of the folio could
>   be in zswap, until proper handling of large folios with zswap is
>   added.
>
> - A warning and recovery attempt will be added in a following change in
>   case the above was not done incorrectly. Zswap will fail the read if
>   the folio is large and it was ever enabled.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  mm/zswap.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index a8c8dd8cfe6f5..7fcd751e847d6 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -83,6 +83,7 @@ static bool zswap_pool_reached_full;
>  static int zswap_setup(void);
>
>  /* Enable/disable zswap */
> +static DEFINE_STATIC_KEY_MAYBE(CONFIG_ZSWAP_DEFAULT_ON, zswap_ever_enabl=
ed);
>  static bool zswap_enabled =3D IS_ENABLED(CONFIG_ZSWAP_DEFAULT_ON);
>  static int zswap_enabled_param_set(const char *,
>                                    const struct kernel_param *);
> @@ -136,6 +137,11 @@ bool zswap_is_enabled(void)
>         return zswap_enabled;
>  }
>
> +static bool zswap_never_enabled(void)
> +{
> +       return !static_branch_maybe(CONFIG_ZSWAP_DEFAULT_ON, &zswap_ever_=
enabled);
> +}

Will we "extern" this one so that mm-core can use it to fallback
to small folios?
or you prefer this to be done within the coming swapin series?

> +
>  /*********************************
>  * data structures
>  **********************************/
> @@ -1557,6 +1563,9 @@ bool zswap_load(struct folio *folio)
>
>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>
> +       if (zswap_never_enabled())
> +               return false;
> +
>         /*
>          * When reading into the swapcache, invalidate our entry. The
>          * swapcache can be the authoritative owner of the page and
> @@ -1735,6 +1744,7 @@ static int zswap_setup(void)
>                         zpool_get_type(pool->zpools[0]));
>                 list_add(&pool->list, &zswap_pools);
>                 zswap_has_pool =3D true;
> +               static_branch_enable(&zswap_ever_enabled);
>         } else {
>                 pr_err("pool creation failed\n");
>                 zswap_enabled =3D false;
> --
> 2.45.2.505.gda0bf45e8d-goog
>

Thanks
Barry

