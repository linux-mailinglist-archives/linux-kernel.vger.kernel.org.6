Return-Path: <linux-kernel+bounces-547311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 537DBA505A2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D39161C27
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE8F19F464;
	Wed,  5 Mar 2025 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XAG77zRq"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B4C151992
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741193449; cv=none; b=ZJOJTv+bsNqE5ebhVg2vv3d5DIUjEy8bStwdAg7rLmKIOczu3IWybh/q4yjyrgeuBrZte4fuBHcJrZ3BaJX8aAzU25LfuaKgQWjRbMC/v0c5On67mkTikBB7UualFjHU619cfZAjWF/ulBh5DsxGOfCu/NdqhDJzDam6cUTmZgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741193449; c=relaxed/simple;
	bh=ES3B4ydqeVIBq5AhSYvRXGBPwvfrSwoyy7i06aA6QKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nr0mGVYzxqFXxSmNM3ff4vRB9C5qKVZhX4IAawxkHgWqYkWmwG+ISbXfGAKQLu87cJqJ30UZ2RxEkWbZ68n+1fdMrOQ0ZCaq83Rnuyvr1NDSUVqaKUZFH/4fWQqTL918HBcuGWuDYr9TUYyDASyCFfwZ3NjqLBGJDt6NtRoPpSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XAG77zRq; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abf42913e95so786907766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 08:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741193445; x=1741798245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IKNxmurIaMvHrB/Je+WV/izNtxkUNd8xxxAxHkdSWn8=;
        b=XAG77zRqi256ZBkkXBYBfb/abAuN+FNRLaOlpX75xeI7b34GBRPTs55FqcWL6O9bqx
         JDiD00ps+LuIGYKBP37lmGW91/fj9OadGfvI/rWBAjy5LGp1N/waXNQT8BvmPsBLBfYB
         Jc1/No4VHJCmOfMPEykiPj+gG5jgsPOvLTGsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741193445; x=1741798245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKNxmurIaMvHrB/Je+WV/izNtxkUNd8xxxAxHkdSWn8=;
        b=TesEv7P2xyNpiId9ILJXkrlNBItJ5YWr4jUf13Z2RyFEX2XRrgaNQQW2O9KF8q+WRd
         g3QCqWY9lWCnaSjSLy+qmNsxmBkG9WETrkABoXFU+YN/7p7WmqT18jFHTuDgFiu3/iG9
         cDwdZ8bDEfUUYuEJYrSvG4aDV8fBndT1h0/hSHu9lNm4AufHFibBC3dKlqvc029B++V+
         I+3jSPMPjT8U0vCAqxA3KnXB3BSlI0/ksXH6e/WNAOjarooFdctljRHwI3hkMVF6rmFJ
         YVProSKTZ9pq03vnsAaASFbHmeMAhtFHGnZLflDgQtwow0m8VRfKQK8CCXhMAvU5PYoc
         0bEg==
X-Forwarded-Encrypted: i=1; AJvYcCWxVDSJmQRn639/S1IQLhNaXpaz6JG3b81pZfAuA3O9SEk5dYYpsqzvFyc/RAlInjemC6hIfbaTW9OQxcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUSzY1EfopYcmgeEuG3/0Hdy0x7v9Vdtxe8aRFJ8stk9cJAn4G
	L3GDgdnvpTMR22hZqLHPzBfHg6ghjaTg1xiR5AFo1mKJifLRZV+R2eka/PgTg1qUhvrB3Nn3WfP
	/7foFGw==
X-Gm-Gg: ASbGncspZBx7TOAQpHUfPod/dU7v2KK2i4Zc+UH4oq4fCo+dXcBqr3WnHCx5lG3kNLG
	s60uCmCJTCjoke+/8ecCRPTwwJ//CM5bNKMpGsCMJQ5SYO0ta+D6bMv/saEQ10ifpj2D1cc/Ou/
	v4VFhiApzLBOeUGGcnb54tr3jG5dmGuOMffCsoM3A5fJPkrctG5yQ1Y62gsqI125ziyJUdrv2rA
	yoCJ6oXETGY03iKvnttFOE7YtLAWjQwKC6jCqlrgNrRG/MfA964iaNphADEYLHvIRaR2V7vHKkn
	2KA2pql2XHguWU+4IRLrGv4JIeUtIiKWl/qA76Xjy2fSzLHuwX5+MKl8NDEqSePqRmGNFgobQ+B
	/o3dIeFOJ2lFkM5kNA8s=
