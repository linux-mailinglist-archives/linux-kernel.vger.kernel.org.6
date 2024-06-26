Return-Path: <linux-kernel+bounces-229891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D719175AC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 03:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EEA5284571
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 01:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09AF101CE;
	Wed, 26 Jun 2024 01:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eXTMgAih"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A56B65A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 01:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719365706; cv=none; b=lRPfJaZjfpEdHLbsI/AUXdKtvwTfbIlI6Be7TUtsK5Ca2OkZSvFa9PSkAiWkS/63uf7UxzU+mjgO5mvPz70Y80orsPaVZz/EY8C/Hl7xX1ATbCzQ7PYZUQMnCNCLcSjzyw57x9OTCeoUdljXpPrcMdzQX8gqXKseLSLWaBlYiF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719365706; c=relaxed/simple;
	bh=p2hdLL0kbSBpNMx92k38MTNyUioVGeQLSXkXLfeSH9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4H1F8fMxGZ50p0IhXO0Nxw5URZKeP2F9Cfn8U5LPzueuIOQ3/Fqt7YpOw0cavzGGPKXW3Ah5SFUnJmHP7pebNmXdX+ubBsg5jcFn8QeGQsjdFdeiA9a+/gzn3TNmIR3vI640ly77smV10D1boHV+Vw77iTrY2gC1pW3q0wdGHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eXTMgAih; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-375bb80e5b8so35955ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719365704; x=1719970504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLVUFx89C6AkQ+z4I8gY1H4LZK9i2k9MI6MIVL9xohI=;
        b=eXTMgAihCT3NJporgmdklRQzDrTy/v8lxcNzh1wMAVWs98k/dTz4HHAgCs5yrNPws5
         bjwP4MstQvxv91W8OOTL4kKPoZqMAur2Qlnw1k0VETS0lNKA/Fxc1CNGWCb7gImq5aCp
         DD9yrUeoAxmSeG0Xkd9tVY/pL7hs+c/pOPxZ/eQWl0H1RJ6UWxrNPDO3Q9whs587WiAl
         vpRV/SV6aPSVaWXMED6Oyy4z87oW9Uc3/IS/f3YXANk3CSF6lml4abk8DaMOpqgtnuuT
         9Q1DuWtSbaN9BiL3TuwzWM+nxOpKWvvtxs/lctW0SoZI9Db2gEhuBJ+5HmzPLmP7PXgl
         JcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719365704; x=1719970504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLVUFx89C6AkQ+z4I8gY1H4LZK9i2k9MI6MIVL9xohI=;
        b=DpU1GezMkgzzcR6HFzW4SiOo7ERrX9UznRWYsAakBAPE9q4VU/c5TEZz/5ErePuh1q
         +Sycx87ugRfhylhgH4cS0J1qfQSZN1uPbFOK57v80XK7H3a303sS5nVPI1DqHafmnM/a
         H8roPogTXDaKVRvcKK9gcSkwLxhdlVBZk6+gWfoqQvliXSkSD2EB9fnEjpFFpcJS3YEv
         fSDxbDfcT/9nFU1sa0OHZZked4VW53f2UiJo+/CadGf1ICmPHDWbLuRxtHBdsanT9TEx
         4rB0ZbC7li+cpgHZcsRT4JUDgzaSCHCKpTHTLsLnuL+TVv3pVq5kI/mAkIgC1i0hwhud
         oddQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW6ydsfJ8c69wHdhBOwNOAvh8WU2CbbtMruV7Mw4txVTEOn7VuCpjB/JsJDjr7NHb+ygrBJdzrUjbtGW3KI3HS/NRCvPd7BOY8NIyf
X-Gm-Message-State: AOJu0YwvDuJOBE6QO3P4Ky4rL7UbWJ3EbEmmPnTl47sQcgiBcqcmbK6/
	vbr/6Gwczdzhi7mOWp2labszM/81CG/r7U8Y1H7Atglna6Ya7gMeriVnCw59YkT84Aac1ph0vFD
	XpywOmIqTS+vK8naE0yc4DZQ6gIxCG6XQtNJm
