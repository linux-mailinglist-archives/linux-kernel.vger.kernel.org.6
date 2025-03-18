Return-Path: <linux-kernel+bounces-566553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8758EA67970
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E970A1715ED
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9155211A0D;
	Tue, 18 Mar 2025 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L0oVg78B"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C332211A27
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315327; cv=none; b=iLkBI5d/NSz+e8YpDcHCb5+jAX3+OT4xYkfBJ7VpCqqNPtNH+q14QaZWfjl5lz/oDooW/vlnTx7g1lexoV5155K4Ff/IUmku7aoIgTerIDmCgMwz1g2nXxJxbn12NJkiisewXiepTXmHcsnFh+fHIIo0FurMVSS7vElfn7cprmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315327; c=relaxed/simple;
	bh=1NImk/XKmWMy8gPUR2AAcOZj5LVRw6HPHAAJ3v25Sig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVw7i0sCT9+CZOV85OStx0/LZjKltTx3oWmkEw+T3XDvlCf1+wvEm9uoRsYTyOROULtUdhKMRlkDb0frhufjWEoXsKsDw5ijNkFbgDNHcTb61daqotc6tWCZrxCQq/ltLr9x3Ex5zIOqNC6hUhG+a3L6ONI1D47PG8UIAwViWCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L0oVg78B; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2263428c8baso159435ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742315325; x=1742920125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjiWpseYA4IueE/0zJY0qwQH+wE9WLGDriyYTJqITfQ=;
        b=L0oVg78B8wifUGcqCdSH1LYw0tJp71fTcRRahE7uuXTkwL8Ceoec/M+OpkXBLwnRUt
         dU68cq6Gxf+JjuXfHrfUj4LjEfZHn0eSIqzmt5oHT96eC7JZ+QheK4bsjI6xjqxJSUOE
         nR14kQslIDkX3V/+NONUIaZ8pFiqKmH0eSdL5nH1ka786g4xyObmQQ32uI5q5t8Elh4c
         K2vloZzqCEZM2uJhNNcAbk6qnOX2JNCPtjScu1rLlRN8rTEavVI9TjUiesc7SUPFwyz0
         uj80XG7OWG2BR4KZoPKNd5ydsWAVTx0k6568EdBNxHGy9j+UBc3f6P0E1bgD415h0AWQ
         2dJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742315325; x=1742920125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjiWpseYA4IueE/0zJY0qwQH+wE9WLGDriyYTJqITfQ=;
        b=h3SVP2YGnPfOHYGYf8ME5UnhgCwnDabetxB5r2coy3ZjY8s4R6eEKoH0IwyV1biAon
         E7YgNrlHSSWDY/NTNQXbVQN3tW+fhtzZXxEoPJ96oviTUiaZ19klfHdHy3x6drAhTVOv
         lOTkyW2lQxhn64tXWI7pw1MrDats6+VsEngoDgOIqg15GAS6zM2PGl3f9cdFVesm4ORb
         NDPq5L/iaO2yR0ORlH8R5E1DXxX6hUfQkoTyMmNsWrr6TdgB3y/R+tRLmQvbvblL7cUT
         G7mbCACYSgPNYKwt69iM+omm+3ygc8vHkJir0tm25VToGrZBbxEJZsuWh1kyIOT4NxGw
         ++0w==
X-Gm-Message-State: AOJu0Ywf5IqlDyRAp1hBayiDEt7cAWjHRH/SIvnlct2hDUccsfJhPbGN
	4ZmJ79FkQfRBBKHicVoN0Uo5x4GvBLZ66d5Nd8I38ND+LskkGBhSYcWd7NymwuXG29Z9XEvFc/p
	xwh30NHzhukZH4xTyzfRYHGCE8q74i+6Nqpug
X-Gm-Gg: ASbGncu3GRXgOM2hE1GH0/IU7cf2nSRyvr5tv9Y79opfLleSk4FwWW3rXdVYtZPifLK
	luqOGtHEfdKQ64He3d2Baqq94Xm6K5cPHeVWa1kkVrFq1Dnx9sg0FaQ72/i7de9dVMNI+ueoEQe
	L36LwkWA2t4vbLLB3j/b0C6t+rTmJ4xwvjwvl3ezwV7CI6O71tX5Q=
X-Google-Smtp-Source: AGHT+IE2d4+OlXo4LNV4oNloXDdclW9whxswpjrXJDzywGS47OBIuzFJLqFBgStTnsAnpx6zhH3/KJM/olEA5u8xdKE=
X-Received: by 2002:a17:903:32c1:b0:216:201e:1b63 with SMTP id
 d9443c01a7336-226357cd4afmr2088485ad.11.1742315324425; Tue, 18 Mar 2025
 09:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318095132.1502654-1-tmricht@linux.ibm.com> <20250318095132.1502654-2-tmricht@linux.ibm.com>
