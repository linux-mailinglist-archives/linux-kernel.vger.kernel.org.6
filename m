Return-Path: <linux-kernel+bounces-445294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 498F79F143B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639BA188D3AE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D22186616;
	Fri, 13 Dec 2024 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3vApYyk/"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC3E157E9F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734111946; cv=none; b=ChF7po7+lo8eU3zvr5ddpgBuTHwhOt2BTijoz5CYzaML3ISYArf91OXMpVIuF1OvO5CfLP3R13q/wvw3oreLuc3C1Kp6FYcOIWUoKzAFsUJ9wIrpOcIKYYduTSqL22E+0fM3GTzs6om9vwEuwjFaeUeIgDuQ/hx+gBh5Dj0Jvk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734111946; c=relaxed/simple;
	bh=nXtDsY4sKwQC3Vhhz/YJXna0EVB/Q0vsfeA6qbjdHg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ii5ilAVWwF6KhG7Ew781FMkPzDS54K6dbE3TLPxhmgQt9mgvfryvTitb7AhQkHTtYJYxgYPXy+P9/MNMN44YqzFw2WqhQwCwdYQ5aQ965iJYLn/pSGj/R9pF0k+ODF3/sJ8N1ezBZATtJQYMkATPUW7Dtw6zLAep1w84kg+wU5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3vApYyk/; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4678c9310afso711cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734111944; x=1734716744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlVKHYsrjLmvj5laSk3FKQQhA8RJ98WLsv9xIi7uKWE=;
        b=3vApYyk/VNFUm9l58E5M8E6WrBVnCc8TsH4748IxxxbcF//k2hkm4+rJK9ecZXOmPa
         s2KY1oDwOSWDyStRidN4peJYqb1dZrcpe77a2v9wrBxXkICshUa1F9+UYOSP8NevNOty
         2gXruFM4fbpxvt0xvrS55kKIrY8H2lR7k072vq8AaD03fY3WzrSGV1T4827KCKT4UsIz
         9QdreF+yd8wkQVGtGoUr9Q4cl1Ba6sMw60dY2h/izqf2PPHhcsfhx9iy2xdihhHSCznf
         zw/3yZcy0Y/k+uTwyZ1e2JkugatyL8G6VVNYRmIWRl06U7Dko1um9iVPLbnedKNCSNvZ
         cozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734111944; x=1734716744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlVKHYsrjLmvj5laSk3FKQQhA8RJ98WLsv9xIi7uKWE=;
        b=n7JP7wfZZk29XOkOKuCoZBl1sCdcLxM0oxY9VAnLxQHZVEFvn63+1bfxilzjpIEggt
         Hky9T1Nl84nfSSDSn6QZtdfKD2atohlMsLlX2QNVffJyg96TE53bzwGXDtFtfcjgqXVo
         yYT6h9TkvNYN6Ys1/RS6rnoKLYaZvxUSi5KNhN3IQRE0ivacYnO/PxOK+pc8Sn/yAjC2
         JS7WcvNjmB1uTTWEF7h0U9aYmR5bmJNBGPXHhjbgWgXyMiBntJp2oBGnnnXZcCpHxMsg
         IuSdVT7X+VV8Xo+2rY3See2018BAhAOqatJ/iPfwj4qqnrb1ImY+G9m3sDRB0fx02x2W
         c2Bw==
X-Forwarded-Encrypted: i=1; AJvYcCW24xfXiLwdVGQ2q5Oo8wrqn2gMdj4vuYzyeGMxel5b6vNxxRGJ0+WX0ltaS35N55VYkD6dMbc3hHsLn0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/1zjDvo/CvYQFuc61OfF6TP8rzjtRg79H6CGm2rlb8bDGlUEG
	gPUV5lRrJh4y0Pt1acnzQ87aTIUOteYvUPnAmp0L8xGx6USE5q6b0wsgAMk/3lT6Oj0PyCYGKzT
	uKZPWcu2Zp6Kozaf74cRkrccYr8ZHwLziX0Cs
X-Gm-Gg: ASbGncvdTVvrVcvsEyXLpneBZqnp828yPIoMpzY5hQ+vLLHUndcx4029/rZrt4+gSwJ
	an3d5pkFJWP1SkQ7hL3siLV3QONEL6KQp7HM8vQ==
X-Google-Smtp-Source: AGHT+IGplKxIBGZDhO3HALFCCrn/tSzaesddHD11PZyBQJ1Q/vgoLq/oS7ohQIcKhbW+fc2DmazVW8pCuKCd/dnml4A=
X-Received: by 2002:a05:622a:4207:b0:462:b2f5:b24c with SMTP id
 d75a77b69052e-467a59d66f3mr3648901cf.29.1734111944106; Fri, 13 Dec 2024
 09:45:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJuCfpHpGSpix8+mB76Virb+HAMrOqB3wG8E4EXPrRCnBoBGeA@mail.gmail.com>
 <20241210223850.GA2484@noisy.programming.kicks-ass.net> <CAJuCfpETJZVFYwf+P=6FnY_6n8E7fQsKH6HrOV1Q_q9cFizEKw@mail.gmail.com>
 <20241211082541.GQ21636@noisy.programming.kicks-ass.net> <CAJuCfpEMYhAmOPwjGO+j1t+069MJZxUs1O1co-zJ4+vEeXCtng@mail.gmail.com>
 <CAJuCfpGOOcRAJ46sbPRoCUNuuhi2fnkM97F=CfZ1=_N5ZFUcLw@mail.gmail.com>
 <20241212091659.GU21636@noisy.programming.kicks-ass.net> <CAJuCfpHKFZ2Q1R1Knh-LFLUYcTX6CJuEsqNM5AwxRyDUAzdcVw@mail.gmail.com>
 <CAJuCfpGKEthmc2JkbOcfEJqsM_cBcm0cAvv0VFe-acMi169fcQ@mail.gmail.com>
 <CAJuCfpGJcrCkzOtaZDH98_oQK01+HNxHzzsf7SS95cXVRyXUPg@mail.gmail.com> <20241213095729.GC2484@noisy.programming.kicks-ass.net>
In-Reply-To: <20241213095729.GC2484@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 13 Dec 2024 09:45:33 -0800
Message-ID: <CAJuCfpHJn9jLT4zW2vPc4kv-Y3_3BTNXkn7pjFEKLVeFjxL4oQ@mail.gmail.com>
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

On Fri, Dec 13, 2024 at 1:57=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Dec 12, 2024 at 08:48:52PM -0800, Suren Baghdasaryan wrote:
>
> > I'm not sure if this is the best way to deal with this circular
> > dependency. Any other ideas?
>
> Move the waiting into an out-of-line slow-path?
>
>   if (atomic_read(&vma->refcnt) !=3D 2)
>     __vma_write_start_wait(mm, vma);

The problem is not a function but the addition of struct rcuwait into
struct mm_struct. The type should be known and I don't want to add it
via a pointer to avoid extra dereferences. After thinking it over, I
think the simplest way would be to move the definition of struct
rcuwait into a separate header and include that header in mm_types.h.
That, with some uninlining like you suggested, should do the trick.

>
> or somesuch..

