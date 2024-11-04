Return-Path: <linux-kernel+bounces-395516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D7E9BBEFE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3811F230D5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058931F7090;
	Mon,  4 Nov 2024 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hqy5e6HO"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB1519F42F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730753296; cv=none; b=cP1mq0vZwvYQmMeTaRuPBPBYukeIDTVOLeiyg5ZDAzp5IFd7zuVShXeQsOewVwQ8Rn+BBVvwr4wd5iT4NK2XuDSIAqUzXgFRQlz58Msmde6kJMXlXeaTmUEPRq7PXuJJpK/irhOhZSIJnnUEdQpPxcPFkfZvIWrO+b/zCxCPf7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730753296; c=relaxed/simple;
	bh=9aJWFFSW3++0fcYdHxr48Xl66D06TUo0DPDdjE5TeyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KoOAJZ9N7KfbaRcwQLvH4GE08yA8XoVzB/3KzM5HnlSji00d5HTpgeCiJI1J1WJ1JUno6xn1jx+UFaEV25wsInHwqxYywqekvnYz8fIRgL/sh9SiHY3eECUmWvGRc2blpJf0+UZHwR9FtyxrVMilc1pVNdl+z4zhOEPNUOfXgLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hqy5e6HO; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so8235ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 12:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730753294; x=1731358094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQrwd2M+bByYwaPmhFd+hKbI2aI8cuthGBmi+PJaIfg=;
        b=Hqy5e6HOAsFPeKROkXwtIRidruMB+xKI79JU/5yV7FZRYpa5woH76/AkFqHKWsDc+3
         gEidCyB/tJDdrwht5wmWNJGsHc/EF9LAAd/apooMWdm9sMyURrjkGh42sGvPZM9rEFeY
         KVKrZIo4ifHUmV7mc44Yl1DzGGXb6Gs/pXlh8CBatHD9cniSIlydbaA1hVzQjm2UyYwB
         zxaVeKz+sH2BzVpPXhx7TlfA26IbIiV6bSRd5dgcYFqm+1mYCLLfw9wkXOKY/ZX96Zry
         Y+n7yx6xSRzk47alFio0siI9MPVz0XThoHt2ostZCZw8Nfs7iJVp+YM/wm9xji6+tbTK
         NKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730753294; x=1731358094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQrwd2M+bByYwaPmhFd+hKbI2aI8cuthGBmi+PJaIfg=;
        b=ojomhhX0NqqFZcMG0EVj4aP0sh0MF38iAS28KfRIlME/+G1nfP4r1ws1kiPoS7RiaS
         r80VJhDpz3CBciwRz+YD7T6eAWAp8rZJamRmOg5q1kfBaEcpYH1NB84TJzJcOAXh4RNK
         8V+nzypVLtqmufxnwXed0acYnMykUmsm9GxPQY4+hzK3FU/TMr8YxvtMQhDVDOcYKnb+
         R5M3a4Hp16g5BvfMiCh6WhRNA/olx+cyfpbfqcxoJqU63HtemhVUKqmbkqyNiPooUhxN
         TD73hwJi2HZJcXUwXVsh0a+Zs3I0D+afnq1wj41UzAYxh1kSsQDg626N+nYvKtyjaRQ0
         Pugg==
X-Forwarded-Encrypted: i=1; AJvYcCW7skxT0oetvS6Hle2e9RYnd/tYEyPHlFJPdUgZHLCfnbuOKrQUTXyEAU+xS35AG5HN2AcGKATWy5SxLdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnwkyDVnNT9P6wYWgO7+U5APmVHIg2kgmfdbo0vM8QyDQX53pj
	GtZ+ubGCEZMg7TfAdPtKWwYoTfheUle+ywYYS0B37XWMSZlRgLi1uh4ygE37HOU65wcUNtDT5Pz
	BKFKTFu1qnleOz0r6uiHaa2WkwXqGcfVmluDj
X-Gm-Gg: ASbGnctM+GBRDqEiFr2pfgA8zhrnzqIp4vv0YEhGEYOr55T9KxuLW5AjeVsm8jPSNPb
	10gP9LOuErD7w4i+Qtrqya7FLlhJrpkhrxS9F/zpm+wsap3sh9/N1AcjLj3Oe1w==
