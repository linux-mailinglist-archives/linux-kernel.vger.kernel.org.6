Return-Path: <linux-kernel+bounces-262847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F298593CDCB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8063B1F22883
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 05:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD25B154C0D;
	Fri, 26 Jul 2024 05:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVTT4DVo"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F048614F9E9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 05:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721972917; cv=none; b=L7/Bz+qR6mXL8eMNaAJIjCmtv8AcNN+PiXsIvZ9+P6JZzOO99NW8quUS7bgnYVF+f9RM6s5egAEV8oFsL4YnTAIFVm1d7IcJnrZpt6yN20u9dqJrmH0FDeishvguekUp65kGduGLEUuo8+gXkGREB897jQruNWEPV66bQGb4VMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721972917; c=relaxed/simple;
	bh=9lZoynuoJR8VgAltwVwSUs7rIhDBbO34C2CGs54yOJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1ErnJ8atjPfqbLF52XTxRAgm9V3LTlX/UHwPlgQOpkcEvDyzhcr9GD0xPHc31AbdTy1f9SXz+wVnYgTSNjRkYrFhqpFSa/ahhKldR94ZPfFyrrkDB60ZEfX2YUP8YEOsaU3w1Km82aIyRk4hQK9kjjb0qwpXdSJ0tBGvhoPp58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVTT4DVo; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-8317511fd45so201535241.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 22:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721972915; x=1722577715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hy5D98gcl/1BnDRFM+BAfO5v9QO7gyFhD3TGX62j7pI=;
        b=mVTT4DVopgfNz49E5tLpT8xz9bcImda/qmWXO9IGXp7VJJaawDLI7xAjho2a1mSFMQ
         GLra0qwL48P65Bxq0WUsS5FzZsnt5j24d8QEPiTYJM1pbJmm2ekcy9A07EKbp93AOPXo
         lZX/+5g+/OlmBGiva/qgb9ZcL0PlNkxNr/sTKAe333fDS1dSeZiCFBSDJm7xkbviCFr/
         IKG68JXkZkMPj5hUE1zBMxhvvuOYJ/ZubA2wdMGSRRxOHhxIGHnUOIIC/N1j8AtMBcIn
         A5Y03U/6Pv7/cy9U95C+ZEQfREfaK8LcjmqOvuoXC4vyyya6VYDBh3tn7/sINKu2KHGJ
         mgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721972915; x=1722577715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hy5D98gcl/1BnDRFM+BAfO5v9QO7gyFhD3TGX62j7pI=;
        b=MhC9GBajPgaqaFemuqjFqRdkv36wUt4qT6OPdSR4mUjnEeHWSoiOubU2rvtXyLPuF8
         mmRGMzenpA4exLnqefC+5QhuCp0FyYigFEWsUP6UbbltGV8OdJQKjf0eX8GE1D1pLfTV
         adWN3MuuOVP1eAvGM3rzlxhF3PZ9zWnPmXzcWYalej1Knb14oJNMes5Y4dGc0gA0EJRk
         0S9CMbADKPwApcTBW7xTllp5a4z9zrgpBfVCEbCsSKH37qNy5xN8R7jrEKsRET017ezi
         s+ujomiPX8auy7pruKf0yWPkecS0nFEzGMz4tYXCyrlMfQytD5Of3ozMk/LXQ0aD8SuZ
         xaRw==
X-Forwarded-Encrypted: i=1; AJvYcCXmaHcJSSFv0w9Qy3fODgNixI0mlbFiV6YcBDiPGGpjV5VVR0/VjY1xlRwVD7We7cjTQ3hmAvfGALo+Y19XWvbmeRZnBI1HEhvHo3Wr
X-Gm-Message-State: AOJu0YynxeD70lPdWaI+obpqKSqulQ2CcGhaIvqJVzGIelRhKQPb3pFg
	x3VwCzbbDKzdxYXeygKfqL3it1NlCLh/objBqxTTvVZu/FFFoVLoxISueegmDaSezkVlqDIW/SO
	ntfgYlKEBVn0ur+vx2FOyNuqOCX1Sf+6A
