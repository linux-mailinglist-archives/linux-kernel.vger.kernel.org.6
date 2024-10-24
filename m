Return-Path: <linux-kernel+bounces-380291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF499AEBC4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE1D1C22ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22081F666B;
	Thu, 24 Oct 2024 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7Oh6JDh"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6846D1E766C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729786817; cv=none; b=kfH9jVcWKgOY8lf6TJwm7ZUlCE3Z0rBzaJriT4PFyHwtFTcKfQilr1XTj9/P1gU3t7J2yV3F/SkDr5YQTDXCUUDwUGzhmiRV5CjuSvYvg6qbK2gLyXSJDF1sxyAUFe+FsnXK/QkK8wQMTHaM6pYeSFV5tp5ZgeP1m7kogwAHCOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729786817; c=relaxed/simple;
	bh=6nlq719E3aKw9NwLYLIPsCHp99u57KGfOdBVs7hWW1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwEn+RMzcchyjqz1cHlo7LvIDfNI+igoJF/+GjpEMqe6zw7+yCi3Q4orFgAwlILTCbefMttL5EHkS6vbbGpkDXXiFf/pTc9OqMZpp6zxd/sbLGb4zoZrZycgeH5Z20wyxahktWVlO74rtt2nJcnsl1UCF31jD6wvqkXgr1C0xj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7Oh6JDh; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb4ec17f5cso10388331fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729786813; x=1730391613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWHsY4Ye9FKkb7KXAAJ7/6vYdn0slI4EMM110d1cAts=;
        b=l7Oh6JDhwQN56fwI5Zgft/y5gEDfAftKfS/zhOo/7GUHAAEcxcfeg7MZ5X2WwhMc62
         vVu5bzNetnaKNIggU3ULdXTDX9q4US9ukuzeNBHScROCXZv4NaL2MD4WlhDk3U8qBhcn
         a+esycN+OTKZ4iX7s9inkRi9VqTYNyp8/3XsCgVs3sK7pQUylivjp/bD+EkXHQ5eQHuX
         n1wDzc6l6fqpjiqW9xaoFnUHCWyRdmvZglN72zXCP7zwSWIA9HJ4USHqWIR4/ROdanQP
         qdjNv1SOtBu4FATs5LxYy2VZ4behlDRA1SJ+1CHcbc/vmxBn30WL0AXoOLsD2eS8X6mO
         u84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729786813; x=1730391613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWHsY4Ye9FKkb7KXAAJ7/6vYdn0slI4EMM110d1cAts=;
        b=DpmDRBdR0vLaeTgN/ptAW/RAiur76ZRkQiT5JMCW3h236zSQIeLnvkOSrZ0Sm/tOxm
         x6JJ2FUlOTw4nQLIMG5sJGT9G7kEu9KiFwzarIJ/ERs3IHOQwx9kcV8acPDYAixAWnUe
         NANctgvUhM+6Xn8F4cSvBmT4LJaC4JPvvMTSuq4tubnNEMNUW/yFHbDgdphVz0068B2e
         K5Hj24Wf92l+aD0aEw1lHybuj+1edfb6hizdPsvr5pY8QjssRKJaoMgrqdmFEjUM55Af
         bkK7JRoEdu9VUkvkt9c6uVB/SW22iFCfXhqHeLg8w+D+hyJDQK0+KzDm0vldV6J4tqvn
         3fAA==
X-Forwarded-Encrypted: i=1; AJvYcCW2QHVMRP8kwXFnsEFgDrZkIkUDR0JjKQJMqXzNiptc22JynkXHSxrIiCuPvK9VHa9vyMbCunN2yGdrRZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8b3GovdCaqQMeevcFEJOhldLdwXDMWqoRz2DWA/8w3wYK5DaF
	Qg8dis6DSxCxW/bKbnX5mBFj52NRN9jmtPML0ax9yKA4YeHc6Mpa8GQ2FM2erZS6p4hGLYccqMo
	6neEg5d7ijtHelDYT/XalUiNhJrxNyg==
X-Google-Smtp-Source: AGHT+IEuwtU5wTNW0OavfLDuU+4hzny0QFwcBv6Ct28xoEmTJs5+BFD+dh2Jx1qjrYg4vjcJ/PaZDorElpAtqhbN9Nc=
X-Received: by 2002:a2e:a9a6:0:b0:2fb:565a:d93c with SMTP id
 38308e7fff4ca-2fc9d33a85emr40059331fa.1.1729786813099; Thu, 24 Oct 2024
 09:20:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007083345.47215-1-ubizjak@gmail.com> <be62f9c4-eca2-46bb-b566-77c0cbe1f15b@intel.com>
In-Reply-To: <be62f9c4-eca2-46bb-b566-77c0cbe1f15b@intel.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 24 Oct 2024 18:20:01 +0200
Message-ID: <CAFULd4Yux5FPvvuvzy6C5J_LTcWsLmPaMmttH2rPvjQG-ZPMVg@mail.gmail.com>
Subject: Re: [PATCH] x86/ioperm: Use atomic64_inc_return() in ksys_ioperm()
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 5:21=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 10/7/24 01:33, Uros Bizjak wrote:
> > Use atomic64_inc_return(&ref) instead of atomic64_add_return(1, &ref)
> > to use optimized implementation and ease register pressure around
> > the primitive for targets that implement optimized variant.
>
> Ease register pressure at the end of a syscall?
>
> I'll accept that we're doing this just as a matter of hygiene.  But it's
> a stretch to say there are any performance concerns whatsoever at the
> end of the ioperm() syscall.
>
> So what is the real reason for this patch?

Please see code dumps for i386, a target that implements atomic64_inc_retur=
n():

 1a9:    8d 04 95 04 00 00 00     lea    0x4(,%edx,4),%eax
 1b0:    b9 00 00 00 00           mov    $0x0,%ecx
            1b1: R_386_32    .bss
 1b5:    89 43 0c                 mov    %eax,0xc(%ebx)
 1b8:    31 d2                    xor    %edx,%edx
 1ba:    b8 01 00 00 00           mov    $0x1,%eax
 1bf:    e8 fc ff ff ff           call   1c0 <ksys_ioperm+0xa8>
            1c0: R_386_PC32    atomic64_add_return_cx8
 1c4:    89 03                    mov    %eax,(%ebx)
 1c6:    89 53 04                 mov    %edx,0x4(%ebx)

vs. improved:

 1a9:    8d 04 95 04 00 00 00     lea    0x4(,%edx,4),%eax
 1b0:    be 00 00 00 00           mov    $0x0,%esi
            1b1: R_386_32    .bss
 1b5:    89 43 0c                 mov    %eax,0xc(%ebx)
 1b8:    e8 fc ff ff ff           call   1b9 <ksys_ioperm+0xa1>
            1b9: R_386_PC32    atomic64_inc_return_cx8
 1bd:    89 03                    mov    %eax,(%ebx)
 1bf:    89 53 04                 mov    %edx,0x4(%ebx)

There is no need to initialize %eax/%edx register pair before the
"call" to atomic64_inc_return() function. The "call" is not an ABI
function call, but an asm volatile (which BTW lacks
ASM_CALL_CONSTRAINT), so there is no ABI guarantees which register is
call-preserved and which call-clobbered.

Oh, this is the "return" variant -  the function indeed returns the
new value in %eax/%edx pair, so the difference is only in the
redundant register initialization. I can reword the commit message for
this case to mention that an initialization of register pair is spared
before the call.

Uros.

