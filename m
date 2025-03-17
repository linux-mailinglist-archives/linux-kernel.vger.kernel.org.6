Return-Path: <linux-kernel+bounces-564563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02078A6576B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3EF42222E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA9C18A6DB;
	Mon, 17 Mar 2025 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uRoOhLq4"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF2017A2EA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742227381; cv=none; b=cdE64ZrPHlMGvuS12cXMQySGG/1ljg3jtCG54VlMfe44a9evhDWKOAfAzPnikGI4Aa+OIsVmXzjKfE8g1UzeioOzjuPGrmfG15P6oy2tkmQpPkwBYeO/9W1EgvkLlDof1CPrwHlwIz6E49l98rcmCy6siEIUX9J1JchXdDVsIyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742227381; c=relaxed/simple;
	bh=QrGtzvGhJEt+eGpdNr3YvstJ5y6Ln+VWAevcx+CJnH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mfP2sBnaUrbHonCFx2Y/jQWncZinctXbFbdHA86660DXiV2P8RM+3wDITeV3GdVsz/wtpMGnDdA+w43AadULFLKCveIzYMl3xSwaB2dXQdBxnlHNX6K+1uBONWlG6Za/+Hv6hnYG5IZ3cI7URlHfYN4/aUcNVvBeeQJ6yBYD5AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uRoOhLq4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2242aca53efso32555ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742227379; x=1742832179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdNCS/9xpAatRym4N52MXBKwvX2+E0sdkGs47955xoE=;
        b=uRoOhLq4hF0/yuKozxmP2G++9epq9JGTDr531eO5KOamKibrbt3GgOEIWHP9tGbmJb
         otuUbYCiwUtTMDJ5WXBGPGcNjZX3wZBiOY9XRdMgMFgTiPnc7aqyvA8wFweVYY44dX8M
         kBfbZOd17qvaI5M+uUdr8LzoSbSN9jXmV2q/9QQhKwKaWIjD+WoIgK4jQbHI59sEe+8w
         XVX0qtMAD4PRRzpcRVjiROe6VSFkNq0NWlLo4DFaog1dmrre1CTSE144tVK0XhJiWW12
         gf+RvyMzbagldEhm2bLw0VamPKbIDWdNU93Bfq0VwRqoeYTVrPCN1m4tKK2+0Evfcqwu
         k+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742227379; x=1742832179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdNCS/9xpAatRym4N52MXBKwvX2+E0sdkGs47955xoE=;
        b=u3cI13OeKkKYPnXAa+DXQ1l05nfPyBkNnMsiZAY6vd1WP+Yhkq9o26jqn9WUvGDiJj
         XZ1AAmcqW0A9mpalgP5jeKPHj5gcoUubAkRZ2ioNyZXoI58347mTDSKmDTx8vEqugj+7
         7gfTHVBNlqWjjLaU/G+6PNnm1WjZ5IwqbOV8y96O/MSL204QIpgHRA8iTYYMOlekR957
         UDsfxwVj8njIY21ujQjetFBE2sES0mv3wJtfqWzEvV1znKs92anUegdnQGqdzqCp4B5N
         cP5xeS0LL+Pwax7U7LnvY3/BHppSNaLEWE0ATsnI86DK5mGUuOAS5sx58hCLW4yFm3Lt
         Co/w==
X-Forwarded-Encrypted: i=1; AJvYcCUXARMUZVDZsa/TSFgMqo21yKjIHNgGQBzF2fafbdkKWVbRIBzqjd857rmyi7VqVMWng5zb82kl/Sg+l8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkz0FmhftDpPxJ2GJKyt2UkMGnm/Cp+bCwbd8cx1AzUmasteoE
	cfnBpQn4QlJ6UVRPIm7QKyV/zBzuGxrmJMygUI0SgIwEPm6SpIdbi/ePRfQ24EmFjHE/SJwapf7
	DBg1hchuA2GbBY5asOoQ3kBEePBAruddrzFEIaKlLTmhExTvAFpSb
X-Gm-Gg: ASbGncuuwCXUUsPJ+POsJ/S/ZmysYMMiueruRahkcFx03762rcZybidQicM19WKQWVt
	VhVnNaRlQsyWwPgucNvJrkv4CI2W5HDPauN1UUDAtf39vUrvaWEZy8F9hM8npeIgqJVPo5Ewvs+
	tjCWxzkQkjPBaW4i8PDyOI9QRmFCpXDdSCd+fH81G2cT+kr3jWGNvMyKi91CKG3FOSwA==
