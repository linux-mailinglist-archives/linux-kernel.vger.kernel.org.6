Return-Path: <linux-kernel+bounces-265094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307E693EC72
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B67DCB212E1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AF97FBAC;
	Mon, 29 Jul 2024 04:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="oR7hrVpf"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD22653
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 04:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722226085; cv=none; b=enOK9Jt1+Wu4u9OKB7X29lXAb+oqS5xIOiGsZN0TzQJiLfG6pGBgtZ0UmmXjQct5NG58jaf9Xx/fafquhlM2ExtkEyhGNP75qRXO43iGpdVOPLpUIOCTivgJNO56XAXJIjYPb92e8RifdUqKS95/vcDoiLrnW3OAP7/czbEbBTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722226085; c=relaxed/simple;
	bh=T4lGoxYNTr6+F++283kyfPshOeS3Gn05EgTWsmKiOB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMk1K4TxWU6XgPxMb+zyQ7QDy547SebiE2kY08gr8zGxzY14P6oMAUJcR58gh3dXF0mrRKXjT4ykVXXrvGuKxcJvRpFA6Cf11fNxVCObtuGgw4zinp0k0qdekbPWFujB5DrZl2YvSsf16WG9gqlp9inQF7cW27W7Js1WzjXMBSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=oR7hrVpf; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8977E3F2A0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 04:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1722226079;
	bh=mS2NWChGwK2dbkHGg9LArYFfctLnmGlSEWfSEvOL2o8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=oR7hrVpf5JsdqRwmgKeb7bB1gGR652H6tslrJLtmv0iQWwU/B64LhPSsSFN1jv8fo
	 fgssReY0pxYoscA21Jr82tI0Dez7ujzEqFP1cWhfmjUNF/psZSgyLzDMcHs/nah0iv
	 dBpA7ug4uOrgAKyp8jPijTFjm9+rMlYirNxr6zCAGmagttbEPka9Exuxmv1gpQUjqs
	 IVFVUmAi4rLeio47JHvS2zdv7hcAtUlXKWjP5QbgnVIpMgUAxuaoPv7C/rIw6oEHIr
	 3ZN8DcZoMY+8zWCpPgz3DQAXZhc+1uQBGMj67SuXaj+II13q+ByzZcxmOJCfJcTyUd
	 BiuRGc/HARW1Q==
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-70932abea64so2278480a34.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 21:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722226078; x=1722830878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mS2NWChGwK2dbkHGg9LArYFfctLnmGlSEWfSEvOL2o8=;
        b=GCLuwaI6vpQmROZQe+nJA4OBZqJSGFEX+evj1atWzq5PXVX5K/BGGfXE7HBbJou3ja
         LOomxudpjn+YNDeVsSYzjKXy0u/chAPug/rGbv5up5bTWvyg3bqhrHlQp35/e82zmNjK
         T4af+nI1lRzBoZ4m12jQ/KDcxnaVDkYXhhN5ylWd/yZoFR5r4opae9xava5BkPvvXB0x
         9QAw6XeXfQdfnX6tcB5BpHe5bTGRDGelsR2l2D5HJXbPdijd/U/xBETzaQXkCAX8+igg
         k6nh/oFC4KVXPCxr7GfFAkkVeLv26Ntk/gRWWYyKUM70sap4ZyvD83wJU8n45/S58nrK
         0dmA==
X-Forwarded-Encrypted: i=1; AJvYcCVxYmIIMyeym5OpR8TkzL20pLoDoyzB1EQqWvzKbLDqyZ8XjWGdU8GHWe88OVaIgRDPN4oomfrntQS4QyDBMQc9RGYq4LZ5DUUm+9W1
X-Gm-Message-State: AOJu0YycVH4kossZt1HdpqVlmLEFC5RW3Mq0giLSZlf0mYMZ+ozQ6fNj
	utlr3XXhsmQdr4VgHR0UpwNDATBhE4Qh9nQuFZS+Gg5VcGu9VlQWoIw+gh7+YVK9voO/iYSNo8r
	J3hA6vXITEHCIop9oyAXQycDTqTfyuTLDZZaD9n//o69vSR9XViooldCNnwP/yvSgvIyEONmfNW
	xrjQ0ruoXT9mKg60J4F3wXMC3XcsV0GgFOkQecNB5d4GUNlLmO9loE
