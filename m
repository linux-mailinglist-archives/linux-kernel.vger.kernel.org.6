Return-Path: <linux-kernel+bounces-189739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3152B8CF451
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 14:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC0B7281709
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 12:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A08DE57F;
	Sun, 26 May 2024 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4k0ivvZ"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292922F55
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716727529; cv=none; b=t4OtPdVtOj3aixv1s0yTjincSwy50f1Nx2KkEawNtOelD7UaHJG4TGFjEmGNZVAngxTFLCe/tdgCJ8N3N+QtVouOd92BECfMJvXVXyl56Wmgs4paZWflAeb5EbwN8I5HSc1XalsJ9omxxWMSoNLl4bfoe2zvIuAKuwnoVjsMyaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716727529; c=relaxed/simple;
	bh=KOAVlkiuGyTnCQ2ZlXLO0vNIzDwXvGBopI5sg3sGgJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUnAUBJD86WFT6otft2v4j/cgOghAut1510MbQrbCYh2BU+XiYiK4Me+aQtl5Wqv7d/uhMGQgIdEIW+pEQR4vBnfSTxzA5FDV9mfyAEfHbfaqPVWqPhyyi9fSO3h1m7H0CsfROCgbjnRPquHQx/EsrtybCdwzplSAqm4Ro4m2q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4k0ivvZ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6265d48ec3so250846366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 05:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716727526; x=1717332326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sGreP7ohmVf4AkzbVkuYO2XvY8O/AuY/tqcEe8fBOKk=;
        b=B4k0ivvZM5UOCKip6EMaZzJVLbSKXGbOAKF9pJmkSC6B37+m4d5gvd8sucPrREvmOQ
         5UjgfJYFsc7pydSzm5eztd1XjCBqgppjAg1+DBvTMok7XKrcUaOqRb2DJEgMCOTGs/XG
         egXsclkS+e08G+WSn+6+IYV/SS8EMJFaOgzUa5BGk2WS1w31TFz14Mffsvn8I1ncFS6F
         G9oD+RR48Nw1/Iq/Zz5yKfgMgR1IXtu1+d0nyHIpGd3joUyFmlvzUbzwnsH3X/habQvq
         rPvQBqjf1V1MVoasZvwezg16Zv4GGNJT89Rm5z/jX0xU6gXSnTM7nwLbj4dW/YEseKHU
         2ihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716727526; x=1717332326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGreP7ohmVf4AkzbVkuYO2XvY8O/AuY/tqcEe8fBOKk=;
        b=UfiFL5IuYGL2wvxOSnDPTERoQGetzCemIvBbWDIYfrDFWZBai43vA9lAQsx6/mefB4
         RSoBTqdOm8KCoZx6fMbDObW0KT2WaHAR0oODQZ8/HYHSIdVDe5oE+LkXYbzfOYDj20W0
         WI4dz/3SUdcNYUJMblv+3fERKhloI6pY3NEmZGC24ql6eKau58RnFVXsoMbPhKnWbGPx
         Xy9fCaQRHMjKZvNowO93vcqL57lhe2AzFAQpnetOGKAzhQlBKOZgfMZiBnZbrfeuyHp4
         ZZigQ8SwrizVpkZe+3mPOxmMnoT6LwIsLGaXrPfe/9n+97CrFFCcoPkML9EfAWT9m8wa
         /POA==
X-Forwarded-Encrypted: i=1; AJvYcCWsbwPhr/Kq6qmUJPVKcdFspPFiaMU5IJnxzIrfGiVv2lD4E/LyWkBGQtG+y5IF0FBlzKEHOGsTh6kRgqslp6WO3IMLuVuvgyad9+H6
X-Gm-Message-State: AOJu0YwncALVc5Rrk6iqYP/ek9i4dQ54j7VDQLWWxvn18v+DdrXtf1TZ
	3EjBsarc5D2qR6uJSVQqCaD5n3D0v4f2Geeb3YCMeZbP7Z/JPZ3GYQHZIg==
X-Google-Smtp-Source: AGHT+IE6UWx5TxyHQ3GKQF5hf8NlJGJeDS5QWJbyP1RP3ZnnrEJFTXgF+oPupSkgZoTGtxn9/7rbcw==
X-Received: by 2002:a17:907:1b20:b0:a5a:99a4:62a with SMTP id a640c23a62f3a-a6265011c68mr609503166b.75.1716727526301;
        Sun, 26 May 2024 05:45:26 -0700 (PDT)
Received: from f (cst-prg-19-178.cust.vodafone.cz. [46.135.19.178])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a62b67f0bbesm177905466b.211.2024.05.26.05.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 05:45:25 -0700 (PDT)
Date: Sun, 26 May 2024 14:45:16 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Dennis Zhou <dennis@kernel.org>
Cc: tj@kernel.org, hughd@google.com, akpm@linux-foundation.org, 
	vbabka@suse.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] percpu_counter: add a cmpxchg-based _add_batch variant