X-Google-Smtp-Source: AGHT+IEAppDzcZL7Ur9e3WhyGOknJuCY0ReRk7mbdSSM7RQwqO4SXSEZA07LmyI7g7KSUW3hkf9jLmbIDMKxl1QjBCo=
X-Received: by 2002:a17:902:d4cd:b0:215:9ab0:402 with SMTP id
 d9443c01a7336-225f3eb40e6mr4553645ad.18.1742227378594; Mon, 17 Mar 2025
 09:02:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313033121.758978-1-irogers@google.com> <Z9TT3tGq4TJ76Tm9@google.com>
In-Reply-To: <Z9TT3tGq4TJ76Tm9@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Mar 2025 09:02:47 -0700
X-Gm-Features: AQ5f1JoehPZ6D2gVoX5jyHNVwuzvDD6lGQqw81zka_NheY0KMJFzGwsbZr_YsSk
Message-ID: <CAP-5=fVhd7=r+T6iL+ZgLi6YmDUzmDq-FEdZD1XHHYzm7KtBtw@mail.gmail.com>
Subject: Re: [PATCH v2] perf libunwind: Fixup conversion perf_sample->user_regs
 to a pointer
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yunseong Kim <yskelg@gmail.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Andi Kleen <ak@linux.intel.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, John Garry <john.g.garry@oracle.com>, 
	Leo Yan <leo.yan@linux.dev>, Michael Petlan <mpetlan@redhat.com>, 
	Tavian Barnes <tavianator@tavianator.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 6:12=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Mar 12, 2025 at 08:31:21PM -0700, Ian Rogers wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > The dc6d2bc2d893a878 ("perf sample: Make user_regs and intr_regs option=
al") misses
> > the changes to a file, resulting in this problem:
> >
> >   $ make LIBUNWIND=3D1 -C tools/perf O=3D/tmp/build/perf-tools-next ins=
tall-bin
> >   <SNIP>
> >     CC      /tmp/build/perf-tools-next/util/unwind-libunwind-local.o
> >     CC      /tmp/build/perf-tools-next/util/unwind-libunwind.o
> >   <SNIP>
> >   util/unwind-libunwind-local.c: In function =E2=80=98access_mem=E2=80=
=99:
> >   util/unwind-libunwind-local.c:582:56: error: =E2=80=98ui->sample->use=
r_regs=E2=80=99 is a pointer; did you mean to use =E2=80=98->=E2=80=99?
> >     582 |         if (__write || !stack || !ui->sample->user_regs.regs)=
 {
> >         |                                                        ^
> >         |                                                        ->
> >   util/unwind-libunwind-local.c:587:38: error: passing argument 2 of =
=E2=80=98perf_reg_value=E2=80=99 from incompatible pointer type [-Wincompat=
ible-pointer-types]
> >     587 |         ret =3D perf_reg_value(&start, &ui->sample->user_regs=
,
> >         |                                      ^~~~~~~~~~~~~~~~~~~~~~
> >         |                                      |
> >         |                                      struct regs_dump **
> > <SNIP>
> >   =E2=AC=A2 [acme@toolbox perf-tools-next]$ git bisect bad
> >   dc6d2bc2d893a878e7b58578ff01b4738708deb4 is the first bad commit
> >   commit dc6d2bc2d893a878e7b58578ff01b4738708deb4 (HEAD)
> >   Author: Ian Rogers <irogers@google.com>
> >   Date:   Mon Jan 13 11:43:45 2025 -0800
> >
> >       perf sample: Make user_regs and intr_regs optional
> >
> > Detected using:
> >
> >   make -C tools/perf build-test
> >
> > Fixes: dc6d2bc2d893a878 ("perf sample: Make user_regs and intr_regs opt=
ional")
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Charlie Jenkins <charlie@rivosinc.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: John Garry <john.g.garry@oracle.com>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Leo Yan <leo.yan@linux.dev>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Michael Petlan <mpetlan@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Tavian Barnes <tavianator@tavianator.com>
> > Cc: Veronika Molnarova <vmolnaro@redhat.com>
> > Cc: coresight@lists.linaro.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Reviewed-by: Ian Rogers <irogers@google.com>
>
> I think you need to add your own Signed-off-by in this case.
> I'll change it for you, ok?

Sure.

Thanks,
Ian

