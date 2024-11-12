Return-Path: <linux-kernel+bounces-404967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE299C4B26
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4DD1F22CCE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62D81FF7DA;
	Tue, 12 Nov 2024 00:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w1qpe4zn"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84545FEE6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 00:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731372548; cv=none; b=n6YC1dEJ+sb04aOrU553lZ4g8UNYcRvoM864spScujOD8EnjswiGYG2FQrb5Q1Q5/DJfReco1iI7PxfAX+PYkq09R5Effa1bey5ipbqDYTHs4A2JjQ1PYL7pltN9Z55cs7QF7PS0p+gmmoX28gxwPBCuTLNPocc6H+lEHdYV57k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731372548; c=relaxed/simple;
	bh=bqmWhdMi9eC38lqdPLaz6TviiRmlx4PikYWeW8oSpQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FoSARbTanjhLBpG+ERTnNtS6FEb3Svq2qEo/dSGvUca5LNmvA00leM+gb6q5I4A0Gs5jJ5GLkqEo4g0Wu/P8YIsIoXolDQN7DdKC1N/SjU3ycUGbsG8hlQy5wtwpDYMb4Vw35FuyWXU6i1RalERTRx7n6ycf+lCeFo/8TN7JvCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w1qpe4zn; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4608dddaa35so131681cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 16:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731372546; x=1731977346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+A95GzH1Ll4uC+5CzjJhSIIK7JoMR9EZ8hAhfkjbps=;
        b=w1qpe4znitbim4WqasSRichXBB1hCn4hzwHjqo6j/HqbawQ6Ozi+hf9ZuF/DpuZKAG
         JNm2NAU3VU7UHPwl3zpQpC3ZN+EkOuN9ZqIlmTB5tI0KgJrFLoeXpb4e2LFrXWCLLpYU
         xxMLs9eJFdEb5ttvHA6P+nEGAeJ29+FcyAAW2RhCfOg5oG/OngiswpbAtKdxxLuRUw7y
         q2yPPCyYFJcJ9tDwD2TddBWZmj4p8nzBPZ2XSHrXIMsLFdUMtJL3QWEXF5C8JgCUwUee
         8LaBzAlAnX+MOfrfCzvChOCJXqmPGNhPeIXgBLkvtrQHuEKKjto0Aq49AOvajhmTYQ6k
         u1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731372546; x=1731977346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+A95GzH1Ll4uC+5CzjJhSIIK7JoMR9EZ8hAhfkjbps=;
        b=C62ljRf+iyEI2No7swP3bc7yHayeVudRD6ubhEF7Dzz6kP1E7bANwQBePoXP76PoK3
         brnqEggG8u1VcT4R5lsD5uaGC6OXecJpWnpKiiNhgBmyZbK7s0Ebkj7Kh38D2kvxTrVq
         w8XMlPf+p3Cq0JSWXLojVHZpClIM8uNrDxIlROQNmHzFvcfwwrh3LNlcVBMHem4UPg7l
         oQcKcH1QJ0IYnhlU9K5efrGPV3lPHz2u7mTLXOpryf/Mt2fGqLDD+0mx3I/rEz7Jf2ZU
         2mmAk+4+K2yMHmgegUbD8Hh+bOf3n7DgMmhMQ1MSBm7VSiigIWS6h2HkPQfw7SNi2W84
         70pw==
X-Forwarded-Encrypted: i=1; AJvYcCWsZtjcCHshNCih2BmQpTnrgKwpyGml/KKwPJDSkzqx2IEdamPe59bX40IRuEUrolVN0x+wqT7Gx/9Y9Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsCDtc9CQ3nRbddcsIFpctVYQDe8uZEDL43pqVxh1glfaYlAfi
	czLr8F3e+zv5+t/+trwu3q+eyCJMRmyyXe4egYAFarNShNrjM9i0RsnxcOOhYDP82IBUeVHbyo6
	P/gOWsZ0KIEsL7MlNIi1Eg814hmZR6/SR84aX
X-Gm-Gg: ASbGncsgZOUtGG5PfASkBEJXRbgQR3YpK/CjM/jA9VTvO70rx9d8FPo5TeMOceHzpFF
	XU8R/2X7NmzOKsYVywdVH3bYH5dfbT+g=
X-Google-Smtp-Source: AGHT+IGbSeZqbmgkC8WW+TVr8vA7oSBz55D/ZdJ5naePZ94IMQ2mxpvLTWKUC+Y4A8FKmlAv1Y1TD/2+abdDv8gppVQ=
X-Received: by 2002:ac8:5891:0:b0:462:9e4:de13 with SMTP id
 d75a77b69052e-4634289433emr105821cf.9.1731372545473; Mon, 11 Nov 2024
 16:49:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111205506.3404479-1-surenb@google.com> <20241111221839.w4rqqlvvkm42jdgm@offworld>
 <CAJuCfpGw1Nnh3nonDHv-UAeqTB=-3z1+hJk9Opy4X-6mbvdEhw@mail.gmail.com> <20241111161102.e047bce4adfbf38002b7a9cf@linux-foundation.org>
In-Reply-To: <20241111161102.e047bce4adfbf38002b7a9cf@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 11 Nov 2024 16:48:54 -0800
Message-ID: <CAJuCfpGAc6zP6tBPV618eyKTQmhWzEF+eOOsX=Ga5uJ3tsMcRA@mail.gmail.com>
Subject: Re: [PATCH 0/4] move per-vma lock into vm_area_struct
To: Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
	oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com, 
	peterx@redhat.com, oleg@redhat.com, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, minchan@google.com, 
	jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com, 
	pasha.tatashin@soleen.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 4:11=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 11 Nov 2024 15:19:22 -0800 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > On Mon, Nov 11, 2024 at 2:18=E2=80=AFPM Davidlohr Bueso <dave@stgolabs.=
net> wrote:
> > >
> > > On Mon, 11 Nov 2024, Suren Baghdasaryan wrote:
> > >
> > > >To minimize memory overhead, vm_lock implementation is changed from
> > > >using rw_semaphore (40 bytes) to an atomic (8 bytes) and several
> > > >vm_area_struct members are moved into the last cacheline, resulting
> > > >in a less fragmented structure:
> > >
> > > I am not a fan of building a custom lock, replacing a standard one.
> >
> > Understandable.
>
> If we're going to invent a new lock type, I'm thinking we should do
> that - make it a standaline thing, add full lockdep support, etc.

Yeah, that will make it easy to experiment and replace it with a
different lock type if needed.

>
> I wonder if we could remove the lock from the vma altogeher and use an
> old-fashioned hashed lock.  An array of locks indexed by the vma
> address.  It might work well enough, although sizing the array would be
> difficult.

Ok, sounds like I'll need to experiment a bit with different lock
implementations.
I'll post a new version without the last two patches, keeping
rw_semaphore for now.
Thanks!

>

