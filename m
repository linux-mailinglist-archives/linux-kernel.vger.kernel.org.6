Return-Path: <linux-kernel+bounces-395627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB0C9BC0C6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D59BB20FFB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9AA1FCC6A;
	Mon,  4 Nov 2024 22:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h9/+Lsls"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB341D5CE7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 22:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730758844; cv=none; b=Vy1H2cDoqcw3oKuxxoanWnYka/88kh7m8DZwzZRWKly0BOpA+Vy/Zl9vCc9LKmmsEo2K4RlbyUMcQXnuQCJXpYWFvTooZP4BYl5YhiMm/FRrq+aywBVeo2l0o6aqCvYwt1smtolM9fTVrtPhiPIk/aRRYDLElApSsJKqbkid0Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730758844; c=relaxed/simple;
	bh=YtC1zPgY1CSZDUiukBIdLDlWX++MZpeTPyZCPXa85rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3gdpAxauNHXJBQKP5Iw6K8OimYzeOrn2MVgdExyvahxu4lWcByh5kBUodZJIhcHOKI7YeSiGN9Zx++L2CEWurkTT5aPzdRB3CCGqIlsImgsLI54VGCEZv67aRdNvk5d/FnAvRZfTokdMkiztXsRqEKOLV8qoeU/nCnBATkxU7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h9/+Lsls; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20ca4877690so15575ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 14:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730758842; x=1731363642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezu069EFwz2Tvc+ZJ6gG6EgI1srdu0M3gSI1AGlpaKg=;
        b=h9/+Lslsnuc1rsbuOrcvvPPQpfTClLifp8vvV9hRNszH+13w2mEkeUiNZJRC6RCklH
         dHgYRv/djL/sKsUH5+eePknLd+Rasd/VJ8JxK9f22utKlm01SK27p1BqB4L6LEVzHCva
         FlbezI10ikMbBEXSrqSaVUL/MawQ7QZXuk22go5qEx70of/dLDrV3ozRuHsFuTZIf1fp
         M9GePO/t2GXiaaPu5JG2rNt+tRP2wbNyxaXS/N3NeXNK9bjj+nNJH2xTpi0OBNfgFr0V
         N7SYcpSb4GYRi9KsqcOE45n5/9hOSbAFzH9OMDgHqhf4sVbgAYE7pY13aUeAAyPzK0gA
         6acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730758842; x=1731363642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezu069EFwz2Tvc+ZJ6gG6EgI1srdu0M3gSI1AGlpaKg=;
        b=QoJVO6KE6uj3uO1wu5bN5aegxFdcbGLjSk9UN7Jue1DmLjys9HNebC6HhHWesfp+lX
         F0pNo+PNeaUOcLvgk/eel8RrD4oMLkrVpHgL+klROo9jrxtkHX/a9JmM/cLjPOors6Ja
         /HvSfq+KGJmJXeB94WwdYZIxuSIQXq5IYEW00TLJ3BRytiwT0x4KDGWfuR8qmDZUuLNn
         BGgLieTwB0hvjFJR75MdEnA8XXCvGb9LIVa3DqCr/VzTwX7YvZczEwNJaAPBslVWEGNP
         uyiEz4GUZ8TnVWUAt4TnwYiF3qrRTGqP/U1ZmHUtTl12AujL+9qHLsV5AxqmEh+SGn9a
         XsNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXULCKGcXJxkg2JZEsfPyHiDQDJpZ1VJd2dQ6HaQksNDizViikaIYzg9xipFZfpUln/lxYJbrCtA3XuDng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV4oBr9g8Ec9+mAixh9hrYzSkF7bxGwkmpUhHBxvS0Q8frQduP
	w2rQMlBjFtU6kbGuCHq3qoZO3D6etJ+GbBigL9wnY5jLjDC6fjxftOwbze6jsfgAUHrLP5VvFX3
	grNG+QfzYM+8lJPn72f3u7uap7Mv9aCUWAzSj
