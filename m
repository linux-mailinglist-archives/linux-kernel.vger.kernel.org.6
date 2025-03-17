Return-Path: <linux-kernel+bounces-564490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6305BA6561F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8256A1897163
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532B024BD02;
	Mon, 17 Mar 2025 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t7iwklv/"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2662459E3
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226186; cv=none; b=bOklQa2bXAKneimJiR8ZKgAM3daNmGXaD0zYsv+KFXnqgHJQSR6PfR5F0KsFTKbsGJ3b+2kiLEiZ2qu43elfYZzGQx2hH7g98Rx6ZBT06YCoAEaICm/H2YLdzjAPZ2iToECwPbMzqBVGiiyBstACScD/7FnzQPopJ4bRq6YkEso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226186; c=relaxed/simple;
	bh=DVNy0mGfrLWmMLfG96C/e3PV0BWGxFYi9QD95q0Moac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDuVvMD9fGYdovj3u12gX60ZPYDXIDv9ki8QgXH+At4I6qpTWLWdYtFfg6Pkonw3l5um0wnGZF32ltcXpMttGC+T3NjEyFrk+E1cwFk82w+D5a0NCOYhp0/TT3IguJg+3AMxz115q0tBLTDdLsIaqYyWky2jCIMd80a6QMBw/jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t7iwklv/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2242ac37caeso21225ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742226185; x=1742830985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVNy0mGfrLWmMLfG96C/e3PV0BWGxFYi9QD95q0Moac=;
        b=t7iwklv/f+kyoNcGMJe7wjst6JEY52GB0+C+UCoS686z2CQcDjYj7zHLKmTWY0rYK4
         /DH03ueJE2b6RNF6akAxOjes9FwZcBwoqBdIzOptfBmlLaEJNXG38bzFQcQFneayJ/OT
         hpe5kaA+0EXcsk/+ktBnkQRuvwGQv1hrvoidBP/mMVi3AhXaoELmLi3EJJVO6y99NnwU
         /UJQiDP539PNLg3Aw15h9z89l/XAbbPMsOwsKsNdQcbwSuK3ssn1pKuSMWcUjlcwOK2u
         ukq6wADTRev4mxcqY+3mtWI2Dcb7STYc8/0tnV9ykf2UtW4BCLxjXoUnI5LEffouxTs8
         sEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742226185; x=1742830985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVNy0mGfrLWmMLfG96C/e3PV0BWGxFYi9QD95q0Moac=;
        b=xR+bugL6kTZx2UxVnEjD9kehvyMdsog5kH8Ka2l/iU122/iWAGZhPWhZNeFZZVAInI
         vzCxDEYyOXE649Wh+flNKsdt4QDM93wxiO4qDheU2yD29PHNK1vjSMNHskkT3SCMtkNL
         d42FIm3518PlZ9qbIxuh3Y6AmjEMtip78KWXrizygM4hKiY7+Po7oM5tS82jTVeO5YXv
         Y8dlDzlZ9/apCwrEhY7Zfcc+BgU3OgFPLipGg113HCfdT4ClAXvrA8KEtt4BPVEtG1V0
         hg/mni+3WyVyWLJOXq8ltacOl6ex42gck5VS2u7iopFl1N/ET/W2hjFmQyLU/MVowpSX
         kNqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4AQYENnSZkSGrInIPOyGmkdj8M/UvJ8YrWfZE0w394KgCc6FGmhxqkl643p4P1P0JG6RLhqHGMaP0eZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOloCFW0pQzFKxwco/23ElpMfdoEG7/SDfa1t/akLr5aPwdnpu
	hU3s2wHnuNATVxsOg22nOx5I9a3q+V5B7YQ5rM2oYuCkQ+sFdK3slc0N7X1hh1MyeyogZpQNQm9
	KhQOAsrtH829I9dNC+fKmh2P1TaVZF3Etivpa
X-Gm-Gg: ASbGncuneiUzG1XXwHZ7SdPjIy2gf2lbaqcxHBWRMxxbhGhRn/MBwwdmV89glCP3iO1
	O41vxBm+jEY9OMbbVrJLBkKNSbebzvLOYRNLGN1ye2F5GpFKlwUzbWsjSiLqg73XKk2e8tv+drQ
	BxObSdWKftO06cPJfaW1T7tPJCqoo6GFiZed4UBJj8NH5Ynocw+whVonzXPIFt/VsSRw==
X-Google-Smtp-Source: AGHT+IHpSeYx6aY2+0dZ1l/rPLNoofBXCsF5QSC+l9QPf+nZIcLzU7jjaGVFsYZoKfMU3S4nM4vf5vZnj+n0cc7PG0w=
X-Received: by 2002:a17:902:d2cf:b0:215:86bf:7e46 with SMTP id
 d9443c01a7336-225f586fe3emr3863375ad.7.1742226184466; Mon, 17 Mar 2025
 08:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106003007.2112584-1-ctshao@google.com> <20241106003007.2112584-2-ctshao@google.com>
 <Z32EFouwz3IHw8h0@x1>
In-Reply-To: <Z32EFouwz3IHw8h0@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Mar 2025 08:42:53 -0700
X-Gm-Features: AQ5f1Jrf_NPH7lzzNyHvt0BDDRHgeAY6q6IW07sFrM7dZmGLUZkeIjnXd3VDTVg
Message-ID: <CAP-5=fW+HDfNcpTkjPwSLezP-XTj9hkPLrwia_JryCr8+Ro0qA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] perf: Reveal PMU type in fdinfo
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>
Cc: Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 11:44=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Nov 06, 2024 at 12:30:06AM +0000, Chun-Tse Shao wrote:
> > It gives useful info on knowing which PMUs are reserved by this process=
.
> > Also add config which would be useful.
> > Testing cycles:
>
> I applied the first patch in the series, that already helps, Peter, what
> about this one for the kernel?

Peter, did you have any input on this? I think this is simple value
add with no real downside. I kind of wish the patch did more than just
dumping type and config in fdinfo, but getting those two is a big
start.

Thanks,
Ian

