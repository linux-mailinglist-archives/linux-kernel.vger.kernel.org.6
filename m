Return-Path: <linux-kernel+bounces-341587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FF3988218
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 884C7B2154D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DCE1BBBDA;
	Fri, 27 Sep 2024 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yf7rDCDK"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D4F1BBBC0
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727431174; cv=none; b=SdjQmky/J7lGOXiqTDMdoJuB0NJLBO1/vLJt+H9V5FbccEm2p9xIGzAJBkBKI7APk7cejFuHngn+hfwiGZ+W4jJqGrPlHHYkpc+ys4N8K4Fcj4/gfds1rgUHFnx66Dj1zSJojFo8gK8rX6bCTRqtMBDpM1E+5NbEIYEhwf10WJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727431174; c=relaxed/simple;
	bh=/wFHvQrnJe6+I0Hk404NsRdbI8eFHq8tb62kLJdsI/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZmSAIYoU72Z9GqVdMHDqT/IFm6rdNivvKCjOVYFWZvxW2cH8UG3cLFmMWaoMr8EK3hA+jGaDWtTbHkrgGleaXUy6cdiYM75X5VZwC41lb1uGl9AEIPyBVZZYHqwHhYEJjMBYP3eIs9ScLOghNWgSni8XHNYaUZPLmQa+pQdyUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yf7rDCDK; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7e6b738acd5so911180a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 02:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727431172; x=1728035972; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/wFHvQrnJe6+I0Hk404NsRdbI8eFHq8tb62kLJdsI/o=;
        b=yf7rDCDKkef/ZmyjQ5fE/iIG8XGaSNtqpivi4oLPR8OmeUcNvceksxMvn/JqgBWjku
         07QMX+A1BPUYrSEDdYetiw28hsxTf1+8LSzQ42Q2f6b1M5TwqV551ASk2Qma6qnupGty
         o00+WNOZxNl7qMYDC/xV2EZMfMSJEGSK8BdX2hAHbmRCqJmZUOrsexyHEs80Pz4S+ltM
         yjkuYoQ0HhDxQkGb9iBzkOJ0VnSB2J4lwzHmgbPmWZ9vPAU6G648bW4kkHWCCFUGLej3
         E92hwCJURVmMzGh+epzRcciNN8A4oNiHF558O29J/Tkhqv8qFZINud6Q78rNZeGbbRQ/
         TxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727431172; x=1728035972;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wFHvQrnJe6+I0Hk404NsRdbI8eFHq8tb62kLJdsI/o=;
        b=cWO7Dwk52t+g/hAj8E1AsjmAT1VT3AzIlQetUP4tNVG7mjmJHdvORwV5XaV9Wttw1J
         CPjsPFCBFsdS76EWExiRC6HS8yiB6Hr1fDP1q32Ypv0zt6BTDA7tZPtl2b/E2Iq7oxaM
         kRPrvSOZQ5sZaABqPXB3y/xoS7VtWnxBycAKxqHyMGQZ/6qGkZQnPmk5DpTQc6hzwURt
         ZteS2kUdv8Wu1Tu7UtxxVEwW7GGwykt9p5ZjIKrqOm8e7x7lrwXc49m61wbpZrVW7hAF
         jEqvWBD8HslK8yJdGm/qWDzv9BEsU4U1/OrOAofnB12KYWRNdNv112Bje9dea86TdcTb
         cJuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSbjQRebbOlF+uF/tt/QWnnAxkW/F7ahNekKlGQkeMSj4Y1dh2jivpauzJJWLgqWtwopcE9eToO7jPaYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjaq1wvOxxA0v/foClyc6wMnJLMOd1DhqqiLCRW5CllCv11gI9
	x0GZwJmlHeZi0QSG1AsRVe0c7zTP5JK6UvptMOoLVEYYah6gjy/oUclP5JX9vqlGGrhqjRwRTC/
	V66YTyR86nIrQz8Oy1Nu7qZVD+t1gVIhZ0m17Jw==
