Return-Path: <linux-kernel+bounces-448020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBED9F39EB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F361D1880516
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF44206263;
	Mon, 16 Dec 2024 19:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oJUy2ng4"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE8D61FF2
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734377581; cv=none; b=JzdApN29QyuYckSqdXht0EK++7NitzVc3FUPT+9EK/OnZ+dswOA2cp+vb+rHR+D3VqhVHpqUA9d94rutGTVpC/9gNNzQIyVEmMVMSQf+jo0s1/3LCUZxGapNo2POh548N3zhUSYb5kILn6T2HREIiN7/OeDWydRNP9K6H4t5G/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734377581; c=relaxed/simple;
	bh=R3xI/58T/F1D9RFYozRoEtTKUhnDXrvAVWgWkpLHyDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZahZ9L0ynELnlx2zecUb+H3H8RZMtJFGYXsuER/d+oJbKqCVOTXmpzA5g5eTI09N9S26AV1TNJchRmcxy8ZyJKWb2CDvxV0gwtCHgH0w+/CbATWsfIkeckbDjDrY0GtMZp8ekimSnPAa32D2XTvtXW8p7rSDhOn6jM5ps3godRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oJUy2ng4; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-467896541e1so34661cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734377579; x=1734982379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rnp1pQwFAGvWyc7ujr4my+8rn/zofEngb5XuRNk7o1g=;
        b=oJUy2ng41ULVo3RBQFqX5bQe9uVNYeRqfdFOn7Q8BDncQKCEOYXo/GRAsN/bibndw5
         sr1PI5j1Woay+t3+/AoKzz2QPOAdBc9qapajT4M4gtqkQKQrSmSzn7PmzoNkfCMLgJbC
         bhItx6fYpw5+rqfbcIMX37AITs6gSpUbMZc+pO+Bydppgt/1lwG0pwErGnwvezPkbSK+
         7DhNTsQOq+CHBItIgad9ICUuAd8j3UYI2fCNADt1+cmir3met5rGAW9JaJ5/Zinq1bPG
         Lymrhwtc57dQ8x8ZGYJUrqpdBXAg+T3gslGdFHoLX0KMIzYdOo3f30P0QuHhrVhKRwFb
         fu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734377579; x=1734982379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rnp1pQwFAGvWyc7ujr4my+8rn/zofEngb5XuRNk7o1g=;
        b=SV1+sK/lO8B2jHwBsDIesS5qaHa/vXoP50BTMR4G00lldrffmF1z2MbaKA+cYwYpoY
         YORv3E+zOrSNEj6pMxkasWbMiaf07gbpa/oodjWEPvUuxdDCJ91JCW2ptlOMMn+5IpDY
         y/bUIREkiBNHoHPTiZ62EXK5UILc1ICrBXKj0OZRDj05QHGFC5lQO4lqEeRXH/ZMHNJ4
         oJ4RPW9mw0Ypss2bYt/T+NDV+LwBFlQfY7aNZvnDdl4g622oetOCk1IxyUOAmO6oZ6yQ
         VksqDxpanVlQBKtHA0mBT7s4iAeLu4nd65qjifm5UW1SJZVx9ba4U5tODL0r56GzrIJa
         KZdg==
X-Forwarded-Encrypted: i=1; AJvYcCXyBRAvGfse/Vsmedp9fSK+IilAH6S8uxfrIUZAd6ZZPb6/CU9eJmguWoYk86diwtgJurxAVGBrRIMr0RY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylnXHwSc9B+v6TEKL8q9YwApdgCkBIFBHmz1HJ6l1NU0q3cjxh
	e3L3RHqGa5njJd4W+OKGNC1b3hvA6QvQtUsFiGXlNZJp2vsFYjcAjJkbw+9A++3NroTuZ2DEKJc
	hIEly/J9CQl18AX/GLeABY5e2XRof0aogGjk2
X-Gm-Gg: ASbGncuVmd562kgl1kS8nf/XU6MccNrokyPl+0LzXrqWcKa/i37W7dGy6ghymIbaeAN
	IkyjcvLJRlZCV1EZJR4OCoSkrjMSGwgS3KipwZA==
