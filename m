Return-Path: <linux-kernel+bounces-521536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BE2A3BEA2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F59F1896B4F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308AA1EA7F0;
	Wed, 19 Feb 2025 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CiB/OEFk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D4A1E25EB
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969374; cv=none; b=MkXpY4LXlYCQYscLHayUGPYRS2ioDVI7m3MUbMuWt8MeIQTPDKa3VVjlQip8jaEEZIwqSD57rA5lTUeWsFae75DVnmhXgD65aB/Th1CfCvOR3HfXDh8v+7svbK9hjc18JVIW7NjATU8lqv7bFukBSY8umEgHQvsaxS3mGCOkX8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969374; c=relaxed/simple;
	bh=EDsmNvJG6i+8D4LW00y//lAFbtwrmRk1VHBMZ8wJodo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cb+AkQ6VEZR2LasZOjrRlL8LvD2eWVUev5Q30O0ELk3wJxNM9zg2bS0gxGyRI8Ops2vsSfOunGMJW0NbBur2P1wfxYlIlyzQW3TDu1CiVE65tiqSKOqhEN+em9RSxVOyHLExZAeGAGoATAKmQldrlFx4d3snd4r6jgbuvMGAog8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CiB/OEFk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739969371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rreqea7gob/60z8pNTfWbKUJ2v9iqUromgRXlIzbXP4=;
	b=CiB/OEFkxk2tb6hs/ZnQO1aua9YctlNMaSDbk804ENTaR0tUHEKfPhbGF2cpIxJrJJtjMe
	V6Sz6teooo+b1AHGp+QkPihkQjFejCC+JU0hkV/+nJ/8mFfVAiMEuqga6bwqVHCMe481jU
	aaup/XymcX4f2BR+zZ+rA3ykOMsoAak=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-EitjDsBJOxadC6JHWGsBTw-1; Wed, 19 Feb 2025 07:49:30 -0500
X-MC-Unique: EitjDsBJOxadC6JHWGsBTw-1
X-Mimecast-MFC-AGG-ID: EitjDsBJOxadC6JHWGsBTw_1739969369
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e04de6583bso4235620a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 04:49:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969369; x=1740574169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rreqea7gob/60z8pNTfWbKUJ2v9iqUromgRXlIzbXP4=;
        b=ADcGjPXYd+ISBFGNX6b9BhgHWkpby3x8Ng8eqK/drk894mVTEAfJwHJXJncCoVN/Un
         3SA99lT5SwGVWitx9qFDzHbQspWKE5Numt55N8PgjQoRrydhMerPISI/MNaWFG3odIQC
         QoNbDJfICGV+Axb68yJzGUScEKJCiKSSpQW+iJ34zRWXPHVcST7CxsCmYJ0KNjSJWlJU
         2jixb6AMUWvsZ2AbYrzMEgZFyBRDLbYjk3o04PLCdKb1ogmjYYQtfjJV41TrVgzakRFX
         sT8ZhWDLXL8itDWch74p/8/Ck1KOD0TAzMFfuwcxmWiD+Iw2KzPMH/XpxF0atDisfxr7
         khww==
X-Forwarded-Encrypted: i=1; AJvYcCW6m+gM/NaMxUyfAIwD5sVyjYtxivTjZF8xzBzxLM0xfX9s+9ZWHi1YqmLP8O0WC1tumvTscCZHufZubAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUSRKsdkH1ivEMd7OYrL9svvWlN3M3LTYwGeOFU9uU4QnY1OKY
	7yk6Rg1/gHHcGpMFp/2+638vfgUKOUD2IN5iSxXjMhewDwWWcvuI7lhrhrkG0DgN6Mpcz4Xx6D/
	ZXwMnbAl/B32ymU7nI1aB5jyH6/ohpftFIgn0J5qcYbmNfhwsBM46/qou9baJWy3zlR8qwni9ph
	lwh5UUaoIIfpsdYZLHR+w8jwrxzxpJkmn5NRER0HB2ev3AqmI=
X-Gm-Gg: ASbGnctnQWpIw3RYiMRhFVEqyDAA8Ppg4qMtYNxEQ9ozHLx5y3sYrrJFTz5ZpcGYtMN
	xVjK7u8eDTth6cvUvLE2RRWzrTcxwxiOiZN1SYGpVQ+0SAlFXVdSjsFsSXVJsuM7Hl23ftsMA5B
	WFcNJ+ebODwR2mtpl7
X-Received: by 2002:a17:907:6ea7:b0:abb:ca31:8877 with SMTP id a640c23a62f3a-abbca318c12mr501706066b.0.1739969369090;
        Wed, 19 Feb 2025 04:49:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrJ+KooYm5EcqJPGxQt1LpLB0CkdlVYG1NrpzXOwYPi/3fnsFqEB+yJ0oIwBQsTdFJa5qKOomUHiL7yERHl2g=
X-Received: by 2002:a17:907:6ea7:b0:abb:ca31:8877 with SMTP id
 a640c23a62f3a-abbca318c12mr501702766b.0.1739969368673; Wed, 19 Feb 2025
 04:49:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219115138.406075-1-costa.shul@redhat.com>
In-Reply-To: <20250219115138.406075-1-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 19 Feb 2025 13:49:17 +0100
X-Gm-Features: AWEUYZkYvfK5JpbvU46W1SFw9D0VGBjvXAvqoPqgQy1IV8AabKtxO-Spu2r3qzQ
Message-ID: <CAP4=nvQ=qj6STkXH=iDvpcesgj-0aBXPhHhXc5POyjWuwuzWYg@mail.gmail.com>
Subject: Re: [PATCH v1] rtla: Refactor save_trace_to_file
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Daniel Bristot de Oliveira <bristot@kernel.org>, 
	John Kacur <jkacur@redhat.com>, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, 
	Eder Zulian <ezulian@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Gabriele Monaco <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 19. 2. 2025 v 12:52 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> The functions osnoise_hist_main(), osnoise_top_main(),
