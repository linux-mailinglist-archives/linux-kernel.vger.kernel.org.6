Return-Path: <linux-kernel+bounces-238752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB58924F9A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B541C228F0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 03:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF78179A7;
	Wed,  3 Jul 2024 03:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHKu7kZr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686D910A1F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 03:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719977475; cv=none; b=FMnzLCMNEfGxmkX2QGCqkYoS7LlO7rNc7Ok53R0GE+mp1TQ7BGiSn+gY4hRU+xmkH7J893u4FKQEK6a4oxZXgDbu71+/BNuqt9Wz18D/8u02y2+HCCozIZ+VkVefgbxc5G5BLOEcmihiKzSl27Pm9RT623D0E3hD2JLAfxDl6TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719977475; c=relaxed/simple;
	bh=Ntgv1RmGQvZEExr5kYNNuFVZ13m+/Y6h9Yh+Z/69C94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ab2fvyh8HY1W8TRi5/5NE4eWjeSh8M9NueTNkuPhQarWQS+AQskudxSp3n+/6x6GwspAS0ITJTJz+iJgfkyajvvDMinPKid8gDymyKoVZas3HQIxf9AYEZZ0BhGREyLAdO2uV5M9kV0GdrH0jqBAF5WacakclQXC8OyopzEzowc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHKu7kZr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719977472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdbEpW+ka8BV0EfHU5IhEH8Kwx89A+Qt9tjxCITxu5w=;
	b=BHKu7kZrwKXBjDRH+Mgn17SXVSaUXUYqFTzl65+MUhNvLEMl93+BVtD8K24yWMsWp5oM7J
	bS131oDZQ65p5x02z9xDqBLYQSbom+966fLktsk37CSr2/nwYP5Ourkz3g4/wFHL1aGjLk
	3lRtQolvlt5RSwuP1iZBVv6ToCQ1m9A=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-vhZrDt5fMjiZV-9x3-MEJw-1; Tue, 02 Jul 2024 23:31:09 -0400
X-MC-Unique: vhZrDt5fMjiZV-9x3-MEJw-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-48f589e9643so238649137.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 20:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719977468; x=1720582268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdbEpW+ka8BV0EfHU5IhEH8Kwx89A+Qt9tjxCITxu5w=;
        b=o14+2pvq2iHxoISm3vmCrJaecVb0nNlT/RM52LwT+0SnkkvTgMkFlqb8+Fn4G33GKn
         uOifGFQEqE4GmLoU0sfSgmYu/Dmzr3LeeH08XNDjuwcBOAFqFyJNArKfwgqCl2VK3emA
         I0xcwlKEvZ7sMdqyzWbFWgtVPGesZ0Wr+mBXSMMfNYtPRKqbZ1cidV3Xt4YH8/RQnDwU
         QdUG2HBggwFEFCvYT5lEJinMQEAlMnCkSqaV0qTST+FzpYxgjn3bBu9I6GJPpVa6UOim
         e2qafEIYckFJK8N5VbAF0DtBgBIqayayuTCSbgAPifM7lsG8lUmnEWc58xHEkpCppIOn
         X4hg==
X-Forwarded-Encrypted: i=1; AJvYcCUZNiyHNxtdQxMey1mJjn8N90/k/+VqOgaBIO4+FQLx/Eri7e4OWEp6uw9gMZHEK0uvZ0w5HF3jhsGAwvt1TK2WKXh0BusnzOZcraH0
X-Gm-Message-State: AOJu0YxelFKGtKtswyHo2ljznd9ff8bf64xqjO0q6G6sVGvEycYXO1ok
	+iaYnHr/RWsgJAnF/8uHruCfT2MfhWuvMn7Tc5TlOjMJLH4ltL8KRR/N6TptrDWRN9aU+jmRsAZ
	3cEBOmWDDAqkaGREFt0DK6jr2YYJW5YLrFG4Mq++MdUWo3ox7Z9WQgBFo38IwATAIZqLWZbmRLC
	nmphZ9u/Mp+WF/jtHvwvt9PE6MsoLwaY6LjPm3JOXss96+9M8=
X-Received: by 2002:a05:6102:418e:b0:48f:df2c:6d58 with SMTP id ada2fe7eead31-48fdf2c7213mr459635137.3.1719977468403;
        Tue, 02 Jul 2024 20:31:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq36iZHffY05mQHqGwXuTfgtcDXU9owjtWovlD+KLAjq9PvpntYYFlSgObgHSBSnsI4qjVbXMlcxCuzralhu4=
X-Received: by 2002:a05:6102:418e:b0:48f:df2c:6d58 with SMTP id
 ada2fe7eead31-48fdf2c7213mr459624137.3.1719977468074; Tue, 02 Jul 2024
 20:31:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703022807.642115-1-yang.yang@vivo.com>
In-Reply-To: <20240703022807.642115-1-yang.yang@vivo.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 3 Jul 2024 11:30:57 +0800
Message-ID: <CAFj5m9KfY+0r8eR-ThS7FF+xTnLaWGVrC4vT01LUChVQMqqzUA@mail.gmail.com>
Subject: Re: [PATCH v5] sbitmap: fix io hung due to race on sbitmap_word::cleared
To: Yang Yang <yang.yang@vivo.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 10:28=E2=80=AFAM Yang Yang <yang.yang@vivo.com> wrot=
e:
>
> Configuration for sbq:
>   depth=3D64, wake_batch=3D6, shift=3D6, map_nr=3D1
>
> 1. There are 64 requests in progress:
>   map->word =3D 0xFFFFFFFFFFFFFFFF
> 2. After all the 64 requests complete, and no more requests come:
>   map->word =3D 0xFFFFFFFFFFFFFFFF, map->cleared =3D 0xFFFFFFFFFFFFFFFF
> 3. Now two tasks try to allocate requests:
>   T1:                                       T2:
>   __blk_mq_get_tag                          .
>   __sbitmap_queue_get                       .
>   sbitmap_get                               .
>   sbitmap_find_bit                          .
>   sbitmap_find_bit_in_word                  .
>   __sbitmap_get_word  -> nr=3D-1              __blk_mq_get_tag
>   sbitmap_deferred_clear                    __sbitmap_queue_get
>   /* map->cleared=3D0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
>     if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
>       return false;                         __sbitmap_get_word -> nr=3D-1
>     mask =3D xchg(&map->cleared, 0)           sbitmap_deferred_clear
>     atomic_long_andnot()                    /* map->cleared=3D0 */
>                                               if (!(map->cleared))
>                                                 return false;
>                                      /*
>                                       * map->cleared is cleared by T1
>                                       * T2 fail to acquire the tag
>                                       */
>
> 4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
> up due to the wake_batch being set at 6. If no more requests come, T1
> will wait here indefinitely.
>
> This patch achieves two purposes:
> 1. Check on ->cleared and update on both ->cleared and ->word need to
> be done atomically, and using spinlock could be the simplest solution.
> So revert commit 661d4f55a794 ("sbitmap: remove swap_lock"), which
> may cause potential race.
>
> 2. Add extra check in sbitmap_deferred_clear(), to identify whether
> ->word has free bits.
>
> Fixes: 661d4f55a794 ("sbitmap: remove swap_lock")
> Signed-off-by: Yang Yang <yang.yang@vivo.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


