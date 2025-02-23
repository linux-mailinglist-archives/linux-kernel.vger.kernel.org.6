Return-Path: <linux-kernel+bounces-527572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3F5A40CB5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 05:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FFAA188B16C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 04:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7DA1C84C8;
	Sun, 23 Feb 2025 04:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TSodocoZ"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C7D376F1
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 04:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740285874; cv=none; b=Zn1AQLXW6JNBpSr4Of0lflIciIkaB+LRf80mQWkxIKFYDcWPCnr/qy2fPa6Z+peTKFstgBPGC89dDVsdTJgY5T/GgAt4FJGsO1kvS/Ei1zxP+JKBJepiF0AAEc3wbjT9SpoHRYggd701quSluVyacwWTDfKf/Oxo5QCV0CPYhMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740285874; c=relaxed/simple;
	bh=/qwbvaYkyJw5YF01fMDSuEqzTdDeyNg91pSNk7wuNiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=We4Yw3MaHJY7GJoBvGiWC9Y4Tt4FepFhIoblk4n7sPdUSV27QxY4uynQRrlzHNUIlvsxi+G83TBxaw7Xl7DGkyPLjqMLykWC1w7MBR9U8DONkTOzvJkwCGXnUwj2Z8WPTWERxsKQV0AWrWNVCl4rD1beF+8mwM+t7LXozHfhe5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TSodocoZ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-471f1dd5b80so167161cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 20:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740285871; x=1740890671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcGUFpbUyOauzWV1lBBOTXy0eRR4JvnEyo1klZZ4Yko=;
        b=TSodocoZL9n9hVRa8hAM4Td1os2cq9lySQ8NhJW85a+82Qq2QKa8UqVafbC4/EI5Rb
         8JQcxIIFpp3xUV9zuUle42FT6DWlFDqJchfVdAFZvFrj49qmy+wukEx8O31NjvQbQMtv
         FjiFwlpEuhKOfgUbqJrj38iUtPBRmmjJUtCBkWNtzB3b8t4FWjEprTQJcng8WP68sAsn
         BcreLgpBDEpErlzc+Lap+NcrYwzOlWObdJDGLLbXcbVN3LIGqLcVdPgYclWUsuhnq+b2
         sl9Swk7THjxqalm5dnVNPIkCMQ21ChOEfqfWS8Fj7z+IujmsAeXs+l3avu3uvlAN1l/b
         F+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740285871; x=1740890671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcGUFpbUyOauzWV1lBBOTXy0eRR4JvnEyo1klZZ4Yko=;
        b=iyALCgzKb2l2YNJLPn9RWOebrKaHZDaJ0qH0EN9Atroy0zvX/NhiKePkSnL+7HfnHS
         /Wgn3lNgExYYCyPq5XqfGNzkdH5yYoLpBYzNiiGDhlyfWMOi14T0NauWFRnJ8+uzoygF
         E+LCIsB8W6sGVh77JROXLA1t/KCb1xTvX3A7fK2/OfF1m/c3y5EQWohn5DkmwcX9cFZV
         9umgcuVi+Ae21ha3evKyCkuHXjH6qTNOtQEoUjM1vmZLRhEgkz8jHTgexuW4PWDTm7q6
         ZH/lerVQL0HOzI9S7FBJWm42/xELfC5w1mg/ARycoHdN3kfnYm9t55aN4+xHYES+D4AE
         CRYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtLRunp+n9DzQZ6cD3x1xo3mlJX18rL2EBWatK1EreCRH+Dk/0HXtDLOwxt3fB7t9xsUJzsj5SqMxEeyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1FxEC9ZdzoOxnGFaT0Goc1LxlRjgtlOe/YDjVFGIzj37Efi5t
	8MYDAK8MjK3dXcMRQU/A6FGFCtzBETU2l1WKks2/CAd6WHB403k/RlRuNprxy+3Uunja4DZ6cVr
	Al0b+9JIgrUrxZ5unsh8eKPib1weBkZ7E1D4O
X-Gm-Gg: ASbGncscLxKwcIwE3u3gLurWjANaLuQOsx8oDCP2Og9HaGxNpSAy2yCsnpowlOHWmeS
	UOtWjI2r3I7k2ykxzEGhgeW6DkD/Ogr3E/gYdnXcg5MQf+mvQ4hXutz/AfXKMbUEvdfUnBgy4R3
	7fqyfpVv4=
X-Google-Smtp-Source: AGHT+IGb46tw+pVZwQoU1jpISG40+sgx+NO0UEx1OrIl6UCn0VBop6mZKH/321hTah7c9P/9I7sBTdiVFXoipsZ/N+o=
X-Received: by 2002:ac8:44d2:0:b0:471:f8af:3231 with SMTP id
 d75a77b69052e-47234ccbf1dmr2354891cf.19.1740285871140; Sat, 22 Feb 2025
 20:44:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz> <ztssad52ikws3a2dwodju4o73h6rsutxnvzj5i6vyjjkudkiel@g7c7g5i3l7jd>
In-Reply-To: <ztssad52ikws3a2dwodju4o73h6rsutxnvzj5i6vyjjkudkiel@g7c7g5i3l7jd>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 22 Feb 2025 20:44:20 -0800
X-Gm-Features: AWEUYZlMNaCB-YHC0BCj5Vx7RBKFda56BzAx84KjKhycsml2Uuiq9n6JJUULhdc
Message-ID: <CAJuCfpHi4Od4K2xQEUFWuG=a4zCKecWBMwBiy_7mVn6QgsTSvA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 00/10] SLUB percpu sheaves
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 4:19=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Fri, Feb 14, 2025 at 05:27:36PM +0100, Vlastimil Babka wrote:
> > - Cheaper fast paths. For allocations, instead of local double cmpxchg,
> >   after Patch 5 it's preempt_disable() and no atomic operations. Same f=
or
> >   freeing, which is normally a local double cmpxchg only for a short
> >   term allocations (so the same slab is still active on the same cpu wh=
en
> >   freeing the object) and a more costly locked double cmpxchg otherwise=
.
> >   The downside is the lack of NUMA locality guarantees for the allocate=
d
> >   objects.
>
> Is that really cheaper than a local non locked double cmpxchg?

Don't know about this particular part but testing sheaves with maple
node cache and stress testing mmap/munmap syscalls shows performance
benefits as long as there is some delay to let kfree_rcu() do its job.
I'm still gathering results and will most likely post them tomorrow.

>
> Especially if you now have to use pushf/popf...
>
> > - kfree_rcu() batching and recycling. kfree_rcu() will put objects to a
> >   separate percpu sheaf and only submit the whole sheaf to call_rcu()
> >   when full. After the grace period, the sheaf can be used for
> >   allocations, which is more efficient than freeing and reallocating
> >   individual slab objects (even with the batching done by kfree_rcu()
> >   implementation itself). In case only some cpus are allowed to handle =
rcu
> >   callbacks, the sheaf can still be made available to other cpus on the
> >   same node via the shared barn. The maple_node cache uses kfree_rcu() =
and
> >   thus can benefit from this.
>
> Have you looked at fs/bcachefs/rcu_pending.c?

