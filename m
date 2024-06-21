Return-Path: <linux-kernel+bounces-225458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6021E9130C4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 01:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D605A1F22809
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B0B16EBFC;
	Fri, 21 Jun 2024 23:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gJGN08q1"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9D182490
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 23:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719011048; cv=none; b=E14hh5CrHoyQ38AA6yoD5DlZf6g7jJXRPEJ5WrQ5dn7qftqmQ7EjemWBuqzCobolSPRQZaT9xUQ8OjoFo/mme/Tb7NkE9tsqTWlAALHEEQExOQwm3wHJLGoMHe0wJpVdZfBklv/Dq16CeJ4tSWGbjIxTbUWdLMngAvXGOByqfPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719011048; c=relaxed/simple;
	bh=LtmWsPMZoRBhKSBBkk24JsnNSXKW2YfxfQ6txvQJk84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOkI9Pu2dVs5Jf8+7OppW3/mDV6brrv371Yj/0gCB7TBrLzUO21/oS01wsbW8sLVTSrj3HZV7w0yF45gTtFo4FtS1YvBIirYj1ZGCkAZn7yFfWfO4oVeDSh1GjOqwx7knTI7ROC2TV+axduGWCqLPzibAzZdSvwHOqgR5tV/xmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gJGN08q1; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-362b32fbb3bso1753298f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 16:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719011044; x=1719615844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyIxA/oNpBTPt4ny609aB/kSdO2414ppktI5EQ6EabI=;
        b=gJGN08q10GooDRBeS/jeo3zkTJ73SpENSwvPjZ6ElCH2orSizH6HyoQcn73LAr7EeC
         mNJ49kV07FAQAGEeRbwEuy97279IVQaxOoGKYG4qUXLpglVoNLKoESo3dLgAhnyKOwZ7
         Yr/8zDNxuo4gB/Wk8KvzckQqL2SFxL0XKNct8LORqeyO0hYwYYkB1o1u+l0zcnbw0C9G
         cYoFwjGy6acbj6BTkVph0V1lB9bQ2wDu9DCKTrj5b/bvt+/1MG5nzAKxg8uVcwWeZkbP
         bypafhRUvviuWj41w4RleGmiX/8Oqb/g2U7kWdakmCei8ZJGfLjsXJ7EnIYtkscgUfQN
         jyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719011044; x=1719615844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyIxA/oNpBTPt4ny609aB/kSdO2414ppktI5EQ6EabI=;
        b=dFrJtrAWuIrmyJ5xxDvd6l4+/s8h8P2uvbPnn9aQ+vQOtloa9azwTXN28IJa/t4K4j
         BVOU+Jn9cMa2CKaax7HHzw5EH+OHgXO6Waicx7c7SmKnQbPOp5WOKLXdsN+NTTO2juB3
         kvdre5R45y6TwD4sc6yQhlm4dPG+Wk3xycpLiPEnxAf6Jn2MFzrJ+Cl3oZSqjCko4fNo
         aoll1XJV4T4AraS3Jo0L+FQWZaCBRJHTIzfKRmtv4flugnCHrwQio7Ge1Gt7Rrq/CJmv
         MLqqwiqXM2tP0xDrtInCapEtlMOdPf0wjBUZ6Kj/VkLcg3Ru0oQUsSlW1GA91lMpd8zf
         00Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVy1EQ4UCS5mMFk/smjJGmy+9z5utIUIH2L5bkzXC41LkRGzI7PwyNiZCScU6lguKE1YeJGzXggiw+I4Nza9qDG2BaDF/YC3ExRWa6c
X-Gm-Message-State: AOJu0YwouAhedUcMgHj++FsPA2jAeKgym6PTvlBiljKT8cD5Whzdgw5z
	/8uldkQE46/vqAnzfDGYZ/2hkXIHM0ivkZZaT1C4B5V+nLXagmjjcxXi5f+eX12gau9t/7U43Wx
	7rRkbqqgXXlyLZcwqAyhF0tP9MmajLN9pscRi
