Return-Path: <linux-kernel+bounces-517418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C75BA38076
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86743AD252
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598AF23CE;
	Mon, 17 Feb 2025 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="sRuV87fP"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8173018FC72
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789038; cv=none; b=M9Qp6KXzmC9ZtrYMacNyfEgzGnjBJSnGWAgm7T0tvfnYRW3F+qXjZtgnZwXc2WUDMHAF35ThKj4QvTumPQ8X0w2dGnB72gY1XUj54xCzPCv/whBxgHn3TfVXPKJay0xt/iSCZfoFNJUQvpRNy+vG2fxkw2axdJdFL2wJ077ot/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789038; c=relaxed/simple;
	bh=FQirNy5/YZ2Udw0QG05Iu/DFbMb3O8n2UUEVTfF3dbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUiWG9tgQh/Jw/4MnBTi3tTdK22L5a5A4ZqY7igu+YLAOMUxYlURKu8dJGRMnv5aoLA3EBtnpPDYvXTzgeUw6X0WRUvSSrtKBBTGVOzwp4027bH0spevqdb5sWzMi/a4YDd8PWc8/Xt1dcg0ORco5KyIImnyNtKEvw7vbbC7zRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=sRuV87fP; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d1987cce10so23788345ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1739789035; x=1740393835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2V99WRo5v5Q3MzOC1ebd9Y57LboqQs5ifLF7qebM8M=;
        b=sRuV87fPerUMyoBYsY9aM5xJw+dTqaSHBlAOF6+OGbqn3JukStestV5ppOQAuMYrmv
         YCWKuTo3lcQJHXEbSZjKe4GC75FHinRE1O0+bWC7uxUgCa9hTipowyXyNJBpPhcNyTQr
         ad0AFbNZmr3XoIbc4dgBYwftzMy3vawJ03+JQTiMqSjIW3wxKIKFVCF6RCdnvldEILvx
         RUrbbXr5relQUrxka5UcVXk5irl5its7vG1ZF8JwLnNPdnPQLn4OL0/WyTr59dYBxEuT
         qVGe6hsJGSjBHM0yMUoIWLFrNABI8BkA72jj0TPoccVKvjqgNRWazgEajXCQ/P0iRBc+
         SpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789035; x=1740393835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2V99WRo5v5Q3MzOC1ebd9Y57LboqQs5ifLF7qebM8M=;
        b=mv/enPOht0Us13O1/jC+QAZNlucgIqs27/GYWYIsejJ1Znvj9JcTNqX3LqViWFV2UN
         e3eje+cs6S4Bunk9oKSk5SgqLvVX1Zi+U6lce5qmZ3K33JhRtYUplWB5n2bPmFLbKTln
         mTTPpv3BAdUnFanmKFD1gEzXLRrh0GQTmcm/7F7IFRXUodpavexn7bV8cDtQ26FB1yiF
         aBgV6DigqtbJf9wIsLXbNO9ddCWUEYZAW5bD1P3nSUgYqtZTIqDE1NHAsAtZro+WuDPW
         5FbIruBWxYHbxquuHEjh2nidXWjfJgGMWbcS3ZVCUA2TlrxUfTQxIUwDb/pyrAZScGmO
         aHiA==
X-Forwarded-Encrypted: i=1; AJvYcCVkx98J3koi9S/iXjwMrrfeisq+2LiC00/HnwEIwKL9QDoQUEGMXq4xz+xZosGaAS376sSHzlOULwrmsy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpJVtmAgxe8rILKIuS+5XM8aWOGjJ+LZPPe3WxGdYCFtKanorJ
	rROFMKxCpLaiOOgtEPa/xZbhz9mt6riD6ZfddVIE1Vj0pagkoEHvsWENQAQdMLDqQzGdGvyAij7
	NM7sEnHVlbtOGuODbMOWlbByb2JicZ4uF0UyxrA==
X-Gm-Gg: ASbGnctVTjtFG7RmD4urXxPQvuf2mwBw15Y8RbEAEN1m4jFXfOrZ1VPWH2tDtSJpTZO
	hHmpQApLYnGI/zTkGMdDsb0ryxMlVUaJx8jmvdRoRTC92sbZa0g+janLFOinBhKvK0TfrchW3eA
	==
