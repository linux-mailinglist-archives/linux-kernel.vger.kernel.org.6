Return-Path: <linux-kernel+bounces-224212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7F4911EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F79E1C21E61
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FD016D4DF;
	Fri, 21 Jun 2024 08:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HsjIqs+m"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0065316D31E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959059; cv=none; b=ss3Tj/1q2SK7mMgvwg1H6O2NKNmdocSb72f+oniUhMAEl3xWW2hEQ9KRCx/lk++maNIvyDA/JKEC2hfIl4GQh956oF1A+YfsWfzgMHf23XbdLWj0jmReemIO3VtQTWop0apu4if56unSOds+SCYZlEKD5d83rmx8SiA6zA44Z4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959059; c=relaxed/simple;
	bh=K6/aFPgwM2ZptDzlB6lOUplAjcs6raEQuwXaydVLIH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KoQ3JjbNfEUZ35bGge0q/njMbdMB8M+XtpmWO/+SJNKLJgWgkZ0XCqD3OD5idL6DRXqXs7WTWRkQfKZokKu58P/oKvFE8NutZDbOhKRqW24LM6NIC+YPpqT1461qRzx2tSzqNxMTbjJqxCTD5xY9WFcs83ZarIMs0obwDTqAMXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=HsjIqs+m; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e02b605bca2so2105773276.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 01:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718959057; x=1719563857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MeBUtcqt/2BjO2eEj4Hryw6kFgsdTYrxtT6OKrYMKKQ=;
        b=HsjIqs+mFskO3+BicVNJzXkK00wrAcS9qiEYSmoEjXDEsosRB8O9CQU26FG+n3fZRq
         v8c/7PS4fA5jZ8qRVyvI2Ko+nq35e5+MLk+mqDrXIISEs2IKk4HM3t8fH8XyFgFJFclP
         end8GDF35W4XaKM+7aIS71Mb1uVsQP5ZQunl+8M7zuQ+bUVDgv7ZXXq9R8qL7+3NleMt
         yPx55cLc35gow8rkUR1JoivAba+98WB9l5XMjZoZ607DW4Q4l1C1zH5jkzckGwqAGPe1
         wZhzDCTQwSqSv183c/8CEK7xLTG22wAsyJMO3XHnNu/wSrhh7Ymi6/+jtG8zcoegA03h
         XecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718959057; x=1719563857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MeBUtcqt/2BjO2eEj4Hryw6kFgsdTYrxtT6OKrYMKKQ=;
        b=VsjNlIBRJXypIlqm5n4+5TKHaQY5Mr02kqoolDwleNp4YxNGLTiJc1xneMYutGCPwc
         rz27/o/qunNOWsbwfaLdZ+iZ4LMFmJ61Q/UNYbcvDTWSx+8xlT0SVLQBInvo3xUsah/L
         UqnGAQqkOZu8UTsHan+EQ8kgL4qQzxh3RDZirA2GDHz91bmux2Q8TDfNi98ALiZEXPdq
         nhCgt9yytOBKUH7vA0MFlxp7CXD89arkooW/WNdJFeK6APrXorL6pVKQadYfDdnToXnK
         Ii46bQf8F0NeIkATNkBFYVA5B/CysPN8JCEVlhkBD+3go/RbLC4mYjHHV4AXf1ujSMSf
         MNaA==
X-Forwarded-Encrypted: i=1; AJvYcCUFll+46un7/8TUorUmMikrLSLbil6rFDOWSLAJzHsOm0Lbevujokoy0UNgWVpLjhXfTChecuI6IrQHhWtKi1nrdJ2xPut7taTB9epP
X-Gm-Message-State: AOJu0YxS9cNgIUGI3sWKGTwUlA5fLaydYvMMhBkGVhYSS/5dt033zXkr
	ApilWD335JF4zsT+3QQSADtShx1JnK+0hV9/QEaJ0w6w2rMU9bzgm8DKJ3WWTjMH32AVzNw5a8C
	mArwPF4U0n79PSTzovEypSL+aZKLCiTqly+VYLw==
X-Google-Smtp-Source: AGHT+IHbfNEc6qqwJeiNuCdtmi3V83oWdMD8frXgVx5sShOdjkd1FJw0gLRG3yObbQuJWUFyOOsAyvirTuCYb0DBNdc=
X-Received: by 2002:a25:b30f:0:b0:dff:1b2b:9b0 with SMTP id
 3f1490d57ef6-e02be172d96mr5898618276.2.1718959056904; Fri, 21 Jun 2024
 01:37:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240609-support_vendor_extensions-v2-0-9a43f1fdcbb9@rivosinc.com>
 <20240609-support_vendor_extensions-v2-3-9a43f1fdcbb9@rivosinc.com>
In-Reply-To: <20240609-support_vendor_extensions-v2-3-9a43f1fdcbb9@rivosinc.com>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Fri, 21 Jun 2024 16:37:26 +0800
Message-ID: <CABgGipUVEWhsftiE7wpi8oe8WRd0r8ozD=tts8=29Ka4RhjFVQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] riscv: Introduce vendor variants of extension helpers
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor.dooley@microchip.com>, 
	Evan Green <evan@rivosinc.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 12:34=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.=
com> wrote:
>
> Vendor extensions are maintained in per-vendor structs (separate from
> standard extensions which live in riscv_isa). Create vendor variants for
> the existing extension helpers to interface with the riscv_isa_vendor
> bitmaps.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Andy Chiu <andy.chiu@sifive.com>

