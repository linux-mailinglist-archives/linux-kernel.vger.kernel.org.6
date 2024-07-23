Return-Path: <linux-kernel+bounces-260172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2933D93A419
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D799A281C3B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEAC156F53;
	Tue, 23 Jul 2024 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z5OxGIJi"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E26156C74
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721750557; cv=none; b=lTAHfDwNmzc0AfNaSG3DxR4pYuHtIvjQ1pHY+kxIGyY8W1fw1ps9B8hfr36HuQZIP+5cKNrKM+UeJNMjKjEjB5+fbPngJwixx4T/PkJ6Hl1B+1OiirLByYkhcvbbIrQocsw4rcsg36n/AB6OOrP590dN+NE+dJ35FutlU/4UPFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721750557; c=relaxed/simple;
	bh=bdglEaLEwE7qr9Hw+lNCxt5a/Vak5/ey5i95Hg06JZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CauCAl7gLQYLV4NHvk0FkWeUJ70u3H3x2Ctys3M0khbIkSni8WcqSDNjidXStoMjwJ4L2Zl5jWIN7Xi+0bjeoQ1TiTXTnlh5hAJdsMpdfFyRkBx4bpL2dOPatYEKecCjJLPtNslZEui8DYpHHFbdzRhEDIeF/6CzFaZB6gjOmY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z5OxGIJi; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fd7509397bso209805ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 09:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721750555; x=1722355355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MaDuSwLVClsstDweDtfH5dIJYrmnq1xTWK+6H4ZsGw=;
        b=Z5OxGIJid4ND0FovDiJ2ier8IY+oPD+S2Tx285IIcDs1s50AKbSKKvoiogYYdi4ig3
         CvFIT7m12MWECOSvOgmIRscBvWu+0yy46ATRnu64i23m4kwS74A7noFXUZKG6Vhsp2EI
         pc1AD1eDvS3aik7d+XArj/MTa36Ia+D2h/j1qRgjo4ZocziGxA7VwzKSC+JjlbCLth1D
         BDInlmPab9Rvc3q1CtaA2n6hxgLMP3GShn0lrDvzabN8up/MaB3X+JKkGZFjye2FIPHA
         caKd4n9CHO2x3KD4C1S5OL7VcnIhCl8mcS84/KXdtdKp7h1pXk7rMMRVbyYnmg92gvt0
         lmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721750555; x=1722355355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MaDuSwLVClsstDweDtfH5dIJYrmnq1xTWK+6H4ZsGw=;
        b=DFv3WgJZf2gtjyLu+Rd3n2/+DKnpLEp+SB8zasrrXCw38uZf0Xn3i3PzPumvhGwfD2
         f0xCLC9UnX7QMWxBGK5PmTXbiW+K+3qJgmtpYaB44aj/4BAjhE9bkwRfampr3IwjEEVN
         9aCEv3IpHeg9UxAqPG8GdcUyqCKU+dZiKSqm1rYruO4RwYNHlu0whzqZHE3wky7Drzyq
         aZzMA4J/BNMkcBsEc3WibwAoVOL1JonY15+cXj3eVLUGS8adiXEMHiLhRZAyMvdk9Ke7
         GGSo0NhPtEVvEZi9kxmbKFG6HfsmaiS3skGbq6ZHhwLQ9umV7oofx7mmHaBK5iHtTMXw
         fnxw==
X-Forwarded-Encrypted: i=1; AJvYcCUGcvThhgr3aPQuTE3yHXJ7QylMfRn8jWDNRcZOb8k9Kz8r3jsZYF4hzdRwU8Nw6/3l9oSJeu1E0TQzwgJXxqo/D6NQQrL7MO7hVQLl
X-Gm-Message-State: AOJu0Yyx9gusKRC7iWAUnF0ZX/U63TWSRtLbi1CikbAck6tKQiwmr4hg
	bSM/MMt4eJI8V4/S4Vf3dK+kPewc+9JkpRsFa3VGTu8tM7/PcLoDwjU2yHTTlMuuUOKGYkgcwHF
	75Q+5HgnK/15i64W+GMCXNbdn8bXLD41s7A6I
X-Google-Smtp-Source: AGHT+IGf7KJM/k06ZSJN/y8P+9fHve4GXpgNKiEQVF7y6nM8XKFbSIx0KCAKVzg9lXA7fDrRhxM6IYM6AJM7xc8QAUo=
X-Received: by 2002:a17:902:da8c:b0:1fc:72f5:43c0 with SMTP id
 d9443c01a7336-1fd7a2087b6mr8320585ad.24.1721750554676; Tue, 23 Jul 2024
 09:02:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723052154.96202-1-kjain@linux.ibm.com>
In-Reply-To: <20240723052154.96202-1-kjain@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Jul 2024 09:02:23 -0700
Message-ID: <CAP-5=fWsQbA-h=_Y_q7z1E7GjCkHE3w-9h-OXu4jLBM3Fag6ag@mail.gmail.com>
Subject: Re: [PATCH] perf vendor events power10: Update JSON/events
To: Kajol Jain <kjain@linux.ibm.com>
Cc: acme@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	akanksha@linux.ibm.com, maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, 
	hbathini@linux.ibm.com, disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 10:27=E2=80=AFPM Kajol Jain <kjain@linux.ibm.com> w=
