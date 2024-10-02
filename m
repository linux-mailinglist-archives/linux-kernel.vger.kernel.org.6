Return-Path: <linux-kernel+bounces-347070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C22298CD67
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9E01F232A0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 06:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E88B18EFF8;
	Wed,  2 Oct 2024 06:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t9LKI56u"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866C51411C7
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 06:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727851947; cv=none; b=i8C3vTt+00yZH6pR56KY2iW9nFt/X0qeAxYtJLriOtYWyEeZYLkFU0GOpBn4nx6SPzAn9QnS4O5f9ftWquhbCJhLagfOewlFaiNYg1e+M126MV4GMgvioDhwdG7Xa7lZgq0wVhmheC9EfcpufsGrjIfnUKBJ2tnTFcZg5Fxv4Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727851947; c=relaxed/simple;
	bh=NbxMuNV6T7+k9WLtS52Fq9ckPhCxmFmjklyi5qtHS8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WXUY7vI6Mi0pvRwBMhFMS9yLOvYo4JZrezVooOVf8mMQcrowHM2KYvpQbRO8wDwC+wWg+HSPvAiwcyM+e/OBRzgkR44thBwq2L1qd2Cvu62DaF3CZvPaLthM+NhFAkRYK46TL943mO1p+IfVvw2ELzTcRJirohSqJh/Il8mhw80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t9LKI56u; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7193010d386so5465888b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 23:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727851946; x=1728456746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wi2knaZL4xgHJFaFdtzBXqIWLSuRG81LD3CTPdMJ4G8=;
        b=t9LKI56uu2XIJLJk9ciuz7Pnztx8VHwAU3i47plfXpxNQWM4PDp+kjC/cZhL2Z3TfA
         FLu2hA/o9S6AFw27C1SrigYhTBNWqo7nUpDp+iKAljTcE1r0VUgvVEShGLTPCcTxZsPY
         R3TkZhFVesyHC0mnjblbkx50lFQpTYp+Y6QD+YU0Bog/PFlIWST9ND/sjHbYGYpApDmg
         sQgZsci7ArF7Nsq7PrWRJ786i7f099MW+TvPThJXi9MO8yXYytMAdaxPxspsLMXeo32b
         IJf6G1fhLcgXuyN6LleUJgxsJeQaKaLvKcqGyUZYlXBw4H4UYFuDEdxaXSCpgbYkdSm3
         4l/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727851946; x=1728456746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wi2knaZL4xgHJFaFdtzBXqIWLSuRG81LD3CTPdMJ4G8=;
        b=m31nu9XWbbV4U9RZtOA5VSagx+EPx6UGev8nSRskNxqYWuGuHZ2o7d3KRiNj5fMqk+
         QlpGtEnjzQ9L4lXrZIbHs89gT6IwXtwarpM46NfbiNBAYq3Yql7yF+pgjiL3ASSpforr
         oaWeXq4+XZja3h2UcqkHc7VNk7IHWBl+aSuI+FafNflWlRN79AXqMYUIFx4eF0FIE+Lt
         Y/I41ENhNA1uHUsOSfGkZirgHbFk525J9KiwNoE3W/jFC51cNHnd8Os7Jt5HRGQnkr2b
         6UBa6cg5zQwJ7PQY10chRS4VLeXFdsZhWTBIxTtw4+rImMel3FJ0EloFjh0Qv/ZI2gjG
         AWkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQypOzBK76ar/c/G4x+pvMDlNjt8TqIDtIGcxH63Jxj5GFdV24slkPqr1mHofjcettpSI+Y4dZWRopZNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8An+IeZhQXHoHK/CteKMOE/13HLclKpKPn2CO9pRO1dpS+jq7
	H5ULZTvhLHET9o1ShAVIDx7KknRnBEbbkORy5obM8ASiX024wwMO1kJN6Nrwdhj+PTTxNRKmz5y
	T8CiH1iJM2gAK7esDKOe2BKwvql2QHRnsFezfCQ==
