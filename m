Return-Path: <linux-kernel+bounces-262885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3EE93CE47
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4D7DB213AE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 06:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B9C157E7D;
	Fri, 26 Jul 2024 06:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X6+IIuDd"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10507176226
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 06:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721976615; cv=none; b=PkF//A6DAH1wOJcU/H78uzoYX6Khc9xgwT2Hn4PLM4ovUioFSyi2qdv0P+PMK2M9UJRsL0U+3rymVgLzwIHsJ6Y80R7R6orqaFwAE9XwxGNJJ+reAndwmDR7rXi1l2OkuLBtn7xX135DGFPtdksYKErcl7tWm8ZIHPQhj0+0M10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721976615; c=relaxed/simple;
	bh=oBVGEkVVtBQ4le+SfYtgfWvw9mBR0Seci3aLjqF2T/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5WrEMXS+PEa3AuYxbIkyEh5vCk51U/Yxv/j1tW25T9KT9woeW45L1g9hSqrkTfQYFKznIMA3abcW/5zHuVB1HCyD+0oUHSqL3KZ8kVdJn/OA5/T5I3701E+cFUoC3jCpymG6GXKcMbxIDlqdPPvIdoxVTEVAoJD62V3hwbAhdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X6+IIuDd; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-38b3543541dso92885ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 23:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721976612; x=1722581412; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yrDGVDfcbEdzvzB7i8L7n3jr8ddDBA4qpsWKmnewmuA=;
        b=X6+IIuDdKNI+Xa7U1JQBUYpDYslfFSn/cfB/4AXlkyPDaozgyJNrO0sc4dU0+u3x2x
         ifnz8mrrIAPGU3z5QDGP7v99RyGHmDPbYhI3rfIrH9a4TE/S52OBizxS9YBinTSs0B4d
         6QptdbNLw81PRjEtZNfBwUzwy/OKeOU4H0njx+yJT3Q/a2AviC3+DT5xT+BdnmrNFhPw
         NGgYcFvCf0HYmTRVoHNleNGTrZ8/+7wAkLIvbSMIbceJarNScZ9coA9IiPLDoAdBi/U7
         1XYb4R9dAV+vWh3bRWMTKHIHcu5sem1ioqZyQeGibIXPMN4MG2kAmKPpYBEFjnbkDvkO
         ycSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721976612; x=1722581412;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrDGVDfcbEdzvzB7i8L7n3jr8ddDBA4qpsWKmnewmuA=;
        b=YvA5+mLW9rggjm+6UWkrC336NfKeIkK3Om8PVY1WdMI2BwOagKdFM3Py5viIU3zT8+
         aLKNB2konZ0OH1s6RpAV04wSPRIQgYdt3QVbv1nauEDxZql1y6kPX3tFcfa/nXKX9dys
         OorDrKQrksB/FtKVf7wAIQ8yIZyQBMo7ShXh0+wCWJ38P0PqulDmk/2uSozzn1GB/ybC
         B1piQDmZwFGrG9Lo2hLaixQKn7u/kIJcE30MOTJr0r8crYWuGT05K5zkRFVqkBET0FAi
         TShNiQ/LvL/XaV7XQ/KyhsslVmpQvuRNOMbL1lytSB1f8cuEW2RZZ4hQ9fBBTr285E4m
         mAKA==
X-Forwarded-Encrypted: i=1; AJvYcCXKvylb0KQVS/IwuEms0IE0KYKgXVjoGje5+S0np3ku05WaWpFcWLwNwwY5oEkCvqeWpYarAY2lFSKd96ALBmhWyuUEr+G30cXqnxwA
X-Gm-Message-State: AOJu0YzwZgnpIFMzwQjl5o8gGM++Js1Sla4GnaLhf7ZfiSIB0ed/qbzj
	i+7Q5ERGe1ou8Vb/rNA27XCsMb/eifgjhPlbVJfCC6+CeLK6Jcbc+HgsIfGs/g==