In-Reply-To: <20250318095132.1502654-2-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 18 Mar 2025 09:28:33 -0700
X-Gm-Features: AQ5f1JoVZgP1EKgkQBgXOme0t3IsMoETkrh_Ar4sjRVVmL_dl-vozM9gu6ykgts
Message-ID: <CAP-5=fV-X7YKVrd9336KP4uK8YsMs2wtfYRWEqOUvEuQuD2WdA@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf/bench: Fix perf bench internals pmu-scan core dump
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	acme@redhat.com, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com, 
	James Clark <james.clark@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 2:52=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> On s390 z/VM systems the command 'perf bench internals pmu-scan'
> dumps core, as can be seen:
>
>  # ./perf bench internals pmu-scan
>  # Running 'internals/pmu-scan' benchmark:
>  Computing performance of sysfs PMU event scan for 100 times
>  double free or corruption (out)
>  Aborted (core dumped)
>  # gdb ./perf core.xxxx
>  ....
>  #9  0x00000000012fb57a in perf_pmu__delete (pmu=3D0x160e370 <tool>)
>      at util/pmu.c:2318
>  #10 0x00000000012fbfca in perf_pmus__destroy () at util/pmus.c:103
>  #11 0x0000000001186f72 in save_result () at bench/pmu-scan.c:71
>  #12 0x00000000011873c2 in run_pmu_scan () at bench/pmu-scan.c:140
>  #13 0x00000000011876a8 in bench_pmu_scan (argc=3D0, argv=3D0x3fff3a77338=
)
>      at bench/pmu-scan.c:183
>  #14 0x0000000001174556 in run_bench (coll_name=3D0x14709ba "internals",
>      bench_name=3D0x1470700 "pmu-scan", fn=3D0x1187620 <bench_pmu_scan>,
>      argc=3D1, argv=3D0x3fff3a77338) at builtin-bench.c:229
>  #15 0x0000000001174a1e in cmd_bench (argc=3D2, argv=3D0x3fff3a77330)
>      at builtin-bench.c:330
>  ...
>
> The root cause is in PMU buildup. The PMUs are constructed via
>
>   run_bench()
>   +--> bench_pmu_scan()
>        +--> run_pmu_scan()
>             +--> save_result()
>                  +--> perf_pmus__scan()
>                       +--> pmu_read_sysfs()
>                            +--> perf_pmus__tool_pmu()
>
> perf_pmus__tool_pmu() returns a pointer to a static defined variable:
>
>   static struct perf_pmu tool =3D {
>                 .name =3D "tool",
>                 .type =3D PERF_PMU_TYPE_TOOL,
>                 .aliases =3D LIST_HEAD_INIT(tool.aliases),
>                 .caps =3D LIST_HEAD_INIT(tool.caps),
>                 .format =3D LIST_HEAD_INIT(tool.format),
>   };
>
> and that PMU is added to the list of other_cpus in file
> ./util/pmus.c, function pmu_read_sysfs().
>
> Later on after the list of PMUs is constructed,
> that list is removed again via:
>
>    save_result()
>    +--> perf_pmus__destroy()
>         +--> perf_pmu__delete()
>
> This works fine until the PMU named "tool" is deleted.
> Its name is a constant pointer possibly located in read-only data
> section and can not be freed using zfree().
>
> Remedy this and check for dynamic memory allocation for the PMU.
>
> Background: s390 z/VM system do not support PMUs for sampling and
> counting. In this case dummy events are created by the perf tool
> and the PMUs "tool" and "fake" are created and freed.
>
> Fixes: efe98a7a3977 ("perf pmu: Use zfree() to reduce chances of use afte=
r free")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Ian Rogers <irogers@google.com>

Hi Thomas,

Was this already addressed by James' patch:
https://lore.kernel.org/linux-perf-users/20250226104111.564443-1-james.clar=
k@linaro.org/

Thanks,
Ian

> ---
>  tools/perf/util/pmu.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 6206c8fe2bf9..59cec4d2909e 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -2315,10 +2315,13 @@ void perf_pmu__delete(struct perf_pmu *pmu)
>
>         perf_cpu_map__put(pmu->cpus);
>
> -       zfree(&pmu->name);
> -       zfree(&pmu->alias_name);
> -       zfree(&pmu->id);
> -       free(pmu);
> +       /* Static variables can not be free'ed */
> +       if (pmu->type !=3D PERF_PMU_TYPE_TOOL && pmu->type !=3D PERF_PMU_=
TYPE_FAKE) {
> +               zfree(&pmu->alias_name);
> +               zfree(&pmu->id);
> +               zfree(&pmu->name);
> +               free(pmu);
> +       }
>  }
>
>  const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
> --
> 2.48.1
>

