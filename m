Return-Path: <linux-kernel+bounces-517407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35972A38057
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FBAB7A2F41
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1624F217668;
	Mon, 17 Feb 2025 10:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="1e8nsgRy"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194391917D7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788639; cv=none; b=N01DM1CuM1vJ6gGlhMTxt0LxaAC2vRpPGTK25KSJU69GFG187V21Ek1sHIUg7zluoZVCd2HEMWaE7kchUVZoJGZYS3S38TTmZ9wwHscALOSuyVfV/7cpCzkh0rk6B890lzOuZVF8DR+SsBwiRAwOgP2SoGW5S9vQM8/X/uLRCj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788639; c=relaxed/simple;
	bh=dtbILtLxMaUl8l2yPdhhHAGatYs4PRjliukECJuJak8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+ovcMN/uX+v08xwDzb10FpqR+m00SYGuYqx1VWyY8OAB9QtqIE9Eaw2iJRTeyPdYN65UDvy5Eij2SXLFRhpOCuN+biCOtkleJhZY97jxDJcap3puHgcjttMtIEalMMkxqFwF7SUzLSayTxZv0OEzh8Hv061RA1GIVAgPesZONc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=1e8nsgRy; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3ce76b8d5bcso39718435ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1739788637; x=1740393437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/4vfKOluL1Eg686lBWaj194kh5dTDmMHAYz+CjFLAs=;
        b=1e8nsgRyoAu7BopQM+4mk4O8hjOS6rE4Ba7aGPZLwi/+Z29YwM1VQaL1CARDI6u03s
         YJ9sjVFHA980uaOUoL58HJ/ZLjqnVE5+Q+3BE5vhU6bZ/OdWfksvZeFVgp8jDOM5FMEa
         x/i+WYcPI1K2t4Xi7wngNQFqQWdyBf8AHDLVvlznc9MSuV/2tzhq5DsdP51YgvktIPLA
         QU98kyQ0NJtZ9kOYXD7b92BdYKxxfBIZsl/KLtBsWKfbn2Zjl5lWNSHWQH6xcLPe8efl
         Wz4qvK+KgyZKMjiAHfZmfAvdkFSziVsUiLiEnubcdYa3lZjhix8LLgRLNHKNJ7se1V7b
         LuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739788637; x=1740393437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/4vfKOluL1Eg686lBWaj194kh5dTDmMHAYz+CjFLAs=;
        b=uoMUOSgIxS0j3X0CLjkXB97eObTQ7oxHDg0oJ17EVko0nr06WJt8UDsM6+D4qQBMB2
         JjqJJTJSNbIv9mhXJyQlJ8eNEaWFVEHU/gFCB9UM2QBJobqFozQ3r5lq84oPuHt760Ef
         +antqxdlku0wivzBDIo7vMxwSZPj9O+6wMTYfb6U/u4RbaXtrmnG+EnCwMt8bm+4jcw8
         4UagtNb8HsLNWXE2T8cGSRLo/px9ZmGvDQVyFdMSvgf1D4N+wixL9C3ra2s5xf1QdWiL
         X4X+6ogP4UfRkjsAZFpg0M5nkgE8WnOvQSHEIMYstXjo1rjuKTZG8UZTxH1Xs0AQR1Bn
         JOLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBCrntLZ4inZLkNmDdzYs9IWYotffC4YZgTGS8yfY3EoUWDNhocApZq+EMwFFtqZsa3tfTehjSldcM2P4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz16D8hnocUIVfscn56drwX/gFhvG+2TO1sNclRvUkMNxYmWGPm
	EFbDBEuakqBFjPgatl9jLOq9/dpmOyIT/puslbxuBm4B2ZpEhZ8cpsIP/uOzF8W8HRXDLsFoRs4
	NCvipgnzVKVb6ZCZTkPs3Rgts2c/DD9RMboYJQQ==
X-Gm-Gg: ASbGnct7bK1YhrcSVvnQpswGESxHZp212yccu/+80N3T0ZQuDYchimIjBGRjMXTvwaF
	9myGdGCZbB4JcxVUrqVJG7U6saY+nklQAosLJowRfYEVb3WMd9sgjsmsufoRLZhrI/XsGbakyCQ
	==
X-Google-Smtp-Source: AGHT+IGSgdNxJGmNM6uEFns6lOMjpsz78qALluZZkDvBBvFmGCBC14C1R6jfhNyS8tBwA04k2Qxv26XqVPutxJOehyI=
X-Received: by 2002:a05:6e02:330f:b0:3d1:9f4d:131 with SMTP id
 e9e14a558f8ab-3d28077166fmr81057795ab.1.1739788637040; Mon, 17 Feb 2025
 02:37:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217084506.18763-7-ajones@ventanamicro.com> <20250217084506.18763-9-ajones@ventanamicro.com>
In-Reply-To: <20250217084506.18763-9-ajones@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 17 Feb 2025 16:07:04 +0530
X-Gm-Features: AWEUYZm9T-78sMEKcz3AEQRarONAs9iFjfd-t2ah-PgfAHb_xncGPr7rpaa4a5k
Message-ID: <CAAhSdy2NxgiE4O0BV5nivTzhUSDH-vo+zqvxb39hga3K4-DgFQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] riscv: KVM: Fix hart suspend_type use
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
> The spec says suspend_type is 32 bits wide and "In case the data is
> defined as 32bit wide, higher privilege software must ensure that it
> only uses 32 bit data." Mask off upper bits of suspend_type before
> using it.
>
> Fixes: 763c8bed8c05 ("RISC-V: KVM: Implement SBI HSM suspend call")
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kvm/vcpu_sbi_hsm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_hsm.c b/arch/riscv/kvm/vcpu_sbi_hsm.=
c
> index 13a35eb77e8e..3070bb31745d 100644
> --- a/arch/riscv/kvm/vcpu_sbi_hsm.c
> +++ b/arch/riscv/kvm/vcpu_sbi_hsm.c
> @@ -9,6 +9,7 @@
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/kvm_host.h>
> +#include <linux/wordpart.h>
>  #include <asm/sbi.h>
>  #include <asm/kvm_vcpu_sbi.h>
>
> @@ -109,7 +110,7 @@ static int kvm_sbi_ext_hsm_handler(struct kvm_vcpu *v=
cpu, struct kvm_run *run,
>                 }
>                 return 0;
>         case SBI_EXT_HSM_HART_SUSPEND:
> -               switch (cp->a0) {
> +               switch (lower_32_bits(cp->a0)) {
>                 case SBI_HSM_SUSPEND_RET_DEFAULT:
>                         kvm_riscv_vcpu_wfi(vcpu);
>                         break;
> --
> 2.48.1
>

