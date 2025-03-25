Return-Path: <linux-kernel+bounces-576152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B82A5A70BB1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812353B356D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F00E266B5D;
	Tue, 25 Mar 2025 20:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NJfMUe2T"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5EF19ADA6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 20:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742935312; cv=none; b=p2i8yM9jNHTZ6XflmJ3IRvThDGXnFLmZp5/ky3onUYcpWJJ3oMecBpdu5Fxi04sptJjBzJUf5C/LgCXysgDfsBLQSKfrMX49UuoPnpDNdT/HaO9Ktf4SYAHxBrKH/fGMNXmJpTDUJTODnuR4COJKCBbI8cNxKDzTvCQQwEXKgGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742935312; c=relaxed/simple;
	bh=GCAhGVtueceq1ubCUXU7aIifbCxnCpAKEuI8oUAtt/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2vezoab98SC8cXmtSqRyL/H2gemQXw5uSRTU1u4/riqtedPBPiIOPUSbZ6HTarq/MlOy9Efsd50olq3tBtaX9Ks4rFYRwIn7C/oDvsmf2q/RLg6jR3cUqqOVAP4y3TE8bKB3tb4gS2yCqpWvmY3PTDWyFXL5iyv6TWmxzNyrlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NJfMUe2T; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2963dc379so1025703266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742935308; x=1743540108; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K52xAWNW5IEkY2W6yv56tbrXz/O78EY3OFwe6Kmcp1A=;
        b=NJfMUe2T/SrCYvY9xa5ZYKh9B0hgZFfz2oOJdyX7/Z6exRgjt1v7EwWPfsB/ZTFwoM
         3ATUtokNCJNYZs7aBFbUAru6STFWtJ4gH4qlJm/7mBVVjzRT8GOH7ylM9d1lwKG7upjX
         scXfardQC6guO2+Bb+i+YVukNocsLibMnlYaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742935308; x=1743540108;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K52xAWNW5IEkY2W6yv56tbrXz/O78EY3OFwe6Kmcp1A=;
        b=XA4LK+j0tvxGYfuORaVY1z0EmzAjBo4PVFHmQoeg6qKPtdIuyeKa3bZ7d85zHwVlcF
         icwbGZJzfBIPVOoHTA2IKzzCAkQZZ7IFnY4L7UmRUbNyGVK5XMPPmVcIB32115RCuWsg
         g2rUyLJy2orlveglrkbyRyViiJ2wGvIpPUqWjbjRukFJkR6HooNEjd4pz9+8Dd53bBTT
         rBHLFwTln5ajpf/auH0sIdXBr39het0qtrb2jFob8gK+Pz4jOd7uBDOZ/RngwlfGFUSc
         n2F3sz8P465op0rY5yAA84UD6k2R9WjDHpZF0C4wQIm8hKS6GFrdLDRX3wPlp95Bvi6R
         6oqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAbT4iPa3uEFWzviDN8CQGYWCXHYXRMcpY+8OlQg59rC+vis4zpcmjq+Pv2z2oaGtDKpErgWh2uGsplxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZzpFik1HGm0DIsDmoi10lGCMsa/rNhDi2hT34awC0kl6P0xmc
	Wl67pIFwEyVtmzWo/FW8eLm6dc3pVzhRke6QQ9wfHXHtV5pwM6iKL369ioHj1OTc7hNyBWIHWsh
	V8z8=
X-Gm-Gg: ASbGncsyuQiu4CC3mAVYbYXvVU1Ddtn9mVr7tWz0+b2ZlYtWLGxfKJxT8S+0rLWY+hw
	1RjIreOsjau9y0z1vo3ho8L1YJ2kaeO+UkM3iHtB3cwElFkujpl4uFaVQcCt6HXjhzr5rYpsxdo
	q/Kzc8KQtKyyvsVaI9HzUFiUzOU0NAm8Ak80MrwNJaR/R8Qe71MP8lo1MRVrXeaCVJykYBEixaO
	HD7lAFm/VFGJhn0hBLeyA4/0V0kTflbsyAthbI+ODmdHvSCDX0ehe5jJqopujWBPnEcXQn6gFSD
	oDLMmEb6m0sNz6szcGh5UOtLtweMIv8EMpNaMvYHvShtUyeOxlkjh2PvYUp4NRZiMHt1HeUQCi1
	SR3Xf0J8wSsgxunkp0QNZHEOIjshSJQ==