X-Google-Smtp-Source: AGHT+IE9oeiL/wJOo0MKl9cc7tMnZ+Q6MfaeQ9IxdDIXNgdUTv6jZ8X3DZBEt0VIz/6ymTn0XeMNZp8fOOAGbNvPeL4=
X-Received: by 2002:a05:6102:508e:b0:493:b1e1:9dd4 with SMTP id
 ada2fe7eead31-493c5a0f8f4mr5595324137.4.1721972914535; Thu, 25 Jul 2024
 22:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711021317.596178-1-yuzhao@google.com> <20240711021317.596178-6-yuzhao@google.com>
In-Reply-To: <20240711021317.596178-6-yuzhao@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 26 Jul 2024 17:48:23 +1200
Message-ID: <CAGsJ_4y0cZwpKmYySdPObXLGaohwOZtKq=kcF4e4tXb22JkNTw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 5/5] mm/swap: remove boilerplate
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 2:15=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> Remove boilerplate by using a macro to choose the corresponding lock
> and handler for each folio_batch in cpu_fbatches.
>
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  mm/swap.c | 107 +++++++++++++++++++-----------------------------------
>  1 file changed, 37 insertions(+), 70 deletions(-)
>
> diff --git a/mm/swap.c b/mm/swap.c
> index 4a66d2f87f26..342ff4e39ba4 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -220,16 +220,45 @@ static void folio_batch_move_lru(struct folio_batch=
 *fbatch, move_fn_t move_fn)
>         folios_put(fbatch);
>  }
>
> -static void folio_batch_add_and_move(struct folio_batch *fbatch,
> -               struct folio *folio, move_fn_t move_fn)
> +static void __folio_batch_add_and_move(struct folio_batch *fbatch,
> +               struct folio *folio, move_fn_t move_fn,
> +               bool on_lru, bool disable_irq)
>  {
> +       unsigned long flags;
> +
> +       folio_get(folio);
> +
> +       if (on_lru && !folio_test_clear_lru(folio)) {
> +               folio_put(folio);
> +               return;
> +       }
> +
>         if (folio_batch_add(fbatch, folio) && !folio_test_large(folio) &&
>             !lru_cache_disabled())
>                 return;
>
> +       if (disable_irq)
> +               local_lock_irqsave(&cpu_fbatches.lock_irq, flags);
> +       else
> +               local_lock(&cpu_fbatches.lock);
> +
>         folio_batch_move_lru(fbatch, move_fn);
> +
> +       if (disable_irq)
> +               local_unlock_irqrestore(&cpu_fbatches.lock_irq, flags);
> +       else
> +               local_unlock(&cpu_fbatches.lock);
>  }
>
> +#define folio_batch_add_and_move(folio, op, on_lru)                     =
                       \
> +       __folio_batch_add_and_move(                                      =
                       \
> +               this_cpu_ptr(&cpu_fbatches.op),                          =
                       \
> +               folio,                                                   =
                       \
> +               op,                                                      =
                       \
> +               on_lru,                                                  =
                       \
> +               offsetof(struct cpu_fbatches, op) > offsetof(struct cpu_f=
batches, lock_irq)     \
> +       )

I am running into this BUG, is it relevant?

