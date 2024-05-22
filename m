Return-Path: <linux-kernel+bounces-185921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B688CBCEB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC841F24A15
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599878005C;
	Wed, 22 May 2024 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HL33OQuI"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA3880039
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716366301; cv=none; b=ObAK+8m3af0MbtuII8oQ+Vc9q0SZxoj+7eR9+HkaQ2RcSC9NfsbNU59vwfB95cRp0aswqUtWuW9QfdGzIYZBJ4hRo/4tBhEuEXxevQmYJnl42aw4VXoUzG6wiqs5uR5aMI9tPoeFuZJhaVeaLfvTwGKs/0JpvIp9qqThHLQHD+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716366301; c=relaxed/simple;
	bh=ZZjOtieCe2E0oa/JksMhIScdEBtDgFgRJ00fyxssCEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fl59C0FPrR+dIIdMQ035HnSEpoGIsXJoJXXwWtK3QnYmsTqSG3AyC0sE2U4lNTbJqZZ+63GtKylTPOAA+mMdlQgQ7sC51V1VyY2Vzx7ANfoZEinfVysr/lHOUgGNjqivBinEq+qAevylbtFk4yvmwMsc2wjnXlZRp70qRivod7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=HL33OQuI; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c9cc681ee0so2362891b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1716366298; x=1716971098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryQmKzk8MS5bOTQ7tYWhiPdYPLdCvZh4q9YKiDsePQg=;
        b=HL33OQuIIXO+jXY6kblTsqFQftIW4anjuFgUqYEsel+ggTbDESo6oZMK3mHOu1bLwV
         YBO3lQN9agZUeL7x0pnLtu7Ph5GMYCABKexqye/seIqmw6TdC+MRdpqhSFEeLGDcCj7C
         EEWqE53Yj8MIYAsA8VMZ4v9u/sPxb8wfJaDD84KSDZ52SGtN2c4Ryb2ep1UWIVDwHMeO
         F4xVnxo3UmPgju0lGFwHUNgYCIkSmO9PyL0UZKnn5jvwfwU7AYl3DyneVbwkz1VSTEKG
         iYP6LSJe/oN+/Un3iJgXrMGCbdaha7dbLDh3RRe7IB3CLJkVdJd05aLSLFeTapI2iE2I
         Cekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716366298; x=1716971098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryQmKzk8MS5bOTQ7tYWhiPdYPLdCvZh4q9YKiDsePQg=;
        b=Gy3yv2o2lka+6Db5W+HNMubAPNyyuvpL4CWYnD7mVjIPyG1/4ufpoqsnEbheWbDhcR
         IuVKjQ7QG3FSAKyI1nWoG3JiANpdznI8lDGa4x5hEsTwncbyJmWgu4qYki1zOsly9mmd
         mfIBWOOLjCtT8mHqfvY/60rAa7k41XqWVIBn/YL8wfew2EUOEiF+iQdNKTwWbXcqJyBX
         LJtAq80RtcDlUj9qooICdcXaV1H5pWQpNWxfoqSPLvAUMZutv5VKPLMnssyNvkG6kpDw
         IcrZ/dn1falPxiS2sjnXSNiGTWQknsPwSfami3bBCBESA5bURYt46nQ1f+MC/Gn8ejkB
         /Btw==
X-Forwarded-Encrypted: i=1; AJvYcCWv/oo8s9jRHPUkvpho/xvBAMqzLUx8lUf81rSgz1Cgoud17q26Z2pRPq2ut0XVCTqB/ZeiwUnik4n8ePG1TpEuDS+sAITmeabHRtd+
X-Gm-Message-State: AOJu0YxCNPZS97qgujZ0aHp2cZJo0Nx/gkP82b5GJsRsrr0JbZpNOHs4
	C3Me54USND20ml8TXfEO7ZHm5xHDF5zPlzgqQozVIRxtHU6hA3VRZIKO6CDdiii0KCQJaAorYfR
	fKGhgYVM52aZwW9AmVGXiVG4PrnU2pg79YIT1ig==
X-Google-Smtp-Source: AGHT+IF4k+kxPGLcYD0POCnK9OmyQ9preI608Hi2OXykANc9ri4/InnJ5s0XE9eRonrivkbfast3MVxc50oCdnXsClw=
X-Received: by 2002:a05:6808:140e:b0:3c7:4db:9769 with SMTP id
 5614622812f47-3cdb6c6eb3dmr1592357b6e.47.1716366298226; Wed, 22 May 2024
 01:24:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415064905.25184-1-yongxuan.wang@sifive.com>
In-Reply-To: <20240415064905.25184-1-yongxuan.wang@sifive.com>
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Wed, 22 May 2024 16:24:46 +0800
Message-ID: <CAMWQL2jvNV70dX46J+EzUQXxw1yzVGzB2+knuPFiWK7mF2TfFA@mail.gmail.com>
Subject: Re: [PATCH 1/1] RISC-V: KVM: No need to use mask when hart-index-bit
 is 0
To: linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping

On Mon, Apr 15, 2024 at 2:49=E2=80=AFPM Yong-Xuan Wang <yongxuan.wang@sifiv=
e.com> wrote:
>
> When the maximum hart number within groups is 1, hart-index-bit is set to
> 0. Consequently, there is no need to restore the hart ID from IMSIC
> addresses and hart-index-bit settings. Currently, QEMU and kvmtool do not
> pass correct hart-index-bit values when the maximum hart number is a
> power of 2, thereby avoiding this issue. Corresponding patches for QEMU
> and kvmtool will also be dispatched.
>
> Fixes: 89d01306e34d ("RISC-V: KVM: Implement device interface for AIA irq=
chip")
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>  arch/riscv/kvm/aia_device.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
> index 0eb689351b7d..5cd407c6a8e4 100644
> --- a/arch/riscv/kvm/aia_device.c
> +++ b/arch/riscv/kvm/aia_device.c
> @@ -237,10 +237,11 @@ static gpa_t aia_imsic_ppn(struct kvm_aia *aia, gpa=
_t addr)
>
>  static u32 aia_imsic_hart_index(struct kvm_aia *aia, gpa_t addr)
>  {
> -       u32 hart, group =3D 0;
> +       u32 hart =3D 0, group =3D 0;
>
> -       hart =3D (addr >> (aia->nr_guest_bits + IMSIC_MMIO_PAGE_SHIFT)) &
> -               GENMASK_ULL(aia->nr_hart_bits - 1, 0);
> +       if (aia->nr_hart_bits)
> +               hart =3D (addr >> (aia->nr_guest_bits + IMSIC_MMIO_PAGE_S=
HIFT)) &
> +                      GENMASK_ULL(aia->nr_hart_bits - 1, 0);
>         if (aia->nr_group_bits)
>                 group =3D (addr >> aia->nr_group_shift) &
>                         GENMASK_ULL(aia->nr_group_bits - 1, 0);
> --
> 2.17.1
>

