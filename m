Return-Path: <linux-kernel+bounces-308168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F946965820
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2CA2B217AB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459281537D1;
	Fri, 30 Aug 2024 07:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GaPpYsE3"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F1044C7C
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 07:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725002069; cv=none; b=HlrLslrEaaoq4VqtdkWH96Qqzfwp0d0haHXVDk+q+b6kDxFBgLS/VQr8AWKINEoQwZO5NeFUeBr8XoU6og64yresgHZyF0RDmq6S3t7hkpEw/tM3KAT2VM86rrEaUY76KNiRJIEEqk2S02OB24LTisAHhIAzOuvOt0lmekjFrpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725002069; c=relaxed/simple;
	bh=totb9Gk8HYfTaUYoPwrx/gU7Nn3LqU08GtNc6/zJUEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Da2yr062pu9noumr3toeBB/KorScJnQqHMNsCIy1Yf7C4/OnkjG1gA5YPJjZ2ikig8B6uZ7DTOH1kGlaZiTmKs0gfBSgfgipimJj6r4jbCYc8merbnY2o5F8y5XjPZOyrIP0ckiS2VV7YYSV2mnnk5ZlW6xUAj2e/jF8J/t5Lhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GaPpYsE3; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8696e9bd24so184830066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 00:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725002066; x=1725606866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lE27HOqSAeqxKsX++00AjgC4a3EofYaayL4XrigSFRU=;
        b=GaPpYsE3hTf7CN3xszrDtmxjOwz9LzcijSYEP7ZjM/k5CZ/ywH8zOz/HfdxuNvhlt1
         I5Aq9Fmtoy68CunSrz67UyUrYWRuGt9RI+3d50Z3enunVtFKVP5oaAQubaqZS4aSm9PG
         zmPVBaD8CEsK0lw/JZt39GX5ykT5L4mrnoDIaxB65mbXkw3JXVxJ2s0OMw7yQRbhnIHh
         ia4DzXLCzO9wS6gCQKJzdwScpRtTYxKUGMv2fu1Keo7ut1AdxFfBZpYYr6VdbR/YSeKg
         vJmGqZmPW9Ylm5MMXjstTxROQJHpnkNi50HGOEIqOOAu7HlsHf6N8tTimTHApznK7wPu
         ETew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725002066; x=1725606866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lE27HOqSAeqxKsX++00AjgC4a3EofYaayL4XrigSFRU=;
        b=fMzzKPQ0gGX85+nikr7gzb5moaztdsSkMGrKahq3YUfYb9pFap1ORle1xZlfXBEND/
         uSRgTOBkqfSP3339RbpBq+1TAbo+Hm0vfoLCJYsFBBGJiLzzrqsSi4eezrE6NEcyD78j
         y6Gh08Sh8Uvy2N3vx7WKboxd+3PCy7IHJhsd+hVHaLpI4H+hLsqhVFyHGcpnvYiuFkqv
         LCNQiOSBbfQZyiOPMgWMurXysW5K3Th2iYluZkBxtsaJauusTc6UJ7nb4OCawDLl7bg+
         VN4e9w3g2cHnY9Wgtg0gwzCCQHpDOCyV3I2NuH4+kc+nOHhauWGI2YeoKq3YZBbHreuy
         scNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHH2fdtUPmnTztk2yqAfqyrjgwkXcfsIY2XtdNc6rBHNXmFT4s2ee0g3QpDwhn58H4p8yXbfJOZylmj9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNwGW9Wk3HLL8mWwrBCY2nhnjyCBW1SeLpJrUlIJHSRUl5oxu4
	T09dHisSOrrLejmzPlcQ7mHO9DDSDSMymyJaoBRweEU1cr0iyXQMre+pqB/I8z3VAZiwD3qjZv7
	q7tEDOos54yJVUk1WdVGEargOhJn5jgrsNDdI
X-Google-Smtp-Source: AGHT+IGaNudbImkNVyuwQt85PNUGnSiMWiDMzm96cL/fqsqHH5F2T9yhuDLnIBWgtyxOnOEtymQoZVMG7K6eJP8r3Tw=
X-Received: by 2002:a17:907:3f2a:b0:a86:9c71:ec93 with SMTP id
 a640c23a62f3a-a897f84d69emr419046066b.24.1725002065122; Fri, 30 Aug 2024
 00:14:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830112239957689310@cmss.chinamobile.com>
In-Reply-To: <20240830112239957689310@cmss.chinamobile.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 30 Aug 2024 00:13:47 -0700
Message-ID: <CAJD7tkZXVFS8XUi07vHAa5WTWR3myi=sSmrLrVpH0+AKCjDkbw@mail.gmail.com>
Subject: Re: The percpu memory used by memcg cannot be cleared
To: liujing <liujing@cmss.chinamobile.com>
Cc: akpm <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 8:22=E2=80=AFPM liujing <liujing@cmss.chinamobile.c=
om> wrote:
>
> hello=EF=BC=8Clinux boss
>
>         I found a problem in the process of using linux memcg=EF=BC=8CWhe=
n I turned swap off, the memcg memory I created with the following script c=
ould not be deleted with echo 0 > memory.force_empty, as explained below=E3=
=80=82

