Return-Path: <linux-kernel+bounces-287539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 211D49528E6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE73287E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 05:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6621494C7;
	Thu, 15 Aug 2024 05:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="tZnHEQlo"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40A73A8E4
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 05:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723699446; cv=none; b=QP853ZPQ/MUXw+WiwV9JD+EXx9OaApg8evNSAOTZQcsTShaRlzitxIOIDXYlfr5/P0aqON78yA6VHfNpZGQ4ZOaGvPXttw2KxWbjNUE4qSFk7hXm9H9o6ntsid+TyICcXGoB0BUba+3zpBu8eru1BsqH9+uTmkSVxMSVd79Nqo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723699446; c=relaxed/simple;
	bh=lzMm94u6vW5uGaWz+ge2HOMCaStZyHkRDvGsEWfuVug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZElEDSSnFgyDuMLueALzXwvXKetO0KHs5smqvnu7WQPsGmeDjLP/aQffp9O+vvjD62mPa3J2LbLOsxh/pRkgIG6uYyGtSMS7cNT6GgPw8OdgMkFlEZFuqmpnih7CeCA09132jwOLIbZnJzqgLdE90PyvK1ygcRrGp4zSvHEjh+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=tZnHEQlo; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso77450266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 22:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723699442; x=1724304242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKxp3UNSfUbMW/P7GF+qPbZQfJT1dV8M0arWtDTJAUs=;
        b=tZnHEQloNadaGHfmJLsOwXpw4+3Kx9gLsDxNvmBH89eH0z5PGBqayQI98OHIXevL4Q
         E6LLCt6Hw35LpGWn9kfo6/V+jPCeBSYZX7mMrUpKp4rY6qU6ZpLnzTSqPf1FagmvK0tV
         QYFsata2u2afGsTY4T+RkDGisM31VwdNXekSOmoyJt1opRLI7agX1ZEiVIWWqRPcYLM/
         HDWhubyOXI1MrrzwzxTTbNqIpxLxpKdoOCE/FpE/OZhqZmnJSfC1hUehZ9pfrAa7AJJa
         aA2WJbIVS93Fo2EokHgyXHfq0lFCf/MmKUP4nEc2g7OSXlnoc6Qho+dC+aGQKaU/YiCS
         oEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723699442; x=1724304242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKxp3UNSfUbMW/P7GF+qPbZQfJT1dV8M0arWtDTJAUs=;
        b=Iu7xWMJ4zRhgvBNWymOjCym1233JpQxij88okUgmlMnHv8JC7cLDT2OoTxDrijqLcr
         AhNyEWE0MDRCGuujkGp6epm35/19ivoKe95ks4mYTwe18cvIF13TawqKTgLaBzX459Ok
         AJtB889V1df8jJ0kLzjmzgli4Tdi4YioC41Y4sWKGN8ZEnzYNchT2lNdCh5WPB1RUPHJ
         B7ZNnsJHWaaKEOubDkYy81RgHwZSF8cdC0VOYvH42/+UKChIIemKyVCNHRG1bEapQmAq
         9XbiECD2bhxn+1aW/D6Ieip55xJ9TAkGDidxohfDNYp0LWsrAXmMtYN32nmkSQxO+yjk
         jK2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWcb6b2cETFlk93HTTPDUF3wjEPezETkvjNd+L+ZZ+DCXHGI5I6CE4kVGMABOWuXhqbgYRkXBTc9M7jAU2J2Q0xurkRY0JsHGFSf/vx
X-Gm-Message-State: AOJu0YzuuE5YPGqpZ4uANETR81SHRjfz8jYbyr67KVkeq7HcedndjNrb
	A3nl68sEpajXxAwyoY8WmZEOi+JIs5+oiX9UB8VZU/KXiey7TPz8jaAeJUW/9cwfYeis9oaVMT8
	0dj1FI73OPWBeQB1i8iFSp09bOve/ZyFxLnv39Q==
