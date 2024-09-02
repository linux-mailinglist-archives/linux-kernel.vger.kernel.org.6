Return-Path: <linux-kernel+bounces-311973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 712FA96903C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 01:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C92ADB260B8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 23:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A8E1925AA;
	Mon,  2 Sep 2024 22:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="XDSThvyY";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="QYRdZFCJ"
Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988F1190073
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 22:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725317755; cv=none; b=e8MRSrQxWoPAh1MzCJNQJ7s0FuA7RxqyQBAFKF/RsO+dGCuHqy0TF5n5IqNaPnVUUM+iO+dWJofK0sZwjacmZYu1zQRt6FPQQRQzs2l4yAU7D/NAUIP5Z8ktPUroSx0vKmXE/PUJve6o9ZBkWOIORpXvUayP57jQVlWc5F7mei8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725317755; c=relaxed/simple;
	bh=AvmAWDj4r+qYYbiUO/xgkn1rKtra/k9liRTqeOgGdlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6HGypIlKPyq+biUvIIzivxzDtfaabwTBR6RXbiuXItUmkn/gc0cZagKQyvPWo6U1LIEI7ucGLX+h93X0Y4VHELJQqeWsZEE1942ipJY/EpAO6tpz3P+RKGkNKSjoHPFmOcIdLcXhvNQByqMaSsEKi9ujMyxxoUOkEEEsKW1u0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=XDSThvyY; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=QYRdZFCJ; arc=none smtp.client-ip=169.235.156.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1725317754; x=1756853754;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=AvmAWDj4r+qYYbiUO/xgkn1rKtra/k9liRTqeOgGdlc=;
  b=XDSThvyYyU+Jv24eUypUcqZyXBsSFyt8ScDL1Q7rhmi1KO/cyBGz+sOJ
   6wQtqy6HUBnJGrYSvCdVnjBbTduuOMc/KrlMIIqJ71FU/rRgdzV3YjI5q
   Zg6JqFGZ9rHY/x5pLeP2UmtzSJhAJ2/hU5h+BiLoozoU3SrWuL/lemvLN
   d6hhmg36JFN3nImw8XtZc1V4ullTpi0gad3t1OgHRQP5ISFdSEFK1YY/a
   mi4lLSKNywV1bvc8nXAExY5dZmKWw7N3oEov+FpxAibeo5m2M0y21yAj8
   MO6kZ68S0nEjgCxPnp49iO5msy/BD7PjXSRdeTYYofOuH4faxRS4mp1yA
   w==;
X-CSE-ConnectionGUID: jiyHv5FTSy6BP6r2gQiSTA==
X-CSE-MsgGUID: jfJ/MmHmScqvV2jKNOTLMA==
Received: from mail-pj1-f71.google.com ([209.85.216.71])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 02 Sep 2024 15:55:47 -0700
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2da511a99e1so600315a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 15:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1725317746; x=1725922546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXqUNUJilunHcYsADZ4SlfhjWqR0TRaSMBkN7XpFRTk=;
        b=QYRdZFCJpLp2dR0kExWUGCI7ChLR//3yvE1//QeSwZSbjhIAL3/8t/hxszQLAtmAVD
         +SMiF5ZjzLbBhjo0gS3tQjSDySdBfTFlgLbB44eMgnSk5MHsud+BvEG7lqdlhRAvBG27
         RVc7S1l5KdkdLtkJc3/k990R1UmhiTZ6kqv28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725317746; x=1725922546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXqUNUJilunHcYsADZ4SlfhjWqR0TRaSMBkN7XpFRTk=;
        b=Snga7zENrmdJ2maVF3s8Hj+EAhFeWn3bJYu2EuTw4wHoXxQyX3QVAK0GLGZ6Mjg3sg
         ciiTMZl3DHe91FU7D9sl6QuUcsCbpXKN+KLu1Km7228b2ZzEo+U2HN3xgFdGJqhfXRwx
         pSswwkJ2XwUDpAgezWVAE9wC7/JeD3/YGuk/7qxqOjyOgCFoxvjnnz6B7/pN+qyndXxJ
         uFdQ51ptlXO4CpaDAgwGdu9N19BYxHqGPqy6FOdvx7KhG8xR1xfrGPA0SfbTrPuLNbzF
         mawL0OqmMEi+d7sKW8GUOWLquylAnFcQlUd5Lk5BtwoNdwpedOFBvgizQVAtE2QQ2LCy
         NDIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnE9kz7U07H/WYddA70pUZ/sg8V5cwDWsrrNXdwQWiQyMa6XFKVSXrPyhjEwbiqsVpZPIV/hn+M2kxlEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9h6jBiwZYs0UMalil4YMpR1BEnuAlOM0Tvo9td9FjTpMFdnqe
	JOw5FMIEV80G0XpVQBPxK54beuZkccXz0QgmgPevQvBevnVNhE1cI2a+hmkd/sNEjOrVUC27F4I
	vNVya2SFdniJ5ZORDgqgqiHNH0scjJio4w6pVZ9wA6DYArQesf5iqaG3rQ29M4bk5M7DwCAQD1T
	jjVHnOepoB++EW0io2hjRyoTW1e2PGALxo3u838A==
