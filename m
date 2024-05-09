Return-Path: <linux-kernel+bounces-174983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FEC8C1848
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 23:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533B21F21F44
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 21:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117AD127E25;
	Thu,  9 May 2024 21:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="K2+KNowD"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9114D1272CA
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289593; cv=none; b=jULxvi2YTQnPjr2UaFlIgEFh/rornPvV8WNsr5qR6w6z0WOXEBx+LGae9x+pbEIT6JS3TrjdpFgpLCIeSjEOdEfS8yvetHzdfw6kM4PW1APN8aZTcdCH2UGyV/EPLdSBCIaUN61rMzHVRC88PKxLUhdltEmqUbDBoqpnXXBqI4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289593; c=relaxed/simple;
	bh=XSTDg6D+nuKKMmgCY9p7yR4M1jZiN3nKiFZMyRMCGiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HC5OmcuNEmFFTFBhaMKg5SNXXRpc9jO2sWZRb4tG2T7uuR/DQ/A/99qsSnQssSjJ8y9QMMw6omVsgbs2galfYYSTWpZ41CTucvxhEuvHVaYrSbrt0bae/zPyYYkmev70/qqu25Uc5DPAr/i0csx2mlMHznq18SjSeFbEwf9M7q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K2+KNowD; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso1770a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 14:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715289589; x=1715894389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qgi3h+IjdR+qGYdA2wxHQV5wR5eEl2tpr3YsgoeQfBs=;
        b=K2+KNowDh/Yz/vPO9MXcNjzhsuN/gWefqx5FxmGiRNGlSzlZlMoSiGxPN60Xq/Ed2l
         1/3Ozuph4mG4ufldGWP6gWVOi0kCMsTieIgwL11BFBxIByeSNiMkkgyEd0JgTKrgjOde
         9eI5HKP3UYI4ye0ijUXnlyaGpUqzXzTC3uKPmib0Hv001oil5RlXORP2uYm/kcHiC4pE
         HBqbIUSV18QJoagx3z+a4V3ofsIT0u4ahbQlCQYmrNYRr/pl/pElNRhaIYZ8nKaowLVg
         A+7oZaw7IayZHTcznNMMW3jT628E52s7PqSCsf1cxnjOserKAWs720mlvlOlFpAkrsCm
         SR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715289589; x=1715894389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qgi3h+IjdR+qGYdA2wxHQV5wR5eEl2tpr3YsgoeQfBs=;
        b=ceE6c98LhgQoF/ic4AyheNQvEP3az7HFSQjKvvAQsRUSDb1W6A+Y/g1QKdu2OnERkj
         8YbkZn3tj/zDyhPUuT7MYg39oyDoIpxp+Y4L2gM2lONBW4XsHzdZgWBgh9DX+aHIaKfs
         D02IEF2mLBFy6IOnDnvfUqRPMdn619C/oc4iAXrQQtUDAIYk0QEtgCInfBPDPfZyZ6GL
         /CQd5AGSgW6MHBoBTwsob5TvhUYHO+5wYo4Q/dkGzJTTWU579iX8O3WCc3KDpYETz48a
         BtkuEeqncJldWd+FYCxuU48X4vG3bJPOaG2yHM9fycRJtgYAA1pndsaNJkGw5474wz9b
         HgAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0lEP9jAX9IhIpWKo42M/fFDzMswttdXLfR+uoD6iqZduCNPjLxd+c+ftunXSyWL+Fy5IC/d+doUVxl7RWUeUoPbRCFfaLvFT5T5Mg
X-Gm-Message-State: AOJu0YzHcosjgGTHjp3KY+0OTVgycq9yC3Xuv3Fz6Q0ZLNcBLa/wmewN
	kXbMFOXCffWmPHQg+ZijiwPiGOrUIOuiXV0P8YtBiCTR8jtFDSMuetY04h8OrVEgGjLy2D1G/zt
	L9IHTDtb9cSgAfr6zAhQNm8zl0BtYlX7RUKoK
