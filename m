Return-Path: <linux-kernel+bounces-256251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0FB934B6C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF6F282161
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FF912C474;
	Thu, 18 Jul 2024 10:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="FJ/LcfCg"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADD4824AC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721296864; cv=none; b=OcMOwtfop+3EsTcONNriCYzggt24yZavBA3+mF67BXQrhsPsdiP+Exnd7eMWFkA/4PLhr/DFUsIqzzqyw2M6ylVS8ty9lbdRv4rG4629PSspYWAEUwncIBhl4Or+y9+Ij97P5mKHa8nDDYdLK3KjirMi37l8BWhWa1f41/URmhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721296864; c=relaxed/simple;
	bh=PVKzFBjUylgl+SFX+eVz4j3ekjHizvwoGKwdu26z3lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dtCO3KayvvvRRqwWgNukosw1D6G+bois1l748TOxXjx78OocxzVwt3iPDflyBR+kpKbGOHEGpNEKxJSE6NUo+SAxbnJKEQOMtiZM1ZSPj7F6UCio+deCG5wKXpvQYOCn++fEHxhLESsXyQwpQj4j07Ax/9EhDRBYPr6VBDGRv28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=FJ/LcfCg; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0B686400E8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1721296855;
	bh=8LsyU/bDvYfIu4r+7OnoQP5eYa7svy7lWN7+7+yiUFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=FJ/LcfCgi4iWKrrBHyzpNoS1c6Ri3Jz+hQ7jxiJY51oXJj7MEQJTY8cy2pqk69GN1
	 ieqBCyNPylQRRR1xTHlhp+kV3rEba67BGuvsF56fB2gYE7R53Sa82YbbCh8KTz6RBk
	 djZG315KItSpWBxiD7COnjztt/zx9QUUnPMo2mC4+HDHlYzaPqoe8kNre/EVoDMhSi
	 lho1Zi02wCfH24HXsG4TigPtOYMdkSM+tlTxkHNiFuJaToAvZARCDcZm1UYZ2Kb3RJ
	 aDN2yCC23/rfgXbzFzCfDRWkZDYO4vD7utufHvYhMJc8ZOnzZsY5P8UHr0ykOa/+hj
	 jTxnJcrUvKsXg==
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-821650bdbe4so238363241.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 03:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721296853; x=1721901653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LsyU/bDvYfIu4r+7OnoQP5eYa7svy7lWN7+7+yiUFA=;
        b=uLAkiVNFDIK9o/jkzeZjkLDJAR+7TlKUh9cX1cK30HRJhX3faWxnFpsAvLsw2A3iWi
         CbCQHzmQmR1LNt8W9QodZdAg+cDDqu3umyDG53nIzZb0ILEWndeEl2KiFGyUtIkmdRm/
         /5XL92W/jDti3fFMmP0dVYJGz4zqhvwynGi0kUVqHThBaysTkXerff8377Afm17iSXrB
         ThY2iuJXBq+5qfRoGMzDF9xu6TYNCGEXdg8k73LOSiEL4li3+uMOCVK9dDbzPNymx04h
         JLzPHAXH+8zw5ywbTeaujgi/SHN+NH5TgI37PlOxwbByH/k+Zb8AvHVZsz5/kW0wlwBj
         Ml/A==
X-Forwarded-Encrypted: i=1; AJvYcCXFSI8O7NM9hAOcgoXR+pfoLZdNy2JJY1W2s/bn8g9d4zTg9k1fAx92Ql2VV9/aUaihM7aYcRnHVh31uZQH5ztvcK4R3m2uWJFT94NO
X-Gm-Message-State: AOJu0YzZNOOjkotq1e6Zt1yEaHnOtPjoewiYAcAJjwwelQ/O504UkAO3
	T+dkkjOwrAhSWbofhWnwMiBK7FpaymvWffqF9HCGYjDj1mUJkt5RxpDv8dtMjd/zyLLB/Pq7B26
	sGdBZ+CSV/8O8cZbb2bgocDImR/0scaQ+ovFox3c0mxh/6O0jTuMgYISSiBTLxd6ZlhQz0JGRCw
	/+3HvQKoujNtGipaqEKxZHwDCib4Qub8kcwmx6YxaFK16bDaw2Z3+j
X-Received: by 2002:a05:6102:5348:b0:48f:e68d:bdc6 with SMTP id ada2fe7eead31-49159a2eff7mr5727764137.33.1721296851013;
        Thu, 18 Jul 2024 03:00:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqJKCH3G3nyP+aVB8d0rCp17Ac0e3EmSJIvfmYYqEiGnQ4Po6sCBParIO6wIwVz03HPaymow75Y6ld3Wl9FUI=
X-Received: by 2002:a05:6102:5348:b0:48f:e68d:bdc6 with SMTP id
 ada2fe7eead31-49159a2eff7mr5727736137.33.1721296850693; Thu, 18 Jul 2024
 03:00:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105152129.196824-1-aleksandr.mikhalitsyn@canonical.com>
 <20240105152129.196824-3-aleksandr.mikhalitsyn@canonical.com> <CAJfpegsttFdeZnahAFQS=jG_uaw6XMHFfw7WKgAhujLaNszcsw@mail.gmail.com>
In-Reply-To: <CAJfpegsttFdeZnahAFQS=jG_uaw6XMHFfw7WKgAhujLaNszcsw@mail.gmail.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 18 Jul 2024 12:00:39 +0200
Message-ID: <CAEivzxc4=p63Wgp_i+J7YVw=LrKTt_HfC5fAL=vGT9AXjUgqaw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] fuse: use GFP_KERNEL_ACCOUNT for allocations in fuse_dev_alloc
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mszeredi@redhat.com, Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 12:01=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Fri, 5 Jan 2024 at 16:21, Alexander Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
> >
> > fuse_dev_alloc() is called from the process context and it makes
> > sense to properly account allocated memory to the kmemcg as these
> > allocations are for long living objects.

Hi Miklos,

Sorry, this thread just got lost in my inbox. I was revisiting and
rebasing fuse idmapped mounts support series and found this again.

>
> Are the rules about when to use __GFP_ACCOUNT and when not documented som=
ewhere?

The only doc I found is this (memory-allocation.rst):
>Untrusted allocations triggered from userspace should be a subject
>of kmem accounting and must have ``__GFP_ACCOUNT`` bit set.

>
> I notice that most filesystem objects are allocated with
> __GFP_ACCOUNT, but struct super_block isn't.  Is there a reason for
> that?

I guess that it just wasn't yet covered with memcg accounting. I can
send a patch to account struct super_block too.

These days, it's pretty safe to use __GFP_ACCOUNT almost anywhere,
because even if memcg is not
determined in a current caller context then memcg charge will be
skipped (look into __memcg_slab_post_alloc_hook() function).

Let's ask what our friends who take care of mmcontrol.c think about this.
+CC Johannes Weiner <hannes@cmpxchg.org>
+CC Michal Hocko <mhocko@kernel.org>
+CC Roman Gushchin <roman.gushchin@linux.dev>
+CC Shakeel Butt <shakeel.butt@linux.dev>

I have also added Christian because he might be interested in
accounting for struct super_block.

Kind regards,
Alex

>
> Thanks,
> Miklos

