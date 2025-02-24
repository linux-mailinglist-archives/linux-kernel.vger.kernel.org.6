Return-Path: <linux-kernel+bounces-530127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A593A42F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BFD1761D0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676A11DE2C1;
	Mon, 24 Feb 2025 21:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcCZXU3P"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB76E1917D0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433578; cv=none; b=pE0BHN9BbzXuD7NNr+U+p3spppRPATCgKFnnqVkCpeiMOrPHkG+/32OR0MWOifIbp48G7Ek3IGAEOFCqTF5vY6qpeGvkvmOstmvTHaY8QepZtGhVCibdY1US41LDNDbgJCf8aAoPRzermELWpdidFr9LuhohFPaD0ebIY44Vves=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433578; c=relaxed/simple;
	bh=kFKzAhPmTXXMnWDVyZmQ5/+mLm1vMdPa8LDW37rHS/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jo59fm7HPvnGqfhQ0kgyj33v1y9O0vw+2HP8KQ+VgMuwFnw5RLIiAnYb6fFKeUA6KNghcXfAKrWsmq6IqeYhXyPcI72R0H+iTW9ZO6UAwljankWoesIFZw7YikDuZDb0cpDqaya/rTlhu7WRHfy6yVEQ68ouDjC3WnVgbFqNAqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcCZXU3P; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38f2f748128so2210399f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740433574; x=1741038374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zz5ds8lRnRaiH9r8UdGpt6YrY5Z2iWTQiQ3X4cCqYo=;
        b=GcCZXU3P48ZW/7dHBcc+a81vM47dtZWYGmCeJ4+fCVaqTQV+Kt27e3kuvZfYyTdXr8
         OcbkxYIvIkCMd1O4avSomnv4aoeqk7W2R0ALAGi6UElMWbvuJxIJdF0jMSI0sOSMU4Dy
         qDeX7Ppx2s4VntZ2fXOF7ACVjTRoVsxmp5U8qHAYiDQQvTLRT/+8TtulVvg52swOVV8j
         L6Ic76ZRda3cU5srDtNCmRuZDIPPg0gdBFqcOIiJ6p63GLd/iXj+W9l0GFsMHx3O7xEf
         knQCSl6BpMMp9HrguVgx6F9lpOaAKrRBfXZDveKvUb8XrCbXcQuMeSbkKHORTVFAUxaK
         aV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740433574; x=1741038374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zz5ds8lRnRaiH9r8UdGpt6YrY5Z2iWTQiQ3X4cCqYo=;
        b=w1Yz1y0VXbqgiXOo+JB0+Zh+27KXfvxKDDDs5zf71pkMEBAxaNiRTKrjFAOR+MT5P6
         1P51YWFq6BeALTKi0qfQGqOEw/yrtW0MZvW6TYFuao6T/ZktSG2ryo3nGvXV1q3hS7Pk
         itEEpO+TbT77Fuuik0eeUQpMKQUjac1fhVt9J0/WYAucj6CezLK8Jnas2GwsoTQVsQHM
         iAMFRs5KGvMSRD+Cg6200/niG2wrEVNjGUqc3U0Z1thWBXnJLzSCmYCIS+LiyTbHJ8rl
         ZIRY4ezslIJz714TtdcX+K/iLkoD8WJRX5fzrlbl/qwiTXJVqVB3mL9AoccM0T2KwZyq
         /fLw==
X-Forwarded-Encrypted: i=1; AJvYcCXW5Zrv3Eg3aBzUwNFkSzUfbzhtZOT1nmduK1OXQyW8gESeifqS/YBbesTFjwd+lq1lLWCKJ1oHkfvMJRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVHbiCp7aoTuoBc+B1jMeTff4M5hiq+9GZFtKmQbU395yTBfKV
	oQnIttc/PiynPfCEE/fD/XBDlMnZop33s9qGNkVkhnRlkNWwyHef
X-Gm-Gg: ASbGncsU7rYKQWZdOliOsq0rXTc7XbABTcLpJWzdbnCdw0rRlVdVk2PHop1dgz/iRD+
	hELf8YtMrS0DM9a+heo5VkyO+t02eaw+5h0oAMTFM/nOcEhKaS7Ef/C8PY5OCfEJduuj6r4hFgb
	jge3Xa+b5HPvuL8XRWkMERMlSkiWQ3INdttQ0TCqNV60YlG+XDhJlkcx/XwfoPE3yaOHglwEpxt
	4uBTMl2RSqgKhSB6fXf+fAjkQde55Xz4Ukt//QUic1w0MAs/HQ6y/0azVaJSVUeIydGeB+vxuvc
	oeo6qVFwrxs4A2qaWUgKOOINGOnUuQphqppx0b/ZYvLY7jOXb6Tpo7DxPK02sCf9
