Return-Path: <linux-kernel+bounces-232706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFAF91AD4E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7179A1F27147
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8585C199EB2;
	Thu, 27 Jun 2024 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ao/PZ+nD"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C7C199EAB
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719507454; cv=none; b=kRKEB38/9RHnIGCro8x1g/808rgTxYlkhPbVOluEiOfoX0iP2ggcTr+zZ1REG14Mj2aeGLIj/XduRZCcyuXfFBWOyiBoEtoJeGerlIIEJz1BnjGz4MF/psloryPyu7NrdXGl848c1VUySyQB86cnjXxhbOzjBGllCkmUQcZ9xEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719507454; c=relaxed/simple;
	bh=FnYTNd4VoG6yJv0fKqSCNSDjS/xt3cKCDoPqBxS46PQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H47phBX93wmHx+2oGetj7lpj7oAFZhrMb4oxEbTXpe5sEIwRvI0mb7x2IpRZcHtMTXGwpDBfEHARNVH1S7xMB2pzjCbAERIqcgz0Kgekt5zAKR6KE9DTARdR5UkEFT0MPeXK1TB9lx2dID+ngE1C4F3wSz9bX1DhyJ8X7TdTQmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ao/PZ+nD; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52ce6c93103so6265042e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 09:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719507451; x=1720112251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i9kjtJnq6QUCFXqe7TVzsRwtJHG6pu+RYcniY0xGCVQ=;
        b=Ao/PZ+nD+azIvC+WX1isTRRGfp9Qq3zpK8uetUS55m53BBQNRpx4zaXpotY6irP9JQ
         bZsGQqDWIF6762+9IpI63Ut1hWBB67P4HCHf4rfvXFCzUh1hPHjKckvTqCaTIV8o2U5r
         NRfo1rY7MBDMhstL2vTZvDi7vrUJsPCv8B47I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719507451; x=1720112251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9kjtJnq6QUCFXqe7TVzsRwtJHG6pu+RYcniY0xGCVQ=;
        b=Z3pKA9GWVy28NpTmYDDRBE+k8EIa0oBTmrmmnspF3eLXvm1cp0+0NR3PbYSY9dh+jT
         endolwL8SJK1ivCpk6D9Z/B7Nazwf5UQru1pwfmfm3jwxsA9UfjU7hCtikIdaT4bZZo0
         itElgPemhd43w8rO7/wnrHkFhoAZvLYC7ObV1vXt8JM7+sigKdcpvwVAaD0B9YKZabIH
         TLDGpsY5B2n01oeMIdD33lCqtQUA64a+nit/42jXFrjVGiJvAR3LYGevmMutX+oC37Jl
         C6TPrgPCGN0oGuujmanPG+YUbK3X7wITr/ayUqU7Ymhff/oQBVnFQ44tfBrXLMgvLEw3
         DJmg==
X-Forwarded-Encrypted: i=1; AJvYcCVktmkbt1d9khugbMG1inG7RjNeUDqFGf7/XLnp0+kb6B9b0FTP+XbhfNaUQcb/ZTYYdPJM0UyFhWM2zjftdUpBysxDmwItZRGff23T
X-Gm-Message-State: AOJu0Yzy+xT1uRoUfokystPkPH0HEn5lYA3E+56XflbFvET6vlGnDuwq
	s6uzyD2hCBiSKdw7Z44vpQPTArzuJvFF8cY/X1v6M8p+f1kTaoQg1NjiOOb5k40sIiMoMi8Nstc
	oeYz/1A==
X-Google-Smtp-Source: AGHT+IGFWD9q9MjOMea089NXKkb3cblQVxuZzFhJ5s9/ob2GwPnxRKzQBfm8YIEAcETdBCtxmD3HOA==
X-Received: by 2002:a05:6512:3986:b0:52d:b226:942a with SMTP id 2adb3069b0e04-52db2269505mr5744820e87.0.1719507450686;
        Thu, 27 Jun 2024 09:57:30 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e71306010sm264201e87.139.2024.06.27.09.57.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 09:57:29 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec002caf3eso124536971fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 09:57:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7UUhB1oYTj/Dn6uW9jzMef242P/SS+ATutXNTYJdwOwHhmBoivOtq2v4Szkekq6+DOQEYzKVtqDwEt8pPwifI3bzA/lenZwI8DqOw
X-Received: by 2002:a2e:6a12:0:b0:2ed:5af6:e846 with SMTP id
 38308e7fff4ca-2ed5af6ea7dmr41715831fa.50.1719507449392; Thu, 27 Jun 2024
 09:57:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406270912.633e6c61-oliver.sang@intel.com> <CAGudoHF7ys8bTCE0G6vLzEbo+_NyQXmAEEGPJ4hx1yoYmBsoUA@mail.gmail.com>
 <CAGudoHFrMkdo1CoVxJUiEvQ_DyW3hzaCz18GjvLi4ny=o-q9ZQ@mail.gmail.com> <CAHk-=wg7PXo_QbBo8gv27OpbMgAwLh9H46kJRxAmp0FL0QD7HA@mail.gmail.com>
In-Reply-To: <CAHk-=wg7PXo_QbBo8gv27OpbMgAwLh9H46kJRxAmp0FL0QD7HA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 27 Jun 2024 09:57:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjkn=yL6vy5s7ZFgBfDybD3Gjg9C72zXchy-JF0Tp+a+A@mail.gmail.com>
Message-ID: <CAHk-=wjkn=yL6vy5s7ZFgBfDybD3Gjg9C72zXchy-JF0Tp+a+A@mail.gmail.com>
Subject: Re: [linux-next:master] [lockref] d042dae6ad: unixbench.throughput
 -33.7% regression
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Jun 2024 at 09:32, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>   getdent subtest:
>       +4.1   lockref_put_return
>       +5.7   lockref_get_not_dead
>      +68.0   native_queued_spin_lock_slowpath

For this getdents load, the main call chains that terminate in the
queued spinlock case seem to be

.lockref_get_not_dead.__legitimize_path.try_to_unlazy_next.lookup_fast
.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast
.lockref_get_not_dead.__legitimize_path.try_to_unlazy.link_path_walk
.dput.terminate_walk.path_openat.do_filp_open

which is interesting because I would have expected the readdir() code
itself to show up.

But the proc_pident_readdir profiles have all gone down, presumably
because there's just much fewer of them. That part shows no spinlock
in the profile at all.

WTH is that benchmark doing? The only readdir that shows up is for
what looks like some /proc filesystem thing.

            Linus