/ # [   64.908801] check_preemption_disabled: 1804 callbacks suppressed
[   64.908915] BUG: using smp_processor_id() in preemptible [00000000]
code: jbd2/vda-8/96
[   64.909912] caller is debug_smp_processor_id+0x20/0x30
[   64.911743] CPU: 0 UID: 0 PID: 96 Comm: jbd2/vda-8 Not tainted
6.10.0-gef32eccacce2 #59
[   64.912373] Hardware name: linux,dummy-virt (DT)
[   64.912741] Call trace:
[   64.913048]  dump_backtrace+0x9c/0x100
[   64.913414]  show_stack+0x20/0x38
[   64.913761]  dump_stack_lvl+0xc4/0x150
[   64.914197]  dump_stack+0x18/0x28
[   64.914557]  check_preemption_disabled+0xd8/0x120
[   64.914944]  debug_smp_processor_id+0x20/0x30
[   64.915321]  folio_add_lru+0x30/0xa8
[   64.915680]  filemap_add_folio+0xe4/0x118
[   64.916082]  __filemap_get_folio+0x178/0x450
[   64.916455]  __getblk_slow+0xb0/0x310
[   64.916816]  bdev_getblk+0x94/0xc0
[   64.917169]  jbd2_journal_get_descriptor_buffer+0x6c/0x1b0
[   64.917590]  jbd2_journal_commit_transaction+0x7f0/0x1c88
[   64.917994]  kjournald2+0xd4/0x278
[   64.918344]  kthread+0x11c/0x128
[   64.918693]  ret_from_fork+0x10/0x20
[   64.928277] BUG: using smp_processor_id() in preemptible [00000000]
code: jbd2/vda-8/96
[   64.928878] caller is debug_smp_processor_id+0x20/0x30
[   64.929381] CPU: 0 UID: 0 PID: 96 Comm: jbd2/vda-8 Not tainted
6.10.0-gef32eccacce2 #59
[   64.929886] Hardware name: linux,dummy-virt (DT)
[   64.930252] Call trace:
[   64.930544]  dump_backtrace+0x9c/0x100
[   64.930907]  show_stack+0x20/0x38
[   64.931255]  dump_stack_lvl+0xc4/0x150
[   64.931616]  dump_stack+0x18/0x28
[   64.932022]  check_preemption_disabled+0xd8/0x120
[   64.932486]  debug_smp_processor_id+0x20/0x30
[   64.933023]  folio_add_lru+0x30/0xa8
[   64.933523]  filemap_add_folio+0xe4/0x118
[   64.933892]  __filemap_get_folio+0x178/0x450
[   64.934265]  __getblk_slow+0xb0/0x310
[   64.934626]  bdev_getblk+0x94/0xc0
[   64.934977]  jbd2_journal_get_descriptor_buffer+0x6c/0x1b0
[   64.935418]  journal_submit_commit_record.part.0.constprop.0+0x48/0x288
[   64.935919]  jbd2_journal_commit_transaction+0x1590/0x1c88
[   64.936519]  kjournald2+0xd4/0x278
[   64.936908]  kthread+0x11c/0x128
[   64.937323]  ret_from_fork+0x10/0x20