rote:
>
> Update JSON/events for power10 platform with additional events.
> Also move PM_VECTOR_LD_CMPL event from others.json to
> frontend.json file.
>
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

> ---
>  .../arch/powerpc/power10/frontend.json        |   5 +
>  .../arch/powerpc/power10/others.json          | 100 +++++++++++++++++-
>  2 files changed, 100 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/powerpc/power10/frontend.json b/t=
ools/perf/pmu-events/arch/powerpc/power10/frontend.json
> index 5977f5e64212..53660c279286 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
> @@ -74,6 +74,11 @@
>      "EventName": "PM_ISSUE_KILL",
>      "BriefDescription": "Cycles in which an instruction or group of inst=
ructions were cancelled after being issued. This event increments once per =
occurrence, regardless of how many instructions are included in the issue g=
roup."
>    },
> +  {
> +    "EventCode": "0x44054",
> +    "EventName": "PM_VECTOR_LD_CMPL",
> +    "BriefDescription": "Vector load instruction completed."
> +  },
>    {
>      "EventCode": "0x44056",
>      "EventName": "PM_VECTOR_ST_CMPL",
> diff --git a/tools/perf/pmu-events/arch/powerpc/power10/others.json b/too=
ls/perf/pmu-events/arch/powerpc/power10/others.json
> index fcf8a8ebe7bd..53ca610152fa 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power10/others.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power10/others.json

The "topic" of an event is taken from the filename, here the topic
will be "others".

> @@ -94,11 +94,6 @@
>      "EventName": "PM_L1_ICACHE_RELOADED_ALL",
>      "BriefDescription": "Counts all instruction cache reloads includes d=
emand, prefetch, prefetch turned into demand and demand turned into prefetc=
h."
>    },
> -  {
> -    "EventCode": "0x44054",
> -    "EventName": "PM_VECTOR_LD_CMPL",
> -    "BriefDescription": "Vector load instruction completed."
> -  },
>    {
>      "EventCode": "0x4D05E",
>      "EventName": "PM_BR_CMPL",
> @@ -108,5 +103,100 @@
>      "EventCode": "0x400F0",
>      "EventName": "PM_LD_DEMAND_MISS_L1_FIN",
>      "BriefDescription": "Load missed L1, counted at finish time."
> +  },
> +  {
> +    "EventCode": "0x00000038BC",
> +    "EventName": "PM_ISYNC_CMPL",
> +    "BriefDescription": "Isync completion count per thread."
> +  },
> +  {
> +    "EventCode": "0x000000C088",
> +    "EventName": "PM_LD0_32B_FIN",
> +    "BriefDescription": "256-bit load finished in the LD0 load execution=
 unit."
> +  },
> +  {
> +    "EventCode": "0x000000C888",
> +    "EventName": "PM_LD1_32B_FIN",
> +    "BriefDescription": "256-bit load finished in the LD1 load execution=
 unit."
> +  },
> +  {
> +    "EventCode": "0x000000C090",
> +    "EventName": "PM_LD0_UNALIGNED_FIN",
> +    "BriefDescription": "Load instructions in LD0 port that are either u=
naligned, or treated as unaligned and require an additional recycle through=
 the pipeline using the load gather buffer. This typically adds about 10 cy=
cles to the latency of the instruction. This includes loads that cross the =
128 byte boundary, octword loads that are not aligned, and a special forwar=
d progress case of a load that does not hit in the L1 and crosses the 32 by=
te boundary and is launched NTC. Counted at finish time."
> +  },
> +  {
> +    "EventCode": "0x000000C890",
> +    "EventName": "PM_LD1_UNALIGNED_FIN",
> +    "BriefDescription": "Load instructions in LD1 port that are either u=
naligned, or treated as unaligned and require an additional recycle through=
 the pipeline using the load gather buffer. This typically adds about 10 cy=
cles to the latency of the instruction. This includes loads that cross the =
128 byte boundary, octword loads that are not aligned, and a special forwar=
d progress case of a load that does not hit in the L1 and crosses the 32 by=
te boundary and is launched NTC. Counted at finish time."
> +  },
> +  {
> +    "EventCode": "0x000000C0A4",
> +    "EventName": "PM_ST0_UNALIGNED_FIN",
> +    "BriefDescription": "Store instructions in ST0 port that are either =
unaligned, or treated as unaligned and require an additional recycle throug=
h the pipeline. This typically adds about 10 cycles to the latency of the i=
nstruction. This only includes stores that cross the 128 byte boundary. Cou=
nted at finish time."
> +  },
> +  {
> +    "EventCode": "0x000000C8A4",
> +    "EventName": "PM_ST1_UNALIGNED_FIN",
> +    "BriefDescription": "Store instructions in ST1 port that are either =
unaligned, or treated as unaligned and require an additional recycle throug=
h the pipeline. This typically adds about 10 cycles to the latency of the i=
nstruction. This only includes stores that cross the 128 byte boundary. Cou=
nted at finish time."
> +  },
> +  {
> +    "EventCode": "0x000000C8B8",
> +    "EventName": "PM_STCX_SUCCESS_CMPL",
> +    "BriefDescription": "STCX instructions that completed successfully. =
Specifically, counts only when a pass status is returned from the nest."
> +  },
> +  {
> +    "EventCode": "0x000000D0B4",
> +    "EventName": "PM_DC_PREF_STRIDED_CONF",
> +    "BriefDescription": "A demand load referenced a line in an active st=
rided prefetch stream. The stream could have been allocated through the har=
dware prefetch mechanism or through software."
> +  },
> +  {
> +    "EventCode": "0x000000F880",
> +    "EventName": "PM_SNOOP_TLBIE_CYC",
> +    "BriefDescription": "Cycles in which TLBIE snoops are executed in th=
e LSU."
> +  },

