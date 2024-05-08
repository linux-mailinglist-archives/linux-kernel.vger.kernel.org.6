Return-Path: <linux-kernel+bounces-173886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D62788C073A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DB981F23568
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E6E1332B1;
	Wed,  8 May 2024 22:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r1nk+o4U"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B8A13329F
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 22:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715206460; cv=none; b=gI/3PLC+vre6VPgM8hmdLAvFPQmQe0GyLpuS+nai7QWnDyS32zuUPbbCgRf65/AOb8L5/6DUoelDWrMOyPc0R72IobmhAJN67yizuk8hrpfF0HpPgKuXS+UQF6z/kuQyDteRCaZEareh8Ktv9ddRUnD70+oiiICHsVUymJ3MdBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715206460; c=relaxed/simple;
	bh=SY3te0gY8EpEl5E689hBYo4WycQ2ACiXqT0tWFK/u1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhVmxRVki/1f55tgl8d5zJpH2LhH/a+kf7ErgcXXhiU5xlhz6PvB4Q2VEvE+wyEF+nvIdkknr+05XOisEk2xTmKoBQhEV08iLdSUUXYaf5L4bWPVe2h4PPdDBWNx8GELlI/VpGH6jJ2f7BNqL6QsqXnQg2qc4oqZQeNPMZPUeVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r1nk+o4U; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ee0ccf9c2fso52325ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 15:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715206458; x=1715811258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+C4NWbW6e+o3FY/4yD/C5aK+kcXnZU1WPZD0Mhpw68=;
        b=r1nk+o4USVy9oe7yUEF6LlzevnLOp8MzdIkrR/q+L8o8K8uWeZU2AJsD85nb3Xx8xP
         hGmiV8KK8o/hyHQ70H08KzA+1YabNpBZmSG38rqnPcYIegz7228OxdiRMC2rTe4pscpk
         RfD1OsdTGAPcybkNB1E0TYtG6CFv392Rpz1JmED0QiTSf9KUl0IXOD4/FYBM9A5dNrBb
         X/yrK51O5ZPr/h1iv8tWJja0k1FilkPhxeh0k3iwmzQSD++MoaM4vH3SIryaOHQcc4TV
         SsFzA4HXKMvDREco0JIZYNDqyxUHwTh7CfYfZfAcxkmir+kp2suDY55+dkB2vD6OCx6f
         GkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715206458; x=1715811258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+C4NWbW6e+o3FY/4yD/C5aK+kcXnZU1WPZD0Mhpw68=;
        b=ujGBDD7ZbbXZRp95qRL4jOvnXhhgPGTVUVHW3fSN9IGhvmIAp/Z46dfiElGGrzvrnX
         PrYmewGDM0+g1wudtx1QUvYlXjWZWhP9Hq1KLLAhNP25GqaJjwZq7Sj94U+k3yJ8wtTc
         F0jSBAXhrjuyIGPQf3Zwm9+ctbO67SS9JAcLy1+0vINtgaDyix7iNS+yn7o5qkCny+32
         DBhyTSrznrnHqY9+I5yw9w60IEqYg3YSLDfFoT5BqZeMtSiU2CPBZ1hmDxmEoGj55n/G
         tGopAJlwZzEKPRRWr1kJ0lOWc3Vd+1hfFMouYoZN/mncFEih5TEYjed6ysxVarPIhoPz
         Uakw==
X-Forwarded-Encrypted: i=1; AJvYcCW6wd3GBFOKQSB/HsXv8Nb7wy5nvCpQj+Ehr4D2OLR0ThLSeCDr6Ao+WclhR+DXHWpREJqNWmu7X1L0pgNT2XHSlP04wwDoysup/NEj
X-Gm-Message-State: AOJu0Yz1rl0bXHRTZpBUMWEkoHiDrC7+fW/J5+gPLbegapuwpDFy1dci
	EpzgEBd2D9BZPfZehaI+np8ejIqyEqgaK2oQEpHeLB+e6pDN6oOezDdvlMJrAnRrOJ1vxk52CLy
	un9927Ops4lRE0mESqC7/jIDMrlFw/vnKgdw4
