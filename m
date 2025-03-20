Return-Path: <linux-kernel+bounces-569886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F71A6A8FA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B38AC189FA62
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74551E25F9;
	Thu, 20 Mar 2025 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRPcHugi"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724A01D63E2
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481367; cv=none; b=Qxx/C7pAsUJx5NerCHw2u9qf8aMdFe3e+iGsd31LKUogmBuliLTKgSf2sIcyRCBFt+psC//xZGXe5vx2Zst6RP8o4kB+zR0rPqPsGa3cQRiwwZ72sHilo6m4QwjfUtFBIpRfW4kjkQVECMixfMSjRd9gptYWx8f5ht2RYZLKUa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481367; c=relaxed/simple;
	bh=KxKlMBDzhU2R4r+Zc/iFORTtvNtQRHsJjdQ4ETOjeas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DKawv9uvoWoj51EFCCTGWGQgg+Q49YJLo0ZOEzUl1yR2Lhj5UooCaFo6IoZGOjizTG/JlEvTDaT7XcsNsNIbTr9Vc0p79ERaYEA38kyBFxO9rGGEB6KoSDR54vriP+CZqQseKxKLrciD7ut4AgVqTGS87q5eEQdpnmMoS7xoP7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRPcHugi; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so1737358a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742481364; x=1743086164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOypmIBJoRunUIGCKqRM1J8OpWvKlKZ9o0yS/wQ29gE=;
        b=iRPcHugiQq7px01CAfH1jcb5f2aY5s+EH2/yIcnxO9kqDeRlHEOS+yXOXMSeTe5ROy
         bgfb/zxTT5tttUDSIXgLPDbi0cso0AAFwks+nzzdv/+UGjt6+7/j7x4d1lzN3pwwl1dS
         NbwaFHUZ9bKQQUXzqVdDyPEKAm/189hJGVJ1o0CFPjmDqHw73fgha+1uIOeBtCg/UAFW
         x9FmxHviG1SsaGrPFVRB+TZNxdwoukyJDRWaVzLC562zAabhnJmBp5UYNhwS8QnN1PEh
         qVsLuIOhnHam7Oh3nX12mK+I44HpXZoMtpjMePdyV2l5e7Cn2oNWwOnyqJftJBiTeoDt
         QdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742481364; x=1743086164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOypmIBJoRunUIGCKqRM1J8OpWvKlKZ9o0yS/wQ29gE=;
        b=goewrMCknVcOzwDivg+WNYlWMAPY8SM5r4m3BG001fZ84Q+KuXV9xfWykQQ0dbFujb
         KPHyIhWZff46ZfCc41kHeqiaKVraVwYg/dAWiVOxoLPjKWKCbqHf86vXgRL7d1LerYfH
         NEoCaKy4VX7VkxaqU2MSJCf658ew6t+nqGb9x1lexL4e+iUcyNSO/Eh7Gm7Rt3l08ouo
         eGn+wH5cTLe1VCIvkeCVHQ914rnRcqAbzckUjdrUmXywaW0KAE0YnuVbbQxpZNei1oHV
         sa0a4CYL++bgd8eeO0YkVA52g1e+0dRho/xmXjNVS4QxEqFbafr0iJ8PPKotXSe9HQZQ
         MVVg==
X-Forwarded-Encrypted: i=1; AJvYcCVSJyzz4dYzZUPYJpJFResjZwzZ64SITQO0HLz+cxH6wVNzAo5T66W23+ME3ik2IsBeVx0MU6WpWkyuBB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydbgGGKCBiH4fvbMQSEBi8eHjGacv02enXroflNSz9nPSpSPho
	7n3L3rfpQapc8b6EVn2NIfswZ0iwVBY2bfX1Vw7Ntk2PWLvq088O5Ml1tdqlNzTHbDhvG/T0HlD
	kcXTlb2KSYRVZuZ+gk0Jcw69KE/U=
