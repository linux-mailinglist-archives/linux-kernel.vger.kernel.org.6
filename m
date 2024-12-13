Return-Path: <linux-kernel+bounces-445577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B216C9F17D1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E604A16C90E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C46192B86;
	Fri, 13 Dec 2024 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r6QNTXFW"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EFA192B84
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123934; cv=none; b=Q+GWiAEYYu77cEBKLhz/D/3tTbGx39oVaYyprgL3xXp2H/TSvDu830LJr6nrAAiy8UlrJqKikxBizCkWOgyoHjb1suEYLfVAZAcnGPVhE+jvYPHs+NlQGjH3aBokoLxoaSaUL9z9TWBchmobIAao0TB3+3v4dN9fl3lkz/2ijuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123934; c=relaxed/simple;
	bh=47ytQkByi69npnQJE9cuMcBCIB8J/1hpQqilY/Jfy2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DyK6tV9O22FCEJmEtOQfHCq3nmzBggswxhQXk0NC1/1ynzlFOXIFF/6ZfNen8ioGfVpM3fZnboyxRcnH6MakzeRdAFAigPfk0ffp4KAQ3zseCENCStWvSFzlivhH5A8oS4KQagIulgqa44l0uzJ9IM4oOJa2tiHFv4rqNMPieOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r6QNTXFW; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a815a5fb60so23685ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734123932; x=1734728732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47ytQkByi69npnQJE9cuMcBCIB8J/1hpQqilY/Jfy2E=;
        b=r6QNTXFW5VollexwBuV+BQe4fFVhqDgsqin3z6WJugxGRxu3LTVJCyr2HMQXORXTYX
         a+xR9dpMclso/sMLtS8E4WMOWq6UhAWwcHO0VRVWNnze+Ke5fCFUavpGuIE/SGuN7X9t
         GCvYrPQlYZn4at9e1FhfWyNiMpDeRPl975nh08PrIebCdAZDhwsWhMDwhjYGPeDdnjEr
         mQM0WEsLR2mOkx4dnZ4anvJAmgWKyzBckcAlzb82zPb0jwuW9Ztw02AFwb/6JIFhxCmc
         7rU7+G63L7YIXlM1wHyff7asJupFOWwPo2aqWlxHEFj1nj58ofAbnczV74bw5z1E04ZB
         9iKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734123932; x=1734728732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47ytQkByi69npnQJE9cuMcBCIB8J/1hpQqilY/Jfy2E=;
        b=Sf4oEPkBTgPaKrxSF+a4IFBV7w/V5N4BDH3PSaHkQZ5RuDL3ppEuTohsbUCI/V7hcX
         QS9i1gSiAV5ZEgIYGkzccBSyOepolDl7uBNVXesHoEbcnWrfkhnat3lkTlDibM14lbuS
         +NBd7yRs0HutdS0Wt43sKhIxUmgxReyPKaU2xYk8a4gZQuOX/UDw9b+8DG5rd6dI0MIW
         sqQ9A7WBxNdtgsdBBzop88DnjUx3wx8E93DzANtZKsECJiPR3W+AU/CoWkzFMLHysoJ7
         W64JmbaOapyWw17ZTmsexfOlJeAr9/tHAP+fMqOHQv4B42VlYxvL+VD2ewwPqpfZDaj+
         m0jg==
X-Forwarded-Encrypted: i=1; AJvYcCVK3tVazdVCM7DKqmeej24HRj/rqDZhGmN4+IK7HkB/1uwDu959yALmj1KtHQ6oBRS2iTa5gN2DVhWawy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw47Vo946/Avf4x5F7MxR2FxZr7DUQTQjJRbwgv6y/RrFohRbmd
	ilTpyFg7U7CN9+r+ozZ5Ez8ztx0hWAc0HMpNVJMsH2YWPJcadCUzxt8onIlxUBz+jHnBPxxs+VL
	r95XTmcppJN3HhOsovlUy5pVyhcQMiofT9KdZ
X-Gm-Gg: ASbGncunryONyRUwQ9PBBmNS4JbJ5umMjxq1IvyoCTZ57FeVmIHdATD7AAHnsoHhsE2
	4VvlzwLMXaMznFfwNDrITy2JHqGDKAb9dplJSdeA=
X-Google-Smtp-Source: AGHT+IHo/kk7shZp2cLw78tSqgm7MN3cgHDkD698rGAaphzsbaWqhB1nqjLPEhhZeYxzO84CQfy6GmWOwDhFWaZ0IMM=
X-Received: by 2002:a92:d792:0:b0:3a7:c997:efdb with SMTP id
 e9e14a558f8ab-3b279e187f9mr478925ab.17.1734123931596; Fri, 13 Dec 2024
 13:05:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z1ySfJAebZyEv8qE@x1>
In-Reply-To: <Z1ySfJAebZyEv8qE@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 13 Dec 2024 13:05:20 -0800
Message-ID: <CAP-5=fUMr_ZqrHdopMNQwacCvuAy2ZO0JKC8j9-v9Ap4vuT8xQ@mail.gmail.com>
Subject: Re: [PATCH 1/1 v2] perf tests switch-tracking: Set this test to run exclusively
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 12:01=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> This test was failing when run with the default 'perf test' mode, which
> is to run multiple regression tests in parallel.
>
> Since it checks system_wide mode, set it to run in exclusive mode.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Link: https://lore.kernel.org/lkml/Z1yPYqYYs_isO1PJ@x1
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

