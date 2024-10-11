Return-Path: <linux-kernel+bounces-361452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 903C199A877
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255C3285ABB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22B6198826;
	Fri, 11 Oct 2024 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmnQYg+m"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3EE18EFC1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728662176; cv=none; b=avWhwbEktcXWp3dFjqGba8ZPMN+BnEh2olwzgal9AuD4ROgN2lUAkC81XFG82+TIEVtDsGXevWybusaoWMBf4kFwSfBhFLtiC6FRnvrfKdC8lIsLgzwaHkzl0a/6CcYCk5fVppssWtZpPJqMUmfviNALAlqt8YqaWt5ZP+C2ksA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728662176; c=relaxed/simple;
	bh=qdBjszcGd8Y4WhqUk+9sib5aFU1rVddxPqsOThaQZXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U306YcwH0pE9oSfMUttM8gd6AumqjQiwwFkPfpK/ivFVi0mBWG9pRqAbfHp8wqVLvKNfH3YxZIMp/ZKo1oT4QL7DVH2a0fNUICpN8Yyq2ORvt47ad0uSXZfekPiklCWJzNgZdY9roCv4GiGfXEkwCXNzB8CAd7/CFMKostG/Wr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmnQYg+m; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cbd00dd21cso13150706d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728662173; x=1729266973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyDOSu6k+pFjB2sY/BoSocqFdUmhvHh2EUN24fV+MKQ=;
        b=KmnQYg+m4AJxBF0G3JJQPy4WGVoVnRenQ69hZQfcBbvb5sRH/x2RQ94+mhsVTGj7SU
         1KRSR93gRhez99bkF/rYZxC+K7t+zYql+wc4zD5B7BWcFkS33aWaUEgLKfCzWGWv0IEl
         fnvtNDG8U4XDEvXY31b0kzOafDspanoUpqOS2rkWfQG/wDHCJh2nNlwVTKB4ypJGRSmR
         auMHJmHDiZUswtIuaAlZ2yL1iTIlHWUrIwBLlQ2t6icg7ptRayXHMu+fM7M32n1RO0zf
         hAVC1JhO14X0efkWmAAeO5QbkASGx9NaVIFQfVeE3Q/Vmm9TCNDyYuyO9KjI3+7ATPFq
         Podw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728662173; x=1729266973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyDOSu6k+pFjB2sY/BoSocqFdUmhvHh2EUN24fV+MKQ=;
        b=DJPDk4CNLgCOtivdez9MUUj+/i/guLRit+pYWXjlpwBd9HUXoE0dExWwud5qtNWGjL
         BPnNZc4zR7ImKbtEli7Ko7CKdh88qbn3MtPZSWVeklbYMofo7pWp6/DY+Ouuo4csO3TY
         8042YYLu2K73McFNRO9Dr/HAuh/muLaYTMuVd6h0mwuqH8cZ4qqXLTQXQRjUVs1XK4k9
         zS4FiA6+5Pzg4S+FKmASnVPeoxAKgRX6AaSbl8tQumMnqCLNMVp4n8JEJKlmkCHjMafZ
         2dPBKuvav6GU8fTw9BcDx08jfCOekyFMorxZotoacjGLIrJC97+LjN0yovomO4TZOJs6
         c6jA==
X-Forwarded-Encrypted: i=1; AJvYcCUAOPOt+zupuUqUKaqtt6x3UORStqxPrUCX+WFOhGtOtCGWKk/nzplQn4dq1Zs+HsofAYdOq9Qnpp20VDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdbakN+4RlNDDy7V2+PS03siKoY/JLAmXaHUbfXipIeveFtCWq
	Ey4Sy0klwy6N9A7cJKNJ9WLCrtBbxWCA+Xxc0NFvRX/qMsclNesN4PCTQ1YHdeWHnO33Cjm00ra
	QhRG5E6TJrZR7ErEQj2wyuK8XnmQ=
