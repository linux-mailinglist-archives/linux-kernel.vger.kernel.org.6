Return-Path: <linux-kernel+bounces-423923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A73E9DAE54
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB9C7B223F1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF473202F88;
	Wed, 27 Nov 2024 20:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l2YGRm9g"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7599E12E1E0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 20:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732738222; cv=none; b=VkzMBazKue/2U9GC6HTKwM/5w0NUm7dQgfpNsqlvZMJ70BLSHzB6R128aRpV6/kUJ2eesh4sOAZN8g3pdhxLoMOkm4/tkobzlL323oln3om+ONqIB1sDP6mxFY761II6lz4UCz+t9kMgp8wqKo9Dgd5lVUuT6RmSvcEI/7rJ7Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732738222; c=relaxed/simple;
	bh=hUBcNXvuvLbYXhYdraBI3VWzdlKOrSFOIJZwTLRZEZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nd1d4qlxb600IFANnSviNfX9o+WJWjKHXpxYJQN13qm7yMejICM9db2n8zJHnHsYp5PcNV2TbRakyE8WISLV0Nk7YWyHXh4NrE/kQNs1S5VJN3KLksm5Tu1IQrInkfFYEHMdHre7ThK4bVUTkWa4vQm0gk8JoiyqVi8qv2vkaEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l2YGRm9g; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434a9f9a225so4295e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732738219; x=1733343019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUBcNXvuvLbYXhYdraBI3VWzdlKOrSFOIJZwTLRZEZw=;
        b=l2YGRm9gPz0ZsEhi8TnCA9kznf2WGM+FRitcXjQA40wZNRpg1+GHIc7J+bJq0UmgW+
         +997SmxG7Ei1vpqfjjvPPN4bDgi/ARVac/AeyZmG9Y+jTv8Na+EcXUMK53rjXqJVIDuz
         /81AHUDLGMxxftFghEmcELMiyM/XkJDuRVV4/Qrb3wlR7mYqOeLAA98y3BfkHO5dT7TG
         ufPRfEi/V+NX/GAxTnNOW2XFSSqpDlqVgLZqSepsz1jPqD6CLr3LDwGNIwlhwrl+tMiR
         qTQI/ffoUpOKYI1Yl3RJYcJj2lHBibtQ8hgaIMEVkJxGrpbgTZdQ+aIkWkgaB4hLPcmS
         F+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732738219; x=1733343019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUBcNXvuvLbYXhYdraBI3VWzdlKOrSFOIJZwTLRZEZw=;
        b=fTVUZJgarwZHPAxV/P1pjzHqzFBrJi1PGj1aQzgG4ZmB9SxuXYZwMeVqpnMlJzfFQu
         wG/T2VCVk+7ooxZFV3Du7drhQO1TJ2jLcmpc5oBc2tkOx0NADlwon9/gn9Jt8wCsCAK4
         aBehEY8HYA5EuyRh9jHM/QVMbSm34v5hij14q29GjqJVARfzc+voR5bkmrEX2uk4Rwf0
         U9xZ+PP2XGxr8ns86KD6L52eDrAJyQEKEB4KQ8fQtBMDmly/TI71SN0jRXRQ3K0Irqiw
         c/bb9Ln3i3Q0OiMjcbUQWYTRoPyKN9tJ1r/dQwNGoLv5igDHMVsA8yiO/LS6nPYzbaVs
         ak4A==
X-Forwarded-Encrypted: i=1; AJvYcCWZMr9NMfwVC4wCesqgPDQxlBfFFEpOQZWPh2S++Iw0UPXJeJJ4iNKBJK2AE/tC44oUc9OoDx+YjyK1dlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj1GGDUsR1f07SMienUPoxiYO6MK9U9c9P/bBZjB73IaQWmXia
	ljEUTFNhWuzqEQqMruvTdg6mt3lZIvfmV+5WD+9ryUZUDBJdpV9jvPRadc46UI8J3qrer9PmN7E
	aj/AGpRP6lDfMU5l9wGEWacQ8fkAHG0WpWXYy
X-Gm-Gg: ASbGncuWD1F+82BnBDHCAc0Z4zNopWGQreka41ijPk3dkYEp0yybx3XzwOFGKhqVo7m
	KhgqPGEYkcCSz1qknk/ws/yywLQpK0qulRAyTnLOErky7Bnyi2JSfrBlSnxY=
X-Google-Smtp-Source: AGHT+IG+kehlB4s0M5dWyJKGLHeYyY36EY44ty+lp0Mvoe5e9HkKe9gEegCulaT0+L4A1Oxd2n33hHXL6WkpLXJ43p4=
X-Received: by 2002:a05:600c:3b28:b0:42b:8ff7:bee2 with SMTP id
 5b1f17b1804b1-434b066ec64mr85985e9.5.1732738218634; Wed, 27 Nov 2024 12:10:18
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125171617.113892-1-shakeel.butt@linux.dev> <Z0Yhivws5XSeme68@google.com>
In-Reply-To: <Z0Yhivws5XSeme68@google.com>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Wed, 27 Nov 2024 12:09:42 -0800
Message-ID: <CAJHvVcg_mHiGvMpaM5XX8F7cvsxxGc9oOdCsy4zjMJAd9kX8-A@mail.gmail.com>
Subject: Re: [PATCH v2] mm: mmap_lock: optimize mmap_lock tracepoints
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Suren Baghdasaryan <surenb@google.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

No objections. :)

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>


On Tue, Nov 26, 2024 at 11:29=E2=80=AFAM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> On Mon, Nov 25, 2024 at 09:16:17AM -0800, Shakeel Butt wrote:
> > We are starting to deploy mmap_lock tracepoint monitoring across our
> > fleet and the early results showed that these tracepoints are consuming
> > significant amount of CPUs in kernfs_path_from_node when enabled.
> >
> > It seems like the kernel is trying to resolve the cgroup path in the
> > fast path of the locking code path when the tracepoints are enabled. In
> > addition for some application their metrics are regressing when
> > monitoring is enabled.
> >
> > The cgroup path resolution can be slow and should not be done in the
> > fast path. Most userspace tools, like bpftrace, provides functionality
> > to get the cgroup path from cgroup id, so let's just trace the cgroup
> > id and the users can use better tools to get the path in the slow path.
> >
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
>
> Thanks!

