Return-Path: <linux-kernel+bounces-337931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4E5985124
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9C81C23500
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F62149C4B;
	Wed, 25 Sep 2024 02:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8Inanlf"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D30148FE6
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 02:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727233153; cv=none; b=X/CM/C4kLlL673lNO47uvMxb2ocjVn0tFkTB4jVW2YHT/Sn4BuNojf0/9jxYbOEOGb1g/o8TPncAlL/leMJ+w9YHQbNbPWwoWnj17gYQAmHB0xC0oxvEseURS9ezhYOsV0TGcH6exX80pvgy9ZjGin9lPP82yUJipDfv1AYcJAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727233153; c=relaxed/simple;
	bh=tr/mqHY1JVfF7LAuC2wQuAcW53PtYq64MivxPPBmfTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Spic5SPON72cBhJDEt+Mr6kcJMONSBmSYYKAqy1wFrrKVLPooodxRW23aPZkF4M7E5GDLPr7HInalwOvpD7o2EjOc0STWDZ9FoCGKSmOAJhFMYnf65O1mK1/RbzQIVpxOF02ZYFm82qshNmE9lN1a4lx1vxbBABDC3nh6QY22xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I8Inanlf; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7db299608e7so3969918a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 19:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727233150; x=1727837950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVfLvmOnIG53YlGDmO92j7WTz3UYtu+tC9c2sMgYWIU=;
        b=I8Inanlfh9STbn+4c40p7555oLGfNyAZX9oTnw8c7ozWfbMpn1FkqcVCyY84Clt/Vk
         3OU6gFDKSVv6M5LVANT49Q9WxZ27wEViOVpO6fCKPJyBS2RS7AnkVQ5b/qnFMB24tTao
         O8JYimGjt6ykx7asy+MWzyU8eQqjlfx4Ec0KnUeCTY2woTqEuqMra0LLdS4h/9JNLCrZ
         8PyFvseNXvyffPZVh7PuiRvcfOxV+pLLqkKvKT9KzGnhX41MbFjSKJRZIlPQRi8zXGA8
         mnPeoWCW3tV44LpYmLbMRMCf355a7jbB84NDcY+loeUpuP3pasBVg2u555z6Tk1D5env
         RQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727233150; x=1727837950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVfLvmOnIG53YlGDmO92j7WTz3UYtu+tC9c2sMgYWIU=;
        b=wMr2rTK6WYPD716P2rWIkbmZTuANNFfhNAIMK1LY1O7t5VwRsSydI7rGDV0VCbBAjC
         xWcHOP8mA7xaTjWpBz4fCMxUCj9Uung4mb8sLV1Ub3uUjkycKimgEPVEPLxRIF/LKena
         nT0brnhQ/iejLHx23zEhVsVnYsF+VUh68EriHgczrnRKQ+HrxbYnQQmMTFwAzMj2E9IJ
         Sji6hJj+rMWhWC1E9WIjGkcziT3tVeHOQv7Wtlqs0Azv3l9p+/rFKMxHVjQTPqpTs6zU
         O44A++RpKfabIuYQFwh9dBASy3JLn+MY61RyiEP0pGLzeJLwBNvQlfIJpPiiQQbNqxfw
         /PYg==
X-Forwarded-Encrypted: i=1; AJvYcCVWcXINEzzCqQ+iy8uekGYFSgXsPaal5m8CCuTn7JnoWvz4HjbOZVSa9IbasDjqqM/DvULX6nQRZ1qlcys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0/knMMvPSXE/QCibe/R2nDn/gzY11XPUKyEkOXK1OE1Vm5NwM
	/ENDScCDaKUPPuTiPbhvkiYcziFQmelk2EXwOLpt0ZkTl9jX2gCHlMmILb2cw2XlDEIe1y32RXz
	CM2knkBF9LDMhXlSGNqhENzYrNpjm/DeQpE4H
