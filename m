Return-Path: <linux-kernel+bounces-303641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C069961294
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51CAC1F243E1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCF41CF28C;
	Tue, 27 Aug 2024 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zCEpO5Cv"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3105A1CEAAF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772626; cv=none; b=t6wAHboIBn5VSNuIjnDjkFWXPSkeiZ/64BYzD+TRi/YdNl73SVls0NhFMyGf8VSYB6wE4bZYH8uYjCduZZlOouwMK4aZDYwQIrnvhXbINK1WKOqj8JSTbpTD6uzCYoF/Vc163FCzQvkz+hNFFZ5NH9+NQQYjll5FrOaYR3Zo34I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772626; c=relaxed/simple;
	bh=RrvifVylM460xSV6ryQ4sWHiMF2Na1CL/DEMc3KrLmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OqLjW8jsjuHxymyBr+l0c7JOisDVdKAoPqprWstQ/X1ZAH+53nLoE7S+irfZ+IKtKrjHTwlzHrOn7K4eEpIFsQJKMInmVye5XtgE8iM8PwyxrvT15ojIfXFwwdym6zqOwj/uaiybZavHsLzWWMpMIyWHMxKaTbuDS9NiPLRB4/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zCEpO5Cv; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20260346ca1so239265ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724772622; x=1725377422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52lDzClgWIfDwjLe7orO5wLRybHMcHJGueg5E+ukdi8=;
        b=zCEpO5CvFRqPFXdkZuHLCngkjbOAfVLpxbNUqmL8W9uYwLUipqTjVVN2JFozjOhhyB
         pnYS6hVOD1vawdgk/v00y4Rv+R4H8z1IOr/Je/PEwUWcDp3emTHJ+XNB+ezBS6LR+nA4
         oMaD626XSzLuyZRVNiiTJ/t/2lRZ8otzkowhSfXlt6CV7bkfe26gRxxPEuiPQwdXM2xD
         kQVrUI58S91P1xiSVRWTKiCVe7f14DBbs1WZqiv+trqmnpW+Q556Wytwjcg76lfSMB8+
         yNHdJs7693I1XoBcvNJ98zr3qPnRfU15Kvgu5tUaBEkkE2DPIPoD+uor9HOLSFo9RLxY
         ERNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724772622; x=1725377422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52lDzClgWIfDwjLe7orO5wLRybHMcHJGueg5E+ukdi8=;
        b=XUwJrkA1dgV7OLEiQ4yc4umIY6j/8pDAfTrWY5i8wngnv1rCrCc//ca+rusKlTVnPK
         DKLo7Gad9+IPwYwtb1P91EUW6PJUxBsNtQ80LZZs+tlvjyic/nT+xzpORf/DvR/oorZY
         64u8WMlB4oNudf6af+7WvuJ2WEvG+CKKhW95VtDMYfcmR2W93xEPKFwtvbBBaw/HMhoF
         1iuRIdHXzoHvn+C8l7DwUcatYQTwzOxzDZMKbZla2rxbK9oBHRu1QIGqgnRV1EaRKfW4
         SeLYbeXPYBMDNTqq6V5YW45odEeFxw8DAAg68Ro5Duc7TIiPbpyMQsiyPaQvAR7CsEjy
         5sgw==
X-Forwarded-Encrypted: i=1; AJvYcCVLHfkRaV6jwWUHp3u9vPrkk7flQOld2LSKUqU9PPmFxFxNfdGBS5HRZRlC38wr1PcB8x0HVuPV5NzeCOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxqYXvtzbRyt2SCvNrBEhp7JfZZZy4F7HRS7oixz+k5hghkz1q
	0HxYLYh3ELZjiQdBFUaU29scgXMxWyqWHqeyfz8eeN9Y8FrGTitzLG7J0YTgvmjwiNOH+KXb1Q4
	2QMUnye9cVC4Ls2TiQg8qeFKrQZOQOGee4Er7TUs1+hPArrPaOnu5
X-Google-Smtp-Source: AGHT+IGaDewL8Pg/Wjw0RU5NHRtlyKO6nhTpAU3Lg4rCcydL7fHaObnOyrHHsW4jK9kJ8V5hhAMz5j4P9PyZyYtN7Hc=
X-Received: by 2002:a17:903:247:b0:201:e2db:7be3 with SMTP id
 d9443c01a7336-204e50afb13mr2895225ad.21.1724772621940; Tue, 27 Aug 2024
 08:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827053206.538814-1-kjain@linux.ibm.com>
In-Reply-To: <20240827053206.538814-1-kjain@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 Aug 2024 08:30:09 -0700
Message-ID: <CAP-5=fWBjt3pypEwEsbKsuNTqX+ZA7v9WbNJCUgc09xxF=pt1A@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf vendor events power10: Update JSON/events
To: Kajol Jain <kjain@linux.ibm.com>
Cc: acme@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, hbathini@linux.ibm.com, 
	disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 10:33=E2=80=AFPM Kajol Jain <kjain@linux.ibm.com> w=
