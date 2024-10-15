Return-Path: <linux-kernel+bounces-365246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650E499DF7B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06681F2334C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5762D19ABDE;
	Tue, 15 Oct 2024 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VX3eF7jQ"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CCF17DFE3
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978269; cv=none; b=lsL7fB9WfoRYGxjvcXBAk8W/a53ZTteD+v32UcorhKV4Wr8szgBg7cumfxdpQuWxAzA9fyE5w43WfBujnk65Z7v3jHX76LVnU5e73Xpv3ue6UyP0DSajoCoMKQC+Ps1GP7VOUo+tOR1VaTtC1mmVRBJrlovI/fYDUxCkWSNkjM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978269; c=relaxed/simple;
	bh=uuZDJ1wHQGYuKTu4hVfqiJ6xN6yR3uxdLWgtw5Cor8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYtYNJoM/1o7B5UOKpEhwopDjS0sAOQ+yQUS8Mp/gtLH5nAywj6+6I8kSSKjQT5UlWurhmsKLmN7x6KJVe+sUCATUor4gZtZp7nBjdtm9+XzhOozkFFSL9dIkeFGj7pFSqs/8LDXkO9vqxABJw9az3dkrzNkbNyR/UWIIGNsesc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VX3eF7jQ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2e88cb0bbso2727184a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728978266; x=1729583066; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mUEb4eLWpnTeGAtqPYAikkibKv1bdiJmI3pgHct7sNo=;
        b=VX3eF7jQo4yU3IP1vAXP8mW+lucMS7ztN3S0n+R9aNI4IZxXZPwdHV58RY3Wy5n53u
         eN2xycwgep35PR7asaDwgPRVnbApwZB0xtTmqhWvOoVoQtRdYfGb78tvrpdlstfj9Suv
         UWAm3oLjBwAMCyT+Wot8l5HsQm1KsTCpDXS5cmT+tsY6ducnPWLDiyjHuXymkbgIQEre
         eGQY8P1ms4XFrCBK5gzDAYbF6PiOi7i4KmyCqyoLgQWUCVlLYZ5221Klmb+Yo+X1u7Ew
         UVhQ2p++5xaTCX6jLv+NrtnvAWYE3famZkDvp6TiBXBPvsgdugc+gmijCD433wzzOI19
         f1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728978266; x=1729583066;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUEb4eLWpnTeGAtqPYAikkibKv1bdiJmI3pgHct7sNo=;
        b=vYpffGxrZBAITEIAo0chUytNLfsIY64t3nHPqbHICWm5AikfotjZCaGCJmtI+uguaH
         RAhEDNl6yHdzbqCPaj4hzoTNsx/qMvxJkRU+C+ZXsAMbXB81BHEdRUM7FVRG9+auMhAN
         +4zTXrUYI61djqo6k5wXODx6zhzseklN/0Ss4cU6PFGgWU0UHsO6vKQ6MytSlfNWiOaD
         Wjwz8HT70ZuodlA2bU6iklmCzBVVsoUoxOJmr84oPX2Jv8a9RvXeGzXGPjNEHbQUK1Ww
         V8jlv7oKc9633OtrTENNUy6G4eUiwneQB6kt3bX/uWQQt+023rpusg0tg5T5wyFTUYBo
         Fljw==
X-Forwarded-Encrypted: i=1; AJvYcCUQPOTL6Xuz8AZ8jVj/f+n4wvPDSx2NlLSYoCRQseEwc6GjgotDTJeL4oAMzt+Z1jTiBCI756qYWUEgSy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhv0xUarBorLV3pUa3fY83nzAjXQcmjSBkQr7MLwnwd3GYWrU+
	EEj9jinCMP3KrmWpu4qHnu17ePOgRu8WuSlhcKdweMaNZvs1V/IgNdu/EdolUtQB2CoPuZUxglJ
	4lmBAUA9TYyuHG731xhSuaa06Yq+nzpvM/y+7DCYv1fe2Mi7hjZw=