X-Google-Smtp-Source: AGHT+IFtluJqBBAYZ6QKzBBaqB4nP/G1hpK/Q5MXB615NVHKv1kP6ZGCQ+ewy0/tdksh+svjhxx3qB7kGthFzxE5Dpk=
X-Received: by 2002:a17:90a:c7c4:b0:2c4:b0f0:8013 with SMTP id
 98e67ed59e1d1-2e06ae60997mr1524592a91.11.1727233149682; Tue, 24 Sep 2024
 19:59:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924184401.76043-1-cmllamas@google.com> <20240924184401.76043-2-cmllamas@google.com>
In-Reply-To: <20240924184401.76043-2-cmllamas@google.com>
From: Todd Kjos <tkjos@google.com>
Date: Tue, 24 Sep 2024 19:58:54 -0700
Message-ID: <CAHRSSEyY_GMSAVnAS6D+uM+rNOUaibGwYqiPzKNPyUydA-fpxA@mail.gmail.com>
Subject: Re: [PATCH 1/4] binder: fix node UAF in binder_add_freeze_work()
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
> proc->inner_lock held. However, this lock is temporarily dropped in
> order to acquire the node->lock first (lock nesting order). This can
> race with binder_node_release() and trigger a use-after-free:
>
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   BUG: KASAN: slab-use-after-free in _raw_spin_lock+0xe4/0x19c
>   Write of size 4 at addr ffff53c04c29dd04 by task freeze/640
>
>   CPU: 5 UID: 0 PID: 640 Comm: freeze Not tainted 6.11.0-07343-ga727812a8=
d45 #17
>   Hardware name: linux,dummy-virt (DT)
>   Call trace:
>    _raw_spin_lock+0xe4/0x19c
>    binder_add_freeze_work+0x148/0x478
>    binder_ioctl+0x1e70/0x25ac
>    __arm64_sys_ioctl+0x124/0x190
>
>   Allocated by task 637:
>    __kmalloc_cache_noprof+0x12c/0x27c
>    binder_new_node+0x50/0x700
>    binder_transaction+0x35ac/0x6f74
>    binder_thread_write+0xfb8/0x42a0
>    binder_ioctl+0x18f0/0x25ac
>    __arm64_sys_ioctl+0x124/0x190
>
>   Freed by task 637:
>    kfree+0xf0/0x330
>    binder_thread_read+0x1e88/0x3a68
>    binder_ioctl+0x16d8/0x25ac
>    __arm64_sys_ioctl+0x124/0x190
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Fix the race by taking a temporary reference on the node before
> releasing the proc->inner lock. This ensures the node remains alive
> while in use.
>
> Fixes: d579b04a52a1 ("binder: frozen notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 978740537a1a..4d90203ea048 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -5552,6 +5552,7 @@ static bool binder_txns_pending_ilocked(struct bind=
er_proc *proc)
>
>  static void binder_add_freeze_work(struct binder_proc *proc, bool is_fro=
zen)
>  {
> +       struct binder_node *prev =3D NULL;
>         struct rb_node *n;
>         struct binder_ref *ref;
>
> @@ -5560,7 +5561,10 @@ static void binder_add_freeze_work(struct binder_p=
roc *proc, bool is_frozen)
>                 struct binder_node *node;
>
>                 node =3D rb_entry(n, struct binder_node, rb_node);
> +               binder_inc_node_tmpref_ilocked(node);
>                 binder_inner_proc_unlock(proc);
> +               if (prev)
> +                       binder_put_node(prev);
>                 binder_node_lock(node);
>                 hlist_for_each_entry(ref, &node->refs, node_entry) {
>                         /*
> @@ -5586,10 +5590,13 @@ static void binder_add_freeze_work(struct binder_=
proc *proc, bool is_frozen)
>                         }
>                         binder_inner_proc_unlock(ref->proc);
>                 }
> +               prev =3D node;
>                 binder_node_unlock(node);
>                 binder_inner_proc_lock(proc);
>         }
>         binder_inner_proc_unlock(proc);
> +       if (prev)
> +               binder_put_node(prev);
>  }
>
>  static int binder_ioctl_freeze(struct binder_freeze_info *info,
> --
> 2.46.0.792.g87dc391469-goog
>

