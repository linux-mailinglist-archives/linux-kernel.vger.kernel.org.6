Return-Path: <linux-kernel+bounces-355569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0E2995423
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318651C23DC6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E5A1E0DFA;
	Tue,  8 Oct 2024 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=g-cbnu-ac-kr.20230601.gappssmtp.com header.i=@g-cbnu-ac-kr.20230601.gappssmtp.com header.b="k0Qni1u+"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2BF1DF241
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403915; cv=none; b=Iz0tUuL1p4g19bORoMORzP7XVYwH+sxt05vu2iLV18W1F/Yo4hIXjt2usHYIRom4ssiyi7D32BISsqeAAtd/OjTwvLzMJ7dJXKvcuLKPkwk0RYus36oRjW9gxPGuY1/c/OJj9wAg8oCL3vKrwv3PKVLXUQizvNPod6bhQ3F6RGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403915; c=relaxed/simple;
	bh=l9nUSXy5fJxXazL93NB3A9BaoEdZe+RDDMisxC7lRYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=JUNJpmaK9+Pt2HD1+eKVdPq6gNChOOg6OZzu84OSxQRWTQA1m8oE1DHNmTg6L77YebcuWYGtqi3c5bK+DVT+Z5B7nP92DMuq7U7JdcO7cqWWQ2vFDuRHwOZakyzmaQVrvxXHZPEFtzBKYdmOU7vm1FyYGHof+WylA31xkY+C1qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=g.cbnu.ac.kr; spf=none smtp.mailfrom=g.cbnu.ac.kr; dkim=pass (2048-bit key) header.d=g-cbnu-ac-kr.20230601.gappssmtp.com header.i=@g-cbnu-ac-kr.20230601.gappssmtp.com header.b=k0Qni1u+; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=g.cbnu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=g.cbnu.ac.kr
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e28fc40fdccso8085276.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 09:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-cbnu-ac-kr.20230601.gappssmtp.com; s=20230601; t=1728403912; x=1729008712; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9nUSXy5fJxXazL93NB3A9BaoEdZe+RDDMisxC7lRYw=;
        b=k0Qni1u+nd+SLX0DFjzXI2bqHbMoa9u/YUTw5PbtRpB1IW8Rz080QKsffh011qimaF
         O+clIDX6rOzK6XOCcnaQTXt2OFEZ425Q8gCYBz1w1dk0o04Vya3fL5KmEBHVYEo7fmmd
         QDuktiGrtT8VT5DbbBd2rlPceQlr29zbLBSFbNQoLiT5w4N1uvbch8wRTvp4dKiatRcM
         L8/hWkMMhDhpnvfHugS2krThk2rZSuA7s336bRHRXAM1vIstVVAfxCjL8uB+Otm0SvC5
         xLLIq2V2HsAyEtxGt+W6Nc9QPXyH38FqanQXkqXnfI+stweuq3F97PBhJ8W2AeO55LGI
         WFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728403912; x=1729008712;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9nUSXy5fJxXazL93NB3A9BaoEdZe+RDDMisxC7lRYw=;
        b=m9mOKnFPw/KKm6Bm8gngJmtlBi6Lb8a8zEu3d+8zyTLN+ac2Oux45NvXz+9JR7v9wo
         NBIwG2j9vqO9yQvRCs6BRj0oi6uI2EZO+yFzwHsdKOoc8IHSgVnuKkxoVGnTcNy/RCqm
         tH1sW/oCoDeB3JD0U0poRPhdEJc4jbPOAQ59ZmbLMK+/Tzu9g8IgOiAKZItv8kWl1xMl
         oKuTfZoucIB2wwWNKzRfjOZPpfxE791brO+eUNJTtniR0A4fjaQoJxeOC4/vzL/z7eaW
         jb9J0KJp/1a7eDwfBgqg5KfRRq6x+mB77Rd6rg1x39FpbJqoUUH3KPquTvh5aeLSNDud
         zr7Q==
X-Gm-Message-State: AOJu0YwPmXpWE9BXA639MUc84Je7X71HY4mGrZOM1MH0ShHN+xi/+K2C
	McY/6Z4zrK7vwDwm4uX5c6Ve58XkNudgN52OZ21EuIq1rriAogDXuTMr4RMcclFk2wvnWBA7cfv
	efedKHgdLwEgxJEwXsXrilesf8jn53y6lVcRYrXF8nY2B+uCSmY0=
