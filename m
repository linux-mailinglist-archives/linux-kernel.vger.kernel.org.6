Return-Path: <linux-kernel+bounces-249485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B318A92EC4C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69961284914
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE1A16A923;
	Thu, 11 Jul 2024 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K2Z6J5bV"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555C516C86A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714125; cv=none; b=g8yi7TrrZF5xhDDgEtLt817ACax+B7EoTM6GMy/WFVVlISWhS3vI8uMawqMZaktexYhIeRQTwxA2cBSpu+W/BsmThBSKAKMLav6X79rfVbrPkcJ2EolXnSvuzRZepJcjFFYq2JMxFbb0jtkA5ys8n+oCskQ4evtFBtaoVixdPTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714125; c=relaxed/simple;
	bh=kY5IJZ4cikqhqf40Y/iuj0LM+o1ikDZwH7ZJwpsRXmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktOcM1YNADTtioPbk+uVUiHL0D6TNpxrQyLv/tRdV//oSyhJcfPK8FVLnf2AGYRekOaNJVuJCwjwb3m2JF3IbIszY2s4leGDtiKhQZOw7cQ7nAnsPBIh7iNvCJvyqIrk2mgXs579e3gWxdw+MA4KYuzn2a+bNqo+3tmJ5QhN+xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K2Z6J5bV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fb67f59805so157035ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720714124; x=1721318924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQSa5gKT+eKn4P0zkPKjQyLYQdgXXMN3YnW0vi5qP9U=;
        b=K2Z6J5bV/WcU2wVI0R3iyWs8Dsx2aBvle29pFYGA/1tODyFU7xkKCtpCms0NZRs9RG
         qjp6AjXr6asXGcc/B7dhVKwkhkrziyrg6AVB1/0AHGum/GQ1c0MauX6QstoQLPX5DHYQ
         27ayqte3PkGV6k/rhQgqyU1dMe+bWMT+Y90GCwZW0N1ZfPWQzaO2gB5ZXeYql0xdEsqp
         cclJK/DVWa7cQgqHzb8kYvARSaghZfoTrnpohWSt6RzNZbmONJU5OeIgJy5TwDGLot9y
         dWsBsKCslJDmwuC2vEEsfTwRBLHTMl8bDwXrc7wogoBNk1xiXW2vLIOV9qUsWl9hFDfj
         6bBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720714124; x=1721318924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQSa5gKT+eKn4P0zkPKjQyLYQdgXXMN3YnW0vi5qP9U=;
        b=RamaQNFLavFpsKtkIKHqbKLnlxeN0J71yy7PL7VK96foteF17itTRJkmwzs8KE7wfj
         HVxIJNAvxfAMaHvEJRi9yV0YVQK8e68ltCNhhRV9L71ZTswSeTgwc68GbpdHnfvo8aYW
         3/YaDzsTNE8HDyK6opQ/m+z9QGh+wyYmwBWKn0gGTxy8ywoagiP3bRIBY5oqOlmb7IVr
         L8ikDiByJZecTCRjiJlEDkf0Dn3FDxF9lj6YZlti73joMRoM9Dmf8IT07H7MBidTZWDS
         7L3OKFkqoAPlIuMemHBC2J6qwuxlvY9r3RvMvcEYgA/LB76cjTV5TaGSGsK9FBuFaRxG
         sbRg==
X-Forwarded-Encrypted: i=1; AJvYcCUKVnjWPiaJ8d6UGvjE6FeXAIaBe9daRbBvkajx/9ehIk58ynWhHkSxJXAgVWdTMIjrNVfsBAWR29Y0hnX0M3dd2GAtfKGLlexe0oFw
X-Gm-Message-State: AOJu0YxDiZ7YcuHSFDFNdsX+E9CEFCIBEFvDCRjoF7lAX20XTvUWx+a+
	ohkD8tSdfeJ135dTiK/GSd29w33dsPiDasiy05ACCxhk8PwDiovrCXz+CqLkiJ3/sABdYXsnLwV
	Tev2CtmEw+4m/1Gro7sg2Eq1essJKKkRHz5tF