X-Google-Smtp-Source: AGHT+IF1FtnepeAwflAOiIkSgwwJRzT5xaIdVINabyw9YJpBK9k1sKfH9BSRt+YkpyePg2/+iEHVIg==
X-Received: by 2002:a17:907:a58c:b0:ac1:e332:b1e7 with SMTP id a640c23a62f3a-ac3f24164e1mr1998128966b.4.1742935308543;
        Tue, 25 Mar 2025 13:41:48 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efb6588esm917117466b.90.2025.03.25.13.41.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 13:41:48 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abf3d64849dso989640666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:41:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXiC1EMkFIy/+qsyJShk50G7Y4IRhGv95i642mktOA8KNYl4DzZw6RA8l5mo1Vrndiii5nhdPJqURH5ITs=@vger.kernel.org
X-Received: by 2002:a17:907:95a4:b0:ac3:48e4:f8bc with SMTP id
 a640c23a62f3a-ac3f27fd3b3mr1859596466b.48.1742935307883; Tue, 25 Mar 2025
 13:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325121624.523258-1-guoren@kernel.org> <20250325121624.523258-2-guoren@kernel.org>
In-Reply-To: <20250325121624.523258-2-guoren@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Mar 2025 13:41:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVgTJpSxrQbEi28pUOmuWXrox45vV9kPhe9q5CcRxEbw@mail.gmail.com>
X-Gm-Features: AQ5f1JpwFc7ifwGuAhyrs4E5qPgHx1McCR38KFycRhkLFRMKTveHrmoaWi4zba4
Message-ID: <CAHk-=wiVgTJpSxrQbEi28pUOmuWXrox45vV9kPhe9q5CcRxEbw@mail.gmail.com>
Subject: Re: [RFC PATCH V3 01/43] rv64ilp32_abi: uapi: Reuse lp64 ABI interface
To: guoren@kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, anup@brainfault.org, atishp@atishpatra.org, 
	oleg@redhat.com, kees@kernel.org, tglx@linutronix.de, will@kernel.org, 
	mark.rutland@arm.com, brauner@kernel.org, akpm@linux-foundation.org, 
	rostedt@goodmis.org, edumazet@google.com, unicorn_wang@outlook.com, 
	inochiama@outlook.com, gaohan@iscas.ac.cn, shihua@iscas.ac.cn, 
	jiawei@iscas.ac.cn, wuwei2016@iscas.ac.cn, drew@pdp7.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, ctsai390@andestech.com, 
	wefu@redhat.com, kuba@kernel.org, pabeni@redhat.com, josef@toxicpanda.com, 
	dsterba@suse.com, mingo@redhat.com, peterz@infradead.org, 
	boqun.feng@gmail.com, xiao.w.wang@intel.com, qingfang.deng@siflower.com.cn, 
	leobras@redhat.com, jszhang@kernel.org, conor.dooley@microchip.com, 
	samuel.holland@sifive.com, yongxuan.wang@sifive.com, 
	luxu.kernel@bytedance.com, david@redhat.com, ruanjinjie@huawei.com, 
	cuiyunhui@bytedance.com, wangkefeng.wang@huawei.com, qiaozhe@iscas.ac.cn, 
	ardb@kernel.org, ast@kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-mm@kvack.org, 
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-atm-general@lists.sourceforge.net, linux-btrfs@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-nfs@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 05:17, <guoren@kernel.org> wrote:
>
> The rv64ilp32 abi kernel accommodates the lp64 abi userspace and
> leverages the lp64 abi Linux interface. Hence, unify the
> BITS_PER_LONG = 32 memory layout to match BITS_PER_LONG = 64.

No.

This isn't happening.

You can't do crazy things in the RISC-V code and then expect the rest
of the kernel to just go "ok, we'll do crazy things".

We're not doing crazy __riscv_xlen hackery with random structures
containing 64-bit values that the kernel then only looks at the low 32
bits. That's wrong on *so* many levels.

I'm willing to say "big-endian is dead", but I'm not willing to accept
this kind of crazy hackery.

Not today, not ever.

If you want to run a ilp32 kernel on 64-bit hardware (and support
64-bit ABI just in a 32-bit virtual memory size), I would suggest you

 (a) treat the kernel as natively 32-bit (obviously you can then tell
the compiler to use the rv64 instructions, which I presume you're
already doing - I didn't look)

 (b) look at making the compat stuff do the conversion the "wrong way".

And btw, that (b) implies *not* just ignoring the high bits. If
user-space gives 64-bit pointer, you don't just treat it as a 32-bit
one by dropping the high bits. You add some logic to convert it to an
invalid pointer so that user space gets -EFAULT.

            Linus

