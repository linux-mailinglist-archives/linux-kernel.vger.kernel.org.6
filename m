Return-Path: <linux-kernel+bounces-435500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1009E78AB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16417281320
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28C51D2F46;
	Fri,  6 Dec 2024 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C3C+Oxfp"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5338D192B76
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733512537; cv=none; b=WI2CJuotkc4gRCrmjjSv0zQu/ZQ9fcZWV/y2nPF0UhMj+lWUAv2YjZwBoxnf2Anvg+k+t56DEDWWIVVK6aQqluzLgeB8uhXQQSUeEq+4In2sZuf7L0idkczfO8SjGacAgJY73h425S/+J9p8F5739fntvrHUgL/N69vloq/5uus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733512537; c=relaxed/simple;
	bh=ajFbm9bK5cqvgCLi6MJ1DB1DDERcm8YueHpowSShf5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qV6M847hHL3Er3MqxGi/01USPcMwLjvYdKpH+Nryc5vhYKv0nOo+RgDkjQzS717R5DhLk1gxpJ/dwnD6DYPkhPzuZAv5Efd7dfGhG+bcrYAHhOdvG2jvLudJsZgz8DbFNkCCbd2ZP/fcVNgIFqpIAJsxbXD6Hd8WfcA3oDa6Uow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C3C+Oxfp; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3cfdc7e4fso691a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 11:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733512533; x=1734117333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7YKnxexLJ1+TaE4HafZ+vrLntQPWzQ2qCK8DJmplRQ=;
        b=C3C+OxfpL81viDInhzwei8EXHte5gNxm0HuJSSobAWltrL2k1pTv6OlAs2c6dtuL+T
         7yOwzK2OtIsFRuVyNYjA2hJ4BwNngkdyhKVzc9DrDTg/TtOfFrVGy0SfQpqtlzkru0VF
         sYETDyfC+LTVW1bZ5CmJOGtg/xPW1Jeg1WL5/LuxmfxiITvcck4pb2YXAfRFk4ykEZbT
         uijQ2qSa6/KBFGfB558dgBqpHtvYu41h90dRpNv5YhL99q+yZ88gBFgYFzEue+QRbKm0
         urGdhmem62JoionLB/46HjuXfWB+iyK0AY00VyoiOQMRuwsJxKRJo/H4gSypl/N2k+pn
         rY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733512533; x=1734117333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7YKnxexLJ1+TaE4HafZ+vrLntQPWzQ2qCK8DJmplRQ=;
        b=dKeyDygaOO7kkhBrVqcMnXl6/6C7eZqtZ9WUD7kiLR802fhYZDSm+I8IVvHAMccdSk
         Jdu77sn2Tpqh7NJBNP3Ls7+ftiKklkW6rAPn6Lmw7cLiCLMFuGbdfTO7el1RjTuNytS+
         J4ytzj5mUigjkAHvSFb7yPdM/xaTbrKBr/eivYwi5sx7mSe1VqWnokTho+rSHgFGB7HD
         F9eIlmRtbyyrhH3cE37emRi4n+4xNAFLUpq/BqvRTuoJV7G5dnGPg77RtDnX8LBXb5d+
         0bM6ZfnzW8FoGpfiofAu2ABM2vGMBaqJfO0E8F+4DxOGaQ3DTm/Gtnle91xDZQUFLfpF
         Up1A==
X-Forwarded-Encrypted: i=1; AJvYcCWNEZxi4fISWW1YQwUtAi85ArPdxcA5fBvFhjcGDk++nqqowhcL8nbW19dpFlUcR1+t36jDAxH/eY6dk/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZxfHr2UQlIkbRwLIawNgfNz4sczNHf7K81LmvKOn2ebUwURga
	/S+ZbAUAuEpjSYJJyNr4pqNUJos6ws75OU3rK427zQ1Qwkf7sQiUng6S1jDWTNmf9T9HkKZ9YTS
	WWmh3FJK1vcvOFNZXRV6GOAlHjm8uXIg7DzeW
X-Gm-Gg: ASbGncvfXqJsCvA1y7M/K5UZB1JzdFTEpEE8vIG9MVU5H0Fn8v0HWClIYK6pp01JHn4
	ugZ4SfnhHZhSXe+R3OhxQVf8HC/ycB8e3NZ3SP4+Ee3mBGMxYJVcWhp6VGgs=
