Return-Path: <linux-kernel+bounces-550863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 641B0A56512
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE8E1893860
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE9E20D4FD;
	Fri,  7 Mar 2025 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E5hV0nHe"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56C1194C8B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343004; cv=none; b=iba6TURj6qlmoqVwxMQCDvZ96ZNhK9hdMZEYEN/FO6gBuBOiyzkD3R8Yx0eaTnUB8Natp5LZ8f/fFUQpyMGsnKofBU6qu06NTksk3cyV6SX7gI/nJVyH4mP8WXaLvbSER/4/6emH436bjBq6UPQ5KSTGCr5CVT2JOzPCelH/MpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343004; c=relaxed/simple;
	bh=DtxFf0fYVU4w0uIExHFhQmlD2Fo3K9WMMATEvxoc1DY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Npv8vDaQw2x72ZnKXdKmEgR90fngtRPCKIi2IzZIgMT6RUWz7LebiuEJXHx+K1lKhU/8gHQ+VqfbuLxeeu9GUZuC//HH+vN7RbD/Z229rJGRsChEqDVLYpCKxXTdnYxh416Y6c70oDjet7PNWBG85bhnVxxE97BbeKKl7LERJMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E5hV0nHe; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6fcf90d09c6so14810097b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 02:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741343001; x=1741947801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfF5v1NAk0jH/+c1GNbFOnaW6p4cZVM6+YYNwLme/iI=;
        b=E5hV0nHe7t5SpGmf6l/OJe3yzCaV+t7xutwCl+2QodGzgNlUByr9AeZk30n7ERGmt5
         DQeRt7bLwxNuvuENISn9hcWguTgCO9NrvjpPmBY3unZbHg08laQ6UotyQLs/MMw+jMvW
         SW2qeybGH/wC77yWQb39pgWFFGGPKjXUMKY0yPyWqBX5s+dopxJr83utbDO4Kj2f9lfF
         oxviHAHBnbIUwNbGrNjvIlnvec+dFg4++72ZjUweeJResmljLWzyo826YrUrBZmR4G5N
         F7x6bJiFUNyWnOtpgVO0Foo09kw3tAlOlPJkuqsKh3y5J6OjN9tq5KcuH4hb9i+5jwGz
         yb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741343001; x=1741947801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfF5v1NAk0jH/+c1GNbFOnaW6p4cZVM6+YYNwLme/iI=;
        b=p53vD9JSNbbIWQYz7d2xqe3a8fPQrrqPJHWi04cNw8YYIIMiDetLP5uwt6Xz4MqJpf
         qs8s1qdFQFcULHAZxlwkPIQLC27sMgompTdd6VkA4DF7i5jD6ji11r95+6rzXhKVSj/2
         2otfiTCbKha57HE8Kr0Hj2e1glkHtyp28A7cH4179HM4VNF1z9wps2yi0jgtUbKaWc8V
         YR4Xjc63uijO1bps95hO57EGpjg+aOiL5EiUCBwgxqgIvIJuBAOcqJiSwI1QV9wY+SSP
         2zgT/zIXYu1lYQNpjiBm/jfyFcTmViZyj6s+58YnMnNdfQ+IPHF2xrbenlMPnVWT03sY
         K8xw==
X-Forwarded-Encrypted: i=1; AJvYcCUdI/JSVKdKOm9OjOa3/bAqdV/d92k38BGfh4IeS1YS3tvAk7tf9IiXsSYq7v+Bg0t95FxMWpPPA0nZEpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz0PB7yknN4wUFEX8VQ7RW+Xpy0QhTbyb/u5CTlv/dm9u5yS9t
	1hJCTd0le+XGXvhhpBaBy+LiTxNoY6U/J82uRZrKx5Drh3kiIw+ngIfnVcNaLzMqVOUtwCFLZFD
	Upx87lCu6ZFzJZvAJM1it2hgJx1aNV/B2b6+NVA==
X-Gm-Gg: ASbGncuCgZuLe6fTgG5utSLoEJ0w70MZnZo/ug8kIgJlhL/X0PW6aX7iT/JQkwbPlWy
	e2ZjIelBe5m9QyaUiJHiYew/hJNvPrnzTt/owulOSFxvsKhzcamE0a9JoPPk7Bc33TI9mKTSj3t
	v4cXedAh8cc3F8QFxogyK/g9KXWg==
X-Google-Smtp-Source: AGHT+IGoVn0EU8OQQylHX1iDez6suRBDKS1M41QCK+afLZoIaTp9DDlChzEKRewCL4YZil1oG324vrVpsJNG5UcBgw8=
X-Received: by 2002:a05:690c:250b:b0:6fe:bf32:a427 with SMTP id
 00721157ae682-6febf32a43amr27741247b3.0.1741343001667; Fri, 07 Mar 2025
 02:23:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306113549.796524-1-ulf.hansson@linaro.org>
 <20250306113549.796524-2-ulf.hansson@linaro.org> <CAJZ5v0hhHv7P8UXEqtRMwC66aSqs115e8gN8rzn_QzZgnVULzA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hhHv7P8UXEqtRMwC66aSqs115e8gN8rzn_QzZgnVULzA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 7 Mar 2025 11:22:45 +0100
X-Gm-Features: AQ5f1JqZugkIR9PiHod2Oz80mHX8b_HvsiZotAhfpU29Uq7tx5I0h5ScmIr0gHE
Message-ID: <CAPDyKFqcCMGdZ9kfpkRi+6Y9wzf16WXAQjrio0-KwP9cZGJt_w@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM: s2idle: Drop redundant locks when entering s2idle
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, 
	Pavel Machek <pavel@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Mar 2025 at 15:34, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Mar 6, 2025 at 12:36=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > The calls to cpus_read_lock|unlock() protects us from getting CPUS
> > hotplugged, while entering suspend-to-idle. However, when s2idle_enter(=
) is
> > called we should be far beyond the point when CPUs may be hotplugged.
> > Let's therefore simplify the code and drop the use of the lock.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  kernel/power/suspend.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index 09f8397bae15..e7aca4e40561 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > @@ -98,8 +98,6 @@ static void s2idle_enter(void)
> >         s2idle_state =3D S2IDLE_STATE_ENTER;
> >         raw_spin_unlock_irq(&s2idle_lock);
> >
> > -       cpus_read_lock();
> > -
>
> As you said above, this is not expected to be contended, so it mostly
> serves as an annotation.
>
> The correctness of the code "protected" by it in fact depends on the
> number of CPUs not changing while it runs and this needs to be
> documented this way or another.
>
> I guess a comment to that effect can be used here instead of the locking.

Okay. I will update the patch and add a comment.

Thanks for reviewing!

[...]

Kind regards
Uffe

