Return-Path: <linux-kernel+bounces-252144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACB5930EDB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0DA1F217F8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 07:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4D2146D69;
	Mon, 15 Jul 2024 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Deex8vzD"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098C116FF3C;
	Mon, 15 Jul 2024 07:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721028800; cv=none; b=J1fMJedV53/CWeP6lV6RObZHdiHNfvc2sN78NpDj6e8DZDvIYe2g69hAzU3X1mPbNxQcfcdd1EZ2wf4dlc0/5Z8ip89b/KPGXXZr0VbBe5ecEkb1rDpfnVSwXVO+oLM8gABfwDlvodNOlJkeUyN6yQVatQidVx5LyqOtGIkyaiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721028800; c=relaxed/simple;
	bh=sFuMBxBp7sXQ9yB9wOVoYxDJTv0KwFWSPP6Wco267BI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DbEBnHNXqZ4Gno+4bcSI1FbHYyT4W9TGggkt/adNhm0VzZa+ddFuctR1yFn7Yebve2LvQUB5Eo57MGZBKdbIqmcxyTsq2Slv3MwDD9vBUWPZfcHIjzEwGF3y3dolMw5PA14Tcv19DI1hcBxvXlv1Cm7GjiWtYA5SyOX/1MlQVq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Deex8vzD; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e05a61303b7so1366681276.0;
        Mon, 15 Jul 2024 00:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721028798; x=1721633598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GB6mgBduP2PALHtsyMGAE3eIsZazmb0VM4xkpaxO1iY=;
        b=Deex8vzDIbKbKIim/kxWKZf9nU2SaEkDI+XhzJd8XtnlMnBOEpveyiVMxM7t2lEXBu
         FRMAgkDagm3EvBjyhHJPwHKTl5AZ/031cSLyj+20QSysKCWPYcvAMJwX9CdCf9+pM6Sp
         vkP3lD0UlZeFPFP3a4Y8bRUr9rcx4e6dLbWVLv4eqIah315Vi1gv5zgQvZgO4qNdhYr6
         +caxLpsWWBxyhsfp+MP5DFE/jDLljDMknzAMQUG9O5V3cmiQoVfNwR7qTuMA614aJ7e4
         dl2IHTiBwqkwajbluzcc179QhLkciWHfCrPIHoBy+T1O/B7I9opO9WZe9gemNcNn/Kca
         UFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721028798; x=1721633598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GB6mgBduP2PALHtsyMGAE3eIsZazmb0VM4xkpaxO1iY=;
        b=R1czKrcLfXK+TZ5To00neRikFyE+YF7UZ0//kJrpnD+jRhAUC9C4zLda/MYWdCIttu
         lrY9IkvYjiMSvF2Et+F3EzPKdJjXxSNOD6+ti/jC5drGTC9QX0dt3xk+JrjBmxW8wXiZ
         Ilw16myP6oBnjmcbNJ0ps2xH0C9YajmxbEc2JaNz0C1rIToGzUx7bAGmhVoItf3fRc81
         4rN80ELinLK+qLsGG1gWqJfB/IaDj5SjNvz+1G7W2ocOaMYDLJTJSaL1vslszxqjVEez
         7H/lpV70ELAjRwLjXeyBm3UcEArmDjCOAL13ErpWmoiMLFwWhBmLZCc80Cfzvip4L3/O
         1ccg==
X-Forwarded-Encrypted: i=1; AJvYcCWGJYaclH7T2wXkel4EqS2QqNsWE4bfFPKd0NMka6ZyXJ1dNllATbfjk4/Y6ZvWXJ5ET15s1PQhO01HS2wwmmtDWdr8sgNIk/1uvCb+0RoHvFxhaj03tEuONoz5amAvJPHyCz755yYX
X-Gm-Message-State: AOJu0YzS+1Bv2237tbh9hBIzN6/qnAaVQywwYS2Abxc6aYOtoOP5q8JF
	/SvXfUCN3S0fmh2KI1/rMcp1GPfjGs+AkD24v+dW/ELKOLwQJatf187YFN6s+ep9+NCL7ZDjtOT
	pdJu8Sz/fEGgC0DBFqbVBzt5WzL0=
