Return-Path: <linux-kernel+bounces-361113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A993E99A388
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B0D1F22089
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E716217322;
	Fri, 11 Oct 2024 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JcIR+2Mc"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE78216450
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648833; cv=none; b=q+TzG9vvakoZDMUDfp8J9Q4YsHSqVi61zl8pO8B8UeZMj2iUBUmPwmgpwJcwm4vOf6YAJQ1a9JQh9Qid5BrZuaiU4ILCFy4JI6Bo5Nj1r2r+diMiJM8hk+Be3mA4RAmt34ZFKE3S4gtegBG8t1zxGEtncVlnGe50iY3JfSecLMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648833; c=relaxed/simple;
	bh=pVgQ4qeBPZp/jrWkLQ9CTTXSj/41aLXmAoXMA/Sm+W4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4xHMmzGVXNwY/TGWNXxJFBLmZNV/dnO8n2IeC0EbWqllYLnndGkMPb5QQbpwEg5Y61iu039iPGdkLIdnqkjaOUJpdHjQ4PN6mwND781lmcFeuDE74W6CKBHggCtK1cmdVMKgx11Ew3wWBiaTANlz80QOqnWeO9PDBIOZasfHTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JcIR+2Mc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cb47387ceso995805ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 05:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728648832; x=1729253632; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6DV8FmK9n2s3xaJw37bhq13Y2oj4hKbJoV0faMjnNfw=;
        b=JcIR+2McKtwOE5Jd5A3c99BsRdTBzErzRGkGdtQDCZhtwGNaRfsM0HbWj1veOd22mW
         /Owtk+Zyg0K0aJ93Mufj8B4Llmq/gr68p8Gk5lQk88nKgX60/DfaqyeoO1VAqkN6t5AU
         2p+v2WZ9lAm+/quhSqJUv2BsrmPnAFhhA4x3PxLJq6eeVopDBuxTPH7JHI7i+2ciKu51
         rr9H2uStt+n65k67NuTrIRq32N15k3wg9piyvlWUZiz0CmFku+AsMQ/jRNKYbNrQkruS
         ZOHK7ubNkqkRV3WNcWmMm2/KxNeeOeLFsHxn0b7FfBny+iaq/LtbE6oEsE0Duy8olaCJ
         AUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728648832; x=1729253632;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6DV8FmK9n2s3xaJw37bhq13Y2oj4hKbJoV0faMjnNfw=;
        b=EGA4F+pwrVOFd6x180lmCioUGqpQCLs5repis1dJb4wPnRFg9wBnM1KyOLSnU2jk3L
         pd8Gglij4+Ewe0DxOC3EI+eqLazOGm8O58n2GLlnQLKwdBLoOeMhyuCiQ1ng7fSinAds
         F701IroBR84ZvuOF40p8dhdtKJdMeBOm0zlEojd0xRI5qYO0ODXU5BX3oZ6pW03KDx9l
         UzyJtPpecuxs/LF+AcxtCxZ5Wk61Omzcv5xmY3Vvc4y4EkHaK24otlx0vuqqzAmNMJSc
         cZe2x3N0L6h0vXHBO79tVUP4dKWtWuZ6Fzo9fGnisRPa3m1AwsG+ZxQoLkZ8Slh/Ql+m
         PvMA==
X-Forwarded-Encrypted: i=1; AJvYcCUl8pgyTDmkOYkMBK03N1qXhyC1K+1YL9cgCtBwALd0NelPF44IpupTHQtFy2aPOC8AxrL/qvVdOR3jbyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkHNs0GMA2rAVqqmSkuAgCNZjpISSwIOIh9IY7zrQwZ+Y6Tmou
	Ygbc4nOLgwZ1oVIth7ilIqZClNZ7xtC8m90Wd/OSmPIDDSyHjRQJ0btKfWeIa0ajesxcHX82IBp
	VfTdGY9iS1dxTt9tmI1kK0eflNBnVEMbn7T2uFw==
X-Google-Smtp-Source: AGHT+IEhHh7IyxNNVXdhpzK7DYdwX3u4HJLwqzq8zbFcpGhkbrrdEfGF3mSpDzSVS0AcPKmBvtOSTltyzsarT9dBX/Q=
X-Received: by 2002:a17:902:e845:b0:20b:b93f:300a with SMTP id
 d9443c01a7336-20ca14246b0mr37785885ad.7.1728648831700; Fri, 11 Oct 2024
 05:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010114019.1734573-1-0x1207@gmail.com> <601d59f4-d554-4431-81ca-32bb02fb541f@huawei.com>
 <20241011101455.00006b35@gmail.com> <CAC_iWjL7Z6qtOkxXFRUnnOruzQsBNoKeuZ1iStgXJxTJ_P9Axw@mail.gmail.com>
 <20241011143158.00002eca@gmail.com> <21036339-3eeb-4606-9a84-d36bddba2b31@huawei.com>
In-Reply-To: <21036339-3eeb-4606-9a84-d36bddba2b31@huawei.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 11 Oct 2024 15:13:15 +0300
Message-ID: <CAC_iWjLE+R8sGYx74dZqc+XegLxvd4GGG2rQP4yY_p0DVuK-pQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1] page_pool: check for dma_sync_size earlier
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Furong Xu <0x1207@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	xfr@outlook.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Oct 2024 at 11:55, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> On 2024/10/11 14:31, Furong Xu wrote:
> > Hi Ilias,
> >
> > On Fri, 11 Oct 2024 08:06:04 +0300, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> >
> >> Hi Furong,
> >>
> >> On Fri, 11 Oct 2024 at 05:15, Furong Xu <0x1207@gmail.com> wrote:
> >>>
> >>> On Thu, 10 Oct 2024 19:53:39 +0800, Yunsheng Lin <linyunsheng@huawei.com> wrote:
> >>>
> >>>> Is there any reason that those drivers not to unset the PP_FLAG_DMA_SYNC_DEV
> >>>> when calling page_pool_create()?
> >>>> Does it only need dma sync for some cases and not need dma sync for other
> >>>> cases? if so, why not do the dma sync in the driver instead?
> >>>
> >>> The answer is in this commit:
> >>> https://git.kernel.org/netdev/net/c/5546da79e6cc
> >>
> >> I am not sure I am following. Where does the stmmac driver call a sync
> >> with len 0?
> > For now, only drivers/net/ethernet/freescale/fec_main.c does.
> > And stmmac driver does not yet, but I will send another patch to make it call sync with
> > len 0. This is a proper fix as Jakub Kicinski suggested.
>
> In order to support the above use case, it seems there might be two
> options here:
> 1. Driver calls page_pool_create() without PP_FLAG_DMA_SYNC_DEV and
>    handle the dma sync itself.
> 2. Page_pool may provides a non-dma-sync version of page_pool_put_page()
>    API even when Driver calls page_pool_create() with PP_FLAG_DMA_SYNC_DEV.
>
> Maybe option 2 is better one in the longer term as it may provide some
> flexibility for the user and enable removing of the DMA_SYNC_DEV in the
> future?

Case 2 would be what this patch does. We already treat -1 as the
maximum DMA memory size. I think it's ok to treat 0 as 'don't sync'. I
need to figure out why people need this.
IOW you still have to sync the page to use it. Now you can do it when
allocating it, but why is that cheaper or preferable?

Thanks
/Ilias