X-Received: by 2002:a05:6830:dc7:b0:709:396c:f295 with SMTP id 46e09a7af769-70940ca166emr10131651a34.32.1722226078286;
        Sun, 28 Jul 2024 21:07:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+DP7BGUy8zSvm9AXhSQBatpe/932igO8e0nfQkVowJAYO/dkU+85vlcAJsREfivDShcRlZ8ttX+F/Z41yikE=
X-Received: by 2002:a05:6830:dc7:b0:709:396c:f295 with SMTP id
 46e09a7af769-70940ca166emr10131636a34.32.1722226078023; Sun, 28 Jul 2024
 21:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726062601.674078-1-kai.heng.feng@canonical.com> <2048df524f8be7ed200bc92eb1c6efe106f0ed19.camel@intel.com>
In-Reply-To: <2048df524f8be7ed200bc92eb1c6efe106f0ed19.camel@intel.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Mon, 29 Jul 2024 12:07:46 +0800
Message-ID: <CAAd53p5ftAjtfb-uCcVKR8G0JfoGnA_a0Se1E_vPeietgOENOg@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Add Jasper Lake and Elkhart Lake support
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[+Cc Rafael, Srinivas]

On Fri, Jul 26, 2024 at 2:52=E2=80=AFPM Zhang, Rui <rui.zhang@intel.com> wr=
ote:
>
> On Fri, 2024-07-26 at 14:26 +0800, Kai-Heng Feng wrote:
> > Without proper C-state support, the CPU can take long time to exit to
> > C0
> > to handle IRQ and perform DMA.
>
> Can you provide more details?
>
> Say, what cstate is entered w/ and w/o this patch?

Without the patch it's ACPI C1, C2 and C3.

>
> can you show the output of "grep .
> /sys/devices/system/cpu/cpu0/cpuidle/state*/*" without this patch?

/sys/devices/system/cpu/cpu0/cpuidle$ grep . */*
state0/above:0
state0/below:631
state0/default_status:enabled
state0/desc:CPUIDLE CORE POLL IDLE
state0/disable:0
state0/latency:0
state0/name:POLL
state0/power:4294967295
state0/rejected:0
state0/residency:0
state0/time:19513
state0/usage:635
state1/above:26
state1/below:12437
state1/default_status:enabled
state1/desc:ACPI FFH MWAIT 0x0
state1/disable:0
state1/latency:1
state1/name:C1_ACPI
state1/power:0
state1/rejected:0
state1/residency:1
grep: state1/s2idle: Is a directory
state1/time:18621370
state1/usage:74523
state2/above:1690
state2/below:17
state2/default_status:enabled
state2/desc:ACPI FFH MWAIT 0x31
state2/disable:0
state2/latency:253
state2/name:C2_ACPI
state2/power:0
state2/rejected:0
state2/residency:759
grep: state2/s2idle: Is a directory
state2/time:7063052
state2/usage:7909
state3/above:13111
state3/below:0
state3/default_status:enabled
state3/desc:ACPI FFH MWAIT 0x60
state3/disable:0
state3/latency:1048
state3/name:C3_ACPI
state3/power:0
state3/rejected:0
state3/residency:3144
grep: state3/s2idle: Is a directory
state3/time:4451519230
state3/usage:55467


>
> >
> > The data collect via wult shows the latency is similar to Broxton, so
> > use the existing table to support C-state on JSL and EHL.
>
> so you have done cstate measurement on the EHL using wult?
> can you share more details about the measurement results?

I look at the "spikes" of the aggregated graph. Not sure if it's the
right way to interpret the graph though.

It will be much better if Intel can add the proper C-states table for
JSL and EHL.

Kai-Heng

>
> thanks,
> rui
>
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219023
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/idle/intel_idle.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> > index 9aab7abc2ae9..eb6975a1d083 100644
> > --- a/drivers/idle/intel_idle.c
> > +++ b/drivers/idle/intel_idle.c
> > @@ -1538,6 +1538,8 @@ static const struct x86_cpu_id intel_idle_ids[]
> > __initconst =3D {
> >         X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,      &idle_cpu_bxt),
> >         X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_PLUS, &idle_cpu_bxt),
> >         X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_D,    &idle_cpu_dnv),
> > +       X86_MATCH_VFM(INTEL_ATOM_TREMONT,       &idle_cpu_bxt),
> > +       X86_MATCH_VFM(INTEL_ATOM_TREMONT_L,     &idle_cpu_bxt),
> >         X86_MATCH_VFM(INTEL_ATOM_TREMONT_D,     &idle_cpu_snr),
> >         X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,     &idle_cpu_grr),
> >         X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,   &idle_cpu_srf),
>

