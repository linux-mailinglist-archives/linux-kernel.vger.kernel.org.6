Return-Path: <linux-kernel+bounces-209066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C307902C91
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 01:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1F5282C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C306C152503;
	Mon, 10 Jun 2024 23:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d8UGfc7m"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EB82110F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 23:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718062916; cv=none; b=Dw8/1hGhZQcODA4+73HKRm4ByAIeoufdOEAsZaF56nrBuv0nAevnRNFAnT7f26Rod3bENSCpqqInrpP0RVUgX0Wq/Q0T2lkv2S3YA6EW/HMgdfjw0mNK0N1I0XdmdxBpVApjj6ae7RAgALroj5CdpD5F6PRi2G37defUNZVJOaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718062916; c=relaxed/simple;
	bh=abF3cAOdvE/GajhbEj/nLCZX49MHrxy2usW6AxPF+Js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxXpjHhhL6fwTn0clkpZoQQatKnEvedgGVriZc16YRnptAFh4OK2goA/I5ZM5QHZRuS+cPFdtjNnL+CTmvfgbeolAjA5RqKOV3sXaDr0AScFk8GC0MgmmJAbNlyE2z2gN31t7P6O8OYtjWdtD3t+YmzDf0ymdj0JqqoceDlddJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d8UGfc7m; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4217f2e3450so21105635e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718062912; x=1718667712; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N+xf+4Khhvj0iiqw7ZQoHFoAsSE9YYEcKJ2hjHteuYs=;
        b=d8UGfc7mqExhRQnGFOiBJNFW1wwm5eRewGBPwU/aoGj3YbbGxn2PBoZDjcmOHkWdzb
         RkYrtqcOF93IjOdF0veuSZxCm5iO4VFfyPRtR/F/VBE2+/JX6cuwOjE5t56MKvZf522s
         lvf7uOD6ySeAX4oYs6aDcKeOokc+/V2G65Q+nKTIKFlKdA8yQ+5PB11TDcJEJB5Yo9Xz
         xuqSJCGFMj9NrgWkkuTcRdRWznBWsIiERTb8Xr+poBPrtCvHVCqGzGil8tmaGw8odKVe
         zy+GCvKsUfO4IjbfRLaZuWDvow3NR+crAmwh06Yt7qOH8l90BTfVlmyBlhYSl717kbCt
         ZMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718062912; x=1718667712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N+xf+4Khhvj0iiqw7ZQoHFoAsSE9YYEcKJ2hjHteuYs=;
        b=YZOBXvGy17B1C19TpLvcjwmTHc9QI9SFAehI4aeBUHTXK0P0bXoMXQuIjIiXRCov4U
         VEGJJLVOVnSQrI+wy9zuaJfNgGnGvmPF9a8S+G8ckPYmJlHZ8LDALVFLdENheLMSVW6f
         jcJQHR6MxjPWgAS0C5ydvvkRnQV0MbBL7DDrdNczWihbTjpglRlJ5WhPb7Metk/+xxUY
         Rlm60SuyPYq2XUHk4mzklvTeZxmZpI4yxjrj12hE9oQCw1N3xmkFwEp0ywfM8LNFx1a5
         I4PW5TY3JLckXZ+2zdMPTp67JfCx5kpHzmlSXYNJwzhCuXJD4JN0kSwcx530xqqp98hn
         2KCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnqdksKmOjS4/VOzaMOwhxuO7p6z0+sWG4F8R2lDWNjUUhv7ATp0+kgryS6vUVIlrnEkTJso9+tIufMuUk9W68kdKoqj30u/jb/u6A
X-Gm-Message-State: AOJu0Yz/KLh0bvdyUk1tifoVAplo9jYBJipZvgSlGvMZWJ98rVFOsAPm
	/WbinBBlY/yQQrwhxYRvRWuxcl4MoMsMLeKYYpTbuWFdO5fNWjGgp40EkeoetpYyotqb4QCnKXB
	tDkSNQ/DcXE3c8VP5BuQfGpsZuBxPlMrMyElA
