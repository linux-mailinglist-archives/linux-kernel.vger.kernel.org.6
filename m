Return-Path: <linux-kernel+bounces-548335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87948A5437F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 326C97A29F7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1E81A9B46;
	Thu,  6 Mar 2025 07:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ofYaGgme"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9350118DB04
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 07:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741245441; cv=none; b=DuRjxQlep0Bek6as+0rs3yg0cYYFcM7C2m5KFRzQMcLy4YoKmoU5cjsbDdJXUcQHSRzjD3PgqA5s06HfT7tSQ+ofdgcG5JH6SVmpNYXdUfx2nOYh77uhMvhG06cqIgaFFoQgAOL+H2ou3rYIADsSWfqbAHsp8olahj5OG+8j5Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741245441; c=relaxed/simple;
	bh=afJfrcTUwNndzGvYlL4g8anzka4FSLZnK67S70X21Kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4yUE5SR2GXj6pLlCVkP1HM9j+KyjRJUqx/zL7xdRpJ2FH/3BF/VWlVwRgbzW7VPPGWTRwj0/sD0w1nWmECh2HxgQwiVUw4Gz5XLIVxWMju/0ewPtptoHcL1nJUsBddbHoFSFhVo2jGe17+yfLrTsoRIYXwMXS+itCVw6eTBIac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ofYaGgme; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2237a32c03aso69835ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 23:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741245439; x=1741850239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klvvH1kgJs0DL3h7Oo378c2WlFSu+xBYIPROUcHihHA=;
        b=ofYaGgmeLLS2phpqsyAQV1VQV/QBIpubaxwCAmVEkkJFkOPkiHLkwaE+dqTqkTyZwy
         4X+IOzVFkM6OSmy5IMT76h3hrpUFzzzRTAEjnC/+3b7ATzdsoPkPc+x6TZrUucu7iDTu
         BFJAT67c8Ut08un8YTP28X6KYca0md7ZyGPsMFUUts75YRfG2CFt6dj/gLUiKwolSzsV
         LwRuYbfANQt47fy8KmbyJmwHkVCnUgGsPpNqK0cGOEdiW079wf/oVhQ8B8Qi0aL4sMT0
         gwTbOO1S+2vu7IGxguV7/K4kDyHEeai9wBWzEnDeWfPwuuvtelB353sEro9lT24fUZ+b
         zuuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741245439; x=1741850239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=klvvH1kgJs0DL3h7Oo378c2WlFSu+xBYIPROUcHihHA=;
        b=I5BTcdMuu3m2FpakG4GlRSLZQwEjz2z25tZnbqsT4Af+hWEobeYk84tm1uEYe2sE3t
         otodXNTtWPdCeqdXI/0OqHX/0UqSvMppM6BOn7gYHJpEbI4k1z7HLXWAz9xsQIqTWln2
         u6bOrcvpPUgqxAVzWV8jD9cLfZGGOtk7WrghEOiFcqqsW3N+qk0NYepzuIaIAYuGQx7Y
         cGUoXvqruoPl21r5DlYwmRSeOD7Tvu4zdWflweXyBENNy5UtZYWwhLu3JDlBmaDgZT/9
         SFBiXecYrUViXYx3b/5HNEJi6d/BPqWd/8gubBdk49GeuVgbGFgSegbZ1VafYOxTorcZ
         aNLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9b0O5KTpP49V3MDjxE9dJqlgoWcc2o2EpsEmy63Sa1HAamWXauhbQZVv2acOBhDyCq9brDj7T7+1vke4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws4mCqtF8LuBGhtDGSmqGwqpfi2f23BkuLMS3OE9t4/bqN89vU
	H5cGIFDapgNuBPZBUC6ZahmrXDzv6TE2EL3LR2WgglL44RVmPGAzqM5iWWMJ5aSiBWSVfMmh/ZA
	P9dRRQ+r0hE5z8Kj/qHJDZ4Na7c/D/uRRijLo
X-Gm-Gg: ASbGncv6F5NKQlLskOo162cLnTUaSNbHkX81CHpyltwjTlh2wq9lfA7c/DYPtGGV/7r
	8XkLeVU1RAC42fT8Jh7iqN9KaZgNG924vJ/0WJgvLQFH1V3wgpPd8DoRE2NynckGwmY5PU9gGqU
	f/FKnnCWJbKVBGmIywTj/yrxnNJp0=
X-Google-Smtp-Source: AGHT+IG1RI8BspnyGZOOKTSThi3cd0DexZtnopn5sTHOBG5TZxLsFjjcFgrXJI3oj8/gpVr0T6PbhwYLOG00b+Cm/uU=
X-Received: by 2002:a17:902:e884:b0:223:7f8f:439b with SMTP id
 d9443c01a7336-2240e4cb713mr1363285ad.29.1741245438515; Wed, 05 Mar 2025
 23:17:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305023120.155420-1-linux@treblig.org>
In-Reply-To: <20250305023120.155420-1-linux@treblig.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Mar 2025 23:17:07 -0800
X-Gm-Features: AQ5f1Jo9VrctFJizPJWRd1IcYze4ewTJcAathfia1ysS5f1XFTZ17W_n1GsestQ
Message-ID: <CAP-5=fUpqfWcQAi8231fdofZ-f_bOTi=t8sdLUenvvXjQ3OfGA@mail.gmail.com>
Subject: Re: [PATCH 0/6] perf: Deadcode - the P's
To: linux@treblig.org
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, namhyung@kernel.org, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 6:32=E2=80=AFPM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> Hi,
>   This is another set of perf deadcode, this is my set
> all starting with 'p'.  It was built on top of
> perf-tools-next as of a few days ago (7788ad59d1d9).
>
> Dave
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>
>
>
> Dr. David Alan Gilbert (6):
>   perf core: Remove perf_event_attrs and perf_event_refresh

This will need to go into tip.git.

>   perf util: Remove unused perf_color_default_config
>   perf util: Remove unused pstack__pop
>   perf util: Remove unused perf_data__update_dir
>   perf util: Remove unused perf_pmus__default_pmu_name
>   perf util: Remove unused perf_config__refresh

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  include/linux/perf_event.h     | 10 ----------
>  kernel/events/core.c           | 24 ------------------------
>  tools/perf/util/color.h        |  5 -----
>  tools/perf/util/color_config.c | 11 -----------
>  tools/perf/util/config.c       |  6 ------
>  tools/perf/util/config.h       |  1 -
>  tools/perf/util/data.c         | 20 --------------------
>  tools/perf/util/data.h         |  1 -
>  tools/perf/util/pmus.c         | 29 -----------------------------
>  tools/perf/util/pmus.h         |  1 -
>  tools/perf/util/pstack.c       | 14 --------------
>  tools/perf/util/pstack.h       |  1 -
>  12 files changed, 123 deletions(-)
>
> --
> 2.48.1
>

