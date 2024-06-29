Return-Path: <linux-kernel+bounces-234986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 783DD91CDF8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 17:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C5BC1C21080
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 15:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95768564A;
	Sat, 29 Jun 2024 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pc6ky84E"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569768286A
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719675683; cv=none; b=a+CJCW7Dvb75VdSHObjUoWQTOGv+D+pd2a7Xy6ZDIPNaLX+3ayCNltaFtf382BgyBs2Kc6bAViDOhJwnhyPJKkVDCgWgJ/ewKyJ8N+XiPK2Ax6hMBRj/Qiz9A8MuM7/e0T0rAdmEqISE2qZqu0ljv2+yGakLVZQ3U6LNaoxEUWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719675683; c=relaxed/simple;
	bh=DMeIYntaGyx/3udKaLVfUapBSggn/EKXU+zMLd6LXiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWNDNWSSECxg4ULdKsUSI2oBrWN6+2NGuecDNg29U0KuW3ESG+HGSezauk86Q1xAmz55u/eytn+dZGzB8Hkc6rxd/xYaM91tf84PQyhBcSBhkAu7RK0QvQ2DdSQoJhwGPQJxz9ZLWpLx73Ona7ZMjSJiK7v1pUA+ZdhtZSx2vUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pc6ky84E; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ec61eeed8eso19318291fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 08:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719675679; x=1720280479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aoxmox5eBIkVDi8vBxgtfZej1EQ1HZTnJK5bAOTy1Vo=;
        b=Pc6ky84EXVLk84lC2UcN46GPUvNlS2PJXkoTCZgimD2eK2tn9UE2rNyOYZv27Pxr3t
         ayygLwdxKBmQHBgTQi+HfDRkK4haaPAVo/J6qd8I8t3gvvD1b5mruuueoOO5oYo5taO7
         6AsFWGFar9zF09vwVE58OTfsrfBMAEYjUjUQIU4vh6DXlklzY1DhNaDjWdH1aFiHgPlJ
         V/5K8SmpYfJkki/RDuKokDxfBSJ0xWDItZNs3DqCH+ySaboK2bBiQcLE30eR1mSGV+BO
         s3VvWWn4z6GU6K9GPJowJCRTXwHQ7KkTpDeBEqrV0CcNZKfUasDkDxeAHSfArps3wqBY
         wubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719675679; x=1720280479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aoxmox5eBIkVDi8vBxgtfZej1EQ1HZTnJK5bAOTy1Vo=;
        b=q577sZ3TjXX2eO2g1AlHKeRYFf/S51ugTxY7/YaQLZoSc7nQ6XE3bnRexKtioJTZI0
         P3L5lhap7PIDkrNGQqmjxW7ht6aCfNW2cqSmE3/baf/MWLXOiyLiTwBQKykSyG+mP0Mq
         2syusbBVi+ybCqOQ4OFUre0Vj93IvWxdWvWZBWxOtd+TMsQRji24ZTrrWbC8eUmFOC5c
         xNsXvAfpdL9uvHyT1SJeV+iwVsvZp8cOZkh7k8/dkvoDsBe/xvu5kLAM+Id1l4QWWGq/
         6UKsgtjZCneIBpdCxZKHov/wgJh667K6O9tE9ssxjPrXwloB5b739HVfxQbIM2veHzDM
         eIqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbh89nmXmUkxZ4c+Vdddph0oqwgzKXgwgDyjW2n2Bb176iCMD+cIp4XFelNFJ9TSkCRXJ7lRp3sShLgwPe02+Y4ocQqJSVaegx3Dp/
X-Gm-Message-State: AOJu0Ywt66zYPJMB9+D1jZDbaYLym7Yc1drpjCqTBfVcuZIy++KwdNOu
	qfVVoxkB0rJMO3hAPSZDmEFPYrg/ADGgMYhZngvsDxCSpChSG1pHrC4tJNU3soUd+q5i6l8Y91z
	1UT2GD66WVtEo/avrrFIrzYx0JA==
X-Google-Smtp-Source: AGHT+IHaAa7k97l7voQh9B9SuQqwncKl+W4BjACyju7LNYGNQ5cWYXCtkv0B0JQtN8AWXNZPgFemyjAP7xjab2X1N6A=
X-Received: by 2002:a05:6512:a8f:b0:52c:e0ce:2d32 with SMTP id
 2adb3069b0e04-52e82687e2cmr1004291e87.36.1719675679177; Sat, 29 Jun 2024
 08:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627-fix-dosemu-vm86-v2-1-d5579f698e77@linux.intel.com>
In-Reply-To: <20240627-fix-dosemu-vm86-v2-1-d5579f698e77@linux.intel.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Sat, 29 Jun 2024 11:41:07 -0400
Message-ID: <CAMzpN2gmxgbuYqwEcia7bpXhHHh_KgY37_wbwGeK5oBAy5=reA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/entry_32: Move CLEAR_CPU_BUFFERS before restoring segments
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, 
	Robert Gill <rtgill82@gmail.com>, Jari Ruusu <jariruusu@protonmail.com>, 
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>, antonio.gomez.iglesias@linux.intel.com, 
	daniel.sneddon@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 10:57=E2=80=AFPM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> Robert Gill reported below #GP when dosemu software was executing vm86()
> system call:
>
>   general protection fault: 0000 [#1] PREEMPT SMP
>   CPU: 4 PID: 4610 Comm: dosemu.bin Not tainted 6.6.21-gentoo-x86 #1
>   Hardware name: Dell Inc. PowerEdge 1950/0H723K, BIOS 2.7.0 10/30/2010
>   EIP: restore_all_switch_stack+0xbe/0xcf
>   EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
>   ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: ff8affdc
>   DS: 0000 ES: 0000 FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010046
>   CR0: 80050033 CR2: 00c2101c CR3: 04b6d000 CR4: 000406d0
>   Call Trace:
>    show_regs+0x70/0x78
>    die_addr+0x29/0x70
>    exc_general_protection+0x13c/0x348
>    exc_bounds+0x98/0x98
>    handle_exception+0x14d/0x14d
>    exc_bounds+0x98/0x98
>    restore_all_switch_stack+0xbe/0xcf
>    exc_bounds+0x98/0x98
>    restore_all_switch_stack+0xbe/0xcf
>
> This only happens when VERW based mitigations like MDS, RFDS are enabled.
> This is because segment registers can have funky values with vm86() that
> can result in #GP when executing VERW. Intel SDM vol. 2C documents the
> following behavior for VERW instruction:
>
>   #GP(0) - If a memory operand effective address is outside the CS, DS, E=
S,
>            FS, or GS segment limit.

This isn't limited to just VM86 mode, since any user DS that isn't a
flat segment can also cause problems.

> CLEAR_CPU_BUFFERS macro executes VERW instruction before returning to
> user space. Add CLEAR_CPU_BUFFERS to the macro RESTORE_REGS before it
> restores segment registers. In vm86 mode kernel does not support SYSCALL
> and SYSENTER instructions, so the problem is only limited to int80 path
> in 32-bit mode. In the opportunistic SYSEXIT path use
> CLEAR_CPU_BUFFERS_SAFE that ensures a sane %ds value.

The simpler fix is to use an SS segment override (verw
%ss:mds_verw_sel), since the stack segment is still valid right up to
the IRET/SYSEXIT.

Brian Gerst

