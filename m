Return-Path: <linux-kernel+bounces-513088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9EAA34198
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37B818825FF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA40241683;
	Thu, 13 Feb 2025 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="jtBeACFN"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CDD23A9AE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455536; cv=none; b=qDe3WyWVs+M3xSHWJOT1W2RUCjbFolqrR8xpUGKR/eGXrsK58T0ZJZUK439Lwv3b4KPuPEaduSoyATP7ZRES9TNnTwnrFGTwQ0KlHqieqoIVi9x+XGFKxiHqrC73vQWlp5Z8WAiIELol48IngVDnB+9ZqkYCwqW25fmKN2abVaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455536; c=relaxed/simple;
	bh=xS258u4nZ8Oh1hovVFPvLu204SUXG1v2PhB8JQekrzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWX5EPMTIfJTe7rc2chF/nVH38Tkqjkd82brFRTYPq41XnWCIHKLwM07h9u9KFL/nVn3y0Z79X8+llZ153uAV0q9+szGKT9Ky+alCOgn+iO3lkZNcIitodchaSR/GKnFWMExhAiohxLBI0akwSdjup3Rl9bbvFefXqeAOHY+aDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=jtBeACFN; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c077c9cbb9so73118585a.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1739455534; x=1740060334; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fiZcI5pNzRU07XzzU8EnwEz/jsrm+hKHSzrUBfY4xZU=;
        b=jtBeACFNrdjCGmaY/9jH6wFB3yez/yqML/HohpGxuCOiB2Tv9GqhrDbijoQy03IIjK
         1CciDijJj9AY1x7+EyT0JCvKeUL3ZHipaDdohL6BURL9b/+FRFh98q05UlaKMO+0NhfP
         r3YGT9hz6euC45ZXrwWiobNXazekfITnQpv1iZJXCn2H9PZMsiG/oOpJUl462otRI8QV
         WL2wtdxumkfdVyyEgfhZ22aP+ns5rHlZ7f9OJ/UIdVq97iZ4s6c85iQC6TD9tP0cR3ex
         h+MsgGdOhkmDbmICdBlfW87RTN2wJyclaBtGaT6rBfQJoigwZO+iaQvWBBY4Akt3sYcY
         vUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739455534; x=1740060334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fiZcI5pNzRU07XzzU8EnwEz/jsrm+hKHSzrUBfY4xZU=;
        b=egzXqFQL7JvffPCe3Ew9wsjXxSgF8eXE8Cnt2LjlwQDLLQS+qekkcgv/tn7Wovip44
         VIGz+qYRqa6fjEGvF0RwBEavImGxoJig9dTW90gy1B2A1CW2Ko2jMQsYrAqLl9WU4mKs
         n0BEj8KhoHZ9kbMh3Mb8Iv9nTwzQ9VznfWAT6y8HLR3v2285ux14nJ5uEinXXTSZD7hY
         A5lA4wGglKyq75j5dkZSp1l3TUIHZDjUfsDINv7Vft4b+xot9CMRK8POQXkGlJjQqsEm
         fEQcZTnkJ9pX75ffHLcP2vJBxCalQVFO/EyCSaKm4WGghMmNNaAMtUcMWTJBcef8VLSC
         +OnA==
X-Forwarded-Encrypted: i=1; AJvYcCUnXwHF2aU76Y8COQffl+KuXKm7IZt7d0BJaYYIjSVW8MhBm1FskeGNwXwwddIyGnZlzzd7/ZXmaAURb3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq0mwUsdKdbQ+mPZaFYHe2pLR0ft5sHcp80S2e8tz0ihn3JE1p
	jlRhjOGwOhRwIR1gqGjXA7iLUMT/+DQLFCqdZ7GzHShl5cQP6+JG72XETokzG/TVTJSjSksl8X0
	FLuYKvprVM+uDYRYFJtfBzS5qYv6O+wv8d5EWnA==
X-Gm-Gg: ASbGncusWIK/T9S+waKQroUqlHbEVVR2sk+6morrAItrd4UuK8Jr/WNcbCpwvEcITdg
	KX61Gbf+jXKqv5FyV/pH2sTtgR8QWOdEhVzqpsYVr3hlpEOT6WIqAJFFzNe4fWeBcyWHbpg==
