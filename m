Return-Path: <linux-kernel+bounces-265615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED2993F3CE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9EFC1F2272F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADB31448E0;
	Mon, 29 Jul 2024 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUTgvMZ+"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0866121373
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722251988; cv=none; b=BdhtUM7FJUEfq7ILeIn3ubhnJXzkc+bieaW205RMZ/SySDXmvRy9DPp5/NzVFnjEuPEQcm2V7wpZCjkLqbrpgGVbJjr3ed0mElpDWwasmPEQSkzWOHuCtBzaZcljRHleyhPWD3mM3xpIR+BQIJPLpULoUyGb4cDQPfrJFHNjBg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722251988; c=relaxed/simple;
	bh=uMtvkIc7P6yNzwt2IsshDe+fI4Neb4NCc1aNZvxKzr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+uJpPWHyhNeMIl2PVEt08LEYPe1DSzQ686I8sCHnRfYWjgeTj6pCYrLE4emfrbtHYP2bk9+PHVvtKRNWgL15GB++tZ+n4WOEg+UWHb3pBibXEukp9VX+P+unIdZHv63K56Jdg1rb3HhHHzsqOrHJUAikOAb83D35I7FcEZmgmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUTgvMZ+; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso3839835a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 04:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722251985; x=1722856785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZMoS+Oc1qXkku/9gbvh835GC/MRuyc4+0P4p5raWYs=;
        b=nUTgvMZ+tnlxk6VcCq8wi27YC0NCY4O01lrHFIwRaj+xt5Ts24O6JgggRVlfI7K0sz
         /WTYD/nmdSvCJo/CSDNKYJYEy1nIL1xNj5Iz7U7EvDwRaeEE+CEKra2jHr6gu2a7yVfs
         pzTy5VQtHLJfHmQJbg3jqZ+bidiWLkVenvkV6IJJ+EIp6BcPO+9u7lL1ieoYJ2w7k2U7
         5hM2vxQVwNwkooru5U9U4NZvZona8I3YBL5QB6UMtcJ1Ahe/cNO3bkvfhtGvAmrFjjKo
         ORVYqFEvrzo2LM97te+73x8olxS7pRkq4oJvTGNkfyL3pnzK4quPfEPRLX0wUMK5lOzO
         /mdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722251985; x=1722856785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZMoS+Oc1qXkku/9gbvh835GC/MRuyc4+0P4p5raWYs=;
        b=ExFXjMp7c3QZJNiZDqInMkhfSVoFAINHU+KX/WC5c4vJXSUUW5epvbuZxUu4oWl9CQ
         bDcRAd0jolii+MKJgVWMZNab7ZpzkP9+OeFwyLD2E1yoN5oJehQr021leXsOGtVzqsi6
         xuACHXflOawEe0QMFNTQu2HPFJdPp8yy+18QdLVPlRh+94aEnMtfjVPc1FSG/1IysN9m
         pVSomMzvQLGRH4jng0HwaBv7W2d/ue2kpUsXmNop5OP1Lcd8nDXXcbN5XW3hVPSpUmDj
         RoMk66KwqjUXBnXbz337D/WErV8KqrhTR9YNc8j35SlMQwKnuMZmY8cN521fpXLiTPxr
         PbVg==
X-Forwarded-Encrypted: i=1; AJvYcCW0YSq3AbB3bI3pidR3QFVUz3Wz724lCrF6ozhgmFlR+TNdK+acGzQObIs1shTQd9ylP6VIPzoHgwNRhrxZ1evzlHW/bzHUirmYzXUz
X-Gm-Message-State: AOJu0YwOUOa7RxLPKV/+W8JuJhyIX4MZ4FgyhaivJxMUgwQUc2wH9FvV
	2moHOQ7/pCf8ROrLWvFgNHkXHBYQOQqZ1uO5kaqBoDMrr8uTDEQUmS6KQMP/SktaGJafvGZ5Gw5
	S2kbF+Z0XIlJ+0nmoTqjH0pwLmLA=
X-Google-Smtp-Source: AGHT+IGoO8iFDKT9G4T6Pc1KxgZDzBrCkq1L+FqT1pk3obiX/dcC0AHozgxdj7llHURqiCuwqaqb1vRq1qJzx7Gw/tM=
X-Received: by 2002:a50:871b:0:b0:5a1:7570:8902 with SMTP id
 4fb4d7f45d1cf-5b020bc19cdmr4619855a12.18.1722251985028; Mon, 29 Jul 2024
 04:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726165246.31326-1-ahuang12@lenovo.com> <ZqdTK+i9fH/hxB2A@MiWiFi-R3L-srv>
In-Reply-To: <ZqdTK+i9fH/hxB2A@MiWiFi-R3L-srv>
From: Huang Adrian <adrianhuang0701@gmail.com>
Date: Mon, 29 Jul 2024 19:19:33 +0800
Message-ID: <CAHKZfL3YsfSLfNq268p+bikzgwvj+Ng7R09cZQk16aKio3fViw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/vmalloc: Combine all TLB flush operations of KASAN
 shadow virtual address into one operation
To: Baoquan He <bhe@redhat.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Adrian Huang <ahuang12@lenovo.com>, Jiwei Sun <sunjw10@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 4:30=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:
>
> On 07/27/24 at 12:52am, Adrian Huang wrote:
> ......
> > If we combine all TLB flush operations of the KASAN shadow virtual
> > address into one operation in the call path
> > 'purge_vmap_node()->kasan_release_vmalloc()', the running time of
> > drain_vmap_area_work() can be saved greatly. The idea is from the
> > flush_tlb_kernel_range() call in __purge_vmap_area_lazy(). And, the
> > soft lockup won't not be triggered.
>               ~~~~~~~~~~~
>                typo

Oh, my fat-finger. Thanks for pointing it out.

I saw that Andrew already added this patch to his mm branch. Let me
know if I need to send the v2 version to fix this typo. (Depend on
Andew's decision)

-- Adrian

