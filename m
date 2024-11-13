Return-Path: <linux-kernel+bounces-408041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC1A9C796A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCAB1F2685E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB961F9ABD;
	Wed, 13 Nov 2024 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d7Cf48B2"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0269B1F77BD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731517042; cv=none; b=qfHCuoyYCfq+V72l6H8YCO7yCOa4lOnoWEoVdc+CkDgKejQGNrBmRUEzkr3ySU4dlfHgMkIOm/DF/LPFdwVYCpgT1ipGo2jnvBUiCaoYeGRuanD/A+3vOKB/lLbnPioLtNhwW2H86WP8Me4TgpsPEN/nuEZYt6n07DDgAYx+IUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731517042; c=relaxed/simple;
	bh=roY9kyECMD+3vngFI1/UwaeZzLwM+IHZFvROogGuYnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrjZsKxqe6zkBlbdpsZ5+cNAjebB2FEczSXimE+8otwrg6RO+5pubUuVMtgokuLQ+77eQ+A0HG4svQq/0KK3TGFH00A6DeZjlLLgVmWhcJvi1XJrslH7HZUYZe7Xu6saBCPE7hxbfjNztU74HhCeAMxqG3mBQSqwzfp6Tqwb9UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d7Cf48B2; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a4e54d3cefso209305ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731517040; x=1732121840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8KxvDaLBUqx0245RDy11VfTWydZkirOEBvvWNT6X60=;
        b=d7Cf48B2NTbcderNfV+e6eWg0T77gjo/mCqY9WQZ0evlU89Q+02qrSrs/jSDIg3TKJ
         npTjy0IfSqDTaePDLS8BuTz/iC2svv0dGYwjlYNk/T0WNAI6p1ep7zE6mo+pK6HWavaa
         6SdzMMoOKMIJokTeFVc59vtC6eRiQSTtpo7w6TnBp1mVg/QbDbdTNS9sVeh7uhWBuOOH
         nardyFybKoxLBVZa01C1Yzr6aX7pz/qtfVpBRf6VY1Pj8/W9Xs+NgKYbfU0a2UZJ+T7M
         ycAR/LSChWC98KJ0h6d2WQOeH5A6VXqdcp9eHPoPwDmFrj8U6udDijB4TE7w5Xiun+2a
         12PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731517040; x=1732121840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8KxvDaLBUqx0245RDy11VfTWydZkirOEBvvWNT6X60=;
        b=Jce0rHXEtIgmro8Z9HK/Ksa+HwLjgdt2glFZKZasVwRNz5XvC9ege/XWK6sjzhW08G
         1UacainzjsvtrgPRpeBbp3YQwyr4/QIP9ZZrePQ45a0Gepn3AVrIA+plNuPi46fhCKe/
         NEL+WT0epoaCaXSp/M9Rw/x90Z4m9x7SS0VR01gf1sJnVhjwIFDEd++wEnXmRYxSH2hh
         Mx2R5mhCGVuXJ+XCroCG4eMkTclsBgiXZIyF3sd1jzyReuia04xRWq+rKYXkNdAK0Ilm
         I5LTgGNSfnO1ZkD3iQvMWFuSpoPrxW4diy7rL5AypM+wJBz0vy85PFVkcDtyCMrLyc3N
         yoWA==
X-Forwarded-Encrypted: i=1; AJvYcCW6DX27MRtV/gGWGWTb5Iems2Nx4nMooRrIGLHkEr9KfYstarnRTipQHQQ9CSz+FTNLqOUi5gF8uRmsNRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD8FMxO4DUe7Odq63DnVxnEI1otELGfTkH3CZ7N725CvQXDNWO
	lmBdQaOGB6tiEzHmVGe0lrj3S5Ot/p02xFzBOC3Bkktxmk+6xS7INLhc8KW1wmxnWcZWGkLhFWI
	j7vgGfkKJCoZoeDkQfco+kZq9GzbuR+xVnMeT
X-Gm-Gg: ASbGncsE7VP3njtUTuNrYga0iaBZEr7H7mV0lWxgZCYTVHLh2NWqCRR0Lx2HzS76C8M
	Vz1Whz0tcrAcUs2nKOHiVUfZGrIcM80zXqAj9BvOjavb3ioSxEbR8vNqjn4HCwQ==
X-Google-Smtp-Source: AGHT+IEYUtjqBOfhYmwUmXk7ZVagsLqJaLpw1VzmKEfuA/uLAvghKlUKEthZAqpx66oTNTtjSeM5RraRZ8GtLAZlBSM=
X-Received: by 2002:a05:6e02:1567:b0:39b:b1f:5be1 with SMTP id
 e9e14a558f8ab-3a7171c3900mr3763585ab.1.1731517039934; Wed, 13 Nov 2024
 08:57:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108143424.819126-1-yeoreum.yun@arm.com> <c03b1604-cc41-4746-be3a-fc326152d556@linaro.org>
In-Reply-To: <c03b1604-cc41-4746-be3a-fc326152d556@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 13 Nov 2024 08:57:08 -0800
Message-ID: <CAP-5=fUSE9Pt+=T73wTUn+y_7iMZ6=bNNNgP0z_a1ty_KwV1Lw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf/util: initialize is_test value in expr__ctx_new()
To: James Clark <james.clark@linaro.org>
Cc: Levi Yun <yeoreum.yun@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nd@arm.com, namhyung@kernel.org, 
	mark.rutland@arm.com, james.clark2@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 8:13=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 08/11/2024 2:34 pm, Levi Yun wrote:
> > when expr_parse_ctx is allocated by expr_ctx_new(),
> > expr_scanner_ctx->is_test isn't initialize, so it has garbage value.
> > this can affects the result of expr__parse() return when it parses
> > non-exist event literal according to garbage value.
> >
> > use calloc instead of malloc in expr_ctx_new() to fix this.
> >
> > Fixes: 3340a08354ac ("perf pmu-events: Fix testing with JEVENTS_ARCH=3D=
all")
> > Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
> > ---
> >   tools/perf/util/expr.c | 5 +----
> >   1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > index 5e3732bc2fa5..bc119501f091 100644
> > --- a/tools/perf/util/expr.c
> > +++ b/tools/perf/util/expr.c
> > @@ -285,7 +285,7 @@ struct expr_parse_ctx *expr__ctx_new(void)
> >   {
> >       struct expr_parse_ctx *ctx;
> >
> > -     ctx =3D malloc(sizeof(struct expr_parse_ctx));
> > +     ctx =3D calloc(1, sizeof(struct expr_parse_ctx));
> >       if (!ctx)
> >               return NULL;
> >
> > @@ -294,9 +294,6 @@ struct expr_parse_ctx *expr__ctx_new(void)
> >               free(ctx);
> >               return NULL;
> >       }
> > -     ctx->sctx.user_requested_cpu_list =3D NULL;
> > -     ctx->sctx.runtime =3D 0;
> > -     ctx->sctx.system_wide =3D false;
> >
> >       return ctx;
> >   }
> > --
> > LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> >
> >
>
> Reviewed-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

