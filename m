Return-Path: <linux-kernel+bounces-402420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3062B9C2754
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E051C223B6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 22:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91AB1E1029;
	Fri,  8 Nov 2024 22:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYyi76c7"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7CE1C1F02
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 22:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731103794; cv=none; b=dzsMkPV50wOCDn3npNJJuwqZHupqjLdTZPcLf4sfTbf46FFtxs37cu4yoYEP+zz8uw1iXQKOUwsVGJzgQNh3PbAgprYE17CSMExemwNQZiBV57fcwHbE8a3OHIL1Tg/qCZfzkv6Ls1+k7h8MbvjYff9WUj9/tK21Cz6yZ8kuUS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731103794; c=relaxed/simple;
	bh=7h3bEUv1IvnuWxMHXZZg/tOxncgVu0TUhiCwPz/IFCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f8/jrba5uHw+01REl/z9wLHyV0T9i9G3+iV+E0+uBOmJvqEFfSXALuL3GA8RYxTUPgbWEvEPK0PUel6DP30DNvXnEQHoFfyBu53Dpa6YFI5U2abZQ2pdl3245vb6CUZ5X61KJGYIiKNjReab1iiYy/neGVx27jxx9nUcnSJc2vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYyi76c7; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e2d1858cdfso2116149a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 14:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731103792; x=1731708592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dF3J8VkAH3cvtNnnPFvB9XV0zuboLFZCCqiQRLDaSx0=;
        b=HYyi76c7ABBAJTkie5u8nis6DTCAt2MFX5T4t3JEfAyHKEXIesb9xnLomFyiM0jjSL
         zMSmB8DQN1SPzXLCqWid2HeGm9UV5owKNAWk+m1T74oDvFwlDJhdsqpNYG1DA4r8/CZm
         JQVkMnTwXWmwQm/qsl3iaJpaEUvl8rGcXTgSwKMm4Eh7hoAJJBf5hzEGIAXnq4uXdEhF
         3Nt6ZNu/xK1kLV+xILAkR3tfdtLPRDs28/id6Z/ENJSf7eplH/VA5KIwCkX3Ewv9JQ3O
         f0JM7gYkxQuqkFWOXdyomK8MdZylvu78tIHrZCT9ndjxarNg5E+YCyACozOF2oTY2VcN
         q6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731103792; x=1731708592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dF3J8VkAH3cvtNnnPFvB9XV0zuboLFZCCqiQRLDaSx0=;
        b=jWpt/cBXyR+6JjtymqN6SvhQ53k7RSxltbRXuFzDGDrwDuQfPEIeIR1FgukigF7DpO
         9D7hZNBgXYHkrjrigs0/5AgfIhCO7rpP82O0NexgMcMEeeic8VRy48V0bycjOH8VITTn
         s/VbJYTuXgh0A1QKvTG5aztJQy0uU2Qk8dA4AB6be2wb19sJclauAFkKFKtYVK/nwRCH
         ql3GPbZMRFIrs7F6F1zyszwjlwtTgqTxRnTdThI793KwBv/tf8MT5WAzjj0qsCSyGYaC
         OsCGmlmGkRqtoryj75EnzYu6DOH7Rvd7c8O1SqhaEEEp7NnrArJ2E6e1iLb5POLhfX0S
         n/aw==
X-Forwarded-Encrypted: i=1; AJvYcCX6aNAbUb+zttKRwdxd7SXyXCc1lwXKU9yfDLg9wRn+CfXqlpGmnLwcM4gZxR4+bkqHn5DX3DyVITfUz6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjhnkX/zv2vJAmmGLA9i4XeBOjlCzQmLlmKpvy2ySqKVRN748I
	n7RqSsvNlcjsmdQz43zRLNtXqh5x+SpT3HxJ38elaz8JNRA7QQ/eLs6+grEMRBav6e9n5Et19Vn
	i5nc7gtF3lB7ya5G6PDSMpirwB1I=
X-Google-Smtp-Source: AGHT+IFgJOTFb7QnLKqguH5RwFwGFJwcoFt7e2VEzQvwylUorflBkV9Ne6pUpikQ6ZsM1bsNSLSsMC3RlEhBG34XiXo=
X-Received: by 2002:a17:90b:1644:b0:2e2:b41b:8544 with SMTP id
 98e67ed59e1d1-2e9b1740eedmr6311641a91.21.1731103791894; Fri, 08 Nov 2024
 14:09:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107-fix_handle_misaligned_load-v1-1-07d7852c9991@rivosinc.com>
In-Reply-To: <20241107-fix_handle_misaligned_load-v1-1-07d7852c9991@rivosinc.com>
From: Jesse T <mr.bossman075@gmail.com>
Date: Fri, 8 Nov 2024 17:09:16 -0500
Message-ID: <CAJFTR8RBcoqYmWNmNe_ZixO3bv2aP-wGCbX7ieorXYxxMAa7BA@mail.gmail.com>
Subject: Re: [PATCH for-next] riscv: Fix default misaligned access trap
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@rivosinc.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 5:38=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.co=
m> wrote:
>
> Commit d1703dc7bc8e ("RISC-V: Detect unaligned vector accesses
> supported") removed the default handlers for handle_misaligned_load()
> and handle_misaligned_store(). When the kernel is compiled without
> RISCV_SCALAR_MISALIGNED
Technically CONFIG_RISCV_MISALIGNED.
I apparently changed `+obj-y +=3D traps_misaligned.o` to
`+obj-$(CONFIG_RISCV_MISALIGNED) +=3D traps_misaligned.o`
in V2 and didn't change that check back oops sorry.

> , these handlers are never defined, causing
> compilation errors.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Signed-off-by: Jesse Taube <mr.bossman075@gmail.com>

> Fixes: d1703dc7bc8e ("RISC-V: Detect unaligned vector accesses supported"=
)
> ---
>  arch/riscv/include/asm/entry-common.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/a=
sm/entry-common.h
> index 7b32d2b08bb6..c2808561df81 100644
> --- a/arch/riscv/include/asm/entry-common.h
> +++ b/arch/riscv/include/asm/entry-common.h
> @@ -25,7 +25,19 @@ static inline void arch_exit_to_user_mode_prepare(stru=
ct pt_regs *regs,
>  void handle_page_fault(struct pt_regs *regs);
>  void handle_break(struct pt_regs *regs);
>
> +#ifdef CONFIG_RISCV_SCALAR_MISALIGNED
>  int handle_misaligned_load(struct pt_regs *regs);
>  int handle_misaligned_store(struct pt_regs *regs);
> +#else
> +static inline int handle_misaligned_load(struct pt_regs *regs)
> +{
> +       return -1;
> +}
> +
> +static inline int handle_misaligned_store(struct pt_regs *regs)
> +{
> +       return -1;
> +}
> +#endif
>
>  #endif /* _ASM_RISCV_ENTRY_COMMON_H */
>
> ---
> base-commit: 74741a050b79d31d8d2eeee12c77736596d0a6b2
> change-id: 20241107-fix_handle_misaligned_load-8be86cb0806e
> --
> - Charlie
>