X-Google-Smtp-Source: AGHT+IHJJbyqVqnP4ZBh9F+JcrnyLgJr4c9SSZEBg9w0f79c3TFGGpdX5idQXZEwUkQrhZCz3XZ7Xbwuvzc/pn7T5Xg=
X-Received: by 2002:a92:ca4f:0:b0:3d1:9fd0:a898 with SMTP id
 e9e14a558f8ab-3d2807fe646mr61148335ab.6.1739789035598; Mon, 17 Feb 2025
 02:43:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217084506.18763-7-ajones@ventanamicro.com> <20250217084506.18763-10-ajones@ventanamicro.com>
In-Reply-To: <20250217084506.18763-10-ajones@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 17 Feb 2025 16:13:44 +0530
X-Gm-Features: AWEUYZm5Tu9EOU6io4oCKCd5uKf8WCJJPGpCQR8aWoZNoElVhT-bBEGNz1aiL1E
Message-ID: <CAAhSdy0SScanoz9Q_dm9YBP3bkoGGnM5AXGVWhtUrMcUZ9_=Nw@mail.gmail.com>
Subject: Re: [PATCH 3/5] riscv: KVM: Fix SBI IPI error generation
To: Andrew Jones <ajones@ventanamicro.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	atishp@atishpatra.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, cleger@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 2:15=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> When an invalid function ID of an SBI extension is used we should
> return not-supported, not invalid-param. Also, when we see that at
> least one hartid constructed from the base and mask parameters is
> invalid, then we should return invalid-param. Finally, rather than
> relying on overflowing a left shift to result in zero and then using
> that zero in a condition which [correctly] skips sending an IPI (but
> loops unnecessarily), explicitly check for overflow and exit the loop
> immediately.
>
> Fixes: 5f862df5585c ("RISC-V: KVM: Add v0.1 replacement SBI extensions de=
fined in v0.2")
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kvm/vcpu_sbi_replace.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_replace.c b/arch/riscv/kvm/vcpu_sbi_=
replace.c
> index 9c2ab3dfa93a..74e3a38c6a29 100644
> --- a/arch/riscv/kvm/vcpu_sbi_replace.c
> +++ b/arch/riscv/kvm/vcpu_sbi_replace.c
> @@ -51,9 +51,10 @@ static int kvm_sbi_ext_ipi_handler(struct kvm_vcpu *vc=
pu, struct kvm_run *run,
>         struct kvm_cpu_context *cp =3D &vcpu->arch.guest_context;
>         unsigned long hmask =3D cp->a0;
>         unsigned long hbase =3D cp->a1;
> +       unsigned long hart_bit =3D 0, sentmask =3D 0;
>
>         if (cp->a6 !=3D SBI_EXT_IPI_SEND_IPI) {
> -               retdata->err_val =3D SBI_ERR_INVALID_PARAM;
> +               retdata->err_val =3D SBI_ERR_NOT_SUPPORTED;
>                 return 0;
>         }
>
> @@ -62,15 +63,23 @@ static int kvm_sbi_ext_ipi_handler(struct kvm_vcpu *v=
cpu, struct kvm_run *run,
>                 if (hbase !=3D -1UL) {
>                         if (tmp->vcpu_id < hbase)
>                                 continue;
> -                       if (!(hmask & (1UL << (tmp->vcpu_id - hbase))))
> +                       hart_bit =3D tmp->vcpu_id - hbase;
> +                       if (hart_bit >=3D __riscv_xlen)
> +                               goto done;
> +                       if (!(hmask & (1UL << hart_bit)))
>                                 continue;
>                 }
>                 ret =3D kvm_riscv_vcpu_set_interrupt(tmp, IRQ_VS_SOFT);
>                 if (ret < 0)
>                         break;
> +               sentmask |=3D 1UL << hart_bit;
>                 kvm_riscv_vcpu_pmu_incr_fw(tmp, SBI_PMU_FW_IPI_RCVD);
>         }
>
> +done:
> +       if (hbase !=3D -1UL && (hmask ^ sentmask))
> +               retdata->err_val =3D SBI_ERR_INVALID_PARAM;
> +
>         return ret;
>  }
>
> --
> 2.48.1
>

