Return-Path: <linux-kernel+bounces-448150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8039F3C42
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70EA188E39A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F571D9A51;
	Mon, 16 Dec 2024 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ITZ+ynrO"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1831D45EF
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 20:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734382417; cv=none; b=Li98vnoDCnPzXWoWnGdteTbj4UJjtthQNYrMzodZqT4lP8OE9CJ9mC7f8wpgHLop5QgKzQs4zhtO3c/n4mAVX8ygzUBkuoYH6oTPKt06eV/LlyyJFJIc/BujbpTs755yXmaSpGKpo/Zs8L2w+jf/6Ev//kLtI+4TCaeAESwQEXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734382417; c=relaxed/simple;
	bh=6EfB6x7eCo3wA6NagtQZ68bboMnD4vJq5kYDbE41ElY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OI6h/yinug3ICd9YbcsdMs4KhZb096LN3b9ALNSS2gzfi3MKEBkiPEjjeahxCezGcPBr5XDcXCFR3+rxWFPvXLedO9gIpLc/tAnFL77mJ4MtbKHUIZdbUP+U/7tpuIbKEo9GKXzY5xIhZffMxq6DVicbb8usikaocfWLF40KFjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ITZ+ynrO; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4679b5c66d0so5551cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734382414; x=1734987214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C652rZDSvgkZ0k1BwpYHR8VjpUkn9It4q/dyT6wjU8g=;
        b=ITZ+ynrO6ZS0orHyhpHnUugyCvuuO1tmyHgiGpTvQHWf0y1++Nn68XU4uE3SSJlYDH
         8O3j6/KRdVE8RxdYh8/Thuto0+34MoS2j1Pn5jRaOZqR+wSUdz1X1ZO1I7Ugby7mguzp
         iBmu3mlB8v3SlL9jy9Vg8RiN38n6lJOOWR288JK9zwMfyeQLLKieh/WkBeDy+Dvevl9s
         GbVdZ7cZwJXMhg3akLhrfME4Og6Lv1j/iItuH/lxibXSHMo82FnuFdQM/71MPZllwNVl
         vtXg+Pog8NResws7Sdx8IDgK5fGMyi3Wtid+H2fe378TZhk1PkURgj25+8PU0a6RoZaM
         eAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734382414; x=1734987214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C652rZDSvgkZ0k1BwpYHR8VjpUkn9It4q/dyT6wjU8g=;
        b=kFJSMPM34hBwWYMsEPFu3TwO3hfepUAQ87YgF1gdkM/Dl0RhHOlBI6yRUe/DA+gLWA
         sNvPsnh/HzIus5nZnNQvxfIEUCQ7QO18QpX7EzSPXSNdFUqw9Y5rPsLmkJN+5ujNd5Lj
         qIbFp+9BmZSEfpHCnrsiwGKEgyFVin2SM1YaNcDzxkYC5te2+gBaz2VaZVwOcGJugrTX
         hjxhEIM3cL680H1Zz3+VqaepgwgzM+cLcp+/JGCYOYm7CbFwlWMrdKdHOfpCCmVIbXhv
         1hR8dotANgq2xGz0JNGmZYHcW0aKyYVuqOP51UC3uwLCmQyV1kADqSEMIy/nU8P7RwL2
         sJjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbsinjbo3t8gTMue7EmXomzIirLQV04Q5INNYdaUIJihWRoxDHZroXFmJUC6F2BatLq0pg3XgxY8D6nog=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHlQ5Z9MOpIP4gSlwdNJNuebPi47GeEFOoqjKAlZ+oKOrbamSX
	qiuRBwB13lFtWiz0AmGnsRsX4YkMlxQUxWnVr4FZDowd4r76PuTg8DGaBW0JK81iJkHCl+LWt7d
	O/S/tZ+PMKTBFCStJxF0hRtq3wLruXVmFn540
X-Gm-Gg: ASbGnctnsqryA1DvcXJ21phdI+EDgVchRNurfTQ7eypfZlU9WILXeyJIE2wwS9vA7SS
	aEnv5qJFXqOkw1DMw2pI+qJUVn1SOE8QUBRAl/Q==
X-Google-Smtp-Source: AGHT+IECtw4GIes14vwWEzxFvxaCuKJ/1TZUV17FkJlSyJ8bJOD4eX1mf6k4P4SIvfNKoqIwfABSkPrJxR4wiemjLNQ=
X-Received: by 2002:a05:622a:1a27:b0:463:6f7b:250d with SMTP id
 d75a77b69052e-468f979beb6mr545991cf.24.1734382414158; Mon, 16 Dec 2024
 12:53:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216192419.2970941-1-surenb@google.com> <20241216192419.2970941-11-surenb@google.com>
 <20241216204223.GA9803@noisy.programming.kicks-ass.net>
In-Reply-To: <20241216204223.GA9803@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 16 Dec 2024 12:53:23 -0800
Message-ID: <CAJuCfpFeKd8T-HXx+iD3DDPe_k_vMZgDvxeVRiuHDGwwgUTfdA@mail.gmail.com>
Subject: Re: [PATCH v6 10/16] mm: replace vm_lock and detached flag with a
 reference count
To: Peter Zijlstra <peterz@infradead.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	lokeshgidra@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	klarasmodin@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 12:42=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Mon, Dec 16, 2024 at 11:24:13AM -0800, Suren Baghdasaryan wrote:
> > @@ -734,10 +761,12 @@ static inline bool vma_start_read(struct vm_area_=
struct *vma)
> >        * after it has been unlocked.
> >        * This pairs with RELEASE semantics in vma_end_write_all().
> >        */
> > +     if (oldcnt & VMA_STATE_LOCKED ||
> > +         unlikely(vma->vm_lock_seq =3D=3D raw_read_seqcount(&vma->vm_m=
m->mm_lock_seq))) {
>
> You likely want that unlikely to cover both conditions :-)

True. VMA_STATE_LOCKED is set only while the writer is updating the
vm_lock_seq and that's a narrow window. I'll make that change in the
next revision. Thanks!

>
> > +             vma_refcount_put(vma);
> >               return false;
> >       }
> > +
> >       return true;
> >  }

