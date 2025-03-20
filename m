Return-Path: <linux-kernel+bounces-570296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADAEA6AE71
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32068463A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77352227B8E;
	Thu, 20 Mar 2025 19:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXu3DYpo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C3FE555
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742498399; cv=none; b=C6zJSwJNTNFaED4zVg+o3URyWIbu+RIEs+7ZOvSEE1A26Ku1r/Lg0hTli5Q/ZbQpy4rwr67f9FJ41onaRSnJDM/uzBzDVG29Mkvbhr4kMDNceFfghRGJm+McwV2rXv/QOi6aucmpH6inEt6t7WH5I2L5tu0rrLGZfpB7Pk302Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742498399; c=relaxed/simple;
	bh=18p1g7p7G+WKSCR/Qx7WOfz7URI7QNEFAgdaVdJ298A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXfn0xYXRHQLu4ee6QY/xepUS2CRO3zSMJYF2O6hH3iYmMRmGJDOdrChxW/bv5r90pJVH3518X9e5LvayXY9RM/9V+HBqzvwWDyRSBUoqKcpzcaE1H//TxvB/ogXUuQe5CUd2m9BKs+Ir1f6xR2c4eQuSY3uu10rgyZDK16vSWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXu3DYpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56420C4CEEC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742498399;
	bh=18p1g7p7G+WKSCR/Qx7WOfz7URI7QNEFAgdaVdJ298A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZXu3DYpot12xIosUsDGsQEawKQ/ZHXEh2gPkhxa3naMlou/8MKX1Dq31zYGKuRV5N
	 cSNnnPHAfu8Hj7zNuV5mAsPsV2dVv3G8dJFFFXo/aoJEe6tSmrRpUjjB4EEyNbrOeW
	 8qTfBa2HdODIKEBr6ctEMj6JMuxSGXWPMtfwJ8O5tWNQBqMd4wsJpJN1gQ8bM2WYgW
	 1BFbhYrDHsTgWTjgVvf7UF7qK1hlTfG77FF4wmyAm1zhnjgVF/TTZnhMyXevMxg5IO
	 C+ZAqYhrSScmbDp4nv0MEwO0c8AnmUpOkrhe7xKVIkhNK2m9MXrLLnqAAd0OSGAbnw
	 72iUa79dN1/tg==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30beedb99c9so11960531fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:19:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWf5eqsigUtoEOgIaJ///QTtUdcyDoSrwXFAIcTGx3v9SOhcuZ+/yL2KkNbtUPK9EEPeW2sBSPk+rppfow=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYYXe9WantxO6kdBeM0Z348G16DmLtKXyX/OAbumesRXEANJoE
	kzC/hPeQhldhjUpB0YzGmsw7q4Yo6l5StKCEMpaqPAj+TiiGZ7Oc1ZQ9vYd4D4BfJu+QFgk0I3k
	3W2+3rMCro80fXV2emiV032RUaPM=
X-Google-Smtp-Source: AGHT+IFv6qp9ZC3REaL6pqtdJRcVeHiw0hqk4WEaMMyj3aa+lTrEnhzZ4agUq0zoyXipvH8hAe5e45n4ydKb3Rnfc88=
X-Received: by 2002:a2e:bc04:0:b0:30c:201a:149a with SMTP id
 38308e7fff4ca-30d7e2aab8bmr1729101fa.25.1742498397674; Thu, 20 Mar 2025
 12:19:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SN6PR02MB415723FBCD79365E8D72CA5FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB415723FBCD79365E8D72CA5FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 20 Mar 2025 20:19:45 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH-awwT99FTaBJqyEbgBoxc20h4LfbzXMP00NQHBs03+A@mail.gmail.com>
X-Gm-Features: AQ5f1JpmsC5AWna36uVwzk7RFc0W8oqX3rhKRXxe5GLuxfgWLI07lDcdjZDXf7U
Message-ID: <CAMj1kXH-awwT99FTaBJqyEbgBoxc20h4LfbzXMP00NQHBs03+A@mail.gmail.com>
Subject: Re: Compile problems w/gcc 9.4.0 in linux-next
To: Michael Kelley <mhklinux@outlook.com>
Cc: "brgerst@gmail.com" <brgerst@gmail.com>, "mingo@kernel.org" <mingo@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Michael,

On Thu, 20 Mar 2025 at 19:29, Michael Kelley <mhklinux@outlook.com> wrote:
>
> Brian/Ingo/Ard -
>
> I'm seeing a compile problem in linux-next-20250319 with gcc 9.4.0. I've bisected
> to a group of 6 commits that you authored:
>
> a9a76b38aaf5 x86/boot: Disable stack protector for early boot code
> f58b63857ae3 x86/pvh: Use fixed_percpu_data for early boot GSBASE
> cb7927fda002 x86/relocs: Handle R_X86_64_REX_GOTPCRELX relocations
> 78c4374ef8b8 x86/module: Deal with GOT based stack cookie load on Clang < 17
> 80d47defddc0 x86/stackprotector/64: Convert to normal per-CPU variable
> 9d7de2aa8b41 x86/percpu/64: Use relative percpu offsets
>
> As of a9a76b38aaf5, everything compiles correctly.
>
> For f58b63857ae3 thru 80d47defddc0, this error occurs:
>
>     arch/x86/platform/pvh/head.S: Assembler messages:
>     arch/x86/platform/pvh/head.S:183: Error: operand size mismatch for `movq'
>

This is simply a bug in patch f58b63857ae3, which uses movq on
EDX/EAX. This breaks bisection (as you've noticed), annoyingly, and
I'll leave it to the tip maintainers to decide whether this warrants a
rebase (given that the fix is already queued up as well)

> As of 9d7de2aa8b41 and later, the head.S error goes away, and this
> error occurs:
>
>     lib/zstd/compress/huf_compress.c:1033:1: internal compiler error: Segmentation fault
>      1033 | {
>           | ^
>     Please submit a full bug report,
>     with preprocessed source if appropriate.
>     See <file:///usr/share/doc/gcc-9/README.Bugs> for instructions.
>
> Interestingly, if DYNAMIC_BMI2 in lib/zstd/common/portability_macros.h
> is changed on line 61 to always be defined as 0, the compile problem in
> huf_compress.c goes away.
>

Without having looked at the crashing code, I suspect that the only
meaningful course of action here is to tweak the conditional logic
that defines DYNAMIC_BMI2 to only enable it for GCC >= 10.1 (assuming
those are unaffected) In any case, GCC 9.4 is not going to get fixed
in the field, so even if this gets fixed on the GCC side, we will have
to deal with it here.

> I'm using gcc 9.4.0 in an Ubuntu 20.04 install as it's the standard compiler
> for that version of Ubuntu. I'm guessing that getting a fix for that
> relatively old version of gcc isn't likely. I have not tested with other
> gcc versions.

