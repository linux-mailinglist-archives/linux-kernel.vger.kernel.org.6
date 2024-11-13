Return-Path: <linux-kernel+bounces-406895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1119C65D8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 01:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18711285D0A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DAA79C8;
	Wed, 13 Nov 2024 00:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WEZjXrJm"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DC723AB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731457194; cv=none; b=DfuYgct+GZsqEghmlHg827kql9HPMm0iwPrbeK1e+x4y+rzmCor4vMhyGYFO6oJiQgTcqrrJWFCSh6HVJwoudtBMACKYmsmEaxc3xBTI8ru45+HFcdK9P0M4SjvgivXdIFILIr7d2S4D9mfXb8Y6vErtiKX7UEB3fpJmsOl4a4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731457194; c=relaxed/simple;
	bh=n6LGoLV9gZFPi/bSk5JT9WySVlojUnnNnhNZN+c71UI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sM1oFb/OfSIh2rdLUPpyXkv90TKdTDBrzwkBnY38VaSvUhXPj39TUM7sth6tXbjUoAT9s7+vJRxvdRkMt3LaX1jhCihitfkOd2Q88fEmOlmPDIhMen1vrxfzXYFz7jIFNil21JiHV5y22B61O1WcHHdtCiJnqALXIylQbUiv9r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WEZjXrJm; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e5a5a59094so58440737b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 16:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731457192; x=1732061992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syV3yYdAawmGgH9foa1REVrhWT3O13PH4ob3NUaHMYI=;
        b=WEZjXrJmasmG+Xim+xhluljaLNlk/2CJxwGIuvY/n1kkM9flzH5GO6ty+Yt3Mdo/Yy
         hhjCKF4qAwPqVwmsfdrux+sNlUHWmX/zyoYq+xf3rqx0vRIn6+1VcpHtyM+z/vmZq4s4
         DDpDZByrXOOdTfubWotfPLW11qFGJK2tVh0zbnRzSWBX0RUPVRfKeKLcIGXoFsnw4LRM
         FszoMG1gJRas7vXpNT0PKfTbWPft/OXVhq+UT4PYm7YnNozdT56XFpg28lYM/91nokCg
         QWh/fPN6z9WQ4lyR1g5dqwmgFfzNcVbRshue0Iqh3J+drV9WvEnAth7Kvye1UedxS99y
         KiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731457192; x=1732061992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syV3yYdAawmGgH9foa1REVrhWT3O13PH4ob3NUaHMYI=;
        b=KP6BGHNn3OffpQkwdzcL7ac3UOIPQAKwJF6qw2xb7kY+uUAm028PDjnqgJfRYLx/Kc
         M011XVdcSx6O3bMjJwott5lalrZtK3zAIhOnDHsvEtDRXIBj9XGfP+tBSVDTEozBm8LP
         KJOYst4ahyb73C1S7UhcSt4+QD5SyRMFwZXq3I8kii+trRkxpP42o5y6gyc3wlaBwzs7
         RyKxkjtESg8fpTZXJObHAdvuMH8qWfcMZXCDbmAaRqbm2LQQVLaY5MOO4pmvPeN2PfK1
         6ThJ5qZxGub5tP5ygbcfS1DPn3S7NO8XdHej9PEAM677gCfW5MmGWCnUo174+44qgpG6
         6aBA==
X-Forwarded-Encrypted: i=1; AJvYcCUxATGgrBk3IDMlrkqq86XUfOkiAfrPzwsxeCYrBf+SIVv6lXy1NajycTqtH8n1Iutrf79xym3DtS1bCaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd/1XZmEOj6pB4LiiIam9CxjMYp3eAa2k+ngP4DlKkRrntg2He
	YxXYnqi2RWEw9UoMOK36RRixa6//bB0U0b1ZB8aF1scGAG/1NTdUr2IOtNItqj77Or4qiHOUqRV
	oqDQIzDL+ir7KWnFy6thci417HLp2RmKBebLTYr5LcznaMrLPfJIfXF4=
X-Google-Smtp-Source: AGHT+IGixxxDoJV0YMo0rwsoyhEldF96phuEv/rTRk4BAVR+x+HH2OZUws6MZb7CLu9ro/nwBiDd24leVC52cMq5E3U=
X-Received: by 2002:a05:690c:744a:b0:6e3:1ce7:addd with SMTP id
 00721157ae682-6eaddfc5cbcmr187848187b3.37.1731457191802; Tue, 12 Nov 2024
 16:19:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031224551.1736113-1-kinseyho@google.com> <20241031160604.bcd5740390f05a01409b64f3@linux-foundation.org>
In-Reply-To: <20241031160604.bcd5740390f05a01409b64f3@linux-foundation.org>
From: Kinsey Ho <kinseyho@google.com>
Date: Tue, 12 Nov 2024 16:19:41 -0800
Message-ID: <CAF6N3nXPw8qv-Rmg6CX1afpkc7DmTQEL06LeDvY=Hcj0AnVx_w@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 0/2] Track pages allocated for struct
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Rientjes <rientjes@google.com>, willy@infradead.org, Vlastimil Babka <vbabka@suse.cz>, 
	David Hildenbrand <david@redhat.com>, Joel Granados <joel.granados@kernel.org>, 
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>, Sourav Panda <souravpanda@google.com>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Thank you for the review and comments!

On Fri, Nov 1, 2024 at 6:57=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> hm.
>
> On Thu, 31 Oct 2024 22:45:49 +0000 Kinsey Ho <kinseyho@google.com> wrote:
>
> > We noticed high overhead for pages allocated for struct swap_cgroup in
> > our fleet.
>
> This is scanty.  Please describe the problem further.

In our fleet, we had machines with multiple large swap files
configured, and we noticed that we hadn't accounted for the overhead
from the pages allocated for struct swap_cgroup. In some cases, we saw
a couple GiB of overhead from these pages, so this patchset's goal is
to expose this overhead value for easier detection.

> And: "the existing use case" is OK with a global counter, but what about
> future use cases?
>
> And: what are the future use cases?

As global counting already exists with memmap/memmap_boot pages, the
introduction of a generic global counter interface was just to try and
aggregate the global counting code when introducing another use case.
However, since the value of pages allocated for swap_cgroup can be
derived from /proc/swaps, it doesn't seem warranted that a new entry
be added to vmstat. We've decided to drop this patchset. Thanks again!

