Return-Path: <linux-kernel+bounces-365884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840D899ED73
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCEA4B22EF3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E660D1C4A3B;
	Tue, 15 Oct 2024 13:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c2TXlRo1"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B3D1C4A36
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998790; cv=none; b=sIECGZ5v/Po/OlUsZlXwmMI5DH0bdvLvDxMdHhqdlHbFFcBEAybKCHi2X4UiiyQHVovdsUk0J59ITbnmWSuyBfZW7cS/A50WqXpgvpAZ/EHSzBR+en9wVu91JMPFGcJ2lUM6tBjx9BqG/4IPn5JUMbeUNwAmS351kImDrE6RTrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998790; c=relaxed/simple;
	bh=OL59YxyGuA494Wfw38yvK0hm/yLF6VVSmMi4N4v67js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6ZpvW879hwHNzwU6Mybj7d0wZk9Ubch/NwGD+3c9zKMIC8AsWUDbwRU1PMhhx80x5geAzekI0hN0o7/F7LB9BSZNDY0OLIXA9sZEssh+1OKUOAOv3t3cqzGLrzJn7kCAw4ia2kGUuiBXYd8IkhjBRwP+KaXov9uNovEn+UCkcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c2TXlRo1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cbcd71012so29346935ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 06:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728998788; x=1729603588; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gn7YXVR2lRLUfWbvrEqfSP4ATfs9xGerpp/s7n0TqQI=;
        b=c2TXlRo1yE7UddezN8KNdGtkoZkDyg0M9iH8pcPpqgTP5CwIvAR4nRCaGShtrvipRw
         fLvFqyXMOMb0LSclDpNcxTF5XgHfRKW+6I4lT2QSNtjwbvCnjHAWO0KzQEq6fCsrIudN
         Sj4i6hFOFOfltAa3RiIiHyI3oZVAVBk0gv569VY9AUlspe+1l9viNfptjIUqGtl9oP3S
         ArsxteRQG1tB8bMotLCCo6qmVm4EqIFewf7KHjRBzsluRXJfzRvZ6Lgp8D9PUBuETvSA
         5ZiHiuksC4dCevMRQYqZ+7n5/w1hOUs85Rof2RML0DoE2TKNux+aoSS6zZCOgrVmaR47
         Mx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728998788; x=1729603588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gn7YXVR2lRLUfWbvrEqfSP4ATfs9xGerpp/s7n0TqQI=;
        b=FFESiElyccraublKQW8fKCsuAeoV2v/sHxaqdAIUP7fyTpApZVB7rN/IAHKanSLA0z
         CLaKxJ2Wn/cGtAkojsiGReoPwFV/yDvA4bmkjXPwq4a+SxsZ1jogHeu8XiTJ3z8BT5lo
         B4HCozDrQtCxKf0/42lsKpT3U7Xqqu8DXivSJp9CgQhaoOpjSz4wX1a4XRlNjt5M0vxZ
         phQ7aTsZBsbmdA0nBfzrfGKpJ/8DAuHYxrf8hW3nS4uMIpeyeJNuJupiCJ+sHPuzh3Bp
         /7erNHSTIvuwk1eDG265vVGyzLLZZ+J3clonVISlgQrPZc2rJ3U7Ga8EqVcR+wJGxZlw
         EFng==
X-Forwarded-Encrypted: i=1; AJvYcCXsg0pzgFkfTGmoabn45fsEhjyF1l3CFEX5QEXbXpBkOMytpe2alyZ98Rjso88qYgq/IxjVHADtey5wY+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz9jbPU4n5ar9UF6p1rgaf+4Wsm9DvA0xGaWXerwUuaNNcX3NJ
	0bZfJ57TqYIRD/73mGNDIZPlFJL62BaXtDwKnYaZ+syXEmAHCjBjDbklkGHQ9ni04Phzb0NciBV
	Q0q4+VDIIiHX7R12FG3FR4Ioj99j2CkDQeki1zgRkmqPIJ784r5E=
X-Google-Smtp-Source: AGHT+IF1Vsr1NyD0DsCZ8nNKKC+tM5iar25bAiL29IU7deOi4hzpMNWOWx5caCqI2G8PEjD50AbSWqksNuv9NOZM26M=
X-Received: by 2002:a17:903:1c4:b0:20c:7c09:b2a4 with SMTP id
 d9443c01a7336-20cbb2a0b7cmr189290585ad.50.1728998787904; Tue, 15 Oct 2024
 06:26:27 -0700 (PDT)
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
 <14627cec-d54a-4732-8a99-3b1b5757987d@huawei.com> <CAC_iWjKWjRbhfHz4CJbq-SXEd=rDJP+Go0bfLQ4pMxFNNuPXNQ@mail.gmail.com>
 <625cdab0-7348-41a1-b07f-6e5fe7962eec@huawei.com>
