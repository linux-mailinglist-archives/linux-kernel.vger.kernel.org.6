Return-Path: <linux-kernel+bounces-511552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F197EA32C88
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884F9188629B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086D725743B;
	Wed, 12 Feb 2025 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mkooxIuT"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC4E2505C2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379188; cv=none; b=J0mLUaxfIkUXAnDQolhnzTXTEFaMrWE99m3juNKIBPY6c718jzd9ueb5z6obrMI69GoR1MjUomn7G8ctlgIRGNpQX5eriXrdqh35c18M9cpu5QbLpTZ3C/O5jEd0J9Nn5cUW4uM8QAmgnsLg2vnRCxyb3nfs2L5YS3hk89D+eCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379188; c=relaxed/simple;
	bh=AMNpujMwxEF0lqcT39JFds7LDCNGNjFeFh/KBzfjZKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzTeM5f1IVTvxbv31kUE7STCYbe6TwlShyjfAL16CUxfIWsBaoNGup3BV2KWvWsTYyVsjcnQkCFnjF1byqSgLK1hP06Vqf5x25vsBOJJcPXIKVoFnBG2+6qwqDcDuliH4PhGeoZZtn2MVT0guDXuPtgu6sGRR7RPBqGZDmeJmDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mkooxIuT; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5dec85c8bfcso901a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739379184; x=1739983984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIV7IWz0yjddKyv/beIYGjRoq6XNzByBQnMEf8PUBBs=;
        b=mkooxIuTZNDO/4grzWX7KKOLTDysqlPWw0U5bYrYw1GI2DcVW3nOrtrnGluny6v29I
         /1Yl2guKh4LYCyXIpcpOKOe6VOybo82rxUlfdl6/j1cRF0iYPHeK3GtwST40b/XynGKZ
         n2d95SY+UnDGEQl0Um4A0qW2PudLm3K20G+CjxLFqo6Gy+8YvLD1z1/T4F7T3SFQEr+J
         ZlJXdXfmRG9yhdB1BYkdDB0EE1maKUgNkSHnAHC+x1vwZocSXjDyMqnwfaGJlXOfw2No
         UzHN/8FEgDa/0g5dTiXBfVYJ+SEpJcTTlpmjRDxhLemNrpJ3YzeYvmin9X2wwKxLftYu
         FVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739379184; x=1739983984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIV7IWz0yjddKyv/beIYGjRoq6XNzByBQnMEf8PUBBs=;
        b=OFhbOBMvNJiiMFswDnOv0nrya2OQjjvDYuEqEu9odrlaG7GYf/KCvxJ2g6dkk1kuBt
         NrzVSRJ44dLF3PceM/9gPdUh3hpYjXqf9/0jzbpi97obAV98UIJpk8JWBVj3N+0I1BXV
         ds90cThXbgkiHEZiBIqIKcUK36OaN/fBbF2ibAB4DuCqG6wqwqPcFaKdqRBTw4QDnAqT
         a+DYAIQUoiMaaV6Gm8hFsY/siW2UzTMJwgFRobiG86hWQbpmpRJ7F4FUxPrv5x/Ijbol
         j88mxzXEKfT1kRfDrW+WHIHGZuHRJSEE47hoBtYt7nHHV19qUH9WkRzpj5pajgnw0LXE
         rvdA==
X-Forwarded-Encrypted: i=1; AJvYcCWZJa+dqHsYK9+I7gsVwkONbwSFWjL8z6rceXdKGLlgIp1e61jHMUlWfOgAAPHgfQYQ+k9LlHRKdjVegmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEjFnEf3ILP+Mki+KDumXC7PH+56uR+5sN8KdKr8hXm0/7e1Pm
	2cU3tlYnlsoojjDirBXwBe5HCQNRPLH3JOpc1X4Q/yik241IrSCMKOU/fjzer4XhAbuc8rZNET1
	js9URxhRACh/Rxm6xl7nC4lzKTkgLMfGPNN4C
X-Gm-Gg: ASbGncsxb/m2Yngt+0Rx0IBhE0rVCrT2gnnmYYrOP6TwdtKP/AusNKxz9gy+vtod3Ff
	j5Xg6bashAb3FwAAnbBN3RWQS4Fqjjt8tNGmKPmWFt6wX/O+eqjxV6VUu2+BTyV5uCLPpvA==
X-Google-Smtp-Source: AGHT+IHGz5vufPcLaUodmyGxxGtYNbNdz1AykWXGGm3hYrwe+nD3RKGRGnrjo4hwPRDJ2Dv82yKvK06Jw364LFyYOsk=
X-Received: by 2002:a50:cd5a:0:b0:5dc:5ae8:7e1 with SMTP id
 4fb4d7f45d1cf-5deaeb262camr123278a12.6.1739379183792; Wed, 12 Feb 2025
 08:53:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <173881156244.211648.1242168038709680511.stgit@devnote2>
 <20250206081225.GI7145@noisy.programming.kicks-ass.net> <20250206205449.5f83a585945ae6eb0cc15483@kernel.org>
 <20250206121328.GN7145@noisy.programming.kicks-ass.net> <20250206123307.GO7145@noisy.programming.kicks-ass.net>
 <20250207085959.b3e9d922eab33edf885368e3@kernel.org> <20250210173016.0ce79bc8@gandalf.local.home>
 <20250211100914.GA29593@noisy.programming.kicks-ass.net> <20250211105002.31b5a517@gandalf.local.home>
In-Reply-To: <20250211105002.31b5a517@gandalf.local.home>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 12 Feb 2025 08:52:27 -0800
X-Gm-Features: AWEUYZmCWP-_bDLn8AzH0F5wUOCKagIjnDD4PTtFP-tRkjvGdXKpxK7eMOGff0U
Message-ID: <CABCJKudwf11wAbv9NdKh_FN-Z+pLaupMHJxNGtRKK1-1D94hCQ@mail.gmail.com>
Subject: Re: [PATCH] ftrace: x86: Fix a compile error about get_kernel_nofault()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Gabriel de Perthuis <g2p.code@gmail.com>, Haiyue Wang <haiyuewa@163.com>, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 7:49=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 11 Feb 2025 11:09:14 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
>
> > I was aiming my patch for x86/core, but if there's a reason to expedite
> > them, I can stick it in x86/urgent I suppose.
> >
> > Just need a reason -- what's this compile error nonsense about, my
> > kernels build just fine?
>
> Masami,
>
> Do you have a config that fails to build without this fix? If so, can you
> please reply with it, and then this can go in as a quick fix.

x86 builds with both CONFIG_GENDWARFKSYMS and CONFIG_FUNCTION_TRACER
are broken without this fix. Here's how to reproduce:

$ make defconfig
$ ./scripts/config -e DEBUG_INFO -e DEBUG_INFO_DWARF5 -e MODVERSIONS
-e GENDWARFKSYMS -e FUNCTION_TRACER
$ make olddefconfig && make -j
...
In file included from ./arch/x86/include/asm/asm-prototypes.h:2,
                 from <stdin>:3:
./arch/x86/include/asm/ftrace.h: In function =E2=80=98arch_ftrace_get_symad=
dr=E2=80=99:
./arch/x86/include/asm/ftrace.h:46:21: error: implicit declaration of
function =E2=80=98get_kernel_nofault=E2=80=99 [-Wimplicit-function-declarat=
ion]
   46 |                 if (get_kernel_nofault(instr, (u32
*)(fentry_ip - ENDBR_INSN_SIZE)))
...

Sami

