Return-Path: <linux-kernel+bounces-358968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D01CB9985DB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0B1282071
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BF61C4623;
	Thu, 10 Oct 2024 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YO6nKgOt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F5E1C3F3B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563129; cv=none; b=NK+EoNJI9AI3Jqqe5sUW1GwcnzySHXWqIrnPTOEfgefVnXvA6bUfVXraIHzyPLuXMurYvqfDdKMrgpN6JXKV2jewVZ/Zs1qR0LpIchfTKHlVhaGkCho8SQ4oGzDRsAWi0diMeLMm7EQcp48+GhAEn1lNJmbCVpxW0nvVXlCJMjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563129; c=relaxed/simple;
	bh=j53k+iqtLH5iTvwrYa1x5su0Idfk7cTjXBsHR1bRjX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fllYh2bX4Gluyc3yNc9YvwwnMWCHDCa4OKVSbVpo7qupsAif+VXk0VsVhybtZ4YlnFUPl5/JkLUjZU5YGew4NMq4HDZ/KXVCqhT30zSGfd1KYkgkajtvlp4SeFluL9d6bc1G7MHnQH5N1h3MtNA1SitqyKG6ANEZsahcojTmGSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YO6nKgOt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728563124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lv+b1p0pbHiqbpqU/YpAaDSNyCTb881lQaMqdfivw10=;
	b=YO6nKgOt0HC5YX6KAb/cmU+AbVN8XOqCWDoRQdn3CKip8nTgLQejyhsJqOicQBwpMoq4qC
	V6VqGRQlx2D3IwMXUyTgmyI1i0aPb9O6zFSPittVXVIF35PfPsoIwGgF+jwnb8ag4My9r+
	4Gt16DZsiWwkix2t6ctyeP9adGhwxUM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-KBlHcAzJOpyLrjtKMzQfXQ-1; Thu, 10 Oct 2024 08:25:23 -0400
X-MC-Unique: KBlHcAzJOpyLrjtKMzQfXQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c92901bb3fso580319a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728563122; x=1729167922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lv+b1p0pbHiqbpqU/YpAaDSNyCTb881lQaMqdfivw10=;
        b=aBrd8y5nBMFcZHvg9PsSOk61nwq+z5odyhXVC3C862sbzEfur6LHVUk3LhttadDNL5
         KE7JQqWg296ySQr+fkmcdkrHIPdKDfCnXinDFnamkiV7OiSikaG/SvJVMj6FsoYMgotH
         PYmVac+7LztI/bEugG/fIoLY7pxJg9SVcNhR6732qx8vUfv0PtLl3k0bPaqJaBgH24GJ
         a0KeqvQgpBvjDfT6+VpTExLkE1uUfny9GsFLig7vC49o0cam5pKPdGdvLMgQXNPdTtHR
         bv/UrYukkPpK+2fDQrYV2a7ZjgXs7gO7cHQVm9IuNZ3ngseZ15F9ZyVDAhlT01ItSqSV
         10XA==
X-Forwarded-Encrypted: i=1; AJvYcCW4poquZ7yVqYnCROfiNDJ6mdyk5x0phdqj/ZLshiufQayN8oHGroeWjErX2uGJNP2UxdFJG290gXoc7e0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrx5YFBQvtA7mAkVVIGmLwrrWYSyFaf4HepmFJ2hh0INhJYTqd
	BRwYk4mLlGaSfZypqi75DyJ0N0Ny5fCJ7B7HGtU5kW7SEZ2k1OmQz2ZYe0yf0OD03wjdGy5oWK9
	PUJrlr7/fGGHfgbMoXeq4A7S+5JbDzZG4j9bKq326hRpaefTkYuDLbFjT7nUA8lKNqiBz5rwvye
	HbD+XTIhHiX208MI6B87M7dMZgkA4ep7kb5DMy
X-Received: by 2002:a17:907:9717:b0:a99:425c:c653 with SMTP id a640c23a62f3a-a998d19f934mr532029966b.22.1728563122327;
        Thu, 10 Oct 2024 05:25:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC/zqiAiWtVMyc2j6Bf9V084EuqKrSc/W1LqvygQRRYH6OYSOoYWk0/MNkbRzT++Y593ecCVmCl1u2bbrtMzs=