In-Reply-To: <625cdab0-7348-41a1-b07f-6e5fe7962eec@huawei.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 15 Oct 2024 16:25:51 +0300
Message-ID: <CAC_iWjKr7ZBmYT+pp-hWRGWJfWiC5TmzEDPtkorqiL9WQOHtJQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1] page_pool: check for dma_sync_size earlier
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Furong Xu <0x1207@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	xfr@outlook.com
Content-Type: text/plain; charset="UTF-8"

Apologies for the noise. The last message was not clear text...


On Tue, 15 Oct 2024 at 14:06, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> On 2024/10/15 15:43, Ilias Apalodimas wrote:
> > Hi Yunsheng,
> >
> > On Mon, 14 Oct 2024 at 15:39, Yunsheng Lin <linyunsheng@huawei.com> wrote:
> >>
> >> On 2024/10/14 14:35, Furong Xu wrote:
> >>> Hi Yunsheng,
> >>>
> >>> On Sat, 12 Oct 2024 14:14:41 +0800, Yunsheng Lin <linyunsheng@huawei.com> wrote:
> >>>
> >>>> I would prefer to add a new api to do that, as it makes the semantic
> >>>> more obvious and may enable removing some checking in the future.
> >>>>
> >>>> And we may need to disable this 'feature' for frag relate API for now,
> >>>> as currently there may be multi callings to page_pool_put_netmem() for
> >>>> the same page, and dma_sync is only done for the last one, which means
> >>>> it might cause some problem for those usecases when using frag API.
> >>>
> >>> I am not an expert on page_pool.
> >>> So would you mind sending a new patch to add a non-dma-sync version of
> >>> page_pool_put_page() and CC it to me?
> >>
> >> As I have at least two patchsets pending for the net-next, which seems
> >> it might take a while, so it might take a while for me to send another
> >> new patch.
> >>
> >> Perhaps just add something like page_pool_put_page_nosync() as
> >> page_pool_put_full_page() does for the case of dma_sync_size being
> >> -1? and leave removing of extra checking as later refactoring and
> >> optimization.
> >>
> >> As for the frag related API like page_pool_alloc_frag() and
> >> page_pool_alloc(), we don't really have a corresponding free side
> >> API for them, instead we reuse page_pool_put_page() for the free
> >> side, and don't really do any dma sync unless it is the last frag
> >> user of the same page, see the page_pool_is_last_ref() checking in
> >> page_pool_put_netmem().
> >>
> >> So it might require more refactoring to support the usecase of
> >> this patch for frag API, for example we might need to pull the
> >> dma_sync operation out of __page_pool_put_page(), and put it in
> >> page_pool_put_netmem() so that dma_sync is also done for the
> >> non-last frag user too.
> >> Or not support it for frag API for now as stmmac driver does not
> >> seem to be using frag API, and put a warning to catch the case of
> >> misusing of the 'feature' for frag API in the 'if' checking in
> >> page_pool_put_netmem() before returning? something like below:
> >>
> >> --- a/include/net/page_pool/helpers.h
> >> +++ b/include/net/page_pool/helpers.h
> >> @@ -317,8 +317,10 @@ static inline void page_pool_put_netmem(struct page_pool *pool,
> >>          * allow registering MEM_TYPE_PAGE_POOL, but shield linker.
> >>          */
> >>  #ifdef CONFIG_PAGE_POOL
> >> -       if (!page_pool_is_last_ref(netmem))
> >> +       if (!page_pool_is_last_ref(netmem)) {
> >> +               /* Big comment why frag API is not support yet */
> >> +               DEBUG_NET_WARN_ON_ONCE(!dma_sync_size);
>
> Note, the above checking is not 100% reliable, as which frag user
> is the last one depending on runtime execution.

I am not sure I understand the problem here. If we are about to call
page_pool_return_page() we don't care what happens to that page.
If we end up calling __page_pool_put_page() it's the *callers* job now
to sync the page now once all fragments are released. So why is this
different from syncing an entire page?

>
> >
> > Ok, since we do have a page_pool_put_full_page(), adding a variant for
> > the nosync seems reasonable.
> > But can't the check above be part of that function instead of the core code?
>
> I was thinking about something like below mirroring page_pool_put_full_page()
> for simplicity:
> static inline void page_pool_put_page_nosync(struct page_pool *pool,
>                                              struct page *page, bool allow_direct)
> {
>         page_pool_put_netmem(pool, page_to_netmem(page), 0, allow_direct);
> }
>

Yes, that's ok. But the question was about moving the !dma_sync_size warning.
On second thought I think it's better if we leave it on the core code.
But as I said above I am not sure why we need it.

Thanks
/Ilias
> And do the dma_sync_size checking as this patch does in
> page_pool_dma_sync_for_device().