X-Google-Smtp-Source: AGHT+IFPConTEKWbPY2PEn82yByECOm2rh2w2jvpgsowhvmXet489QmnAkLlx/4vZ1J4vXNx0p+2G45N0VKcPkRQKe4=
X-Received: by 2002:a05:6214:4388:b0:6cb:3b9b:1673 with SMTP id
 6a1803df08f44-6cbf0105d01mr32723146d6.49.1728662173048; Fri, 11 Oct 2024
 08:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002012042.2753174-1-nphamcs@gmail.com> <20241002012042.2753174-2-nphamcs@gmail.com>
 <87cyk79mes.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87cyk79mes.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 11 Oct 2024 11:56:02 -0400
Message-ID: <CAKEwX=NsBWQkzpwFZHbbtnZ-2AsNjb7_PnUa6aLs76ZksD-=8w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] swap: shmem: remove SWAP_MAP_SHMEM
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com, 
	hughd@google.com, shakeel.butt@linux.dev, ryan.roberts@arm.com, 
	chrisl@kernel.org, david@redhat.com, kasong@tencent.com, willy@infradead.org, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, chengming.zhou@linux.dev, 
	v-songbaohua@oppo.com, linux-mm@kvack.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 2:39=E2=80=AFAM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Nhat Pham <nphamcs@gmail.com> writes:
>
> [snip]
>
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 0cded32414a1..9bb94e618914 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -1381,12 +1381,6 @@ static unsigned char __swap_entry_free_locked(st=
ruct swap_info_struct *si,
> >       if (usage =3D=3D SWAP_HAS_CACHE) {
> >               VM_BUG_ON(!has_cache);
> >               has_cache =3D 0;
> > -     } else if (count =3D=3D SWAP_MAP_SHMEM) {
> > -             /*
> > -              * Or we could insist on shmem.c using a special
> > -              * swap_shmem_free() and free_shmem_swap_and_cache()...
> > -              */
> > -             count =3D 0;
> >       } else if ((count & ~COUNT_CONTINUED) <=3D SWAP_MAP_MAX) {
> >               if (count =3D=3D COUNT_CONTINUED) {
> >                       if (swap_count_continued(si, offset, count))
> > @@ -3626,7 +3620,6 @@ static int __swap_duplicate(swp_entry_t entry, un=
signed char usage, int nr)
> >
> >       offset =3D swp_offset(entry);
> >       VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
> > -     VM_WARN_ON(usage =3D=3D 1 && nr > 1);
> >       ci =3D lock_cluster_or_swap_info(si, offset);
> >
> >       err =3D 0;
> > @@ -3652,6 +3645,13 @@ static int __swap_duplicate(swp_entry_t entry, u=
nsigned char usage, int nr)
> >                               err =3D -EEXIST;
> >               } else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX) {
> >                       err =3D -EINVAL;
> > +             } else {
> > +                     /*
> > +                      * The only swap_duplicate_nr() caller that passe=
s nr > 1 is shmem,
> > +                      * who never re-duplicates any swap entry it owns=
. So this should
> > +                      * not happen.
> > +                      */
> > +                     VM_WARN_ON(nr > 1 && (count & ~COUNT_CONTINUED) =
=3D=3D SWAP_MAP_MAX);
>
> Why not
>
>         VM_WARN_ON_ONCE(nr > 1 && count);
>
> ?
>
> IIUC, count =3D=3D 0 is always true for shmem swap entry allocation.  The=
n
> developers who use __swap_duplicate() with nr > 1 without noticing the
> unsupported feature can get warning during development immediately.
> "(count & ~COUNT_CONTINUED) =3D=3D SWAP_MAP_MAX" is hard to be triggered
> during common swap test.

Yeah honestly, I agree with this. Let's not try to be smart and make
provision for things that can't happen (and make it harder to catch
issues in the future).

Thanks for the suggestion, Ying. I'll just do this in next version.

>
> >               }
> >
> >               if (err)
> > @@ -3686,27 +3686,28 @@ static int __swap_duplicate(swp_entry_t entry, =
unsigned char usage, int nr)
> >       return err;
> >  }
>
> [snip]
>
> --
> Best Regards,
> Huang, Ying