rote:
>
> Update JSON/events for power10 platform with additional events.
>
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>

For the series:
Reviewed-by: Ian Rogers <irogers@google.com>

Just to note, the moving of events in patches 2 and 3 is necessary as
the filename sets the "topic" in perf list. I'm not sure the whole
"topic" thing makes total sense and we may want to revisit it at some
date. For example, AMD generally put the topic into the event name,
the PMU gives a strong hint of "topic", etc.

Thanks,
Ian

> ---
>  .../arch/powerpc/power10/datasource.json      | 25 +++++++++++++++++++
>  .../arch/powerpc/power10/frontend.json        | 10 ++++++++
>  .../pmu-events/arch/powerpc/power10/pmc.json  |  5 ++++
>  3 files changed, 40 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/powerpc/power10/datasource.json b=
/tools/perf/pmu-events/arch/powerpc/power10/datasource.json
> index 0eeaaf1a95b8..283284745d9c 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power10/datasource.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power10/datasource.json
> @@ -14,6 +14,31 @@
>      "EventName": "PM_DATA_FROM_MEMORY",
>      "BriefDescription": "The processor's data cache was reloaded from lo=
cal, remote, or distant memory due to a demand miss."
>    },
> +  {
> +    "EventCode": "0x0000004080",
> +    "EventName": "PM_INST_FROM_L1",
> +    "BriefDescription": "An instruction fetch hit in the L1. Each fetch =
group contains 8 instructions. The same line can hit 4 times if 32 sequenti=
al instructions are fetched."
> +  },
> +  {
> +    "EventCode": "0x000000026080",
> +    "EventName": "PM_L2_LD_MISS",
> +    "BriefDescription": "All successful D-Side Load dispatches for this =
thread that missed in the L2. Since the event happens in a 2:1 clock domain=
 and is time-sliced across all 4 threads, the event count should be multipl=
ied by 2."
> +  },
> +  {
> +    "EventCode": "0x000000026880",
> +    "EventName": "PM_L2_ST_MISS",
> +    "BriefDescription": "All successful D-Side Store dispatches for this=
 thread that missed in the L2. Since the event happens in a 2:1 clock domai=
n and is time-sliced across all 4 threads, the event count should be multip=
lied by 2."
> +  },
> +  {
> +    "EventCode": "0x010000046880",
> +    "EventName": "PM_L2_ST_HIT",
> +    "BriefDescription": "All successful D-side store dispatches for this=
 thread that were L2 hits. Since the event happens in a 2:1 clock domain an=
d is time-sliced across all 4 threads, the event count should be multiplied=
 by 2."
> +  },
> +  {
> +    "EventCode": "0x000000036880",
> +    "EventName": "PM_L2_INST_MISS",
> +    "BriefDescription": "All successful instruction (demand and prefetch=
) dispatches for this thread that missed in the L2. Since the event happens=
 in a 2:1 clock domain and is time-sliced across all 4 threads, the event c=
ount should be multiplied by 2."
> +  },
>    {
>      "EventCode": "0x000300000000C040",
>      "EventName": "PM_INST_FROM_L2",
> diff --git a/tools/perf/pmu-events/arch/powerpc/power10/frontend.json b/t=
ools/perf/pmu-events/arch/powerpc/power10/frontend.json
> index 53660c279286..456971f60814 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
> @@ -93,5 +93,15 @@
>      "EventCode": "0x400FC",
>      "EventName": "PM_ITLB_MISS",
>      "BriefDescription": "Instruction TLB reload (after a miss), all page=
 sizes. Includes only demand misses."
> +  },
> +  {
> +    "EventCode": "0x00000040B8",
> +    "EventName": "PM_PRED_BR_TKN_COND_DIR",
> +    "BriefDescription": "A conditional branch finished with correctly pr=
edicted direction. Resolved taken."
> +  },
> +  {
> +    "EventCode": "0x00000048B8",
> +    "EventName": "PM_PRED_BR_NTKN_COND_DIR",
> +    "BriefDescription": "A conditional branch finished with correctly pr=
edicted direction. Resolved not taken."
>    }
>  ]
> diff --git a/tools/perf/pmu-events/arch/powerpc/power10/pmc.json b/tools/=
perf/pmu-events/arch/powerpc/power10/pmc.json
> index 0e0253d0e757..04732698d9b2 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power10/pmc.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power10/pmc.json
> @@ -104,6 +104,11 @@
>      "EventName": "PM_RUN_CYC",
>      "BriefDescription": "Processor cycles gated by the run latch."
>    },
> +  {
> +    "EventCode": "0x200F8",
> +    "EventName": "PM_EXT_INT",
> +    "BriefDescription": "Cycles an external interrupt was active."
> +  },
>    {
>      "EventCode": "0x30010",
>      "EventName": "PM_PMC2_OVERFLOW",
> --
> 2.43.5
>

