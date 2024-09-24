Return-Path: <linux-kernel+bounces-336414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6FB983A93
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 02:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5EEB1F2338C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 00:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5171B85CF;
	Tue, 24 Sep 2024 00:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jMdD4rFb"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C7038C
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 00:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727137299; cv=none; b=hKJf80WsaPL5SSZT4Gb0aMhSnySLviutJYxKShMMaFdT8I67Do3gOwQlwIfuq4pbgSsC2JKs5iFW5YAV3tec/nXAJQTadushp2mf5LO/TjHLF6hIWPBcSHcrlxdbFP86mkum5stY3DazWWe0XAWi7WY5W6F3Xgon+RI32s4HLrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727137299; c=relaxed/simple;
	bh=RraPfnkGYA8VputFOH+7STgBUnygY7VlpnAMNOz+hfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0MUoh7sZa1ZncmdDPNKw17YjAMHoFkB+CnDcgkFgxkwaMsdVixm6CS6KDhxyb9DAsGcILjbNR3b/za5N8bbk49gWAGh5D36H2Mu/czmucRvQO2Jm8OclRduOsd08ajlKYgVB4T2o6JZf85tND/ENlBZo8BN2+ltWjzz6w9acnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jMdD4rFb; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d43657255so780213866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 17:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727137296; x=1727742096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Au0uzoSbH2ElJzaMeNmhVwvwewgLeaPK4IrgkIjA0rA=;
        b=jMdD4rFbiUg7gFihGnhOXvltIoJD6UzUqtG+Vi7K3SaJ/eNSsFkfcACJ5ydrodYGsa
         DQjNJ6R6k6LXsQsJTjgXzMTswQZHAzzcFYUgJ7ptXwrYrztawqgeADdRr2FQmOsjHdQV
         0zVWIxxFZcBeYJ36gPLSum6aBFJIv86fQLcSJGLZo1QGK2m8JUETTjPw9Cf24SgwTLCh
         j74AEJxvMqa+scpT8vwQte/WQIePGIuoxcmj599kqskXjLRL8acob3udQtetroXZ7BXo
         ofz556ipGKpg9pqYaKv75S5mujV4MOFbS93zUuTTPsnhdW2luVtKABG4zmgmpCjw33TW
         H8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727137296; x=1727742096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Au0uzoSbH2ElJzaMeNmhVwvwewgLeaPK4IrgkIjA0rA=;
        b=u2nY0Dw9YuWbFUYD6qQQBo6mmtxOw+IHfEv8UuTfzvFxspFUY1ATqHhnMAJEyUOU1P
         mxtXd+1RcAmShxUC+18ZaEUJNSEge4bGbmXAkCNp5Ic8YIxchYL4kLLb06A9a77QmQQ7
         17nAruOkqAWxxqYBkq5N6Cz7ri4/bdZ80daMOf9Me04JlTLIIhGboSUdynbE9hhqW9RF
         h6Om8pcyHwqT47Fpf6QwEBCX21aCF7IeiIte2mLCq5p+89xBGLXY2xJ5nAvUjDMP2Mra
         RX87GZwHpI5hWYxGxlvvqH+uliPEO0kgSyIkHtoq+MH8GC7Q9SuNGxQuWuQkZEBIhwyH
         ycrg==
X-Forwarded-Encrypted: i=1; AJvYcCWgjeFo/8Ec5qBniiRh3wnQ3c8UMzXt2mtckjScPu0+1oKKVmVWIyXvsxmMik3BWWPZhuNj4ETLN7G+h/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5xYYsxXCpesUZ27eZDFa0LZkpQLvIp3pX1sfZBThS9mwruPQI
	S+awbZFOUHs3rijetZVJR4I3sa0clg8fx0HJnLSgGWDVHvy0rAOywc75rH1k7UDX6pVvW6IkBg8
	tv1gi35AeeEyYPcvc9axFFPMVbyMGgDRD7otO
X-Google-Smtp-Source: AGHT+IE5iLzSstIhHpa898vVT2SsIC0B/KYygGCt0eGc0G0jTBqYSwXADuL3GomFoCiTYr/rjIhxtbaxkzyqEgn0jq8=
X-Received: by 2002:a17:907:e612:b0:a8d:3e29:a82d with SMTP id
 a640c23a62f3a-a90d5000fa9mr1132574166b.37.1727137295406; Mon, 23 Sep 2024
 17:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923231142.4155415-1-nphamcs@gmail.com>
In-Reply-To: <20240923231142.4155415-1-nphamcs@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 23 Sep 2024 17:20:58 -0700
Message-ID: <CAJD7tkbjr14JbbPOadacjbUmKEPyqPwAjikFO1xRCkOkLhN8LA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] remove SWAP_MAP_SHMEM
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	chrisl@kernel.org, david@redhat.com, kasong@tencent.com, willy@infradead.org, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, chengming.zhou@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 4:11=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> The SWAP_MAP_SHMEM state was originally introduced in the commit
> aaa468653b4a ("swap_info: note SWAP_MAP_SHMEM"), to quickly determine if =
a
> swap entry belongs to shmem during swapoff.
>
> However, swapoff has since been rewritten drastically in the commit
> b56a2d8af914 ("mm: rid swapoff of quadratic complexity"). Now
> having swap count =3D=3D SWAP_MAP_SHMEM value is basically the same as ha=
ving
> swap count =3D=3D 1, and swap_shmem_alloc() behaves analogously to
> swap_duplicate()
>
> This RFC proposes the removal of this state and the associated helper to
> simplify the state machine (both mentally and code-wise). We will also
> have an extra state/special value that can be repurposed (for swap entrie=
s
> that never gets re-duplicated).
>
> Another motivation (albeit a bit premature at the moment) is the new swap
> abstraction I am currently working on, that would allow for swap/zswap
> decoupling, swapoff optimization, etc. The fewer states and swap API
> functions there are, the simpler the conversion will be.
>
> I am sending this series first as an RFC, just in case I missed something
> or misunderstood this state, or if someone has a swap optimization in min=
d
> for shmem that would require this special state.

I have the same patch sitting in a tree somewhere from when I tried
working on swap abstraction, except then swap_shmem_alloc() did not
take a 'nr' argument so I did not need swap_duplicate_nr(). I was
going to send it out with other swap code cleanups I had, but I ended
up deciding to do nothing.

So for what it's worth I think this is correct:
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

>
> Swap experts, let me know if I'm mistaken :) Otherwise if there is no
> objection I will resend this patch series again for merging.
>
> Nhat Pham (2):
>   swapfile: add a batched variant for swap_duplicate()
>   swap: shmem: remove SWAP_MAP_SHMEM
>
>  include/linux/swap.h | 16 ++++++++--------
>  mm/shmem.c           |  2 +-
>  mm/swapfile.c        | 28 +++++++++-------------------
>  3 files changed, 18 insertions(+), 28 deletions(-)
>
>
> base-commit: acfabf7e197f7a5bedf4749dac1f39551417b049
> --
> 2.43.5

