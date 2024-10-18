Return-Path: <linux-kernel+bounces-371850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DDF9A414E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62921F24ED4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F931F4289;
	Fri, 18 Oct 2024 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yvLgzV7t"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87D11EE026
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262219; cv=none; b=TuSiERRqEr2O57LrgSzQDTU80jBE1v0GNy7GEKGzNWQp9wyk89DX3hIdPIREycz1QSKdvAW5xtIO4UF1jtenCUGAX3hsLBFZ+iwrAHkXY+yo6GNCnInYXTEcoLM0SMLkzWwl3XNmca0joSDrzlz6HO47MevaCAZ0/GKeMhINJFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262219; c=relaxed/simple;
	bh=C1jKHDBFy2o9/Z5BQ43Z/TvjolPDG3ZilqUK9yWK1Z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLUI/6opJRcVj57PTfzERAymheZkCI/48NKu5+JorSF7zfJknSkHHEZnqor38VlDOCx6q6jdcAeR5ztCQufGf4dv7uzdzpepRGe+GWhmWRrCOHoVS6uXGf5zi9GR3uYGXdtsHQdzaTaWdu3zl+e5dJ6nVor5CEfKMf0XuWcru1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yvLgzV7t; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e681ba70so19262e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729262215; x=1729867015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvy5eBUxdhPiiEPoS/y6D7WtkY1N7NVonPg2B7x3yac=;
        b=yvLgzV7t0Ms1jKVslJYPE8YTs9Dxyy1IhO41hBbCUjt7QaqUxwawrUzSvlxaZ/0VjE
         WXvxXlH1mYolqWbO/5tCP1XHnvKQFxbjmVsjVA51dh9C8tt3bLjFMvpjS+gLSt8//TOH
         mIYJ1LOi1QvLt+SnV/oIS2kqncwmo2hnKp9CCJr7TARKjuqVqyaWDSGiv+piY2sFcjxE
         5kz1R+7sNtrsBzUzPPte6NmdAvn4Gr3ULEm4N6fWAqRTD4EteYF/JMiwqIF+Si9SzUrg
         uTaJicp41533/V/bAcaG2M+rquYf2zLNA6CyM1VdIl3MD4Gd9zK3lpZRGuvXKtiwd6HU
         Y55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729262215; x=1729867015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvy5eBUxdhPiiEPoS/y6D7WtkY1N7NVonPg2B7x3yac=;
        b=tahvVqGhyiIFx2nFjRYqV0oVmyKKVHfbD//XUjJz/bVA8arPyr6mWMzGxRT+8o0Tpi
         v2FbhXZ0fmt9638h3k+z62TNep76DVPMkktiSUVp0ZH5fJVpaPnK7I2lJbWNDAJTeIKw
         vfP/k6M5myD03cVbJg1H1kYbxzgpKwGOtORJCOKQIlhtnhIrTe6L2z8OboIv8CFf5M32
         IPS3rsHSi36mYBaFWrXV2GCCW88IEOQoSxYY6qZYE+ZMpjVQ1AQpUY7m4aT+qEZ4bZWe
         OGHqhsxhWD3fIrLR2S2O4L7wtjhj7zeYPfqJP3BYyYmqNNxHk8eO36etni6eweBfLPK4
         xhqg==
X-Forwarded-Encrypted: i=1; AJvYcCXxsaZnqciCVZcfE0mjwXQZWxbAKo406WG+xQzMFSjITX38LFFH8NXSF/n7oz5Q4WmQrz3R+ZWYFm97jnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQONvz/jf1yn1/MFUtUKXOvbvbFyPDkbhe0HtEfgpdEfI2PVVj
	xEhTWYvHhILCcZmNVMlcekktzWvUZeJrftKmFHOkkKCOgiOMKYC04slQK3DR7K76KJ9YM5/UlZW
	IsCcJ+o3bg7ylWzTujoj7XvnUD2lql7vkHHc7
