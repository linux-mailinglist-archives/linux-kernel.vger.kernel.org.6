Return-Path: <linux-kernel+bounces-201047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801FB8FB8ED
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D2E7B220E7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC680146D6E;
	Tue,  4 Jun 2024 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uSMeGsvM"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E3953BE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717517524; cv=none; b=KQFAEJjYauSUGZrMJrFHvBG+F9mz1XS+gZNVUV8NLjZRAztEaqC0GJgp2BfttnvfX42BI20vBWbTZe0AupblioS0bMA9jHXwEA/ylbTE/evQvnIjRbi4orAsuGlQDZTMPe5uWIAuMPwTRRqUNIFvMk+5YhzUIONhmzL4K9LOda4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717517524; c=relaxed/simple;
	bh=7Fq1N08ityDodrU5UqN/tu7ksF/MqwNuqjUfkSs8E40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iOosMC/IGTQ5IIP7PHgQTY4qlvm2MYan6Zdrl0HZZ2wDfkRh0xN8GZ3hs40DNVUOvsznL6/CfLQST1gXUivi511bflXi7MVzNqJuavlpAa2OK6kEcXG4+ijnXj+INqNBneY2zUHVRvqdTBrqnDtGH+QuiAY6le3xUzChb15n9cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uSMeGsvM; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a691bbb7031so285998066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 09:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717517521; x=1718122321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Fq1N08ityDodrU5UqN/tu7ksF/MqwNuqjUfkSs8E40=;
        b=uSMeGsvM7jgvY5nWrRDZwOyjEIR8CZB/fK7gNLbc6T2lF4lqhIr4QKURrMC9SSEryQ
         KNif1hDTB2NnAvh0XNT7DYt8fSQNcHPQQBfLPrk/RSLAEQoHyGNWsUWNEeiOMwSRSwIY
         iji2HedoKLoKrVt9MpRQnRwSI3++RqiQQjkbVXjRZLKpm+yxZYVYN8FfS1wy6KVmg+dI
         TlHfPV6Bky01ptwNR6jpWz8+gRLrAmfLfD8E6wCwat2zlbRGH4FzLbaAgEAxKnZCFHEY
         0NyTF3TyPWc6fbhyN5DkpEd8HSeKte6QbR5wxCUhSbHrwYHP2ytVabvowUx30maOZ8ea
         VUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717517521; x=1718122321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Fq1N08ityDodrU5UqN/tu7ksF/MqwNuqjUfkSs8E40=;
        b=fmdGSYWnF5aI723EQHZCDKW4Cr/BgRv7gL8t3A9kRLSbHaVU299iTNpmsGWksHpmvW
         yrW6r/4XdIKLdvk+BpQ6NGh4XtEHT7RnMnA0bLq75z5U7tA7OgSIUuNOtet57JGUDRkZ
         HSzMiueiSZYox2lUsLYzW2xjzqIuzbAjzHw1uGvRJmS310Mm67K8o0o8SHjxHI94CNis
         UimaEH4y2GZcr1R5XK17fuR+hqnTeRj0Xf3+uMwmpPpW60lXg6OBJBWHtFMvznr7lect
         Mtl1P7QsuKu8sCng7lRv3y+MyrcunyYsUk01EOoHWF86UGBGYaj4XW4ea1oUGTLutz4j
         CbzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAC0uwY3KpRdY1w4qfBRo/deZImHAM9WpWhxEwqUSbY6e9daV8AwPrEjIWS20xeh8a1j4nnHip36j9l92U992M03gWh6bu5xAeVQVR
X-Gm-Message-State: AOJu0Yz849DHnvCfdVFpzKQfVKFJU2W8oD4Qt09RCwKIXppdS7+pvJ6S
	FLP7MOLyLOqsOT536Hr7WmGUzDJAt2fJplDB1Bhm3/Dm6lSTd8oyStya3HMhRAUTOZrRyGlp+RB
	TswaiqBQWKWaT5GYv0ohzDshQheNnvDQF2xe/4CgYAejRxCfrklCu
X-Google-Smtp-Source: AGHT+IHjToe9HZIMn9NzVD0RPeflJl/bU+DgMt9GMRZwk/Ij7exz/RMTsjf5+KctCPjgAFtdRjBi3oCz1G19/QxZrYg=
X-Received: by 2002:a17:906:35da:b0:a59:d2ac:3856 with SMTP id
 a640c23a62f3a-a699f66643bmr380966b.22.1717517520321; Tue, 04 Jun 2024
 09:12:00 -0700 (PDT)
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
 <CAJD7tkbCRLdy0vD2Pd17fNrxHgkzW1VucN4qMkohLFLBLaaeCQ@mail.gmail.com> <20240604134458.3ae4396a@yea>
In-Reply-To: <20240604134458.3ae4396a@yea>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 4 Jun 2024 09:11:21 -0700
Message-ID: <CAJD7tkYjJJGthQ_8NukGw6Q9EYbLA=8sAH_7=B90KXEL6HWdSw@mail.gmail.com>
Subject: Re: kswapd0: page allocation failure: order:0, mode:0x820(GFP_ATOMIC),
 nodemask=(null),cpuset=/,mems_allowed=0 (Kernel v6.5.9, 32bit ppc)
To: Erhard Furtner <erhard_f@mailbox.org>
Cc: Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 4:45=E2=80=AFAM Erhard Furtner <erhard_f@mailbox.org=
> wrote:
>
> On Mon, 3 Jun 2024 16:24:02 -0700
> Yosry Ahmed <yosryahmed@google.com> wrote:
>
> > Thanks for bisecting. Taking a look at the thread, it seems like you
> > have a very limited area of memory to allocate kernel memory from. One
> > possible reason why that commit can cause an issue is because we will
> > have multiple instances of the zsmalloc slab caches 'zspage' and
> > 'zs_handle', which may contribute to fragmentation in slab memory.
> >
> > Do you have /proc/slabinfo from a good and a bad run by any chance?
> >
> > Also, could you check if the attached patch helps? It makes sure that
> > even when we use multiple zsmalloc zpools, we will use a single slab
> > cache of each type.
>
> Thanks for looking into this! I got you 'cat /proc/slabinfo' from a good =
HEAD, from a bad HEAD and from the bad HEAD + your patch applied.
>
> Good was 6be3601517d90b728095d70c14f3a04b9adcb166, bad was b8cf32dc6e8c75=
b712cbf638e0fd210101c22f17 which I got both from my bisect.log. I got the s=
labinfo shortly after boot and a 2nd time shortly before the OOM or the ksw=
apd0: page allocation failure happens. I terminated the workload (stress-ng=
 --vm 2 --vm-bytes 1930M --verify -v) manually shortly before the 2 GiB RAM=
 exhausted and got the slabinfo then.
>
> The patch applied to git b8cf32dc6e8c75b712cbf638e0fd210101c22f17 unfortu=
nately didn't make a difference, I got the kswapd0: page allocation failure=
 nevertheless.

Thanks for trying this out. The patch reduces the amount of wasted
memory due to the 'zs_handle' and 'zspage' caches by an order of
magnitude, but it was a small number to begin with (~250K).

I cannot think of other reasons why having multiple zsmalloc pools
will end up using more memory in the 0.25GB zone that the kernel
allocations can be made from.

The number of zpools can be made configurable or determined at runtime
by the size of the machine, but I don't want to do this without
understanding the problem here first. Adding other zswap and zsmalloc
folks in case they have any ideas.

>
> Regards,
> Erhard

