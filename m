Return-Path: <linux-kernel+bounces-327175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA22D977177
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C18288343
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB9C1ACDE8;
	Thu, 12 Sep 2024 19:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4MxGLPaP"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8676018BC20
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726169496; cv=none; b=Idn77Ex+jrGWK05qPQ+vS6E8Jf7pWHbwHxjh3vtbkAUXAoLXtVhnMuKD1YDKjgEnnx3HEb8/VkcTsOOE2ZANUmxf8HMu07uF1KZeUx9SUvdO6o8L1/LTNuzjzubUxs9AHZGxa0EMQKrskm02n74Rpfw1L7Ndnecj4Nuq/P71lW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726169496; c=relaxed/simple;
	bh=Cr5zlDMGaPNV64I3wQ6jiU1g/Gs4cGVM1A+QGKe6gR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L9J2eNZN1aNJlxNUFFj2YqiD77Rcqx/yftYjEfCM+5x9wSAevELK6bU0+rclpBYWn023WfT9CtJV4bAfHK4OT/wV0P0dkZOwJ0+YRebCbWpTxCt7TTHeCpQz7f9c2AdWIMAQtxCeLmtUfCJFG3ToQdnbabSKuB5t5frKW9SIOT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4MxGLPaP; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39d2a107aebso40365ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 12:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726169494; x=1726774294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cr5zlDMGaPNV64I3wQ6jiU1g/Gs4cGVM1A+QGKe6gR0=;
        b=4MxGLPaPTmC3AlKMOaz0FPsdGsogkhpoeZnyxWwykvUFrBpJFGW9fajYOsqIT7LU9I
         tYIoeaIsQfX0L7/u2lcfMr+8SX6r/pqzvUh3Ag+hIETedKg1biJ1n+eLO976i7DGk4R/
         cgm47xDwGCP3jf+5DCIHVFpPYIN8YJ0rkVB2Ha35I3zkalLNr5Ghjbz6BVbjnUo/09J1
         eqBzxlcC7cgBLrUAHHL2qAPJQWIsSBjNBtnu2o8Epep9BhCm4yzQGajHinZQip21q8f/
         2IepCT5T6UwhLTPCkIdbJY2RAFyocltRfv9KX4iU/yz0b9jQj3OOMKBYyHcTUppKZh1o
         2PAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726169494; x=1726774294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cr5zlDMGaPNV64I3wQ6jiU1g/Gs4cGVM1A+QGKe6gR0=;
        b=ggyfiOTRDB/SVMt/FY3VpODZBqTjYUovNqW5e+gVph07XmP6tLUTvlmNO4e1DvOi6m
         zNLnOdYKFs+JtNgI5PPSwNklX27IVUPSqyIKrWuUw7FAK0xdzc5sIcfwgrVIxY65IlV/
         QhLZWQ9L7nOpqgzMSU0e6l0jo3ueYiRmyCYiwDOeG/JR93FI6Vb6E1LoPr/BMWV8aDi+
         ke6toorh2wVtthSxJHjJuIocaxxz+fwEQLRZHn2zp9Ux/HuUF1ohIlNJttFoyRqeSSYg
         gWv5VW7iRhd4L1VRzbvoXuHJVEsofzi0oqym/os/xbAkcroyrbdK6eYMfUoCXj6inAS2
         QjWA==
X-Forwarded-Encrypted: i=1; AJvYcCVgJKPVk7fmAddKXUnOaT4pUv/UHRz2Hp0IAEbSEVgTT966BC2plQGCYDH79M9Mwf83nS+2T8AOqIwLtYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxziONqVMwhTXDP/usnWQhtVBZ+viNXOJBxLk3CtCvwSeFld792
	xvm8Jh72jvePxLkh0MlWrOysPD9rYAYom/9zCAkcAibrIT1FsF3Kp0ux0Nlb6vCA7a5Itah9p1X
	bBpNZsVVEH7CS1BDP43VF9GTtIXpI791GoBkfdvAq+lZsQemEyg==
X-Google-Smtp-Source: AGHT+IHvH6+bWkd/eSNntgoj9UD2X4cfQfRs08lgUinSsz7xEoyunyuN7JXR3FANHFFusAgInC4jFNzt1d2xEHsRndg=
X-Received: by 2002:a05:6e02:1a84:b0:39a:f2f4:7ec1 with SMTP id
 e9e14a558f8ab-3a0847e81b2mr5237655ab.20.1726169494308; Thu, 12 Sep 2024
 12:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912182757.762369-1-irogers@google.com> <ZuM9zc71XXXZ3eRZ@x1>
In-Reply-To: <ZuM9zc71XXXZ3eRZ@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Sep 2024 12:31:23 -0700
Message-ID: <CAP-5=fUCVa3VoByKUFDp8Q+M2ZOTdy7ccL7Ter8E8dSE368KAA@mail.gmail.com>
Subject: Re: [PATCH v1] perf vdso: Missed put on 32-bit dsos
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 12:15=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Sep 12, 2024 at 11:27:57AM -0700, Ian Rogers wrote:
> > If the dso type doesn't match then NULL is returned but the dso should
> > be put first.
>
> I guess we can add:
>
> Fixes: f649ed80f3cabbf1 ("perf dsos: Tidy reference counting and locking"=
)
>
> ?

Yep, that's the one that added the reference count increment.

Thanks,
Ian