X-Google-Smtp-Source: AGHT+IElvTnqaWO9R7urpZJutwvE+MMjdeEGJVTWB+RvH5lxKcz23FQGzGtnmWxXLdNYPtGOuFpCS6RTfBslR59gJ8I=
X-Received: by 2002:a17:902:f28c:b0:1fa:9627:d363 with SMTP id
 d9443c01a7336-1fbdec43278mr2668445ad.11.1720714123218; Thu, 11 Jul 2024
 09:08:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com> <20240629045350.285243-2-irogers@google.com>
 <d55916c7-a771-4fae-8bc8-595b7b1e9861@intel.com> <b4d28088-3de5-43a5-a4b6-12d3a29244b7@intel.com>
In-Reply-To: <b4d28088-3de5-43a5-a4b6-12d3a29244b7@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 11 Jul 2024 09:08:31 -0700
Message-ID: <CAP-5=fX+VG3HsAPb=3DzEp2bUyAUvHk7f1zAhq3r=FKYaJPW6Q@mail.gmail.com>
Subject: Re: [PATCH v3 01/28] perf auxtrace: Remove dummy tools
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 11:46=E2=80=AFPM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> On 11/07/24 09:43, Adrian Hunter wrote:
> > On 29/06/24 07:53, Ian Rogers wrote:
> >> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> >> index 0ec92d47373c..44db5b49128f 100644
> >> --- a/tools/perf/util/session.c
> >> +++ b/tools/perf/util/session.c
> >> @@ -1764,6 +1764,36 @@ int perf_session__deliver_synth_event(struct pe=
rf_session *session,
> >>      return machines__deliver_event(&session->machines, evlist, event,=
 sample, tool, 0, NULL);
> >>  }
> >>
> >> +int perf_session__deliver_synth_attr_event(struct perf_session *sessi=
on,
> >> +                                       const struct perf_event_attr *=
attr,
> >> +                                       u64 id)
> >> +{
> >> +    union {
> >> +            struct {
> >> +                    struct perf_record_header_attr attr;
> >> +                    u64 ids[1];
> >> +            } attr_id;
> >> +            union perf_event ev;
> >> +    } ev =3D {
> >> +            .attr_id =3D {
> >> +                    .attr =3D {
> >> +                            .header =3D {
> >> +                                    .type =3D PERF_RECORD_HEADER_ATTR=
,
> >> +                                    .size =3D PERF_ALIGN(sizeof(struc=
t perf_event_attr),
> >> +                                                       sizeof(u64))
> >> +                                        + sizeof(struct perf_event_he=
ader)
> >> +                                        + sizeof(u64),
> >> +                            },
> >> +                    },
> >> +                    .ids =3D { id, }
> >> +            },
> >
> > Nested definitions are not needed.  It can just be:
> >
> >               .attr_id.attr.header.type =3D PERF_RECORD_HEADER_ATTR,
> >               .attr_id.attr.header.size =3D sizeof(ev.attr_id),
> >               .attr_id.ids[0] =3D id,
> >
> >> +    };
> >> +
> >> +    memcpy(&ev.attr_id.attr.attr, attr, min((u32)sizeof(struct perf_e=
vent_attr), attr->size));
> >
> > It is not unreasonable to validate attr->size, but neither slicing
> > nor padding will work.  Better to just return an error:
> >
> >       if (attr->size !=3D sizeof(ev.attr_id.attr))
>
> Or rather
>
>         if (attr->size !=3D sizeof(ev.attr_id.attr.attr))

Thanks, I'll change this in v4. The struct perf_event_attr are
internal to the tool, so it shouldn't be possible for the size to
deviate.

Ian

> >               return -EINVAL;
> >
> > Then:
> >
> >       ev.attr_id.attr.attr =3D *attr;
> >
> >
> >> +    ev.attr_id.attr.attr.size =3D sizeof(struct perf_event_attr);
> >> +    return perf_session__deliver_synth_event(session, &ev.ev, NULL);
> >> +}
> >> +
>

