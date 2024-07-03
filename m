Return-Path: <linux-kernel+bounces-238885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB159252B8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74264282BE3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FA24963B;
	Wed,  3 Jul 2024 04:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="marPNZ1u"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADEC433A8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 04:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719982530; cv=none; b=gFnXGJOGWNCX1MxYMsGtD3z3XfZB8OsLaB3ZXfnSFAfn+joe3biEaW90dtatblYPtchdPF7nC0qT+aH7XjmfsQ5hYaQuxoU5KHeLAujVrq2zSRlHBB59SIhO2YdIEWHS8oC74SV3MI5+Pbv/XLKaf4BC+pQc0dT0ibNYeIHM1nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719982530; c=relaxed/simple;
	bh=pioZSIolVmtYtlquODUS7rJvpggVsoqCEChcPHt1YFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyCc/ci86tYWi7kuoT9HDqvRhdiaynuOHeTBnf4gRt45UrODXJaPFDxzEKd67vArnyJvZsP2/HnVw8Q4kCelynnDOgHsuGWFw+lZPByyOj2tT98s3exddLi/6gFa+ms0uGvQvuhoyVogvfCeNFJVHO4OS5ae1zbYvXCPKbKNiEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=marPNZ1u; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-375fc24a746so72365ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 21:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719982528; x=1720587328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IO/DqH0ADYTRDFm1YTYAqoMCWBJrgXM18yuI3dQFuJc=;
        b=marPNZ1u53Evh1KLWM688U0HKuGYq1AYmTsitGHJDZKfMXOtmNY8mNhM0YNUfW9uRx
         504QLLU6kvoWCU2FIpkF07gwxBI4xPIFiPeDF6hWlHeW7YhniC5at88ZHk+FmLfrR/I3
         8+piswqXMSz8KejTqmEzIiCn6g/vStoUjJLYuz5fDT858ouhCQ+hJOrwBMs5BusoBnkD
         aIHsB73pON2bpnkoe7GmtogvQNoRjNAgEK3CKi2ZWaSPWDps2rsG8jrXZCD0ttjKkkPC
         Ik22jHz2r1ugKWjgLohw6CgKxZ+chn+6yLShuiwddjF6PMvOPwrM1syFDxlKszWGJIX9
         3uBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719982528; x=1720587328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IO/DqH0ADYTRDFm1YTYAqoMCWBJrgXM18yuI3dQFuJc=;
        b=eoT3dvKrQs7s76o9Ai7Xsb1N1Kbk+7SnVXGFYGdRQCPu6OGsMuZ5lf1pUdJYVtKmLS
         kxh74T1gtl/XNPCGs6a25TPVwx6ylKwE3Cvlf1goFGgNhk7wBA2PeJeQ4mO20StEUV4j
         1ZCQmye3mAewZ5wIfRqh45I5kufrN1xejtVdoHkN7+96GhQ4WxK2oYs4HEzndh9Jq4hv
         h2PXZcvIPyoKlV2/Jc8FDCDrl96UG1lpaQ9z+yQ/rK6pM6JWVuBi+MG+bndexuNh+nfG
         NyoAfDECJkXRDPXpp14gRcJ6/mh6gHSfpvXQahveSCooBJhs2Yv7PdZcN7gh3wNCC2EX
         4Ocw==
X-Forwarded-Encrypted: i=1; AJvYcCV7JopgrOErU4kVWBUX/EdC33wHumtYaSKZzkRxcTNkn90ZrefKrZbA08zNc5dxb8z5vaxU8bdpDUJjbxSC/H+ECkDCn2I6KOaUz1oc
X-Gm-Message-State: AOJu0YzsUGor9VUpNrrxgrLpiMIX81PfU7orjRO/L6IzFehphAO/P2L1
	TR2d8FgXavcBsD0YqrpN4teHU7s53PibqzvCi86LlOacNDBFFwexZmLvRTFCS99tQodvcrIrQTM
	cdPfWtEe8UhGZpPs3rrD5grjo5YUscIQkLpax
