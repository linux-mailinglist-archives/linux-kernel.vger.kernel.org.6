Return-Path: <linux-kernel+bounces-262712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5419693CB2D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 01:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAFE282A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 23:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50504149001;
	Thu, 25 Jul 2024 23:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gXx9gLmI"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE32F145B05
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 23:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721949686; cv=none; b=lu/+7afUviaIiNMM3DQb3gLf5sPrQ5pXsXwpTqXbQ8/UuVDse50QvY4rS6AQFHumFxB+ObJ8qAGGKJ9F+E/T7kDHwrkIJugb8eOUnG/A+zSSM/eSKkBldDKw65e+5MjtrBR9x+qOKpb2f3jWLQ0BTLRz5DXCzJk374lu6grvqTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721949686; c=relaxed/simple;
	bh=mSz8fuJCEg7d/UoBKnz6Q6nu8zf2EleP4t3YtOmDo1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=csOUyCobMOixawJJiI/j8Whvur+mu8BEFjPorYHrwM5mmdjLJfTO1xKwC8vKmbbEF+3CTpgFjX4NG9fSlgX+3XRZ72S1Xj9tciSQP3MP2l2a0PNcVqUu6xN/7Ja8Ous4tcbdWJuNuIJfMnW8vxJEmiACu+93G7MHGV81fYI9yc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gXx9gLmI; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so140851566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 16:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721949682; x=1722554482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BhWFqkULj+AvRbdCNR9XG39O/J74nwNfGpIydF1LCg=;
        b=gXx9gLmI2jpGsYZa2OUVTZq0HznDV/ikyccRPqjQDoUdiP9eYDt9CDLv/xMVUxeYVH
         Xmazt/h0MM+JpYNkHz+bgaxwQWcIwTmNmhZ0aXfDEtWpQiaEtDLp+NwztzbJ1vf/Mu96
         asHy8MyFyS0W7qrGDiwDPNs2U+lbe4gbKAhh6DK0KX3DTPTFRW7ZENv7qvoNfs8u+OE9
         48QVZiTPjTLIAX+crA7RufqeApF069/4ci40jkaBXOOMPOaKZ5LGU90ZX0hw8DUigHA1
         RX7aA2PqssY37OqB0c+r1FpVbcVU80m5JTwVvZ1khGAJdmJSncawoQ8IqA2Xt8+SJnyN
         i/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721949682; x=1722554482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BhWFqkULj+AvRbdCNR9XG39O/J74nwNfGpIydF1LCg=;
        b=Yi2esC1yTiEIy9BtfiibL4zLN4Xa6FUAevPpBzcmPBCdBebvixO/SP4sirFEsnA1kY
         XGVK+706xbNopIakVJRHCUMi2PfxmkEfx8g5jAukP/pJ+d+NiT8eguNSBq6f0tXBolMn
         oFo8lL2Dr9bbV1MYDAv8hs7tWGpcwePdevXH9s5GeID3XEXR90UMYzEt+aBvzMo7Dq1k
         7p1lZE3eE1uMuR7KmTKPMXTXE5rIjGTixWLQeUvopNl+/1ASLw1mJVXxFAhxpnWUli9W
         jDl3u78Pawr4pchaZfW2rA4zMBHI5m5w0NpQJBqIFOezI3Ijp7j08Q+sNiWZoFuQJw7v
         rbdg==
X-Forwarded-Encrypted: i=1; AJvYcCVFdlSupzy2Hg4+xppRtWBzQpzFmKRZl4QLRIxttXR8fRvKZ+jTUn65q1yvRf4g84gsggHSSKKGTvzdJTjIesshme0Yv1RcdFm6lsYu
X-Gm-Message-State: AOJu0Yxjve2SkRbz7U+OZwqArANkTqgIUZKMvKezkCkC+eJElZ+fDueR
	nq+K74PbO79po/XHTfUaIIstHUNfFgxU3E0h+VN1r1oEblv4fT9MipG3D0hFk+DmuQlyPYpjzZm
	JHyqXdyuocFN9D5AiExM3MdWy1d0w4KY55K+W
X-Google-Smtp-Source: AGHT+IHJ59e3RjfpIjsYfqW7mSWdBpnmRV6+dg8CCj0u3/kAEp8Crps2xN4z3/VbgDQB02FDUaGMQUFTjFWq19hvltU=
X-Received: by 2002:a17:907:3f1e:b0:a72:4444:79bb with SMTP id
 a640c23a62f3a-a7ac5087ca2mr386817766b.59.1721949681571; Thu, 25 Jul 2024
 16:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722225306.1494878-1-shakeel.butt@linux.dev>
In-Reply-To: <20240722225306.1494878-1-shakeel.butt@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 25 Jul 2024 16:20:45 -0700
Message-ID: <CAJD7tkaR3s6fzRZWdvMvfSRBRaozSj7d2pH5HUjtbuOW+RROFA@mail.gmail.com>
Subject: Re: [RFC PATCH] memcg: expose children memory usage for root
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Greg Thelen <gthelen@google.com>, 
	Facebook Kernel Team <kernel-team@meta.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 3:53=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> Linux kernel does not expose memory.current on the root memcg and there
> are applications which have to traverse all the top level memcgs to
> calculate the total memory charged in the system. This is more expensive
> (directory traversal and multiple open and reads) and is racy on a busy
> machine. As the kernel already have the needed information i.e. root's
> memory.current, why not expose that?
>
> However root's memory.current will have a different semantics than the
> non-root's memory.current as the kernel skips the charging for root, so
> maybe it is better to have a different named interface for the root.
> Something like memory.children_usage only for root memcg.
>
> Now there is still a question that why the kernel does not expose
> memory.current for the root. The historical reason was that the memcg
> charging was expensice and to provide the users to bypass the memcg
> charging by letting them run in the root. However do we still want to
> have this exception today? What is stopping us to start charging the
> root memcg as well. Of course the root will not have limits but the
> allocations will go through memcg charging and then the memory.current
> of root and non-root will have the same semantics.
>
> This is an RFC to start a discussion on memcg charging for root.

I vaguely remember when running some netperf tests (tcp_rr?) in a
cgroup that the performance decreases considerably with every level
down the hierarchy. I am assuming that charging was a part of the
reason. If that's the case, charging the root will be similar to
moving all workloads one level down the hierarchy in terms of charging
overhead.

>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 6 ++++++
>  mm/memcontrol.c                         | 5 +++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 6c6075ed4aa5..e4afc05fd8ea 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1220,6 +1220,12 @@ PAGE_SIZE multiple when read back.
>         The total amount of memory currently being used by the cgroup
>         and its descendants.
>
> +  memory.children_usage
> +       A read-only single value file which exists only on root cgroup.
> +
> +       The total amount of memory currently being used by the
> +        descendants of the root cgroup.
> +
>    memory.min
>         A read-write single value file which exists on non-root
>         cgroups.  The default is "0".
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 960371788687..eba8cf76d3d3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4304,6 +4304,11 @@ static struct cftype memory_files[] =3D {
>                 .flags =3D CFTYPE_NOT_ON_ROOT,
>                 .read_u64 =3D memory_current_read,
>         },
> +       {
> +               .name =3D "children_usage",
> +               .flags =3D CFTYPE_ONLY_ON_ROOT,
> +               .read_u64 =3D memory_current_read,
> +       },
>         {
>                 .name =3D "peak",
>                 .flags =3D CFTYPE_NOT_ON_ROOT,
> --
> 2.43.0
>
>

