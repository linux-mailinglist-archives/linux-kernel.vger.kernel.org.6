Return-Path: <linux-kernel+bounces-288084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABA495339C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5EE1C251A0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4C51ABEC8;
	Thu, 15 Aug 2024 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gFubfzSY"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3463214
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731427; cv=none; b=PyDLNpTKp1Pbwjd2aUv8VH/PqF/5JMaXPm9pXFWTwW66ngqjeqbqOmlKX3gAg/SbCCNPm2b7o62kT6LnEVizv7q4cd8B+PQhk9AbxY7LhAfhySgnVKHZPLe+Q0BVoWxLCmhtB8UJOWyhtwh1rn9wYWaZYKvLT9H5XrZo/ml74uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731427; c=relaxed/simple;
	bh=lnzMl695VSGRAib7TxI4EDKXjdJGD7KQgExAJp7Eb/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Czo8z2BIUGSSnek1OCJS0ZbVGQaQPq2x6AqHusywWxTOMoee2Ns0uRMx7RFr1LbrR8lww/uwrCQ+TDtJYxodOIqOfGQqySDSqsiSsB2L5Vj0tkH6eefF/oWjgPD5TzGNtqA4SgEIQwz+EQaehdU9JVs60FKYd2B3bTH9635wzPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=gFubfzSY; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so141672866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 07:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723731424; x=1724336224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAVLP2QFhmGnxnmeTbf8eFIID24nsinWmxF9a6BsjI4=;
        b=gFubfzSY7A+PtAIpslrXvQIKZaVcnj1tk48imn3Zpgw36ZKIe8eLtIVromCtB7HuSZ
         RH7V9krF8Xl583cqzas+h5T9110JhdI/kwL++CfraPr2ePtKhja94YjlEPa85Toibr+X
         VkhAcbwCMjYfT2JR/rsDNBjyTRu475KCoNS8PkE6x+kz+qQv1ku8TscQ+uAXp8OqGjaw
         aP9KwJLPWHy2yLAGrvhGljlPM3L21v7JwudwX7VYJPOm1zZZgr1fsrZMjoUwPt0uBpDZ
         MpAfXllu7XeMY3hZcym92+JhW9HSWczyNLTP7nfbY4SUNwTYTGI86xZ6sQPdnvRkAUdu
         lVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723731424; x=1724336224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAVLP2QFhmGnxnmeTbf8eFIID24nsinWmxF9a6BsjI4=;
        b=QkhJMLy/PC6WkJrV5bOE9UQlOG0gWJTRd7wA2wXuaGMcADWjn/E3f1bswOFYT2hmdW
         CJCUDQfrOhoswra8YnBePy+QC/KGGGhdg+4NFdZtFbERFa0B+QayB+p9mRz/dLoNfRSu
         Ca9ld/CojkwZwISt+tn+ToX9kHo96K4VYQHnwMSC1MjJQA+8mlzPFLgwggBsa+lv+c/u
         lyQEzOBudhRfAq1aqW2S+ibQWLwvf3gDACpgU4qEae2MCSsrSM6xHCtxuuIU4nnjcmBM
         Es0MfFc/3mgs4aWWQS0ybtrnCbFoCjGSm4gUZSNlBr4R2KNrYulpiRKlM/NwZdJPZ8q/
         sRSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmrp9xxq+fLO7OAOfF0/Hq2ylGUHrjkZimah53Juo/pbSWJHzw69IvrbMNW1/JGT5uTpAlaNW435eJAvAe9Tr3IXe9JN04LrjDGLJk
X-Gm-Message-State: AOJu0YyvD8D2+1aaA4+4eYsN1OHzzGQDoo1racIteKarED0Gc13O823B
	MlXNkNfj0/K96txjodF9enNJsd+zWNFnJ985EOXadK8tq9ei/mty4WLr/WwCHbUdqqXtAou1RR2
	P1/JST8MXk3fMu78JdPIJa8/6L3N2kLyX8di50g==
X-Google-Smtp-Source: AGHT+IGZQZVkLs1R94f5r/cOZntuAVJ3giaLkP9ibYuSTl3FYwhnVnxfqxGmllCdLoMsajtZsF2ijZS0FEtKusHWF7c=
X-Received: by 2002:a17:907:f70b:b0:a7a:b895:656f with SMTP id
 a640c23a62f3a-a8366d44eefmr447980366b.38.1723731423795; Thu, 15 Aug 2024
 07:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814145642.344485-1-emil.renner.berthing@canonical.com>
 <87jzgjnh9z.ffs@tglx> <CAJM55Z8WERQgs=QMyFGWvAHOpwcnOAudBqovaEuDudPSXCvL5Q@mail.gmail.com>
 <87ttfmm2ns.ffs@tglx> <CAJM55Z88H635Crc-Aeq+K0qcAk7NC89WVTAFdXDd2aQKQ7QmEg@mail.gmail.com>
 <CAJM55Z_qQX7n8tAeOFqrAH1BFjA9vaWA8rtsPG2BcKmiO88m=Q@mail.gmail.com>
 <87plqalyd4.ffs@tglx> <686d61c4-e7ac-4dca-a7fd-decdd72e84d9@sifive.com> <87h6blnaf1.ffs@tglx>
In-Reply-To: <87h6blnaf1.ffs@tglx>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 15 Aug 2024 19:46:52 +0530
Message-ID: <CAK9=C2V7oL023=u6nodJs76k_0yHZ8PTJs=n1QFqDWCcCnG9kw@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] Fix Allwinner D1 boot regression
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Samuel Holland <samuel.holland@sifive.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 7:41=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Thu, Aug 15 2024 at 08:32, Samuel Holland wrote:
> > On 2024-08-15 8:16 AM, Thomas Gleixner wrote:
> >> Yes. So the riscv timer is not working on this thing or it stops
> >> somehow.
> >
> > That's correct. With the (firmware) devicetree that Emil is using, the =
OpenSBI
> > firmware does not have a timer device, so it does not expose the (optio=
nal[1])
> > SBI time extension, and sbi_set_timer() does nothing.
>
> Sigh. Does RISCV really have to repeat all mistakes which have been made
> by x86, ARM and others before? It's known for decades that the kernel
> relies on a working timer...

My apologies for the delay in finding a fix for this issue.

Almost all RISC-V platforms (except this one) have SBI Timer always
available and Linux uses a better timer or Sstc extension whenever
it is available.

When Emil first reported this issue, I did try to help him root cause
the issue but unfortunately I don't have this particular platform and
PLIC on all other RISC-V platforms works fine.

I am also surprised that none of the Allwiner folks tried helping.

>
> > I wrote a patch (not submitted) to skip registering riscv_clock_event w=
hen the
> > SBI time extension is unavailable, but this doesn't fully solve the iss=
ue
> > either, because then we have no clockevent at all when
> > check_unaligned_access_all_cpus() is called.
>
> check_unaligned_access_all_cpus() is irrelevant.
>
> > How early in the boot process are we "required" to have a functional cl=
ockevent?
> > Do we need to refactor check_unaligned_access_all_cpus() so it works on=
 systems
> > where the only clockevent is provided by a platform device?
>
> Right after init/main::late_time_init() everything can depend on a
> working timer and on jiffies increasing.
>
> I'm actually surprised that the boot process gets that far. That's just
> by pure luck, really.
>
> Thanks,
>
>         tglx

Regards,
Anup

