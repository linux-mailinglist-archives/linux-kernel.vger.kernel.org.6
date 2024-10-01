Return-Path: <linux-kernel+bounces-346028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 399A898BE85
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6CC9B24353
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E841C9B7C;
	Tue,  1 Oct 2024 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bbeWAO54"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3471C6F58
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790700; cv=none; b=fl1KrpqG9OX3fVZhJ2IxMN03FIK0T0Rnl1o8NDyEn8ZaQ4y5TKWUy55g8EY0PioxFIPKASdlMUM/0S0d6JxNxyxw4He4sbihbSwWrV+mg5IrFyK8t/ks8mRY8IRhtOumYZqOGB5OoStJqySWkLh2DMtF1/wApmMhg3yDBWWDodc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790700; c=relaxed/simple;
	bh=DKMT61YzqQ1gvISKlWmlLIYiprIGfEGiqyn8K0KQMmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCvUyWnP+6x6TflIQ/XEmWWhhbFrke0Js0ZcYEDx5XKiTemS2jGJL7BAmdxIBm6a8jZuDaVEHaAoR2RxBbco9B/12/2IDWfT0wt0JUz8lNen6e6Q1GqI+foJXym7XrBwdLgGiH4LIv7FLyg2hr59WsUhaVkPDy9NfzI1yOlyreE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bbeWAO54; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a0cb892c6aso359275ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 06:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727790697; x=1728395497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48wUOkFe53TjLWfnqR6mtcm302S1oICUhkJf6xdI3GE=;
        b=bbeWAO54ycOWxO4QS37HsMCVVP+9lAT3kT/fCSUbiN1Cc7nslyZzuWlg8RrEVfCYWz
         AAe60SxpsbgxeHDcjcZ0Uuy8qh1yRQOVCr+Ma9yu7dhs3hEOWsiSDSbd5OMBEhaaRp4z
         ednp51iRYY+FkAr92AGVBmQceDoLbBqt1wdfv7IpIGXkmNV85/elKxhScNP4vKoBLUBc
         YgUYjOMXwAf5IymTqKrw4lBUJAZejMbRLi1pXYABQGVC9ngC5Wr/AhTC+n+nYIW1XLS8
         fOeQkYFdI4EtPmW5y5HRlrGwZq6QyJRelyxvUX9NFWIVTfid2VRIfRvjnTN5Nvba8s25
         4LTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727790697; x=1728395497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48wUOkFe53TjLWfnqR6mtcm302S1oICUhkJf6xdI3GE=;
        b=RK9zLgU6hpXh40QIRwrr/FxtEDzIC3NWrbVguWwb/R37SmKZrnUiyEuKICMJ9HXmqB
         J0yuqEdIy1yLFL20MPiJ7nbt/IA+PyxNkvySc4udKDomBnAD8zh5HTzh1CfiBY6qkXIR
         hwe3rcp5WcTQSbEqYUcjDwwTA+/m3UqxIunSCVVBhsCqe0iMnSqGaM0RYoLot1T2tX+9
         DcYlGcJ0NtxzcF3mQhMCIYyqvmQqwcNsh62uxE4FvvyCSWzfv8YJRs6ys2mvMMe/Ibpg
         5dVsGsuGsi8b+tKJtyZoJEsdYeTpDVuzo38Txv84fuFCfGzeTzlED+3rsxi85w94misM
         30Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXDYIiMicmYjYpLoKrPuCtFd9rzEnvXwcul/YmbBBMWforp4zjOTg68SZPz2Wqw77Ml9nx5eMXntECLyB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgIpFCv4sE+3g176YHkEepXUsJrQH3toIrt7rz67B15VtrJSEp
	182zHhrkWLgFTHz0q1z8Odlb9QiRUQGRG9Sid0I5HCi/RBfkvD4grCoWxBXVsDYvlAkNVYEttiI
	WWxlZy7YhMMK6gC1YJw0xZbjieSoTfDDPuX9J
X-Google-Smtp-Source: AGHT+IFcHk3nqjivw+SJYZ1aoJmxEgVk8y9/J6HHuCIHNMPZ7sipZFKYUdJWncidCw3XXnrEA8ibHKSYEC3fjQvG8T0=
X-Received: by 2002:a05:6e02:1a62:b0:3a0:b0dc:ac0d with SMTP id
 e9e14a558f8ab-3a36083bf05mr3161285ab.27.1727790696651; Tue, 01 Oct 2024
 06:51:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001123625.1063153-1-james.clark@linaro.org> <Zvv9eBDrquBHBHhF@x1>
In-Reply-To: <Zvv9eBDrquBHBHhF@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 1 Oct 2024 06:51:24 -0700
Message-ID: <CAP-5=fX3X22NS35YQwcMgv03Cw9acjDC_AC-Yocm-zMJXpBg4g@mail.gmail.com>
Subject: Re: [PATCH] perf dwarf-aux: Fix build with !HAVE_DWARF_GETLOCATIONS_SUPPORT
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 6:47=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Tue, Oct 01, 2024 at 01:36:25PM +0100, James Clark wrote:
> > The linked fixes commit added an #include "dwarf-aux.h" to disasm.h
> > which gets picked up in a lot of places. Without
> > HAVE_DWARF_GETLOCATIONS_SUPPORT the stubs return an errno, so include
> > errno.h to fix the following build error:
> >
> >   In file included from util/disasm.h:8,
> >                  from util/annotate.h:16,
> >                  from builtin-top.c:23:
> >   util/dwarf-aux.h: In function 'die_get_var_range':
> >   util/dwarf-aux.h:183:10: error: 'ENOTSUP' undeclared (first use in th=
is function)
> >     183 |  return -ENOTSUP;
> >         |          ^~~~~~~
> >
> > Fixes: 782959ac248a ("perf annotate: Add "update_insn_state" callback f=
unction to handle arch specific instruction tracking")
> > Signed-off-by: James Clark <james.clark@linaro.org>

There are a few variants of this same patch flying around:
https://lore.kernel.org/lkml/20240919013513.118527-4-yangjihong@bytedance.c=
om/
https://lore.kernel.org/lkml/20240924003720.617258-4-irogers@google.com/
Just a heads up that we only need to apply 1.

Thanks,
Ian

> > ---
> >  tools/perf/util/dwarf-aux.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> > index 336a3a183a78..bd7505812569 100644
> > --- a/tools/perf/util/dwarf-aux.h
> > +++ b/tools/perf/util/dwarf-aux.h
> > @@ -9,6 +9,7 @@
> >  #include <elfutils/libdw.h>
> >  #include <elfutils/libdwfl.h>
> >  #include <elfutils/version.h>
> > +#include <errno.h>
>
> Simple enough, thanks, applied to perf-tools/perf-tools.
>
> - Arnaldo
>
> >  struct strbuf;
> >
> > --
> > 2.34.1
> >

