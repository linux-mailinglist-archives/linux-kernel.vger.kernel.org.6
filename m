Return-Path: <linux-kernel+bounces-262470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B729E93C77C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482241F21FFB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9184726286;
	Thu, 25 Jul 2024 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A7AI4H/+"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494FF1990CD
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721926816; cv=none; b=dCFfkZaHRIG/tN6FTKUx/bl1YllmTPTUdd1OcjBo7Xbpp0Wj/cw4wo9g9OpkSpEIYli0wmPXgIKZs6iq8EyEgYCya+3cy25xO+C6zZ/Xxld4w23+FCswyVTR1YWsm5ZlUAoWGSCTZMlBILZ3sIEt40REsE3oiXA6HrTGwl3wD2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721926816; c=relaxed/simple;
	bh=LlYwAwE8l5wqAdDFnTcXPcObo1XSBbN1LFVcZo31A/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y51Uj6HUBd4HsPbkpj9HR7BDSHcnfRNTn1znaT5TRTPFD3NajjYEIcELSDKHI+0T1N3/03F0XeruMdiWcWYFCSdvFi5ksAhb3Y4iKkXCc4NgVM2E3utXXhqgOEhfkz/aEL+kyAZJM/MtXoJzqUnrFzkqtUL1YGj9xwFoehn9sTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A7AI4H/+; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-38b3543541dso5045ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721926814; x=1722531614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2X85cH5/Eio05xnIArIaK9C87tpch57NjNfRmDAITOU=;
        b=A7AI4H/+5zwS7vAaXJtrIGOjYDUDBO92Qas7EoCEmeb4h+nUsQ2WhQQQqowOAhRVrA
         32PbvDQyt/LZ9D3NSve3TNFNpXta3MQlE+DW/ePHjPHEQEKV6on+PpkMk6hNCkZe0/9t
         cOgh351V+gsilXwnpc1uagogIKnepdxiOQ0CL5TU1cAtiNFOls5pHdSgUVwR2Xt6B2Jy
         MCRSQ+tE8pONIjMQaB2ukmhSGDtVrvlNtQR2BTImbX5N3bbTTP22SdKFN7Wg+fYiq8Hm
         sSVBgQUHzoYAgtc0gZrZAi/VHf7oR1+nCFo5Ve/VOHvu6lDTYaDyZXrFatvlgvIQCuSf
         kTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721926814; x=1722531614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2X85cH5/Eio05xnIArIaK9C87tpch57NjNfRmDAITOU=;
        b=lmPqhP2DtaKD++gi8hccq+wVTNe+ivyCReF5EYn9qokDJLE3t1RHxpzUKKg4Iwa/SV
         OmRHm+1q+k8LvuZmBCwLrBwK/0e7/ERZ4PxatubvWncdHMBEYsm86wnNbQR1GchrckEe
         wAUyteUj81MYrsJSGxu5JQ2TbtPf40SHtExTEiJxcCMmNP4B20dRUSExfde9YcOnerTG
         Wv/pKlGTkJlLN+FE0yO6ecysMOhK7gDkq/TYdkgqmdMUb0cGnafDOTUrTP6knQmf3dWZ
         S1vezeWhmc37nbykVmkKoQlbvrZ6ezvpdqcPzLKcAiZ1N4zTJCxucT0Rlsn3BWtgbgX1
         TLhw==
X-Forwarded-Encrypted: i=1; AJvYcCUzpTCAiQ5kDTSBRcv1ieiVk7WjLI4dPRt+7ZN6B2cGyD7UI/eAf6C3ncajXz2OtXvW4REHjCYTeLbuV2tVIGoKbhv1LaWEBGzPQQ6S
X-Gm-Message-State: AOJu0YxH7Wl8YfFFHmRl5HLpGYs0dgx7jWhcvhxtusa3gFT80Ngxk73J
	KjgUnNVgPKQftqIXIrA+AuyJ1SlvN3zXJKbO68pABcbDjrsA7yjIe0t5f4pY2Bp8RVX8QOJ4HqV
	BC6kOx92BaBH2Nu150yuYHSQnZXc+vsV+2Rlo
X-Google-Smtp-Source: AGHT+IENc1pMMX53nfDCX90+Sby4HvWU5UoqDlQx/hbr5Q58RkGY7Wv3Er3TxebHENtBvGMu6vqrmXWL+MnILQ2ktvk=
X-Received: by 2002:a05:6e02:1386:b0:385:1bd6:6f2c with SMTP id
 e9e14a558f8ab-39a2218911emr2370775ab.7.1721926814032; Thu, 25 Jul 2024
 10:00:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW4nem9XZP+b=sJJ7kqXG-cafz0djZf51HsgjCiwkGBA+A@mail.gmail.com>
 <26fb7054-f877-496f-b23a-9b6a3d752595@linux.intel.com> <CAPhsuW6+7ULMQFLbmOsBzYAdd8LMV54h_ynfkGDxd_oH6O8cww@mail.gmail.com>
