Return-Path: <linux-kernel+bounces-203413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5168FDAC4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C801F25781
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD2F167268;
	Wed,  5 Jun 2024 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C+1BGUSF"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0A415FA60
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 23:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717630933; cv=none; b=WNNq9pyT6oAiobI1cL/ILPQiK4UfGTlDkZFWdORntjZ+X5xMzpk9g1JOkcN7GVp4x4a75APyfekUAX3QrGcNJPuIkqMfqDV0BU5nDiG0eb64OcynHqcTdr3U551KrghybB0N1x5JilzMuh5p9cLSbKPRSQiVvDf4CiIwZTbdR9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717630933; c=relaxed/simple;
	bh=fURZ+GlEwn1DW8Z6q3RkvHuwBmyZjfx8HFK5EMb98t4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=We3xZ7ch0PNUy8oYLjJpMXbVt2D1dpGTTJFewyYh3YfrqdKA8bz86zIbszRrQCMGy05MXWw+5N8Qu7x0UP1qBdT7ZUpAhyDKtNrf0YCeSUUYT86SfosyE4qj3eAEE+F0TKq24zRoBQW4VmB+AC76WFcFjXCrVyG9QHpW/ncHASg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C+1BGUSF; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-80a8770ff33so139940241.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 16:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717630931; x=1718235731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fURZ+GlEwn1DW8Z6q3RkvHuwBmyZjfx8HFK5EMb98t4=;
        b=C+1BGUSFeF7N7zfda926Y/Ks2+gvKd3OlQzjKFfhZ3JgyIL3CG+/MkOfM+FOq6QdEr
         FfopwMGsHcSjPb1Ur4aL0kzrApCpKDdTdE7KBxNac3LJRqdC8bvd/FM6Y7WPLVX8RPoF
         CFTceAY/OS2wMYoYxnMvz2me+yQOdqX/M2FDm7zV5N65z9/VUk9Pjrm4H6Ag9t1Raswl
         rngSLVMQaNNf/e8ImL3R6KX6ACVOcb6EA71YBW6/00TfFXO8HvWyId+EbExfWHif9EWy
         pH0eXG//IsplXcXmnI/j337/rLiKdi6whgNnoSZhLbeh+CZzcuUnWoBgBhgkcmafn64E
         atog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717630931; x=1718235731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fURZ+GlEwn1DW8Z6q3RkvHuwBmyZjfx8HFK5EMb98t4=;
        b=MDSC3dNSUFIp6HFKO1VBkVq0nZUg0an8cdyWReRFGCuu36PXtod4CH1F0IxdCm4rGf
         FORxvmp4yriHqL1aXWNB9Sxc+aRNhgO1CAL4oVAnh5BHnvgpfItbwY03oLVHEdcXoG6o
         aP1o4GEV2ZdfLLji1nRKJkwqTjhRPcLNU1RuU1GUTtgcle6Nsh4AM+4SMzH7p9qJbowT
         IzuBLBQLUdC5wFcDdgxyOR3jSd9t1+ShEWuKvei4TRpXR/xbiJ39L8dCm1caHiBiDfWD
         dz7gkRtFLODAGRpNSiEJPsh7VKmOB3sma5guk+YhjaiC62Cs6BUKy2oXTcK9B2nzyCkA
         uTHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+M4G7qP1oRRu6wyDqV4AEPVEfb+1/SYPXAXBaznvI55P3ZPliVPsCvOiaeloYxGSIZGaO2xD4n1GtNlmqI8+cNwO9jJzikA/qr/cH
X-Gm-Message-State: AOJu0YxfSZsUS8/ORCB4/EnUpVmTg2Gr7b0i7bMryadwq+q6dgEyF6du
	Z1eD+gTzbe9sNgBuTyAkGu5KpZq/ZvbFMy06jw7l4ed4rgVzwInznoyRxEIPCNpfj92ATbttEsa
	/Tr4Rw9DiftjHbwauB6wcvWYQnxXb0DzFzQkq
