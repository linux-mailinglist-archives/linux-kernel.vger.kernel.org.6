Return-Path: <linux-kernel+bounces-378601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 891889AD2FC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1212D1F22545
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F037A1CEEB5;
	Wed, 23 Oct 2024 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="GuzX14qk"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30A11CEEAA
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704964; cv=none; b=W7Ap0ra5YBEBci1bafk/JA0YHs6c+OI6+OUie2Z+wCOGNHr9i0uBJHFui1dEb3mT7cY9JF3SQNkhqcBha5NMWBe01YFS3dcjrJnwkhzlk1TDEDzUcPJl+sAYyVTn7FcK3hR0pE2TRrktsGu4RxD2rZWHVxjN072bkgZTanRAwak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704964; c=relaxed/simple;
	bh=spFboIypgyk3XWp5kghVBAFFeZk1pIkBkrhK+B/w9NQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4tnTTDlUCQAuQeRW8KzFgR2Dy3Hdd5glLHeLjB/oBtbLtJx9/atg30Xl11oTlpPOnBemRvg0cE2j1Q3iGABwOOVlu0sm2OeOZRVPYVF4HUcCVp5WvCF6e2GpF6cTVs97O5ZhMD3oaSXsKl5Q7NrnNoGYWF8gphiNNXw/XD4j5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=GuzX14qk; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-460ad0440ddso244331cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1729704961; x=1730309761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spFboIypgyk3XWp5kghVBAFFeZk1pIkBkrhK+B/w9NQ=;
        b=GuzX14qkCeGqN3E6465gmapHJB0vk57BfOaf40RmAdF0aZbjq+hYdVGHletdw/bxkq
         cM8XIAeLW8/aU/+GsNUxAVFYDToW8zlSNDMWUrSEUGqG+MWsLZ/amvpTXhabuA6cE4A1
         U8aeBvdgevCqur7ynOaQj7QKBn6gyH9PV39GHFBWxef7gYS8HpfBX9x8ACqJp2CP4n1Z
         DkVh6H+1G/Jjn5MS8FggfFlAAoj9d8T6hfbDt3JakCgXtdJ59bw+rm34kwrN2ayoQAM+
         ofhUJiM+KLYYIhAaAwbo1VxxJUHIR1YiOUOL7a++v+AD7b2+0y5TFG2/ZUUPD3h43CcP
         37dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729704961; x=1730309761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spFboIypgyk3XWp5kghVBAFFeZk1pIkBkrhK+B/w9NQ=;
        b=u1e8+tAErBYREmu9yDkYXtlJAyUaBXMn+8LUT6zAv4TjnIPu1zof3p5zvGZVP/7ZPC
         t5wvaLzIttsmeFjw68Oz8Q5gXR63MD9aY55TWrkKv9Cs8QCPEs3esxpKJcXqMOlzaJvg
         q/kjL5X/yQKyE81YQ4reLkKNcsf4/Wz5//qIt7CRQ0/j9j41hWDvizzge6YbHT0FFZ8l
         Ng/ixkSppArOdAZ0Iyh3DFPXdkAvB5WRHqxR12YCuW5N/5Xo1Q4Tv+q0YnT/4xCyme1W
         YCawBOI6+6aq0jqAxxYEHX6szGrxv71oALJYrrEfUx9KaRyh5qeUUcLejFgrXX1l0aSW
         TpcA==
X-Forwarded-Encrypted: i=1; AJvYcCV0acYz/vXq/IKFoCh2uECfCB1QiYodgvGIB4h63EkeqX0hSkjVZlo/JVZjfxTPcsMcF9MoLJrkB7lxSsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyad9GJ8x+sxRFLHIwQ1y8lpHuOVMqn5tlaniPsE/n4jorn6Mk+
	lMQTx25j65TdYTiCmt4aI/JIq4zpBgkSBt6fyIc+qQEPrtIuNOTZHlfd6ASCUeqcqSOyGgvoulv
	EFoK5lBpatrF12+0kuc6isXI4BZzkakJGZ0f/TA==
X-Google-Smtp-Source: AGHT+IFV+lf1cZYVfoZTKRitSaDBfAqj+KRGY17augig5JAjskqsVjHe3OvS9TISaOCa0dNfmisxyapMIUhj1oFRM3E=
X-Received: by 2002:ac8:5e0a:0:b0:460:a942:e8be with SMTP id
 d75a77b69052e-46114714d4cmr43850111cf.37.1729704961651; Wed, 23 Oct 2024
 10:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023170759.999909-1-surenb@google.com> <20241023170759.999909-6-surenb@google.com>
In-Reply-To: <20241023170759.999909-6-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 23 Oct 2024 13:35:24 -0400
Message-ID: <CA+CK2bCUqFeJdWqMiKRNEjWc15vUsk9YAbaLqgL5nAXM8ZkdBA@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] alloc_tag: introduce pgtag_ref_handle to abstract
 page tag references
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, 
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, urezki@gmail.com, hch@infradead.org, petr.pavlu@suse.com, 
	samitolvanen@google.com, da.gomez@samsung.com, yuzhao@google.com, 
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, linux-modules@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 1:08=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> To simplify later changes to page tag references, introduce new
> pgtag_ref_handle type. This allows easy replacement of page_ext
> as a storage of page allocation tags.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

