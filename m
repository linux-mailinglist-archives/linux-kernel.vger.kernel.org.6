Return-Path: <linux-kernel+bounces-283727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F1494F83F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9151C213AE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AC319413E;
	Mon, 12 Aug 2024 20:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWvq1RaF"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF7214B978
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723494980; cv=none; b=aM/AyHJp9FwV+SjXL4LFyAs2yICKaURdMX6/GWA8f+OKEp5Wl3g4gHd8LLVXdFKGxlmbu4zNEJeJojLwQui33Cd4IEBdvFFBJ730MDEBfI+DCwbjmqujfzK+/8oifFe2huXv9OVIPqycpiO2rkfM6FtJKq2mbq5yhy8oHviD21Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723494980; c=relaxed/simple;
	bh=9R+kTf1t7duI2y5VeZMGbgeOcCWdzXiWgtlVjy4GRpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsB7TBde0ysF1qMj384s4Ml1q96dy4srl7N6bt+8qXuAzAIgTTeOMFcTxCq1AOXIuQemzpqIKxm4VYaOUTjGavJYqinYkhS6p2zxYRoaeWAr2CtLKEoivyKfcmiiryJYnnOjohlF32QiKZCequzfX3HK7OXPMzu10yW0gXAex78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWvq1RaF; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eeb1ba040aso65504331fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723494977; x=1724099777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Krl4tzyVcLOgEOZk0xyBfeZl1rzZ7k3IomOAOBcy3A=;
        b=OWvq1RaFfrNPcZA2f+WbwYP8HveX/BRM0bpowP7E21YMOdHcye3M09s5JOGq9B9x8W
         jnsn55YTtNDb9hLajBJdPSZB94dCsJZC9Ko45w+yMOM+uNrKSiuRKioTeQw9f7XZCz2P
         QN+Wq4umvpGxjVpEkQqFL7vfgOkP8tJYv48TxNb7W3Jb9zzNybVgZI3HmAFlow147Vhb
         qeqv1XHMrGFV/QY34XdQX1O8YQKGyY/GoarED92wkDcB1vcuPWW6ZY2Hdy7soEXb8D48
         5yNap9NXM8HH5x178kAiPd3QYtq2Ksxkgx8dBW76njNMAiknc3Sfv8i9/gtInCMu1g/h
         mPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723494977; x=1724099777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Krl4tzyVcLOgEOZk0xyBfeZl1rzZ7k3IomOAOBcy3A=;
        b=gbPMW6CDRFQ93eb3IOh684wp+bGtTN6Cgl9OqZp/MlOlBjuegFSuP0oWRgR2/nOYD9
         wt7y0ks+duRJjEkuhMUqoMwNVU+/UpzKivQpDTIm4UAe9OUKHklV9hkLiZyqPoI79NWn
         6zZb6J4QUgSujvbbux9GxIrp4LkUQJBD48dHSDsyLxUKgcnFu99E6429LmlltBvq7BXJ
         5eqOcA/P5f/ia26HvKdOu/tLWqbScnOB0h8KQUajgteHFnbhb7U1w4DXFnSsNW8EOOmB
         zbvhTkMx9jz6LdRxQxPnZfdIi0D97vArp2I96Kr0u3fsBDiaGYhHGm44L2PLxaXu+Tw3
         AHCA==
X-Forwarded-Encrypted: i=1; AJvYcCWOiaBVfSp2HR9h9mGrvLz85RcV3MOW0NzxAyc9W+6Vy9PRkR7RnktDaD+xtZaVbVs4FORArtngjRg1KPc97rGSpNzaNlJ7sRpMKBKj
X-Gm-Message-State: AOJu0YwdqXMX7HdjvUGk5eX0Ee/8S/2aYAMabb/fepfF4tKDWvkbQgEo
	i02WRJhHcp/9MYqwYftNQei7FklSovPvqCRqB3J2OgWxrhwiH4nqJ4o1tppYb7s59tkG+Tsg0UT
	6gcbfXXNySTgg2AeUzwvr4sVwfqc=
