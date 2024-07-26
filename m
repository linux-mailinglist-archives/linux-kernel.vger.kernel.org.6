Return-Path: <linux-kernel+bounces-263812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DB393DACF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1C2F1F22CC9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A08F1514F8;
	Fri, 26 Jul 2024 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aoFGNQzV"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218AA143C6A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 22:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722034099; cv=none; b=WA1QW9iLcEMU9GOiH50KMg+vis+LYTHzeMYpM01x4t+9G0Ni1clYduJgFYMCcva6ztH81dPqLpjT9lEh8zP02PekVDbHHsk+Ydtgw1wxcvmzXKeczJftqU29ey0JQsl44rtqSP+5infDUVpHM9I7IGIS+35ej7NQExte7Q760OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722034099; c=relaxed/simple;
	bh=ik05G7iwnI78HfDCCFcvEPtupzj6vuYvWeqIXABJP8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mn5KW2lA0pWttwaviYDSoHT8iYrvvPnBC8vHBNuhNBu9FO6eSW1E7q7QZbHwH/D7e4/3BXWgNpVH489OBlfazi5a8KE64NafjVzRVqBMrUxJfEkguae/wBeq5es0Aa78MdA9BnHyNOAJJeo3XebhXLEnVuhfrqy24sRz9Mwp/08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aoFGNQzV; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a869e3e9dfso5609a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 15:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722034096; x=1722638896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IISxiKaE69HlxW9zSbdzn0yNE5018cgYeG2mOlmSYSI=;
        b=aoFGNQzVCIrUgsd6uW/36mpCGbdCGaHLaGCW2fhAUL1hBOIN9o/JDLazm7VLzbwTNt
         r2ME1jI1JANcAK3Nl7fBDQ/5hu6tePWZlAdxw8aITfKMA1dFpsKZurT0kaGAxAG+piQL
         50ci9GhwOtPE1USaF1WREznN7AzVY/m7KtCx3D+B/pRr9JgfmY7lnXePItO3DLFMp2I2
         +1yjmnx2ZEC3nId+fZ5tGHzKPCIVHcvUctE+85qMo8xdS5rD/qFO2LLspgGmbKdqxwDD
         7UXTt1/Q4NE4E8Vr1O9s0rAUGh2PKsw04QjFgIofADlVN7jFBXDQqF2S4XQaaCCZfA5B
         5K7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722034096; x=1722638896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IISxiKaE69HlxW9zSbdzn0yNE5018cgYeG2mOlmSYSI=;
        b=P0WBic+F2zrIi0E9Pi7sJfMNJz/kSY3PpYt/SrbjiEA0nbRQSkM8f7zTJaJ5ldZ/YK
         nq1iRD05LNqwef2G5xeKU4C7nkQxXnf5YA+3XizY5bhMBO7UixLVNdAYVzp7GgWYtI6O
         4V8GoAmEuJv9/nmCOWhI7Km4oNCEpV2Hk51zteSC7Ur7+lsK316JMDIp6vE0BCTE4xQb
         UGLGj2Vk6wB+Hfekh7DIdshGHCMpB5wXTC4g3Uj28XRJyuW0JxAjmTamDwE4T3q6xtrV
         N5rbWUBdrp/lUlng5E3hnS1i430WL0FfeOLbDdZJN+5c8fUZ5qMkoHVQkIcaKVGy/D2i
         gFrg==
X-Forwarded-Encrypted: i=1; AJvYcCXA7xpGt4/y75fcVHHvVK1vYSFwTrZOzmXT8wONLbv6EA8CDSyvgtZoNiePMrbehdclXdO3QgJEaWi9GKT4BHIOG58mhC1RIoMpuVZC
X-Gm-Message-State: AOJu0YwuJEoMW5GL26X36OgZ4MrzlBqiY8vh40kqZWz6orB/RNendV99
	RfvD6MC5ahERqDi47NnwoWt07w92H0Tppu4LfKxskP38ctIcvjvDJH4jhl2vuUXIV6ylwycRr4U
	GkjLo4sR7zj9CoSfgy8aNWrqX5EhGi2r6x4EC
