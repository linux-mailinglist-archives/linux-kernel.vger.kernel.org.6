Return-Path: <linux-kernel+bounces-227564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A24915341
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B391C21EF0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEE419D8B3;
	Mon, 24 Jun 2024 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y1uzcEEI"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0139D142625
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245817; cv=none; b=R0mKRFHXklnupDhjCqXv/7YM2F2C3KLoouShRwKg+QW44LL9mJ3ebI/Tw/VhGMoF0khsSCcYjW/h0ucw1FDNc1g/IXq8dkmbswMb0/8JSDp4XCWiFjKYG5bU5O6zRJSXMovCbCS8JxEILZ4EbRHn3Jyw2+ZbpFtz0xaqyNgDp/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245817; c=relaxed/simple;
	bh=VC15zHdju7sXcUQrdV4uuCooM3b/QyNaod6e42Iz/lE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXnYv74tSTwMGyx+WNNb/0vMKytT2kqbFHx34zQwLiwBViKuW1uj5Bavc1a+jrvRAdmkErqT0jr2NtYifmKV6/KCbsvzXgKvaAwk2WsjnudvEqn13NAS01o2bN4hkZWOvKELLl6Bt34446/2TSFrvVwyv9oPvD1BseetrP5p38g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y1uzcEEI; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44056f72257so1108741cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719245815; x=1719850615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoCuTTuRP9nik68N2jcDiJ0+UlXT5uhKxb/k4JLFLE4=;
        b=Y1uzcEEI8IpE/6wnXy4rk7DAaesQ8JfIDKdwO4kTcQ3lpR6FeCAH81vqQq6OIj0zGS
         x4/+2dTkOSRudYIbSscF9mZ1FKh21tUrGaIbOueoGiJHfZqtFARgqZPFR8Zhu/YZrxLZ
         YM9V4LxSjNXgzZ+PrV7cph8wNn1L83XzFdSqganPtDmB2IErnqTCa2iLy0cN9CC7QosW
         RnzCGeY5DT072t21kegqql/ncigBxFGwuISKrke+LhrJJWN6R/EQHzunI2q8DPKoutqt
         KXv3bUUO1ckLL1RSS6n1Ee7+YTE8tv8mydPgpjGTU3Hjn0lEt/si+sHMavEH3ITbmT2C
         t1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719245815; x=1719850615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CoCuTTuRP9nik68N2jcDiJ0+UlXT5uhKxb/k4JLFLE4=;
        b=UJv3yDDKg5rUwd3cVaZ6qjZa6L3PAClmkrlBPfElZHA2SkIJowVkf7/EAv3SEGFJ/3
         FIY81yOiaPdfwrRfPqzeMa44WkiSS+4uh1d8ptjm8SmeLktnkSj91RiOrnZYzEjplw1M
         9tOLwhxnr47ZbXLOlr4dhgwCxaW6sdS4sDiCqMZq+wKmohGAa2ncgZ0Ea+Z47Qr/NxPd
         z9jrLKolBQ90cuu5Yx9q9WPp1NG+vvjBCg5x6s4tR5v81OcgONXouFP7yCIoHxnqNqCb
         zKPqnh139drOtOnuI7zf0rzyca1NeyZu2R1tEoDRXnzQ2Fgez8Qy6hYd/f5szoSFSNsR
         GpyA==
X-Forwarded-Encrypted: i=1; AJvYcCXBWAioS7eIWFKJ+MnEpzelMuQpo6F7bcCoaIGi1bkAvESShvg4B8yalz7yybq4+6bNZVbwj8GldqBKm7//3eUEabUzSG8iOKgA5DT7
X-Gm-Message-State: AOJu0YwIHeN4IHQhZaYulNplZidzNBhOsZhl9xiPY49nVmPGtPZXB6Pi
	MAvnBOX+T6C1iRiz5JYzud2vYIwpCYer90XLpyG6tzwIi2Vx/QJFpn+H2B0IwtbJTdSfZcYK0Ql
	U/h7ovoWaVtfrSSCAHkHPe628fZNdTG5BaEr7
X-Google-Smtp-Source: AGHT+IFsUsVaP9g9yLLpm3p1FMcIJY7mfKyNWsnIZ1899ae8yEIlyhLVmzgItOvSQQeU2kn7xvkZJb87BjIxIWBySJ4=
X-Received: by 2002:a05:622a:14c7:b0:444:c3f3:231f with SMTP id
 d75a77b69052e-444ce2eac12mr5751141cf.16.1719245814685; Mon, 24 Jun 2024
 09:16:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240623133437.222736-1-leo.yan@arm.com> <20240623133437.222736-2-leo.yan@arm.com>
In-Reply-To: <20240623133437.222736-2-leo.yan@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 24 Jun 2024 09:16:43 -0700
Message-ID: <CAP-5=fWgGR-L6V5RNNpTHdHyT0wTOqKd3CQ8xQSQDAJ1D2edYA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf arm-spe: Support multiple Arm SPE PMUs
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 6:34=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> A platform can have more than one Arm SPE PMU. For example, a system
> with multiple clusters may have each cluster enabled with its own Arm
> SPE instance. In such case, the PMU devices will be named 'arm_spe_0',
> 'arm_spe_1', and so on.
>
> Currently, the tool only supports 'arm_spe_0'. This commit extends
> support to multiple Arm SPE PMUs by detecting the substring 'arm_spe'.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/arch/arm/util/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pm=
u.c
> index 8b7cb68ba1a8..29cfa1e427ed 100644
> --- a/tools/perf/arch/arm/util/pmu.c
> +++ b/tools/perf/arch/arm/util/pmu.c
> @@ -27,7 +27,7 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_u=
nused)
>                 pmu->selectable =3D true;
>                 pmu->is_uncore =3D false;
>                 pmu->perf_event_attr_init_default =3D arm_spe_pmu_default=
_config;
> -               if (!strcmp(pmu->name, "arm_spe_0"))
> +               if (strstr(pmu->name, "arm_spe"))

Why not use strstarts?

Thanks,
Ian


>                         pmu->mem_events =3D perf_mem_events_arm;
>         } else if (strstarts(pmu->name, HISI_PTT_PMU_NAME)) {
>                 pmu->selectable =3D true;
> --
> 2.34.1
>