X-Google-Smtp-Source: AGHT+IGmDphLvI1T8GpCvIXYvDHYZO2VPJO6uuNL21qt0W0velrmzhsXL8Xjac4nz1HIRTs2A4mnSw==
X-Received: by 2002:a17:907:7245:b0:abf:5fe7:40db with SMTP id a640c23a62f3a-ac20da540b4mr382844466b.31.1741193444980;
        Wed, 05 Mar 2025 08:50:44 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf3a8e2f53sm941138266b.115.2025.03.05.08.50.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 08:50:44 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac1f5157c90so363198266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 08:50:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWO8KiGCy1tPPJKhRXdc668GD5iNbzyt3HtJWQ89UdoQlLbqgQYli5uIbg5X7GPWUVFkvrTJSBjt2i+U04=@vger.kernel.org
X-Received: by 2002:a17:907:7b87:b0:abf:6b14:6cf0 with SMTP id
 a640c23a62f3a-ac20d97e7e8mr378423166b.12.1741193443692; Wed, 05 Mar 2025
 08:50:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228143049.GA17761@redhat.com> <20250228163347.GB17761@redhat.com>
 <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com> <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
 <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
 <741fe214-d534-4484-9cf3-122aabe6281e@amd.com> <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
 <CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com>
 <CAGudoHG2PuhHte91BqrnZi0VbhLBfZVsrFYmYDVrmx4gaLUX3A@mail.gmail.com>
 <CAHk-=whVfFhEq=Hw4boXXqpnKxPz96TguTU5OfnKtCXo0hWgVw@mail.gmail.com>
 <20250303202735.GD9870@redhat.com> <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
 <87h6475w9q.fsf@prevas.dk>
In-Reply-To: <87h6475w9q.fsf@prevas.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 5 Mar 2025 06:50:26 -1000
X-Gmail-Original-Message-ID: <CAHk-=wh6Ra8=dBUTo1vKT5Wao1hFq3+2x1mDwmBcVx2Ahp_rag@mail.gmail.com>
X-Gm-Features: AQ5f1JpWO33IMmOwg7UfUdLzDWyAOlX4zxQSS4AWUM-aJeee9tnDsKOQREulDIo
Message-ID: <CAHk-=wh6Ra8=dBUTo1vKT5Wao1hFq3+2x1mDwmBcVx2Ahp_rag@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Oleg Nesterov <oleg@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, "Sapkal, Swapnil" <swapnil.sapkal@amd.com>, 
	Manfred Spraul <manfred@colorfullife.com>, Christian Brauner <brauner@kernel.org>, 
	David Howells <dhowells@redhat.com>, WangYuli <wangyuli@uniontech.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 05:31, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> On Mon, Mar 03 2025, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > +/*
> > + * We have to declare this outside 'struct pipe_inode_info',
> > + * but then we can't use 'union pipe_index' for an anonymous
> > + * union, so we end up having to duplicate this declaration
> > + * below. Annoying.
> > + */
> > +union pipe_index {
> > +     unsigned long head_tail;
> > +     struct {
> > +             pipe_index_t head;
> > +             pipe_index_t tail;
> > +     };
> > +};
> > +
>
> -fms-extensions ? Willy wanted to add that for use in mm/ some years ago
> [*], and it has come up a few other times as well.
>
> [*] https://lore.kernel.org/lkml/20180419152817.GD25406@bombadil.infradead.org/

Oh, I was unaware of that extension, and yes, it would have been
lovely here, avoiding that duplicate union declaration.

But it does require clang support - I see that clang has a
'-fms-extensions' as well, so it's presumably there.

I don't know if it's worth it for the (small handful) of cases we'd
have in the kernel, but it does seem useful.

                 Linus

