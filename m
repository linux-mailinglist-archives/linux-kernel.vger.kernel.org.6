Return-Path: <linux-kernel+bounces-260129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C2E93A381
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C771F235EB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B758156F2B;
	Tue, 23 Jul 2024 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rg9uC+d9"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C15C155351
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721747382; cv=none; b=Ac1vsQ29CSukmlOMz/sm4/uOZX4TV1zV7q5Dr/aYUK5UZG/EOjUzccvzfBUdca/9ZiS/eVMz/1NiTYm1zmxze2yIFb8hVdDtBU3a5j4L5kp6cOxAiRKB4pucHR76U+GdBdlkKSY3/8QGmWDGluDVLK+0+zfZE8LjxSmwR1OfhZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721747382; c=relaxed/simple;
	bh=5G031YT9XT7YFHSEVlrz3bOBO8dw7jLrIIxZwVn0yig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emtfUD3ozRq4kDAaS6aGLtLEpiNf1Ggl+ulJcwVGVPTLJ20/H7IdzlZpo2QjyltXRkTkErtRDiksm3SYV+widdmRumDiliFvT0TR4pE4fOQSqbGUI+FyG2ufVKx3lCvBmWkYehbqNL+r/Txkgt3M1H6n/MWnyzZCsyOhNO4X7WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rg9uC+d9; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cb576db1c5so2872494a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721747381; x=1722352181; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OHtmeHUkZa9VAmNWyZWAYgFfFLiZeJu3qEKndF9+/HI=;
        b=rg9uC+d9MWr8Liv++wCPYW+rM9wyI8Nx/7/3Bt7FpCa1jGvmR3Ldsa5j6iAOKzStZL
         AUdirQWbVcoGV5RPOIijsFzoSDHeAGZBwh/fVqR0qAczxeURKgOzl1O+0pKnPuxLLRj4
         +ueVN3QlIuo80PLoEvYtUMmDhmb4vVBGBydIojhkIZucdDNbCPWDFpi3Eb8cLt4cr0hu
         cSJNCg2MVs/9yi+BOJ2hF0J23MvQkwCbLt4oCV9y76v6J8E/eUYJrJ3mPB86QCWYMFR6
         pGnzf3ep/Abqw5+Eh/O5CuQfh8haiQJmUENANoSM3UJ/j6cxXnmOztaNL6xuSw5PSQ5W
         5peA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721747381; x=1722352181;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OHtmeHUkZa9VAmNWyZWAYgFfFLiZeJu3qEKndF9+/HI=;
        b=QSIwRD2D8dkrmSajms/fJKfuzlqbHrtf7ZwzCdqFVye2IFRHs3cHOHALglorczFaJo
         lXPKUnk4keSJYGYihrokabP5FXQkP2wtEsn7mmPXZtUuFG/7meNO2SR7Vn30aZ8CC9H9
         //+3tVRmXVyj2XkgYl5+6WDEOMn31ph54oVsgdzy/gq/oUlsJKJxOlgqqiQZvpExvdmV
         YKNkgx/VbVCx7DP8Sg5wokSPKwXwrvqZIlkByHjc+hK4ZKAu4pemjqaxMKcBXzvtpjV8
         EWUwuxaZy0KLJKDOKAoJXH7aAjjd9qP/fXBqw7CSYlsFcKxJVUA/J7WN4Foxaq7wpPuP
         osqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvgunYbDDFMXnyMm14whIc3D4ET/Na6X4l/gdBoM/dzkLJi67lsCBzuC0ARyLdIfrTWAG/Aa6It3eln73FXTMREHz2ayUCIinvJI3V
X-Gm-Message-State: AOJu0YzGrAQb+RSBmZGAegNqrMpMJtdH+rDTCVIVfNL6kGvZCfSU0WVX
	uTNhtHN4HtvzyGdVouvO9ywcoz8sj9VRhiS6PLHwj9neZwRWCI9NVSQekEX/EginTix/wTS/X9H
	O7m8dMjwBuz8EDRshxuH2VLto2JgaFvEZveDrlw==
X-Google-Smtp-Source: AGHT+IHh4f5ljYPfeqEzD+jOmwYWcdYXnMSSP6kzzoIGBrszeKVncWzDok/la26tdtDvUhOhPZhyGhGQ33wdS+mt58k=
X-Received: by 2002:a17:90b:812:b0:2c9:7e9d:8424 with SMTP id
 98e67ed59e1d1-2cd274f029cmr6446161a91.30.1721747380680; Tue, 23 Jul 2024
 08:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722152756.59453-1-james.clark@linaro.org> <20240722152756.59453-2-james.clark@linaro.org>
In-Reply-To: <20240722152756.59453-2-james.clark@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Tue, 23 Jul 2024 16:09:29 +0100
Message-ID: <CAJ9a7VhLx0Zi0e-1qzcGCUWArkeD7vDkv0ewueDE_pYbmm5PVw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf cs-etm: Output 0 instead of 0xdeadbeef when
 exception packets are flushed
To: James Clark <james.clark@linaro.org>
Cc: coresight@lists.linaro.org, gankulkarni@os.amperecomputing.com, 
	leo.yan@arm.com, suzuki.poulose@arm.com, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jul 2024 at 16:28, James Clark <james.clark@linaro.org> wrote:
>
> Normally exception packets don't directly output a branch sample, but
> if they're the last record in a buffer then they will. Because they
> don't have addresses set we'll see the placeholder value
> CS_ETM_INVAL_ADDR (0xdeadbeef) in the output.
>
> Since commit 6035b6804bdf ("perf cs-etm: Support dummy address value for
> CS_ETM_TRACE_ON packet") we've used 0 as an externally visible "not set"
> address value. For consistency reasons and to not make exceptions look
> like an error, change them to use 0 too.
>
> This is particularly visible when doing userspace only tracing because
> trace is disabled when jumping to the kernel, causing the flush and then
> forcing the last exception packet to be emitted as a branch. With kernel
> trace included, there is no flush so exception packets don't generate
> samples until the next range packet and they'll pick up the correct
> address.
>
> Before:
>
>   $ perf record -e cs_etm//u -- stress -i 1 -t 1
>   $ perf script -F comm,ip,addr,flags
>
>   stress   syscall                    ffffb7eedbc0 => deadbeefdeadbeef
>   stress   syscall                    ffffb7f14a14 => deadbeefdeadbeef
>   stress   syscall                    ffffb7eedbc0 => deadbeefdeadbeef
>
> After:
>
>   stress   syscall                    ffffb7eedbc0 =>                0
>   stress   syscall                    ffffb7f14a14 =>                0
>   stress   syscall                    ffffb7eedbc0 =>                0
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 5e9fbcfad7d4..d3e9c64d17d4 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1267,8 +1267,12 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
>
>  static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
>  {
> -       /* Returns 0 for the CS_ETM_DISCONTINUITY packet */
> -       if (packet->sample_type == CS_ETM_DISCONTINUITY)
> +       /*
> +        * Return 0 for packets that have no addresses so that CS_ETM_INVAL_ADDR doesn't
> +        * appear in samples.
> +        */
> +       if (packet->sample_type == CS_ETM_DISCONTINUITY ||
> +           packet->sample_type == CS_ETM_EXCEPTION)
>                 return 0;
>
>         return packet->start_addr;
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

