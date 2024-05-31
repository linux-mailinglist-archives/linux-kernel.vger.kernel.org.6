Return-Path: <linux-kernel+bounces-196263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2595E8D597C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8EECB25047
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 04:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E017F49B;
	Fri, 31 May 2024 04:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="AqbnsYY+"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D8E7C082
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 04:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717130064; cv=none; b=tWiSajnBr9GlMlqEPYqFZ7SORqAEZjcJDfggg5Tt2ofHgnDZgqCrUhRXS4nSLOgGdYU5YhM0Cz5AkN+2JvWuD4VrM7Pi2nmc59pp+CZIFAKn1aEp2WzmAYSUbyOHsKhNLe11esG/+93kB+rTLuPcdZyaEXYGtLV6taYs78Fyjek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717130064; c=relaxed/simple;
	bh=JbXFS0Fgv/0TnV1TSruhy4/VftWuFz4YNvlVR+xTgiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJ2gGxnn/UXg/VMF0s3MVRuL6yJtGyuGkxjmWtxQGRIjXy3UJK4QWeL+pRlsPqHbVl2QEGZSJv8SiRxTlUG4RuQ5zDv3dOwIf63mPQPInVky4rX3ub/SSLXarL37gGlHtFcMLoIbbkvrO64X39mIbrxYf1O2M5sxnOK5+ghicW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=AqbnsYY+; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7eacb1bc636so77719239f.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 21:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1717130061; x=1717734861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aojvCCZI7oDG8nQF+lVjR38DWbQN1/i4Dj6O/Uiios=;
        b=AqbnsYY+ZJqS25mKTXXbsEc+6PFAz4NGuL7fyC1LDyYey/h+41o2HgGplLyyvddlh4
         JE5CGhKsnv8T1HoLBWS0OY+pItTr/wOir+sr8Fd16+3dXLpnaQHED5wFD3WjCNpPfynM
         PEU1m3BHIWQSv8ZOTEStHfqMXZbxR71boo9DysqGQdH7JA+G0tkt1EfRcTRTN2w6un7w
         5LAZnJu1A5vOOR6kQbo9E3oZEfdwHxKd4rOcCdSUM9FtajBHgk4j1YifDa1DzUh41Fpu
         BzDbYHfymX6YGCkLomGatWYsPPBEPPZQuYNmYKxxh8WV9M9EVQNFNXfoBuIgYVBGuipB
         K2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717130061; x=1717734861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9aojvCCZI7oDG8nQF+lVjR38DWbQN1/i4Dj6O/Uiios=;
        b=Fc43I1ceXVrNMG8eysSaX99xVgAwr0XNPkLQEYK0u7HCtrLsa9QI4T5qht/VUH4rgO
         p3Oihvf3671o+BLGt9uV05PniWgABaAhqqxJknPXUH+B9y0uS7wF2Afkg9F6OvMYOcH2
         RXa0fQzua92lcTD+HOEAzxwBK3/LDM/Rx+d93/8NdI5c9/EzuTG2sM4ijyfzjJzethxC
         fIGTReeBus1S1xtqRcatJx+ITUB9/hc7UjTbYu3yroA/LJ2lkVYFbvm3WF6wiL/x5DYz
         8WsAnzPL2uk87ej7hyhxcOZ79yJVdoiIpdi1Oqg0Q5pb5r3CpnbauDmRbM3l7GS5E9GA
         URDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiRNBMPyphsjFbceGYfhIs2ArjAl/U4Hp4BClWRcOQ6/5frE1DL1alB/fwqRzolSQ/ZAHO2dz+ud6+LrFQc8v4WciL/RgBgJEj6exT
X-Gm-Message-State: AOJu0YxJaWWG18NI3BoOg+2N5OJG0N+hz9J+X6BmYKfZzPCasgH3r8Yh
	ThpnwVroQ3hxBin7QcMXeYuGOtfl8jOQUq3BezXPhEGK/j/Mio5seCxNKpV8sUR8CDtwjzlI9U4
	nG7DQR9meyN4nZkS7qhBU1av5LbKE240sW7z7Ig==
X-Google-Smtp-Source: AGHT+IFumUwOVBhqm9jSSegtfTbBsWrL7+wRv2hHDnozjQHdKdEmqi3s7UpbRv2rHVzdr2XDkO13liv49fwxH13T3Ws=
X-Received: by 2002:a05:6602:3425:b0:7de:c59f:2151 with SMTP id
 ca18e2360f4ac-7eaffe71e50mr101316239f.3.1717130060742; Thu, 30 May 2024
 21:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415064905.25184-1-yongxuan.wang@sifive.com>
In-Reply-To: <20240415064905.25184-1-yongxuan.wang@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 31 May 2024 10:04:09 +0530
Message-ID: <CAAhSdy0STe67n6TB2ZH1OYZCTQ+yPycmsQ+8Ay0KsorwVYEo6w@mail.gmail.com>
Subject: Re: [PATCH 1/1] RISC-V: KVM: No need to use mask when hart-index-bit
 is 0
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org, 
	greentime.hu@sifive.com, vincent.chen@sifive.com, 
	Atish Patra <atishp@atishpatra.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 12:19=E2=80=AFPM Yong-Xuan Wang
<yongxuan.wang@sifive.com> wrote:
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

Queued this patch for Linux-6.10-rcX fixes.

Thanks,
Anup

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

