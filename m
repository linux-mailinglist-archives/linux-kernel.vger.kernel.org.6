Return-Path: <linux-kernel+bounces-337934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2DE98512B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F350C2854EE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F15F1474BF;
	Wed, 25 Sep 2024 03:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aIE/MlP/"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DD7322A
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 03:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727233441; cv=none; b=OBLZGw1Dx7CkfZmdUZIio+vrboaFKpdKftwQA6wB0nh5Tz+dH8cnGXg8eO75Ixq1l4aqOZf+yKKqGw8pwsSWEuYtJPwKodO2E2jg00j/veC6L/FPqQGE8XU0pjNShtnynv76zWB2H3zGJSgp0LU5sjfd7KLN2SeQP2eHrU5bX9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727233441; c=relaxed/simple;
	bh=5r+59I4CQWy7k3kWiJKNOO3s4nDuPYlsN7QUQ5XOxJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6aDfs0J9cgVTTDEsn9zan+KK/bRrVi0YQZt1oRx2urMQ341XLR8F4QU52aLIKwK+ZWoeWvLFtjl2SSCHB+KwSoHe37MXpZqQ80AcFDdSsYAOR2bTBbccjALdNviCbDyeCP9B14nbzSZx41FVK78NpmzGT5jX/Lfq8ZYY33SzQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aIE/MlP/; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-374b9761eecso4665527f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727233438; x=1727838238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMJlftRu1ApM29AbQaY0rClUx7D4m9+/I+WKgrmVBvo=;
        b=aIE/MlP/fBCCU3HcbFb5VhZKiguzU/vN6E/a0o4XMP793KasXRBNAITk/QBmCyqLHO
         KqmM0MpwzZGz2hE3Efkxn9GZvuZeZlRM4k5eA+/GDF6tO/7UQtWZHHYBtz0cEf9gz/NG
         q/pilfz1oewufKXDuto6v1aRPIv6zaCUK/cP8qcKlz193OgZLq68ZZweE4HiFlJTz7Ai
         6918ojTImfntqaf3En0bcbQKcqDhbGT4l4fbgWN8BEgBp1oYEN15FkzSGqaFUPbQPLLq
         tyNjUWOskLmpRSJ0SQc/35RisUnMZxbceYWLqRoMfJVNQtRixRh4ZFpZwKSmBWMIBY1Z
         lGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727233438; x=1727838238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMJlftRu1ApM29AbQaY0rClUx7D4m9+/I+WKgrmVBvo=;
        b=rzEaYl0KkyoQ6PVk1JxXt57jxyrpVa+6sAF6wgpY5M6HjjQQso3HceuhqYpKJP5F7P
         8l/JV5s1feUa/Xjeb3G9u5ZTEBwjvTeKjQOJsw0zIQAQQcAxYpsPyD2imA4E5Em4ZH8x
         Bp/9j5dw6gGoeAJrc61FLFx2ZZDCanz+8D5b82YpUQi9bdLLjD6FnuGPHR4n4x/ZB4Cl
         GC98+IRQTtmW4aWcPikfMWIRzTtbz5vXgSAc/q+/N1RoBEl/BNBFT7Rj1OgJkJ3aWR57
         8x8OeamKLCzUKwbmYX1+k2fq5NZN/QsIc8KcQs3L1OT0qdFDy3ebGJHF35JvVrB+QqSy
         O2Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWMrHlWKuhC5VFYC2RFwotxNcmTpIVcCCaMKUWAK5wIcmH8giHwPDbaTUCMmPjZpkFCtCFrWCKZFZkZcsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbw7RPq7hla/Xk2WaKlmAcjeYMvD8rUw3tdP4Ek54OE9QKeNXW
	kf5GrADbxD2chF/9tuKnEP8UtMca6/GST5exwqhS1OHVKlbXQhZcKxhh8awXhGY339o8DZujGA5
	uTYkcvpkRFxaxzgEZ4EKwdgsMcmam17MMnHzL
X-Google-Smtp-Source: AGHT+IG2j/0dt7YxVgpp7ZQ0AxTB1QUg2S+QpxCnQrkO42UAv2CeqHvLJ3hpHRv/UQeMcZscbY7Ax27lYgymygp3JfM=
X-Received: by 2002:adf:f310:0:b0:371:8f32:557e with SMTP id
 ffacd0b85a97d-37cc24c5aa8mr697626f8f.39.1727233437950; Tue, 24 Sep 2024
 20:03:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924184401.76043-1-cmllamas@google.com> <20240924184401.76043-3-cmllamas@google.com>
In-Reply-To: <20240924184401.76043-3-cmllamas@google.com>
From: Todd Kjos <tkjos@google.com>
Date: Tue, 24 Sep 2024 20:03:40 -0700
Message-ID: <CAHRSSEwwppkYzxV3XYt=SaWTiFTEkMPC40KJi=zgyr7S5=XTpQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] binder: fix OOB in binder_add_freeze_work()
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Yu-Ting Tseng <yutingtseng@google.com>, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 11:44=E2=80=AFAM Carlos Llamas <cmllamas@google.com=
> wrote:
>
> In binder_add_freeze_work() we iterate over the proc->nodes with the
> proc->inner_lock held. However, this lock is temporarily dropped to
> acquire the node->lock first (lock nesting order). This can race with
> binder_deferred_release() which removes the nodes from the proc->nodes
> rbtree and adds them into binder_dead_nodes list. This leads to a broken
> iteration in binder_add_freeze_work() as rb_next() will use data from
> binder_dead_nodes, triggering an out-of-bounds access:
>
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   BUG: KASAN: global-out-of-bounds in rb_next+0xfc/0x124
>   Read of size 8 at addr ffffcb84285f7170 by task freeze/660
>
>   CPU: 8 UID: 0 PID: 660 Comm: freeze Not tainted 6.11.0-07343-ga727812a8=
d45 #18
>   Hardware name: linux,dummy-virt (DT)
>   Call trace:
>    rb_next+0xfc/0x124
>    binder_add_freeze_work+0x344/0x534
>    binder_ioctl+0x1e70/0x25ac
>    __arm64_sys_ioctl+0x124/0x190
>
>   The buggy address belongs to the variable:
>    binder_dead_nodes+0x10/0x40
>   [...]
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This is possible because proc->nodes (rbtree) and binder_dead_nodes
> (list) share entries in binder_node through a union:
>
>         struct binder_node {
>         [...]
>                 union {
>                         struct rb_node rb_node;
>                         struct hlist_node dead_node;
>                 };
>
> Fix the race by checking that the proc is still alive. If not, simply
> break out of the iteration.
>
> Fixes: d579b04a52a1 ("binder: frozen notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 4d90203ea048..8bca2de6fa24 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -5593,6 +5593,8 @@ static void binder_add_freeze_work(struct binder_pr=
oc *proc, bool is_frozen)
>                 prev =3D node;
>                 binder_node_unlock(node);
>                 binder_inner_proc_lock(proc);
> +               if (proc->is_dead)
> +                       break;
>         }
>         binder_inner_proc_unlock(proc);
>         if (prev)
> --
> 2.46.0.792.g87dc391469-goog
>