In-Reply-To: <CAPhsuW6+7ULMQFLbmOsBzYAdd8LMV54h_ynfkGDxd_oH6O8cww@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 25 Jul 2024 10:00:02 -0700
Message-ID: <CAP-5=fVNfGT+a1RG9-ugKWjQR-83vLdHo-6vCVz=N=CBF4_7ug@mail.gmail.com>
Subject: Re: Some unc_cha_tor_* events appear to be "not supported"?
To: Song Liu <song@kernel.org>, "Wang, Weilin" <weilin.wang@intel.com>, 
	"Taylor, Perry" <perry.taylor@intel.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, jonesz@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 9:39=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> Hi Kan,
>
> Thanks for your quick response!
>
> On Thu, Jul 25, 2024 at 6:37=E2=80=AFAM Liang, Kan <kan.liang@linux.intel=
.com> wrote:
> >
> >
> >
> > On 2024-07-24 6:39 p.m., Song Liu wrote:
> > > Hi folks,
> > >
> > > We noticed that some unc_cha_tor_occupancy and unc_cha_tor_inserts ev=
ents
> > > appear to be "not supported" and always counting zero (see an example=
 below).
> > > Is this a known issue? We are testing with 6.10 kernel and perf.
> > >
> > > Thanks,
> > > Song
> > >
> > >
> > > [root@kerneltest008.05.atn6 ~]# ./perf list | grep
> > > unc_cha_tor_occupancy.ia_hit_llcprefdrd
> > >   unc_cha_tor_occupancy.ia_hit_llcprefdrd
> > > [root@kerneltest008.05.atn6 ~]# ./perf stat -e
> > > unc_cha_tor_occupancy.ia_hit_llcprefdrd -a -- sleep 1
> > > WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
> >
> >
> > The value '4b433' is for the 'Filter1', according to the original event
> > list.
> >
> > https://github.com/intel/perfmon/blob/main/SKX/events/skylakex_uncore.j=
son#L4634
> >
> >       "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
> >       "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
> >       "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
> >       "Counter": "0",
> >       "MSRValue": "0x00",
> >       "ELLC": "0",
> >       "Filter": "Filter1",
> >       "ExtSel": "0",
> >       "Deprecated": "0",
> >       "FILTER_VALUE": "0x4b433"
> >
> > There are two filters for CHA on SKX. Each filter is 32 bits wide.
> > So the Linux kernel driver uses config1 (64 bits wide) to represent bot=
h
> > of them. The low 32 bits are for filter0 and high 32 bits are for filte=
r1.
> >
> > It should be an issue of the convert script, which set the filter1 valu=
e
> > to the low 32 bits.
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json#n4489
> >
> > Can you please try the below event?
> > uncore_cha/event=3D0x35,umask=3D0x11,config1=3D0x4b43300000000/
>
> This appears to work. I also tried events like:
>
> uncore_cha/UNC_CHA_TOR_OCCUPANCY.IA_MISS,config1=3D0x4043200000000/
> uncore_cha/UNC_CHA_TOR_INSERTS.IA_MISS,config1=3D0x4043200000000/
>
> Do you have an idea on how to fix the convert script? I haven't looked
> into these codes.

The converter script logic is here:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py#L395
but presumably this worked at some point or is needed on other models.
Checking the perf json I see:
```
$ grep -rl config1 tools/perf/pmu-events/arch/x86/
tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json
tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json
tools/perf/pmu-events/arch/x86/cascadelakex/uncore-cache.json
tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
```
Since CLX is near equal to SKX, and the metrics will presumably be
false hits, perhaps shifting this value will break snowridgex - I have
no such machine to test on.

Using config1 values rather than formats is odd to me. On a SkylakeX I see:
```
$ grep -r config1 /sys/devices/uncore_cha_0/format/
/sys/devices/uncore_cha_0/format/filter_rem:config1:32
/sys/devices/uncore_cha_0/format/filter_opc0:config1:41-50
/sys/devices/uncore_cha_0/format/filter_isoc:config1:63
/sys/devices/uncore_cha_0/format/filter_tid:config1:0-8
/sys/devices/uncore_cha_0/format/filter_loc:config1:33
/sys/devices/uncore_cha_0/format/filter_nc:config1:62
/sys/devices/uncore_cha_0/format/filter_opc1:config1:51-60
/sys/devices/uncore_cha_0/format/filter_all_op:config1:35
/sys/devices/uncore_cha_0/format/filter_not_nm:config1:37
/sys/devices/uncore_cha_0/format/filter_state:config1:17-26
/sys/devices/uncore_cha_0/format/filter_nm:config1:36
```

Adding Weilin and Perry as I'm unsure what the right fix should be. My
thought is the input Intel perfmon json should break apart the filter
value into opcodes, etc. and then in the converter script we add these
to perf events like filter_opc0=3D0xb4.

Thanks,
Ian

> Thanks,
> Song
>
> [...]