X-Gm-Gg: ASbGncve29aKvYwilToU6tce9TyUNkrMRR1BpQjO4+yvF1Zfg/Xok7YhTIL29nEcWmA
	c3EFA88hsMDbMqjk12djiA6c4/SSYPRbF8NN3jpnoIknYKZMQ0LUkmgcTQ4I8lby97gx6J8zB2m
	dpjPvzqpSy883Ia9vwqQZtRDYLKA==
X-Google-Smtp-Source: AGHT+IFIT3O/clAND4Vx+js89mhTBNYF80C65CpKQRh/9liYHfbK7zWH6h200sNHwIPMpn1I0tbcNWykGIZE8qoaD+U=
X-Received: by 2002:a05:6402:270b:b0:5e7:b02b:381f with SMTP id
 4fb4d7f45d1cf-5eba02bbcd6mr3528519a12.30.1742481363242; Thu, 20 Mar 2025
 07:36:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320142213.2623518-1-herton@redhat.com>
In-Reply-To: <20250320142213.2623518-1-herton@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 20 Mar 2025 15:35:51 +0100
X-Gm-Features: AQ5f1Jr0zfJtNv6pAfyE2qLz-5w4mm5FO8eoo3YILuyhNtxB2QGaWlgFAR1kGCo
Message-ID: <CAGudoHGr6y-WQY9CZ7mppeX87cgN0dG07ivK+MaoUow3ymArDw@mail.gmail.com>
Subject: Re: [PATCH] x86: write aligned to 8 bytes in copy_user_generic (when
 without FSRM/ERMS)
To: "Herton R. Krzesinski" <herton@redhat.com>
Cc: x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, olichtne@redhat.com, atomasov@redhat.com, 
	aokuliar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 3:22=E2=80=AFPM Herton R. Krzesinski <herton@redhat=
.com> wrote:
> diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
> index fc9fb5d06174..b8f74d80f35c 100644
> --- a/arch/x86/lib/copy_user_64.S
> +++ b/arch/x86/lib/copy_user_64.S
> @@ -74,6 +74,24 @@ SYM_FUNC_START(rep_movs_alternative)
>         _ASM_EXTABLE_UA( 0b, 1b)
>
>  .Llarge_movsq:
> +       /* Do the first possibly unaligned word */
> +0:     movq (%rsi),%rax
> +1:     movq %rax,(%rdi)
> +
> +       _ASM_EXTABLE_UA( 0b, .Lcopy_user_tail)
> +       _ASM_EXTABLE_UA( 1b, .Lcopy_user_tail)
> +
> +       /* What would be the offset to the aligned destination? */
> +       leaq 8(%rdi),%rax
> +       andq $-8,%rax
> +       subq %rdi,%rax
> +
> +       /* .. and update pointers and count to match */
> +       addq %rax,%rdi
> +       addq %rax,%rsi
> +       subq %rax,%rcx
> +
> +       /* make %rcx contain the number of words, %rax the remainder */
>         movq %rcx,%rax
>         shrq $3,%rcx
>         andl $7,%eax

The patch looks fine to me, but there is more to do if you are up for it.

It was quite some time since I last seriously played with the area and
I don't remember all the details, on top of that realities of uarchs
probably improved.

That said, have you experimented with aligning the target to 16 bytes
or more bytes?

Moreover, I have some recollection that there were uarchs with ERMS
which also liked the target to be aligned -- as in perhaps this should
be done regardless of FSRM?

And most importantly memset, memcpy and clear_user would all use a
revamp and they are missing rep handling for bigger sizes (I verified
they *do* show up). Not only that, but memcpy uses overlapping stores
while memset just loops over stuff.

I intended to sort it out long time ago and maybe will find some time
now that I got reminded of it, but I would be deligthed if it got
picked up.

Hacking this up is just some screwing around, the real time consuming
part is the benchmarking so I completely understand if you are not
interested.

--=20
Mateusz Guzik <mjguzik gmail.com>

