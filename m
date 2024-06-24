Return-Path: <linux-kernel+bounces-227883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7529157AE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7D31C225BE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E283A1A01B7;
	Mon, 24 Jun 2024 20:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FibGNk3b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29192FBEF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 20:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719260063; cv=none; b=JQjMr6Nb9N10xfZEItXWRaGWytar74HpL1SwtWUPcKlp9VPQuI5XJsCGJjJnDsF7TIRYfFSGlALAKia69tXWKCiikzn6433EIsKQzcna6XERnwjDWMrpDuFdXtWlaGga9KrwtJiAJO9t591TMDZFcpW3R2sB6EjoU4tkEzTYv8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719260063; c=relaxed/simple;
	bh=+T0EC+BKMDCsEfLu0EC918+5a958Z0xU9XA+x12y4X4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dp2h3133wqjzXZQw5yu0KacBFEogkvKNh8DXGTVQ+Owe5E0xy1MOK9NrDA89AFy6VjmTsmyXUI6ie4WARn9ophtCVDDEE558yIDVBnt/44enBYBM7Vf+z728b7wQsxklow/pWAnqn3SgL4EXRmExTZ8aY/+cpXny7FQCd6a3mwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FibGNk3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A17C4AF0A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 20:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719260062;
	bh=+T0EC+BKMDCsEfLu0EC918+5a958Z0xU9XA+x12y4X4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FibGNk3b2bUqC1f8zvTTFZYw0VManLnp29Jx1O6va2p7l+FJQ5cuzDKqin4ClBJ3H
	 xjskbMaGb9uH7J/OrWUD1DFzPk8vY54DS439q1jnZSd4tbdtSBYzCIUSlPjrXet/G3
	 QRuDuj4Qs9Hw+U8J1xpoRq8+X8RAcQ3QSolfsPpJ4WAIRPr/LstsoBudDeUoriABWU
	 YySUNxYitYAWHpI8YpfQ6tyGp3ksiKX3SXlySeIk/07XhjIWvVIvtA0YFejI9v4Rw/
	 uuS28X1yNP6iFzHLfyA2JjoymJXgAcHhYFJvXLeTPgMPXJ0iEwQAgBn9k3OeyA8QQb
	 oyk2IVPX058AA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so55216101fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:14:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMBNQuW6o0l7SdwldRBmU2VE361rR7PW0nM+SiaRpObvYhe7TEaegxZoYLcvrBn1FRRe8zdhADKJkB7+5e1VhM7GqnjF4QQQmXwU5I
X-Gm-Message-State: AOJu0YyQ82bn9qV6RARHMhvNtGzFhpsT1reUQD0e/fwnu65bSf6pPQ+o
	fr1ZEeUiKsIoJq7uL0ZUboORVt0JhlPcPvPY8Vlmv7V5Hv1/ju2Ot9rUpJu9d8qhF0QGZjZHeOY
	JJHhNUaD0hNGN7L0exbeh7P1JIA==
X-Google-Smtp-Source: AGHT+IGCThMCqv0QdDLhB3+rM3hc+kx0hOPXWMbQFGNrbXIWQLJ1n1x+2xafjuOiPqLi00MvzHiFOn8ELjn/Yj/6k54=
X-Received: by 2002:a2e:9cc8:0:b0:2ec:3fb8:6a91 with SMTP id
 38308e7fff4ca-2ec5797a562mr43562221fa.19.1719260061029; Mon, 24 Jun 2024
 13:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611155012.2286044-1-robh@kernel.org> <20240618154102.GD2354@willie-the-truck>
In-Reply-To: <20240618154102.GD2354@willie-the-truck>
From: Rob Herring <robh@kernel.org>
Date: Mon, 24 Jun 2024 14:14:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJaavfSUGLs4Uoi7ibiYG6=ebzRsUnzdNMU9vo70FA-Xw@mail.gmail.com>
Message-ID: <CAL_JsqJaavfSUGLs4Uoi7ibiYG6=ebzRsUnzdNMU9vo70FA-Xw@mail.gmail.com>
Subject: Re: [PATCH] perf: arm_pmuv3: Avoid assigning fixed cycle counter with threshold
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, James Clark <james.clark@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 9:41=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Tue, Jun 11, 2024 at 09:50:12AM -0600, Rob Herring (Arm) wrote:
> > If the user has requested a counting threshold for the CPU cycles event=
,
> > then the fixed cycle counter can't be assigned as it lacks threshold
> > support. Currently, the thresholds will work or not randomly depending
> > on which counter the event is assigned.
> >
> > While using thresholds for CPU cycles doesn't make much sense, it can b=
e
> > useful for testing purposes.
> >
> > Fixes: 816c26754447 ("arm64: perf: Add support for event counting thres=
hold")
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  drivers/perf/arm_pmuv3.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> > index 23fa6c5da82c..2612be29ee23 100644
> > --- a/drivers/perf/arm_pmuv3.c
> > +++ b/drivers/perf/arm_pmuv3.c
> > @@ -939,9 +939,10 @@ static int armv8pmu_get_event_idx(struct pmu_hw_ev=
ents *cpuc,
> >       struct arm_pmu *cpu_pmu =3D to_arm_pmu(event->pmu);
> >       struct hw_perf_event *hwc =3D &event->hw;
> >       unsigned long evtype =3D hwc->config_base & ARMV8_PMU_EVTYPE_EVEN=
T;
> > +     bool has_threshold =3D !!(hwc->config_base & ARMV8_PMU_EVTYPE_TH)=
;
>
> Just a nit, but I don't think you need the '!!' here.

Right, I guess since bool is a first class type in C9X we don't have
to worry about truncation. Old habits...

Rob