X-Google-Smtp-Source: AGHT+IGN5Ch4M92qnmqBGXI6V6wafb7DTaUaatifjKeXf6otrQ2Vdp/CsMIzZ88KZX2C+4NiCmQ78hfdgG1BaBCZKdU=
X-Received: by 2002:a05:6512:4020:b0:530:ae18:810e with SMTP id
 2adb3069b0e04-53a15761373mr323279e87.5.1729262214336; Fri, 18 Oct 2024
 07:36:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com>
 <CAHC9VhSyWNKqustrTjA1uUaZa_jA-KjtzpKdJ4ikSUKoi7iV0Q@mail.gmail.com>
 <CAHC9VhQR2JbB7ni2yX_U8TWE0PcQQkm_pBCuG3nYN7qO15nNjg@mail.gmail.com>
 <7358f12d852964d9209492e337d33b8880234b74.camel@huaweicloud.com>
 <593282dbc9f48673c8f3b8e0f28e100f34141115.camel@huaweicloud.com>
 <15bb94a306d3432de55c0a12f29e7ed2b5fa3ba1.camel@huaweicloud.com>
 <c1e47882720fe45aa9d04d663f5a6fd39a046bcb.camel@huaweicloud.com>
 <b498e3b004bedc460991e167c154cc88d568f587.camel@huaweicloud.com>
 <ggvucjixgiuelt6vjz6oawgyobmzrhifaozqqvupwfso65ia7c@bauvfqtvq6lv> <e89f6b61-a57f-4848-87f1-8e2282bc5aea@lucifer.local>
In-Reply-To: <e89f6b61-a57f-4848-87f1-8e2282bc5aea@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Fri, 18 Oct 2024 16:36:16 +0200
Message-ID: <CAG48ez0m4O5M8m4bLJ++gTZzsAyKgud++cBMBqAm74OLUKBFpg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ima: Remove inode lock
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	Paul Moore <paul@paul-moore.com>, ebpqwerty472123@gmail.com, 
	kirill.shutemov@linux.intel.com, zohar@linux.ibm.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	serge@hallyn.com, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, linux-mm@kvack.org, 
	akpm@linux-foundation.org, vbabka@suse.cz, linux-fsdevel@vger.kernel.org, 
	Liam Howlett <liam.howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 1:00=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Fri, Oct 18, 2024 at 01:49:06PM +0300, Kirill A. Shutemov wrote:
> > On Fri, Oct 18, 2024 at 11:24:06AM +0200, Roberto Sassu wrote:
> > > Probably it is hard, @Kirill would there be any way to safely move
> > > security_mmap_file() out of the mmap_lock lock?
> >
> > What about something like this (untested):
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index dd4b35a25aeb..03473e77d356 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1646,6 +1646,26 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long,=
 start, unsigned long, size,
> >       if (pgoff + (size >> PAGE_SHIFT) < pgoff)
> >               return ret;
> >
> > +     if (mmap_read_lock_killable(mm))
> > +             return -EINTR;
> > +
> > +     vma =3D vma_lookup(mm, start);
> > +
> > +     if (!vma || !(vma->vm_flags & VM_SHARED)) {
> > +             mmap_read_unlock(mm);
> > +             return -EINVAL;
> > +     }
> > +
> > +     file =3D get_file(vma->vm_file);
> > +
> > +     mmap_read_unlock(mm);
> > +
> > +     ret =3D security_mmap_file(vma->vm_file, prot, flags);
>
> Accessing VMA fields without any kind of lock is... very much not advised=
.
>
> I'm guessing you meant to say:
>
>         ret =3D security_mmap_file(file, prot, flags);
>
> Here? :)
>
> I see the original code did this, but obviously was under an mmap lock.
>
> I guess given you check that the file is the same below this.... should b=
e
> fine? Assuming nothing can come in and invalidate the security_mmap_file(=
)
> check in the mean time somehow?
>
> Jann any thoughts?

The overall approach seems reasonable to me - it aligns this path with
the other security_mmap_file() checks, which also don't happen under
the lock.