X-Received: by 2002:a17:90b:1809:b0:2cf:cd53:327d with SMTP id 98e67ed59e1d1-2d85649e899mr15941621a91.36.1725317746578;
        Mon, 02 Sep 2024 15:55:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv4GuiqlHjax8ecMosXFOzu7HGR5Awep2jt01fQqOhr+HIwu0Y2kLc8Secqma25pl6hYcvpOuEjYHN8fG0yOQ=
X-Received: by 2002:a17:90b:1809:b0:2cf:cd53:327d with SMTP id
 98e67ed59e1d1-2d85649e899mr15941610a91.36.1725317746189; Mon, 02 Sep 2024
 15:55:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-7TsMdA7rjxfpheXc=MNqikEXY9TZNxJt4z9vm6Yfs5qQ@mail.gmail.com>
 <87frqi76ns.ffs@tglx>
In-Reply-To: <87frqi76ns.ffs@tglx>
From: Xingyu Li <xli399@ucr.edu>
Date: Mon, 2 Sep 2024 15:55:35 -0700
Message-ID: <CALAgD-6MwUxVzN9Q=U5qBNnhO7tUy43dnT==Vh=TbJ4aCZpsgw@mail.gmail.com>
Subject: Re: BUG: general protection fault in __free_object
To: Thomas Gleixner <tglx@linutronix.de>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This needs the corresponding
kernel config, the exact kernel version and a description of the
reproduction environment (compiler, qemu command line ....)

As mentioned, it is on Linux 6.10. And here is the config:
https://gist.github.com/TomAPU/64f5db0fe976a3e94a6dd2b621887cdd
It is compiled by clang version 14.0.0
(https://github.com/llvm/llvm-project.git
329fda39c507e8740978d10458451dcdb21563be).

On Mon, Sep 2, 2024 at 2:21=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Wed, Aug 28 2024 at 16:27, Xingyu Li wrote:
> > We found a bug in Linux 6.10 using syzkaller. It is possibly a null
> > pointer dereference  bug.
> > The reproducer is
> > https://gist.github.com/freexxxyyy/5aefd53c6567415e9fe8c76cc2ad390c
>
> Reproducer alone is not really helpful. This needs the corresponding
> kernel config, the exact kernel version and a description of the
> reproduction environment (compiler, qemu command line ....)
>
> It does not reproduce here at all.
>
> Also if it really reproduces, then have you checked against current
> mainline as well?
>
> > RIP: 0010:hlist_add_head include/linux/list.h:1032 [inline]
> > RIP: 0010:__free_object+0x903/0xaa0 lib/debugobjects.c:396
> >  __debug_check_no_obj_freed lib/debugobjects.c:994 [inline]
> >  debug_check_no_obj_freed+0x135/0x530 lib/debugobjects.c:1019
> >  slab_free_hook mm/slub.c:2163 [inline]
> >  slab_free_freelist_hook mm/slub.c:2225 [inline]
> >  slab_free_bulk mm/slub.c:4462 [inline]
> >  kmem_cache_free_bulk+0x1bf/0x360 mm/slub.c:4676
>
> The code in question is serialized against objpool modifications with
> pool_lock. So nothing can change any of the related data.
>
>     if (obj_pool_free > debug_objects_pool_size &&
>         obj_nr_tofree < ODEBUG_FREE_WORK_MAX) {
>
>         for (i =3D 0; i < ODEBUG_BATCH_SIZE; i++) {
>                 obj =3D __alloc_object(&obj_pool);
>                 hlist_add_head(&obj->node, &obj_to_free); <- fail
>
> debug_objects_pool_size is initialized to:
>
>         ODEBUG_POOL_SIZE + num_possible_cpus() * ODEBUG_BATCH_SIZE;
> =3D
>         1024 + num_possible_cpus() * 16
>
> The minimum size is 1040, so there are at least 1040 objects in
> obj_pool. The loop allocates at max 16 objects, which means
>
>              __alloc_object(&obj_pool);
>
> is guaranteed to return an object and cannot return NULL.
>
> So the only reason why this can result in a NULL pointer dereference is
> that the obj_to_free list is corrupted. No idea how that should happen.
>
> Maybe some proper reproducer instructions shed some light to it.
>
> Thanks,
>
>         tglx
>
>
>
>


--=20
Yours sincerely,
Xingyu