X-Google-Smtp-Source: AGHT+IEcvyrhsNmSCfDoQdRhpKhe+RRessbk74R641XcJIjVxaTYakqoztiVG1s3RLEv6Vw6oMY7wkwBV5cdBrEhT7I=
X-Received: by 2002:a05:6e02:20ce:b0:3a6:b8f5:7166 with SMTP id
 e9e14a558f8ab-3a6da957881mr784505ab.12.1730753293845; Mon, 04 Nov 2024
 12:48:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031014252.753588-1-irogers@google.com> <20241031014252.753588-7-irogers@google.com>
 <ZyPX7ayIO4teziDX@x1> <CAP-5=fVgJu8BJWFVUkCy1Zsi3piTPdV-GXL1bTpWZeO=nm=jrg@mail.gmail.com>
 <Zykk2MJ4REGCaqVw@google.com> <CAP-5=fXQpej43wxEtMYFbxdofHtUi98X68W4AaR9UCfsbDir5A@mail.gmail.com>
 <ZykxD41c6gWQoIrQ@x1>
In-Reply-To: <ZykxD41c6gWQoIrQ@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Nov 2024 12:48:01 -0800
Message-ID: <CAP-5=fWf8guTgqwfrrct3AGYDC=Lb1Oxo7kXU_x1yEr5urFSkQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/21] perf script: Move find_scripts to browser/scripts.c
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 12:39=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Nov 04, 2024 at 12:34:47PM -0800, Ian Rogers wrote:
> > On Mon, Nov 4, 2024 at 11:47=E2=80=AFAM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Thu, Oct 31, 2024 at 01:51:36PM -0700, Ian Rogers wrote:
> > > > On Thu, Oct 31, 2024 at 12:18=E2=80=AFPM Arnaldo Carvalho de Melo
> > > > <acme@kernel.org> wrote:
> > > > >
> > > > > On Wed, Oct 30, 2024 at 06:42:37PM -0700, Ian Rogers wrote:
> > > > > > The only use of find_scripts is in browser/scripts.c but the
> > > > > > definition in builtin causes linking problems requiring a stub =
in
> > > > > > python.c. Move the function to allow the stub to be removed.
> > > > > >
> > > > > > Rewrite the directory iteration to use openat so that large cha=
racter
> > > > > > arrays aren't needed. The arrays are warned about potential buf=
fer
> > > > > > overflows by GCC now that all the code exists in a single C fil=
e.
> > > > >
> > > > > Introducing is_directory_at() should be done as a prep patch, as =
the
> > > > > rest of the patch below could end up being reverted after some ot=
her
> > > > > patch used it, making the process more difficult.
> > > > >
> > > > > I mentioned cases like this in the past, so doing it again just f=
or the
> > > > > record.
> > > >
> > > > This is highlighted in the commit message:
> > > > ```
> > > > Rewrite the directory iteration to use openat so that large charact=
er
> > > > arrays aren't needed. The arrays are warned about potential buffer
> > > > overflows by GCC now that all the code exists in a single C file.
> > > > ```
> > > > so without the change the code wouldn't build. The new is_directory=
_at
> > > > function is effectively 2 statements fstatat and S_ISDIR on the
> > > > result, it is put next to is_directory for consistency but could ha=
ve
> > > > been a static function in the only C file to use it.
> > > >
> > > > For the record, patches introducing 2 line long functions can be
> > > > excessively noisy, especially in a 21 patch series. There is always
> > > > the declared but not used build error to worry about - here things
> > > > couldn't just be simply moved due to triggering a different build
> > > > error. Given the simplicity of the function here I made a decision =
not
> > > > to split up the work - the commit message would likely be longer th=
an
> > > > the function. The work never intended to introduce is_directory_at =
but
> > > > was forced into it through a desire not to disable compiler warning=
s.
> > >
> > > This patch does more than just moving the code which can be easy to m=
iss
> > > something in the middle.  I think you can move the code as is without
> > > introducing build errors and then add new changes like using openat()=
 on
> > > top (you may separate the change out of this series).  I think it's
> > > ok to have a small change if it clearly has different semantics.
> >
> > If you are trying to bisect to find something that broke a build,
> > having commits that knowingly break the build will cause the bisect to
> > fail. The bisect will falsely fail on the known to be broken commit.
>
> I'm not understanding, AFAIK nobody is advocating for breaking
> bisection, just to first instroduce a function, then use it to avoid:
>
> 1) Introduce function foo() and use it for feature bar()
> 2) Somebody else uses function foo()
> 3) We find a justification to revert 1) but can't, since it will break
>    2) so we need to add 4) that removes bar() from 1).

Namhyung was asking that the c&p of code be 1 patch then "add new
changes like using openat() on top". That is:

patch 1: add is_directory_at - introduce the 2 line helper function
patch 2: move the code
patch 3: update the code to use is_directory_at

patch 2 is known broken as patch 3 is fixing it.

Hopefully this is clear.

Thanks,
Ian


>
> > It should be unacceptable to knowingly break the build in a commit for
> > this reason.
> >
> > Thanks,
> > Ian

