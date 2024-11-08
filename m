Return-Path: <linux-kernel+bounces-402423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BAD9C2757
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BC1CB22358
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 22:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986B51EF0BD;
	Fri,  8 Nov 2024 22:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8artpQH"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AC11E0E0B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 22:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731103964; cv=none; b=ohv0wOfRm4L09h1Kg8g7wNHrJQCdqxNWpFrqfUtxYnwE2rJmrhFgY/SrbHB/89s+qEBzaPcfY6EkTfbVFBjKog3ChdjaTGKl+KKhF3te4aJTiNtluoCHdTCvHnhT8rQHHX61YlUHqIfMsExB9xnsLYI8UsM6MiedaHCV7qkhZN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731103964; c=relaxed/simple;
	bh=jnQ+cgf/DDQZD4qWfPzglFVhkx9ffmATFMRxXFwCaT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0n07j/RlrHPWOeRb6F1C2M+WrNRvvySnPt7KlWC54fcbj5UNswo+6tLka0YcNf17InDMJ6qhOXOEGJLfYYa/gQCqXCQFqCNcFyapvjJpLm8tYzdL9X3IpXYu46egN5FI5JLa8k/9PD7jLgaFzH8hkeidcFb5N6FT5C60a7prSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8artpQH; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-720d5ada03cso2687883b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 14:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731103962; x=1731708762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Y8a1AHAlhuTlLNcLfqXjrOEzx68EYY+QPX1C03VNss=;
        b=D8artpQHDoYKOCqU0rr+ruAF2OFYyQJe9PcStQeCQOehqpzhepOBXNAoV5dqWmBpnA
         jcl0IMR6ocgYzcVZhU98Ux3jbW2IZHpW24X6hlMlRlQ61zDVnyjSvHVD2O/4kHJXO47f
         3caCefbpGaW4/9wOPAKlaj0aj2dFOA9pC8Be0kWC3B2DEU2Bju1v/Sg73xWxuPK4vnaO
         XksIFSbfxHoM9FbtMxMe+4qX4+1ew5tAtvsYkxKi5XywYvMDlCv5k+vzxe7mCOo/wsJo
         KFd9SHnBByIvriKH1L0b0TOxH/TRszU5mGnjxlYb81jau62q0qvg1f0xlAB9oI9/aEBq
         z03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731103962; x=1731708762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Y8a1AHAlhuTlLNcLfqXjrOEzx68EYY+QPX1C03VNss=;
        b=n25OXqllhaMMZbMl05LHEL8TUftrIZlZVAD/jhyjJpG2cCkoIKaTGzyrqXLQpfaEEc
         IfGEW9dqou8+cdCpZjuZQwALR6QWqzefV2FiHHdJTghnOiIfELIJMB94ea+xw7rNK5av
         dCes9M2nIY4deRI7HqVvfwZNsX2+ShCKufPx5LOhUUtDhlSvqS3+yhGz9jc6L2Ev7HyG
         5M/Dpxwe0kiPFoyJzYh60kTnmIL6UMqR6q0gHZEAfwl9SV9QN1hvNPjzRAeI0TwI5Bco
         crhcHAsFtFNB/BfdNw7vaFY6JdA8b48Is7xacTNByP9SUF/ZDURHA4dDFw/1F/0kh8aM
         roLg==
X-Forwarded-Encrypted: i=1; AJvYcCWKvRPKJMQq1uG5apjBemPWSmw0UquKtyafFUV3XJUhFJNhgkM2OoUSCV6ukiQbZDkiwEkxON6AclLuuXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgq3Ma4UJIkqyuef6ZzvZONNzX5M9WQFGnFPKkecR5/8dPT7sh
	Gb/PfVo1Wbk4jNdqmy2GRmJmVjmqYzPt9j+kXs/7v4T+UABBP1ajs9HzvyFVhioiGNqA1RpUlFk
	KuUB69/Gnyx+clZZZDtG7h84A9H0=