X-Google-Smtp-Source: AGHT+IElYlBNREfqiZtIPEZ0AoFhO5dJI6xcw9xcSYAg6cDhIC7rFrPCr3zdIfmomIG/xUNduJKYL+dryW/WkRiwaII=
X-Received: by 2002:aa7:d507:0:b0:5d0:eb21:264d with SMTP id
 4fb4d7f45d1cf-5d3db4b972cmr3792a12.1.1733512533171; Fri, 06 Dec 2024 11:15:33
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206101110.1646108-1-kevin.brodsky@arm.com>
In-Reply-To: <20241206101110.1646108-1-kevin.brodsky@arm.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 6 Dec 2024 20:14:57 +0100
Message-ID: <CAG48ez1b8BBquEB1BJEg+KsPdPyZLPuD7uToUH3ZdN8F0r+U9w@mail.gmail.com>
Subject: Re: [RFC PATCH 00/16] pkeys-based page table hardening
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	aruna.ramakrishna@oracle.com, broonie@kernel.org, catalin.marinas@arm.com, 
	dave.hansen@linux.intel.com, jeffxu@chromium.org, joey.gouly@arm.com, 
	kees@kernel.org, maz@kernel.org, pierre.langlois@arm.com, qperret@google.com, 
	ryan.roberts@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 11:13=E2=80=AFAM Kevin Brodsky <kevin.brodsky@arm.co=
m> wrote:
> This is a proposal to leverage protection keys (pkeys) to harden
> critical kernel data, by making it mostly read-only. The series includes
> a simple framework called "kpkeys" to manipulate pkeys for in-kernel use,
> as well as a page table hardening feature based on that framework
> (kpkeys_hardened_pgtables). Both are implemented on arm64 as a proof of
> concept, but they are designed to be compatible with any architecture
> implementing pkeys.
>
> The proposed approach is a typical use of pkeys: the data to protect is
> mapped with a given pkey P, and the pkey register is initially configured
> to grant read-only access to P. Where the protected data needs to be
> written to, the pkey register is temporarily switched to grant write
> access to P on the current CPU.
>
> The key fact this approach relies on is that the target data is
> only written to via a limited and well-defined API. This makes it
> possible to explicitly switch the pkey register where needed, without
> introducing excessively invasive changes, and only for a small amount of
> trusted code.
>
> Page tables were chosen as they are a popular (and critical) target for
> attacks, but there are of course many others - this is only a starting
> point (see section "Further use-cases"). It has become more and more
> common for accesses to such target data to be mediated by a hypervisor
> in vendor kernels; the hope is that kpkeys can provide much of that
> protection in a simpler manner. No benchmarking has been performed at
> this stage, but the runtime overhead should also be lower (though likely
> not negligible).

Yeah, it isn't great that vendor kernels contain such invasive changes...

I guess one difference between this approach and a hypervisor-based
approach is that a hypervisor that uses a second layer of page tables
can also prevent access through aliasing mappings, while pkeys only
prevent access through a specific mapping? (Like if an attacker
managed to add a page that is mapped into userspace to a page
allocator freelist, allocate this page as a page table, and use the
userspace mapping to write into this page table. But I guess whether
that is an issue depends on the threat model.)

> # kpkeys_hardened_pgtables
>
> The kpkeys_hardened_pgtables feature uses the interface above to make
> the (kernel and user) page tables read-only by default, enabling write
> access only in helpers such as set_pte(). One complication is that those
> helpers as well as page table allocators are used very early, before
> kpkeys become available. Enabling kpkeys_hardened_pgtables, if and when
> kpkeys become available, is therefore done as follows:
>
> 1. A static key is turned on. This enables a transition to
>    KPKEYS_LVL_PGTABLES in all helpers writing to page tables, and also
>    impacts page table allocators (see step 3).
>
> 2. All pages holding kernel page tables are set to KPKEYS_PKEY_PGTABLES.
>    This ensures they can only be written when runnning at
>    KPKEYS_LVL_PGTABLES.
>
> 3. Page table allocators set the returned pages to KPKEYS_PKEY_PGTABLES
>    (and the pkey is reset upon freeing). This ensures that all page
>    tables are mapped with that privileged pkey.
>
> # Threat model
>
> The proposed scheme aims at mitigating data-only attacks (e.g.
> use-after-free/cross-cache attacks). In other words, it is assumed that
> control flow is not corrupted, and that the attacker does not achieve
> arbitrary code execution. Nothing prevents the pkey register from being
> set to its most permissive state - the assumption is that the register
> is only modified on legitimate code paths.

Is the threat model that the attacker has already achieved full
read/write access to unprotected kernel data and should be stopped
from gaining write access to protected data? Or is the threat model
that the attacker has achieved some limited corruption, and this
series is intended to make it harder to either gain write access to
protected data or achieve full read/write access to unprotected data?

