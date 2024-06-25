Return-Path: <linux-kernel+bounces-228186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D58915C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18AF21F22473
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03310374F1;
	Tue, 25 Jun 2024 02:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RRaB8Oyl"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865C343AA0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 02:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719281355; cv=none; b=ONH2xn9cSwHYcLpH1yos0uDcd4lAlKXfu2owY994gajSdUfhtsKLXxniO7GILAAAi3IP1XYHGRBe/K11MHvuA/FmJUZtkoKO7+hvO1R1e7nqRRTKA5jUt59rF9motKO8kgg9D/cZxni+WVamnVAWozdNU2BBnCvgOmMR1C0+LYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719281355; c=relaxed/simple;
	bh=8Dgnfl/cmjPFossAwBHG7gXDl7i4eWudTx2LI4TLj04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DE3NbsAiBcr6ramktyTjE9pV4yC2XhhMjdQTNCWYI9tTthcth63y9haJYs+ca4FQk7UJPDepUfYjNa8UZD4R0q/A9lKUZHgL6N8ALKjfAL4CYMVX9ZKWJIXkEaA6E3i8a2tc1JSNbI/Uk1ku/ABeMEO08nFrh5MwQ92VyL+T98s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RRaB8Oyl; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d55aecf55eso23017b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 19:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719281350; x=1719886150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4VgV6qFA43tq7j/BPXZyEIKqUDK/RxNPBkPfT+JLKs=;
        b=RRaB8OylIdFNoOvHVM0DopAF9SanFSoD5+TYFwxcyzMEkKeopcLkNtMTC9Vxo5KA1i
         LHLhq5EJ3FBOIBLlSPjmcT5poaTBCnpL48VIItoJ6eE87WMhbxD53NVhMH+p22GdiB2z
         hwvASKGmkSPbwMDJQiYf4dV9WGZaHDPaowZlgtPdt9Hq8WS/4JahMpiQAHdZvLjq+Oxl
         mVEUV3UEsmfR59yfTI3/DjLgiB1RKl/YKtrmg8dK+c+AV9V4ioIcUaO3oTVH+nO/tVK8
         ha69QKAX7ZriFM5e0mpn3llJ6PdZAihn4rdZxRDJf/gItckqe5GJAWlSTKCaBpeYQSrt
         TRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719281350; x=1719886150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4VgV6qFA43tq7j/BPXZyEIKqUDK/RxNPBkPfT+JLKs=;
        b=aCwIqzOMI2/gEVR94ud7JP7b+zklKLEeVyTyUBhWjyAA9SiaD6vUW0uh3C7jz8gXGx
         izHRt6tZzKjXiw5by+t1KTwcEZodk9XwlRnnSj0mk53jJ5O0YgoS8DtK0z+dvv1T3Q3K
         8QWR5E0VjrjiMSFJB61x30Q/tQRG/OXD0IjYcIDB0GC4QxoP0nz2Ak4gdqzW7a6e+5sH
         HVC/99W8xHD+bRzkwbW3dv0oazzZW7/Yc0hO3u06Z3xgKoqNaDDKa4/m7osxNzwNiG7W
         gL43mkw8O13mcvwi7W82ac7iuDL13IjTdS7wn0oZFCicOB1mWZ2+CsaV0sf8vaSzJ5Sl
         7Q2w==
X-Forwarded-Encrypted: i=1; AJvYcCVlgDW6VEPrAkrEfTQ1udHK1JsKfYZcAXwvs7p8TTnk7VG5dfHB6NRtDiDrDGeUlhydKWPULlocvrYJ8IgWCz2FVGBU+Vd2JbFNKAdd
X-Gm-Message-State: AOJu0YxWJOmalxXFtyDPgpDSH4DpYW+45ZfLe2luwOsREP+HqiYxHzWF
	OL5ZJh7r2mULJNlWCO8X+9h9GSMJ1WyyZySdNZJUzVHQKlL1xa5BdW0hSgdtrf1RGqrnvwxcFcR
	voWGLUIBWBSiQtgGRCO8G+C1W4ja8IfloWZnFCw==
