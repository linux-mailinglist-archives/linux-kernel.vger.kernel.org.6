Return-Path: <linux-kernel+bounces-432598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E36249E4D80
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962E6285460
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 06:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FDD198A02;
	Thu,  5 Dec 2024 06:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="Sb+KBnq8"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CEF18D620
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 06:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733378970; cv=none; b=EB7NDlwmqy4/Q1sWTGCD92EsePTFvku0Oki/w3Jjdk8693fbKe68i6DtCnl17h/erz+ECFM8ihOe8ZNt+0PyuPRjsW85iIowJgtGctqIs2dQF6jg+3Ks77nlLy4ItwYmUcVMqF6ffTsYviSWD9AzXplaaTRuf4urrgINHb1tTmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733378970; c=relaxed/simple;
	bh=ha/tTjNA7iNUNNwAK8VOBu4fR+9xQhqvVimxkSptFaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7wMwQbS2yeSor8G8f2cSnJ1yZs2XO9xBlw54D2/lkG8vOmC5aUm8p/ujNc8HNYd8v2Fe5lYsv2QT7nky2rBeHARVRiGHAW8ADrnrlaeqRJbMsR1WJBJsdBEJk3HszSmytTdFbUHw4R1FAFQ64pDwddeDuyFmkIdsPpDCoFf2ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=Sb+KBnq8; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-841a565f871so20364939f.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 22:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1733378968; x=1733983768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aL2ODb59ZMLyvYZNKyPV9w4ocXZc2/Drlrpw4dYUQ6s=;
        b=Sb+KBnq8jwhs+5mgSiCjTA37EXuTY0c3RjqZCJErupbk1d/GrufM690z3CsEbLSHEi
         zJzZy9Aa0siYE1ZfxzxRSGi4WzYrCvzEfVOS6MVszmKmrsAonP1arFHXpmPYy8rUmCHy
         0srtOBCzxDB/z9jmi61BPlvAPElM4VFqjIJQz7rfxer95Tz8ZdCJS3pm357IyOtxNh5y
         QDmbCWGpywXsqvsX4C/6hNGHPhguNyIpf0WHMvjp7d5pqR9nTko573B13MIL3RCcteqX
         Pg2+ZB6ipdMEsAiAXMJPbKav5q+cnFEvB17WHV5ofxbmk2ygyLunMRDSBAmgbvBPFjXW
         685Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733378968; x=1733983768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aL2ODb59ZMLyvYZNKyPV9w4ocXZc2/Drlrpw4dYUQ6s=;
        b=PktQaBUwgcjSuFKNh0d9Bh+BTKKD33i8thiOn3SbRWSrYct2iWsZyi3u2b4duZySGZ
         6KFmbdBZpt1aA3Q2gILFoBwMDtC09eEW5q8lK1PsUmPpXo/JuswszEtP6Rcg5XaAKFzI
         5x1BF3R+YGRLrvylPPd9YALXXMr3E9f6enliZbBSB6+ufCFbKGVqchILLyqR2JUUTBpW
         iLq34k9us6UIWgwcoaC/u0j1PANaE6Npx1sp7Ixg6XaGOKgMvh+QgaBYMY7yHCEucoh7
         h6/oMq474KJBtSyRV9E59s0ILUEhKSH2YPAD3CUJARChzMZActHY31qjaTMvxiv9Usz6
         935w==
X-Forwarded-Encrypted: i=1; AJvYcCWLOa47iuFikMhexlWlSO8eT9hdtlc7XSkk4tuR0QJ84p6gFLd19pbbU3VmEIwdgRX9gO5Ke/YghgJ+6fQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV+sDJp8idW1xr/0/TMJrBTSEhqCztVnhEbSPJpTrQy3aLrjml
	Fh+on51YUWJdD6ZUrzNn0jmIzTqhhwgOtFURu8EMq/LQg6OefpaaigzHPQWK4N1n347zyXr+MBC
	2wHwjSxItq/TkgQYNETEPINPkDYzEkDyEjjNIoQ==
X-Gm-Gg: ASbGnctE1cYLN9sLtIrF99bkwKD+Hz6+SkEQy5OS8dT7n225aWCZhPTNS9yZAKe3V7b
	/onP/WhAvdF/UMV5280gmF2/6JQQtCg==
X-Google-Smtp-Source: AGHT+IEOJFcAi0n4c1mbGRpzcMhoQOlyi+pjiyaxzgnJjkOrtltLnY8I/trZOofEuFvj7Y58FOr5LXqv2HOUgAuNT5U=
X-Received: by 2002:a05:6602:160b:b0:83a:7a19:1de0 with SMTP id
 ca18e2360f4ac-8445b5e5949mr1404993539f.14.1733378967761; Wed, 04 Dec 2024
 22:09:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1732854096.git.zhouquan@iscas.ac.cn>
In-Reply-To: <cover.1732854096.git.zhouquan@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 5 Dec 2024 11:39:16 +0530
Message-ID: <CAAhSdy2aPmV6U+GnCnqExXzO3okpDFTbCgwz+Y=dZDVBO0E7Eg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] RISC-V: KVM: Allow Svvptc/Zabha/Ziccrse exts for guests
To: zhouquan@iscas.ac.cn
Cc: ajones@ventanamicro.com, atishp@atishpatra.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 8:53=E2=80=AFAM <zhouquan@iscas.ac.cn> wrote:
>
> From: Quan Zhou <zhouquan@iscas.ac.cn>
>
> Advertise Svvptc/Zabha/Ziccrse extensions to KVM guest
> when underlying host supports it.
>
> ---
> Change since v1:
> - Arrange Svvptc in alphabetical order (Andrew)
> - Add Reviewed-by tags
>
> ---
> v1 link:
> https://lore.kernel.org/all/cover.1732762121.git.zhouquan@iscas.ac.cn/
>
> Quan Zhou (4):
>   RISC-V: KVM: Allow Svvptc extension for Guest/VM
>   RISC-V: KVM: Allow Zabha extension for Guest/VM
>   RISC-V: KVM: Allow Ziccrse extension for Guest/VM
>   KVM: riscv: selftests: Add Svvptc/Zabha/Ziccrse exts to get-reg-list
>     test

Queued this series for 6.14

Thanks,
Anup

>
>  arch/riscv/include/uapi/asm/kvm.h                |  3 +++
>  arch/riscv/kvm/vcpu_onereg.c                     |  6 ++++++
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 12 ++++++++++++
>  3 files changed, 21 insertions(+)
>
> --
> 2.34.1
>

