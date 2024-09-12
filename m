Return-Path: <linux-kernel+bounces-326917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5082D976E79
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73CCB1C23789
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A43D13F012;
	Thu, 12 Sep 2024 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="li7GZvgL"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E3629CFE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726157556; cv=none; b=T9Pj+FaeQbb7qphtL2EimTfHv2Yl+82SdrN7TSj90lGvE1x0C4C06rv1czOm/0c8bKRS9VG08KCBKTlHRSnO7avDLmmTO9DagNtt1ITzTsrZLi/TIev59hHWd2L16qhXuV/rt6ft2+SLd9a9pkJUP8NpjDXGg2ARFzxNOlrNh/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726157556; c=relaxed/simple;
	bh=ZcNfuBX9YwlG/7kwcb9vx/KGc/TIDAGINzAYOcTHIEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Owo83UmEgeUmPGyXE49qYA2V00c55Aood8dYL/ao893HtBOnXTwngchdZDHlFL3HpWgNCzNYWlptrvpg336sZymdpQmk+rFmrody4obpzN6Zo6qUP+Ywpzx56+O/zWmJ78M4+aQ+IBs1tVeuUtN2yculeeFjVEUaUTRYlpoT/gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=li7GZvgL; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c2443b2581so14225a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726157553; x=1726762353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiQyIF1mvxSjqMyhPNS2IVuiQwAu3H/w1r54T2zJLTM=;
        b=li7GZvgLuux5s/ppQkErsUJR1tYbwuVm/7oUprcD5G8geIbLf5NDPnjCkgtV2GzWU7
         IherbZLEWC5xsqY3YWgxBvjRh9T140rxKEhPTBIzy5ykAWWnY+jaky59HXOCEZl9derq
         kyvNMUIRDO3niZN+/PSHV1e1e9WY9X546OrqlRIpHnOknoWZZpavFu7RqvD9VvwYAkyi
         NKUD/b5IjRbD04Cc4sXNXQm7b8JOlH58BEgbiylZyIFwUnkusvNTIwLn6Hz1CsvxnOHX
         DvcWkcKlQw+pHsqc7es87t9cpvM3hcXNf5OSIjLoVQox69zydIkfsr5Fy7za928tEvKy
         fYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726157553; x=1726762353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QiQyIF1mvxSjqMyhPNS2IVuiQwAu3H/w1r54T2zJLTM=;
        b=ZmmsR30KwBzWa3G5pT3xJqnlVDWxqT+bALgdfZKa/7S8UmyfHi3ZoQCKmUxqPR8H2a
         iDRBNz95JP8MiTaVH6M7aY5lsI6KpMkBHcN5Voe3Ybl9TCcRWaR7Y2AClyzi7bpcWj5A
         YVySEPsQjkjnCLh/SmnqcaNOve+Qnxe6SBF0lPScWDMgBYdbCC9xvq/U+kF5DdpJhP1/
         kmlfJtMeBT0f/HHSYMWTXUR432Vsa0fZan2zKP9pfO3EwfY4rSRuJsTZbj+vUguTCgyL
         1QwxAQWJ5/6ynKMjYSxCfvpKs6eGIcgSSHb/ol0+wxxKPTx10X/tJWOvtZDXncAJxeOE
         /0+w==
X-Forwarded-Encrypted: i=1; AJvYcCU5c1AD5Sz7QbAcSB8lyUjeQIxa/5i34VAkvq13PcwWO5/vabpq5w9OdD/eJ5GINzNSFubUJx6/ivOkajY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLAiQczjkX70pbtS3aQ4eoqcxVZOMwQwuRSkLt3KAOf4N1TCdh
	+ZvsssRjYB6K8//Pg7tQMcyZcWkII6hHRYlyb4OWyAn/IJazKbbY/sFMhwUwMMjODozI+3C8p79
	LcLux+/VfehzOfEFG8VFNy4KMmxnWdOZhhwQ+wkI3YteIbq+96hnX
