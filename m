Return-Path: <linux-kernel+bounces-347156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CB898CEB6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D5F285600
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3704195809;
	Wed,  2 Oct 2024 08:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hk4K+BHc"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4F61946B8
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727857441; cv=none; b=VwB2Cx8BA/TeIoU9T7DnuW/15DjsjncDAznVxnVNlUU2wy9wstWLyCIjdxAFQu5FnYIXdqj18Da1Q0LHVKpEGv4rkY3Yirzrb4LBW5WTTwum6ixA/9Gy4Re4Hkw8vM9Y7VLu4TBh884lhR9DKzWBlW3QzUZzydQrWfpubQ7OWME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727857441; c=relaxed/simple;
	bh=8qT8AJdSAevn7Lon301IIUYaxahlZK6BFR3I/iQhyNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RxO0FJFheLM16qnoUDyrHjeloGh+4ws3pL+HNrrtVujavhzmnXvxpqFivCay8nlV9NQCm9ttMR+GXCPqv9Wgp3fxKljzgrg+FqavjVUandq4yS2FoU2dUDEXkyoN0nuvs94VcMfp12kq0/PNg10GWu5PEd3aib9rgKgtpgI1h4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hk4K+BHc; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7db90a28cf6so420276a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 01:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727857439; x=1728462239; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8qT8AJdSAevn7Lon301IIUYaxahlZK6BFR3I/iQhyNk=;
        b=Hk4K+BHceIML/taLMgC9xQ0OvyZPRSoHMNvtliV2hMHV5jeiTpTVywG/h6fpR0+Pu0
         7dLQQmIfc8ecKkG4knb6q0ly1uNfprTUdULeeo36VSAUok564rsvV24+1A592i6+w+6n
         jfduehMlh2Pz/+jtL0Mi3Pqe1LICKji5ls4Clk0o5IsMk0ZvWYIh5effJbjBfXh77QiA
         Aqo0ajdlTy5m+KTX4gA9deW9Rk3pXymA/r5klFdzf4r5UoW6RKOWESubfsHS1gF7DhJ6
         CVExqMOoqr9DN+pYvaGt72niXjN+KifUNPWC0tFIBvMPu2usQTEqC5cQshRjeJopaqod
         KZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727857439; x=1728462239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qT8AJdSAevn7Lon301IIUYaxahlZK6BFR3I/iQhyNk=;
        b=SnL4ljXphBBBnyhhNVKnETRr0KHInB8awhRv/o6rX/X/TuWW9mWFkXypC1/YdT21xX
         jGn2b1osxjObZ3ZOKkLHhEgSwWNJAQvB169YQGgyec7cUj89T7EwRaQt4Qte9oRWbgZn
         x96VI3xMxHqsP9CtFJqgqqVFVhHfw4KgTx3sxj5wH+gasihbGwz7y0Y02vFIjuZfkDSY
         oKGbf+JwYnSHEBSCrxRZ3PLZ9qkERvMI0STTxxN6Ked2ywENQXbJp1q8TsqwHhRLnZ1D
         mLDu2xVTvouGqwOtwoPHYlUpLbHZfCAOx+voqKYSTVMl8fPZgp/FwK3IRZfe/QyZNRxB
         44DA==
X-Forwarded-Encrypted: i=1; AJvYcCW+w7dCKomPbbVxvzhSOxsMlKU6KtzCz0r6vhL/3CtdHHS/wb7s74lEIM1VWuhlWwNOJHzmhpScSEW227g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1jDdwcPo+3ysFZa/vF5PaheQ7R1doJZqccMN4iq1pcCC4Hngo
	nMcsKhy741LQr7tEw5YTq2s7zo7LLldZgeat14/qgW987eO7r9l5lvnTxQQ8w9yI22Ko5eM767M
	Uv+R8o/BY7CgSsJChiY/BdCcP8R+jkSuCIv9WXQ==
X-Google-Smtp-Source: AGHT+IEr1vFU0a1kvwV4sZXMH05Rcdg/y0G4x0gieaTwktCZi4DvPvG3W8WrO/0W27YGf2bHaceIX2iLNO+x3PuzjLM=
X-Received: by 2002:a17:90a:cb8f:b0:2c9:36bf:ba6f with SMTP id
 98e67ed59e1d1-2e1851496c6mr3427473a91.3.1727857439139; Wed, 02 Oct 2024
 01:23:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
 <20240925075707.3970187-3-linyunsheng@huawei.com> <4968c2ec-5584-4a98-9782-143605117315@redhat.com>
 <33f23809-abec-4d39-ab80-839dc525a2e6@gmail.com> <4316fa2d-8dd8-44f2-b211-4b2ef3200d75@redhat.com>
In-Reply-To: <4316fa2d-8dd8-44f2-b211-4b2ef3200d75@redhat.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 2 Oct 2024 11:23:22 +0300
Message-ID: <CAC_iWjLBE9UY2wk_kKE=t=npRBF13HoLWODLUpQJ6F3P8sv4rw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] page_pool: fix IOMMU crash when driver has
 already unbound
To: Paolo Abeni <pabeni@redhat.com>
Cc: Yunsheng Lin <yunshenglin0825@gmail.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
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
	linux-mediatek@lists.infradead.org, linux-mm@kvack.org, davem@davemloft.net, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

On Wed, 2 Oct 2024 at 10:38, Paolo Abeni <pabeni@redhat.com> wrote:
>
> Hi,
>
> On 10/2/24 04:34, Yunsheng Lin wrote:
> > On 10/1/2024 9:32 PM, Paolo Abeni wrote:
> >> Is the problem only tied to VFs drivers? It's a pity all the page_pool
> >> users will have to pay a bill for it...
> >
> > I am afraid it is not only tied to VFs drivers, as:
> > attempting DMA unmaps after the driver has already unbound may leak
> > resources or at worst corrupt memory.
> >
> > Unloading PFs driver might cause the above problems too, I guess the
> > probability of crashing is low for the PF as PF can not be disable
> > unless it can be hot-unplug'ed, but the probability of leaking resources
> > behind the dma mapping might be similar.
>
> Out of sheer ignorance, why/how the refcount acquired by the page pool
> on the device does not prevent unloading?
>
> I fear the performance impact could be very high: AFICS, if the item
> array become fragmented, insertion will take linar time, with the quite
> large item_count/pool size. If so, it looks like a no-go.

It would be could if someone could test that. I'll look around in case
we have any test machines with cards that run on page pool.

>
> I fear we should consider blocking the device removal until all the
> pages are returned/unmapped ?!? (I hope that could be easier/faster)

Jakub send an RFC doing that [0]. Yes, this is far far simpler and
does not affect performance, but aren't we implicitly breaking
userspace?

[0] https://lore.kernel.org/netdev/20240806151618.1373008-1-kuba@kernel.org/

Thanks
/Ilias
>
> /P
>

