Return-Path: <linux-kernel+bounces-189223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDEE8CED4E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 03:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AD63B20E32
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 01:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74D815C3;
	Sat, 25 May 2024 01:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PtPF/wfq"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDA9391
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 01:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716600402; cv=none; b=glxipwT6hrZnd8xq3XhTEVDcZb/Ux7ZCwd7WEuJ6hZEuf0jaxhSrpVWRRiApO24ysmrOGVZ0z931koH8m1GM7/oTtMRlbeueHC1mtlplEQh4eYqGOBrwsZvBAhTOLwmVhZmAPwxs1Efg86W9+NXeCQ31wHVjaxKHXnF4xtM6iqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716600402; c=relaxed/simple;
	bh=ekWtQiuFC9hRTRqzLYUPI8tvqm3UzOZX4/nHMuyW4Xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TYC8iSNbtUYL7I1VL5OiFNZ9Ha1+0ovmiyYOB7L/cbDsL0FOX2mtnkyQGsMqC2WM01fXp8qlbpybRVadBMFCjdMm604zrUhB5ICRgSkNfGaYTc6v/iVBCAuQf8aQxRdSJNwJyBQtAlZ7FULIG+TvP+i20V918Mu9IESDMZRxBHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PtPF/wfq; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43dfa9a98d2so43491cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 18:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716600399; x=1717205199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyskWn7gAK4GatlSK3paUJEmvNBp3h8+7kuW84hMmtg=;
        b=PtPF/wfqPGgXSHwHecfDvlEI/Ch4BZJBapB3wJz6eT/Ivij1jAGYACVJtTg6O7NiKZ
         nrB6kJZeYzDxDqSAp4o2yJR0TfQNYpcqFXX/gVVuUF1Tt0jVgQtTjVnuxJJKjesan3EO
         QHtrLUUT7RrSrZhCAfHzZlTwDYds1AsOPRP49mSL74dSjTqTJrbDIJGdN6HFxK5BmHMh
         QoZn2fEywv4ljoAm/XHTi0NJ0cDzjJ0rHj1dPf3EuT08oSVmiNT4FjU3bhqzI6BuR/kf
         uid82beCo/O31muPc+JRJzkWUMXutsxCpjfdu8PF4lURSMnBNS3Dju5fqqafAKR/m2QI
         Srkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716600399; x=1717205199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyskWn7gAK4GatlSK3paUJEmvNBp3h8+7kuW84hMmtg=;
        b=R2HiqSY9JDbxEU0l7ANgow7dSa+ewvSkNXAm0E27LmeV0jkC4NOLD6Y/yoquN90ovr
         Aot8mcl1Y6QmWqbvYjt9IlIlQtrKPJ+AfnzwKMksNMdnr3e85aOGDzxDYjnnIP5tTEpZ
         1mXnjSK+xE8YwdeF+avTxsmRrK0MZm8pAAYstnsFHR6q7pLseZsGDNp4/2zW977Xfwz9
         WXkOMX/umxil0SCw8OD/lTdiLRMJSTHnF7SQBYY5K/wALVWqXCd/EH5HCXSnjRSCMmNE
         np6LYgYf36sw8qeMmA4HFRwNqLZXBci4J6SCJr+JrLU5SzkqoCcQQ6GbImdY/saoxn6V
         bL0g==
X-Forwarded-Encrypted: i=1; AJvYcCX3xLUmcnPaHHigWsVQ29VnoRtn9GBGGlHaRBwZwxq2KS3yZgwAO609iU+9hlqyZhI3Fvm+abcZgyhEDUytyTmz055JCpATYUEAnMlN
X-Gm-Message-State: AOJu0YwPkm4lTTLkCN4hyuwpgj1fDqHPfXk+RLJYsS2Xl/AB3E0CFwC4
	q3I+elGPShmd/J1GGo9vM21FOM5RpCCW7XgEk4LfTnrYKsI09iYMl++fXZCvpJXZaUF/kwx60/S
	XDzT/8gJ/ZJMcud7Y8KmBUMDXsplMOkIfmfNf
X-Google-Smtp-Source: AGHT+IE0+qpSMG1Nj1Ou0YsvA+xYJ1ZLiqofkBmsWLfKf34amWFXg6qqms2k5cTej7Za/5Dfw7xalvOK5IhtKkG2sbQ=
X-Received: by 2002:ac8:6f08:0:b0:43e:ec2:4bb8 with SMTP id
 d75a77b69052e-43fb9f9b9a5mr1296071cf.26.1716600399486; Fri, 24 May 2024
 18:26:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522204254.1841420-1-weilin.wang@intel.com>
In-Reply-To: <20240522204254.1841420-1-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 24 May 2024 18:26:27 -0700
Message-ID: <CAP-5=fUtp_vd=EeeesXPR=nsm0VOZoyXico=EVWobOEYsxq27g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] perf test: make metric validation test return
 early when there is no metric supported on the test system
To: weilin.wang@intel.com
Cc: Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 1:43=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Add a check to return the metric validation test early when perf list met=
ric
> does not output any metric. This would happen when NO_JEVENTS=3D1 is set =
or in a
> system that there is no metric supported.
>
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/lib/perf_metric_validation.py | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/lib/perf_metric_validation.py b/tools=
/perf/tests/shell/lib/perf_metric_validation.py
> index a2d235252183..0b94216c9c46 100644
> --- a/tools/perf/tests/shell/lib/perf_metric_validation.py
> +++ b/tools/perf/tests/shell/lib/perf_metric_validation.py
> @@ -95,7 +95,7 @@ class Validator:
>                        indent=3D4)
>
>      def get_results(self, idx: int =3D 0):
> -        return self.results[idx]
> +        return self.results.get(idx)
>
>      def get_bounds(self, lb, ub, error, alias=3D{}, ridx: int =3D 0) -> =
list:
>          """
> @@ -173,7 +173,10 @@ class Validator:
>          pcnt =3D 0
>          tcnt =3D 0
>          rerun =3D list()
> -        for name, val in self.get_results().items():
> +        results =3D self.get_results()
> +        if not results:
> +            return
> +        for name, val in results.items():
>              if val < 0:
>                  negmetric[name] =3D val
>                  rerun.append(name)
> @@ -532,6 +535,9 @@ class Validator:
>          '''
>          if not self.collectlist:
>              self.parse_perf_metrics()
> +        if not self.metrics:
> +            print("No metric found for testing")
> +            return 0
>          self.create_rules()
>          for i in range(0, len(self.workloads)):
>              self.wlidx =3D i
> --
> 2.42.0
>