X-Google-Smtp-Source: AGHT+IGuQ2C1AkI2NSp2wA2voG3exUpdcpEnl+lgNqHk58wly44D2kvuQj0BFwg41Kqp5d9FWtxk7pJMCVXCilt7PvE=
X-Received: by 2002:a05:600c:154d:b0:421:54d0:5123 with SMTP id
 5b1f17b1804b1-42164a44574mr118161115e9.34.1718062912299; Mon, 10 Jun 2024
 16:41:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608023654.3513385-1-yosryahmed@google.com>
 <CAGsJ_4yVmDKtcKKAdjPOkOMWB+=ZT5TrrWz188xJaTV4EpM1Bw@mail.gmail.com>
 <CAJD7tkaHLVcjUgiUFfBK+ztCqxBTRfyVbSVH9vytK=5JYOw+Sw@mail.gmail.com>
 <CAGsJ_4w-magFysq4uLBm46AzHLD+r=v6pJphwmQn+OFvECHjrA@mail.gmail.com>
 <CAJD7tkYdq533Z7nubjFT5jQYuS4oq2u15RAz2oGHGxYSk5Oicg@mail.gmail.com>
 <CAGsJ_4zNxC5u088RRnKeM18skEJvwTd22mB_FWSA67K3S-CKPw@mail.gmail.com>
 <CAJD7tkb0Rv4mSPS3DXqF888iVwd++nd99N3WrZYuJhLPDN+dhA@mail.gmail.com> <CAGsJ_4ztBavP+ic15V1F0-KUhoE1zh08xuOZ3jMMfuHu=JHNEw@mail.gmail.com>
In-Reply-To: <CAGsJ_4ztBavP+ic15V1F0-KUhoE1zh08xuOZ3jMMfuHu=JHNEw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 10 Jun 2024 16:41:14 -0700
Message-ID: <CAJD7tka2e1tG6vxU2XXKrzZBUBAc1EfcvaLU+yhQbzZO2gh0=g@mail.gmail.com>
Subject: Re: [PATCH v2] mm: zswap: handle incorrect attempts to load of large folios
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[..]
> > > > We can't always WARN_ON for large folios, as this will fire even if
> > > > zswap was never enabled. The alternative is tracking whether zswap was
> > > > ever enabled, and checking that instead of checking if any part of the
> > > > folio is in zswap.
> > > >
> > > > Basically replacing xa_find(..) with zswap_was_enabled(..) or something.
> > >
> > > My point is that mm core should always fallback
> > >
> > > if (zswap_was_or_is_enabled())
> > >      goto fallback;
> > >
> > > till zswap fixes the issue. This is the only way to enable large folios swap-in
> > > development before we fix zswap.
> >
> > I agree with this, I just want an extra fallback in zswap itself in
> > case something was missed during large folio swapin development (which
> > can evidently happen).
>
> yes. then i feel we only need to warn_on the case mm-core fails to fallback.
>
> I mean, only WARN_ON  is_zswap_ever_enabled&&large folio. there is no
> need to do more. Before zswap brings up the large folio support, mm-core
> will need is_zswap_ever_enabled() to do fallback.

I don't have a problem with doing it this way instead of checking if
any part of the folio is in zswap. Such a check may be needed for core
MM to fallback to order-0 anyway, as we discussed. But I'd rather have
this as a static key since it will never be changed.

Also, I still prefer we do not mark the folio as uptodate in this
case. It is one extra line of code to propagate the kernel warning to
userspace as well and make it much more noticeable.


>
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> index 2a85b941db97..035e51ed89c4 100644
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -36,6 +36,7 @@ void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
>  void zswap_lruvec_state_init(struct lruvec *lruvec);
>  void zswap_folio_swapin(struct folio *folio);
>  bool is_zswap_enabled(void);
> +bool is_zswap_ever_enabled(void);
>  #else
>
>  struct zswap_lruvec_state {};
> @@ -65,6 +66,10 @@ static inline bool is_zswap_enabled(void)
>         return false;
>  }
>
> +static inline bool is_zswap_ever_enabled(void)
> +{
> +       return false;
> +}
>  #endif
>
>  #endif /* _LINUX_ZSWAP_H */
> diff --git a/mm/zswap.c b/mm/zswap.c
> index b9b35ef86d9b..bf2da5d37e47 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -86,6 +86,9 @@ static int zswap_setup(void);
>  static bool zswap_enabled = IS_ENABLED(CONFIG_ZSWAP_DEFAULT_ON);
>  static int zswap_enabled_param_set(const char *,
>                                    const struct kernel_param *);
> +
> +static bool zswap_ever_enable;
> +
>  static const struct kernel_param_ops zswap_enabled_param_ops = {
>         .set =          zswap_enabled_param_set,
>         .get =          param_get_bool,
> @@ -136,6 +139,11 @@ bool is_zswap_enabled(void)
>         return zswap_enabled;
>  }
>
> +bool is_zswap_ever_enabled(void)
> +{
> +       return zswap_enabled || zswap_ever_enabled;
> +}
> +
>  /*********************************
>  * data structures
>  **********************************/
> @@ -1734,6 +1742,7 @@ static int zswap_setup(void)
>                 pr_info("loaded using pool %s/%s\n", pool->tfm_name,
>                         zpool_get_type(pool->zpools[0]));
>                 list_add(&pool->list, &zswap_pools);
> +               zswap_ever_enabled = true;
>                 zswap_has_pool = true;
>         } else {
>                 pr_err("pool creation failed\n");
>
> Thanks
> Barry

