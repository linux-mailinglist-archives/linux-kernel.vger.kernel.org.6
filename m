Return-Path: <linux-kernel+bounces-574510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C48FDA6E61E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3EE8177931
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BC51F099D;
	Mon, 24 Mar 2025 21:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3xwj0hU"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115C61EF099;
	Mon, 24 Mar 2025 21:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853515; cv=none; b=Kf8lHuQ9JARezo2yZiPK5xij3sK2OINlCF6xKPdbBjxMYQXReD6+xBTrN94Cl3PrPcgrr+ijzS7JZaT0quNPMLI6dH/NLB0QafDm3WzeydRvWU8PTnwF//enHatRyo9C/6DLB6QhvyNPjvRO2QcRt05AJbdd12Z/p1k/yqnlkE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853515; c=relaxed/simple;
	bh=Ot1DfOQiy27nUyF1DlyhAcVDQgk2TuJxclhmeyMz1OM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IlyggU3qLSi4E2sB9NrNqJt+BheyaxJ8SOERTvBqkBF0P3Z0Zk20bGokjKqD8Abfpe3Fx7Bh5+YaH9lL7ZuINnLO2545ufMWhK7AP0CKLFBTLwBjBYyFwFhL09IxYD/08ubJw0luJ0Ig6jeh9BP1GskS94mif9p3fySn+/S8xkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3xwj0hU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso52330415e9.3;
        Mon, 24 Mar 2025 14:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742853512; x=1743458312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ot1DfOQiy27nUyF1DlyhAcVDQgk2TuJxclhmeyMz1OM=;
        b=X3xwj0hUAO1o2rp4AWoF4/6uwPyeKFBSFQndNWpYEYfnpEcREiATc9JPeUX7HmtefG
         M1cbgXhWXa+5ZyYd+fQgMixPhaqwi18p+mBRRVKKYU1YMkW8nCMdO5kwMoEHCTmbeJg3
         AH8DjIwBX5EnjaSVyxDz2swdKihUCKpefZo21WRLmdbkfC9/gPbgMu4WkqNcydkajzo+
         JCkMVrd+bdmI8KVvqSUWHi8EDd6oRoFd80IS4/10MNCABVGyD5uLK8MwMkIqZ/twsxF+
         Zsj4ykaX5RBthH3HE3+r7sTPXHjxd1d1oWnjm0Jahr7Trlx4HiifDwGQbIg0qyjMu5Uo
         vjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742853512; x=1743458312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ot1DfOQiy27nUyF1DlyhAcVDQgk2TuJxclhmeyMz1OM=;
        b=Obp/sGQ0yrRE0EpYgS9P4TopizXlFwZUz8jbYOGCEJ1eqKFtonaVxzhYnwC0wfb93+
         7mM4wptEM3Cw5fk0MdjQxuEU6Kf9bEb2e48DB70w3crBSvHFAdgGU0YZ5rF8p9+CLbGV
         FM64+vNSgm7o85TCUooCdvdbpsw2eoalF4M9xjD+xsZxodv44gCg5GVwKTgQYr48lAc4
         a40NKFr+AicKcemkpqADMOlhhMS6BlDn3lpjFIvMFP+3R8nizfCrXpRmflN/1vXk5a2o
         yyDnlRRvZpLziGEJpXJQBBAoT8CeHRxkbo4TLQ4Jlz5dcHpBgkfT6wkct1g8upUsR50a
         OOJw==
X-Forwarded-Encrypted: i=1; AJvYcCUmH0gGQg4/IyV6xYtTgInxPa1SU9arWh35WhtOF6l7KEWTrmsyUQAoMf7rWRq9ELg5FsUMmTbWvF+KVew9@vger.kernel.org, AJvYcCUr9gAAxSDRGP5T7TpboHn8XGU4BH1szrmWauC9gFex1BnhFWU0e+T2TiK5x9cgNBmusjg9rMq8v+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3/1ArRanfZIkCufHdogGj0AhYtJ+37xk5MY4DAaS5qCVYpdtO
	QzWWCgStWbbMupsU+4c/1/P2B0PtsU8KeEnGRCnXUqsi4nF/Pua6yujEcVpWg78HK4KSarm+TVR
	A1g5WnMSYor34wjk8v5jeEktdGCI=
X-Gm-Gg: ASbGncvZut+zHs5lmjH7o5mhpa3ay++rfTHv4lmvDECNqwE4WVNQ2x2kSgKFp1TcZJT
	oIMwfyNZW2z6gXcyr4caVjL9w7GG33ZfzCSVPn8aX6PdqS8WYUZdPTp9Wux5Xrhi5Fjy/zzAJle
	plUIK3HeYYoZBZ1A2/HosCKFUSYY8=