X-Google-Smtp-Source: AGHT+IE+xZ/oYNigcsXm3i/zxBQmyCEJ2QC7989kVG5a6gHMV+thGObZqTbBGRxs5zA8QDnSe+EohLFt1+CGFoMZugA=
X-Received: by 2002:a05:6e02:216b:b0:381:28b8:f199 with SMTP id
 e9e14a558f8ab-381e3f7387emr1636915ab.20.1719982527746; Tue, 02 Jul 2024
 21:55:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603092812.46616-1-yangyicong@huawei.com> <20240701142222.GA2691@willie-the-truck>
In-Reply-To: <20240701142222.GA2691@willie-the-truck>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Jul 2024 21:55:16 -0700
Message-ID: <CAP-5=fVTT=CA59uOXdtC3H8d58ep5LR=JUAM5qvZsVUtf=RDgA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Perf avoid opening events on offline CPUs
To: Will Deacon <will@kernel.org>
Cc: Yicong Yang <yangyicong@huawei.com>, mark.rutland@arm.com, acme@kernel.org, 
	namhyung@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, james.clark@arm.com, dongli.zhang@oracle.com, 
	jonathan.cameron@huawei.com, prime.zeng@hisilicon.com, linuxarm@huawei.com, 
	yangyicong@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 7:22=E2=80=AFAM Will Deacon <will@kernel.org> wrote:
>
> On Mon, Jun 03, 2024 at 05:28:09PM +0800, Yicong Yang wrote:
> > From: Yicong Yang <yangyicong@hisilicon.com>
> >
> > If user doesn't specify the CPUs, perf will try to open events on CPUs
> > of the PMU which is initialized from the PMU's "cpumask" or "cpus" sysf=
s
> > attributes if provided. But we doesn't check whether the CPUs provided
> > by the PMU are all online. So we may open events on offline CPUs if PMU
> > driver provide offline CPUs and then we'll be rejected by the kernel:
> >
> > [root@localhost yang]# echo 0 > /sys/devices/system/cpu/cpu0/online
> > [root@localhost yang]# ./perf_static stat -e armv8_pmuv3_0/cycles/ --ti=
meout 100
> > Error:
> > The sys_perf_event_open() syscall returned with 19 (No such device) for=
 event (cpu-clock).
> > /bin/dmesg | grep -i perf may provide additional information.
>
> I still don't see the value in this. CPUs can come and go asynchronously,
> so this is all horribly racy. Furthermore, there are other (racy) ways
> to find out which CPUs are online and whatever we do in the kernel now
> isn't going to help userspace running on older kernels.

Hi Will,

you are assuming here that a counter should be opened on all CPUs.
This is true for "core" PMUs for events like "cycles" but isn't true
for uncore PMUs. For an uncore PMU on dual socket x86 it may have a
cpumask advertising opening on CPUs "0,18". If CPU 18 is taken offline
then the cpumask becomes say  "0,19". In the perf tool we don't need
to determine the topology of the system and see that 19 is next to 18
and online, the PMU driver does it for us. If we intersect the cpumask
of an uncore PMU with online CPUs and the cpumask were still "0,18",
then we'd end up only opening the event on one socket (for CPU 0).

What the cpumask is providing is the list of default CPUs we want to
open the event upon, like a "-C" command line option. Yes this is racy
if you are running perf and taking CPUs on and offline, but it's what
happens on x86 and we live with it okay. That's not to say we can't do
a smarter topology system, cover races with things like BPF, and so
on. These things just aren't where the perf tool code is today and
could face challenges wrt permissions, older kernel compatibility and
so on. In the perf tool code today:

 - No cpumask/cpus file was provided on non-hybrid/BIG.little systems
and so such a cpumask is taken to mean open on all online CPUs. If the
cpumask exists but is empty then we also do this. I see broken ARM
memory controller PMUs with empty cpumask files.
 - A cpus file with a list of online CPUs. This is used by core PMUs
on hybrid/BIG.little systems. x86 doesn't place offline CPUs in this
file but ARM does. My hope is that ARM can be consistent with x86.
 - A cpumask with a list of say one CPU per socket. This is generally
used by uncore PMUs, CPUs not in the cpumask are still valid and are
sometimes used to spread interrupt load. The majority of ARM PMU
drivers seem broken here, either wrt offline CPUs, not providing a
cpumask, etc.

Thanks,
Ian

