Return-Path: <linux-kernel+bounces-522276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C278CA3C831
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0D8C1888272
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05011B87CC;
	Wed, 19 Feb 2025 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GuSu2DcH"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6691B6D17
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739991776; cv=none; b=CDiCVCReBpfXx7o4XIuS1z5mPMsqZo9CDKyDtxaXj1fco7OSx9hSWzaIVyh+GCASr0t8BXVKR9sVGFCzIYFXsibJ0i7KvlNMS6gKAUD9lZ87ocNts+/vPGkpoXq4m5nm8tiRAG0IllqhsJPlxvE4Ztk3L1lHx0WN43ciA8wYSV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739991776; c=relaxed/simple;
	bh=xqCqR/hufhb5P8/CLi7BzLgbexyw/GGhmOMSc6YxdVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=NHrZdJusmsL0UmYNQHCaMxYfaM+aluGXOd4o1xxmZUDpvuFd/pRGGQFIAWd4I9fRS1eGtveByiLRlH6vnuKE9nMwTzCf48CgPlqzEOg77G+GbSrOyklrktgwUwlUPf82vsfKBqbIFBsY1HmsboJiFAmkzFzYnpkoCdxuV8JWBp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GuSu2DcH; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d1925db9e7so14255ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739991773; x=1740596573; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqCqR/hufhb5P8/CLi7BzLgbexyw/GGhmOMSc6YxdVA=;
        b=GuSu2DcHnkPqOPuI51GdTuhRJWIOuRFR8z7JBtf+mrOCFAOKH+uurXURgXHI3tXEdo
         Rqu443aZNwn5GUz4h6jzokPcuBY5OFh3sjbpQCRLp97X2COi+q4I6F6eFd5DvFIJ0cnf
         GaEnZ8mbcEAgaPt7LvTzBfFHcb8t/tfNVe7dMOMswp/0gNtTN5O0XMX6QYAB4uSEuwRx
         FS1s1CppzNEOmsepLs3726/CPLAJgHukkuS/HkzZvrEApKRN2PAZtq1MhnhooI6D7Ehb
         nBmNP83ArDm2HxlR8HxaNlyp4QerB4N7a094IqBzap7wixOTkpf9e0FdSjPFAyGTRS94
         JKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739991773; x=1740596573;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqCqR/hufhb5P8/CLi7BzLgbexyw/GGhmOMSc6YxdVA=;
        b=hLuYL9R4HL6PClqwJw2V4mg4x0hp1OJJr7i6LZYKbY2hSWZ4xqw02m7FpE4FEdM3ko
         /TxaFyhY885ME57DfEXkIZkCvIXtOjsU7imyFuGX05tX6Mis6Q43Z/to8Yh6B6OFqJ7A
         mXi5W79QlnTRd2wgV/vObdClAiGTnQGHx/WOFNlt2pmUArgh6APJyRTKkR2fZI+w+ooa
         /tAj0Ui/g1HaUb2goPnoGyGHyM6FC07nXFpY+DCyAq+7bS0K1CT69zW1CyhTmpAhci2G
         HIq/I5zmB0FJ8jj8KQ+PfWlWnBHX3Dl0L36lu0AIq3mVY3iEIpm0h8Ah2RmjLrMDFtYp
         0raw==
X-Forwarded-Encrypted: i=1; AJvYcCVm2/0mzLOqOjEE2cf8INDv7nB17KP+Ch4+0+WDg16KHat6Y+NR2mW4vKUuGaSeZuJhHuSAC9ExRb8laJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze9s+iM8dMrCS/2vc/DG+cpYjRpRO60NN4rnaIGXAoDsGCo+8+
	SdVSvXpEYJaOeAaEDasB/VljG4rdZYsLxTbRgISSh20hNwTxsGv0z6+YhQoyP2UQ1eW1WuZ2alC
	kd0u2q5p8KGWdEZCq/kV3zox143FL2rc+1Rgj
X-Gm-Gg: ASbGncs2+2pDEzqYNJ6j7E2AiPSieADmwjiSR5C084DbBeb0CqtS3207LP1PtOQKGaO
	7sTAUyDwZ8vtguFfsWYzb9F2+Ajx4to9BqxVVAK33EoC1VxHlQ4pcWhlCM4QDW+LY5/aWRBecDt
	PEVSU+AGTu7rtaCr3/rnCiD7Bxbw==
X-Google-Smtp-Source: AGHT+IFTTa9BmF/cvrRnLMexuFSYqNhnGoLFlnoL7/Nc/YaDz0GVAvlFhZqtew98n6t59Vt1hUPih85IrbvbGbZZDxs=
X-Received: by 2002:a92:c56e:0:b0:3cf:fbc9:5c10 with SMTP id
 e9e14a558f8ab-3d2c0b75e6fmr148655ab.26.1739991773534; Wed, 19 Feb 2025
 11:02:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109175401.161340-1-irogers@google.com> <CAP-5=fWghT8+pBFVxn9JDbqHU9NPy9mgyT8Ee=pTdkCKxRoJgA@mail.gmail.com>
In-Reply-To: <CAP-5=fWghT8+pBFVxn9JDbqHU9NPy9mgyT8Ee=pTdkCKxRoJgA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Feb 2025 11:02:40 -0800
X-Gm-Features: AWEUYZkGjeOagc7NGuKyV-tf79xYdyrj45f5ezlrCbEQXR619UXdXuxCSPih_AY
Message-ID: <CAP-5=fWZAk7XqtL+=CanefkuFxhDsJ22+-uHkrxXi4g8123oew@mail.gmail.com>
Subject: Re: [PATCH v1] perf parse-events: Tidy name token matching
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 11:23=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Thu, Jan 9, 2025 at 9:54=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > Prior to commit 70c90e4a6b2f ("perf parse-events: Avoid scanning PMUs
> > before parsing") names (generally event names) excluded hyphen (minus)
> > symbols as the formation of legacy names with hyphens was handled in
> > the yacc code. That commit allowed hyphens supposedly making
> > name_minus unnecessary. However, changing name_minus to name has
> > issues in the term config tokens as then name ends up having priority
> > over numbers and name allows matching numbers since commit
> > 5ceb57990bf4 ("perf parse: Allow tracepoint names to start with digits
> > "). It is also permissable for a name to match with a colon (':') in
> > it when its in a config term list. To address this rename name_minus
> > to term_name, make the pattern match name's except for the colon, add
> > number matching into the config term region with a higher priority
> > than name matching. This addresses an inconsistency and allows greater
> > matching for names inside of term lists, for example, they may start
> > with a number.
> >
> > Rename name_tag to quoted_name and update comments and helper
> > functions to avoid str detecting quoted strings which was already done
> > by the lexer.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Ping. This patch addresses name parsing inconsistencies, in particular
> events may start with a number without a PMU, but not with. It also
> aims to give better names to patterns than name_minus and name_tag
> (with term_name and quoted_name respectively) that have drifted from
> their original meaning and become to me less than intention revealing.

Ping.

Thanks,
Ian

