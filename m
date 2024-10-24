Return-Path: <linux-kernel+bounces-380565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D94F99AF289
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F1628AF13
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6F42170AB;
	Thu, 24 Oct 2024 19:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="lA5AKoUJ"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1F41FE0F6
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 19:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797426; cv=none; b=EuzP5L7KgVeXYxFfXa9J52jzT2K+n4SD6Z+ly0GUdp/8njCy0gRu22w1vmQ/VjWyFuUSS6dLxGstW845d/P9YuzjxBkkJWXhUTQp+mEkuvaF1Mdv+xhmqJZ/IsWS6XuEMuN1Al8J+XbUz37sBHQk/e9vzhucgCkv8O4wZXEnZDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797426; c=relaxed/simple;
	bh=r2894LsRaL5cMjTp9c/aiq8WNR9qa3a0tHFbx9n/VDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIeIxmKidHlepiM9bB0A1RNNTyRvK6zh4sxd+rNWDhoRYtyO/PXU/Ud3PfYRnQbCoRoyGRrF9TbCNfSK3E8r1u/pwBnXR6S2b52at40Z1zi4TYOMlB7MdbWe0d9Cr1Vnqx+fSz7216rrMyCgPtsFprSOq2V0rKGoMFhZG6HoRFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=lA5AKoUJ; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a4e551efdbso34805ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 12:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1729797423; x=1730402223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMVuNP7DptisRZKMAE62XcZxOQ0ITSLxzIbBe9rphWg=;
        b=lA5AKoUJX5NIwwmgwcPO0LlAnXNw+nDr5zN62GyzVprCGtCgDWXcbL3wbZKSmd/cKV
         q2tkl2+WVcFz036R8T2JRNiF0UTJJy+n5Mvbe9+HwpJCpIogtQuHGpNUcl17ct5wRC+b
         q78WEjVrXTskIjfLoqRXO6mn+aGGaQRckOft+v7EXhfs4hO7youWj1ySdz7r0bMyQ1x6
         3aHrdfL7wgFFuc6ng37zi9seTtXpUdckqOCFGHjDe5kbErGaXluSWILmwojRuMN2z18E
         N9GcNvBFxFa7W6lczd6JavYcSyxkBkKEK8GzFWAgXzfb4O28HsugSwfaH0XnL74SxTEU
         LNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729797423; x=1730402223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMVuNP7DptisRZKMAE62XcZxOQ0ITSLxzIbBe9rphWg=;
        b=pEy3pveFQprscD5bITkwRZ6BpNuRJw2IgViyZrOL16EVmHNK+Kt+gn2Xd3stqz9lfH
         pfmy2nL3pzTS8x0ZUAwyT/B+IMfHq+ZfDUFbwybKqf28KY/6AZicb0TnkF1E2b5rBH9v
         9O1vXBgUjz36Vrt+9lsvKUwT34t7cgnJZY6Y1xWCzfedkZSilDymSC7A/1tLoo4ZFzMb
         k0puBxLpnRwBvgpA5emezAO/F+Bq9HB6peKQG7P246fKBBSjUCkllFY6cACjx6GPXYAr
         YkAX42sfxS5Yx3/QygTctreyP9ZQR2+wsqW1UTaMdc+ons8yzp2QgC9NKO8blEDlrCD/
         D8TA==
X-Forwarded-Encrypted: i=1; AJvYcCXgBU+cl+Jm572VjtSCppKabiJWu5Qnsq3gKZO9gYTfEOCBeGHSirMKaA3zCnC23pVDdO8iY9m8AiyZGj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YytWJDTa780pNTakhftOO+0TnsMfSMgt6WXHk/Bot96GwPwReKY
	y9/e+8RIfNge2x8z/N7R8CdSd9pvEqP2qv/mqqxWgdEB45KPwBd/qzwVcqYVZ4fuOj3OzwLJSir
	MiKaOwZRwSrXodRG/1Vf6N3VLg4LD9u64hTWsdQ==
X-Google-Smtp-Source: AGHT+IFZzEb2zN7h96lApR8DYauv53XlH5oPpoX1QtB4zj0x/HOggQdCeZlKWS+cP9VVlhcXp5Qae/4W4hrCmVnyZps=
X-Received: by 2002:a05:6e02:1564:b0:3a0:c15f:7577 with SMTP id
 e9e14a558f8ab-3a4d5945f99mr81465345ab.9.1729797423093; Thu, 24 Oct 2024
 12:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927-dev-maxh-svukte-rebase-2-v2-0-9afe57c33aee@sifive.com> <20240927-dev-maxh-svukte-rebase-2-v2-3-9afe57c33aee@sifive.com>
In-Reply-To: <20240927-dev-maxh-svukte-rebase-2-v2-3-9afe57c33aee@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 25 Oct 2024 00:46:51 +0530
Message-ID: <CAAhSdy0ncLTAjEE1s-GWL95sscxwQFsKn1rXyA1_VVfk1bQBiw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/3] riscv: KVM: Add Svukte extension support for Guest/VM
To: Max Hsu <max.hsu@sifive.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Atish Patra <atishp@atishpatra.org>, Palmer Dabbelt <palmer@sifive.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, Samuel Holland <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 7:12=E2=80=AFPM Max Hsu <max.hsu@sifive.com> wrote:
>
> Add KVM ISA extension ONE_REG interface to allow VMM tools to
> detect and enable Svukte extension for Guest/VM.
>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Max Hsu <max.hsu@sifive.com>
> ---
>  arch/riscv/include/uapi/asm/kvm.h | 1 +
>  arch/riscv/kvm/vcpu_onereg.c      | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/=
asm/kvm.h
> index e97db3296456e19f79ca02e4c4f70ae1b4abb48b..41b466b7ffaec421e8389d3f5=
b178580091a2c98 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -175,6 +175,7 @@ enum KVM_RISCV_ISA_EXT_ID {
>         KVM_RISCV_ISA_EXT_ZCF,
>         KVM_RISCV_ISA_EXT_ZCMOP,
>         KVM_RISCV_ISA_EXT_ZAWRS,
> +       KVM_RISCV_ISA_EXT_SVUKTE,
>         KVM_RISCV_ISA_EXT_MAX,
>  };
>
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index b319c4c13c54ce22d2a7552f4c9f256a0c50780e..67237d6e53882a9fcd2cf265a=
a1704f25cc4a701 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -41,6 +41,7 @@ static const unsigned long kvm_isa_ext_arr[] =3D {
>         KVM_ISA_EXT_ARR(SVINVAL),
>         KVM_ISA_EXT_ARR(SVNAPOT),
>         KVM_ISA_EXT_ARR(SVPBMT),
> +       KVM_ISA_EXT_ARR(SVUKTE),
>         KVM_ISA_EXT_ARR(ZACAS),
>         KVM_ISA_EXT_ARR(ZAWRS),
>         KVM_ISA_EXT_ARR(ZBA),

The KVM_RISCV_ISA_EXT_SVUKTE should be added to the
switch-case in kvm_riscv_vcpu_isa_disable_allowed() because
hypervisor seems to have no way to disable Svukte for the Guest
when it's available on the Host.

Regards,
Anup