(Adding memcg maintainers in case they are interested)

It's not a problem, it's the way the linux kernel currently behaves in
terms of handling deleted memcgs that are still referenced in the
kernel (i.e. offline/dying/zombie memcgs).

>
> -------------------------------------------------------------------------=
---------------------------------
> step1=EF=BC=9Aswapoff -a
>
>
> step2=EF=BC=9Ause this script to create memcg
>
> #!/bin/bash
> mkdir -p /tmp/test
> for i in 'seq 2000'
> do
>         sudo mkdir -p /sys/fs/cgroup/memory/user.slice/user-0.slice/test$=
 {i}
>         sudo echo $$ > /sys/fs/cgroup/memory/user.slice/user-0.slice/test=
$ {i}/tasks
>         sudo echo 'data' > /tmp/test/test$ {i}

Assuming /tmp is a tmpfs mount, here you created 2000 child memcgs and
allocated one tmpfs page in each of them. So each of those child
memcgs is charged for one page of memory, and each charge holds a
reference to the the respective memcg.

>         sudo echo $$ > /sys/fs/cgroup/memory/user.slice/user-0.slice/task=
s
>         sudo rmdir /sys/fs/cgroup/memory/user.slice/user-0.slice/test$ {i=
}

Then you deleted those memcgs, but the kernel cannot free them yet
because the tmpfs memory you allocated above is still charged to them.

> done

>
>
> step3=EF=BC=9Aview /proc/cgroup and /proc/meminfo  files
>
> [root@localhost ~]# cat /proc/cgroups
> #subsys_name    hierarchy       num_cgroups     enabled
> cpuset                    10                   1                         =
1
> cpu                          4                     1                     =
   1
> cpuacct                    4                     1                       =
1
> blkio                        13                   1                      =
  1
> memory                  14                 2009                   1

Here you can see the cgroups you deleted still exist in the kernel.

> devices                      6                   94                      =
 1
>
> [root@localhost ~]# cat /proc/meminfo | grep Percpu
> Percpu:           600576 kB

The percpu memory you observe here is likely the per-CPU metadata that
the kernel uses to keep track of each memcg. Since the memcgs are not
freed, the metadata is not freed either.

>
>
> step4=EF=BC=9Awhen I use "echo 0 > /sys/fs/cgroup/memory/user.slice/user-=
0.slice/memory.force_empty", I find the num_cgroups of memory and percpu  h=
ave no changed

Yes, because at this point there is no swap, so the tmpfs memory
charged to the deleted memcg cannot be reclaimed and cannot be freed,
and the refs they hold cannot be dropped.

>
> [root@localhost ~]# echo 0 > /sys/fs/cgroup/memory/user.slice/user-0.slic=
e/memory.force_empty
> [root@localhost ~]# cat /proc/cgroups
> #subsys_name    hierarchy       num_cgroups     enabled
> cpuset                    10      1       1
> cpu                          4       1       1
> cpuacct                   4       1       1
> blkio                       13      1       1
> memory                  14      2039    1
> devices                    6       87      1
>
> [root@localhost ~]# cat /proc/meminfo | grep Percpu
> Percpu:           600576 kB
>
>
> step 5: when I use swapon -a to open swap, then echo 0 > /sys/fs/cgroup/m=
emory/user.slice/user-0.slice/memory.force_empty again
>
> [root@localhost ~]# swapon -a
> [root@localhost ~]# echo 0 > /sys/fs/cgroup/memory/user.slice/user-0.slic=
e/memory.force_empty

When you add a swapfile and try to reclaim memory from the cgroups
again, the kernel is able to reclaim the tmpfs memory by swapping it
out. The kernel is smart enough at this point to not charge the swap
slots to the deleted cgroups, but to their living/online parent. At
this point, the tmpfs memory is uncharged and freed, and the refs to
the deleted cgroups are dropped. Now they can be deleted by the
kernel.

>
>
> step 6: view /proc/cgroup and /proc/meminfo  files ,I found the the num_c=
groups of memory and percpu  have been reduced.
> [root@localhost ~]# cat /proc/cgroups
> #subsys_name    hierarchy       num_cgroups     enabled
> cpuset                    10                         1                 1
> cpu                         4                          1                 =
1
> cpuacct                  4                          1                  1
> blkio                     13                         1                  1
> memory                14                     185                 1
> devices                    6                      87                 1
> freezer                   9                          1                 1
>
> [root@localhost ~]# cat /proc/meminfo | grep Percpu
> Percpu:           120832 kB

Now the memcgs are freed, and their associated per-CPU metadata is also fre=
ed.


> -------------------------------------------------------------------------=
-------------------------------
>
>
> Therefore, I want to know why swap affects memcg memory reclamation,  ech=
o 0 > memory.force_empty this interface should force the memory used by the=
 cgroup to be reclaimed.
> I want to know why ,I look forward to hearing back from the community.

I hope it's now clear that the per-CPU memory cannot be freed when you
use memory.force_empty on the parent memcg, because the per-CPU memory
is the metadata of the deleted memcgs, and those cannot be freed until
the memory charged to them is freed (which needs swap, because it's
tmpfs not a regular file).

