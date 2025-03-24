Return-Path: <linux-kernel+bounces-574248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA391A6E290
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C9B188EF9A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FED9264F8B;
	Mon, 24 Mar 2025 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVWcJ/DA"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E6D2627E9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742841657; cv=none; b=gguU4TGbrxxiKuLRkZVNESlaNerZTPuNYEZ0IyaMIYEmZowCPO80GC3ZMlnjMZ1h3i0pAbo39oiIvS6WrXZVUBOCviSBKKn+vOkzcEmghNm+IgkW499k4pWK00mgxizsgNbhWhEQ28ZvQ2UVcMzVN2FCMOJGFq1Fm7VhFUqIDCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742841657; c=relaxed/simple;
	bh=f4DdomVr0nagMtgc+/I4m7RjU+SfBMD1Z8bRaM4ug24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sllmBCY622n/s3UcCgBYgXd+Z4wyZpncNC6gbkQcWNzEhbVPWo/RrxKFW4THW6sq4oDGVrjbBi3cIpMvgdgtU94adtcW+qLYBfmuxBKI1+HSEP9yzCZCXmEmG9ifTEO+bZyJqAcXFIPUpwJO/ni0SWE1dghltslJroSB1o+ojrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FVWcJ/DA; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47666573242so82161cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742841655; x=1743446455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVFFcWh5dZoKRR9sK5sDoRV9h4cdUzLL2+BzZ81kSD4=;
        b=FVWcJ/DAyPeQjruz6D0IltEw1GE2o5uBRFsoT1jO48Qw4gOTOLTyG6rbPCL/7ZoK7W
         zIs5woQMJhmqkx7tWt+t3+tlwxgDvnievXBp2csINaHtd7S0yhsFAJqu64AIoxl4xSuu
         d0GPi4R2LjoUW7GwtdnK7r5b/+5e/FRTraE5VU5iLHrvOsq1+ARUKHGZradRVsUEz9u9
         W2kFWIfTeplAb8TEOUrIgHrSJnRs09QMNX/xSNritvK40SfhcjwIdD1QetKu+QdJZ07d
         fwAB4driL99492Fv++wB6axZSRH2SMseCinuu8SSSSKL2G5Vr7dVWztsKmpeZXiSa0WW
         Ystg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742841655; x=1743446455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVFFcWh5dZoKRR9sK5sDoRV9h4cdUzLL2+BzZ81kSD4=;
        b=s7pYamUUoITzCGOZYvqJwCXjW5cP4FXVOMiMuwGjdtjXA2rnmQ1r6oRR2Zhh90sRPX
         gzpQXo5tPAKvXBr/IJQ3X9mRlK/owyMRFIBmmkJ3dR4eDL7qhJMowCtBanJO2kmeWGze
         /4zDZmO9sKYxRJSFnrPlGF+jj2SQVjFDiLfWY2SOVrwtRakcKrogCRsQwDi2MmlEsJ+p
         2E8dvtWHJURDxJgNk9pVhF3SMMsf4wx0PEynKY1njUPSsKVA1PdGwr2Xw4gGIh6gCmW/
         Qk0+RNI9LQFaqOZi0sPcBAEw2KclWrA1hbBtq+XHMGqTmNrpaM9HFqTHGom4MJRWwuHD
         izOA==
X-Gm-Message-State: AOJu0Yz0EHDSVkkHMsAFflI4HoekI7HaJsxTkdDMCtPmgCcjoaQ7Ovpe
	yYJluX1c4EZ/dMd1dKkjd6hFRsbh61EcJ+kW4FnK9qdJHUneMJvj2H/36XBP2s/7OJ47Qa6+3Io
	v2twk+AfqVeSYyhbEK8idqsfDxpB5frjlbEp4
X-Gm-Gg: ASbGnctPX2Bz04cGC+W4Kr8klu1axmDzpy9cXphT5WOaNyJ7otxF/rxvEBvo5DLbr7g
	S6gCdse2kPUud7GJVEv3nJuGpdzz6HL3kyNN9R5b+r8mYXDPHXHd9LOvlwHGqz3jZ/d9HGZIl5D
	sQv3FbkwQ/UgoHYl5LcOVshOQ=