Perhaps the topics here should be memory or translation?

> +  {
> +    "EventCode": "0x000000F084",
> +    "EventName": "PM_SNOOP_TLBIE_CACHE_WALK_CYC",
> +    "BriefDescription": "TLBIE snoop cycles in which the data cache is b=
eing walked."
> +  },
> +  {
> +    "EventCode": "0x000000F884",
> +    "EventName": "PM_SNOOP_TLBIE_WAIT_ST_CYC",
> +    "BriefDescription": "TLBIE snoop cycles in which older stores are st=
ill draining."
> +  },
> +  {
> +    "EventCode": "0x000000F088",
> +    "EventName": "PM_SNOOP_TLBIE_WAIT_LD_CYC",
> +    "BriefDescription": "TLBIE snoop cycles in which older loads are sti=
ll draining."
> +  },
> +  {
> +    "EventCode": "0x000000F08C",
> +    "EventName": "PM_SNOOP_TLBIE_WAIT_MMU_CYC",
> +    "BriefDescription": "TLBIE snoop cycles in which the Load-Store unit=
 is waiting for the MMU to finish invalidation."
> +  },
> +  {
> +    "EventCode": "0x0000004884",
> +    "EventName": "PM_NO_FETCH_IBUF_FULL_CYC",
> +    "BriefDescription": "Cycles in which no instructions are fetched bec=
ause there is no room in the instruction buffers."
> +  },
> +  {
> +    "EventCode": "0x00000048B4",
> +    "EventName": "PM_BR_TKN_UNCOND_FIN",
> +    "BriefDescription": "An unconditional branch finished. All unconditi=
onal branches are taken."

I see PM_BR_TAKEN_CMPL in
tools/perf/pmu-events/arch/powerpc/power10/frontend.json, so maybe it
makes sense to put this event in that topic?

Thanks,
Ian

> +  },
> +  {
> +    "EventCode": "0x0B0000016080",
> +    "EventName": "PM_L2_TLBIE_SLBIE_START",
> +    "BriefDescription": "NCU Master received a TLBIE/SLBIEG/SLBIAG opera=
tion from the core. Event count should be multiplied by 2 since the data is=
 coming from a 2:1 clock domain and the data is time sliced across all 4 th=
reads."
> +  },
> +  {
> +    "EventCode": "0x0B0000016880",
> +    "EventName": "PM_L2_TLBIE_SLBIE_DELAY",
> +    "BriefDescription": "Cycles when a TLBIE/SLBIEG/SLBIAG command was h=
eld in a hottemp condition by the NCU Master. Multiply this count by 1000 t=
o obtain the total number of cycles. This can be divided by PM_L2_TLBIE_SLB=
IE_SENT to obtain the average time a TLBIE/SLBIEG/SLBIAG command was held. =
Event count should be multiplied by 2 since the data is coming from a 2:1 c=
lock domain and the data is time sliced across all 4 threads."
> +  },
> +  {
> +    "EventCode": "0x0B0000026880",
> +    "EventName": "PM_L2_SNP_TLBIE_SLBIE_DELAY",
> +    "BriefDescription": "Cycles when a TLBIE/SLBIEG/SLBIAG that targets =
this thread's LPAR was in flight while in a hottemp condition. Multiply thi=
s count by 1000 to obtain the total number of cycles. This can be divided b=
y PM_L2_SNP_TLBIE_SLBIE_START to obtain the overall efficiency. Note: =E2=
=80=99inflight=E2=80=99 means SnpTLB has been sent to core(ie doesn=E2=80=
=99t include when SnpTLB is in NCU waiting to be launched serially behind d=
ifferent SnpTLB). The NCU Snooper gets in a =E2=80=99hottemp=E2=80=99 delay=
 window when it detects it is above its TLBIE/SLBIE threshold for process S=
npTLBIE/SLBIE with this core. Event count should be multiplied by 2 since t=
he data is coming from a 2:1 clock domain and the data is time sliced acros=
s all 4 threads."
>    }
>  ]
> --
> 2.43.0
>