> ---
>  arch/riscv/include/asm/vendor_extensions.h | 83 ++++++++++++++++++++++++=
++++++
>  drivers/perf/riscv_pmu_sbi.c               |  3 +-
>  2 files changed, 85 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/vendor_extensions.h b/arch/riscv/incl=
ude/asm/vendor_extensions.h
> index 5fca550fc1f6..04d72b02ae6b 100644
> --- a/arch/riscv/include/asm/vendor_extensions.h
> +++ b/arch/riscv/include/asm/vendor_extensions.h
> @@ -42,8 +42,91 @@ extern const size_t riscv_isa_vendor_ext_list_size;
>  #define VENDOR_EXT_ALL_CPUS                    -1
>
>  bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendo=
r, unsigned int bit);
> +#define riscv_cpu_isa_vendor_extension_available(cpu, vendor, ext)     \
> +       __riscv_isa_vendor_extension_available(cpu, vendor, RISCV_ISA_VEN=
DOR_EXT_##ext)
>  #define riscv_isa_vendor_extension_available(vendor, ext)      \
>         __riscv_isa_vendor_extension_available(VENDOR_EXT_ALL_CPUS, vendo=
r, \
>                                                RISCV_ISA_VENDOR_EXT_##ext=
)
>
> +static __always_inline bool __riscv_has_extension_likely(const unsigned =
long vendor,
> +                                                        const unsigned l=
ong ext)
> +{
> +       asm goto(ALTERNATIVE("j %l[l_no]", "nop", %[vendor], %[ext], 1)
> +       :
> +       : [vendor] "i" (vendor), [ext] "i" (ext)
> +       :
> +       : l_no);
> +
> +       return true;
> +l_no:
> +       return false;
> +}
> +
> +static __always_inline bool __riscv_has_extension_unlikely(const unsigne=
d long vendor,
> +                                                          const unsigned=
 long ext)
> +{
> +       asm goto(ALTERNATIVE("nop", "j  %l[l_yes]", %[vendor], %[ext], 1)
> +       :
> +       : [vendor] "i" (vendor), [ext] "i" (ext)
> +       :
> +       : l_yes);
> +
> +       return false;
> +l_yes:
> +       return true;
> +}
> +
> +static __always_inline bool riscv_has_vendor_extension_likely(const unsi=
gned long vendor,
> +                                                             const unsig=
ned long ext)
> +{
> +       if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
> +               return false;
> +
> +       if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
> +               return __riscv_has_extension_likely(vendor,
> +                                                   ext + RISCV_VENDOR_EX=
T_ALTERNATIVES_BASE);
> +
> +       return __riscv_isa_vendor_extension_available(VENDOR_EXT_ALL_CPUS=
, vendor, ext);
> +}
> +
> +static __always_inline bool riscv_has_vendor_extension_unlikely(const un=
signed long vendor,
> +                                                               const uns=
igned long ext)
> +{
> +       if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
> +               return false;
> +
> +       if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
> +               return __riscv_has_extension_unlikely(vendor,
> +                                                     ext + RISCV_VENDOR_=
EXT_ALTERNATIVES_BASE);
> +
> +       return __riscv_isa_vendor_extension_available(VENDOR_EXT_ALL_CPUS=
, vendor, ext);
> +}
> +
> +static __always_inline bool riscv_cpu_has_vendor_extension_likely(const =
unsigned long vendor,
> +                                                                 int cpu=
, const unsigned long ext)
> +{
> +       if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
> +               return false;
> +
> +       if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) &&
> +           __riscv_has_extension_likely(vendor, ext + RISCV_VENDOR_EXT_A=
LTERNATIVES_BASE))
> +               return true;
> +
> +       return __riscv_isa_vendor_extension_available(cpu, vendor, ext);
> +}
> +
> +static __always_inline bool riscv_cpu_has_vendor_extension_unlikely(cons=
t unsigned long vendor,
> +                                                                   int c=
pu,
> +                                                                   const=
 unsigned long ext)
> +{
> +       if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
> +               return false;
> +
> +       if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) &&
> +           __riscv_has_extension_unlikely(vendor, ext + RISCV_VENDOR_EXT=
_ALTERNATIVES_BASE))
> +               return true;
> +
> +       return __riscv_isa_vendor_extension_available(cpu, vendor, ext);
> +}
> +
>  #endif /* _ASM_VENDOR_EXTENSIONS_H */
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 02719e0c6368..e1f0edfb7dcc 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -1064,7 +1064,8 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu=
, struct platform_device *pde
>                    riscv_cached_mimpid(0) =3D=3D 0) {
>                 riscv_pmu_irq_num =3D THEAD_C9XX_RV_IRQ_PMU;
>                 riscv_pmu_use_irq =3D true;
> -       } else if (riscv_isa_vendor_extension_available(ANDES_VENDOR_ID, =
XANDESPMU) &&
> +       } else if (riscv_has_vendor_extension_unlikely(ANDES_VENDOR_ID,
> +                                                      RISCV_ISA_VENDOR_E=
XT_XANDESPMU) &&
>                    IS_ENABLED(CONFIG_ANDES_CUSTOM_PMU)) {
>                 riscv_pmu_irq_num =3D ANDES_SLI_CAUSE_BASE + ANDES_RV_IRQ=
_PMOVI;
>                 riscv_pmu_use_irq =3D true;
>
> --
> 2.44.0
>

