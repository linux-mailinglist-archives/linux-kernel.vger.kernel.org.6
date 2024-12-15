Return-Path: <linux-kernel+bounces-446170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1E39F209E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 20:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3FBA188576B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 19:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3421B1AAE39;
	Sat, 14 Dec 2024 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FABAKGPB"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87D7195B37
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 19:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734204762; cv=none; b=SrRNhx+99P+n1eLPiFHIeVMSXk4sW/fQR6+LcO2XjT3PVlHqd1iR63FmBjQUv1keECRBUKLMB+Vii4OY7a18k/FEo6sh61X3m8ibIlAgZP7YhUFX6Uuac6Y0p5GnyQOc29ZISJaIYfGCG6Sd2wOOt0oDzUISUukrockW+AUlX+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734204762; c=relaxed/simple;
	bh=5Jn6S+PCzo7AtwY/ECptG9xjtJQeXvtl2DfkeEJVwQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=vGmahYCNL49qf1cp1T6Q4IXZ0/NYiQtuCif8jnF60jbsWPYJMSxrfIfdTz60UeITKMVO++Y5PJDD8E02yQYteRWvYOyepHw2cxsNwl5pQG0/9UGaqF1ZkgmV1sQVc6X2IX9qO+YYCjWnX7OWq66uW4DuRaNUi+hE3Oe7folEpTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FABAKGPB; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so127195ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 11:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734204759; x=1734809559; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ifcfCthQDxy8ySBkB1RvsW8y2Gn8eCLwcVlMpuAFhk=;
        b=FABAKGPB2fqG++cv2YvXkOIXKv+wO0QQ90KfG8FAD9C7Hz8I6O3g0i2XB1CRAE1u0p
         /vnyUHwZRsHis6RNN4AysTmHnNzhLe/ZE4R6Sz89Qkswp/01zuqLuB7Hxm44kH/u03bC
         EY79L6tPlemP0U6KYnQx1iMthAL4XG/3DPdcFlqIBlf8JYCAC6EQN4a+Z6R5kMMYcKWe
         bdmDr9D1LMN0QvzvK1I5raWebqMLPjgVUhUjkPn+9YwSoF8o/MbnlM1teTd52bgp7tFx
         Wn+NXxatirwLqmPX/rs1oHzs1bXvkc3D3NeWL+mdMnlMWbBo2fE+B1JpQbYnhvdci2fl
         ehng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734204759; x=1734809559;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ifcfCthQDxy8ySBkB1RvsW8y2Gn8eCLwcVlMpuAFhk=;
        b=alhoJfm/LOqT51QAqjarLPz4mcsoPTH1SevAvILdxbhkzyxAWtMOE6QftNJKUwyvCj
         oUyRd0u4I4bUsaInJpA3craGrgdqzi0oBYJVwy1oCvXyMpcgxLUMfOsMW3y7ptgb1M+9
         sigYIPKNgDf7WD6lzXw3IMBsK2Tn/OdUlTN9i/YlyHLj89lPF9sNppSaA9hIkfdSuZOt
         M2uLdluxnJUsabmzFsWp9qFOU/4v1zryIkEaeVlmzoTRyYiFQCWszRznh3yirYstZEG2
         3MNZ283lyQK/5cbWXH9+cplxBMWnwTkqW1tLZBi/y25+Q6NRKBcbYWLZQu0yUh2nXH5O
         LUAA==
X-Forwarded-Encrypted: i=1; AJvYcCVJFrBRGPPO7xQ7fqw0/Z81bS+Do3Bq/J2q0bJo/NTKbDX2R8czl0GZDsXW22ZtUf5ZA/79TbbCgr5w4VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyflO5xlzPFmki7azFFCBU/4D1m1Ob1eEioCQ/sre/wzJxbNSGd
	WXxnmPveSJi9mvWBW66fykwZ2Rue+RoU8wgAv6GExdXb6yEIVb/wIl50i0Ew4XxmBwhvAYnER5C
	dpsW+iCz4H+u3jBhcGHtRd+6u2Qp8R7BPa80+
X-Gm-Gg: ASbGncs6qCSgjTQPuXheVUQmNOA0XOwFWrI+6NgdP9XdpEgzKPF4U+0s4n7Bnz/DMsK
	PapdnymzBC6pZIQsNMzYbo6HDiae2uwgw1rYqP4s=
X-Google-Smtp-Source: AGHT+IFGhEb9ifi4P5jJR6XUfQpzX49Z5lgclmZFwa3AsU2s1eMDMawXBOKA5N9NN49ZI2HTuN1WkAnYhYmJiUN64C4=
X-Received: by 2002:a92:cdaa:0:b0:3a7:e616:8d36 with SMTP id
 e9e14a558f8ab-3b2c59470f0mr1754295ab.9.1734204758801; Sat, 14 Dec 2024
 11:32:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212080530.1329601-1-irogers@google.com>
In-Reply-To: <20241212080530.1329601-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 14 Dec 2024 11:32:27 -0800
Message-ID: <CAP-5=fWtxkt_kFCF8G=Dp4Fj+=m1M7Fv6Ep4RvJmH_k-k53rNw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] perf synthetic-events: Ensure features are aligned
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 12:05=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> Features like hostname have arbitrary size and break the assumed
> 8-byte alignment of perf events. Pad all feature events until 8-byte
> alignment is restored.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

This change breaks pipe mode tests for me on ARM. I've not investigated why=
 yet.

Thanks,
Ian

> ---
>  tools/perf/util/synthetic-events.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index f8ac2ac2da45..5b14244253b5 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -2401,6 +2401,11 @@ int perf_event__synthesize_features(const struct p=
erf_tool *tool, struct perf_se
>                         pr_debug("Error writing feature\n");
>                         continue;
>                 }
> +               while (PERF_ALIGN(ff.offset, sizeof(u64)) !=3D ff.offset)=
 {
> +                       char c =3D 0;
> +
> +                       do_write(&ff, &c, 1);
> +               }
>                 /* ff.buf may have changed due to realloc in do_write() *=
/
>                 fe =3D ff.buf;
>                 memset(fe, 0, sizeof(*fe));
> --
> 2.47.1.613.gc27f4b7a9f-goog
>

