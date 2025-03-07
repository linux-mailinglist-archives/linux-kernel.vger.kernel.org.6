Return-Path: <linux-kernel+bounces-550661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6A9A5628D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A9516BA24
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FCC1C6FEF;
	Fri,  7 Mar 2025 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="Zdl2TGmN"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A68D1A314C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741336141; cv=none; b=gB9/di4qeceql3FoCBO9uMbO0BckMbOMbTZssANIhtUJ+CnUEjaKZdRWNmLUAY7e2aU8gy/6vAw5ZMImwKH+TAbktn1BO1pYTZNln3tjdNCAU/f1Jxi3x2na8HZRY6Nu1G/gGYFUHAxZMfF5s9+cbqluKk0dVQBab/F4yZ1onfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741336141; c=relaxed/simple;
	bh=KAEABgo5QmoLhvA8/dKPBOR8Bq/G4TG267wdgb4RRRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4Ai7UMGHL4ae+6N31PvC+a/NTRH/bRN7jLO3m27HhcTxlz1Wx7MQfLHGmU7gxlF+0bSSURoyngHptnqs7Cr/tLYgA+qoz6o2Y/cfLobZtWwbauNwKyJIC3XH3gPmzdzt7WvEhCK0ilRKg48XTvlsuB71AGh+9zKLviVCYeA0+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=Zdl2TGmN; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d284b9734fso13707825ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 00:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1741336139; x=1741940939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YlIiXhwG4KRcbOBdAmDvGTlkxDSVAhUX3csscpKyVg=;
        b=Zdl2TGmNjlXM06Ncz5wDIhQU5kU/XKpjSvqrO1WU+20bi93on/Dr62PNLgLzq9njkp
         A8KIVGFrLsy6+qndjyEmbO95Zr9dOkP8syd5rWFfnC2jbYWCXShunygvVFuEMETsqr1R
         p2FHgbc9iNynHkzuCPeJudsXw+miMPttLaIuKfprPvD4txughSOtIA1L4FzOEg8KQJtN
         UTsi1t8uwlne33L0gE9Z7lOnAnPEunKdvAB11dPz6hZa8aalqxCEsIfJEYfFo6vx97aC
         BjoZQfopMDxP4m7pjK1GHHPdHRTuPMtOoeL4ZFtGYM390tdduHD4cgli6tmcMPIYlI4V
         XRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741336139; x=1741940939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YlIiXhwG4KRcbOBdAmDvGTlkxDSVAhUX3csscpKyVg=;
        b=MgXPVRfQAHfnBMNb7bHarTgW2kYpok7pWehgr5LaLxKbhuwyNVa1mcSSH1oFLZNeCR
         pkAiX2NM3PtzJoZYCVw3zG+nPWo6AjWZjlYSBnxFcSxL65pglrfkt6mandRdYuQQECcr
         fopV6Aequ34ANAEn7yPYFH8H9lqlgzd5ClaHFAQwNNyK4nenUh8FaP3wwxXrJ+oyvGWm
         AE2bwcf0SQ7P8hejpukU4mxQgkul/I0nKkzoi8tF50WYbJmLOg0elMrMLtQ/8wD00iws
         Mpqcc+PZYTr2aUpfXuSaH/R1r14S/59LqTmi7AAlb8smYSFIjYPMTNeSYkR7pOMHnaIJ
         YsXw==
X-Forwarded-Encrypted: i=1; AJvYcCU7w+kB9As8hVmFLufcd79PtGmsGQL/zqa1mdu7Vra7Xc9EH95Gkde30G7yuHSReUHmPcrqDCjjEh8mP58=@vger.kernel.org
X-Gm-Message-State: AOJu0YxORl0V09YIGu6HCFRDcSVKye6twJYLXegX+2HohkFccQaiQ5VK
	VMT9njbojv+GNi8aX+38ncmsvIZI5FGzRjz9ci8pPJsq3xlw9ddOeIezMio6xtZHE8/q5eq8edj
	uVIvJOl75NHqgmAU/lw9tocUg8y3hSpuIWR/DoQ==
X-Gm-Gg: ASbGncuV/krvBJfmsxARLBJnp71C6P/76eXB2UneAESEsksqARCGChNq8JNBfrvfNDR
	GZsS/ihNLCY2JDJSW370MmRs3qH6kzlXwcc4asXhJejkw/y7pdbMt0ocB8/9bHF7moPpmX99xQG
	71QojBUBkikYg/oBD9CIJ1wbhX7sk=
X-Google-Smtp-Source: AGHT+IHpyge1YXB1VBykLP/dh9ft8HFAB3zzw6CmKWnhV8/XYcR00xSa4YW+S5Z3jF04shZ9TO0vf5OuS0Vy70VC954=
X-Received: by 2002:a05:6e02:16c7:b0:3d0:239a:c46a with SMTP id
 e9e14a558f8ab-3d44194816cmr30189715ab.9.1741336139186; Fri, 07 Mar 2025
 00:28:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-kvm_pmu_improve-v2-0-41d177e45929@rivosinc.com>
In-Reply-To: <20250303-kvm_pmu_improve-v2-0-41d177e45929@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 7 Mar 2025 13:58:46 +0530
X-Gm-Features: AQ5f1JqfLRDl2sXghMrs9tGiGCXrhEWfy1IvZjbEz2be6tiJtFVbpcg_wKAhY44
Message-ID: <CAAhSdy3KncYJhPAa20oH=bB1Zi5-=sD8m69OYFS451q3_EMiEA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] RISC-V KVM PMU fix and selftest improvement
To: Atish Patra <atishp@rivosinc.com>
Cc: Atish Patra <atishp@atishpatra.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 4:23=E2=80=AFAM Atish Patra <atishp@rivosinc.com> wr=
ote:
>
> This series adds a fix for KVM PMU code and improves the pmu selftest
> by allowing generating precise number of interrupts. It also provided
> another additional option to the overflow test that allows user to
> generate custom number of LCOFI interrupts.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
> Changes in v2:
> - Initialized the local overflow irq variable to 0 indicate that it's not=
 a
>   allowed value.
> - Moved the introduction of argument option `n` to the last patch.
> - Link to v1: https://lore.kernel.org/r/20250226-kvm_pmu_improve-v1-0-74c=
058c2bf6d@rivosinc.com
>
> ---
> Atish Patra (4):
>       RISC-V: KVM: Disable the kernel perf counter during configure
>       KVM: riscv: selftests: Do not start the counter in the overflow han=
dler
>       KVM: riscv: selftests: Change command line option
>       KVM: riscv: selftests: Allow number of interrupts to be configurabl=
e

Queued this series for Linux-6.15.

Thanks,
Anup

>
>  arch/riscv/kvm/vcpu_pmu.c                        |  1 +
>  tools/testing/selftests/kvm/riscv/sbi_pmu_test.c | 81 ++++++++++++++++--=
------
>  2 files changed, 57 insertions(+), 25 deletions(-)
> ---
> base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
> change-id: 20250225-kvm_pmu_improve-fffd038b2404
> --
> Regards,
> Atish patra
>