X-Received: by 2002:a17:907:9717:b0:a99:425c:c653 with SMTP id
 a640c23a62f3a-a998d19f934mr532027666b.22.1728563121870; Thu, 10 Oct 2024
 05:25:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c355dc9ad23470098d6a8d0f31fbd702551c9ea8.1728552769.git.jstancek@redhat.com>
 <45c1f78d4f0e7f1b786443ffdd462d7670ec1634.1728552769.git.jstancek@redhat.com>
In-Reply-To: <45c1f78d4f0e7f1b786443ffdd462d7670ec1634.1728552769.git.jstancek@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 10 Oct 2024 14:25:11 +0200
Message-ID: <CAP4=nvRLgwu3y_c_m-SdPxaWm6rO_LVFKK98pkjFiLJ42LqhpQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools/rtla: fix collision with glibc sched_attr/sched_set_attr
To: Jan Stancek <jstancek@redhat.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jforbes@redhat.com, ezulian@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 10. 10. 2024 v 11:33 odes=C3=ADlatel Jan Stancek <jstancek@redhat.c=
om> napsal:
>
> glibc commit 21571ca0d703 ("Linux: Add the sched_setattr
> and sched_getattr functions") now also provides 'struct sched_attr'
> and sched_setattr() which collide with the ones from rtla.
>
>   In file included from src/trace.c:11:
>   src/utils.h:49:8: error: redefinition of =E2=80=98struct sched_attr=E2=
=80=99
>      49 | struct sched_attr {
>         |        ^~~~~~~~~~
>   In file included from /usr/include/bits/sched.h:60,
>                    from /usr/include/sched.h:43,
>                    from /usr/include/tracefs/tracefs.h:10,
>                    from src/trace.c:4:
>   /usr/include/linux/sched/types.h:98:8: note: originally defined here
>      98 | struct sched_attr {
>         |        ^~~~~~~~~~
>
> Define 'struct sched_attr' conditionally, similar to what strace did:
>   https://lore.kernel.org/all/20240930222913.3981407-1-raj.khem@gmail.com=
/
> and rename rtla's version of sched_setattr() to avoid collision.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  tools/tracing/rtla/src/utils.c | 4 ++--
>  tools/tracing/rtla/src/utils.h | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/util=
s.c
> index 05b2b3fc005e..c62044215a48 100644
> --- a/tools/tracing/rtla/src/utils.c
> +++ b/tools/tracing/rtla/src/utils.c
> @@ -229,7 +229,7 @@ long parse_ns_duration(char *val)
>
>  #define SCHED_DEADLINE         6
>
> -static inline int sched_setattr(pid_t pid, const struct sched_attr *attr=
,
> +static inline int rtla_sched_setattr(pid_t pid, const struct sched_attr =
*attr,

Hmm, rtla_sched_attr sounds to me like the function does something
specific to rtla. Maybe syscall_sched_attr would be a better name?

>                                 unsigned int flags) {
>         return syscall(__NR_sched_setattr, pid, attr, flags);
>  }
> @@ -239,7 +239,7 @@ int __set_sched_attr(int pid, struct sched_attr *attr=
)
>         int flags =3D 0;
>         int retval;
>
> -       retval =3D sched_setattr(pid, attr, flags);
> +       retval =3D rtla_sched_setattr(pid, attr, flags);
>         if (retval < 0) {
>                 err_msg("Failed to set sched attributes to the pid %d: %s=
\n",
>                         pid, strerror(errno));
> diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/util=
s.h
> index d44513e6c66a..99c9cf81bcd0 100644
> --- a/tools/tracing/rtla/src/utils.h
> +++ b/tools/tracing/rtla/src/utils.h
> @@ -46,6 +46,7 @@ update_sum(unsigned long long *a, unsigned long long *b=
)
>         *a +=3D *b;
>  }
>
> +#ifndef SCHED_ATTR_SIZE_VER0
>  struct sched_attr {
>         uint32_t size;
>         uint32_t sched_policy;
> @@ -56,6 +57,7 @@ struct sched_attr {
>         uint64_t sched_deadline;
>         uint64_t sched_period;
>  };
> +#endif /* SCHED_ATTR_SIZE_VER0 */
>
>  int parse_prio(char *arg, struct sched_attr *sched_param);
>  int parse_cpu_set(char *cpu_list, cpu_set_t *set);
> --
> 2.43.0
>

Apart from that, LGTM.


Tomas