X-Google-Smtp-Source: AGHT+IEf63XSBNB1eogE66LvdOGFLLfaEY5Mo64ee4URqfz824vzQwE0SGokshy/+g/3yRREbtgOp+7oCQjnGfMsbR4=
X-Received: by 2002:a05:6870:c154:b0:24c:a415:fd4b with SMTP id
 586e51a60fabf-25d01753118mr7676775fac.35.1719281350502; Mon, 24 Jun 2024
 19:09:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240622025514.66537-1-cuiyunhui@bytedance.com>
In-Reply-To: <20240622025514.66537-1-cuiyunhui@bytedance.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 25 Jun 2024 10:08:59 +0800
Message-ID: <CAEEQ3wmV56GUNmOMV3ydkKjRu3Jt4Vw9Nb5r-0KYiF9d5tF6fw@mail.gmail.com>
Subject: Re: [PATCH v3] RISC-V: Provide the frequency of time CSR via hwprobe
To: jesse@rivosinc.com, jrtc27@jrtc27.com, corbet@lwn.net, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	cleger@rivosinc.com, evan@rivosinc.com, conor.dooley@microchip.com, 
	cuiyunhui@bytedance.com, costa.shul@redhat.com, andy.chiu@sifive.com, 
	samitolvanen@google.com, linux-doc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	punit.agrawal@bytedance.com, Sunil V L <sunilvl@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add punit and sunil in the loop.


On Sat, Jun 22, 2024 at 10:55=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.co=
m> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> A handful of user-visible behavior is based on the frequency of the
> time CSR.
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> Reviewed-by: Evan Green <evan@rivosinc.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> ---
>  Documentation/arch/riscv/hwprobe.rst  | 2 ++
>  arch/riscv/include/asm/hwprobe.h      | 2 +-
>  arch/riscv/include/uapi/asm/hwprobe.h | 1 +
>  arch/riscv/kernel/sys_hwprobe.c       | 5 +++++
>  4 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/ri=
scv/hwprobe.rst
> index df5045103e73..ec3c99474ed7 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -233,3 +233,5 @@ The following keys are defined:
>
>  * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
>    represents the size of the Zicboz block in bytes.
> +
> +* :c:macro:`RISCV_HWPROBE_KEY_TIME_CSR_FREQ`: Frequency (in Hz) of `time=
 CSR`.
> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hw=
probe.h
> index 150a9877b0af..ef01c182af2b 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -8,7 +8,7 @@
>
>  #include <uapi/asm/hwprobe.h>
>
> -#define RISCV_HWPROBE_MAX_KEY 7
> +#define RISCV_HWPROBE_MAX_KEY 8
>
>  static inline bool riscv_hwprobe_key_is_valid(__s64 key)
>  {
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/u=
api/asm/hwprobe.h
> index 2fb8a8185e7a..5053a9b18710 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -74,6 +74,7 @@ struct riscv_hwprobe {
>  #define                RISCV_HWPROBE_MISALIGNED_MASK           (7 << 0)
>  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE    6
>  #define RISCV_HWPROBE_KEY_MISALIGNED_PERF      7
> +#define RISCV_HWPROBE_KEY_TIME_CSR_FREQ        8
>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>
>  /* Flags */
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwpr=
obe.c
> index e4ec9166339f..3d47edc04a3f 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -8,6 +8,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/cpufeature.h>
>  #include <asm/hwprobe.h>
> +#include <asm/delay.h>
>  #include <asm/sbi.h>
>  #include <asm/switch_to.h>
>  #include <asm/uaccess.h>
> @@ -227,6 +228,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *p=
air,
>                         pair->value =3D riscv_cboz_block_size;
>                 break;
>
> +       case RISCV_HWPROBE_KEY_TIME_CSR_FREQ:
> +               pair->value =3D riscv_timebase;
> +               break;
> +
>         /*
>          * For forward compatibility, unknown keys don't fail the whole
>          * call, but get their element key set to -1 and value set to 0
> --
> 2.20.1
>

