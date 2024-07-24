Return-Path: <linux-kernel+bounces-261414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584E193B709
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E9A28393C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14A716A947;
	Wed, 24 Jul 2024 18:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JLr9JSHG"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD8E1598F4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721847119; cv=none; b=BUL0jZPGYOjGC3OPSbKb0Mj5bCabMt1GSzgO3W2qW86cVEnQAmr2A4HLJnszYs8ELUNIs31sCEiDgEHghUbPnya2W2p1wPKv+kHqizkOJGVSOcpqf8z115uuFkr1Nx7bEtPav6MqFD0SICArP2iEbpkkIfbCO65jb8Jlv5XfqOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721847119; c=relaxed/simple;
	bh=Vw0A4MYZooitJHp244OZC2CuDx0yGD1T9A4YrRNm+Kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLpwKLhY1yIxN3lSAIxL+BQ3KZ3Hu+K7K7sOLscV9NcaxLj7QbKNgZi+fOqvGxTo/ryIPUM9nQYuucPcn9jsJJJRyiTRr95zllkiLA+EMwTTGOl6aVgOK4DivcsdSERLE9aXY3SwcLwZGYBIhR2+O088WowdwCHDeWn3tVgN5IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JLr9JSHG; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cb5deb027dso113357a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 11:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1721847116; x=1722451916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fz1re8hEAbdCbg6+d0sgG9QoSqWm1jEP+6/Po7xO6nU=;
        b=JLr9JSHGtbmReoQIz7sX7UZ4i/eNH0hRsitoP36Ua3CmhBZYaOGrvlMX18lsWypMDw
         pdZuhnevEvvhGzWjzwk695IGslShlOIuSew0DHDB5J5ej17ig75uUkqsJ4AN2DlYoYaF
         Jj9lufdlirYtAoagV1mpaWH45ep09Rd5xcLS5uCEpNaXVqWUg7+5JeL6JsA6l0FLo4Gr
         wVCacrQTFeexFLmvNpC+ooV06NleDiaKhQ2tAI+ex1IQU8YXF2nSo1WOa6OhTWzRrSq/
         JeNodE88W+XaI56ZB6AP8aTlDunVgLsTKPUZAiHBqizEmoB4HxHxQDuC8KSnkH8FKqKS
         nF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721847116; x=1722451916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fz1re8hEAbdCbg6+d0sgG9QoSqWm1jEP+6/Po7xO6nU=;
        b=EO2J7QMEwipK58RxkODS6xAr2wFC9R0jZthzTTmGhi2jestXkBlbocR4I5Qizxqrwb
         K7b9v702ysLZ4H9a25fNQgP3XeN4BVEYkAuaDRkciPp+pC6FKL/vWQzwb2282uIKSXGa
         iKzBeogAAu5h8FdwHvvWKVi/z2M+SjnTAwPE6TZdqc7o5ASei53P4ezqyybrVSunlXYn
         i5GGTdiwxWKE6zQZY7mcNzXoDBOxzWFoIE3PXkeYowgO5CrArnLf4DZSLO7KzRWNl2pQ
         0E6aIszdjikk1j6kCDqep9e2pU0jA1HbIYpvxpE9iUy8e7q8sZu6RpbxQiTxm1nisQg9
         oJ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHcUk28onT1F3Y3ztrUY4OLDODP39aYsBtj5uwL94l6kpXakqpdJj19cWdCIJA85IbrkJxm5MNLTpqed2U5nSPx+eK2uYeVBGPyzMp
X-Gm-Message-State: AOJu0YwrduPLimRaSoZS//wdsq5mfUjCQUhyD1+2rVprf02BkNdhwAsp
	ZopEe/hD1Xzj2TNAFVgt7g50cC6cUYqYCoN9pb+WHkkNSREDOcHL2jJvEwAYh4kGMUKOMoN2yXw
	k8bsBrSh89831LuAYukpSbvCOi7A2J2NPOg8q8g==