X-Google-Smtp-Source: AGHT+IFo0fgkkzOhQeTM17z3YRQKGZGwN4hsVdO0xQMJQUInhtJqMfvfEiTMgv2kF2rjGzeSNitZxLyE90sYcKA4+gs=
X-Received: by 2002:a92:612:0:b0:376:3ad9:22c1 with SMTP id
 e9e14a558f8ab-377ef339880mr1608545ab.20.1719365704169; Tue, 25 Jun 2024
 18:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625182256.291914-1-kan.liang@linux.intel.com> <20240625182256.291914-8-kan.liang@linux.intel.com>
In-Reply-To: <20240625182256.291914-8-kan.liang@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 25 Jun 2024 18:34:50 -0700
Message-ID: <CAP-5=fU4Mn0BhgS3n_aUmfamtD77d-VDhnZ1OoiRvXFrGJERCQ@mail.gmail.com>
Subject: Re: [PATCH V2 07/13] perf/x86/intel: Support PERFEVTSEL extension
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@kernel.org, acme@kernel.org, 
	namhyung@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, 
	ak@linux.intel.com, eranian@google.com, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 11:22=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Two new fields (the unit mask2, and the equal flag) are added in the
> IA32_PERFEVTSELx MSRs. They can be enumerated by the CPUID.23H.0.EBX.
>
> Update the config_mask in x86_pmu and x86_hybrid_pmu for the true layout
> of the PERFEVTSEL.
> Expose the new formats into sysfs if they are available. The umask
> extension reuses the same format attr name "umask" as the previous
> umask. Add umask2_show to determine/display the correct format
> for the current machine.
>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c      | 69 +++++++++++++++++++++++++++++--
>  arch/x86/include/asm/perf_event.h |  4 ++
>  2 files changed, 69 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 23e074fd25e1..9d50e1049e30 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4632,8 +4632,55 @@ PMU_FORMAT_ATTR(pc,      "config:19"     );
>  PMU_FORMAT_ATTR(any,   "config:21"     ); /* v3 + */
>  PMU_FORMAT_ATTR(inv,   "config:23"     );
>  PMU_FORMAT_ATTR(cmask, "config:24-31"  );
> -PMU_FORMAT_ATTR(in_tx,  "config:32");
> -PMU_FORMAT_ATTR(in_tx_cp, "config:33");
> +PMU_FORMAT_ATTR(in_tx,  "config:32"    );
> +PMU_FORMAT_ATTR(in_tx_cp, "config:33"  );

nit: It seems unfortunate these 2 lines change for the sake of spaces
before the ')'. Perhaps leave unchanged.

Thanks,
Ian

