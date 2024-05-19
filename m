Return-Path: <linux-kernel+bounces-183301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBB38C9756
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 01:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466D1281170
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 23:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0162D6E5E8;
	Sun, 19 May 2024 23:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b8/UEu9T"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03B510A3E
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 23:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716159665; cv=none; b=R9q9VW0CY4pSpdnJ6UTNJCaz1dLCF7EBFSkOi5PTq0D5rnmgFvowSum4e+Sxlj6U1UpdZ+q4MzClrDnIrnpokrGI+NvMJCE0f3jM10Mpq0g5XulhkjvoSD1Ox/wMDYOXEnAIZ+y7P4LyL72hsZe+g0O1lmo42x+VzAN0Bjc1gf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716159665; c=relaxed/simple;
	bh=ho1U+M+/SGKXCmr0Jp3HXiCcni35a30OfnM/31BV0dU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4554/RsjJ+Z9MIdMzwRLbCvEw5duNzEiFAuU6ozLe4Qy+d/bf43a+Pi+ooB/P1BsmVKWMrg8czYILrMZ0YQp4jDTvKSNHho6Pcn/HbnlLGdLF0cOI6gXAnx7pd2wQ/d2/47HuiEiy+alGwaNgwVOY5Nsrm1BGhIJNOlH9vuRGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b8/UEu9T; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ee0ccf9c2fso116865ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 16:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716159663; x=1716764463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3T2sk0zUifZrkf16bKv1srjvtZVOWyPlOZal3CJeJAY=;
        b=b8/UEu9T5DCQwfiPpf+MimFMLG5PgTepH0diyfLvc1snZzgCL754bSfOr4x1U/rqRY
         k4PH1KnNcK4GuQcIMRwicGS1yhEzUIS0Jd70TR1a714pamdTa8z8Re+GCXq/CdlmJYPG
         kN8DnJ1RUykHBStRK1lpCNusNQD1d+z9qUULsAVZJciGFXOw0aznNbqM+y8poTN96/nr
         oGM8ELy3dSyaMv3a2q69L+uvLq/GW9nkjvpvBdhR1UVmOsakSrSnvhLKpHHOPUjY0df+
         0ZG8xYpfF5gxsQpmw305BUpu9/lovgpIJBLXoZ0ZP4ux/FoG9dmbqzrnjSm4fhCmA8lo
         qV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716159663; x=1716764463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3T2sk0zUifZrkf16bKv1srjvtZVOWyPlOZal3CJeJAY=;
        b=dZXLjoemYwZLDBP0HS2j4YsZEItRvVZcw3PV0E8cH+TMgLcUxx/D9+f/fZxTuI6rCT
         XyrWGwnWsFXzhperuib/Ezb0e7EtgbM2Vkf3ogOKJKVRVc/inY/qTfDptB7Ird7sTIvH
         T9vrbQEGA50ztyrKt/9WehGFHcX0RXrylWiYEP1RVltyMb36i2X5LO4iFOv1swghH4uz
         e7wOwAv3rhntviWvOYOrK5MxTQn4XMTPtQkP3MqkWjOozC+Po2fp8JzstGRL38+lGsXC
         FrZExpVZ7VR8HpJR57q6Dhl1UDvzZCnE63SVClcWPlaDLPudV8V+MkYGXfQcK3ltrIyV
         ulvg==
X-Forwarded-Encrypted: i=1; AJvYcCXXTMSJcjKav+q3ufUObrfSHt1/UP63cEON8tAHo1We1NtnJ7nrfBKlIBA85JRq3dL5s1H71nL7vVvtlCrU0o2xGcNYXgHrUaWh/vIs
X-Gm-Message-State: AOJu0YxVlBbBGGvwAjubUcyyRXUa7xZBuL1xbgvQAhqp3qJWRq+KLO14
	g0UUgmfzYJzouY4FcenQltfGiNi/Oh+vDlCZw33oa29INaE4kFnt73Sla0CX4yGq+CyLid4AVhV
	TOXuCD1tRlVeZYBGeQ/wxezw9JULcN2+BiEsB
X-Google-Smtp-Source: AGHT+IEdkAdka9vpjvtaC0wh0z5o+xjxTsSuFpdHlphp4TlD/UT1+nt08SkIxRJcG/B6LnRDtJK2UhjIBc1osOgzwDo=
X-Received: by 2002:a17:902:ba8d:b0:1eb:59c4:4fc4 with SMTP id
 d9443c01a7336-1f2ecbb175bmr2401905ad.10.1716159662758; Sun, 19 May 2024
 16:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240518165335.3963530-1-sesse@google.com> <CAP-5=fW5YtzYz0R-9ZkgfdAFjkUDHu_Z1Sexs+2SmN0RwhrADw@mail.gmail.com>
 <ZkpokaHRfQYCo3uG@google.com>
In-Reply-To: <ZkpokaHRfQYCo3uG@google.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 19 May 2024 16:00:27 -0700
Message-ID: <CAP-5=fVYbewBtC0-GBKFUQq_gaGUMdZenCRyh3cyP4ff7yuqCA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf report: Support LLVM for addr2line()
To: "Steinar H. Gunderson" <sesse@google.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 19, 2024 at 2:01=E2=80=AFPM Steinar H. Gunderson <sesse@google.=
com> wrote:
>
> On Sun, May 19, 2024 at 11:23:26AM -0700, Ian Rogers wrote:
> > I think we might want to display this in the feature list during the bu=
ild:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/build/Makefile.feature?h=3Dperf-tools-next#n123
>
> Ack.
>
> > s/HAVE_LIBLLVM_SUPPORT/HAVE_LLVM_SUPPORT/
>
> Ack.
>
> >> +#pragma GCC diagnostic push
> >> +#pragma GCC diagnostic ignored "-Wunused-parameter"  /* Needed for LL=
VM 14. */
> > nit: pehaps disabling this should be conditional:
> > #if LLVM_VERSION_MAJOR =3D=3D 14
>
> It doesn't seem LLVM_VERSION_MAJOR is defined yet at this point, so I
> don't think that would work. (I just checked; 15 has the same issue.)
> In any case, I think it would be just more clutter for dubious gain.
>
> >> +       if (file) {
> >> +               if (line_info.FileName =3D=3D "<invalid>") {
> >> +                       /* Match the convention of libbfd. */
> >> +                       *file =3D nullptr;
> > Should "*file" be cleared if "!file" so the caller can reliably free it=
?
>
> I don't understand. If =E2=80=9C!file=E2=80=9D, then file =3D=3D NULL and=
 surely accessing
> *file would mean a crash?

You're right, sorry. Thanks,
Ian

> /* Steinar */

