Return-Path: <linux-kernel+bounces-271670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64483945161
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25502286064
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995021B3733;
	Thu,  1 Aug 2024 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hT3jWjSa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD281EB4B1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722532781; cv=none; b=JeTFWgRL9TrlTbdRyIIfrCEtQ7p7qId7iggLc97dcPt/clqodvmfwfE0NxsQBYPkgXznUZSJVf/gEUBTVoVTagzx6FEDo5R6yd9DRwu58un5lj7x+iPjWeX1x1p6RufEEqgYl+ITPzZVt0ENjHporlDW6YtN5iEufiiVBRDuCeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722532781; c=relaxed/simple;
	bh=5hs7LtRK2Eil3q0D3xtVYy47x+GfdxXfXCC+og7NLbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdMhOGQjZqnFj399g6d+oty2L7qiO1GRDtF2yn2kQQXLYQ7soHb0utKFaBnMy59L6p6Zk1WKVsQOhiuzAXpU5YJlGH/gsRioihMKK6ndtUCnS/kwdJk+C7v0e3MKnOUECDxBL8wNaSc1PFQqTjdtWYySNOPOmO+4Aj8gz1sOsm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hT3jWjSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5DAC32786
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 17:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722532781;
	bh=5hs7LtRK2Eil3q0D3xtVYy47x+GfdxXfXCC+og7NLbU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hT3jWjSa41hbxScvNnE7mv9J1ke7+4X3JpmUCcfhz2SjAyXDOaZPCYQIiPgakkTTp
	 HpqcktSDvnzKElFsEZxGfsaWbnZdt8wA3E3JpBDTsXF92Jx+kIqjlamUSkuTRdDXVA
	 xUKSDGuyObBbDxgTEQGuVIhA/N96CMFD3ZJvxLKk/LbbYwOe0ZM/nvK6Ufrwj3QMAp
	 +jAhus/J+UYuzszTrqFqJ/uks1ttXppLvhX5PifISfKgAa3OQWLtTgj8JRj8Fz8n7a
	 MzWn+prTpZX/b7OJCo8IbuMZTe9CoqvfVV7zkBlA5eXFifiDkraHLR25kiKjvPFjQ8
	 atvkSzp9lMxDg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f040733086so83904121fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 10:19:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3PQfSs18L/DP61zYWPYOs3B5QJ1bTGDIZ26DkOzFgncK5wGccBIC0w2Mj0XoF9QG/elNGXmiprQ3Gkm/mTQ7zYy/488ONYsgF34Wv
X-Gm-Message-State: AOJu0YwwIp9Gn+94a+Y3DiEmQCZ4186WAQuy02L7O6UwH0/RIjJbdPW2
	iXdPWJRdhBbvknY4Ozzw6eoUw68fNwwn1V0mSC4Dus3ez2LcxHnJ0/ztkCwA5fi3nIBG1zOTY/P
	wwRSf9Ln++AB7I5yf/ZHFmH8D2A==
X-Google-Smtp-Source: AGHT+IGEXIEOAIvfi5QgIqq+O+OnhdvJLGjZ3UQWjuGxfLJmMiA52UnYerCA/UZaAuNM9jSzAeI8C3V2Pt2xpMHJRCc=
X-Received: by 2002:a2e:8456:0:b0:2ef:286e:ca68 with SMTP id
 38308e7fff4ca-2f15aac2b49mr6681601fa.23.1722532779747; Thu, 01 Aug 2024
 10:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710182357.3701635-1-robh@kernel.org> <20240801112923.GA4476@willie-the-truck>
In-Reply-To: <20240801112923.GA4476@willie-the-truck>
From: Rob Herring <robh@kernel.org>
Date: Thu, 1 Aug 2024 11:19:26 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+YoHYyUF25aD6ACbiUj3+M2c4uH5tWGB+u12AiCp6fGg@mail.gmail.com>
Message-ID: <CAL_Jsq+YoHYyUF25aD6ACbiUj3+M2c4uH5tWGB+u12AiCp6fGg@mail.gmail.com>
Subject: Re: [PATCH] perf: arm_pmuv3: Fix chained event check for cycle counter
To: Will Deacon <will@kernel.org>, catalin.marinas@arm.com
Cc: Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 5:29=E2=80=AFAM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Jul 10, 2024 at 12:23:56PM -0600, Rob Herring (Arm) wrote:
> > Since commit b7e89b0f5bd7 ("perf: arm_pmu: Remove event index to
> > counter remapping"), armv8pmu_event_is_chained() is incorrectly
> > returning that the cycle counter is chained, but the cycle counter has
> > always been 64-bit. The result is trying to configure counter #30 which
> > typically doesn't exist.
> >
> > As ARMV8_PMU_MAX_GENERAL_COUNTERS is the number of counters (31), the
> > comparison to the counter index needs to be '<' rather than '<=3D'.
> >
> > Fixes: b7e89b0f5bd7 ("perf: arm_pmu: Remove event index to counter rema=
pping")
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  drivers/perf/arm_pmuv3.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> > index 3b3a3334cc3f..0e22c68fb804 100644
> > --- a/drivers/perf/arm_pmuv3.c
> > +++ b/drivers/perf/arm_pmuv3.c
> > @@ -482,7 +482,7 @@ static bool armv8pmu_event_is_chained(struct perf_e=
vent *event)
> >       return !armv8pmu_event_has_user_read(event) &&
> >              armv8pmu_event_is_64bit(event) &&
> >              !armv8pmu_has_long_event(cpu_pmu) &&
> > -            (idx <=3D ARMV8_PMU_MAX_GENERAL_COUNTERS);
> > +            (idx < ARMV8_PMU_MAX_GENERAL_COUNTERS);
> >  }
>
> Acked-by: Will Deacon <will@kernel.org>
>
> Catalin -- please can you pick this up as a fix?

No, this is the fix for what Will dropped and said to resend on the
v9.4 fixed instruction counter series. Here's the series with the fix
in it[1].

Rob

[1] https://lore.kernel.org/all/20240731-arm-pmu-3-9-icntr-v3-0-280a8d7ff46=
5@kernel.org/

