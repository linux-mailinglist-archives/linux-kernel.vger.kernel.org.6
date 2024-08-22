Return-Path: <linux-kernel+bounces-297786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DC995BDB7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21161F239D7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28186F2F3;
	Thu, 22 Aug 2024 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IGdogpHO"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCF938F9A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724348980; cv=none; b=DQAbOYQIOPSgXXOWEfhZ+7d2KgZ+qC+99TV3Egs9+ALldyXUvlj4a2JloX6xSbfzwCQ460WgiSgkFncEh0v9AAgRaDYavg3Ft1aUoWsTQDBzFGH8tlGjZZmu8qrMimnJ/TxXqS+sI58vyu49iabpDRTOXVaM3HTyTPbIyd84occ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724348980; c=relaxed/simple;
	bh=4DCNjjCKoSP4eyvhwLdjPqdqgDhehWVQKDeRIGJ9azU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAPvt0yxCri/+ZGmTYHHxzboOfD4Ww5GL4OReP2I6NdAUOd1brjnuEcKLCoAzuM0T/yn+VbXCa9gKMcC8dWM6G0MGJgD8qZbBN6AtamPP1RCJlYzA75mVZ3IxJAd4va5+S8ASTlb8RJpglxXA4y0Q3dJqWi6G+oalBPZfjBYOOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IGdogpHO; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so151106266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724348977; x=1724953777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DCNjjCKoSP4eyvhwLdjPqdqgDhehWVQKDeRIGJ9azU=;
        b=IGdogpHOjb5NzWbAEk3r9CZ7gj4xodI3StlT0ZC2Qz83u6oLAwEVZ3WtsQInH1jd8j
         U3rGz7VqEuGAzWn0WsDHuZ3YCgt9kNgeBf3sqcHOMES6GBnk8IsGRdPRqr0dgB4TRozC
         4iTiqZ+OTKhregxpggNrLfHTlfdqh1KcT6w0/4E/fGShSugr76WI/VoH0g4DziVxwELn
         APbJx6vawZoD1ysLfp9nXa+72FbFvg0YFeXVyFVbCg6C4lh6L3i5hgN8UxUGfExqlvgH
         cpyBk86yFRiH6tnTmGOC2pfeBivalnwKsll11x1qQZVeuPFxAvJHxRsb4jVeh44F8J9a
         Rwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724348977; x=1724953777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DCNjjCKoSP4eyvhwLdjPqdqgDhehWVQKDeRIGJ9azU=;
        b=pafv5MGVAFrT+Wvp5/qjXRaTSjfP1+UkA+huc7UcHXWaLVtZsxbRgR/C1hlRoGqQCx
         u2x1iKikJNM906dR17D7/bQfu7QLzQnFdQCutqhFE6KHSBcIlzq93vK0g57cVEjTr02o
         kfbVlKAaOW/rWCPtV6Qk8LvEJfPg+LdT9D/9hOkbB/nfSLRpGAcH6FvNK2cJE6BZJtaE
         Ze3mb/x39vm+r2eK1jmXJ0Md0XO+S27M6zCYtm0vB/VY0lIXW5r0C/S8IB9yTQEY+Fm2
         RTk/IxeRnGJ9nMCjzGQ/pAqGQkZyz9BGZtlA0H7UPIpTehQ0Lno67TFyEblKaC5Y8UJ6
         OFsg==
X-Forwarded-Encrypted: i=1; AJvYcCXfoazdipongqRoTCLWlIbq10f16rVgaCWI4bgWsGWPTSckowy1daOhTujovJtffFFCMZQQo64NO2dbbBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQOVjBW033J6sjvWEvJY/CVOYD+e2b8tbOWvJ7/1klsFdkeXwX
	6IVEV54BPMDT9Zq9DJJPZEGhUJ8uFUWPDWgUy0ivD7Y7VqCSPmuhaUtIlOL77vvXWAE1ykqQD7x
	/dkEyR0P0783odmLR5k6c8tR3CP7+VLjyT7On
X-Google-Smtp-Source: AGHT+IE4IQPc9rbpt76DXkp3o0GnQk0sV4FVm/dLBBD+l2uTlPMrcgrYLjxXm0Xi/oBVM9Rz3LssTdd79gSz+FmJjI8=
X-Received: by 2002:a17:907:944c:b0:a7a:a89e:e230 with SMTP id
 a640c23a62f3a-a866f3600b7mr421320966b.30.1724348976225; Thu, 22 Aug 2024
 10:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814171800.23558-1-me@yhndnzj.com> <CAKEwX=NrOBg0rKJnXGaiK9-PWeUDS+c3cFmaFFV0RrE8GkNZZA@mail.gmail.com>
 <CAJD7tkZ_jNuYQsGMyS1NgMf335Gi4_x5Ybkts_=+g5OyjtJQDQ@mail.gmail.com> <zsj4ilkso7p43qexiumk42bkzuqt5bxi3u5pys5arfpjodqszd@4jomnqwf4vim>
In-Reply-To: <zsj4ilkso7p43qexiumk42bkzuqt5bxi3u5pys5arfpjodqszd@4jomnqwf4vim>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 22 Aug 2024 10:49:00 -0700
Message-ID: <CAJD7tkZ28FSKOmA4dzVdTzR05_Qge9EcYGZzwMNgP7EHJOJHWQ@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: respect zswap.writeback setting from
 parent cg too
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Mike Yuan <me@yhndnzj.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 9:14=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Wed, Aug 14, 2024 at 01:22:01PM GMT, Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> > Anyway, both use cases make sense to me, disabling writeback
> > system-wide or in an entire subtree, and disabling writeback on the
> > root and then selectively enabling it. I am slightly inclined to the
> > first one (what this patch does).
> >
> > Considering the hierarchical cgroup knobs work, we usually use the
> > most restrictive limit among the ancestors. I guess it ultimately
> > depends on how we define "most restrictive". Disabling writeback is
> > restrictive in the sense that you don't have access to free some zswap
> > space to reclaim more memory. OTOH, disabling writeback also means
> > that your zswapped memory won't go to disk under memory pressure, so
> > in that sense it would be restrictive to force writeback :)
> >
> > Usually, the "default" is the non-restrictive thing, and then you can
> > set restrictions that apply to all children (e.g. no limits are set by
> > default). Since writeback is enabled by default, it seems like the
> > restriction would be disabling writeback. Hence, it would make sense
> > to inherit zswap disabling (i.e. only writeback if all ancestors allow
> > it, like this patch does).
> >
> > What we do today dismisses inheritance completely, so it seems to me
> > like it should be changed anyway.
>
> I subscribe to inheritance (at cgroup creation) not proving well (in
> general). Here's the case of expecting hierarchical semantic of the
> attribute.
>
> With this change -- is there any point in keeping the inheritance
> around? (Simply default to enabled.)

Agreed, please feel free to include a patch in your next version that
does that, and add "Fixes" tags and Cc:stable so that the changes are
backported and users get these changes ASAP.