X-Google-Smtp-Source: AGHT+IEyCelTG43l+W5jC+9ilBM0QfFfNBPW0/hrkNF7fQyxMWOTtBHDhstpigm0TORwlyXxWQJr+rn6iwBWnW10gIA=
X-Received: by 2002:a17:90a:f486:b0:2c9:7849:4e28 with SMTP id
 98e67ed59e1d1-2cf23901745mr513948a91.27.1721847115671; Wed, 24 Jul 2024
 11:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722211548.61455-1-cachen@purestorage.com>
 <CALCePG0GtG4DQwzJ-QCJRScfxVg3Up6Xeemxh48qSf2VjxjebA@mail.gmail.com> <CAM9d7cj20KdEtg8v93+bt+ZmpTzin=N3DfAX3K8ELHLkccoeqQ@mail.gmail.com>
In-Reply-To: <CAM9d7cj20KdEtg8v93+bt+ZmpTzin=N3DfAX3K8ELHLkccoeqQ@mail.gmail.com>
From: Casey Chen <cachen@purestorage.com>
Date: Wed, 24 Jul 2024 11:51:44 -0700
Message-ID: <CALCePG3sqCCJyRaUOiE0TqDCGmOdw7B38hBzs9PvF5EgPjU8EA@mail.gmail.com>
Subject: Re: [PATCHv5] perf tool: fix dereferencing NULL al->maps
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	irogers@google.com, yzhong@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 9:19=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Tue, Jul 23, 2024 at 6:01=E2=80=AFPM Casey Chen <cachen@purestorage.co=
m> wrote:
> >
> > Ian / Namhyung,
> >
> > Could you take a look at the latest diff PATCHv5 ?
> >
> > Thanks,
> > Casey
> >
> > On Mon, Jul 22, 2024 at 2:15=E2=80=AFPM Casey Chen <cachen@purestorage.=
com> wrote:
> > >
> > > With 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions"=
),
> > > when cpumode is 3 (macro PERF_RECORD_MISC_HYPERVISOR),
> > > thread__find_map() could return with al->maps being NULL.
> > >
> > > The path below could add a callchain_cursor_node with NULL ms.maps.
> > >
> > > add_callchain_ip()
> > >   thread__find_symbol(.., &al)
> > >     thread__find_map(.., &al)   // al->maps becomes NULL
> > >   ms.maps =3D maps__get(al.maps)
> > >   callchain_cursor_append(..., &ms, ...)
> > >     node->ms.maps =3D maps__get(ms->maps)
> > >
> > > Then the path below would dereference NULL maps and get segfault.
> > >
> > > fill_callchain_info()
> > >   maps__machine(node->ms.maps);
> > >
> > > Fix it by checking if maps is NULL in fill_callchain_info().
> > >
> > > Signed-off-by: Casey Chen <cachen@purestorage.com>
> > > Reviewed-by: Ian Rogers <irogers@google.com>
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks,
> Namhyung
>
>
> > > ---
> > >  tools/perf/util/callchain.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.=
c
> > > index 1730b852a947..6d075648d2cc 100644
> > > --- a/tools/perf/util/callchain.c
> > > +++ b/tools/perf/util/callchain.c
> > > @@ -1141,7 +1141,7 @@ int hist_entry__append_callchain(struct hist_en=
try *he, struct perf_sample *samp
> > >  int fill_callchain_info(struct addr_location *al, struct callchain_c=
ursor_node *node,
> > >                         bool hide_unresolved)
> > >  {
> > > -       struct machine *machine =3D maps__machine(node->ms.maps);
> > > +       struct machine *machine =3D node->ms.maps ? maps__machine(nod=
e->ms.maps) : NULL;
> > >
> > >         maps__put(al->maps);
> > >         al->maps =3D maps__get(node->ms.maps);
> > > --
> > > 2.45.2
> > >

Thanks Namhyung.
I have another question. When will this patch get merged into master
branch or 6.6 release line ? Our benchmark systems depend on this fix
to do performance analysis. Currently, both our kernel and perf are on
6.6.9 and they build separately. We want to update perf hash without
patching it locally.

Casey

