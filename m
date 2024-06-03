Return-Path: <linux-kernel+bounces-199449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657278D8757
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885241C215FE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F06136994;
	Mon,  3 Jun 2024 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhbLN/BV"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DC46A031
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717432381; cv=none; b=RINPx66n+2QdNi7lyyKZS7ykb5Fq1AioTRh6GKhGkujcdG6i69295M1ntCyAWJSxrG3Z7zHj9uicv8xdXgQsi9rZ8+RlO1mwsZED7jaIGFLNbVewXvS+4JrhHE+27+DCHbK3mVRDI+fihfUl6eiws9+Ft7/k71Y9dIJwuTEBHzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717432381; c=relaxed/simple;
	bh=SwyAAsQo5LPigjyVrJh9TE3RAcBQUO6hlyM5El9jJtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tc/NZlUetoe6G4kIyZ2f9nxtHAE/ZQjJSdigqhGDgBiJtwTV9JSIospEUT4MTy3sTVqSZrkKnZdI/G61X39FTtrNgNV78l4dS+hAj1kt5rU+aOgMLY1VJwj207TWi1GO8feSoX+qIbTg/QOb35iXqTXmsfGv7B0dV9KG7oErhQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vhbLN/BV; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-440075abc22so340061cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 09:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717432379; x=1718037179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjXuAqR4EYQTQU2Kd98gpGTnvGi9iTYHYeoY30Mkzb8=;
        b=vhbLN/BVxX5n5fC6Bn33MNJJ87nFvTvdt9ieBJvPxfnPcw4llbjKS5xdwNVPILTTR8
         kpK2gu8OBgeKsQtHzgAXXipx6Q0ZSuibbz62c0k8LH4OUA7hwXU44W68kC+B8QIo59J2
         If7Aj6x9d7sasIrFVTbuGhK6R73QY5x3U5C7ChjbPjaifdkPt+JOn5+rJdZetZRnp3co
         xSb9iBJovr8E6AenzZuhBMz65Pr3kP3D9O6iJcpDv//UMl1dVHuHWD5MPbPG7zGU5QcR
         lXjemL7EoHY4cPalSJFYf8E6/9bfHLHFmHnQh/r4KnKpk9FHAWH/iTlk3p9bJQCulT5k
         HbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717432379; x=1718037179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjXuAqR4EYQTQU2Kd98gpGTnvGi9iTYHYeoY30Mkzb8=;
        b=MmqxerblHioYlfdo1LG4Q6xvB1kpCap4a82NO2xg3qpobqu3lp9GRYD3NGOZYSVVSH
         k950DFe9NZ8+1NfQnPfuDuLGmrAm3CUfC2AsHwCGIZUC8kCfybk/xdWlJJLmBs+Qf2pf
         e/p9Hvi58biR3ZTrLU5uCs+XGE8g/i1r+OHozC3Yd2obUvqEoZAlJdDJKdyClLsfjFKo
         QvHVV9gc9qq+Bu0UF/N1CdMP6GuY1JtL5KeHqb72TR1jhr3u02YPTfw4fFiW4XSSjNlX
         ZD3kNBnY0Ic38BI9pHiqO2LAIlvamoxsnxTbzcmWP4ScjIfYOkMCbvC8aSFXnirL9SmC
         dqQA==
X-Forwarded-Encrypted: i=1; AJvYcCXdxjtQb9e3PTkLVytbTirJlhlVudcBlWtHOMm/60mjePHQ7gDcseIFW5z/17CJE+9WWgZGmwNpT82IgN+nRHAf+/HVciKUC7gbIjH+
X-Gm-Message-State: AOJu0YyV43uDHvMF9t7YUSLs5tNb1on942RO+/3cvWA/DQKRfFE5LAQ+
	oe/wFqzosbJyrcYdpXPDGqtnwwfepO3V2oZa5orhDOjY0SljE6JqJWbEWSslv61vgXiyIkHWlga
	a2a76vdXQbBtcT7LgiiZQIVhC9JyL0HGJZ6nyJpSRPafOh2x4h79JNAQ=
X-Google-Smtp-Source: AGHT+IHJuWInCRTDMlvTj/RdEeJeBxSy/8tT4IotZuca6cMAB+u12gC4Z3gU+2rP8k1Jw6COZaoHA2CUJ2x6Vz27V7s=
X-Received: by 2002:a05:622a:a709:b0:440:3e3:5730 with SMTP id
 d75a77b69052e-44003e35ac3mr2074601cf.14.1717432378882; Mon, 03 Jun 2024
 09:32:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602000505.213032-1-linux@treblig.org>
In-Reply-To: <20240602000505.213032-1-linux@treblig.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Jun 2024 09:32:47 -0700
Message-ID: <CAP-5=fUbtFd2V=cjSHd-KgFmrGQnncS5p7FXTNpL5kA+19qRNA@mail.gmail.com>
Subject: Re: [PATCH] perf genelf: remove unused struct 'options'
To: linux@treblig.org
Cc: peterz@infradead.org, mingo@redhat.com, jolsa@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 1, 2024 at 5:05=E2=80=AFPM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> 'options' has been unused since
> commit fa7f7e735495 ("perf jit: Move test functionality in to a test").
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Hi/thanks David,

Reviewed-by: Ian Rogers <irogers@google.com>

Ian

> ---
>  tools/perf/util/genelf.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
> index ac17a3cb59dc..c8f6bee1fa61 100644
> --- a/tools/perf/util/genelf.c
> +++ b/tools/perf/util/genelf.c
> @@ -54,11 +54,6 @@ typedef struct {
>    char         name[0]; /* Start of the name+desc data */
>  } Elf_Note;
>
> -struct options {
> -       char *output;
> -       int fd;
> -};
> -
>  static char shd_string_table[] =3D {
>         0,
>         '.', 't', 'e', 'x', 't', 0,                     /*  1 */
> --
> 2.45.1
>