X-Google-Smtp-Source: AGHT+IE0H8cuPgYWHsKI4WdmtFf9dZiOQy1YBeNsv1pqFMvz/79qL3pUf+5Wnr3wk920VCRYK7JEgdCGb+25hj19SyI=
X-Received: by 2002:a17:90a:d382:b0:2e2:b513:fdca with SMTP id
 98e67ed59e1d1-2e2f0af1e79mr18526965a91.20.1728978266403; Tue, 15 Oct 2024
 00:44:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010114019.1734573-1-0x1207@gmail.com> <601d59f4-d554-4431-81ca-32bb02fb541f@huawei.com>
 <20241011101455.00006b35@gmail.com> <CAC_iWjL7Z6qtOkxXFRUnnOruzQsBNoKeuZ1iStgXJxTJ_P9Axw@mail.gmail.com>
 <20241011143158.00002eca@gmail.com> <21036339-3eeb-4606-9a84-d36bddba2b31@huawei.com>
 <CAC_iWjLE+R8sGYx74dZqc+XegLxvd4GGG2rQP4yY_p0DVuK-pQ@mail.gmail.com>
 <d920e23b-643d-4d35-9b1a-8b4bfa5b545f@huawei.com> <20241014143542.000028dc@gmail.com>
 <14627cec-d54a-4732-8a99-3b1b5757987d@huawei.com>
In-Reply-To: <14627cec-d54a-4732-8a99-3b1b5757987d@huawei.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 15 Oct 2024 10:43:49 +0300
Message-ID: <CAC_iWjKWjRbhfHz4CJbq-SXEd=rDJP+Go0bfLQ4pMxFNNuPXNQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1] page_pool: check for dma_sync_size earlier
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Furong Xu <0x1207@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	xfr@outlook.com
Content-Type: text/plain; charset="UTF-8"

Hi Yunsheng,

On Mon, 14 Oct 2024 at 15:39, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> On 2024/10/14 14:35, Furong Xu wrote:
> > Hi Yunsheng,
> >
> > On Sat, 12 Oct 2024 14:14:41 +0800, Yunsheng Lin <linyunsheng@huawei.com> wrote:
> >
> >> I would prefer to add a new api to do that, as it makes the semantic
> >> more obvious and may enable removing some checking in the future.
> >>
> >> And we may need to disable this 'feature' for frag relate API for now,
> >> as currently there may be multi callings to page_pool_put_netmem() for
> >> the same page, and dma_sync is only done for the last one, which means
> >> it might cause some problem for those usecases when using frag API.
> >
> > I am not an expert on page_pool.
> > So would you mind sending a new patch to add a non-dma-sync version of
> > page_pool_put_page() and CC it to me?
>
> As I have at least two patchsets pending for the net-next, which seems
> it might take a while, so it might take a while for me to send another
> new patch.
>
> Perhaps just add something like page_pool_put_page_nosync() as
> page_pool_put_full_page() does for the case of dma_sync_size being
> -1? and leave removing of extra checking as later refactoring and
> optimization.
>
> As for the frag related API like page_pool_alloc_frag() and
> page_pool_alloc(), we don't really have a corresponding free side
> API for them, instead we reuse page_pool_put_page() for the free
> side, and don't really do any dma sync unless it is the last frag
> user of the same page, see the page_pool_is_last_ref() checking in
> page_pool_put_netmem().
>
> So it might require more refactoring to support the usecase of
> this patch for frag API, for example we might need to pull the
> dma_sync operation out of __page_pool_put_page(), and put it in
> page_pool_put_netmem() so that dma_sync is also done for the
> non-last frag user too.
> Or not support it for frag API for now as stmmac driver does not
> seem to be using frag API, and put a warning to catch the case of
> misusing of the 'feature' for frag API in the 'if' checking in
> page_pool_put_netmem() before returning? something like below:
>
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -317,8 +317,10 @@ static inline void page_pool_put_netmem(struct page_pool *pool,
>          * allow registering MEM_TYPE_PAGE_POOL, but shield linker.
>          */
>  #ifdef CONFIG_PAGE_POOL
> -       if (!page_pool_is_last_ref(netmem))
> +       if (!page_pool_is_last_ref(netmem)) {
> +               /* Big comment why frag API is not support yet */
> +               DEBUG_NET_WARN_ON_ONCE(!dma_sync_size);

Ok, since we do have a page_pool_put_full_page(), adding a variant for
the nosync seems reasonable.
But can't the check above be part of that function instead of the core code?

Thanks
/Ilias
>                 return;
> +       }
>
>         page_pool_put_unrefed_netmem(pool, netmem, dma_sync_size, allow_direct);
>  #endif
>
>
> > I am so glad to test it on my device ;)
> > Thanks.
> >
> >