X-Google-Smtp-Source: AGHT+IHAnN6iPut17bEYXfYnfLGsXK6sfXzfubPXfbhUS8blTjz17bOTn91JlkDIm7hIKzp3PRjRYFu2wWeBlv0+4lY=
X-Received: by 2002:a2e:d12:0:b0:2ef:2344:deec with SMTP id
 38308e7fff4ca-2f2b72779a8mr8663761fa.45.1723494976878; Mon, 12 Aug 2024
 13:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812115945.484051-1-ubizjak@gmail.com> <20240812115945.484051-3-ubizjak@gmail.com>
 <2EF46123-30B0-4A7E-9414-EE25CBCF255E@gmail.com>
In-Reply-To: <2EF46123-30B0-4A7E-9414-EE25CBCF255E@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 12 Aug 2024 22:36:04 +0200
Message-ID: <CAFULd4YOf0Mz-JbR6LEWxM2M=4GTxqC9m-q_QAZJw8Ws16yrTA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/4] percpu: Assorted fixes found by strict percpu
 address space checks
To: Nadav Amit <nadav.amit@gmail.com>
Cc: "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, Andy Lutomirski <luto@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>, 
	Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 9:09=E2=80=AFPM Nadav Amit <nadav.amit@gmail.com> w=
rote:
>
>
> > On 12 Aug 2024, at 14:57, Uros Bizjak <ubizjak@gmail.com> wrote:
> > Assorted fixes to prevent defconfig build failures when
> > strict percpu address space checks will be enabled.
> >
> > These show effeciveness of strict percpu address space checks.
>
> [snip]
>
> > --- a/drivers/base/devres.c
> > +++ b/drivers/base/devres.c
> > @@ -1231,6 +1231,6 @@ void devm_free_percpu(struct device *dev, void __=
percpu *pdata)
> >        * devm_free_pages() does.
> >        */
> >       WARN_ON(devres_release(dev, devm_percpu_release, devm_percpu_matc=
h,
> > -                            (__force void *)pdata));
> > +                            (__force void *)(uintptr_t)pdata));
> >
>
> Since this pattern of casting appears multiple times (sometimes slightly
> different), I think it would be best to give a name for this operation
> and put it behind a macro.

The macro would not be flexible enough to also cover const qualified
(const void __percpu *)(const uintptr_t) casts, required in e.g. [1].

[1] https://lore.kernel.org/lkml/20240811161414.56744-1-ubizjak@gmail.com/

Also, some casts are decorated with __force. According to sparse
documentation [2], there is no need to use __force when the
destination type is uintptr_t or unsigned long, but sparse seems to
not be consistent with this exception, leading to spurious warnings
and  fixes like the one in [3].

[2] https://sparse.docs.kernel.org/en/latest/annotations.html#address-space=
-name
[3] https://lore.kernel.org/lkml/20240402175058.52649-1-ubizjak@gmail.com/

OTOH, in a full allyesconfig this pattern of casting appears maybe a
dozen of times (which is a surprisingly small number).

> This would allow both to audit the cases developers move data between
> address-spaces, and also make them think whether what they do makes
> sense.

Looking through the fixes required for allyesconfig build, the
remaining couple of casts are mostly required for ERR_PTR return with
__percpu return type function, like:

--cut here--
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 6c2cb4e4f48d..d82fe78f0658 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -849,7 +849,7 @@ register_wide_hw_breakpoint(struct perf_event_attr *att=
r,

     cpu_events =3D alloc_percpu(typeof(*cpu_events));
     if (!cpu_events)
-        return (void __percpu __force *)ERR_PTR(-ENOMEM);
+        return (void __percpu __force *)(uintptr_t)ERR_PTR(-ENOMEM);

     cpus_read_lock();
     for_each_online_cpu(cpu) {
@@ -868,7 +868,7 @@ register_wide_hw_breakpoint(struct perf_event_attr *att=
r,
         return cpu_events;

     unregister_wide_hw_breakpoint(cpu_events);
-    return (void __percpu __force *)ERR_PTR(err);
+    return (void __percpu __force *)(uintptr_t)ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(register_wide_hw_breakpoint);

--cut here--

While the casts are somehow ugly, I think that the number of different
types (pcpu -> generic and generic -> pcpu casts with possible const
qualifier and still needed __force sparse attribute) and low number of
occurrences currently do not warrant a separate macro.

Uros.