X-Google-Smtp-Source: AGHT+IGdt97m2HbrRSMe6Qgmb/piNElKrTuWxumai62rKRGIt2GILaEk2AU9o+H7bVMrdkha90OYmZU3J/39eOp4IRM=
X-Received: by 2002:adf:f791:0:b0:362:9313:e535 with SMTP id
 ffacd0b85a97d-363192ce38bmr6585083f8f.48.1719011043943; Fri, 21 Jun 2024
 16:04:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ef22d289-eadb-4ed9-863b-fbc922b33d8d@I-love.SAKURA.ne.jp>
In-Reply-To: <ef22d289-eadb-4ed9-863b-fbc922b33d8d@I-love.SAKURA.ne.jp>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Fri, 21 Jun 2024 16:03:25 -0700
Message-ID: <CAJHvVcgfgjPQMxRn09+QKV0G-6AOS6UA7hMbtu2azMquMW4JCA@mail.gmail.com>
Subject: Re: [PATCH] mm: mmap_lock: replace get_memcg_path_buf() with on-stack buffer
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nicolas Saenz Julienne <nsaenzju@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 6:08=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Commit 2b5067a8143e ("mm: mmap_lock: add tracepoints around lock
> acquisition") introduced TRACE_MMAP_LOCK_EVENT() macro using
> preempt_disable() in order to let get_mm_memcg_path() return a percpu
> buffer exclusively used by normal, softirq, irq and NMI contexts
> respectively.
>
> Commit 832b50725373 ("mm: mmap_lock: use local locks instead of disabling
> preemption") replaced preempt_disable() with local_lock(&memcg_paths.lock=
)
> based on an argument that preempt_disable() has to be avoided because
> get_mm_memcg_path() might sleep if PREEMPT_RT=3Dy.
>
> But syzbot started reporting
>
>   inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
>
> and
>
>   inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
>
> messages, for local_lock() does not disable IRQ.
>
> We could replace local_lock() with local_lock_irqsave() in order to
> suppress these messages. But this patch instead replaces percpu buffers
> with on-stack buffer, for the size of each buffer returned by
> get_memcg_path_buf() is only 256 bytes which is tolerable for allocating
>  from current thread's kernel stack memory.
>
> Reported-by: syzbot <syzbot+40905bca570ae6784745@syzkaller.appspotmail.co=
m>
> Closes: https://syzkaller.appspot.com/bug?extid=3D40905bca570ae6784745
> Fixes: 832b50725373 ("mm: mmap_lock: use local locks instead of disabling=
 preemption")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> Only compile tested.
>
>  mm/mmap_lock.c | 175 ++++++-------------------------------------------
>  1 file changed, 20 insertions(+), 155 deletions(-)

No objections. Looking back all the way to the first version [1] the
buffers were already percpu, instead of on the stack like this. IOW,
there was no on-list discussion about why this shouldn't go on the
stack. It has been a while, but if memory serves I opted to do it that
way just out of paranoia around putting large buffers on the stack.
But, I agree 256 bytes isn't all that large.

That v1 patch wasn't all that complex, but then again it didn't deal
with various edge cases properly :) so it has grown significantly more
complex over time. Reconsidering the approach seems reasonable now,
given how much code this removes.

This change looks straightforwardly correct to me. You can take:

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

[1]: https://lore.kernel.org/all/20200917154258.1a364cdf@gandalf.local.home=
/T/

>
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index 1854850b4b89..368b840e7508 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -19,14 +19,7 @@ EXPORT_TRACEPOINT_SYMBOL(mmap_lock_released);
>
>  #ifdef CONFIG_MEMCG
>
> -/*
> - * Our various events all share the same buffer (because we don't want o=
r need
> - * to allocate a set of buffers *per event type*), so we need to protect=
 against
> - * concurrent _reg() and _unreg() calls, and count how many _reg() calls=
 have
> - * been made.
> - */
> -static DEFINE_MUTEX(reg_lock);
> -static int reg_refcount; /* Protected by reg_lock. */
> +static atomic_t reg_refcount;
>
>  /*
>   * Size of the buffer for memcg path names. Ignoring stack trace support=
,
> @@ -34,136 +27,22 @@ static int reg_refcount; /* Protected by reg_lock. *=
/
>   */
>  #define MEMCG_PATH_BUF_SIZE MAX_FILTER_STR_VAL
>
> -/*
> - * How many contexts our trace events might be called in: normal, softir=
q, irq,
> - * and NMI.
> - */
> -#define CONTEXT_COUNT 4
> -
> -struct memcg_path {
> -       local_lock_t lock;
> -       char __rcu *buf;
> -       local_t buf_idx;
> -};
> -static DEFINE_PER_CPU(struct memcg_path, memcg_paths) =3D {
> -       .lock =3D INIT_LOCAL_LOCK(lock),
> -       .buf_idx =3D LOCAL_INIT(0),
> -};
> -
> -static char **tmp_bufs;
> -
> -/* Called with reg_lock held. */
> -static void free_memcg_path_bufs(void)
> -{
> -       struct memcg_path *memcg_path;
> -       int cpu;
> -       char **old =3D tmp_bufs;
> -
> -       for_each_possible_cpu(cpu) {
> -               memcg_path =3D per_cpu_ptr(&memcg_paths, cpu);
> -               *(old++) =3D rcu_dereference_protected(memcg_path->buf,
> -                       lockdep_is_held(&reg_lock));
> -               rcu_assign_pointer(memcg_path->buf, NULL);
> -       }
> -
> -       /* Wait for inflight memcg_path_buf users to finish. */
> -       synchronize_rcu();
> -
> -       old =3D tmp_bufs;
> -       for_each_possible_cpu(cpu) {
> -               kfree(*(old++));
> -       }
> -
> -       kfree(tmp_bufs);
> -       tmp_bufs =3D NULL;
> -}
> -
>  int trace_mmap_lock_reg(void)
>  {
> -       int cpu;
> -       char *new;
> -
> -       mutex_lock(&reg_lock);
> -
> -       /* If the refcount is going 0->1, proceed with allocating buffers=
. */
> -       if (reg_refcount++)
> -               goto out;
> -
> -       tmp_bufs =3D kmalloc_array(num_possible_cpus(), sizeof(*tmp_bufs)=
,
> -                                GFP_KERNEL);
> -       if (tmp_bufs =3D=3D NULL)
> -               goto out_fail;
> -
> -       for_each_possible_cpu(cpu) {
> -               new =3D kmalloc(MEMCG_PATH_BUF_SIZE * CONTEXT_COUNT, GFP_=
KERNEL);
> -               if (new =3D=3D NULL)
> -                       goto out_fail_free;
> -               rcu_assign_pointer(per_cpu_ptr(&memcg_paths, cpu)->buf, n=
ew);
> -               /* Don't need to wait for inflights, they'd have gotten N=
ULL. */
> -       }
> -
> -out:
> -       mutex_unlock(&reg_lock);
> +       atomic_inc(&reg_refcount);
>         return 0;
> -
> -out_fail_free:
> -       free_memcg_path_bufs();
> -out_fail:
> -       /* Since we failed, undo the earlier ref increment. */
> -       --reg_refcount;
> -
> -       mutex_unlock(&reg_lock);
> -       return -ENOMEM;
>  }
>
>  void trace_mmap_lock_unreg(void)
>  {
> -       mutex_lock(&reg_lock);
> -
> -       /* If the refcount is going 1->0, proceed with freeing buffers. *=
/
> -       if (--reg_refcount)
> -               goto out;
> -
> -       free_memcg_path_bufs();
> -
> -out:
> -       mutex_unlock(&reg_lock);
> -}
> -
> -static inline char *get_memcg_path_buf(void)
> -{
> -       struct memcg_path *memcg_path =3D this_cpu_ptr(&memcg_paths);
> -       char *buf;
> -       int idx;
> -
> -       rcu_read_lock();
> -       buf =3D rcu_dereference(memcg_path->buf);
> -       if (buf =3D=3D NULL) {
> -               rcu_read_unlock();
> -               return NULL;
> -       }
> -       idx =3D local_add_return(MEMCG_PATH_BUF_SIZE, &memcg_path->buf_id=
x) -
> -             MEMCG_PATH_BUF_SIZE;
> -       return &buf[idx];
> +       atomic_dec(&reg_refcount);
>  }
>
> -static inline void put_memcg_path_buf(void)
> -{
> -       local_sub(MEMCG_PATH_BUF_SIZE, &this_cpu_ptr(&memcg_paths)->buf_i=
dx);
> -       rcu_read_unlock();
> -}
> -
> -#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                            =
       \
> -       do {                                                             =
      \
> -               const char *memcg_path;                                  =
      \
> -               local_lock(&memcg_paths.lock);                           =
      \
> -               memcg_path =3D get_mm_memcg_path(mm);                    =
        \
> -               trace_mmap_lock_##type(mm,                               =
      \
> -                                      memcg_path !=3D NULL ? memcg_path =
: "",   \
> -                                      ##__VA_ARGS__);                   =
      \
> -               if (likely(memcg_path !=3D NULL))                        =
        \
> -                       put_memcg_path_buf();                            =
      \
> -               local_unlock(&memcg_paths.lock);                         =
      \
> +#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                    \
> +       do {                                                    \
> +               char buf[MEMCG_PATH_BUF_SIZE];                  \
> +               get_mm_memcg_path(mm, buf, sizeof(buf));        \
> +               trace_mmap_lock_##type(mm, buf, ##__VA_ARGS__); \
>         } while (0)
>
>  #else /* !CONFIG_MEMCG */
> @@ -185,37 +64,23 @@ void trace_mmap_lock_unreg(void)
>  #ifdef CONFIG_TRACING
>  #ifdef CONFIG_MEMCG
>  /*
> - * Write the given mm_struct's memcg path to a percpu buffer, and return=
 a
> - * pointer to it. If the path cannot be determined, or no buffer was ava=
ilable
> - * (because the trace event is being unregistered), NULL is returned.
> - *
> - * Note: buffers are allocated per-cpu to avoid locking, so preemption m=
ust be
> - * disabled by the caller before calling us, and re-enabled only after t=
he
> - * caller is done with the pointer.
> - *
> - * The caller must call put_memcg_path_buf() once the buffer is no longe=
r
> - * needed. This must be done while preemption is still disabled.
> + * Write the given mm_struct's memcg path to a buffer. If the path canno=
t be
> + * determined or the trace event is being unregistered, empty string is =
written.
>   */
> -static const char *get_mm_memcg_path(struct mm_struct *mm)
> +static void get_mm_memcg_path(struct mm_struct *mm, char *buf, size_t bu=
flen)
>  {
> -       char *buf =3D NULL;
> -       struct mem_cgroup *memcg =3D get_mem_cgroup_from_mm(mm);
> +       struct mem_cgroup *memcg;
>
> +       buf[0] =3D '\0';
> +       /* No need to get path if no trace event is registered. */
> +       if (!atomic_read(&reg_refcount))
> +               return;
> +       memcg =3D get_mem_cgroup_from_mm(mm);
>         if (memcg =3D=3D NULL)
> -               goto out;
> -       if (unlikely(memcg->css.cgroup =3D=3D NULL))
> -               goto out_put;
> -
> -       buf =3D get_memcg_path_buf();
> -       if (buf =3D=3D NULL)
> -               goto out_put;
> -
> -       cgroup_path(memcg->css.cgroup, buf, MEMCG_PATH_BUF_SIZE);
> -
> -out_put:
> +               return;
> +       if (memcg->css.cgroup)
> +               cgroup_path(memcg->css.cgroup, buf, buflen);
>         css_put(&memcg->css);
> -out:
> -       return buf;
>  }
>
>  #endif /* CONFIG_MEMCG */
> --
> 2.43.0
>