> +
>  static void lru_move_tail(struct lruvec *lruvec, struct folio *folio)
>  {
>         if (folio_test_unevictable(folio))
> @@ -250,23 +279,11 @@ static void lru_move_tail(struct lruvec *lruvec, st=
ruct folio *folio)
>   */
>  void folio_rotate_reclaimable(struct folio *folio)
>  {
> -       struct folio_batch *fbatch;
> -       unsigned long flags;
> -
>         if (folio_test_locked(folio) || folio_test_dirty(folio) ||
>             folio_test_unevictable(folio))
>                 return;
>
> -       folio_get(folio);
> -       if (!folio_test_clear_lru(folio)) {
> -               folio_put(folio);
> -               return;
> -       }
> -
> -       local_lock_irqsave(&cpu_fbatches.lock_irq, flags);
> -       fbatch =3D this_cpu_ptr(&cpu_fbatches.lru_move_tail);
> -       folio_batch_add_and_move(fbatch, folio, lru_move_tail);
> -       local_unlock_irqrestore(&cpu_fbatches.lock_irq, flags);
> +       folio_batch_add_and_move(folio, lru_move_tail, true);
>  }
>
>  void lru_note_cost(struct lruvec *lruvec, bool file,
> @@ -355,21 +372,10 @@ static void folio_activate_drain(int cpu)
>
>  void folio_activate(struct folio *folio)
>  {
> -       struct folio_batch *fbatch;
> -
>         if (folio_test_active(folio) || folio_test_unevictable(folio))
>                 return;
>
> -       folio_get(folio);
> -       if (!folio_test_clear_lru(folio)) {
> -               folio_put(folio);
> -               return;
> -       }
> -
> -       local_lock(&cpu_fbatches.lock);
> -       fbatch =3D this_cpu_ptr(&cpu_fbatches.lru_activate);
> -       folio_batch_add_and_move(fbatch, folio, lru_activate);
> -       local_unlock(&cpu_fbatches.lock);
> +       folio_batch_add_and_move(folio, lru_activate, true);
>  }
>
>  #else
> @@ -513,8 +519,6 @@ EXPORT_SYMBOL(folio_mark_accessed);
>   */
>  void folio_add_lru(struct folio *folio)
>  {
> -       struct folio_batch *fbatch;
> -
>         VM_BUG_ON_FOLIO(folio_test_active(folio) &&
>                         folio_test_unevictable(folio), folio);
>         VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
> @@ -524,11 +528,7 @@ void folio_add_lru(struct folio *folio)
>             lru_gen_in_fault() && !(current->flags & PF_MEMALLOC))
>                 folio_set_active(folio);
>
> -       folio_get(folio);
> -       local_lock(&cpu_fbatches.lock);
> -       fbatch =3D this_cpu_ptr(&cpu_fbatches.lru_add);
> -       folio_batch_add_and_move(fbatch, folio, lru_add);
> -       local_unlock(&cpu_fbatches.lock);
> +       folio_batch_add_and_move(folio, lru_add, false);
>  }
>  EXPORT_SYMBOL(folio_add_lru);
>
> @@ -702,22 +702,11 @@ void lru_add_drain_cpu(int cpu)
>   */
>  void deactivate_file_folio(struct folio *folio)
>  {
> -       struct folio_batch *fbatch;
> -
>         /* Deactivating an unevictable folio will not accelerate reclaim =
*/
>         if (folio_test_unevictable(folio))
>                 return;
>
> -       folio_get(folio);
> -       if (!folio_test_clear_lru(folio)) {
> -               folio_put(folio);
> -               return;
> -       }
> -
> -       local_lock(&cpu_fbatches.lock);
> -       fbatch =3D this_cpu_ptr(&cpu_fbatches.lru_deactivate_file);
> -       folio_batch_add_and_move(fbatch, folio, lru_deactivate_file);
> -       local_unlock(&cpu_fbatches.lock);
> +       folio_batch_add_and_move(folio, lru_deactivate_file, true);
>  }
>
>  /*
> @@ -730,21 +719,10 @@ void deactivate_file_folio(struct folio *folio)
>   */
>  void folio_deactivate(struct folio *folio)
>  {
> -       struct folio_batch *fbatch;
> -
>         if (folio_test_unevictable(folio) || !(folio_test_active(folio) |=
| lru_gen_enabled()))
>                 return;
>
> -       folio_get(folio);
> -       if (!folio_test_clear_lru(folio)) {
> -               folio_put(folio);
> -               return;
> -       }
> -
> -       local_lock(&cpu_fbatches.lock);
> -       fbatch =3D this_cpu_ptr(&cpu_fbatches.lru_deactivate);
> -       folio_batch_add_and_move(fbatch, folio, lru_deactivate);
> -       local_unlock(&cpu_fbatches.lock);
> +       folio_batch_add_and_move(folio, lru_deactivate, true);
>  }
>
>  /**
> @@ -756,22 +734,11 @@ void folio_deactivate(struct folio *folio)
>   */
>  void folio_mark_lazyfree(struct folio *folio)
>  {
> -       struct folio_batch *fbatch;
> -
>         if (!folio_test_anon(folio) || !folio_test_swapbacked(folio) ||
>             folio_test_swapcache(folio) || folio_test_unevictable(folio))
>                 return;
>
> -       folio_get(folio);
> -       if (!folio_test_clear_lru(folio)) {
> -               folio_put(folio);
> -               return;
> -       }
> -
> -       local_lock(&cpu_fbatches.lock);
> -       fbatch =3D this_cpu_ptr(&cpu_fbatches.lru_lazyfree);
> -       folio_batch_add_and_move(fbatch, folio, lru_lazyfree);
> -       local_unlock(&cpu_fbatches.lock);
> +       folio_batch_add_and_move(folio, lru_lazyfree, true);
>  }
>
>  void lru_add_drain(void)
> --
> 2.45.2.803.g4e1b14247a-goog
>
>

Thanks
Barry