X-Google-Smtp-Source: AGHT+IFPw7TdHI7xAVBejSYDuXRNyLLxKTG1ESrzw48y3A/pOuf25zX23NWOfeE/8MxH7DAW+JoIMvACw7ATICsO3w0=
X-Received: by 2002:a05:6a20:6f03:b0:1cf:23cb:b927 with SMTP id
 adf61e73a8af0-1d4fa7a6f8emr3754825637.34.1727431171797; Fri, 27 Sep 2024
 02:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
 <20240925075707.3970187-3-linyunsheng@huawei.com> <CAHS8izOxugzWJDTc-4CWqaKABTj=J4OHs=Lcb=SE9r8gX0J+yg@mail.gmail.com>
 <842c8cc6-f716-437a-bc98-70bc26d6fd38@huawei.com> <CAC_iWjLgNOtsbhqrhvvEz2C3S668qB8KatL_W+tPHMSkDrNS=w@mail.gmail.com>
 <0ef315df-e8e9-41e8-9ba8-dcb69492c616@huawei.com>
In-Reply-To: <0ef315df-e8e9-41e8-9ba8-dcb69492c616@huawei.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 27 Sep 2024 12:58:55 +0300
Message-ID: <CAC_iWjKeajwn3otjdEekE6VDLHGEvqmnQRwpN5R3yHj8UpEiDw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] page_pool: fix IOMMU crash when driver has
 already unbound
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Mina Almasry <almasrymina@google.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, liuyonglong@huawei.com, fanghaiqing@huawei.com, 
	zhangkun09@huawei.com, Robin Murphy <robin.murphy@arm.com>, 
	Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, 
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, Eric Dumazet <edumazet@google.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>, imx@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Sept 2024 at 12:50, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> On 2024/9/27 17:21, Ilias Apalodimas wrote:
> > Hi Yunsheng
> >
> > On Fri, 27 Sept 2024 at 06:58, Yunsheng Lin <linyunsheng@huawei.com> wrote:
> >>
> >> On 2024/9/27 2:15, Mina Almasry wrote:
> >>>
> >>>> In order not to do the dma unmmapping after driver has already
> >>>> unbound and stall the unloading of the networking driver, add
> >>>> the pool->items array to record all the pages including the ones
> >>>> which are handed over to network stack, so the page_pool can
> >>>> do the dma unmmapping for those pages when page_pool_destroy()
> >>>> is called.
> >>>
> >>> One thing I could not understand from looking at the code: if the
> >>> items array is in the struct page_pool, why do you need to modify the
> >>> page_pool entry in the struct page and in the struct net_iov? I think
> >>> the code could be made much simpler if you can remove these changes,
> >>> and you wouldn't need to modify the public api of the page_pool.
> >>
> >> As mentioned in [1]:
> >> "There is no space in 'struct page' to track the inflight pages, so
> >> 'pp' in 'struct page' is renamed to 'pp_item' to enable the tracking
> >> of inflight page"
> >
> > I have the same feeling as Mina here. First of all, we do have an
> > unsigned long in struct page we use for padding IIRC. More
>
> I am assuming you are referring to '_pp_mapping_pad' in 'struct page',
> unfortunately the field might be used when a page is mmap'ed to user
> space as my understanding.
>

Ah good point, I just grepped for it and didn't look at the surrounding unions.

> https://elixir.bootlin.com/linux/v6.7-rc8/source/include/linux/mm_types.h#L126
>
> > importantly, though, why does struct page need to know about this?
> > Can't we have the same information in page pool?
> > When the driver allocates pages it does via page_pool_dev_alloc_XXXXX
> > or something similar. Cant we do what you suggest here ? IOW when we
> > allocate a page we put it in a list, and when that page returns to
> > page_pool (and it's mapped) we remove it.
>
> Yes, that is the basic idea, but the important part is how to do that
> with less performance impact.

Yes, but do you think that keeping that list of allocated pages in
struct page_pool will end up being more costly somehow compared to
struct page?

Thanks
/Ilias