X-Google-Smtp-Source: AGHT+IFp8koGJ5z9B2iYuRA1SjLPqE1fjH610M4HsbYYGGiU8xRXw3/oOjPyK1aeZTnnxlfQV4bGyWTVncicCz94LjI=
X-Received: by 2002:a17:903:22cc:b0:1ea:963e:2e2d with SMTP id
 d9443c01a7336-1ef01244e57mr775635ad.24.1715206457473; Wed, 08 May 2024
 15:14:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507141210.195939-1-james.clark@arm.com> <20240507141210.195939-5-james.clark@arm.com>
In-Reply-To: <20240507141210.195939-5-james.clark@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 May 2024 15:14:06 -0700
Message-ID: <CAP-5=fWJCfz6VPRC+A4pcsGYVBTv_ANis6kxByELVRiOWsPhxQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf symbols: Fix ownership of string in dso__load_vmlinux()
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.vnet.ibm.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 7:13=E2=80=AFAM James Clark <james.clark@arm.com> wr=
ote:
>
> The linked commit updated dso__load_vmlinux() to call
> dso__set_long_name() before loading the symbols. Loading the symbols may
> not succeed but dso__set_long_name() takes ownership of the string. The
> two callers of this function free the string themselves on failure
> cases, resulting in the following error:
>
>   $ perf record -- ls
>   $ perf report
>
>   free(): double free detected in tcache 2
>
> Fix it by always taking ownership of the string, even on failure. This
> means the string is either freed at the very first early exit condition,
> or later when the dso is deleted or the long name is replaced. Now no
> special return value is needed to signify that the caller needs to
> free the string.
>
> Fixes: e59fea47f83e ("perf symbols: Fix DSO kernel load and symbol proces=
s to correctly map DSO to its long_name, type and adjust_symbols")
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/symbol.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index e98dfe766da3..6a0900dcdfd3 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1977,6 +1977,10 @@ int dso__load(struct dso *dso, struct map *map)
>         return ret;
>  }
>
> +/*
> + * Always takes ownership of vmlinux when vmlinux_allocated =3D=3D true,=
 even if
> + * it returns an error.
> + */
>  int dso__load_vmlinux(struct dso *dso, struct map *map,
>                       const char *vmlinux, bool vmlinux_allocated)
>  {
> @@ -1995,8 +1999,11 @@ int dso__load_vmlinux(struct dso *dso, struct map =
*map,
>         else
>                 symtab_type =3D DSO_BINARY_TYPE__VMLINUX;
>
> -       if (symsrc__init(&ss, dso, symfs_vmlinux, symtab_type))
> +       if (symsrc__init(&ss, dso, symfs_vmlinux, symtab_type)) {
> +               if (vmlinux_allocated)
> +                       free((char *) vmlinux);
>                 return -1;
> +       }
>
>         /*
>          * dso__load_sym() may copy 'dso' which will result in the copies=
 having
> @@ -2039,7 +2046,6 @@ int dso__load_vmlinux_path(struct dso *dso, struct =
map *map)
>                 err =3D dso__load_vmlinux(dso, map, filename, true);
>                 if (err > 0)
>                         goto out;
> -               free(filename);
>         }
>  out:
>         return err;
> @@ -2191,7 +2197,6 @@ static int dso__load_kernel_sym(struct dso *dso, st=
ruct map *map)
>                 err =3D dso__load_vmlinux(dso, map, filename, true);
>                 if (err > 0)
>                         return err;
> -               free(filename);
>         }
>
>         if (!symbol_conf.ignore_vmlinux && vmlinux_path !=3D NULL) {
> --
> 2.34.1
>