> timerlat_hist_main(), and timerlat_top_main() are lengthy and contain
> duplicated code.
>

There is definitely a bunch of code that needs to be unified in rtla.
My idea is to eventually merge top and hist, see my note to the cover
letter to the BPF patchset [1].

[1] https://lore.kernel.org/linux-trace-kernel/20250218145859.27762-1-tgloz=
ar@redhat.com/

> Refactor by consolidating the duplicate lines into the
> save_trace_to_file() function.
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

Thank you for the cleanup patch.

Reviewed-by: Tomas Glozar <tglozar@redhat.com>
Tested-by: Tomas Glozar <tglozar@redhat.com>

> ---
>  tools/tracing/rtla/src/osnoise_hist.c  | 5 +----
>  tools/tracing/rtla/src/osnoise_top.c   | 5 +----
>  tools/tracing/rtla/src/timerlat_hist.c | 5 +----
>  tools/tracing/rtla/src/timerlat_top.c  | 5 +----
>  tools/tracing/rtla/src/trace.c         | 4 ++++
>  5 files changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/s=
rc/osnoise_hist.c
> index b4930b835b0a1..7c6ef67ef3e6c 100644
> --- a/tools/tracing/rtla/src/osnoise_hist.c
> +++ b/tools/tracing/rtla/src/osnoise_hist.c
> @@ -983,10 +983,7 @@ int osnoise_hist_main(int argc, char *argv[])
>
>         if (osnoise_trace_is_off(tool, record)) {
>                 printf("rtla osnoise hit stop tracing\n");
> -               if (params->trace_output) {
> -                       printf("  Saving trace to %s\n", params->trace_ou=
tput);
> -                       save_trace_to_file(record->trace.inst, params->tr=
ace_output);
> -               }
> +               save_trace_to_file(record->trace.inst, params->trace_outp=
ut);
>         }
>
>  out_hist:
> diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/sr=
c/osnoise_top.c
> index 4772677ac762c..0eeefbbbf3173 100644
> --- a/tools/tracing/rtla/src/osnoise_top.c
> +++ b/tools/tracing/rtla/src/osnoise_top.c
> @@ -813,10 +813,7 @@ int osnoise_top_main(int argc, char **argv)
>
>         if (osnoise_trace_is_off(tool, record)) {
>                 printf("osnoise hit stop tracing\n");
> -               if (params->trace_output) {
> -                       printf("  Saving trace to %s\n", params->trace_ou=
tput);
> -                       save_trace_to_file(record->trace.inst, params->tr=
ace_output);
> -               }
> +               save_trace_to_file(record->trace.inst, params->trace_outp=
ut);
>         }
>
>  out_top:
> diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/=
src/timerlat_hist.c
> index 6d7d0a2d45b47..5f54b268a1033 100644
> --- a/tools/tracing/rtla/src/timerlat_hist.c
> +++ b/tools/tracing/rtla/src/timerlat_hist.c
> @@ -1390,10 +1390,7 @@ int timerlat_hist_main(int argc, char *argv[])
>                 if (!params->no_aa)
>                         timerlat_auto_analysis(params->stop_us, params->s=
top_total_us);
>
> -               if (params->trace_output) {
> -                       printf("  Saving trace to %s\n", params->trace_ou=
tput);
> -                       save_trace_to_file(record->trace.inst, params->tr=
ace_output);
> -               }
> +               save_trace_to_file(record->trace.inst, params->trace_outp=
ut);
>         }
>
>  out_hist:
> diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/s=
rc/timerlat_top.c
> index 05a9403b01d26..1e64e6216bc2e 100644
> --- a/tools/tracing/rtla/src/timerlat_top.c
> +++ b/tools/tracing/rtla/src/timerlat_top.c
> @@ -1159,10 +1159,7 @@ int timerlat_top_main(int argc, char *argv[])
>                 if (!params->no_aa)
>                         timerlat_auto_analysis(params->stop_us, params->s=
top_total_us);
>
> -               if (params->trace_output) {
> -                       printf("  Saving trace to %s\n", params->trace_ou=
tput);
> -                       save_trace_to_file(record->trace.inst, params->tr=
ace_output);
> -               }
> +               save_trace_to_file(record->trace.inst, params->trace_outp=
ut);
>         } else if (params->aa_only) {
>                 /*
>                  * If the trace did not stop with --aa-only, at least pri=
nt the
> diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trac=
e.c
> index 728f5029d5335..74ed2f6208baa 100644
> --- a/tools/tracing/rtla/src/trace.c
> +++ b/tools/tracing/rtla/src/trace.c
> @@ -75,12 +75,16 @@ int save_trace_to_file(struct tracefs_instance *inst,=
 const char *filename)
>         int out_fd, in_fd;
>         int retval =3D -1;
>
> +       if (!filename)
> +               return 0;
> +
>         in_fd =3D tracefs_instance_file_open(inst, file, O_RDONLY);
>         if (in_fd < 0) {
>                 err_msg("Failed to open trace file\n");
>                 return -1;
>         }
>
> +       printf("  Saving trace to %s\n", filename);
>         out_fd =3D creat(filename, mode);
>         if (out_fd < 0) {
>                 err_msg("Failed to create output file %s\n", filename);
> --
> 2.48.1
>


