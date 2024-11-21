Return-Path: <linux-kernel+bounces-416457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2859D452F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 02:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5E62838AB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 01:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4201F5E6;
	Thu, 21 Nov 2024 01:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jd1q5w2z"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E04733C9;
	Thu, 21 Nov 2024 01:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732151080; cv=none; b=Pjoheh7Ug05LaeO+P3//zSAgEEJ6fc7Upt3t9ypbEFI4MltDNJ8xGyi7Hhxe1DhWV3UiMtNzPyIUD5Fo9bp3QoQ85g2CwZ5KUEk+lGuKZVQl2b4wpnNowTC5tj/UPagR/OuywXuOlHmnw6o8zMtQEY5zYULXe16ERWFwBA74Bjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732151080; c=relaxed/simple;
	bh=SjNQbUWWP+DtDoP1kYTI1Ze0sG1YzDLgt1sWYXIRN2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5SmXw2/izeq4EYO8oVUQSiFjElIPeTvzMnWaKnuISFnkkRz2YvaKFtgEFLdMJxDaFFzdmDDsWBuTIfge4Ur7pw6zslGVqEHAlIrSwPJfHoBIhO+3azmvwAlTpbBDDKJre6TkqzKM2674NYTDkSbBtkraTsz6jThdtN1VaZ/edA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jd1q5w2z; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ea4c418488so48506a91.3;
        Wed, 20 Nov 2024 17:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732151079; x=1732755879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IU/AIwVgeV5w6FGGxBcIWiVm50Thsufsls4Lt+cFAxw=;
        b=Jd1q5w2z9My8NdyH6LsVM4u+UJqnzvJt4sq6Fppd9Z+jkbBujE5AZeeVCb67NKBAmF
         1SX2hG6VixXTR/yK3kZIA9SISh4qUOb6DveZAvSQaNSPCvYGS/ljnvRIjG+JFKdVYAzd
         s5gSi0yy2rsg3kvTTADQ8BoDcpnP7IkukO2FeGkpeh7bFeLaY3lu2IFZQPiWAPy0fwEn
         qvOJswnB79WuCvb1w9fEumtSnT5hdFGCj170itrwf+pkvZO0B0qma1ugGQj92rwOUThb
         rShn5mLO1gvAQWJeWoR1qsrY5qsC69SuNECdggsgMIajDXKsNlQyalpLnnRAvdPRevsm
         NuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732151079; x=1732755879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IU/AIwVgeV5w6FGGxBcIWiVm50Thsufsls4Lt+cFAxw=;
        b=bci3HudRrVDWeunmFlKS0hHMoNL3WxZal2v35dJRYSLXLaCRKTbxVgZTmWtb3ok616
         w5E1l0UAhHN3hxcbMHE583Hp9FgLXE2frrkM0vPg5oesIRkbe1N4sZtNtjEoP1wajWiD
         NQAOUnMXy5WlBDdgYSb0cTf2euLlK2Ez9gBsFrbFHR56UJs4/6hNTKq+J0yrcEsruboK
         TeBg/0SZfNoiVKWCM0sDN0xUwIW7+GLMZm8V3YHBiaih+G+JCx1n82K99EC2oq+qmF8R
         SMQKuNNoGG+FOsaDxLHhLDQ2RzCYYE8gXZLaNhMNHHTd/62kj4IyPLevCxJ7mueFcD0Z
         FYAw==
X-Forwarded-Encrypted: i=1; AJvYcCV8Rzp2HczULuzRo582T8MywgbaYMT2sHY8Dz676EeyNSQcbPWdGFfghVTHG9RYYR0SmY+Ir54ljL0rKaw=@vger.kernel.org, AJvYcCX0br/rB6YReWB7RSc6T9u66puABwCLbTing5pR1ILL7/9W8oPsjQI0pYXo6BJw6zU+0Jg3XYnPbgN9TTChlEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD4ozUV5HPH6JJXoL3qIJHaLLyu7v0fOrPk5PLvDvvvmvGNlpF
	yGuH4xWuNbPfiR9BxETLCNYuSl5bhWb7Ne1rmBbh1VfARaafZtmOGQQNzAi1gcdVfY/7xS6Wf5F
	EVjS9My4YxwpuYy7hBQe+0K3f0nI=
X-Gm-Gg: ASbGnctqHQgEsQiP6eYqwNzXtfvsKzaj3O8PwKn5g5HYhioP62ddu/qG2WAH0fraHWx
	Qj1Elv+/co5NR3oWu3DXp+w/ROCX7fos=
X-Google-Smtp-Source: AGHT+IHPvpL0/zgOk0G/8Dv/8F/KVywmgi0Gcw5Gh9egq5LlOzppDTLYsdEwJ+PkR8JzxQ+vbtvfcXvWaPQQm1LHbBQ=
X-Received: by 2002:a17:90b:164f:b0:2ea:c2d3:a079 with SMTP id
 98e67ed59e1d1-2eaca70ac06mr2540211a91.3.1732151078623; Wed, 20 Nov 2024
 17:04:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-insn-decoder-test-len-fix-v1-1-44b075deda05@gmail.com>
In-Reply-To: <20241120-insn-decoder-test-len-fix-v1-1-44b075deda05@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 21 Nov 2024 02:04:26 +0100
Message-ID: <CANiq72nyMi5NUwmg20ZzX8RNC8+dP2J3Zey9Qfn+5CaoeET+7A@mail.gmail.com>
Subject: Re: [PATCH] x86/tools: Use a longer buffer for insn_decoder_test
To: Mitchell Levy <levymitchell0@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 11:33=E2=80=AFPM Mitchell Levy <levymitchell0@gmail=
.com> wrote:
>
> Use a 1024 byte buffer for parsing objdump output lines to accommodate
> long symbols created by rust doctests.
>
> The number 1024 is based on giving a healthy margin above KSYM_NAME_LEN
> to accommodate angle brackets, addresses, and whitespace.
>
> ---
> Rust doctests can result in very long symbol names, which results in
> very long lines in objdump output, such as:
> <__pfx__RINvNtCshBBT4i9RzFA_4core3ptr13drop_in_placeINtNtNtCskPkSD4WGMmy_=
6kernel4sync3arc3ArcINtNtNtNtBN_5block2mq7tag_set6TagSetNtNvNvNvCs8MySzWyGC=
07_25doctests_kernel_generated33rust_doctest_kernel_block_mq_rs_04main42__d=
octest_main_rust_kernel_block_mq_rs_58_011MyBlkDeviceEEEB23_>:ffffffff818bb=
250
>
> Currently, fgets will truncate on the first read of this line (but this
> is fine since we see it starts with '<' and continue the loop), but on
> the second we get "rs_58_011MyBlkDeviceEEEB23_>:ffffffff818bb250", which
> is treated as malformed.
>
> Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>

Thanks Mitchell -- this is:

    https://lore.kernel.org/rust-for-linux/320c4dba-9919-404b-8a26-a8af16be=
1845@app.fastmail.com/

as well as:

    https://lore.kernel.org/rust-for-linux/20241117195923.222145-1-sergio.c=
ollado@gmail.com/

It would be nice to get something like this finally in.

Cheers,
Miguel