X-Google-Smtp-Source: AGHT+IE5+gZ94fZfEMa4/mu+5y69Keqgf6GYglfVDQZk9TGfgwTjD/V2nGDREwNflvI0c0qaa+IqDh+lZikxQgFL/jU=
X-Received: by 2002:a05:622a:17c4:b0:475:1410:2ca3 with SMTP id
 d75a77b69052e-4772be23f26mr9607281cf.15.1742841654660; Mon, 24 Mar 2025
 11:40:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com> <20250320015551.2157511-8-changyuanl@google.com>
In-Reply-To: <20250320015551.2157511-8-changyuanl@google.com>
From: Frank van der Linden <fvdl@google.com>
Date: Mon, 24 Mar 2025 11:40:43 -0700
X-Gm-Features: AQ5f1JqgK3t9nzg4mdWiXWpH_sA43D2BNXiBuTZpvx6PAjAQCpPGjdYAtW64c_s
Message-ID: <CAPTztWbFXajArSN8yKu32eSoR=xsk1CHM_4V7MJ0eQxydFqPUQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/16] kexec: add Kexec HandOver (KHO) generation helpers
To: Changyuan Lyu <changyuanl@google.com>
Cc: linux-kernel@vger.kernel.org, graf@amazon.com, akpm@linux-foundation.org, 
	luto@kernel.org, anthony.yznaga@oracle.com, arnd@arndb.de, 
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, dave.hansen@linux.intel.com, dwmw2@infradead.org, 
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, 
	krzk@kernel.org, rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org, tglx@linutronix.de, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, will@kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 6:56=E2=80=AFPM Changyuan Lyu <changyuanl@google.co=
m> wrote:
>
> From: Alexander Graf <graf@amazon.com>
>
> Add the core infrastructure to generate Kexec HandOver metadata. Kexec
> HandOver is a mechanism that allows Linux to preserve state - arbitrary
> properties as well as memory locations - across kexec.
>
> It does so using 2 concepts:
>
>   1) State Tree - Every KHO kexec carries a state tree that describes the
>      state of the system. The state tree is represented as hash-tables.
>      Device drivers can add/remove their data into/from the state tree at
>      system runtime. On kexec, the tree is converted to FDT (flattened
>      device tree).
>
>   2) Scratch Regions - CMA regions that we allocate in the first kernel.
>      CMA gives us the guarantee that no handover pages land in those
>      regions, because handover pages must be at a static physical memory
>      location. We use these regions as the place to load future kexec
>      images so that they won't collide with any handover data.
>
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Co-developed-by: Pratyush Yadav <ptyadav@amazon.de>
> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Co-developed-by: Changyuan Lyu <changyuanl@google.com>
> Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> ---
>  MAINTAINERS                    |   2 +-
>  include/linux/kexec_handover.h | 109 +++++
>  kernel/Makefile                |   1 +
>  kernel/kexec_handover.c        | 865 +++++++++++++++++++++++++++++++++
>  mm/mm_init.c                   |   8 +
>  5 files changed, 984 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/kexec_handover.h
>  create mode 100644 kernel/kexec_handover.c
[...]
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 04441c258b05..757659b7a26b 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -30,6 +30,7 @@
>  #include <linux/crash_dump.h>
>  #include <linux/execmem.h>
>  #include <linux/vmstat.h>
> +#include <linux/kexec_handover.h>
>  #include "internal.h"
>  #include "slab.h"
>  #include "shuffle.h"
> @@ -2661,6 +2662,13 @@ void __init mm_core_init(void)
>         report_meminit();
>         kmsan_init_shadow();
>         stack_depot_early_init();
> +
> +       /*
> +        * KHO memory setup must happen while memblock is still active, b=
ut
> +        * as close as possible to buddy initialization
> +        */
> +       kho_memory_init();
> +
>         mem_init();
>         kmem_cache_init();
>         /*


Thanks for the work on this.

Obviously it needs to happen while memblock is still active - but why
as close as possible to buddy initialization?

Ordering is always a sticky issue when it comes to doing things during
boot, of course. In this case, I can see scenarios where code that
runs a little earlier may want to use some preserved memory. The
current requirement in the patch set seems to be "after sparse/page
init", but I'm not sure why it needs to be as close as possibly to
buddy init.

- Frank

