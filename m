Return-Path: <linux-kernel+bounces-253831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 998B8932790
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39E3DB24E94
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A459219AD80;
	Tue, 16 Jul 2024 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p5J4KK6c"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A163119AD71
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136849; cv=none; b=lQ1+RT37KSUke8Z5VhGd6Z7w6/nG9q5yroGLSgM0XCfn6yV8psBdDTjgFOGxCkmi75k7jxrnTJ4EfJl5JugDTvibP2qJmLjD+WtFW7eUNrJtrcVMM+2NvG1CGHx43dMj1Zs8Q01olNtOojqU85fjqALAW95VYNmmz/E2Er6N8j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136849; c=relaxed/simple;
	bh=+edc5xyo7SNQeaQNFbWXs+Tm3sUeDiyy8ZmXrozCLfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtYmi1zVB/T/uYGsErtr7cqBF61tAAqaycSjHWbbkeR+rswZ6vOA93xPTNho/fVoEpprviTP5mpnbShn6VXS47qKxOvnd2CnUIgw33J3Qfrv7oCHZwa79vgjeN8Yz1pmzqOIEGqJGAPR9JFt38h4CbIXjp5Nf6MFNbBy0OhVgKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p5J4KK6c; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-38206c2f5e3so134385ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721136847; x=1721741647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQBlIx+MbLsC+Vy1pbzJoOe43hAv765RYr7yJg8JEZ4=;
        b=p5J4KK6c44PFOrW5TB9xGYMxap0YMuV0/GDAt/EaGZfxDKTFukCdlaxCnO5YvBOxil
         oM3bujIsvroHTHDeQsjU7R/Wd0ESMe94MvUEUnoiGDMuurjyYK52194avHO0RFk+w1Ay
         mkHisRrO7hgpTZh9dWmXcMqW79k2I392/3UEN26D/gjN+i9P4gXGE/49r6zc+xBjYxLP
         1qdAW4ziKvCH/UDeM32tsFsaN/WT/uby8Q0c4Jm3ZSIkM+64eiqpQiO2pN0FGrk8HldH
         87p92FYSzCn32Zj2HtRVPWuAWGllSvYjKnO2xvzKKR6dmpR8fNnowuRLJ43kDbLnotB3
         Xwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721136847; x=1721741647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQBlIx+MbLsC+Vy1pbzJoOe43hAv765RYr7yJg8JEZ4=;
        b=eIBm4W18hY5dQAR/TGnDf4lExO99oTgmX1Zi1eRquhj13q8o5t3F3X5VkwnUCGzy8E
         ATXrkl/kAxxty5aZbkw8dbMV6HfyOlTTkkmVtEqPMPcLYCpY5wIrp0F2DfQSlQl3CvwG
         ek8rjQUfcwePYZgAXALxNDowObxmep9vTynsFuTEqDve8Sb04jMe+c+AWf4YUvOdFQHn
         +2Mr+v0pBZCRsCOtEZq7roA8WpxhmVmHsa18+7wmVZd+H8uiage3saJjEvet1rqR+uXj
         zplSUtPys6MBQkKJiQgkkt30OYEIgnZtxCpGSIRlVi3v6Z0kbCcQS4LlaXIYaSv9BD5P
         HRmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoIWqbXPYmlHUNoRfA2k75NzYIhQpTZDidcG/bY4Lw5VS5/6zKy4ASttwQelveFdvUGT/o8zfo7H3/ty8U6dntfGoziYvJWAe3lHpd
X-Gm-Message-State: AOJu0YyyY7LV4giKMHGsQMw+mCBAHWoPoyUtDvG9IHHu9fZpjz1R66xA
	Fu7KjosYqM4SkSGUs/CPJVtff0PSsT4pgWY7dGwbPB5sHi29MGmYhShEQ6U5sBt8eng5tHo6ouL
	RcgU6rQS6JO9hcYETMxuv2V3NARF1H9r3stEh
X-Google-Smtp-Source: AGHT+IGtFaWf50TIORBi/HuxOGMvmqdyJb2rTuRdSU75GpFxkoV0cPiqLMktwAAj9pa02+8lpPweTPaMd6nedQdhjkk=
X-Received: by 2002:a05:6e02:1fc8:b0:376:f79:1337 with SMTP id
 e9e14a558f8ab-393e7ddac7fmr2670755ab.1.1721136846711; Tue, 16 Jul 2024
 06:34:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716075347.969041-1-nichen@iscas.ac.cn>
In-Reply-To: <20240716075347.969041-1-nichen@iscas.ac.cn>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Jul 2024 06:33:54 -0700
Message-ID: <CAP-5=fV8J1UE8gYgXL16ZqaVQ=cNLV2wrFWA4Z3e8HbTLoAxmQ@mail.gmail.com>
Subject: Re: [PATCH] perf inject: Convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 12:55=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote=
:
>
> Replace a comma between expression statements by a semicolon.
>
> Fixes: 97406a7e4fa6 ("perf inject: Add support for injecting guest sideba=
nd events")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-inject.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index a212678d47be..7b4a5d56d279 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2069,7 +2069,7 @@ static int __cmd_inject(struct perf_inject *inject)
>                  */
>                 inject->tool.finished_init      =3D host__finished_init;
>                 /* Obey finished round ordering */
> -               inject->tool.finished_round     =3D host__finished_round,
> +               inject->tool.finished_round     =3D host__finished_round;
>                 /* Keep track of which CPU a VCPU is runnng on */
>                 inject->tool.context_switch     =3D host__context_switch;
>                 /*
> --
> 2.25.1
>

