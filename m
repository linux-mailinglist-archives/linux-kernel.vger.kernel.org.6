Return-Path: <linux-kernel+bounces-347709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DAB98DC04
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC062815AA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE1B1D2B12;
	Wed,  2 Oct 2024 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3bkb/49Z"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BE41D221A
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879484; cv=none; b=le6CL3WNvYMGQrQ4K9p+O9rcuzlnpUa2ETcqTZNZVTtehTt2i1gg3A/q3JB6oBVi8yCXROUNjhtAfm7HrmnkyHcDg1bZHkZzSju9CIkD3shuTCaNn8jX4qsX6qeMKmTrdyvL3S8QRTgXX2DozCL5pxSrC6gPYPbtPEcGP9nhA+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879484; c=relaxed/simple;
	bh=CSWmUrFZWc9onuvV22L4XOor6A90L8OZlFpH2b3CYi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWf50IEKkAhqO47ZlpSXnYjqJIjkDB7inLNeZCY+vLqVjbQ+DR4FtXmNOlKjBD8lQjvqvDiiyWXbziN/amhgBu4cbfz+VppHQ0i1jF070n05nfhBBfJ/dfL84Jix+ilIvepJgGe63C+hIQfZEIgVllr1HP1NKIgqfm4j/UcZnC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3bkb/49Z; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b3d1a77bbso193515ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 07:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727879482; x=1728484282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LM7+Zf/idW06POnNvCS7OHrrkGODD4Nf0LqSVTaa/Ok=;
        b=3bkb/49Zhd6HoAthZjrGHqAskoCFUJntRCd/w2Q0V/E4gNhJ1LavCKep5ZZe4NC1cq
         N7t1voVCKFXubl6FE85zwqLwfZktoMNUtrjHVmOz1pf1v7yV79TaWOKnqFCrTiqsEn5n
         kbe3dr5NXR2qmfbhfijjihxAOPVlQZT7p8O88ODiQIZyRejiSoYPMmRpfANKE7nWpVJk
         s/3NsWOCoQWAsW13ng4vVl/R4JGMn0AnbgpMo4gyujvDn7v0kd4ociHA4ikKPq0xmSxT
         Ybf/4S2DYZEquEX/zeGo9q0joW/T+AmJveJ1fsgxrUC2CKmRTMx6F/WGmKvIsF8IzYYr
         JKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727879482; x=1728484282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LM7+Zf/idW06POnNvCS7OHrrkGODD4Nf0LqSVTaa/Ok=;
        b=b1MXdpinp9EubS2DuSSiUe2oKmjYx0h6sT6IWAtT5GBfyD0i5Y/I5k+5XC38TbmUyq
         k5mgPetDW0Y5pZFqbHUlR/tuDLvhDSDOC1L3o4aUYn9rVF8jRJTqplv1IFwwpBzDxuEp
         zuUD9NOaO6jqrgKGdESA+Uqo6pti2YUTmRqTfeIkDbFk/94c99uzlTgduEGblmF2RMSl
         5sHrTR1PW0Y5/yNwfkF8JZ9qgoZQfz19hLeCQI2cY4YJwADdr4tpGf5zZ1JZ5OgYuvo9
         5Q6KERmjPuIpar9eodP4O80ib/jgN94qS2r+s4BfvF0UlKu0ksyd5gSE5dRvKQJdAPJx
         jctQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPrnpOIkwvdo6bLOSqMzWo1jb4E/6cLp/DmMklWemekvOCLKz05jPpWxCbXWwoZLkBLA2zpNOFbnh1ZQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtvn+b30E2CT5dlORI3OtpEvmbyWZDEhCl/xpa7Z8zRLmyVFfy
	rNPNzIQMKHGmWikJ2lGsQ3k158oUDvCqFV/ax+KHVuQJMPIxiQ1LHC92c9wxe/6uq2e3NEAw+0A
	V23YA2kqpJ/YvaxmQw/QS3EddUpKfXyFh6Qn5
X-Google-Smtp-Source: AGHT+IEB6OZhK4KCuGoyBRzaby/YL6OjwEP+CHwoiUbLF/vZ/4e3KZ5l8jt05d/apzsvYPirD8e/y7zVG01Vpk7Xrv0=
X-Received: by 2002:a17:902:d50b:b0:206:9b0f:48f3 with SMTP id
 d9443c01a7336-20bca3931a4mr2005825ad.19.1727879481647; Wed, 02 Oct 2024
 07:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
 <172781650408.2469191.8205759350946908012.b4-ty@kernel.org> <CAP-5=fUekHedP74PZU-F_poETt505AVSwVNYWcYNE=1D9P00AQ@mail.gmail.com>
In-Reply-To: <CAP-5=fUekHedP74PZU-F_poETt505AVSwVNYWcYNE=1D9P00AQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 2 Oct 2024 07:31:10 -0700
Message-ID: <CAP-5=fX=5Ctgqr2pDodUrJpNfEcztBcRkCCTjhDEy+UeH9z1aA@mail.gmail.com>
Subject: Re: [Patch v5 0/6] Bug fixes on topdown events reordering
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yongwei Ma <yongwei.ma@intel.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 3:32=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Tue, Oct 1, 2024 at 2:02=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> >
> > On Fri, 13 Sep 2024 08:47:06 +0000, Dapeng Mi wrote:
> >
> > > Changes:
> > > v5 -> v6:
> > >   * no function change.
> > >   * rebase patchset to latest code of perf-tool-next tree.
> > >   * Add Kan's reviewed-by tag.
> > >
> > > History:
> > >   v4: https://lore.kernel.org/all/20240816122938.32228-1-dapeng1.mi@l=
inux.intel.com/
> > >   v3: https://lore.kernel.org/all/20240712170339.185824-1-dapeng1.mi@=
linux.intel.com/
> > >   v2: https://lore.kernel.org/all/20240708144204.839486-1-dapeng1.mi@=
linux.intel.com/
> > >   v1: https://lore.kernel.org/all/20240702224037.343958-1-dapeng1.mi@=
linux.intel.com/
> > >
> > > [...]
> >
> > Applied to perf-tools-next, thanks!
>
> I disagreed with an early patch set and the issue wasn't resolved. Specif=
ically:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
commit/?h=3Dperf-tools-next&id=3D3b5edc0421e2598a0ae7f0adcd592017f37e3cdf
> ```
>   /* Followed by topdown events. */
>   if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
>   return -1;
> - if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs))
> + /*
> + * Move topdown events forward only when topdown events
> + * are not in same group with previous event.
> + */
> + if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs) &&
> +     lhs->core.leader !=3D rhs->core.leader)
>   return 1;
> ```
> Is a broken comparator as the lhs then rhs behavior varies from the
> rhs then lhs behavior. The qsort implementation can randomly order the
> events.
> Please drop/revert.

Tihs is still in the tree:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/co=
mmit/?h=3Dperf-tools-next&id=3D3b5edc0421e2598a0ae7f0adcd592017f37e3cdf
It should be invariant that for all comparators that:
a < b =3D=3D b > a
This code breaks this property and so event sorting is broken.

Thanks,
Ian

