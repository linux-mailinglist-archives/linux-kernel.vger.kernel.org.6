Return-Path: <linux-kernel+bounces-401094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E679C15E6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 06:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09E92833AD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FDA1C3F00;
	Fri,  8 Nov 2024 05:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yeVXzoWg"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1686680C0C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 05:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731042609; cv=none; b=DJ9jLeUIbO1RG6AfDJhi00TcFF1S6adLIY5xciZuAo0+a0zoYHlm+SDezn/9CB7vLo6Pu2xwWa06p401hGaClvscqAmseHoJc/8a4TZnQ8a3kNFuJHzqblfnUKW9bJPvj+eR97ng2/fEUQlFbGChuBt2ON1RKiXmOgjCktj//48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731042609; c=relaxed/simple;
	bh=6Uwenx1zk1vdZVl3Baq7wuOMFnGkdZE4mXir7DsLKgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DH6vtOpqIE4wfsYmDBfhOKY2NiM+aVEa5FOYXrss2xEv5TeXCvUz3MppJJ9sP9NcD9Qcz/ztkyhAnn3V3fuuQdl+Ez9WLDBjOGRhq+SKPvDpjuAxM2gbORWyp99hvtscNZJ/dNF3bvajfdK9PT1SIfLetuaub5dl3pGaznCEmME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yeVXzoWg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4319399a411so15838275e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 21:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731042606; x=1731647406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCTltMBUOe3yPWk3k2ae1sCDON4I33qScm5ujUxlfMY=;
        b=yeVXzoWgLtRqlbcJQHmi0tFtulZYD2ZuNo+6tHZuKEBFVGSEXYhDLsmgYA481NQaZp
         CMEl1S/AkkUAMHMDl2z+WLT03VmIfcBf7B/AOqHae/jKHu2li55ISMH1homgQS7lZTp5
         g0JvF7BmU3F55Q6tL0icutwJ1y5yPz7QmOifmyeZT0q4foOH/5vVOG/zRZXceaYM6m2N
         ICeudYXUSQNST1Z7Ov+ee2kEFO+Ipe5+R3buhfjCBH8Mu/jD71rVJyNaOLDyWfySlqjx
         oYvU85/qs5MllZaJEtdrpyQM7PHvPflVOirup+gjF9vIBdHi8he3TaDat55SNI2y/acW
         sdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731042606; x=1731647406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCTltMBUOe3yPWk3k2ae1sCDON4I33qScm5ujUxlfMY=;
        b=qsQug05NltSVT1k6rF504VetmB3Ex4m/bSGhCUBUSaUg0KwLkVCw4EjroAb1lg/myg
         k7xU2DYxixfQHdeXXZneomqxAXt85I6fAJFeNaXbbBr4Xg3sXWijjPgNivue+IE89lXO
         1Tb3RDbpdfNDRyS42jVPWHVBqhHluuzn7KMf4igJvcrBwO+xIf5t/EQUUIqDdPyPDszH
         uSUN3yffXWxETSk2tWEmG/YRmB2EPB89GLGZXvkiB5VWnIl8UzLjPFLZun8riQIkBjF1
         Qv4OByVTBSwsNpA163wBZWAAr0Qlj3vFemULRVlNDcJ9t/XKUhu1R9g06bJF0RnTUUJG
         Kq1g==
X-Gm-Message-State: AOJu0YxoNW+ovPeuVn9KJLnu5Xu7NnBkXXVtfPEkBjrs/h6sOl6q7pFs
	B+hpmACrmPZSVifHFkCXQIHQXcz2w3WF+ygXakCzRyUB9nZmZ2yZ7LOhEG2MFbHKtOSygjQAq8J
	Rro3qFa+YhIj+k4DqFaWOtJ6K7bMObUaCGubu
X-Google-Smtp-Source: AGHT+IEV2dzAqmw7gBPSZr2rfVz9Av1LIMYf4LLsc4fX52nHbzut1u1+/GxLTeCi31l8asrJgGvOR6vcFDh71vEYuU8=
X-Received: by 2002:a05:600c:5488:b0:431:9397:9ac9 with SMTP id
 5b1f17b1804b1-432b7507c16mr8129645e9.15.1731042606199; Thu, 07 Nov 2024
 21:10:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107215921.3518636-1-ctshao@google.com> <Zy1oBfroZLBwN6Jf@google.com>
In-Reply-To: <Zy1oBfroZLBwN6Jf@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Thu, 7 Nov 2024 21:09:53 -0800
Message-ID: <CAJpZYjWy_c=Yhs-YnMyUM0BJvjmUGE57FTu66iSf3E02vObyyQ@mail.gmail.com>
Subject: Re: [PATCH] perf/arm-smmuv3: Fix lockdep assert in ->event_init()
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Greg Thelen <gthelen@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Tuan Phan <tuanphan@os.amperecomputing.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your feedback, Namhyung! Please see my v2 patch:
https://lore.kernel.org/all/20241108050806.3730811-1-ctshao@google.com/

On Thu, Nov 7, 2024 at 5:23=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Thu, Nov 07, 2024 at 09:59:20PM +0000, Chun-Tse Shao wrote:
> > Same as
> > https://lore.kernel.org/all/20240514180050.182454-1-namhyung@kernel.org=
/,
> > we should skip `for_each_sibling_event()` for group leader since it
> > doesn't have the ctx yet.
> >
> > Fixes: f3c0eba28704 ("perf: Add a few assertions")
> > Reported-by: Greg Thelen <gthelen@google.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Tuan Phan <tuanphan@os.amperecomputing.com>
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > ---
> >  drivers/perf/arm_smmuv3_pmu.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pm=
u.c
> > index d5fa92ba8373..09789599fccc 100644
> > --- a/drivers/perf/arm_smmuv3_pmu.c
> > +++ b/drivers/perf/arm_smmuv3_pmu.c
> > @@ -431,6 +431,11 @@ static int smmu_pmu_event_init(struct perf_event *=
event)
> >                       return -EINVAL;
> >       }
> >
> > +     hwc->idx =3D -1;
>
> I think you should update the event->cpu as well.
>
> Thanks,
> Namhyung
>
> > +
> > +     if (event->group_leader =3D=3D event)
> > +             return 0;
> > +
> >       for_each_sibling_event(sibling, event->group_leader) {
> >               if (is_software_event(sibling))
> >                       continue;
> > @@ -442,8 +447,6 @@ static int smmu_pmu_event_init(struct perf_event *e=
vent)
> >                       return -EINVAL;
> >       }
> >
> > -     hwc->idx =3D -1;
> > -
> >       /*
> >        * Ensure all events are on the same cpu so all events are in the
> >        * same cpu context, to avoid races on pmu_enable etc.
> > --
> > 2.47.0.277.g8800431eea-goog
> >