X-Google-Smtp-Source: AGHT+IFY029Ik5cmsibefwaM68QoV1oPyoyiE0W+r/Ksx9leN+tUY5NENUNsCrOL8ol0vtnTFdrfZQ==
X-Received: by 2002:a05:6000:1789:b0:38f:295e:6331 with SMTP id ffacd0b85a97d-390cc605164mr516806f8f.19.1740433573905;
        Mon, 24 Feb 2025 13:46:13 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8e72fcsm185516f8f.80.2025.02.24.13.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 13:46:13 -0800 (PST)
Date: Mon, 24 Feb 2025 21:46:12 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
 scott.d.constable@intel.com, joao@overdrivepizza.com,
 andrew.cooper3@citrix.com, jpoimboe@kernel.org, jose.marchesi@oracle.com,
 hjl.tools@gmail.com, ndesaulniers@google.com, samitolvanen@google.com,
 nathan@kernel.org, ojeda@kernel.org, kees@kernel.org,
 alexei.starovoitov@gmail.com, mhiramat@kernel.org, jmill@asu.edu
Subject: Re: [PATCH v4 06/10] x86/traps: Decode LOCK Jcc.d8 #UD
Message-ID: <20250224214612.5569d62c@pumpkin>
In-Reply-To: <20250224124200.486463917@infradead.org>
References: <20250224123703.843199044@infradead.org>
	<20250224124200.486463917@infradead.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 13:37:09 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Because overlapping code sequences are all the rage.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Kees Cook <kees@kernel.org>
> ---
>  arch/x86/include/asm/bug.h |    2 ++
>  arch/x86/kernel/traps.c    |   26 +++++++++++++++++++++++---
>  2 files changed, 25 insertions(+), 3 deletions(-)
> 
> --- a/arch/x86/include/asm/bug.h
> +++ b/arch/x86/include/asm/bug.h
> @@ -17,6 +17,7 @@
>   * In clang we have UD1s reporting UBSAN failures on X86, 64 and 32bit.
>   */
>  #define INSN_ASOP		0x67
> +#define INSN_LOCK		0xf0
>  #define OPCODE_ESCAPE		0x0f
>  #define SECOND_BYTE_OPCODE_UD1	0xb9
>  #define SECOND_BYTE_OPCODE_UD2	0x0b
> @@ -26,6 +27,7 @@
>  #define BUG_UD1			0xfffd
>  #define BUG_UD1_UBSAN		0xfffc
>  #define BUG_EA			0xffea
> +#define BUG_LOCK		0xfff0
>  
>  #ifdef CONFIG_GENERIC_BUG
>  
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -97,6 +97,7 @@ __always_inline int is_valid_bugaddr(uns
>   * If it's a UD1, further decode to determine its use:
>   *
>   * FineIBT:      ea                      (bad)
> + * FineIBT:      0f 75 f9                lock jne . - 6
                    ^^ nibble swapped

	David

>   * UBSan{0}:     67 0f b9 00             ud1    (%eax),%eax
>   * UBSan{10}:    67 0f b9 40 10          ud1    0x10(%eax),%eax
>   * static_call:  0f b9 cc                ud1    %esp,%ecx
> @@ -106,6 +107,7 @@ __always_inline int is_valid_bugaddr(uns
>  __always_inline int decode_bug(unsigned long addr, s32 *imm, int *len)
>  {
>  	unsigned long start = addr;
> +	bool lock = false;
>  	u8 v;
>  
>  	if (addr < TASK_SIZE_MAX)
> @@ -114,12 +116,29 @@ __always_inline int decode_bug(unsigned
>  	v = *(u8 *)(addr++);
>  	if (v == INSN_ASOP)
>  		v = *(u8 *)(addr++);
> -	if (v == 0xea) {
> +
> +	if (v == INSN_LOCK) {
> +		lock = true;
> +		v = *(u8 *)(addr++);
> +	}
> +
> +	switch (v) {
> +	case 0x70 ... 0x7f: /* Jcc.d8 */
> +		addr += 1; /* d8 */
> +		*len = addr - start;
> +		WARN_ON_ONCE(!lock);
> +		return BUG_LOCK;
> +
> +	case 0xea:
>  		*len = addr - start;
>  		return BUG_EA;
> -	}
> -	if (v != OPCODE_ESCAPE)
> +
> +	case OPCODE_ESCAPE:
> +		break;
> +
> +	default:
>  		return BUG_NONE;
> +	}
>  
>  	v = *(u8 *)(addr++);
>  	if (v == SECOND_BYTE_OPCODE_UD2) {
> @@ -322,6 +341,7 @@ static noinstr bool handle_bug(struct pt
>  		fallthrough;
>  
>  	case BUG_EA:
> +	case BUG_LOCK:
>  		if (handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
>  			handled = true;
>  			break;
> 
> 
> 