X-Google-Smtp-Source: AGHT+IF+EtVAWErpzQLsJU9lzROtq87V+bVYpIsCmWHQQvWO7HFhIFw3/0JzawddfQWxIl+EB/VhgRDZ1jDo9tla5Q4=
X-Received: by 2002:a05:6402:348d:b0:5c0:aad5:43db with SMTP id
 4fb4d7f45d1cf-5c4146155d7mr261554a12.4.1726157552469; Thu, 12 Sep 2024
 09:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <koa5yyc2opu23giistqjaw3eo47gjcxpx56ekrbsbhltk74wzz@pvym4ollouzu> <20240912022740.6125-1-00107082@163.com>
In-Reply-To: <20240912022740.6125-1-00107082@163.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 12 Sep 2024 09:12:20 -0700
Message-ID: <CAJuCfpHPrVm6WPRRDZTKr+3XrLZnd-BkibzvFUAOBRxE5k=47w@mail.gmail.com>
Subject: Re: [PATCH] Add accumulated call counter for memory allocation profiling
To: David Wang <00107082@163.com>, Yu Zhao <yuzhao@google.com>
Cc: kent.overstreet@linux.dev, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 7:28=E2=80=AFPM David Wang <00107082@163.com> wrote=
:
>
> At 2024-07-02 05:58:50, "Kent Overstreet" <kent.overstreet@linux.dev> wro=
te:
> >On Mon, Jul 01, 2024 at 10:23:32AM GMT, David Wang wrote:
> >> HI Suren,
> >>
> >> At 2024-07-01 03:33:14, "Suren Baghdasaryan" <surenb@google.com> wrote=
:
> >> >On Mon, Jun 17, 2024 at 8:33=E2=80=AFAM David Wang <00107082@163.com>=
 wrote:
> >> >>
> >> >> Accumulated call counter can be used to evaluate rate
> >> >> of memory allocation via delta(counters)/delta(time).
> >> >> This metrics can help analysis performance behaviours,
> >> >> e.g. tuning cache size, etc.
> >> >
> >> >Sorry for the delay, David.
> >> >IIUC with this counter you can identify the number of allocations eve=
r
> >> >made from a specific code location. Could you please clarify the usag=
e
> >> >a bit more? Is the goal to see which locations are the most active an=
d
> >> >the rate at which allocations are made there? How will that
> >> >information be used?
> >>
> >> Cumulative counters can be sampled with timestamp,  say at T1, a monit=
oring tool got a sample value V1,
> >> then after sampling interval, at T2,  got a sample value V2. Then the =
average rate of allocation can be evaluated
> >> via (V2-V1)/(T2-T1). (The accuracy depends on sampling interval)
> >>
> >> This information "may" help identify where the memory allocation is un=
necessary frequent,
> >> and  gain some  better performance by making less memory allocation .
> >> The performance "gain" is just a guess, I do not have a valid example.
> >
> >Easier to just run perf...
>
> Hi,
>
> To Kent:
> It is strangely odd to reply to this when I was trying to debug a perform=
ance issue for bcachefs :)
>
> Yes it is true that performance bottleneck could be identified by perf to=
ols, but normally perf
> is not continously running (well, there are some continous profiling proj=
ects out there).
> And also, memory allocation normally is not the biggest bottleneck,
>  its impact may not easily picked up by perf.
>
> Well, in the case of https://lore.kernel.org/lkml/20240906154354.61915-1-=
00107082@163.com/,
> the memory allocation is picked up by perf tools though.
> But with this patch, it is easier to spot that memory allocations behavio=
r are quite different:
> When performance were bad, the average rate for
> "fs/bcachefs/io_write.c:113 func:__bio_alloc_page_pool" was 400k/s,
> while when performance were good, rate was only less than 200/s.
>
> (I have a sample tool collecting /proc/allocinfo, and the data is stored =
in prometheus,
> the rate is calculated and plot via prometheus statement:
> irate(mem_profiling_count_total{file=3D~"fs/bcachefs.*", func=3D"__bio_al=
loc_page_pool"}[5m]))
>
> Hope this could be a valid example demonstrating the usefulness of accumu=
lative counters
> of memory allocation for performance issues.

Hi David,
I agree with Kent that this feature should be behind a kconfig flag.
We don't want to impose the overhead to the users who do not need this
feature.
Thanks,
Suren.

>
>
> Thanks
> David
>
>
>