X-Google-Smtp-Source: AGHT+IGMP88jINMPoFMOhhs/JAOS7v2yzIBooFPBVGpWjkqaheBF8kqUyMw9whWPj/OQ8rwmytDe/wVilf8O/rIqWwA=
X-Received: by 2002:a05:620a:6841:b0:7b6:d611:ce6f with SMTP id
 af79cd13be357-7c07a89294cmr506602985a.8.1739455533614; Thu, 13 Feb 2025
 06:05:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217100809.3962439-1-jens.wiklander@linaro.org>
 <20250212205613.4400a888@collabora.com> <CAFA6WYOaGEPj0xNEDBCoEmjJreEHChjQ2hyXRJ_CYoGhiBonfw@mail.gmail.com>
 <20250213093557.278f5d19@collabora.com> <CAFA6WYOJkSRsH-15QdqXNMd08Q=Dg4NkRd1Cr9LXA+5nozTF6g@mail.gmail.com>
 <20250213134008.4cbef142@collabora.com>
In-Reply-To: <20250213134008.4cbef142@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 13 Feb 2025 14:05:22 +0000
X-Gm-Features: AWEUYZn29uWPvEYSBg2IY8QVofzDJvdO9H1dHkQQoSFoIsbJfLKOXfSzgdbP8WY
Message-ID: <CAPj87rM5Y=-Jgf4mwukicF6Yb-vccn2fpG2X1jNq0upH2+cAEQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] TEE subsystem for restricted dma-buf allocations
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Jens Wiklander <jens.wiklander@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, 
	Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, 
	Florent Tomasin <florent.tomasin@arm.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, 13 Feb 2025 at 12:40, Boris Brezillon
<boris.brezillon@collabora.com> wrote:
> On Thu, 13 Feb 2025 14:46:01 +0530 Sumit Garg <sumit.garg@linaro.org> wrote:
> > Yeah but all the prior vendor specific secure/restricted DMA heaps
> > relied on DT information.
>
> Right, but there's nothing in the DMA heap provider API forcing that.

Yeah. DMA heaps are just a way to allocate memory from a specific
place. It allows people to settle on having a single way to do
allocations from weird platform-specific places; the only weird
platform-specific part userspace needs to deal with is figuring out
the name to use. The rest is at least a unified API: the point of
dma-heaps was exactly to have a single coherent API for userspace, not
to create one API for ZONE_CMA and DT ranges and everyone else doing
their own thing.

> > Rather than that it's better
> > for the user to directly ask the TEE device to allocate restricted
> > memory without worrying about how the memory restriction gets
> > enforced.
>
> If the consensus is that restricted/protected memory allocation should
> always be routed to the TEE, sure, but I had the feeling this wasn't as
> clear as that. OTOH, using a dma-heap to expose the TEE-SDP
> implementation provides the same benefits, without making potential
> future non-TEE based implementations a pain for users. The dma-heap
> ioctl being common to all implementations, it just becomes a
> configuration matter if we want to change the heap we rely on for
> protected/restricted buffer allocation. And because heaps have
> unique/well-known names, users can still default to (or rely solely on)
> the TEE-SPD implementation if they want.
>
> > There have been several attempts with DMA heaps in the past which all
> > resulted in a very vendor specific vertically integrated solution. But
> > the solution with TEE subsystem aims to make it generic and vendor
> > agnostic.
>
> Just because all previous protected/restricted dma-heap effort
> failed to make it upstream, doesn't mean dma-heap is the wrong way of
> exposing this feature IMHO.

To be fair, having a TEE implementation does give us a much better
chance of having a sensible cross-vendor plan. And the fact it's
already (sort of accidentally and only on one platform AFAICT) ready
for a 'test' interface, where we can still exercise protected
allocation paths but without having to go through all the
platform-specific setup that is inaccessible to most people, is also
really great! That's probably been the biggest barrier to having this
tested outside of IHVs and OEMs.

But just because TEE is one good backend implementation, doesn't mean
it should be the userspace ABI. Why should userspace care that TEE has
mediated the allocation instead of it being a predefined range within
DT? How does userspace pick which TEE device to use?  What advantage
does userspace get from having to have a different codepath to get a
different handle to memory?  What about x86?

I think this proposal is looking at it from the wrong direction.
Instead of working upwards from the implementation to userspace, start
with userspace and work downwards. The interesting property to focus
on is allocating memory, not that EL1 is involved behind the scenes.

Cheers,
Daniel