X-Google-Smtp-Source: AGHT+IFhMmDduA5a1iE2vV0TLq5eSikCuAjR0q61Pqxg01+Hqyhn16WkR44U4x1SYv2rEC7ihuvi+Q==
X-Received: by 2002:a05:6e02:b43:b0:377:1653:a1da with SMTP id e9e14a558f8ab-39a2b465e7dmr1927825ab.19.1721976611827;
        Thu, 25 Jul 2024 23:50:11 -0700 (PDT)
Received: from google.com ([2a00:79e0:2e28:6:7804:a7e1:484d:96f2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81f7d800e00sm92951939f.41.2024.07.25.23.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 23:50:11 -0700 (PDT)
Date: Fri, 26 Jul 2024 00:50:04 -0600
From: Yu Zhao <yuzhao@google.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable v1 5/5] mm/swap: remove boilerplate
Message-ID: <ZqNHHMiHn-9vy_II@google.com>
References: <20240711021317.596178-1-yuzhao@google.com>
 <20240711021317.596178-6-yuzhao@google.com>
 <CAGsJ_4y0cZwpKmYySdPObXLGaohwOZtKq=kcF4e4tXb22JkNTw@mail.gmail.com>
 <CAGsJ_4zn46WWmhjsTGES1hH9Un65BiNn+KLUfvE_Espnf0tw9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4zn46WWmhjsTGES1hH9Un65BiNn+KLUfvE_Espnf0tw9Q@mail.gmail.com>

On Fri, Jul 26, 2024 at 05:56:10PM +1200, Barry Song wrote:
> On Fri, Jul 26, 2024 at 5:48 PM Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Thu, Jul 11, 2024 at 2:15 PM Yu Zhao <yuzhao@google.com> wrote:
> > >
> > > Remove boilerplate by using a macro to choose the corresponding lock
> > > and handler for each folio_batch in cpu_fbatches.
> > >
> > > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > > ---
> > >  mm/swap.c | 107 +++++++++++++++++++-----------------------------------
> > >  1 file changed, 37 insertions(+), 70 deletions(-)
> > >
> > > diff --git a/mm/swap.c b/mm/swap.c
> > > index 4a66d2f87f26..342ff4e39ba4 100644
> > > --- a/mm/swap.c
> > > +++ b/mm/swap.c
> > > @@ -220,16 +220,45 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
> > >         folios_put(fbatch);
> > >  }
> > >
> > > -static void folio_batch_add_and_move(struct folio_batch *fbatch,
> > > -               struct folio *folio, move_fn_t move_fn)
> > > +static void __folio_batch_add_and_move(struct folio_batch *fbatch,
> > > +               struct folio *folio, move_fn_t move_fn,
> > > +               bool on_lru, bool disable_irq)
> > >  {
> > > +       unsigned long flags;
> > > +
> > > +       folio_get(folio);
> > > +
> > > +       if (on_lru && !folio_test_clear_lru(folio)) {
> > > +               folio_put(folio);
> > > +               return;
> > > +       }
> > > +
> > >         if (folio_batch_add(fbatch, folio) && !folio_test_large(folio) &&
> > >             !lru_cache_disabled())
> > >                 return;
> > >
> > > +       if (disable_irq)
> > > +               local_lock_irqsave(&cpu_fbatches.lock_irq, flags);
> > > +       else
> > > +               local_lock(&cpu_fbatches.lock);
> > > +
> > >         folio_batch_move_lru(fbatch, move_fn);
> > > +
> > > +       if (disable_irq)
> > > +               local_unlock_irqrestore(&cpu_fbatches.lock_irq, flags);
> > > +       else
> > > +               local_unlock(&cpu_fbatches.lock);
> > >  }
> > >
> > > +#define folio_batch_add_and_move(folio, op, on_lru)                                            \
> > > +       __folio_batch_add_and_move(                                                             \
> > > +               this_cpu_ptr(&cpu_fbatches.op),                                                 \
> > > +               folio,                                                                          \
> > > +               op,                                                                             \
> > > +               on_lru,                                                                         \
> > > +               offsetof(struct cpu_fbatches, op) > offsetof(struct cpu_fbatches, lock_irq)     \
> > > +       )
> >
> > I am running into this BUG, is it relevant?