X-Gm-Gg: ASbGncuOiRv9ChjrhxB8D01gwbsIzNna07t5ICx3g8PpWOybvCSS5ulAXjKzOREqwyI
	u0KX1NRT8NcUABKCUUnB3FSdkTs+VkjdU+BICOh2BN1TbtP+Xvij00mrS5dkyGTs=
X-Google-Smtp-Source: AGHT+IHx1BUa6dlZq5ClEuvGMRG28L4rSNnJktrt9z2YvZVUPM9PhUoKpEnE6UU2aAqiSFY7/NnFVOS4Ww51+uWcck8=
X-Received: by 2002:a17:902:c402:b0:20c:6c50:dc80 with SMTP id
 d9443c01a7336-2115f63dc88mr211675ad.9.1730758841928; Mon, 04 Nov 2024
 14:20:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031014252.753588-1-irogers@google.com> <20241031014252.753588-7-irogers@google.com>
 <ZyPX7ayIO4teziDX@x1> <CAP-5=fVgJu8BJWFVUkCy1Zsi3piTPdV-GXL1bTpWZeO=nm=jrg@mail.gmail.com>
 <Zykk2MJ4REGCaqVw@google.com> <CAP-5=fXQpej43wxEtMYFbxdofHtUi98X68W4AaR9UCfsbDir5A@mail.gmail.com>
 <ZykxD41c6gWQoIrQ@x1> <CAP-5=fWf8guTgqwfrrct3AGYDC=Lb1Oxo7kXU_x1yEr5urFSkQ@mail.gmail.com>
 <Zyk19KgzI7ybPkQ4@google.com> <CAP-5=fXj1-wqt+Bs-0ZypRsaZw2VP0qyKdeeRHpjUD5BwO9OBg@mail.gmail.com>
 <ZylGJF7Ux3JdJllo@google.com>
In-Reply-To: <ZylGJF7Ux3JdJllo@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Nov 2024 14:20:30 -0800
Message-ID: <CAP-5=fUz_LSJ4v4aaAWoLMQRXAtsqeQSjcyRun2kBVXUHTzvUA@mail.gmail.com>
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

On Mon, Nov 4, 2024 at 2:09=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Mon, Nov 04, 2024 at 01:06:35PM -0800, Ian Rogers wrote:
> > On Mon, Nov 4, 2024 at 1:00=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > On Mon, Nov 04, 2024 at 12:48:01PM -0800, Ian Rogers wrote:
> > > > Namhyung was asking that the c&p of code be 1 patch then "add new
> > > > changes like using openat() on top". That is:
> > > >
> > > > patch 1: add is_directory_at - introduce the 2 line helper function
> > > > patch 2: move the code
> > > > patch 3: update the code to use is_directory_at
> > > >
> > > > patch 2 is known broken as patch 3 is fixing it.
> > > >
> > > > Hopefully this is clear.
> > >
> > > Actually I don't care about the patch ordering.  My request is not
> > > to break build and just to separate different changes out. :)
> >
> > So, patch 2 can't be separated from patch 3 - are we agreed? So we
> > squash patch 2 with patch 3. Patch 1 is trivial and fails to meet the
> > bar of a meaningful change, so we squash that. We end up with this
> > patch. If there's a later revert and a dependence of the 2 liner, just
> > don't revert that part of the change. We've never had such a revert so
> > it is hard to see why we need to generate so much churn because of it.
>
> As I said the patch 1 should be the c&p and no need to introduce
> is_directory_at() before that.  Why not doing
>
>  patch1: move the code
>  patch2: add and use is_directory_at() + openat()
>
> ?

Because placing all the code in 1 file expands GCC's analysis and the
build fails. In the commit message I describe this:
"The arrays are warned about potential buffer overflows by GCC now
that all the code exists in a single C file."
A standard unsound workaround to this is to change "sizeof(...)" to
"sizeof(...) - 1", as it is ugly I added is_directory_at to not suffer
the problem as the arrays are gone.

Thanks,
Ian