Message-ID: <qyuogq43hmgqguiswjt2r5hyxlk6epuc6gs3n6votoc4nwk5lf@o2alaj7nrgy2>
References: <20240521233100.358002-1-mjguzik@gmail.com>
 <Zk1HsDYKwxpzeBjq@snowbird>
 <CAGudoHGpiJwuNX5MEj_RGdc+vVo_3u3hSv9wWSRm6ZrmAi65NA@mail.gmail.com>
 <Zk6FIJTUEiNORrzl@snowbird>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zk6FIJTUEiNORrzl@snowbird>

On Wed, May 22, 2024 at 04:52:00PM -0700, Dennis Zhou wrote:
> On Wed, May 22, 2024 at 06:59:02AM +0200, Mateusz Guzik wrote:
> +     do {
> +             if (unlikely(abs(count + amount)) >= batch) {
> +                     raw_spin_lock_irqsave(&fbc->lock, flags);
> +                     /*
> +                      * Note: by now we might have migrated to another CPU
> +                      * or the value might have changed.
> +                      */
> +                     count = __this_cpu_read(*fbc->counters);
> +                     fbc->count += count + amount;
> +                     __this_cpu_sub(*fbc->counters, count);
> +                     raw_spin_unlock_irqrestore(&fbc->lock, flags);
> +                     return;
> +             }
> +     } while (!this_cpu_try_cmpxchg(*fbc->counters, &count, count + amount));

For completeness I'll add that Vlastimil suggested creating an inline
variant of the fast path of the routine, which does look reasonable now
that it is 2 branches. Should it land, the reworked routine I posted
would serve as the slowpath.

I hacked it up (inlined below for reference).

This of course creates a tradeoff in terms of func call cost vs i-cache
footprint. bloat-o-meter on a debian-based kernel config says:
Total: Before=24584638, After=24592309, chg +0.03%

I don't know if that automatically disqualifies the thing.

At the moment the negative lookup test I used to bench the cmpxchg
change failed to register a win due to numerous artificial slowdowns in
that codepath (most notably memory alloc/free are incredibly slow).

That is to say at the moment I cannot justify submitting the inline
variant for inclusion. If someone has a test which bounces off of the
routine they are welcome to bench it and share if it helps.

I however do intent to whack out some of the problems in the test I was
running, by the end of that process it may be the inline variant will
provide a measurable win, in which case I'll send a proper patch.

diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index 3a44dd1e33d2..b0038811b69f 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -52,9 +52,21 @@ static inline void percpu_counter_destroy(struct percpu_counter *fbc)
 	percpu_counter_destroy_many(fbc, 1);
 }
 
-void percpu_counter_set(struct percpu_counter *fbc, s64 amount);
+#ifdef CONFIG_HAVE_CMPXCHG_LOCAL
+void percpu_counter_add_batch_slow(struct percpu_counter *fbc, s64 amount, s32 batch);
+void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
+{
+        s64 count = this_cpu_read(*fbc->counters);
+	if (unlikely((abs(count + amount)) >= batch ||
+            !this_cpu_try_cmpxchg(*fbc->counters, &count, count + amount)))
+		percpu_counter_add_batch_slow(fbc, amount, batch);
+}
+#else
 void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount,
 			      s32 batch);
+#endif
+
+void percpu_counter_set(struct percpu_counter *fbc, s64 amount);
 s64 __percpu_counter_sum(struct percpu_counter *fbc);
 int __percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch);
 bool __percpu_counter_limited_add(struct percpu_counter *fbc, s64 limit,
diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index c3140276bb36..80fa1aa7a1bb 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -90,7 +90,7 @@ EXPORT_SYMBOL(percpu_counter_set);
  * 1. the fast path uses local cmpxchg (note: no lock prefix)
  * 2. the slow path operates with interrupts disabled
  */
-void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
+void percpu_counter_add_batch_slow(struct percpu_counter *fbc, s64 amount, s32 batch)
 {
 	s64 count;
 	unsigned long flags;
@@ -111,6 +111,7 @@ void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
 		}
 	} while (!this_cpu_try_cmpxchg(*fbc->counters, &count, count + amount));
 }
+EXPORT_SYMBOL(percpu_counter_add_batch_slow);
 #else
 /*
  * local_irq_save() is used to make the function irq safe:
@@ -134,8 +135,8 @@ void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
 	}
 	local_irq_restore(flags);
 }
-#endif
 EXPORT_SYMBOL(percpu_counter_add_batch);
+#endif
 
 /*
  * For percpu_counter with a big batch, the devication of its count could