X-Google-Smtp-Source: AGHT+IHB5vbuYgoHzyE4VqkkyenDd0XtXJRfmN4AlQZzBmVBqpqyc1bRUTgyVv8nXskKAUiYew/UvTVdsYWeXMBGKpQ=
X-Received: by 2002:a05:6102:5089:b0:47f:40f7:2b5f with SMTP id
 ada2fe7eead31-48c047f4db6mr5870916137.5.1717630930642; Wed, 05 Jun 2024
 16:42:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508202111.768b7a4d@yea> <20240515224524.1c8befbe@yea>
 <CAOUHufZ-9NmzOKjLedvZFp0=N0LvRZn77qC6k1WXK+NHtKr=0w@mail.gmail.com>
 <CAOUHufZ36rQc8AfLtRv2QrEareysdvbprAEO5XkcG-FeDOxFLA@mail.gmail.com>
 <20240602200332.3e531ff1@yea> <20240604001304.5420284f@yea>
 <CAJD7tkbCRLdy0vD2Pd17fNrxHgkzW1VucN4qMkohLFLBLaaeCQ@mail.gmail.com>
 <20240604134458.3ae4396a@yea> <CAJD7tkYjJJGthQ_8NukGw6Q9EYbLA=8sAH_7=B90KXEL6HWdSw@mail.gmail.com>
 <CAOUHufa0Fpj6SjNgB-z0n5Jg63q1ewkbOAU65forpDwQVs45qg@mail.gmail.com>
 <CAJD7tkb=5GJ9SNUwDsu1Zy3Tus4rjsNo60Hg9N7=gGth409Diw@mail.gmail.com>
 <CAOUHufb6zXr14Wm3T-4-OJh7iAq+vzDKwVYfHLhMMt96SpiZXg@mail.gmail.com>
 <CAJD7tkZ+QY55GTzW9A7ZCm=rxAEfrW76cWXf8o5nwiKSXp8z=w@mail.gmail.com>
 <20240604231019.18e2f373@yea> <CAJD7tkYq5u7B+0UH2XKpeWJnUxoO2kJ1_XZ2JOgYpyNEVR7u0g@mail.gmail.com>
 <20240606010431.2b33318c@yea>
In-Reply-To: <20240606010431.2b33318c@yea>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 5 Jun 2024 16:41:31 -0700
Message-ID: <CAJD7tkbhWYzx=6YmzAh0F+cK-_Bn8mPOH7gMbQS7YVXmaFSgFg@mail.gmail.com>
Subject: Re: kswapd0: page allocation failure: order:0, mode:0x820(GFP_ATOMIC),
 nodemask=(null),cpuset=/,mems_allowed=0 (Kernel v6.5.9, 32bit ppc)
To: Erhard Furtner <erhard_f@mailbox.org>
Cc: Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Minchan Kim <minchan@kernel.org>, 
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 4:04=E2=80=AFPM Erhard Furtner <erhard_f@mailbox.org=
> wrote:
>
> On Tue, 4 Jun 2024 20:03:27 -0700
> Yosry Ahmed <yosryahmed@google.com> wrote:
>
> > Could you check if the attached patch helps? It basically changes the
> > number of zpools from 32 to min(32, nr_cpus).
>
> Thanks! The patch does not fix the issue but it helps.
>
> Means I still get to see the 'kswapd0: page allocation failure' in the dm=
esg, a 'stress-ng-vm: page allocation failure' later on, another kswapd0 er=
ror later on, etc. _but_ the machine keeps running the workload, stays usab=
le via VNC and I get no hard crash any longer.
>
> Without patch kswapd0 error and hard crash (need to power-cycle) <3min. W=
ith patch several kswapd0 errors but running for 2 hrs now. I double checke=
d this to be sure.

Thanks for trying this out. This is interesting, so even two zpools is
too much fragmentation for your use case.

I think there are multiple ways to go forward here:
(a) Make the number of zpools a config option, leave the default as
32, but allow special use cases to set it to 1 or similar. This is
probably not preferable because it is not clear to users how to set
it, but the idea is that no one will have to set it except special use
cases such as Erhard's (who will want to set it to 1 in this case).

(b) Make the number of zpools scale linearly with the number of CPUs.
Maybe something like nr_cpus/4 or nr_cpus/8. The problem with this
approach is that with a large number of CPUs, too many zpools will
start having diminishing returns. Fragmentation will keep increasing,
while the scalability/concurrency gains will diminish.

(c) Make the number of zpools scale logarithmically with the number of
CPUs. Maybe something like 4log2(nr_cpus). This will keep the number
of zpools from increasing too much and close to the status quo. The
problem is that at a small number of CPUs (e.g. 2), 4log2(nr_cpus)
will actually give a nr_zpools > nr_cpus. So we will need to come up
with a more fancy magic equation (e.g. 4log2(nr_cpus/4)).

(d) Make the number of zpools scale linearly with memory. This makes
more sense than scaling with CPUs because increasing the number of
zpools increases fragmentation, so it makes sense to limit it by the
available memory. This is also more consistent with other magic
numbers we have (e.g. SWAP_ADDRESS_SPACE_SHIFT).

The problem is that unlike zswap trees, the zswap pool is not
connected to the swapfile size, so we don't have an indication for how
much memory will be in the zswap pool. We can scale the number of
zpools with the entire memory on the machine during boot, but this
seems like it would be difficult to figure out, and will not take into
consideration memory hotplugging and the zswap global limit changing.

(e) A creative mix of the above.

(f) Something else (probably simpler).

I am personally leaning toward (c), but I want to hear the opinions of
other people here. Yu, Vlastimil, Johannes, Nhat? Anyone else?

In the long-term, I think we may want to address the lock contention
in zsmalloc itself instead of zswap spawning multiple zpools.

>
> The patch did not apply cleanly on v6.9.3 so I applied it on v6.10-rc2. d=
mesg of the current v6.10-rc2 run attached.
>
> Regards,
> Erhard

