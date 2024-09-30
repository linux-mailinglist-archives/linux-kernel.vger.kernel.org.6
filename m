Return-Path: <linux-kernel+bounces-343720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622A3989EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 233942812A8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFFB189903;
	Mon, 30 Sep 2024 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzUMfxZC"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6882E170A23
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727689789; cv=none; b=B2bIRz9h/W6TtORsEt6JB/PH99cC3RHKWXi1IhXN4pQQoUzEAziTFeLCCnD2a5AUYJo4DZjUlw0qq1JvvLyQX2VbsYBLGsa1MZuMiX5zfS/wIoJzsbfncPBzApMV4YyfBvYgo/o6OUpMxNo4Sk7/w78sEIbV8K7Pg3pVqhEi29s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727689789; c=relaxed/simple;
	bh=tpuXjx+qImknMtCjvf/H12ctwmtiN772TVHBFF9SfaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMp9+q1Vgaargp5lxJ1QQYgcLh1vs4crfWoHwn9OvrdHDJuOe0dNsdyy0aqpIKZpTPeOb/1Zepdnx1uB82svL9kBYEXqTgCoomM/OtxG8h+wHivHtNW8kfDtVP8FM0bQyFfk0oe3HZ2L+xbG+aP08FaDAe6+hThRs323K9zD9JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzUMfxZC; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d2b24b7a8so954176366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 02:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727689786; x=1728294586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Y8xzZhNdiTm4MfGV2ugvdzV/xOWaN3/MM1HAjacBWE=;
        b=MzUMfxZCOwo/vxp3Q8ZWScfM3wRD/3dBtgb0QLEXveaYi0skiLxI/8KoQXHX6RLwOH
         nxrj7wtq+WtD9eH0VK0jDn+yZqSePGvmdw5I/VCZnvQ7ITNhxgcKoCPHZa0E8Bjc+N3/
         8Ux4EtzCyc47bbyCWBJxhn+v0o7ib5e+6N01cTfB7Cpjv7WX/QRa+/oAuaVoURPEfRVz
         DGLNlg9Wk0xrLO6YYxSTs9O+IxsPonfFkJWDzw1f20vZDBdTf4IwX6el8kkLxkpIk3vT
         UpEr28QaRRvZscL2GlJ/DET4RldaMC4aHo7Y41Tfa2F/43Ft9WpKxKHRwRAL/C9IML/V
         lo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727689786; x=1728294586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Y8xzZhNdiTm4MfGV2ugvdzV/xOWaN3/MM1HAjacBWE=;
        b=n9NMT5GCG7niEoQQrJ6ZMDLhysu4ksT3+07A1Ht2m01IvGNdHDcwoKE/0X3iTPjKfg
         yIsxpzS+c5FsvMEwCeEoZw17x5nwuwmrSVbWbUfzijNjmG1Gh4fXKk4JecTFAe7tEd6p
         Ww8oyEQik8hOv23MYEypcXhdu56yi0Tlz2BvFg+aZzKcTX7fI3qjyQyrXLIPF5dKHT9T
         kXwzahEom0U1YxqUjDq7W6hlpRS5htBjJPbZrnCMMEvoQoLgFvXkTKk/8wCzLPbiXlv9
         wL1KOaGMXnNUtou3e5fO8zslPBsCoqaIRBvO2ayZDSzo3fvFn2sfdCsCeOnlXcIwB8do
         Jd+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlC/NGGzGQDQI5Sb8nwojTvUAfEGeU2foS3IuTSPzTpt3oYL8pVQppavBzkJsyGh3kMHT6RkrnbvWPaOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTV13mBUWVRBI+fzwDxbluUkzXlAWk0dLwWGjrBvFocRIFmMc6
	fK/NrI5X7Mg68dnsql0ttBiHbtOyO90A3lsysZR8a4djGiZOGxEjoN88SD7fDYSZVdEGFrzvMeI
	dq0QFQIYixDjuzVR9IJSTVWlm1rg=
X-Google-Smtp-Source: AGHT+IGrukCaE6n3y/KlOYVIqcP8OuyMBkkIZLziiyGt5z7sqLX4iDXjZoDHipRmikKBdBZ8YrX1uOnpGdjavPiaMsM=
X-Received: by 2002:a17:907:6d25:b0:a91:1699:f8eb with SMTP id
 a640c23a62f3a-a93c320e687mr1288321266b.28.1727689785361; Mon, 30 Sep 2024
 02:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925134732.24431-1-ahuang12@lenovo.com> <20240925134706.2a0c2717a41a338d938581ff@linux-foundation.org>
 <CAHKZfL0D6UXvhuiq_GQgCwdKZAQ7CEkajJPpZJ40_e+ZfvHvcw@mail.gmail.com> <ZvWI9bnTgxrxw0Dk@pc636>
In-Reply-To: <ZvWI9bnTgxrxw0Dk@pc636>
From: Huang Adrian <adrianhuang0701@gmail.com>
Date: Mon, 30 Sep 2024 17:49:33 +0800
Message-ID: <CAHKZfL1jUs1Nh=aqnUrLLMiwb-F15kPc-fqC6i0hRaw0HbtMLw@mail.gmail.com>
Subject: Re: [PATCH 1/1] kasan, vmalloc: avoid lock contention when
 depopulating vmalloc
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Adrian Huang <ahuang12@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Uladzislau,

On Fri, Sep 27, 2024 at 12:16=E2=80=AFAM Uladzislau Rezki <urezki@gmail.com=
> wrote:
>
> Hello, Adrian!
>
> > > >
> > > > From: Adrian Huang <ahuang12@lenovo.com>
> > > > After re-visiting code path about setting the kasan ptep (pte point=
er),
> > > > it's unlikely that a kasan ptep is set and cleared simultaneously b=
y
> > > > different CPUs. So, use ptep_get_and_clear() to get rid of the spin=
lock
> > > > operation.
> > >
> > > "unlikely" isn't particularly comforting.  We'd prefer to never corru=
pt
> > > pte's!
> > >
> > > I'm suspecting we need a more thorough solution here.
> > >
> > > btw, for a lame fix, did you try moving the spin_lock() into
> > > kasan_release_vmalloc(), around the apply_to_existing_page_range()
> > > call?  That would at least reduce locking frequency a lot.  Some
> > > mitigation might be needed to avoid excessive hold times.
> >
> > I did try it before. That didn't help. In this case, each iteration in
> > kasan_release_vmalloc_node() only needs to clear one pte. However,
> > vn->purge_list is the long list under the heavy load: 128 cores (128
> > vmap_nodes) execute kasan_release_vmalloc_node() to clear the correspon=
ding
> > pte(s) while other cores allocate vmalloc space (populate the page tabl=
e
> > of the vmalloc address) and populate vmalloc shadow page table. Lots of
> > cores contend init_mm.page_table_lock.
> >
> > For a lame fix, adding cond_resched() in the loop of
> > kasan_release_vmalloc_node() is an option.
> >
> > Any suggestions and comments about this issue?
> >
> One question. Do you think that running a KASAN kernel and stressing
> the vmalloc allocator is an issue here? It is a debug kernel, which
> implies it is slow. Also, please note, the synthetic stress test is
> not a real workload, it is tighten in a hard loop to stress it as much
> as we can.

Totally agree.

> Can you trigger such splat using a real workload. For example running
> stress-ng --fork XXX or any different workload?

No, the issue could not be reproduced with stress-ng (over-weekend stress).

So, please ignore it. Sorry for the noise.

-- Adrian

