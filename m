Return-Path: <linux-kernel+bounces-262708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5072993CB23
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 01:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06AF62821D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 23:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B9E149001;
	Thu, 25 Jul 2024 23:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z2RmqE2i"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F556143738
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 23:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721949147; cv=none; b=bTTsu93/uywmgFnyT5nFeb4ddHq2v66UgWhmwWYUtuImuwsDIU8TKLFwp0BK8zwV4H45KxVP66YKzj0wbuIt1BDLtqirjSJZfUHhDAw+cFqDyCHWvh8p9IFPJumJSQT8QYsuA0EF4jT2sEAhPXexvtFPrGFZEyCgH2k1BPPN0ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721949147; c=relaxed/simple;
	bh=FArKmzRC0yJOVkaBqWwuTpFKKJvGBvsHSZKLPxb7Kzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mt1gE/E4p93J/hz/oaNDvTfWn2EUxQrt1btTZx4TKA08scMnR6UpVJRTxrbiIM5RP4nRO74ewvPpAwnaL4VIiOh8dfviiLvrL554FhwqwDG7sYl1TWEOncBlqBQfSldXTIH1E060GEvDAKMPDOpFqbvLczO62LkxZoFq4T63bnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z2RmqE2i; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dfdb6122992so1373623276.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 16:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721949144; x=1722553944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3d1zGC521b6j6WMF79KL4j8jgavX6XjnXIm0tZCyjk=;
        b=z2RmqE2i39luTA6Y1PXwcviL/LsRYylpgc+/qxB4G83d1tMXGTdCZjKvEKJ1GCXAGL
         GZUD7BCUMKEMbQtnPq153lcpjYKjy7TuMJ/SLV4Tg63XPn0sDb3kSWJGL89GGEvDsr3s
         G9cq9zTYWU1XezCa71jQHqQ+AHYfmzxR8davbRStKKE5mombnckSZUh2NsP8u9USomxE
         Azm/VS5F7k72bq+Q6T3y4IqP7Vse1Wp0W/VuE9f1RlCLugd2/WSwC9f4Cf/ImzODW3Wc
         qToeVKuKqMIwzqF424hfAVft/ml0UUMNHSIwkYY2ONGr+1UD2UBvCdfovR5DZzvBRfLe
         RpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721949144; x=1722553944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3d1zGC521b6j6WMF79KL4j8jgavX6XjnXIm0tZCyjk=;
        b=tJeS+Jud6Xcv9ZL73s8VkKEVyB+pvHXkJxg+BaKx9SJ/UzS5dZW10GPDeTPjnb82KI
         H68By3EGwEMWmkvaQzwxOjPxo+T7Vsol+z6BH1t05LO5d5DYIbeBzfm3WcDEepl913Eg
         0BSYQ2+qV/pn8MFT88oVeU97d5uML+lySlWAu2HMtych0lRPA98iLqyryDU5HZzwtMB2
         Cbuc9Tp+5GH20dkUqiiREyIAkCQbGChmOiOPNV2I/f2+ppFSPjQDzt8Addmf6cPJ02lX
         te+Y/Ovjj4Dr7omM5W0xN37/5b3QN3VYTkC80PRY6M+2Ay2I9stMfNQdJUOvpAJiwweu
         llvg==
X-Forwarded-Encrypted: i=1; AJvYcCVOnybC3BR79hmNMBXETVtc58h6wl03J+xxQsZQaLix6P9n31C0i0kuHfAnhpiXaEnAkMNHoWq0Q1NlFKXK5+jRpxxxOLDbiIAwfVnk
X-Gm-Message-State: AOJu0YwQlJZSKoutyOt6EBd77vblGcobKM2COGOYPS3niGFRTSVcV+al
	eaPBaVQ+0/nanW6RIDhlfpQ/fCWmIrgXjAtu56LYZDH7OHFP1CSLsV96hXjhu2/0ERGaUzymjg+
	4XGp6upS+E4eb0v8m0oKgoA2nNjnkkwrI6DBy
X-Google-Smtp-Source: AGHT+IETY78vyhD6DEhT9etUSc8N43LepRmktceChLoKqRE+NzzWbiEyqOzvL9PRN7JfjPX50EG5OzRZoObQNo3ZoU8=
X-Received: by 2002:a05:6902:1ac9:b0:e03:4501:6102 with SMTP id
 3f1490d57ef6-e0b231f402cmr5256018276.46.1721949144110; Thu, 25 Jul 2024
 16:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722225306.1494878-1-shakeel.butt@linux.dev>
In-Reply-To: <20240722225306.1494878-1-shakeel.butt@linux.dev>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 25 Jul 2024 16:12:12 -0700
Message-ID: <CABdmKX2Hsd7i_Erc2_n8FQqY90mMgX24hkVe+z=y9tCk7sUL6g@mail.gmail.com>
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

Hi Shakeel,

Since the root already has a page_counter I'm not opposed to this new
file as it doesn't increase the page_counter depth for children.
However I don't currently have any use-cases for it that wouldn't be
met by memory.stat in the root.

As far as charging, I've only ever seen kthreads and init in the root.
You have workloads that run there?

Best,
T.J.



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

