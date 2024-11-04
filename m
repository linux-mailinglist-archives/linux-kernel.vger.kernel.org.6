Return-Path: <linux-kernel+bounces-395504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E239BBED2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63DC4283055
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639971F5849;
	Mon,  4 Nov 2024 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SX5sEeHz"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4260E1F5845
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 20:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752501; cv=none; b=AcyaAhq+ZNgmXryQLxX/vcchvYE1LPKUhY7yW1i2fEA2qi0zPSb1/T1K9XaX7arHhbymdflGONJiM39JRr7Bd7hv2IiVOWvJ0TI94XL+WFWsXXjWoU/zOWLqTa2i/hzh+vqMmp72/oGcDnoEyot2VsogWBdCdTVpESMwhqEQ4+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752501; c=relaxed/simple;
	bh=fCXm53AZpLvD3mlG5kaIz/uCWSEGjcylvGsCkXzMLrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTXha5K1xyySQf3IIsAFZn+aADjVeIupkRFKS4mUlIHf+Eqv9CRFcmBJLXrLZVU2eMiWqwAAZ99+BloYqS8ivNPBgp/1da0kauO6hGfTVAnkA5YmrZ32gZELAnJmD+TB1gnmPnIUKoYmw6htw99YIxNMFmqkDS1omrsGr5BwV4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SX5sEeHz; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a4e4776f79so29645ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 12:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730752499; x=1731357299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTtHTuauzkyyFaQ5FOERKTQGUplDXz7vVkQVmXIkb2o=;
        b=SX5sEeHz1a5qcc8B1kpCYbJuLVH9cymsFjoIIl53YcwGm+gm7sKBr2d+27Pn//50oi
         6sjUcNW95hjlivMOEV66hAznYcSF7SS04Ga/6ALGpxYyCwB0WOuH9XfSdeD1NCiQeahz
         g/G3ZGRrbuzOhImtGeDmLDGw8+HcOlpNKEXF0EF760qP5N881eNbMxbuuo0MNaUWght1
         InjVdy4rUFid4dM+JFRt5kulK4XYAhMU0VYw55lxecG+2CfBtR8b0JBKT7g4vhxBvvpU
         wyce1SKul8O/mlE+PPW8mMAt4j+XzCu3FtJQQ45nWMwGk+bmLOpxIGC6DAa3yQkZM1EJ
         S+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730752499; x=1731357299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTtHTuauzkyyFaQ5FOERKTQGUplDXz7vVkQVmXIkb2o=;
        b=ZGNG5EbBu3R3ZmWiXUfHE5rLfoeYKsZp4ulGj2zmqgMxkx0NlT0d70816c9oYhZTR7
         8/0z2YVEQnFUPTNTtxzxe/yA7cLFYw4DSr/f6KwEOYEop7QEGNq3VfXZh+/gXHiipzq0
         wG0Ve+oEgKWtFZ+ZKfC7j3HY245Um5XGVB/jUOXxNC/egt5b8sVgnQwFH5lfCvAzyjY+
         KU3M4IzuhMOivoIEdHzWCRpdnuavxX/O66wrq0LhM9cvzF9y0RPmAvyrty7oGSrJcbiw
         Uu3cfEtBS+8SNjEpost0bpBv9/qssQbXGEwpNvoWdQWoe7b125n+h1Zs5z574unb+61D
         jqNA==
X-Forwarded-Encrypted: i=1; AJvYcCXW1yZHjedlK3w7ttu/u7aZDftNTDMr0EW0VL68LkmlOQExCYXqmtOICkhDJym8XIeHV2XsptBaPMSVl+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVREZkVHccEktXSIhfsMaUEM4qwVK+RlgnDjWlWBpGXmEYOCsl
	j7ApVuCO4nq0iCHod30HCwXBKUL2JlV2LGbmDsw6ONF11Z/LzeEtbW7zqdXiCQmEX+PFis8O1cg
	IQX8b3gNDc4ZlP1VlT/TzOM9E1D2H3cGIJBfz
