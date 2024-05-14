Return-Path: <linux-kernel+bounces-178218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 143838C4A8C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4609A1C22DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 00:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9498815A8;
	Tue, 14 May 2024 00:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QSIyNAGz"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EC9A34
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 00:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715647495; cv=none; b=WWTjtcgczglzSRgi46+xQKp/ioNcAHcwrSV0t0WjQrdhhND9RrXCCHGGhWKV9ieLLR8R//xvAVk8JriVKwOhTG4pO47A7wQYFoMXOKjxzK2ghLvuxjRfQyFCX+LgEOAOKNhWzNDAIM33SB0FEa4lemvD7v+rDAx05ZBx4tMqxG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715647495; c=relaxed/simple;
	bh=hotnGKFFWEqENC+OuBeDoezU0EopsSKXL0Drl1zpfWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7q6hZYXmnxZU3tViSTGNHYbiwro6mc43phhZvXi05Q7NatcCI1P/iLJc6lzilpawAw8D8v+I0FOGVgQoyvmEVZvQywVi9OUvpV7+YGKneB1LTxm4MtK0ZqK3mLYOM4F/zBBj5C1P8JgueNUvoaPL0HyIntc7lUwWwXmuXqX36g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QSIyNAGz; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43dfe020675so1071561cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 17:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715647493; x=1716252293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6RmozACYy8ltoFttbF2c05dcjbPjMeLrBXKWJdWEQs=;
        b=QSIyNAGzt4Jy6jsYggK5WcTFdfmwME9laLBughcoPbh+gCIaDw8qvxSdglDaxI3YWe
         gqe3OPk2GpL36GYBUqneiwbZdP2ZZnNwK5FuiecH2HKE30QlFOlmX8rgVIuO/m1U1APu
         rN99ODwJox4xnGYxxrXtefX/kZ7ml7qvNhSM2AH2PLHkeXCNqx5Nnut+XjY8U4WY1tnG
         PDlTfKf8OhCyoyQd6kvXTlvg7Rx2FD3oytA49/NDD49WnLwXz02n7ZIb52/7vIJCxPs4
         FQIW36D4mMb/14b7jGcVXkDTnQT4tH8MWZCk0gf0f2lJyjhu+P3wMgOEy+Vto14imUhu
         qo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715647493; x=1716252293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6RmozACYy8ltoFttbF2c05dcjbPjMeLrBXKWJdWEQs=;
        b=MWZrFWC2vtE+HIYB8IKmIq9eoh6ykPLlaR0EKv+w06/ai4yVpTD8O6/XcW5mqbIOwA
         Fv+pEobTzuNcu4zwD0HITDFGsw2/VoqgTUs+K6oGQ9taJMV49S8DZPVkmG3iPzEOhklI
         ZfS7qwDpA9TcovwHUK4m6A0LOh8la8KKh8ATD6FmiwAn2+W4P83ejeZip0XQsC3YKNqa
         WkzueHgv1XAlnrcE66chEscwsljdBJtO/DoA4ZQAxDHMCjNsxMCh90CL88Qjc9RiUK0w
         flbID5M7VY1IGSA/RMJKZQOTOPHBGUpJiyIS9altyMzwOsbZeUZ2yf/dyXD2C0wabNaM
         /rxw==
X-Gm-Message-State: AOJu0YyTbwlrZTtcfjvgH87C5lY8kpwmHYpH6wIANKSSoofBr5mzAu09
	aVL2g/1OdpA/cv1yPHC3GRVvTjWsrbMRfvbDyKAsKaq/7U+P6PIALmhvNYCWyMjDbXZxGTieVqu
	0cBluKoI1y+b5UvEccAKsJdhpgCBuGMQNAS9I
X-Google-Smtp-Source: AGHT+IFNr4DUzcObxLrqd5Hy13a9Cu8+6IFvv0t+v2kKTE3AbueEhLmbtAk0f5+wF3jlpBQn8ErwjC3VJNPPbIocpho=
X-Received: by 2002:a05:622a:1b1e:b0:43d:eeb1:fd4e with SMTP id
 d75a77b69052e-43e092249fdmr6540261cf.0.1715647492443; Mon, 13 May 2024
 17:44:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513192439.18473-1-rdunlap@infradead.org>
In-Reply-To: <20240513192439.18473-1-rdunlap@infradead.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 May 2024 17:44:41 -0700
Message-ID: <CAP-5=fX020He2fdmm-tzFY383tSaaOB4q6OBzEtFHgXOW+S00w@mail.gmail.com>
Subject: Re: [PATCH] perf Documentation: clarify sysfs event names characters
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 12:24=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> Specify that perf event names in sysfs must not contain mixed lower and
> upper case characters and that they may contain numbers, ".", "_",
> or "-" as well.
>
> Fixes: 785623ee855e ("perf Document: Sysfs event names must be lower or u=
pper case")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: linux-perf-users@vger.kernel.org

Reviewed-by: Ian Rogers <irogers@google.com>

Looks good to me! Thanks,
Ian

> ---
>  Documentation/ABI/testing/sysfs-bus-event_source-devices-events |   10 +=
+++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff -- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events=
 b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> --- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> @@ -37,11 +37,13 @@ Description:        Per-pmu performance monitor
>                 performance monitoring event supported by the <pmu>. The =
name
>                 of the file is the name of the event.
>
> -               As performance monitoring event names are case
> -               insensitive in the perf tool, the perf tool only looks
> -               for lower or upper case event names in sysfs to avoid
> +               As performance monitoring event names are case insensitiv=
e
> +               in the perf tool, the perf tool only looks for all lower
> +               case or all upper case event names in sysfs to avoid
>                 scanning the directory. It is therefore required the
> -               name of the event here is either lower or upper case.
> +               name of the event here is either completely lower or uppe=
r
> +               case, with no mixed-case characters. Numbers, '.', '_', a=
nd
> +               '-' are also allowed.
>
>                 File contents:
>