Sorry for the trouble.

> > / # [   64.908801] check_preemption_disabled: 1804 callbacks suppressed
> > [   64.908915] BUG: using smp_processor_id() in preemptible [00000000]
> > code: jbd2/vda-8/96
> > [   64.909912] caller is debug_smp_processor_id+0x20/0x30
> > [   64.911743] CPU: 0 UID: 0 PID: 96 Comm: jbd2/vda-8 Not tainted
> > 6.10.0-gef32eccacce2 #59
> > [   64.912373] Hardware name: linux,dummy-virt (DT)
> > [   64.912741] Call trace:
> > [   64.913048]  dump_backtrace+0x9c/0x100
> > [   64.913414]  show_stack+0x20/0x38
> > [   64.913761]  dump_stack_lvl+0xc4/0x150
> > [   64.914197]  dump_stack+0x18/0x28
> > [   64.914557]  check_preemption_disabled+0xd8/0x120
> > [   64.914944]  debug_smp_processor_id+0x20/0x30
> > [   64.915321]  folio_add_lru+0x30/0xa8
> > [   64.915680]  filemap_add_folio+0xe4/0x118
> > [   64.916082]  __filemap_get_folio+0x178/0x450
> > [   64.916455]  __getblk_slow+0xb0/0x310
> > [   64.916816]  bdev_getblk+0x94/0xc0
> > [   64.917169]  jbd2_journal_get_descriptor_buffer+0x6c/0x1b0
> > [   64.917590]  jbd2_journal_commit_transaction+0x7f0/0x1c88
> > [   64.917994]  kjournald2+0xd4/0x278
> > [   64.918344]  kthread+0x11c/0x128
> > [   64.918693]  ret_from_fork+0x10/0x20
> 
> This removes the BUG complaint, but I'm unsure if it's the correct fix:

Below is the proper fix. Will post v2.

--- a/mm/swap.c
+++ b/mm/swap.c
@@ -221,7 +221,7 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
 	folios_put(fbatch);
 }
 
-static void __folio_batch_add_and_move(struct folio_batch *fbatch,
+static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
 		struct folio *folio, move_fn_t move_fn,
 		bool on_lru, bool disable_irq)
 {
@@ -234,16 +234,14 @@ static void __folio_batch_add_and_move(struct folio_batch *fbatch,
 		return;
 	}
 
-	if (folio_batch_add(fbatch, folio) && !folio_test_large(folio) &&
-	    !lru_cache_disabled())
-		return;
-
 	if (disable_irq)
 		local_lock_irqsave(&cpu_fbatches.lock_irq, flags);
 	else
 		local_lock(&cpu_fbatches.lock);
 
-	folio_batch_move_lru(fbatch, move_fn);
+	if (!folio_batch_add(this_cpu_ptr(fbatch), folio) || folio_test_large(folio) ||
+	    lru_cache_disabled())
+		folio_batch_move_lru(this_cpu_ptr(fbatch), move_fn);
 
 	if (disable_irq)
 		local_unlock_irqrestore(&cpu_fbatches.lock_irq, flags);
@@ -253,7 +251,7 @@ static void __folio_batch_add_and_move(struct folio_batch *fbatch,
 
 #define folio_batch_add_and_move(folio, op, on_lru)						\
 	__folio_batch_add_and_move(								\
-		this_cpu_ptr(&cpu_fbatches.op),							\
+		&cpu_fbatches.op,								\
 		folio,										\
 		op,										\
 		on_lru,										\