X-Google-Smtp-Source: AGHT+IG1jyNDr++HAhaKKVBK3BQ1JTufribeHY6KDIsoK53DdOhOyfgeonYGpLTpASCgz9syqiJvXEpTKmoyb2Wk6fU=
X-Received: by 2002:a25:800c:0:b0:e03:6533:136d with SMTP id
 3f1490d57ef6-e041b12408amr20545512276.40.1721028797779; Mon, 15 Jul 2024
 00:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706022523.1104080-1-flintglass@gmail.com>
 <20240706022523.1104080-7-flintglass@gmail.com> <CAKEwX=NJjDL3aW3hXioxh=yASSsHbDBWubV9cE2RiH+tSXpscw@mail.gmail.com>
 <CAPpoddfpU1rN5ST49vBBJ_=MHKehQQrwsz_hwBd6xyzi4-uQkQ@mail.gmail.com> <CAKEwX=OJyrBdCJDLV2v7wLh+hz4Mh1Kjr2Te1eds8JvUY+Jm5w@mail.gmail.com>
In-Reply-To: <CAKEwX=OJyrBdCJDLV2v7wLh+hz4Mh1Kjr2Te1eds8JvUY+Jm5w@mail.gmail.com>
From: Takero Funaki <flintglass@gmail.com>
Date: Mon, 15 Jul 2024 16:33:07 +0900
Message-ID: <CAPpoddefQpkRiCmArz4F5CA_=Y+gYeT0R9bnXLsxBMNgRtEWpQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] mm: zswap: interrupt shrinker writeback while
 pagein/out IO
To: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B47=E6=9C=8811=E6=97=A5(=E6=9C=A8) 7:10 Nhat Pham <nphamcs@gmail=
.com>:

> > > Yet another (less concerning IMHO) scenario is when a cgroup disables
> > > zswap by setting zswap.max =3D 0 (for instance, if the sysadmin knows
> > > that this cgroup's data are really cold, and/or that the workload is
> > > latency-tolerant, and do not want it to take up valuable memory
> > > resources of other cgroups). Every time this cgroup reclaims memory,
> > > it would disable the global shrinker (including the new proactive
> > > behavior) for other cgroup, correct? And, when they do need to swap
> > > in, it would further delay the global shrinker. Would this break of
> > > isolation be a problem?
> > >
> > > There are other concerns I raised in the cover letter's response as
> > > well - please take a look :)
> >
> > I haven't considered these cases much, but I suppose the global
> > shrinker should be delayed in both cases as well. In general, any
> > pagein/out should be prefered over shrinker writeback throughput.
> >
> > When zswap writeback was disabled for a memcg
> > (memcg.zswap.writeback=3D0), I suppose disabling/delaying writeback is
> > harmless.
> > If the rejection incurs no IO, there is no more memory pressure and
> > shrinking is not urgent. We can postpone the shrinker writeback. If
> > the rejection incurs IO (i.e. mm choose another page from a memcg with
> > writeback enabled), again we should delay the shrinker.
>
> You are delaying writeback globally right? IOW, other cgroup is also affe=
cted?
>
> Say we are under memory pressure, with two cgroups under reclaim - one
> with zswap writeback disabled. The one with writeback disabled will
> constantly fail at zswap_store(), and delay the global shrinking
> action, which could have targeted the other cgroup (which should
> proceed fully because there is no contention here since the first
> cgroup is not swapping either).
>

Thanks, I think I understand your concern. Even if zswap rejected
pages, that does not mean we need IO because memory.zswap.writeback=3D0
also disables memory-to-disk writeback...
And yes, v2 interrupts the shrinker in this case, which is
unnecessary. I'll move the timer updates to page_io.c like this:

--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -205,6 +205,7 @@ int swap_writepage(struct page *page, struct
writeback_control *wbc)
                folio_mark_dirty(folio);
                return AOP_WRITEPAGE_ACTIVATE;
        }
+       zswap_shrinker_delay_extend();

        __swap_writepage(folio, wbc);
        return 0;


This extends the delay only if actual I/O is necessary.