X-Google-Smtp-Source: AGHT+IHDME2M4oRRU1tPkqrKQKVieU27NVCFCstk8M6tOb4plumxgASPhmUSJGc9E9Et+SL7sPhom9XcSZZ+b5pJONk=
X-Received: by 2002:a17:906:6a17:b0:a7d:2c91:fb1b with SMTP id
 a640c23a62f3a-a83671101f1mr279976066b.68.1723699441761; Wed, 14 Aug 2024
 22:24:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814192619.276794-1-alexghiti@rivosinc.com> <20240814-overexert-baffling-1abf9a80c7b0@spud>
In-Reply-To: <20240814-overexert-baffling-1abf9a80c7b0@spud>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 15 Aug 2024 07:23:49 +0200
Message-ID: <CAHVXubhMDS5s=_VSoJ8nXKg4o9hAE-bb+1V4xuSxFvgPBUCBqQ@mail.gmail.com>
Subject: Re: [PATCH -fixes v2] riscv: Fix out-of-bounds when accessing Andes
 per hart vendor extension array
To: Conor Dooley <conor@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Andy Chiu <andy.chiu@sifive.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 12:26=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Wed, Aug 14, 2024 at 09:26:19PM +0200, Alexandre Ghiti wrote:
> > The out-of-bounds access is reported by UBSAN:
> >
> > [    0.000000] UBSAN: array-index-out-of-bounds in ../arch/riscv/kernel=
/vendor_extensions.c:41:66
> > [    0.000000] index -1 is out of range for type 'riscv_isavendorinfo [=
32]'
> > [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc=
2ubuntu-defconfig #2
> > [    0.000000] Hardware name: riscv-virtio,qemu (DT)
> > [    0.000000] Call Trace:
> > [    0.000000] [<ffffffff94e078ba>] dump_backtrace+0x32/0x40
> > [    0.000000] [<ffffffff95c83c1a>] show_stack+0x38/0x44
> > [    0.000000] [<ffffffff95c94614>] dump_stack_lvl+0x70/0x9c
> > [    0.000000] [<ffffffff95c94658>] dump_stack+0x18/0x20
> > [    0.000000] [<ffffffff95c8bbb2>] ubsan_epilogue+0x10/0x46
> > [    0.000000] [<ffffffff95485a82>] __ubsan_handle_out_of_bounds+0x94/0=
x9c
> > [    0.000000] [<ffffffff94e09442>] __riscv_isa_vendor_extension_availa=
ble+0x90/0x92
> > [    0.000000] [<ffffffff94e043b6>] riscv_cpufeature_patch_func+0xc4/0x=
148
> > [    0.000000] [<ffffffff94e035f8>] _apply_alternatives+0x42/0x50
> > [    0.000000] [<ffffffff95e04196>] apply_boot_alternatives+0x3c/0x100
> > [    0.000000] [<ffffffff95e05b52>] setup_arch+0x85a/0x8bc
> > [    0.000000] [<ffffffff95e00ca0>] start_kernel+0xa4/0xfb6
> >
> > The dereferencing using cpu should actually not happen, so remove it.
> >
> > Fixes: 23c996fc2bc1 ("riscv: Extend cpufeature.c to detect vendor exten=
sions")
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
>
> You're missing a changelog here, which is doubly important when you drop
> tags provided to you on an earlier version.

Yes, you're right.

>
> >  arch/riscv/kernel/vendor_extensions.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/kernel/vendor_extensions.c b/arch/riscv/kernel/=
vendor_extensions.c
> > index b6c1e7b5d34b..a8126d118341 100644
> > --- a/arch/riscv/kernel/vendor_extensions.c
> > +++ b/arch/riscv/kernel/vendor_extensions.c
> > @@ -38,7 +38,7 @@ bool __riscv_isa_vendor_extension_available(int cpu, =
unsigned long vendor, unsig
> >       #ifdef CONFIG_RISCV_ISA_VENDOR_EXT_ANDES
> >       case ANDES_VENDOR_ID:
> >               bmap =3D &riscv_isa_vendor_ext_list_andes.all_harts_isa_b=
itmap;
> > -             cpu_bmap =3D &riscv_isa_vendor_ext_list_andes.per_hart_is=
a_bitmap[cpu];
> > +             cpu_bmap =3D riscv_isa_vendor_ext_list_andes.per_hart_isa=
_bitmap;
> >               break;
> >       #endif
> >       default:
> > --
> > 2.39.2
> >
> >

