Return-Path: <linux-kernel+bounces-205406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E21E98FFB18
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9021C23635
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 05:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BB61946B;
	Fri,  7 Jun 2024 04:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qPx8dDr6"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9B21BC4B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717736331; cv=none; b=RYgOUpt62zzE/grYK27d6DPeVXdtvJYJD/kZa8a2Y3Dv56xGmGUtVLkN/CQ4ixeplOcLHVxr2OrVdNsKyfQFzKa33m86eudIxwB7gxIB0ytrqTKJ9nBylSA516KSRWwF65DVhxg85fMbM+sa5HqO29WA5cZV+gBjv65HCfNsJgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717736331; c=relaxed/simple;
	bh=09oLwl2Fi7q3ZOGUqyDhPiw36+NyQKSV2deDo6izUjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RFDd1hU1YQli+i4MawGODIdXwRWAw4COSKnhDMN036CCksXRD27ji/NgBV8yLGsgSMJJ+XRkJhJfVcpDMBHMAWHpbLvJc4MPqkr3QTYfhChL4HwEruvsL1wWTXFxv8hDuPg55BoAJKy552btTyjAgm5R7iEdBaOm0sqhVP7JCMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qPx8dDr6; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a7dc13aabso2040486a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 21:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717736328; x=1718341128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09oLwl2Fi7q3ZOGUqyDhPiw36+NyQKSV2deDo6izUjk=;
        b=qPx8dDr6McRmCYu+EcF0ZJBpDWpBsZjvjZ2X3zLHJaayzi0iZfvYw7YIqROIBAwDgq
         qG2NN9ZP3xyIwge2ESHgbEwEijnD9vpyo8YV+WdNVooJseC4F3feLKUQEATLxnr8Mhac
         ih7Dw9EicQdVQGJnCbjoUlOqM12o8ZQNJJoLOAJ6CiQ3OAYmn+0piVpcBhAMccHiBFTa
         pizMO+U1oJKB5hTjhR0L94oLqSX08dkDOzMHaC1qrBnwhs+8K7yMdiaDV/ak5qNIpL/s
         SUoBCcekhKXhinQb5NpGxpFq0JM8WvqLnMthhtWVULjpYppqoepysZy2GlW4b249xkAu
         AS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717736328; x=1718341128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09oLwl2Fi7q3ZOGUqyDhPiw36+NyQKSV2deDo6izUjk=;
        b=K094dwSWkNhSHjKs371S4DOXJJKrJ0cO6S4Dyt2Et8eDvROVo5b743hzTCWgbMuq/F
         65rGSGzCMtK7/HuEsgHY68p2lCZ0VB2SGehOPb3S4a9OsrVXfoVf5a+SfV+JPglIq4BF
         CA9u4VqFT47tm6OSeZqzffdg1JPTmusZfFcNgJ6GMhM+ytagFKIb6jJ1+MCkRXKH9Hi9
         sAH3Lbl2OOeHOOP2Cq0GiL7EnZ3l/eV2JVZRe////bB36ZOU4zngiWSx3b174pO1Mt7p
         4ThjcN9WhO97UB8JLt9QMVfo93dG4/p6IEe+tNP5PQHkD0UHuwmyMdz47Zw1Dv6uEngK
         fOGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2C0HuuPRit9ZFdWQcXx5LsMpFV7Qw1P37+1fNsA8a9+JXNbhpIdOq4a3P43Fteq26ERoQpPm25058O0b7gRKC35krag4USdRcIN06
X-Gm-Message-State: AOJu0YyuNTOeD6hfDA4S+IamICVu7tKs/JOrsagQ09BxxSp9hX7SFYHP
	LEfXUj+b3IVX2IW1cpmjpINh0HVm1gCWxvbtcM5u1X1hlhkl9COqVz0aKuGYRlcinT8Dw06z+Rk
	yc6NsjbUalMvoNX0Jt47o1upF7cYnA9USoIbi
X-Google-Smtp-Source: AGHT+IEQDEkW/UIMBTN67S6TtKaGz+0SsoOGahvJjV/bvIcWOW58RFnZgGEnkj/89Q52sY1SCqwuAn43LLmE3J0H/0s=
X-Received: by 2002:a17:907:766f:b0:a68:f1ca:db46 with SMTP id
 a640c23a62f3a-a6cdc0e077cmr81577266b.64.1717736327464; Thu, 06 Jun 2024
 21:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606165303.431215-1-flintglass@gmail.com> <CAJD7tkZ=o3AN+4Cj5UBJv6zcrjPFW5T1_53iHB2qtShRRhKhbQ@mail.gmail.com>
 <CAPpoddc5ge0myLfN8burL9fEUjc0oaB0C8Yc3_J923hd_O9u4A@mail.gmail.com>
In-Reply-To: <CAPpoddc5ge0myLfN8burL9fEUjc0oaB0C8Yc3_J923hd_O9u4A@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 6 Jun 2024 21:58:11 -0700
Message-ID: <CAJD7tkZPB8SSGgaobvFtQ5aOHjBzLt9DLxYT4j8k0sSyyLdURA@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: limit number of zpools based on CPU and RAM
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 6:01=E2=80=AFPM Takero Funaki <flintglass@gmail.com>=
 wrote:
>
> 2024=E5=B9=B46=E6=9C=887=E6=97=A5(=E9=87=91) 2:46 Yosry Ahmed <yosryahmed=
@google.com>:
>
> >
> > There are a lot of magic numbers in this patch, and it seems like it's
> > all based on theory. I don't object to making the number of zpools
> > dynamic in some way, but unless we do it in a data-driven way where we
> > understand the implications, I think the added complexity and
> > inconsistency is not justified.
> >
> > For example, 2*CPU zpools is an overkill and will cause a lot of
> > fragmentation. We use 32 zpools right now for machines with 100s of
> > CPUs. I know that you are keeping 32 as the limit, but why 2*CPUs if
> > nr_cpus <=3D 16?
> >
> > Also, the limitation based on memory size assumes that zsmalloc is the
> > only allocator used by zswap, which is unfortunately not the case.
> >
> > The current implementation using 32 zpools all the time is not
> > perfect, and I did write a patch to make it at least be min(nr_cpus,
> > 32), but it is simple and it works. Complexity should be justified.
> >
>
> Thanks for your comments.
> I agree the 2*cpu is too much. it was conservatively chosen assuming
> 1/2 contention while all cores are accessing zswap. Much smaller
> factor or non-linear scale as your comments in the main thread would
> be better.

Chengming is currently experimenting with fixing the lock contention
problem in zsmalloc by making the lock more granular. Based on the
data he finds, we may be able to just drop the multiple zpools patch
from zswap.

I'd wait for his findings before investing more into improving this.

>
> I found your patch from the main thread.
> One point I'm afraid, this hashing will fail if nr_zswap_zpools is 1
> or is not rounded to order of 2. hash_ptr crashes when bit is 0.

Yeah that patch was just for experimenting, I did not test it well.
Thanks for taking a look.

