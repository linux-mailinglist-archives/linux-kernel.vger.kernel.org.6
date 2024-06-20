Return-Path: <linux-kernel+bounces-223274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E80B0911091
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D0E1C241AC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373441BE876;
	Thu, 20 Jun 2024 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4pltnY0Y"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001711BA096
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906886; cv=none; b=iLssL5HhBmMWoOXotUH5ZjAPswXTf2zPaDCvtlYdykZ5HI1TiXAUR7ZPY9LbIbmtbi3nrhCZPk5VMkgTMvNUUgNwNWc3E4kWcqtOHVPmCcRi9D2dpAZ00JBZQ61H+Kqfn+St4DWnIBC6GcluUjaLCpSS8cN4Tv3QUQbldZwUAqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906886; c=relaxed/simple;
	bh=AiSUFmCvXmOIY11aG7P0jqpokdtXDCdMyccJlMzbZrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ouhl4MKTFlKNZMiOtQW51LBnNYNH44zPD6gvAruEfwEh2sduDo6BFpUxm7d6nwG2xRxBj62zEsHRb11yN+joB7so+aXP7EUh9rRQH1ol7fCD8ieKZKy1NED0c7Vu99yf+3OPDrwBHCuVRKqEu57N7ClVCOAWXoP+Q4kuxS3IK5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4pltnY0Y; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-375fc24a746so11655ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 11:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718906884; x=1719511684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boOOgjA2cYx+WRs+FXruMxLj/lb0birCa2UkibJY+OY=;
        b=4pltnY0YSdMtfBO6JNJQx3edd+EbdMeBBPIZnvkbcCOTXqwE0kiNIK94/iKzAXVbzb
         jDogKkEXJvD/Yc/BPeW7TtcKEdM4WLy/zqb26u6EBruMeLQZG6NKtaEBxZMwREOU3tKl
         NjOcvBzgcHxFsYBRd0kaCZ/bJNblJNgbshac9WHq9kYeTLndmaK/hxomOlmlwlzwokW7
         RwDsSxn/0tU4doWMoxP89Gu1PpVDsrrVROWCbYBNuNbivPeROQz1p9ArJCZ5NtKk2Yzz
         btaVKnNh5ehCyb4Y3u4JpeJSqClWa6OIDbYNF1oM081YWJtQiDlnXaS8ulF90z2+mtaV
         QM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906884; x=1719511684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boOOgjA2cYx+WRs+FXruMxLj/lb0birCa2UkibJY+OY=;
        b=OJjHLRJ6Ren1c8a1E+/wLKG+5ZWqQTFXXmDak3VdVNOt1C8Yw/qrponpahmuDwv0cO
         M0yVboL/+FvSEwp+Vvmsz32Mge8iwtgiMgUujuhYOxc/f91XzET3D4WRn5TLBArRTxlL
         raEeWnzeCPlZB0Aazlrv7EBSszPtOTwoRNSkxoyePztaeMgfhdxPbbCZSOhJPkgUpTqq
         zcBxztacTa1eVUZnTPm4QY+J4bgnXbbbzhIvvPI2C7vYbufCiWfo7csfJ+Y0i101eChh
         MzvRPC9Vum0i36gqjjmsS70/20f3mR0qbT8RUCkbeKS8SEzb4iMuymv+RoN1zLV0SdVW
         mjGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUJ3cllpdH17QfXxbeWmDS8cUmO2wbf+1r9KPVEXgnZ501xMgIGtZI8WJEQzvPckE/rNxEEacVvQ8gXHg7dtwg1LaCyvC6ImdCw5ON
X-Gm-Message-State: AOJu0YwmulXzHydMmjLZ1t/sTOTM2kKKmI/VnxFEDJYRkbTzuhVS+t64
	SwmVQktYScHhQ9gq/8mS5yOkSYI6MT1tGwMXblB8rasnHaA9j0Vz+EFmWmLTKy88w8sUr3BF2yh
	bzuMNhKvkukp6v6H8bKETDsd7JvTQ1OE8Lsep
X-Google-Smtp-Source: AGHT+IHpxw0aH2Kn0lYlHD9maAaOsFDpR+FzuRFUpUCA6/zf78WxdostPFIWO5RhK6uC2MEo8LVy36QxkLBAh68cAlA=
X-Received: by 2002:a92:90c:0:b0:375:9743:9f4 with SMTP id e9e14a558f8ab-3762e5dbbbdmr270055ab.0.1718906884043;
 Thu, 20 Jun 2024 11:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614230146.3783221-1-irogers@google.com> <20240614230146.3783221-14-irogers@google.com>
 <00ac4787-c290-424f-8461-7ba300a4c1a9@linux.intel.com>
In-Reply-To: <00ac4787-c290-424f-8461-7ba300a4c1a9@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 20 Jun 2024 11:07:52 -0700
Message-ID: <CAP-5=fVzr5a85DO1ZMstj6AXTEfkawphT6RY7oT38mbbGCLr8A@mail.gmail.com>
Subject: Re: [PATCH v1 13/37] perf vendor events: Update grandridge events and
 add counter information
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Weilin Wang <weilin.wang@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 6:45=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
> On 2024-06-14 7:01 p.m., Ian Rogers wrote:
> > Update events from v1.01 to v1.02.
>
> The subject has a typo. It should be "perf vendor events: Update
> graniterapids events and add counter information", not grandridge.

Thanks, will fix in v2.

Ian

> Thanks,
> Kan
>
> >
> > Bring in the event updates v1.02:
> > https://github.com/intel/perfmon/commit/0ff9f681bd07d0e84026c52f4941d21=
b1cd4c171
> >
> > Add counter information. The most recent RFC patch set using this
> > information:
> > https://lore.kernel.org/lkml/20240412210756.309828-1-weilin.wang@intel.=
com/
> >
> > There are over 1000 new events.
> >
> > Co-authored-by: Weilin Wang <weilin.wang@intel.com>
> > Co-authored-by: Caleb Biggers <caleb.biggers@intel.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  .../arch/x86/graniterapids/cache.json         |  825 ++++
> >  .../arch/x86/graniterapids/counter.json       |   77 +
> >  .../x86/graniterapids/floating-point.json     |  242 ++
> >  .../arch/x86/graniterapids/frontend.json      |  469 ++-
> >  .../arch/x86/graniterapids/memory.json        |  175 +-
> >  .../arch/x86/graniterapids/other.json         |  150 +-
> >  .../arch/x86/graniterapids/pipeline.json      | 1009 ++++-
> >  .../arch/x86/graniterapids/uncore-cache.json  | 3674 +++++++++++++++++
> >  .../arch/x86/graniterapids/uncore-cxl.json    |   31 +
> >  .../graniterapids/uncore-interconnect.json    | 1849 +++++++++
> >  .../arch/x86/graniterapids/uncore-io.json     | 1901 +++++++++
> >  .../arch/x86/graniterapids/uncore-memory.json |  449 ++
> >  .../arch/x86/graniterapids/uncore-power.json  |   11 +
> >  .../x86/graniterapids/virtual-memory.json     |  159 +
> >  tools/perf/pmu-events/arch/x86/mapfile.csv    |    2 +-
> >  15 files changed, 10975 insertions(+), 48 deletions(-)
> >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/counte=
r.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/floati=
ng-point.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore=
-cache.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore=
-cxl.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore=
-interconnect.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore=
-io.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore=
-memory.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore=
-power.json