> +PMU_FORMAT_ATTR(eq,    "config:36"     ); /* v6 + */
> +
> +static ssize_t umask2_show(struct device *dev,
> +                          struct device_attribute *attr,
> +                          char *page)
> +{
> +       u64 mask =3D hybrid(dev_get_drvdata(dev), config_mask) & ARCH_PER=
FMON_EVENTSEL_UMASK2;
> +
> +       if (mask =3D=3D ARCH_PERFMON_EVENTSEL_UMASK2)
> +               return sprintf(page, "config:8-15,40-47\n");
> +
> +       /* Roll back to the old format if umask2 is not supported. */
> +       return sprintf(page, "config:8-15\n");
> +}
> +
> +static struct device_attribute format_attr_umask2  =3D
> +               __ATTR(umask, 0444, umask2_show, NULL);
> +
> +static struct attribute *format_evtsel_ext_attrs[] =3D {
> +       &format_attr_umask2.attr,
> +       &format_attr_eq.attr,
> +       NULL
> +};
> +
> +static umode_t
> +evtsel_ext_is_visible(struct kobject *kobj, struct attribute *attr, int =
i)
> +{
> +       struct device *dev =3D kobj_to_dev(kobj);
> +       u64 mask;
> +
> +       /*
> +        * The umask and umask2 have different formats but share the
> +        * same attr name. In update mode, the previous value of the
> +        * umask is unconditionally removed before is_visible. If
> +        * umask2 format is not enumerated, it's impossible to roll
> +        * back to the old format.
> +        * Does the check in umask2_show rather than is_visible.
> +        */
> +       if (i =3D=3D 0)
> +               return attr->mode;
> +
> +       mask =3D hybrid(dev_get_drvdata(dev), config_mask);
> +       if (i =3D=3D 1)
> +               return (mask & ARCH_PERFMON_EVENTSEL_EQ) ? attr->mode : 0=
;
> +
> +       return 0;
> +}
>
>  static struct attribute *intel_arch_formats_attr[] =3D {
>         &format_attr_event.attr,
> @@ -4786,8 +4833,14 @@ static inline bool intel_pmu_broken_perf_cap(void)
>
>  static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
>  {
> -       unsigned int sub_bitmaps =3D cpuid_eax(ARCH_PERFMON_EXT_LEAF);
> -       unsigned int eax, ebx, ecx, edx;
> +       unsigned int sub_bitmaps, eax, ebx, ecx, edx;
> +
> +       cpuid(ARCH_PERFMON_EXT_LEAF, &sub_bitmaps, &ebx, &ecx, &edx);
> +
> +       if (ebx & ARCH_PERFMON_EXT_UMASK2)
> +               pmu->config_mask |=3D ARCH_PERFMON_EVENTSEL_UMASK2;
> +       if (ebx & ARCH_PERFMON_EXT_EQ)
> +               pmu->config_mask |=3D ARCH_PERFMON_EVENTSEL_EQ;
>
>         if (sub_bitmaps & ARCH_PERFMON_NUM_COUNTER_LEAF_BIT) {
>                 cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNT=
ER_LEAF,
> @@ -5810,6 +5863,12 @@ static struct attribute_group group_format_extra_s=
kl =3D {
>         .is_visible =3D exra_is_visible,
>  };
>
> +static struct attribute_group group_format_evtsel_ext =3D {
> +       .name       =3D "format",
> +       .attrs      =3D format_evtsel_ext_attrs,
> +       .is_visible =3D evtsel_ext_is_visible,
> +};
> +
>  static struct attribute_group group_default =3D {
>         .attrs      =3D intel_pmu_attrs,
>         .is_visible =3D default_is_visible,
> @@ -5823,6 +5882,7 @@ static const struct attribute_group *attr_update[] =
=3D {
>         &group_caps_lbr,
>         &group_format_extra,
>         &group_format_extra_skl,
> +       &group_format_evtsel_ext,
>         &group_default,
>         NULL,
>  };
> @@ -6042,6 +6102,7 @@ static const struct attribute_group *hybrid_attr_up=
date[] =3D {
>         &group_caps_gen,
>         &group_caps_lbr,
>         &hybrid_group_format_extra,
> +       &group_format_evtsel_ext,
>         &group_default,
>         &hybrid_group_cpus,
>         NULL,
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/per=
f_event.h
> index 400c909b8658..91b73571412f 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -32,6 +32,8 @@
>  #define ARCH_PERFMON_EVENTSEL_INV                      (1ULL << 23)
>  #define ARCH_PERFMON_EVENTSEL_CMASK                    0xFF000000ULL
>  #define ARCH_PERFMON_EVENTSEL_BR_CNTR                  (1ULL << 35)
> +#define ARCH_PERFMON_EVENTSEL_EQ                       (1ULL << 36)
> +#define ARCH_PERFMON_EVENTSEL_UMASK2                   (0xFFULL << 40)
>
>  #define INTEL_FIXED_BITS_MASK                          0xFULL
>  #define INTEL_FIXED_BITS_STRIDE                        4
> @@ -185,6 +187,8 @@ union cpuid10_edx {
>   * detection/enumeration details:
>   */
>  #define ARCH_PERFMON_EXT_LEAF                  0x00000023
> +#define ARCH_PERFMON_EXT_UMASK2                        0x1
> +#define ARCH_PERFMON_EXT_EQ                    0x2
>  #define ARCH_PERFMON_NUM_COUNTER_LEAF_BIT      0x1
>  #define ARCH_PERFMON_NUM_COUNTER_LEAF          0x1
>
> --
> 2.35.1
>

