Return-Path: <linux-kernel+bounces-276516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C25D19494EB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6BB6B2A968
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D37381AA;
	Tue,  6 Aug 2024 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cjWrwhOM"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5243B7AC
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959416; cv=none; b=gp1bxprVAlujAwiQQfUtXQUDh+R5STOl62L3dv4n8aZuaCI5FU8KCTjEIcOWuxTdaj4mqA01usUtF83++bFSfHsyIaFaYUA03LiECokRLQQZBeoJeOz/KbNx+nMC5D4Zu7kFASB0u2W3fqeOv9ApVAw+S62upparGip0xzwNlxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959416; c=relaxed/simple;
	bh=8F/sdfwOgYrozXSYzhW6xlVGWL5FX8sCck7YmA7e/mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZfehEmKOKD/duC3WJA1heWfgqWMogflIYGNGey1jiNYyt/l+CvOngYSQtI7Nx852yua95YIblZZk2uLGx4IyOuLOrD/yy/is5qZfE93OBKuHsjsxMXkupYfJ3PLhYUGdFFkioh1DhuRMVSi0zcLgT/GQYfWm3lOQek6EKxThyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=cjWrwhOM; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f01e9f53e3so12938791fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 08:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1722959413; x=1723564213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8F/sdfwOgYrozXSYzhW6xlVGWL5FX8sCck7YmA7e/mo=;
        b=cjWrwhOMAHiYkbqzY2U3HTQZbQXR7v6c9JBKTRVXLqYZTtEMK9BWjixQ656rZ7o6wa
         sccPWl/5xqcNGBR2tJ+Ha4cvuBqbVfQlYqCKC5Ux5TOWirR80KnwsV6exc2PL6eVdawX
         oy0gIpyucHMe/F1B/OPbgvyXQqMuH2RdM8Wdb66yUclOlEN1q3DAxn5p2rm+HhaxjHvN
         m1C0bV3uCRHiGcegXcn2n74IOIDwx74zVDfci6YjBzpRnDx8cG7oF1qWAGzQYc1aPTcp
         h56LVugsqWDzs1W1v4tSQmwhllOky/4Leg4Hw9nqUowgq4ZDMNCBo9uL1jJiNXclIhpB
         rC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722959413; x=1723564213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8F/sdfwOgYrozXSYzhW6xlVGWL5FX8sCck7YmA7e/mo=;
        b=THERDNjzEQzheYoHXWRUGJm6f9K4MW3aN3by/TFkbycC9IUKK1SrXbQSti1HPjmkwa
         twGNhvHay5kiWLHRTXhwdDLpwaITZwnB2Fwoo7NEy4rizjqjz6897aLxE7EXkDs8sUI4
         SgtqnJ/OsSPo+/mPAk0dJR0YGZer+JQMj/rs58+n2RXRRqvTptFkxjB03Y1mGNNb3Gsg
         As26rmcezSJwC2pU7JX4JS/jpsSPMWRG50I8x+M4i5TeTaPrbGkDjU7eju5hKjI/FZHw
         X5tFC1k5X5At1S6dpYAliMyEoTP80i7500MRcYS64QoJaWST0NSev9ONR4M0sV6xLFon
         f8FA==
X-Forwarded-Encrypted: i=1; AJvYcCVqbMQNNfWQFsBkfsDXM1ctXTTIZmLWjQOO5tG027ZrTnsD/ZV6T8CYKjt69KElrr5uOhaDhkP6BgFcnpEmcZDn1jZjvOiPY5Q5Hs/v
X-Gm-Message-State: AOJu0YwUhexXkkioeZJy0Cjt6jr3y5CxxlEUQoEXsoKZow9eFx4IOpLz
	u0O26sSoRsEC2vCaMkSoHAik2+fcnqswHSS36VLOAb8L2HR/JiVjYzkQJnV7uHkUhSeSlHAl7Zm
	DtESMToqBqEmMEMXNPAmwe9hRcEZbANpoG0vtuQ==
X-Google-Smtp-Source: AGHT+IEKRNQL6v8yZxwZiugCHsLJCc91BgG6XIW8t6WKvKDPtqvKAcvwQ3Mf0Z6iVsyMeVqV3TUGbDZ5W+id3C9qS34=
X-Received: by 2002:a2e:9ed3:0:b0:2ef:17ee:62a2 with SMTP id
 38308e7fff4ca-2f15aaab018mr133316761fa.14.1722959412812; Tue, 06 Aug 2024
 08:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805194424.597244-1-irogers@google.com> <20240805194424.597244-4-irogers@google.com>
 <CAPqJEFpiy307B4OBHK4WJGjgbVm_woUrdZ+Vy_LSdQ=ECqZX-Q@mail.gmail.com>
 <CAP-5=fWDmdAkJSoncedZTaSgFwG+p3--jywDj9krnXSfkhh6dQ@mail.gmail.com>
 <ZrInOywRKzRmjtKF@x1> <ZrIqR07cYJnhcTq8@x1>
In-Reply-To: <ZrIqR07cYJnhcTq8@x1>
From: Eric Lin <eric.lin@sifive.com>
Date: Tue, 6 Aug 2024 23:50:01 +0800
Message-ID: <CAPqJEFoFfCG0_fqkVqakUK7CWs_8WREpmAd+f3H26UasGRPz2Q@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] perf pmu-events: Remove duplicated riscv firmware event
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Samuel Holland <samuel.holland@sifive.com>, Charles Ci-Jyun Wu <dminus@andestech.com>, 
	Locus Wei-Han Chen <locus84@andestech.com>, Atish Patra <atishp@rivosinc.com>, 
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, Guilherme Amadio <amadio@gentoo.org>, 
	Changbin Du <changbin.du@huawei.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, vincent.chen@sifive.com, 
	greentime.hu@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Tue, Aug 6, 2024 at 9:51=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Tue, Aug 06, 2024 at 10:38:07AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, Aug 05, 2024 at 09:05:26PM -0700, Ian Rogers wrote:
> > > On Mon, Aug 5, 2024 at 8:54=E2=80=AFPM Eric Lin <eric.lin@sifive.com>=
 wrote:
> > > >
> > > > Hi Ian,
> > > >
> > > > I've sent a patch to fix it and the patch already merged. Thanks.
>
> Also, already merged where? Upstream? In the riscv kernel tree? where?
>

The patch already merged to Linux upstream:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D63ba5b0fb4f54db256ec43b3062b2606b383055d

Thanks.

Best regards,
Eric Lin

> - Arnaldo
>
> > > > https://lore.kernel.org/all/20240719115018.27356-1-eric.lin@sifive.=
com/
> > >
> > > Hi Eric/Arnaldo,
> > >
> > > Right, I already commented this should have gone through the
> > > perf-tools-next tree:
> > > https://lore.kernel.org/all/CAP-5=3DfV3NXkKsCP1WH0_qLRNpL+WuP8S3h1=3D=
cHaUMH5MFkVHQg@mail.gmail.com/
> > > Arnaldo, please take Eric's patch in preference to this one.
> >
> > So I removed your version from perf-tools-next, eventually we'll get
> > this merged upstream, I'm just checking this isn't going to get in our
> > way of testing what we have in perf-tools-next...
> >
> >
> > - Arnaldo

