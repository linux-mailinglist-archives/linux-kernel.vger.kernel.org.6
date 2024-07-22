Return-Path: <linux-kernel+bounces-259191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EC1939267
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E4D51C216C7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B7E16E886;
	Mon, 22 Jul 2024 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hk2guBwH"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162381804E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721665020; cv=none; b=G0e733X2UIeJSwA8++wgOaKkONZITpqy2B5+OTzVvXtSDM6Fv3buDXlZsFbjF1AneHMeG7RGTJ2Z2g8H2pn2c9c8hfV73S/Krv7HYcEAXvkOBY04wRW3cMyeMUhezdDcTanPDJtybjBDfBDDhxL1HYswXsIDDT93X0pZA28T7jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721665020; c=relaxed/simple;
	bh=6Gsk81WeH6DvE4tX61P/Mt/obOnYGk14eTFU+HVGNKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFctESq7v1BltFIJDj0NMwR4NkM5LSEr6Uc9IrXFFFbf3kkEFd9IwFWuPMRKfFqKDhKOWG+39fWYgqvsP6LRyp+wJyodI3a3Zcji1Sr0SW+ocBxQLXbwPqWXBfmEwD1+96aRhCUGqo98DsN9eXprzoiDkiQWw58KcgZZ8zVgOfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hk2guBwH; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-38b3543541dso560425ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721665018; x=1722269818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdGV+l8J2hM7fv/FlUa7Wq6WlLTG8Ht4/K+xLQQTCkg=;
        b=Hk2guBwHR4XlJFudCuvX8SRto4F+wjx0dvVkoxACA5iBbLc6RZL3UQt2/k+jypSWpr
         7R0Cp/XogiN5Tvp8OdMBoI8HWnPewhqpTMrOOEojiaI557INNFrK8p+iGsS0QHNS4ijD
         glHrFbyuJt81t8BcHlluw+bMjnb1ycslP7uO5VWQELBdKtF744j0G87IOZ8qGl+XKRuD
         AZ+XK35MWL0ppVRc6aewKGuq4W+15E8RrVqPA/SyNjKGYFotTmGLuRCopQSey2hKwywc
         ZlUDmD1f17Kfcvb6USsmniY4zq5L1KinZwMtKaYMZV7RqxcYvzYIpFgfJxtQNnww6hop
         D1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721665018; x=1722269818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdGV+l8J2hM7fv/FlUa7Wq6WlLTG8Ht4/K+xLQQTCkg=;
        b=CDCjsQ+jxXWES8w+muvd+ktLRzpAgHQtM2ms+7dQxv3AY/SjXzL82FkeAwqy6V/SAL
         dg3IgAJktJQcUF7HB2FOh/8+wjixGs2Oel8JyPhVM/CS5ydrIE0f9uXNLCTlLNUhNOkD
         I9LN+XR5uFp4ybgHI5coOfXk3mwhtUFA4iUG5ieMsCG/wzN376VpImIDr00l54EZaVpO
         PYmgEYJrWWY2ldM/0BZVWrPcbUDzoRHPoDEIioUdf7dIUA2miCZxwxJcvq03ZClWMUq7
         762/E9oe4yl6D94JxHLkJEYejB8fYtofeoxeWru1OewxS0IfSMHbQuxIFAotntd6XwWV
         tlbw==
X-Forwarded-Encrypted: i=1; AJvYcCW+aQtHXHcSnPVuXZ/rs6/hSDDl54sTfyXJ6jKguNB588HHiJfOqzZhDaAvOgd2S91XgNRs/br4pIwrQ62d1UwoSMa8ggNGSLYULoEx
X-Gm-Message-State: AOJu0YySqaif2wmKp8iBQ3dMiCGnPOoQPaA8gtslvBrHAg8ERmHAtZ9Z
	MWHcZ1JeE/jFa1GD1xBBCZAuAwhe10xcQ9/J002Uxf9e6z8UX11zrCrwVfh20Ev7f88DwfF5oT8
	yj/LQ/ohHpjrFRynVtNWDrYxe719QYt6TlvFP
X-Google-Smtp-Source: AGHT+IHxK94eUMozfDDRBAENF9nSqWstRggS+pONhrh2+8iovrfLH3WBQq+S1YOxXE60n14f2c/4EOjXG42L3Vu3RtY=
X-Received: by 2002:a05:6e02:148e:b0:376:257b:a110 with SMTP id
 e9e14a558f8ab-39934707d23mr5712405ab.10.1721665017859; Mon, 22 Jul 2024
 09:16:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240721202113.380750-1-leo.yan@arm.com> <20240721202113.380750-2-leo.yan@arm.com>
In-Reply-To: <20240721202113.380750-2-leo.yan@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 22 Jul 2024 09:16:46 -0700
Message-ID: <CAP-5=fXr62AWU_g=Lymf=8wO-9FF-eEEsoBEYHdqxxdD0qgbnQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] perf pmu: Directly use evsel's PMU pointer
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 21, 2024 at 1:21=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
>
> Rather than iterating the whole PMU list for finding the associated PMU
> device for an evsel, this commit optimizes to directly use evsel's 'pmu'
> pointer for accessing PMU device.

The code doesn't do that:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmus.c?h=3Dperf-tools-next#n698
```
struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
{
       struct perf_pmu *pmu =3D evsel->pmu;

       if (!pmu) {
               pmu =3D perf_pmus__find_by_type(evsel->core.attr.type);
               ((struct evsel *)evsel)->pmu =3D pmu;
       }
       return pmu;
}
```
That is, if the evsel->pmu is not NULL then just return it, otherwise
find the pmu using the type from the attribute. Any linear such should
happen at most once unless the pmu is NULL from event parsing or
perf_pmus__find_by_type.  The PMU may be NULL for legacy events and if
sysfs isn't mounted. If you are encountering that then maybe we need a
flag to say don't find the PMU for this evsel as it is known NULL.

Thanks,
Ian

> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/util/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 986166bc7c78..798cd5a2ebc4 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1199,7 +1199,7 @@ void perf_pmu__warn_invalid_formats(struct perf_pmu=
 *pmu)
>
>  bool evsel__is_aux_event(const struct evsel *evsel)
>  {
> -       struct perf_pmu *pmu =3D evsel__find_pmu(evsel);
> +       struct perf_pmu *pmu =3D evsel->pmu;
>
>         return pmu && pmu->auxtrace;
>  }
> --
> 2.34.1
>