X-Google-Smtp-Source: AGHT+IHRJyxZeWO6H0E/ZrTJPHGaqBbJQ0AoPsWYruUTc7F8qjkvtZJz8oZcWjU0v7phBYK/7JH1blLYJ8J56SkBQIs=
X-Received: by 2002:a05:6902:e11:b0:e26:f12:1dd9 with SMTP id
 3f1490d57ef6-e28936dbe5amr12018165276.13.1728403911159; Tue, 08 Oct 2024
 09:11:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008084411.196455-1-chminoo@g.cbnu.ac.kr> <b78d1aa5-1de4-4050-80a5-cbd4bc1eb8f2@efficios.com>
 <c84e6cb4-646c-4b70-9834-3d0f66f51787@efficios.com> <CANuQ-S9akG6_UntYiwzuEs9gXAfg-Dbw3xi5EVzZPHSj-Pc62w@mail.gmail.com>
In-Reply-To: <CANuQ-S9akG6_UntYiwzuEs9gXAfg-Dbw3xi5EVzZPHSj-Pc62w@mail.gmail.com>
From: Minwoo Jo <chminoo@g.cbnu.ac.kr>
Date: Wed, 9 Oct 2024 01:11:38 +0900
Message-ID: <CANuQ-S_yiohRXMESd=ZnRx+y0vgnEdwC3G0brqjoBLB3Z1TBCQ@mail.gmail.com>
Subject: Fwd: [PATCH] Hitshield : Something new eviction process for MGLRU
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

---------- Forwarded message ---------
=EB=B3=B4=EB=82=B8=EC=82=AC=EB=9E=8C: Minwoo Jo <chminoo@g.cbnu.ac.kr>
Date: 2024=EB=85=84 10=EC=9B=94 9=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 1=
:04
Subject: Re: [PATCH] Hitshield : Something new eviction process for MGLRU
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: <akpm@linux-foundation.org>, <rostedt@goodmis.org>,
<mhiramat@kernel.org>, <willy@infradead.org>, <david@redhat.com>,
<yuzhao@google.com>, <heesn@cbnu.ac.kr>, <linux-mm@kvack.org>,
<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>


2024=EB=85=84 10=EC=9B=94 8=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 10:21, =
Mathieu Desnoyers
<mathieu.desnoyers@efficios.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2024-10-08 15:02, Mathieu Desnoyers wrote:
> > On 2024-10-08 10:44, Minwoo Jo wrote:
> >> Signed-off-by: Minwoo Jo <chminoo@g.cbnu.ac.kr>
> >>
> >
> > [ Any reason why no mailing lists are CC'd ? ]
> >
>
> [...]
> > Please consider CCing LKML and the linux-mm mailing lists on your reply=
.
>
> The Documentation/process/submitting-patches.rst document describes who
> should be CC'd when submitting patches.
>
> The script scripts/get_maintainer.pl will help you identify which
> email recipients are relevant for your patch.
>
> Thanks,
>
> Mathieu
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>

> [ Any reason why no mailing lists are CC'd ? ]

I think I did some mistake when I mail, so I add CC to
linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
linux-kernel@vger.kernel.org (open list)
linux-trace-kernel@vger.kernel.org (open list:TRACING)

> Have you considered alternative approaches, and why is this approach
> better ?

I used an alternative approach of creating another wrapper or value
approach, but this was not good because it increased memory usage per
folio, resulting in more swaps.

> Do you have benchmarks of workloads that regress with this feature
> enabled ? How are they affected ?

I tried another two benchmarks, 7zip benchmark, YCSB.

The 7zip benchmark shows a 3.1% reduction in pswpin, 2.8% reduction in pswp=
out,
and a 2.9% reduction in runtime under 1G constraints.
Under 2G constraints, pswpin decreased by 22.4%, pswpout decreased by 21.2%=
,
and Runtime decreased by 14.8%.
On 3G constraints, pswpin decreased by 3.3%, pswpout decreased by 1.3%,
and runtime decreased by 1.9%.

We also measured the Yahoo! Cloud Service Benchmark.
YCSB showed a 69.9% decrease in pswpin, 67.1% decrease in pswpout,
and a 5.1% decrease in Runtime at the 500M constraint.
At 750M constraints, pswpin decreased by 83.8%, pswpout decreased by 81.0%,
and runtime decreased by 2.4%.
On 1G constraints, pswpin decreased by 79.5%, pswpout decreased by 76.7%,
and runtime decreased by 3.8%.

> Documentation should be there first, or at least something explaining
> the rationale and design.

I think my previous commit mail might be helpful.
https://lore.kernel.org/linux-mm/ZpvY_aZV4VtMmXP-@casper.infradead.org/T/

Thank you for your response.