X-Google-Smtp-Source: AGHT+IHDvwVw23uSTcDi4SzHL+t6WXgiACBRlhQpwZ+TMNL+bUR6puGV+HLKl3cR72B/zvuFm3wC9iotOGgbxu+qgRA=
X-Received: by 2002:a05:6402:2694:b0:5a1:4658:cb98 with SMTP id
 4fb4d7f45d1cf-5aed459c474mr321422a12.0.1722034096206; Fri, 26 Jul 2024
 15:48:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720043311.git.babu.moger@amd.com> <28866653751deb8405f575e40df6f08affdb25d6.1720043311.git.babu.moger@amd.com>
In-Reply-To: <28866653751deb8405f575e40df6f08affdb25d6.1720043311.git.babu.moger@amd.com>
From: Peter Newman <peternewman@google.com>
Date: Fri, 26 Jul 2024 15:48:05 -0700
Message-ID: <CALPaoChGp+JHeyxsqDvix=t=ik5eTqc3bf+ihUL=RXx5p9r5Cw@mail.gmail.com>
Subject: Re: [PATCH v5 09/20] x86/resctrl: Initialize monitor counters bitmap
To: Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com, 
	lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com, 
	leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com, 
	kirill.shutemov@linux.intel.com, jithu.joseph@intel.com, kai.huang@intel.com, 
	kan.liang@linux.intel.com, daniel.sneddon@linux.intel.com, 
	pbonzini@redhat.com, sandipan.das@amd.com, ilpo.jarvinen@linux.intel.com, 
	maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Babu,

On Wed, Jul 3, 2024 at 2:50=E2=80=AFPM Babu Moger <babu.moger@amd.com> wrot=
e:
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu=
/resctrl/rdtgroup.c
> index 4f47f52e01c2..b3d3fa048f15 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -185,6 +185,23 @@ bool closid_allocated(unsigned int closid)
>         return !test_bit(closid, &closid_free_map);
>  }
>
> +/*
> + * Counter bitmap and its length for tracking available counters.
> + * ABMC feature provides set of hardware counters for enabling events.
> + * Each event takes one hardware counter. Kernel needs to keep track
> + * of number of available counters.
> + */
> +static unsigned long mbm_cntrs_free_map;
> +static unsigned int mbm_cntrs_free_map_len;

If counter assignment is supported at a per-domain granularity, then
counter id allocation needs to be done per-domain rather than
globally. For example, if I free a counter from one group in a
particular domain, it should be available to allocate to another group
only in that domain.

When I attempt this using the current series, the resulting behavior
is quite interesting. I noticed Reinette also commented on this later
in the series, noticing that counters are only allocated permanently
to groups and never move as a result of writing to mbm_control.

# grep 'g1[45]' info/L3_MON/mbm_control
test/g14/0=3Dtl;1=3Dtl;2=3Dtl;3=3Dtl;4=3Dtl;5=3Dtl;6=3Dtl;7=3Dtl;8=3Dtl;9=
=3Dtl;10=3Dtl;11=3Dtl;12=3Dtl;13=3Dtl;14=3Dtl;15=3Dtl;16=3Dtl;17=3Dtl;18=3D=
tl;19=3Dtl;20=3Dtl;21=3Dtl;22=3Dtl;23=3Dtl;24=3Dtl;25=3Dtl;26=3Dtl;27=3Dtl;=
28=3Dtl;29=3Dtl;30=3Dtl;31=3Dtl;
test/g15/0=3D_;1=3D_;2=3D_;3=3D_;4=3D_;5=3D_;6=3D_;7=3D_;8=3D_;9=3D_;10=3D_=
;11=3D_;12=3D_;13=3D_;14=3D_;15=3D_;16=3D_;17=3D_;18=3D_;19=3D_;20=3D_;21=
=3D_;22=3D_;23=3D_;24=3D_;25=3D_;26=3D_;27=3D_;28=3D_;29=3D_;30=3D_;31=3D_;

[domains 2-31 omitted for clarity below]

# echo 'test/g14/1-t' > info/L3_MON/mbm_control
# grep 'g1[45]' info/L3_MON/mbm_control
test/g14/0=3Dtl;1=3Dl;
test/g15/0=3D_;1=3D_;

# echo "test/g15/1+t" > info/L3_MON/mbm_control
# grep 'g1[45]' info/L3_MON/mbm_control
test/g14/0=3Dtl;1=3D_;
test/g15/0=3D_;1=3D_;


-Peter