X-Gm-Gg: ASbGncuAyr8/y4nVJpgeUERZrX3fpmF2SxWspeXXPtkNA2UTprTs40mrrGPtqSFZJNu
	NgsqDJpqabE3CrJYqyY2kaxYcuCd0Uirp4Hu7NgAk/6L9r50SLmQDJI/mgsNguA==
X-Google-Smtp-Source: AGHT+IF2RG8jMIhbr3G3wIVER0dIaBDxrGWf6Ov4CTuuI8RTqGpMnA/hqfSnwPEmDAXRhsf/y2Q0ha81fWR+0ujBjJg=
X-Received: by 2002:a05:6e02:1a87:b0:3a4:d2ba:2011 with SMTP id
 e9e14a558f8ab-3a6da8bd59bmr676595ab.0.1730752499214; Mon, 04 Nov 2024
 12:34:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031014252.753588-1-irogers@google.com> <20241031014252.753588-7-irogers@google.com>
 <ZyPX7ayIO4teziDX@x1> <CAP-5=fVgJu8BJWFVUkCy1Zsi3piTPdV-GXL1bTpWZeO=nm=jrg@mail.gmail.com>
 <Zykk2MJ4REGCaqVw@google.com>
In-Reply-To: <Zykk2MJ4REGCaqVw@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Nov 2024 12:34:47 -0800
Message-ID: <CAP-5=fXQpej43wxEtMYFbxdofHtUi98X68W4AaR9UCfsbDir5A@mail.gmail.com>
Subject: Re: [PATCH v5 06/21] perf script: Move find_scripts to browser/scripts.c
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
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

On Mon, Nov 4, 2024 at 11:47=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Oct 31, 2024 at 01:51:36PM -0700, Ian Rogers wrote:
> > On Thu, Oct 31, 2024 at 12:18=E2=80=AFPM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Wed, Oct 30, 2024 at 06:42:37PM -0700, Ian Rogers wrote:
> > > > The only use of find_scripts is in browser/scripts.c but the
> > > > definition in builtin causes linking problems requiring a stub in
> > > > python.c. Move the function to allow the stub to be removed.
> > > >
> > > > Rewrite the directory iteration to use openat so that large charact=
er
> > > > arrays aren't needed. The arrays are warned about potential buffer
> > > > overflows by GCC now that all the code exists in a single C file.
> > >
> > > Introducing is_directory_at() should be done as a prep patch, as the
> > > rest of the patch below could end up being reverted after some other
> > > patch used it, making the process more difficult.
> > >
> > > I mentioned cases like this in the past, so doing it again just for t=
he
> > > record.
> >
> > This is highlighted in the commit message:
> > ```
> > Rewrite the directory iteration to use openat so that large character
> > arrays aren't needed. The arrays are warned about potential buffer
> > overflows by GCC now that all the code exists in a single C file.
> > ```
> > so without the change the code wouldn't build. The new is_directory_at
> > function is effectively 2 statements fstatat and S_ISDIR on the
> > result, it is put next to is_directory for consistency but could have
> > been a static function in the only C file to use it.
> >
> > For the record, patches introducing 2 line long functions can be
> > excessively noisy, especially in a 21 patch series. There is always
> > the declared but not used build error to worry about - here things
> > couldn't just be simply moved due to triggering a different build
> > error. Given the simplicity of the function here I made a decision not
> > to split up the work - the commit message would likely be longer than
> > the function. The work never intended to introduce is_directory_at but
> > was forced into it through a desire not to disable compiler warnings.
>
> This patch does more than just moving the code which can be easy to miss
> something in the middle.  I think you can move the code as is without
> introducing build errors and then add new changes like using openat() on
> top (you may separate the change out of this series).  I think it's
> ok to have a small change if it clearly has different semantics.

If you are trying to bisect to find something that broke a build,
having commits that knowingly break the build will cause the bisect to
fail. The bisect will falsely fail on the known to be broken commit.
It should be unacceptable to knowingly break the build in a commit for
this reason.

Thanks,
Ian

