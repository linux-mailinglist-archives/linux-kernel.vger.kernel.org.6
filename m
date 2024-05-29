Return-Path: <linux-kernel+bounces-193217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB49A8D287C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 01:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982E71F253F7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6623317C6A;
	Tue, 28 May 2024 23:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NarDvgvw"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6647313CABA
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 23:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716937372; cv=none; b=XQNtdOA+XFJxfWfD/LRP0whOzjMltF73hXPuoW+JAoCqxDJLklxfEPBBmvfEalbde4z31zqPbYlT27EvQzI5qrGgd2Tswo/+U8FZKSnqUaxO8F4aqDvEF/22G09fiQ9PcMw/IWQAFLaf6ZKDscjjolocWlIWPIV/1ht15TftRLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716937372; c=relaxed/simple;
	bh=DYoz2T95x+J7paSa/on8RF2MCa1kLO5q7i/erHdIOpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urlHgaiBTMRhPDlVhHZj9hcqQTIgpiMk92Az11n+4bEyM+GbY3qhegs/U4OD03kdfBJOKJ6NOHOYLPhYDXJ+eLrFfZcO5ZTFn8jT6O/gJbWhXp7fvjTBWKfi7AZFwoy0raYF9s0ophVI86T+wQizF0rtZumKGNQjifKDtlZwNS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NarDvgvw; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-62a087bc74bso13708057b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716937370; x=1717542170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYoz2T95x+J7paSa/on8RF2MCa1kLO5q7i/erHdIOpE=;
        b=NarDvgvwJCSvKRwvGkIqCsYafjfMmi/f7Vc1qJ1NsGZ+wrJQKWOdtJil0ctVXLoE8v
         RKBt0sS+HXUf+jK8+lwWBDhqRrDZ/1bQcivVzq3qN+h4ViGPgq5uid5/OJ8mJdZjJG17
         7Zp5zgv2yjJJAVTwuYXuN9Ndx0y5uRNIOv99Ehx/42SKz12HaygMbqh8/tsLsYckrxUD
         ApkTdOXStgzh3pLAgJV9KmBmuL+fjiQwxq/guaef1BzZF1dbbPlbqLdyei6CbA2szwff
         QsAMfmO1nCUxnY/9twRPMnIzvhRk1k3sg2gRNbRolw3IYUMw0M3BEQ/jKBqGtE1LYtbH
         9uSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716937370; x=1717542170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYoz2T95x+J7paSa/on8RF2MCa1kLO5q7i/erHdIOpE=;
        b=Emt+76gyn6/xT/BQFjXG5P3TQqwpj6v4yhJFeUpjOFaH0MhN+88ROFradbkmQOOKSK
         u1mxYikagxhKdHxF9p4ld4NO305i6AUlZjTgwa+3rrGJdsla7eQtLuP9SY5l1L0n4BsF
         3RzqEhsBR5qg/9J5Ty4XRm2FboR/CDTFNNeopWzmgTfPc79onzOGX70kkTYyxdFH4yhX
         ijG0dnloB4mi7eu/gaq4/GfgRj7Pu1nAthWNt+IAz9YUcChcEXGhccw2kMrNwHSAZuRY
         a2RVm9I55MEbBtkK+7aAO+W4K8MyXmkAxEPDhJjNxCjSlFiFD8YbdPToiAtljDvHdMCb
         0Opw==
X-Forwarded-Encrypted: i=1; AJvYcCXuo9vHxKClTOInNGrnrFq4qIGmr5MXC9xYmINsVPIDh19beFYbwxOlKSKOq+lvymew9EB0moo8kEzcs54JJhira2fRkwAUDK8z7Xdi
X-Gm-Message-State: AOJu0YyfKcxoKFzQei+qWLEK0hPKGfUw6vKB3R9X7UDCDQz/3FFLSuIl
	u+wazLKeIz7RFF1+/S6uzfIw+Fgpf1OCi3z9LE/+s1PecotMIrd5HqhQkoWZDz/VQ7KP/cbZZXi
	oq9UbzLSWrvcFxDBQIfhko70jqgm2IQUa1015
X-Google-Smtp-Source: AGHT+IFO+mB8zDk7WTuhLW8/YjKO26Dcvi2LzbMWr1nS0AQ+b9Vcg58b4Yt/2PIp7n1F4lN7p0zAG4JzhSB9cvvjAEU=
X-Received: by 2002:a81:6d96:0:b0:61b:1718:7302 with SMTP id
 00721157ae682-62a08dfd012mr133834827b3.31.1716937370252; Tue, 28 May 2024
 16:02:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528163713.2024887-1-tjmercier@google.com>
 <ZlYzzFYd0KgUnlso@slm.duckdns.org> <zrvsmkowongdaqcy3yqb6abh76utimen5ejrnkczd4uq3etesl@jv3xb4uso4yk>
 <CABdmKX2vmpFS=j_FoFOadHRVVWaWUsReJYv+dJNHosk1uE_Dvw@mail.gmail.com>
 <ZlZd2EsF7KOqPx7a@slm.duckdns.org> <CABdmKX0+rRAHVDmv-A549OxBsyaLcTERYeM52_1ZhiL0-gvTyA@mail.gmail.com>
In-Reply-To: <CABdmKX0+rRAHVDmv-A549OxBsyaLcTERYeM52_1ZhiL0-gvTyA@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 28 May 2024 16:02:38 -0700
Message-ID: <CABdmKX2LrdAC2YtkShr+rNM_Ng8586AowH9Uu2ZGhzmX+YH6DQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] cgroup: Fix /proc/cgroups count for v2
To: Tejun Heo <tj@kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 3:45=E2=80=AFPM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> On Tue, May 28, 2024 at 3:42=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
> >
> > On Tue, May 28, 2024 at 03:38:01PM -0700, T.J. Mercier wrote:
> > > > > I think it would make sense to introduce something in a similar
> > > > > fashion. Can't think of a good name off the top of my head but ad=
d a
> > > > > cgroup. file which lists the controllers in the subtree along wit=
h the
> > > > > number of css's.
> > > >
> > > > BTW, there is the 'debug' subsys that has (almost) exactly that:
> > > > 'debug.csses' -- it's in v1 fashion though so it won't show hierarc=
hical
> > > > sums.
> >
> > Yeah, something like that but hierarchical and built into cgroup2 inter=
face.
> > Would that work for your use case?
> >
> I think so, I'm checking this out now. debug as v1-only and non-stable
> interface files doesn't work, but the same sort of thing with a stable
> interface on v2 seems like it would.
>
Ok debug.cgroup_subsys_states reports css->css->online_cnt, but I'd
also want to include the number that are dying. Either as a separate
count or combined with the online_cnt like in /proc/cgroups.