X-Google-Smtp-Source: AGHT+IHsypqnvHxqefjiDxYFDz2akYzDsFoGU6PLh+7312onUDhEMOGndUNDmbbTnJmbGIeOeR17h1E7o2px85taLvw=
X-Received: by 2002:a05:6a21:2d8b:b0:1d5:10c3:af5a with SMTP id
 adf61e73a8af0-1d5e2d3df25mr3361839637.47.1727851945585; Tue, 01 Oct 2024
 23:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
 <20240925075707.3970187-3-linyunsheng@huawei.com> <4968c2ec-5584-4a98-9782-143605117315@redhat.com>
 <CAC_iWjKHofqDrp+jOO_QTp_8Op=KeE_jjhjsDUxjRa4vnHYJmQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKHofqDrp+jOO_QTp_8Op=KeE_jjhjsDUxjRa4vnHYJmQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 2 Oct 2024 09:51:49 +0300
Message-ID: <CAC_iWjJXWgt9TdBSYGkc=htyeS=VAago5wqXzBgX_Mun76Z42g@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] page_pool: fix IOMMU crash when driver has
 already unbound
To: Paolo Abeni <pabeni@redhat.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, kuba@kernel.org, 
	liuyonglong@huawei.com, fanghaiqing@huawei.com, zhangkun09@huawei.com, 
	Robin Murphy <robin.murphy@arm.com>, Alexander Duyck <alexander.duyck@gmail.com>, 
	IOMMU <iommu@lists.linux.dev>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
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

On Wed, 2 Oct 2024 at 09:46, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Paolo,
>
> Thanks for taking the time.
>
> On Tue, 1 Oct 2024 at 16:32, Paolo Abeni <pabeni@redhat.com> wrote:
> >
> > On 9/25/24 09:57, Yunsheng Lin wrote:
> > > Networking driver with page_pool support may hand over page
> > > still with dma mapping to network stack and try to reuse that
> > > page after network stack is done with it and passes it back
> > > to page_pool to avoid the penalty of dma mapping/unmapping.
> > > With all the caching in the network stack, some pages may be
> > > held in the network stack without returning to the page_pool
> > > soon enough, and with VF disable causing the driver unbound,
> > > the page_pool does not stop the driver from doing it's
> > > unbounding work, instead page_pool uses workqueue to check
> > > if there is some pages coming back from the network stack
> > > periodically, if there is any, it will do the dma unmmapping
> > > related cleanup work.
> > >
> > > As mentioned in [1], attempting DMA unmaps after the driver
> > > has already unbound may leak resources or at worst corrupt
> > > memory. Fundamentally, the page pool code cannot allow DMA
> > > mappings to outlive the driver they belong to.
> > >
> > > Currently it seems there are at least two cases that the page
> > > is not released fast enough causing dma unmmapping done after
> > > driver has already unbound:
> > > 1. ipv4 packet defragmentation timeout: this seems to cause
> > >     delay up to 30 secs.
> > > 2. skb_defer_free_flush(): this may cause infinite delay if
> > >     there is no triggering for net_rx_action().
> > >
> > > In order not to do the dma unmmapping after driver has already
> > > unbound and stall the unloading of the networking driver, add
> > > the pool->items array to record all the pages including the ones
> > > which are handed over to network stack, so the page_pool can
> > > do the dma unmmapping for those pages when page_pool_destroy()
> > > is called. As the pool->items need to be large enough to avoid
> > > performance degradation, add a 'item_full' stat to indicate the
> > > allocation failure due to unavailability of pool->items.
> >
> > This looks really invasive, with room for potentially large performance
> > regressions or worse. At very least it does not look suitable for net.
>
> Perhaps, and you are right we need to measure performance before
> pulling it but...
>
> >
> > Is the problem only tied to VFs drivers? It's a pity all the page_pool
> > users will have to pay a bill for it...
>
> It's not. The problem happens when an SKB has been scheduled for
> recycling and has already been mapped via page_pool. If the driver
> disappears in the meantime,

Apologies, this wasn't correct. It's the device that has to disappear
not the driver

> page_pool will free all the packets it
> holds in its private rings (both slow and fast), but is not in control
> of the SKB anymore. So any packets coming back for recycling *after*
> that point cannot unmap memory properly.
>
> As discussed this can either lead to memory corruption and resource
> leaking, or worse as seen in the bug report panics. I am fine with
> this going into -next, but it really is a bugfix, although I am not
> 100% sure that the Fixes: tag in the current patch is correct.
>
> Thanks
> /Ilias
> >
> > /P
> >