X-Google-Smtp-Source: AGHT+IEUUuY2Db0h5BkUCKLvsIxKl8NZK1oeGSqYQqEHhk5l2ar/r7SKmTR9x8h91YsnG4+AUcp+k3SBeke2mv0hzmY=
X-Received: by 2002:a05:600c:4ed3:b0:43d:db5:7b21 with SMTP id
 5b1f17b1804b1-43d5dc40c1dmr56681635e9.28.1742853511979; Mon, 24 Mar 2025
 14:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+fCnZdtJj7VcEJfsjkjr3UhmkcKS25SEPTs=dB9k3cEFvfX2g@mail.gmail.com>
 <lcbigfjrgkckybimqx6cjoogon7nwyztv2tbet62wxbkm7hsyr@nyssicid3kwb>
 <CA+fCnZcOjyFrT7HKeSEvAEW05h8dFPMJKMB=PC_11h2W6g5eMw@mail.gmail.com>
 <uov3nar7yt7p3gb76mrmtw6fjfbxm5nmurn3hl72bkz6qwsfmv@ztvxz235oggw>
 <CA+fCnZcsg13eoaDJpueZ=erWjosgLDeTrjXVaifA305qAFEYDQ@mail.gmail.com>
 <ffr673gcremzfvcmjnt5qigfjfkrgchipgungjgnzqnf6kc7y6@n4kdu7nxoaw4>
 <CA+fCnZejp4YKT0-9Ak_8kauXDg5MsTLy0CVNQzzvtP29rqQ6Bw@mail.gmail.com>
 <t5bgb7eiyfc2ufsljsrdcinaqtzsnpyyorh2tqww2x35mg6tbt@sexrvo55uxfi>
 <CA+fCnZdunJhoNgsQMm4cPyephj9L7sMq-YF9sE7ANk0e7h7d=Q@mail.gmail.com>
 <s7wo5gqrvqfiq3k5wf2pwdurtdrzixlubmck5xgrr4eoj33hi4@vjexcwpp7g4g> <zmebaukzqlem7qrskdbqyzdsqcgpp6533vvfbo4vh3vtyeh4iu@yghuqyloverw>
In-Reply-To: <zmebaukzqlem7qrskdbqyzdsqcgpp6533vvfbo4vh3vtyeh4iu@yghuqyloverw>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 24 Mar 2025 22:58:21 +0100
X-Gm-Features: AQ5f1JqkwSi0yThMsOGpogsoWYqU98B_Blb_P24sQK5qkQMRfsxA3HC1ACSj060
Message-ID: <CA+fCnZfzA8f2rjq0CAYBvGtQLxZKOWk+3BWwjrdP-T-ncdeLpg@mail.gmail.com>
Subject: Re: [PATCH v2 13/14] x86: runtime_const used for KASAN_SHADOW_END
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: Florian Mayer <fmayer@google.com>, Vitaly Buka <vitalybuka@google.com>, kees@kernel.org, 
	julian.stecklina@cyberus-technology.de, kevinloughlin@google.com, 
	peterz@infradead.org, tglx@linutronix.de, justinstitt@google.com, 
	catalin.marinas@arm.com, wangkefeng.wang@huawei.com, bhe@redhat.com, 
	ryabinin.a.a@gmail.com, kirill.shutemov@linux.intel.com, will@kernel.org, 
	ardb@kernel.org, jason.andryuk@amd.com, dave.hansen@linux.intel.com, 
	pasha.tatashin@soleen.com, guoweikang.kernel@gmail.com, dwmw@amazon.co.uk, 
	mark.rutland@arm.com, broonie@kernel.org, apopple@nvidia.com, bp@alien8.de, 
	rppt@kernel.org, kaleshsingh@google.com, richard.weiyang@gmail.com, 
	luto@kernel.org, glider@google.com, pankaj.gupta@amd.com, 
	pawan.kumar.gupta@linux.intel.com, kuan-ying.lee@canonical.com, 
	tony.luck@intel.com, tj@kernel.org, jgross@suse.com, dvyukov@google.com, 
	baohua@kernel.org, samuel.holland@sifive.com, dennis@kernel.org, 
	akpm@linux-foundation.org, thomas.weissschuh@linutronix.de, surenb@google.com, 
	kbingham@kernel.org, ankita@nvidia.com, nathan@kernel.org, ziy@nvidia.com, 
	xin@zytor.com, rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, 
	cl@linux.com, jhubbard@nvidia.com, hpa@zytor.com, 
	scott@os.amperecomputing.com, david@redhat.com, jan.kiszka@siemens.com, 
	vincenzo.frascino@arm.com, corbet@lwn.net, maz@kernel.org, mingo@redhat.com, 
	arnd@arndb.de, ytcoode@gmail.com, xur@google.com, morbo@google.com, 
	thiago.bauermann@linaro.org, linux-doc@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 11:50=E2=80=AFAM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> >So I assume that if outline mode works, inline mode should be fine as fa=
r as
> >kernel is concerned? If so perhaps it will be more time efficient to pos=
t v3 of
> >this series (once I'm done with kasan_non_canonical_hook() edge cases an=
d
> >unpoisoning per-cpu vms[areas] with the same tag) and work on the clang =
side
> >later / in the meantime.

Generally, yes.

The inline mode also might require adding some __no_sanitize_address
annotations. Typically for lower-level function that get messed up by
the inline instrumentation. But the annotations previously added for
the Generic mode would work for SW_TAGS as well, unless SW_TAGS
instrumentation touches some other low-level code.

> Oh, I guess I also need to add a patch to handle the int3 (X86_TRAP_BP) s=
o
> kasan reports show up in inline mode.

Ah, yes, for SW_TAGS, need an appropriate handler here.

