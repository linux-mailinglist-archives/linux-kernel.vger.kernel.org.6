Return-Path: <linux-kernel+bounces-293154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EC3957B63
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 04:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ADA8284A04
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 02:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2222421D;
	Tue, 20 Aug 2024 02:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hBic+XC2"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A2322EF2
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724120532; cv=none; b=rTxN39IM2IPDr+x8rH6PVjpxJPcd+F/d2i79V/qy/uyyB/jS/NjeEChznSRUWxEEpcXKDduUgFdxSW4T2on0Y44FqmF7tshmvynDes4KKs3DjTtwZkGG0Rg0/ypnzjt0IjggbjpO+npW/85b8SBD9a27G9WcVFrSF8N97w61MKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724120532; c=relaxed/simple;
	bh=TSnk6AtWa28c59UrW4je/4+rOjKmL6E2erc9O4TAePU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfuBTB3UNDsTZ8Zph3V/WhdQlQjQIgA/6NigCJnISUsQ8M5x9+d9hg84m3aIkAQZfbWO9DkhHI/BDKSBHhDE3KMHHZkioi9lVMZ3eRES+J8sivm5ArBwvzkZUIY+/EED0xeurq3kywO1GXlbQPxUdJjKvN8oZ04rvcPgolRm+Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hBic+XC2; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6b8d96aa4c3so17369157b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 19:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724120530; x=1724725330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9Q7vC9LFMPCk3qVQ7Qc1QgEANirFuPSlZqqwwUbx7g=;
        b=hBic+XC2Wu+Cb5FH8rh8OsKSeoWLOq7qjnFXvGU/5glX/Lz8UFhIvPFrlGvSDxO9eh
         JBVdcaY6pfkRY8pqAmWCzO00lIQuVlawwXs7RtyLzXrwozyCcMv5IWReVMxRk0wdOs5Q
         dD7xDUTBTOGNeymnKjzBlexmCOx1CBcfT78PfLQ8DqMjk9SYa/Gb5prWFFqduFrWHFYI
         xk6YduqHUaWnPhFexLFTGus1ZBSc6OfQNEJzmxGSlC+iX19PdHzriM8fEiONm2tZQ3hZ
         /ErRORNoSXSy8+RvneXWmnER5jq35LpiUSsouirkCrrBuYAdi5F91C9hnjDyMOrGYeGA
         QDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724120530; x=1724725330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9Q7vC9LFMPCk3qVQ7Qc1QgEANirFuPSlZqqwwUbx7g=;
        b=pWAIryNk58QAdvoCMDiJ1S2WyYxMA9YS/VdZ+9pgfKUz3ky72NqDS5HIVwR0kL5L78
         Ys9Y3NDChEIvDMi6lWTBf8oVsxZul4ZgW5brsLZf7MWw4NGGscvn6lbGjIWlxxcVEmxa
         MOwiJs1PofCSlx3+pZ2Do0aBqitG35jE7oTeWkiZ796ONaoZTT1of2zwXEz/YAsWjBHK
         imwRAh4m1leTeItd9vZoNMk/UP5LUYu46Bso+QX7zV5FIh25vnt/Q4LwQAYtXnqrxDrt
         ZADPP3mOQCkjmA8SyZfnEJ+oF8HfczbrnYCLNjPMntKBb/llcRujZ++Tg7wCNZRqyOI8
         vSHg==
X-Forwarded-Encrypted: i=1; AJvYcCW+t1hkxce0WBA52kYqO6GwcuDKSVde/lzvdBqjGsosnS/KtXfuZlzTm1sMaocKsmPdT8L9aM4TuUuhbz76Zo+2/D46/tKgjMboyaMd
X-Gm-Message-State: AOJu0YzF0670hmqTj6+6ZE2ZBUuuvS+oWAhBgye/smLtaeR2iLgSYUN/
	8hNlAEGgUL4pUDvsmHpK5Y28u8x0jS79ZcsrIEcGdvLz40VwVbDAwWKmeJTpgck+6QYvtx7Za+r
	P3YtNPo/ibnHqPDEmmTD5YjaKr1aXcOotr7so
X-Google-Smtp-Source: AGHT+IGqv2dvKxmgA37AXYwXcqcy+VUarFEug/q6Qajf1/shsAVDJ2FVpYt5LV0ZKu34PjuRvF0l1baRqWG8DdWGDA4=
X-Received: by 2002:a05:690c:f94:b0:63b:d711:e722 with SMTP id
 00721157ae682-6b1b9b5ac7cmr168081857b3.1.1724120529883; Mon, 19 Aug 2024
 19:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819151512.2363698-1-surenb@google.com> <20240819151512.2363698-6-surenb@google.com>
 <ZsOeVSlToyhsyDGD@casper.infradead.org> <CAJuCfpH4yFw6RNKVDK0hqXQQhAhMsyGNp5A50E+c2PZd+_vOgw@mail.gmail.com>
 <ZsOtwhWC_JpgWe_J@casper.infradead.org> <20240819184649.8fc7da59f89290f716ae0553@linux-foundation.org>
In-Reply-To: <20240819184649.8fc7da59f89290f716ae0553@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 19 Aug 2024 19:21:57 -0700
Message-ID: <CAJuCfpHa_wfcbatEksuEZqWjTxvM0fc_SAdoBf74QYFipA+s7A@mail.gmail.com>
Subject: Re: [PATCH 5/5] alloc_tag: config to store page allocation tag refs
 in page flags
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, kent.overstreet@linux.dev, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, 
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	dave@stgolabs.net, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com, 
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 6:46=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 19 Aug 2024 21:40:34 +0100 Matthew Wilcox <willy@infradead.org> w=
rote:
>
> > On Mon, Aug 19, 2024 at 01:39:16PM -0700, Suren Baghdasaryan wrote:
> > > On Mon, Aug 19, 2024 at 12:34=E2=80=AFPM Matthew Wilcox <willy@infrad=
ead.org> wrote:
> > > > So if ALLOC_TAG_REF_WIDTH is big enough, it's going to force last_c=
pupid
> > > > into struct page.
> > >
> > > Thanks for taking a look!
> > > Yes, but how is this field different from say KASAN_TAG_WIDTH which
> > > can also force last_cpupid out of page flags?
> >
> > Because KASAN isn't for production use?
> >
> > > >  That will misalign struct page and disable HVO -- with no warning!
> > >
> > > mminit_verify_pageflags_layout already has a mminit_dprintk() to
> > > indicate this condition. Is that not enough?
> >
> > Fair.
>
> Is a BUILD_BUG_ON() feasible here?

We could, but I didn't think we should prevent people from having such
a configuration if that's what they need...