X-Google-Smtp-Source: AGHT+IHj+HQHj2A2e+dxWaLP5rgIuLcnFIc+g+z1NFpaB1H8aqRrAsgQQMl3PJX8x8ome62Yd7ixIHA2lhsVnTFpE8Y=
X-Received: by 2002:a05:622a:4ce:b0:466:8e4d:e981 with SMTP id
 d75a77b69052e-468f9944400mr137521cf.3.1734377578908; Mon, 16 Dec 2024
 11:32:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJuCfpETJZVFYwf+P=6FnY_6n8E7fQsKH6HrOV1Q_q9cFizEKw@mail.gmail.com>
 <20241211082541.GQ21636@noisy.programming.kicks-ass.net> <CAJuCfpEMYhAmOPwjGO+j1t+069MJZxUs1O1co-zJ4+vEeXCtng@mail.gmail.com>
 <CAJuCfpGOOcRAJ46sbPRoCUNuuhi2fnkM97F=CfZ1=_N5ZFUcLw@mail.gmail.com>
 <20241212091659.GU21636@noisy.programming.kicks-ass.net> <CAJuCfpHKFZ2Q1R1Knh-LFLUYcTX6CJuEsqNM5AwxRyDUAzdcVw@mail.gmail.com>
 <CAJuCfpGKEthmc2JkbOcfEJqsM_cBcm0cAvv0VFe-acMi169fcQ@mail.gmail.com>
 <CAJuCfpGJcrCkzOtaZDH98_oQK01+HNxHzzsf7SS95cXVRyXUPg@mail.gmail.com>
 <20241213095729.GC2484@noisy.programming.kicks-ass.net> <CAJuCfpHJn9jLT4zW2vPc4kv-Y3_3BTNXkn7pjFEKLVeFjxL4oQ@mail.gmail.com>
 <20241213183546.GB12338@noisy.programming.kicks-ass.net> <CAJuCfpG5LJeM3OmkUv7MGr6tVVGFJ10j5T1TJMdhq6p6yyCz2Q@mail.gmail.com>
In-Reply-To: <CAJuCfpG5LJeM3OmkUv7MGr6tVVGFJ10j5T1TJMdhq6p6yyCz2Q@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 16 Dec 2024 11:32:47 -0800
Message-ID: <CAJuCfpEN=v57sSAOgjfau0dfhZSfMZ-wEcwp2SHmgcSwrYyNtw@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: replace rw_semaphore with atomic_t in vma_lock
To: Peter Zijlstra <peterz@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, minchan@google.com, 
	jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com, 
	pasha.tatashin@soleen.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 10:37=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Fri, Dec 13, 2024 at 10:35=E2=80=AFAM Peter Zijlstra <peterz@infradead=
.org> wrote:
> >
> > On Fri, Dec 13, 2024 at 09:45:33AM -0800, Suren Baghdasaryan wrote:
> > > On Fri, Dec 13, 2024 at 1:57=E2=80=AFAM Peter Zijlstra <peterz@infrad=
ead.org> wrote:
> > > >
> > > > On Thu, Dec 12, 2024 at 08:48:52PM -0800, Suren Baghdasaryan wrote:
> > > >
> > > > > I'm not sure if this is the best way to deal with this circular
> > > > > dependency. Any other ideas?
> > > >
> > > > Move the waiting into an out-of-line slow-path?
> > > >
> > > >   if (atomic_read(&vma->refcnt) !=3D 2)
> > > >     __vma_write_start_wait(mm, vma);
> > >
> > > The problem is not a function but the addition of struct rcuwait into
> >
> > Durr, in my brain that was a struct task_struct pointer, totally forgot
> > we had a type there. Yeah, as Willy says, move it to compiler_types.h o=
r
> > somesuch.
>
> Got it. Thank you both!

I posted the implementation of the mechanism we discussed here at:
https://lore.kernel.org/all/20241216192419.2970941-11-surenb@google.com/
It ended up becoming a large patchset but most patches are very small
logical units.
Feedback is greatly appreciated!

