Return-Path: <linux-kernel+bounces-355733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981FB99562B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED897B272CC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87296210C35;
	Tue,  8 Oct 2024 18:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XiHV6nhW"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70509139587
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728410835; cv=none; b=f/tvZ1oKBM6NPBkUBRAY9KpGwhBrsU8KVzq9To+mApdUTMYGS/SYX0R7NWlFACXfraE8adK2fqqAqONJtObG3sZ/Si2VCWUmufs3SjerMwR4/U4HzK8Q2GBwIYQxVsvS0/5TxONTxj9RMoAYbddG8I1PifmYjCa02VUz0dXgbXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728410835; c=relaxed/simple;
	bh=viBmhD7gGvLGQ7Oo9pTHKKgJri2maYs3RTGP4qOy4BY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pu47yssS2LzRBy5qBccs8OAt/pooehSducSpgbM5phf03MWuqKp1WOjaDll/86lQW9L8XFE57IIIaKyLJ18gd5IoeaICBGgqa7rlEnW8i+ZIPoOEK1nAyuWAQ6DmHTUYbH3psq9o5a1deBpgKrFx3Oh5IGkYtEhehCsyO4ph74M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XiHV6nhW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cae4ead5bso28635e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 11:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728410832; x=1729015632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viBmhD7gGvLGQ7Oo9pTHKKgJri2maYs3RTGP4qOy4BY=;
        b=XiHV6nhWgqHRsiexNI5CEFBe+5M4vD47pLBMBp1mJdd3uycKM3VmM8/zta/oh2FJfa
         +ozeVnK760gnBNlAHF4U3d/ImgAfDpCt/OvvJKxnJFiqRHMr9sXlIZN7mGcep/QL7Muq
         jbHKPJnkGzr/zGDU4oA/ZdAfjQ84TZQi/GpslAzgEBwyzcHlJCcsQM6zUyLrPivQV1S/
         hCylwHJhwzELhVS1K6T5SFSIs8TeUWNGhe6D5lsuLNmd16/y1xVL9rmqVGec+YFKFrG9
         uspPxMZRLBuHlztohvq9OeIxOopNU8aZzUf3AZBPuY1tZILwoRSpLCeN/O+Slx+eTpvl
         wGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728410832; x=1729015632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=viBmhD7gGvLGQ7Oo9pTHKKgJri2maYs3RTGP4qOy4BY=;
        b=Y8Dmz5bE1cJC2WnfMN8kaTA0kCLla8C7uhHNrPBFC18xR4wxg0uvWCtupaYdaM1xSa
         JoMtNq4jb2gPLV4CnWci7mePXsgeJJFW/inhi1YSyepYToWhmnY7o0lutfbZxYO1WFXN
         IyBmxmpocPFL9UXnVsNpQ898R45888r7mkON5u4Im7bwnlTWBLBcLhcWi+MfOw1qorIg
         2DWUewRTJ4udr5b8NP6xz5eGfVzvWg4tR3CEkSr0MSFp9zPnFCtOCcSXrPH83Lwz2vJL
         QoYlwGXOW7sFgGdBl4SoPYww0UhS/67C93qS7VnZ5AF60/WTgbm++vbDodG1ZVPAZ2yD
         Jxww==
X-Forwarded-Encrypted: i=1; AJvYcCVzHQccUi3iQckIgZUrUB0QL9NEhIv2HJ+hSxTxSb4Whh49hZQbrQqIU1+hF6d3N71oFKQCYuJFIR6PUfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX1qJ2iOAHSTvkz0qaJM4H2PnA6O3TPmB6ix46KeT/b6B19ten
	Qv0cJArZUy3nyXzqvZjPzHTytHjxqMJB3zxeTtusrkM1AznJFUZumT0DjijB9oDWujtfqSdJ+ne
	TgL1pkBGMfx0bOA1NQp2BsZ/L/wqRXXGd8gJ+
X-Google-Smtp-Source: AGHT+IG0Ua74EgE6K84YQjHt1KQHJmVOAGcNEjhiw2VgdV6Hy6/FCQVVmouz8XlYGgRxh/uOG2ghJ1mnq9tthv5OIXE=
X-Received: by 2002:a05:600c:b8a:b0:42c:b0b0:513a with SMTP id
 5b1f17b1804b1-43058cf488cmr294435e9.2.1728410831395; Tue, 08 Oct 2024
 11:07:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
 <20240830040101.822209-15-Liam.Howlett@oracle.com> <CAG48ez0ZpGzxi=-5O_uGQ0xKXOmbjeQ0LjZsRJ1Qtf2X5eOr1w@mail.gmail.com>
 <wxvj55hptaogh2yxhhfftaomwzm6ifek5xu3uobbdsaabdmjll@t2ixdotfhaie>
 <CAG48ez3Ao_XkT0LKHfZsZSEZaoDAc4zRjitKG=P5O7R2BOgHxw@mail.gmail.com>
 <btu3mxc7qn33vux2jtzewuavth7ziq4xb6nudiu5kf7bs3bejm@e7btayqaavzh>
 <CAG48ez0e4Zv3g2uHGzhrCmJcE2XE=160HxyNy4YAhEfQKKFNBw@mail.gmail.com> <CAJuCfpE2+n_jd233-B_h8jfi+1ia2-KRCrnvSvvUaQehgUOJjg@mail.gmail.com>
In-Reply-To: <CAJuCfpE2+n_jd233-B_h8jfi+1ia2-KRCrnvSvvUaQehgUOJjg@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 8 Oct 2024 20:06:33 +0200
Message-ID: <CAG48ez0afDQ94ZDYvU1-MdYC2n5AO3yZLXW93JkQMtJ7oh0vaA@mail.gmail.com>
Subject: Re: [BUG] page table UAF, Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing
 vma tree in mmap_region()
To: Suren Baghdasaryan <surenb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Linux-MM <linux-mm@kvack.org>, 
	kernel list <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Sidhartha Kumar <sidhartha.kumar@oracle.com>, 
	Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Jeff Xu <jeffxu@chromium.org>, 
	Seth Jenkins <sethjenkins@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 7:52=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
> On Tue, Oct 8, 2024 at 10:16=E2=80=AFAM Jann Horn <jannh@google.com> wrot=
e:
> > Is that code in a tree somewhere?
> >
> > What locking will those RCU walkers use when accessing VMAs? I guess
> > they probably anyway have to take the VMA locks to ensure they see
> > consistent state, though I guess with enough effort you could avoid it
> > (seqlock-style) on some fastpaths when the vma is not concurrently
> > modified and the fastpath doesn't need access to the VMA's file?
>
> Sorry, it's not posted upstream yet but yes, the idea is to walk the
> tree under RCU and detect concurrent changes using seq-counters. A
> prototype was posted here:
> https://lore.kernel.org/all/20240123231014.3801041-3-surenb@google.com/
> but it had some issues I'm yet to resolve.

Ah, thanks for the pointer.