X-Google-Smtp-Source: AGHT+IESFwBeKEPJHXIvjKnYagQw1HEdTMzk6jry3RDX75zlENIpGV8y1GohMsEmGFBkNbvjuiuL//wMmjE86393x/o=
X-Received: by 2002:a50:85cb:0:b0:573:438c:7789 with SMTP id
 4fb4d7f45d1cf-57351de5880mr11488a12.1.1715289588869; Thu, 09 May 2024
 14:19:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509200022.253089-14-edliaw@google.com> <20240509203113.63537-1-sj@kernel.org>
In-Reply-To: <20240509203113.63537-1-sj@kernel.org>
From: Edward Liaw <edliaw@google.com>
Date: Thu, 9 May 2024 14:19:23 -0700
Message-ID: <CAG4es9WMDZ6qD1+0MhDN_dD676tB1em34fpRe2wuoefkTGGPHA@mail.gmail.com>
Subject: Re: [PATCH v3 13/68] selftests/damon: Drop define _GNU_SOURCE
To: SeongJae Park <sj@kernel.org>
Cc: shuah@kernel.org, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Christian Brauner <brauner@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, damon@lists.linux.dev, 
	linux-mm@kvack.org, mathieu.desnoyers@efficios.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 1:31=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote:
>
> Hi Edward,
>
> On Thu,  9 May 2024 19:58:05 +0000 Edward Liaw <edliaw@google.com> wrote:
>
> > _GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
> > redefinition warnings.
> >
> > Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
>
> I show Mathieu's comment on this[1].  I have no strong opinion on this, b=
ut if
> you conclude to remove or change this line, please apply same change to t=
his
> patch.

Will do, thanks for reviewing.

>
> [1] https://lore.kernel.org/638a7831-493c-4917-9b22-5aa663e9ee84@efficios=
com
>
> > Signed-off-by: Edward Liaw <edliaw@google.com>
>
> I also added trivial comments that coming from my personal and humble
> preferrence below.  Other than the above and the below comments,
>
> Reviewed-by: SeongJae Park <sj@kernel.org>
>
> > ---
> >  tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c    | 3 ---
> >  .../damon/debugfs_target_ids_read_before_terminate_race.c      | 2 --
> >  2 files changed, 5 deletions(-)
> >
> > diff --git a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.=
c b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
> > index 0cc2eef7d142..7a17a03d555c 100644
> > --- a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
> > +++ b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
> > @@ -2,9 +2,6 @@
> >  /*
> >   * Author: SeongJae Park <sj@kernel.org>
> >   */
> > -
> > -#define _GNU_SOURCE
> > -
> >  #include <fcntl.h>
>
> I'd prefer having one empty line between the comment and includes.
>
> >  #include <stdbool.h>
> >  #include <stdint.h>
> > diff --git a/tools/testing/selftests/damon/debugfs_target_ids_read_befo=
re_terminate_race.c b/tools/testing/selftests/damon/debugfs_target_ids_read=
_before_terminate_race.c
> > index b06f52a8ce2d..4aeac55ac93e 100644
> > --- a/tools/testing/selftests/damon/debugfs_target_ids_read_before_term=
inate_race.c
> > +++ b/tools/testing/selftests/damon/debugfs_target_ids_read_before_term=
inate_race.c
> > @@ -2,8 +2,6 @@
> >  /*
> >   * Author: SeongJae Park <sj@kernel.org>
> >   */
> > -#define _GNU_SOURCE
> > -
> >  #include <fcntl.h>
>
> Ditto.
>
> And I realize I also forgot adding one empty line before the above #defin=
e
> line.  That's why I'm saying this is just a trivial comment :)

No problem, I will add it back in.

Thanks,
Edward


>
> >  #include <stdbool.h>
> >  #include <stdint.h>
> > --
> > 2.45.0.118.g7fe29c98d7-goog
>
>
> Thanks,
> SJ

