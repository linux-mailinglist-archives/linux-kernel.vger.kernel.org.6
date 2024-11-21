Return-Path: <linux-kernel+bounces-417168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D379D4FD1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236FF284079
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6DA13AD3F;
	Thu, 21 Nov 2024 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jj58eW6D"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F84C78289
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203417; cv=none; b=RwZ3IK/zI59AeMIpRDquvd2o3bnj4xv9zto1DMu8CI8rGyAzcUg19qIfTT9Hp9tySa4//9W5eYOd/DFWhm1q0sMFonnN8p99kNPICL5gghe6vtGy1pLe5dAk5q/rdFzw3Eownno49p6mev8VQ15+O8100QGve4BQJ44VxV+r1+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203417; c=relaxed/simple;
	bh=f+5eu3i1biuvPB++1VXhnk1wXT/1aJPH0TLJr3C9z00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQAbBJU99l2P3YoJfHQ56fdtejjfhHeyongtu4Mhu0+7w7fGba1Y5YaOAu9jsTsCAdG5ZaLw2tCel7JYl6H/HIRMx2DnjEsO64xWaBalHM7yxRaSyIautwgtDq/8Q0dtvaKafA02MKZ5SKzwY8ZoDQ3r8sdvBhotL/a1YUBIj7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jj58eW6D; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460a8d1a9b7so249301cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 07:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732203415; x=1732808215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4nPPmITE0cgPNHF19a0j6DIt0zlAK0qCukXxXNbX+I=;
        b=Jj58eW6DXiSgkZ1HKgXxEUul2yHOdoD/lUMOybrQcS/lbBOxid0LiSeM6cOsyOjmum
         R7DYH8mXdicq4TyTpKVioIyoQHB4TEY7ahRuq5NeomnOIwFTIQBH4FXO0hEU6Ixb/kdx
         x3EcMo6TRXveMVp5VMeFPv1JDvHOHOlgomwQp36lr9wK0AeqEwX/bEU0oxQb4rFYS8bz
         2VeDIZuC0kc+jBFPAr3xuS+lOXp4KOggO9+7gxKaIVJnkXRb65aTTMAJk+cjvw5cCYbt
         1Es3AeHAvz+/HVQbN5oEyOXzjO6nDKDLZhjQzUNxcZzOQ6f9C/6ktzaGGFp0hWjjxTZU
         4dHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732203415; x=1732808215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4nPPmITE0cgPNHF19a0j6DIt0zlAK0qCukXxXNbX+I=;
        b=lq+bTY6BXlCHPsWMEuydaoEyvJo7mqmrGw1UwklvN2RHWih30X+37CSOt7OlTcsNqR
         f+V1xc52ForLGBzCbdfSeCB6nqwgJbLQfrXZRvVxGNjag/InVJWxiUz6V6qi/vJgvFQ/
         eJbxQv3s1uyQZ4FqwzQlPNnFbmsuPQnnPKtqXu+D2cugv8/lksZslblo9XtARQ4260Kp
         i0AijZHwC9XhunWlQiSCXSAQUWmAB4bRr8AvH8zgZOSaEQcpUr9NNoXX1Hu27zZ/AmOQ
         QrKyWUzrZVnKqllHOUrZ5Xx2fp5QDyI1p9xPXlFE2GfqVGWYwtGNAeK4Swoj65bYl0js
         Sgbg==
X-Forwarded-Encrypted: i=1; AJvYcCW6l66molA6NRajg2LC4txQXDk9TzC3qAqKAbcUHludtv70PmOobsje57haxJJZN4ij4mYIW3LCdxoI/G8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwLdNHtcT7ky8l6/w8YPGTJP84wlbXdObCChLpQ5VDBPAfmotI
	nhEfequ84HcAIVHmWIenaRNrDZL1F3+tKp0p95GEyCe4HFdNCESmlVjuCyIQNxM06db19JYpWJs
	+7N3jKOy+oGyKmeKO619PGU8t0YSW6f2O64A6
X-Gm-Gg: ASbGncuN3MzBLz3jz4wLSshbLv6iXIswd7fwxcPnoybdHj8yUBm1FYhH23Lk/lfhKWS
	XgT1Wcw0wY+Wm0MdV+f87+cFJG9svknTTfA15Vd4UhXe1b4ka8NgCuZINC/UI
X-Google-Smtp-Source: AGHT+IH1SWogEGFZbng5bmadf/PzQLLTFdgdPJQJD536g3mvOBUR/1NIEP5wbiUXW212c2x/5zIIe+RImYF2DYJPRZE=
X-Received: by 2002:a05:622a:19a3:b0:463:6f64:7ee4 with SMTP id
 d75a77b69052e-4653bcc2063mr148291cf.3.1732203414816; Thu, 21 Nov 2024
 07:36:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028010818.2487581-1-andrii@kernel.org> <20241028010818.2487581-3-andrii@kernel.org>
 <20241121144442.GL24774@noisy.programming.kicks-ass.net> <20241121152257.GN38972@noisy.programming.kicks-ass.net>
In-Reply-To: <20241121152257.GN38972@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 21 Nov 2024 07:36:43 -0800
Message-ID: <CAJuCfpE04MtnmRR+JYpYqC07-u9yXRUF0FB2mSaQatzwSkNNdw@mail.gmail.com>
Subject: Re: [PATCH v4 tip/perf/core 2/4] mm: Introduce mmap_lock_speculation_{begin|end}
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, 
	mhocko@kernel.org, vbabka@suse.cz, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	arnd@arndb.de, richard.weiyang@gmail.com, zhangpeng.00@bytedance.com, 
	linmiaohe@huawei.com, viro@zeniv.linux.org.uk, hca@linux.ibm.com, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 7:23=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Nov 21, 2024 at 03:44:42PM +0100, Peter Zijlstra wrote:
>
> > But perhaps it makes even more sense to add this functionality to
> > seqcount itself. The same argument can be made for seqcount_mutex and
> > seqcount_rwlock users.
>
> Something like so I suppose.

Ok, let me put this all together. Thanks!

>
> ---
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index 5298765d6ca4..102afdf8c7db 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -318,6 +318,28 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    tru=
e,     mutex)
>         __seq;                                                          \
>  })
>
> +/**
> + * raw_seqcount_try_begin() - begin a seqcount_t read critical section
> + *                            w/o lockdep and w/o counter stabilization
> + * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
> + *
> + * Very like raw_seqcount_begin(), except it enables eliding the critica=
l
> + * section entirely if odd, instead of doing the speculation knowing it =
will
> + * fail.
> + *
> + * Useful when counter stabilization is more or less equivalent to takin=
g
> + * the lock and there is a slowpath that does that.
> + *
> + * If true, start will be set to the (even) sequence count read.
> + *
> + * Return: true when a read critical section is started.
> + */
> +#define raw_seqcount_try_begin(s, start)                               \
> +({                                                                     \
> +       start =3D raw_read_seqcount(s);                                  =
 \
> +       !(start & 1);                                                   \
> +})
> +
>  /**
>   * raw_seqcount_begin() - begin a seqcount_t read critical section w/o
>   *                        lockdep and w/o counter stabilization