X-Google-Smtp-Source: AGHT+IHtIoOOc0qNZA15HBrRt6plvL2XTAgiaEwHRJvo/oRBU8GZjS12ieRf2Ck9tGR17spq7vZX3+InpD0NN+fqUVI=
X-Received: by 2002:a17:90b:3d09:b0:2da:8e9b:f37b with SMTP id
 98e67ed59e1d1-2e9b172af1fmr5648708a91.24.1731103961909; Fri, 08 Nov 2024
 14:12:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107-fix_handle_misaligned_load-v1-1-07d7852c9991@rivosinc.com>
 <CAJFTR8RBcoqYmWNmNe_ZixO3bv2aP-wGCbX7ieorXYxxMAa7BA@mail.gmail.com>
In-Reply-To: <CAJFTR8RBcoqYmWNmNe_ZixO3bv2aP-wGCbX7ieorXYxxMAa7BA@mail.gmail.com>
From: Jesse T <mr.bossman075@gmail.com>
Date: Fri, 8 Nov 2024 17:12:04 -0500
Message-ID: <CAJFTR8Sas83NkRPSuSdbb3qtDNra=cbinPoBmpyt4_ic8R5LQg@mail.gmail.com>
Subject: Re: [PATCH for-next] riscv: Fix default misaligned access trap
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@rivosinc.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 5:09=E2=80=AFPM Jesse T <mr.bossman075@gmail.com> wr=
ote:
>
> On Thu, Nov 7, 2024 at 5:38=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.=
com> wrote:
> >
> > Commit d1703dc7bc8e ("RISC-V: Detect unaligned vector accesses
> > supported") removed the default handlers for handle_misaligned_load()
> > and handle_misaligned_store(). When the kernel is compiled without
> > RISCV_SCALAR_MISALIGNED
> Technically CONFIG_RISCV_MISALIGNED.
> I apparently changed `+obj-y +=3D traps_misaligned.o` to
> `+obj-$(CONFIG_RISCV_MISALIGNED) +=3D traps_misaligned.o`
> in V2 and didn't change that check back oops sorry.
>
> > , these handlers are never defined, causing
> > compilation errors.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Signed-off-by: Jesse Taube <mr.bossman075@gmail.com>
>
> > Fixes: d1703dc7bc8e ("RISC-V: Detect unaligned vector accesses supporte=
d")
> > ---
> >  arch/riscv/include/asm/entry-common.h | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include=
/asm/entry-common.h
> > index 7b32d2b08bb6..c2808561df81 100644
> > --- a/arch/riscv/include/asm/entry-common.h
> > +++ b/arch/riscv/include/asm/entry-common.h
> > @@ -25,7 +25,19 @@ static inline void arch_exit_to_user_mode_prepare(st=
ruct pt_regs *regs,
> >  void handle_page_fault(struct pt_regs *regs);
> >  void handle_break(struct pt_regs *regs);
> >
> > +#ifdef CONFIG_RISCV_SCALAR_MISALIGNED

Meant to say to change this to CONFIG_RISCV_MISALIGNED.
As they are defined when CONFIG_RISCV_SCALAR_MISALIGNED is false
and CONFIG_RISCV_VECTOE_MISALIGNED is true. they are only not defined when
CONFIG_RISCV_SCALAR_MISALIGNED is false.

> >  int handle_misaligned_load(struct pt_regs *regs);
> >  int handle_misaligned_store(struct pt_regs *regs);
> > +#else
> > +static inline int handle_misaligned_load(struct pt_regs *regs)
> > +{
> > +       return -1;
> > +}
> > +
> > +static inline int handle_misaligned_store(struct pt_regs *regs)
> > +{
> > +       return -1;
> > +}
> > +#endif
> >
> >  #endif /* _ASM_RISCV_ENTRY_COMMON_H */
> >
> > ---
> > base-commit: 74741a050b79d31d8d2eeee12c77736596d0a6b2
> > change-id: 20241107-fix_handle_misaligned_load-8be86cb0806e
> > --
> > - Charlie
> >

