Return-Path: <linux-kernel+bounces-234376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1E291C5E0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06438281A67
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3DD1CE0B9;
	Fri, 28 Jun 2024 18:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iJNYv2JB"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC6B1CD5B2
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719599745; cv=none; b=Vyq91XxZZYDAyehhmX2LOEE+YVyR23zooIYNC+WHKFEUsyUlRM/zvZADR1pTSrfn28hEWsHYVk5TglaoQFe3G+Dq4ZGSIRo+cNQCYiq0H6jHFH0pJMVPsObiP90IUOXMmFN8MdGUWcQPxqkMUzJzLTeP4QDIZwtuLSDIl4TWeXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719599745; c=relaxed/simple;
	bh=I2+vN1YtxeoCW1ZzBL6DjYHFnVPt3IlmCYIIwne0LuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUxl2wM38f3prXwQZ2/CPvt5E4hnk02NV1xJ6nK+Mhli++rj6xLIDhKmZCtlRYO6UvSJ1LaQaKuzj5zhhzo37wWzknnp8DG6Z6SWbpn5TgHC985vMfXi1ACwppZ36Vz5NpN6ut0DiGZlFvNsRtiQMwPyCzrjCFLdW3LaOiB9Rms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iJNYv2JB; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3762775e9ebso21655ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719599743; x=1720204543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RErrAs0DK8wPplxpianYaV5QcD/2TCRDQ9qb3zaOQoo=;
        b=iJNYv2JBTf+A5JAIIDso1eauUx5zJN4FU0KCNgiuvEFfIPvbRJBzNAq7MG1uvuEZaU
         F/r/St/PGmFfl+uNvARkm17Gpj56s11hWWgklNWDwI/QCz6I5aKPF2ofw+jnDR9zG/X1
         BDgnPD69dw5zTozkg0wAd10+RlwR9i+MtkBuq6SUFT3/tfsn2XdbLE9p9sttdqm8pcGZ
         nB+mml5ZCuDqsfwUASOqZ3VH90eyUZtQ1kLHbMxg3fuWTSINjoM/7r5zvqzCfvP/zB67
         GS0R0MTT75Yq75sUDoj6GDBfqUiG9LN5CPn8Vr80+TbHDozKRZwMSUdYXkith4tSzBIt
         ht4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719599743; x=1720204543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RErrAs0DK8wPplxpianYaV5QcD/2TCRDQ9qb3zaOQoo=;
        b=e+vVGyXssMHAWcI1PDkJyiATSrJZfy6btP87plgxLr5lKlLEPzpqG27/52HUulPmVJ
         crBYnBiz1KYTPQbcco3teoaYu6bAw6CQSw7zVHuapMSME8BC7oS6mH0FzMZqWXvUO/jN
         7lMmxMQRyhCV1o68Zfj1X4Ppq0NYaEqcVKsKp75L/Mr3lfolS3dHIJJq4oDDMUE59v53
         sztF1wZZywOifT9zTf1SsDqkxg43kwDSC6EM0ELGh8nKeRAN/ao6ddpPkYsKYVRgEDaC
         k61w8zLdlKssUPxkn11xRfsa/jO8bvauBPbtZD4Tc+z+qKbZ6O9hqTbZk8MBg8ZEvaZh
         87Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVVn8H7X7h15jr/YRx5zar1JxuvVJzZWgxYQEz/4k8ErwRbpe9VCLHqewrrnzgQw57oHWAuQGBKPOFFch3aA8SDy5fkA119KRpesUCm
X-Gm-Message-State: AOJu0YwZwFymtVu7ph8xPv1bkeClhgDQr+JY8pG6GyKsUHCsOlU5Prm/
	R6xe5ILUF7yD8Dk6hOt426X5AlGRo6pYBpOWbDEgKoQYLNIHIFAKxvMvJVUpL4N+6x0hFxOV5zO
	+rZZq5NssZXftyRNvFSGPQfnpm2ukdB+OOOAR
X-Google-Smtp-Source: AGHT+IEIdTlPMI5QX/9NDYi/RpkgzP+Z+ZzXVhld5+h7yexSsH86cZjoenbpLMSq/Lli4Dab5ND8vBPfg/LmAoRXHrM=
X-Received: by 2002:a05:6e02:156b:b0:375:eeb4:78fd with SMTP id
 e9e14a558f8ab-37c42e1f27emr210045ab.25.1719599743167; Fri, 28 Jun 2024
 11:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628183224.452055-1-adubey@linux.ibm.com>
In-Reply-To: <20240628183224.452055-1-adubey@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 28 Jun 2024 11:35:32 -0700
Message-ID: <CAP-5=fWT81saq2m+zaXrCsa_V-aqyZvNXDbQ28_wNSBo=-nByw@mail.gmail.com>
Subject: Re: [PATCH] perf report: Calling available function for stats printing
To: Abhishek Dubey <adubey@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, naveen.n.rao@linux.vnet.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, peterz@infradead.org, mingo@redhat.com, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 11:32=E2=80=AFAM Abhishek Dubey <adubey@linux.ibm.c=
om> wrote:
>
> For printing dump_trace, just use existing stats_print()
> function.
>
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-report.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 9718770facb5..6edc0d4ce6fb 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1089,8 +1089,7 @@ static int __cmd_report(struct report *rep)
>                         perf_session__fprintf_dsos(session, stdout);
>
>                 if (dump_trace) {
> -                       perf_session__fprintf_nr_events(session, stdout);
> -                       evlist__fprintf_nr_events(session->evlist, stdout=
);
> +                       stats_print(rep);
>                         return 0;
>                 }
>         }
> --
> 2.44.0
>

