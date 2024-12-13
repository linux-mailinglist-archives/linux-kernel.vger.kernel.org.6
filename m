Return-Path: <linux-kernel+bounces-445361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F069F150B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76BD27A067E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BFF1E570E;
	Fri, 13 Dec 2024 18:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q1L+UCy6"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD901E25F6
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 18:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115050; cv=none; b=Q7UX026vE2yl1I2+BdKFSXKb+cWVvJk+DKJjbFsdE5oxrpomU6BC8ex/BpVNdt79KSIV7p4BVTpwhb+QYFxQgLKvbkVKrN7sjZ3EBN19m0YtjXxxIt9+EJXJAlEykg2sTkP54M5wNeoRqsjv2zZFUA6qsYOWhO+okcG4ys7m1MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115050; c=relaxed/simple;
	bh=ZamEB+uJILNtV1BSshuimxRqikLrNjtegQRD5N32xMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKABNKQgkLj8qBmxzGyykELtvEgHT3oix2lSBx0gfCotqaSoMuoRBnywBsXtx6O22r6TqzjaA7uHj6emVEYmE+ZPlqiXYTchmmUD+IaTzBBWMy/MY0F3DMToi433rnI2s2AKd7WSnCZhqF851WnkzbTzKgX/LQhN07eKV4dILVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q1L+UCy6; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4678c9310afso17321cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 10:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734115047; x=1734719847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJPdDphMSw61Z/xpiwgyvi+y02X1+U22e8ZJNsqiVWk=;
        b=q1L+UCy6FHolkZ69XeWEHB3923CSQhbVT46G7HVpYB/qLwUCOQcLAy4KHa357x+a5b
         NM2XSsR3b0mlGc/kFEsY6z2gjaZXt2wEAjbAluMt/5vpU73CjX1TZwLopezMgFoYWt8Q
         Mtp1nnCLXf8pOGvgIN7YzCZ2U65u8+KMvUTgbW+zvUDEJBCpmtobJi9Djq42T5cFah5R
         fTFZiosvt0Byk4A/k76WO3qpFbxCquAHuMCkZPb6o9VNbF4V5KZRMiRX+9zL6c+8evI+
         Baq4gsYbwRPXBdCofDoyNpZgwuTY8jejdImsEK4D3VVQB6rUMHnDobJsdeba/1jyeRXi
         YG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734115047; x=1734719847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJPdDphMSw61Z/xpiwgyvi+y02X1+U22e8ZJNsqiVWk=;
        b=R9rTsI4JiJx6lxXPZFLPjZLw5nmaPAX3u+dxT/CLKr6VpS2qAzdBTcpyuSQ0QvmzhB
         tKvwlHay49SDwcWb16nItLd8NfHdxL1u4cjoEleLRIk6bJOCWvhbFl07MtFpWUTjC9J5
         k5T2WBAgjBbd4M0GcN2iERw0exS+zXZm5yipAb76Z/xx88XFhmACffgDUgtiVS/5MGY9
         IYNz2mVuClxbBK64db1AidZzTyj1o5SZqJlwU35oLKqIBYCq2HQB4dwsrTNq0N/HbaCq
         Zqqlf7BYB6deM1PbHDh0KJ7a7+avRcgGGzHlGJnL04323ZtfCdw4upPU04xeRH0jkSIz
         DLgw==
X-Forwarded-Encrypted: i=1; AJvYcCXwu5kyOwFSA0GlZBZJibP1qUDh688j7A2stIWFhRmpOp2uLwgVEC+jLeTn+hKGGN5SdemFr7frbN7yb/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk0Y3N3iJ5A3SUg9Ncyw6F8ao+PHmWONgiXq7moY1YXdSFd97O
	Fqgxa2uZQc3lS/oqA+4jXl0bAPA5g7t2tLD1tWwiN6OUOMLZ7dHZ1PGAfoffbamQoJqZ23VhEiW
	IWiLaqf+EhPj2Es3P7WQ78iA4qY95jag7gT3m
X-Gm-Gg: ASbGncudk9YmptJO5CHojqAUbx8MrhRLz211Vl7YDAey4M1xF1ygq1sJ12kYN1g2xHa
	LHFqFVB6DvBGLnUXXifpbiS8/svp32teCzIoLI0GvFJjPIZx07jN9v9IkAFG+bpi6TQFo
X-Google-Smtp-Source: AGHT+IHn5vnT98GrAShsoRnmTs9Ha9saW5pY6+qwN95n+4LlUIdrAskMfCnAU8wt5yLRnKZ3h9Bmt5adsoXJtoJ1PrQ=
X-Received: by 2002:ac8:690f:0:b0:466:8e4d:e981 with SMTP id
 d75a77b69052e-467a58952d3mr4069631cf.3.1734115047084; Fri, 13 Dec 2024
 10:37:27 -0800 (PST)
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
 <20241213183546.GB12338@noisy.programming.kicks-ass.net>
In-Reply-To: <20241213183546.GB12338@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 13 Dec 2024 10:37:16 -0800
Message-ID: <CAJuCfpG5LJeM3OmkUv7MGr6tVVGFJ10j5T1TJMdhq6p6yyCz2Q@mail.gmail.com>
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

On Fri, Dec 13, 2024 at 10:35=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Fri, Dec 13, 2024 at 09:45:33AM -0800, Suren Baghdasaryan wrote:
> > On Fri, Dec 13, 2024 at 1:57=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Thu, Dec 12, 2024 at 08:48:52PM -0800, Suren Baghdasaryan wrote:
> > >
> > > > I'm not sure if this is the best way to deal with this circular
> > > > dependency. Any other ideas?
> > >
> > > Move the waiting into an out-of-line slow-path?
> > >
> > >   if (atomic_read(&vma->refcnt) !=3D 2)
> > >     __vma_write_start_wait(mm, vma);
> >
> > The problem is not a function but the addition of struct rcuwait into
>
> Durr, in my brain that was a struct task_struct pointer, totally forgot
> we had a type there. Yeah, as Willy says, move it to compiler_types.h or
> somesuch.

Got it. Thank you both!

