Return-Path: <linux-kernel+bounces-406173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF969C5BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1BF8283FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFB22003AE;
	Tue, 12 Nov 2024 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wFXLSRtI"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3081FF046
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424741; cv=none; b=tNJ938was0as0fgA0/otSIHeJE20JU5iGbwMedM+R/rzYa9SKlnKp4kMMmX0ScREJ+rxVSUbMsLSkV2f9WMXFFatoy9bTs9GnisOm+p+dwqBHRO8PvsCf170JDkQz1/8Mf+eklIl00te5osS7bJd24RchD2N00ZYYiBDF+PtiF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424741; c=relaxed/simple;
	bh=M4scW01G7Vkl8rObO+ufUyoTN9XieKMnRyrnvdqtk0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pqlJfiRSh7iVflXHlVcQFfzxyLEquWmVPYYJvfiV7dTCm4zc+2/yuR1YP9BqkCnwkIrRXdpmUUeQX7w5L/ArEpjhoHXbA5d00KVJ1FDpVfFot/ht2jibX3FqTlXyOugQsLdzI6K8YyAqbRfoA1CV7pmataiTSlbQDUjnyFOsPGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wFXLSRtI; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-460969c49f2so302491cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731424738; x=1732029538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7s0gz8SBe6kZJRdrCBkVAQ16SvSS5JRcd2TF6qDYlEM=;
        b=wFXLSRtILG/aBO4VxTLMxuvtIXwDhwq8WCJ+GynqWzD+10491YrI100t+SdshpH3Gc
         qvsxW2lK/3XtQ8y2lFg+TFvT++M+g2RvwWohJAkwVxKsPzgF+pYQgHrLOQLiVsL93uH+
         wAE1smS7fTa1E29L9jY1bhMb5bamFqH2Ff7BCWiKw531KvdLa+IMOJdDEIa2V3appShP
         pcw6JGwmjPiT0fQ9GS2CFegM+AjsuAVBBCr/MmIea/kABpG4x0wJ1hteO0i/tilJTdYq
         0ahXP5ICCwCF+IxV8YgiLZpL5jQ7QREbkR34BCQodutqD3RnIbjWL2cz7e1gHCktbYyy
         pQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731424738; x=1732029538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7s0gz8SBe6kZJRdrCBkVAQ16SvSS5JRcd2TF6qDYlEM=;
        b=RhhfcY4ACEOitcvtQYoTYZ7AP4bua2Lp6X+1XGBubEyUFfVIQW4iTDcD6VOcPcQs3s
         XpyjplcDOYSQyW/XGF3OyC99OYqI8zpWDJ5dxCvU61bEf7J8EAnwOsA4aIJ94PNxGqq0
         5ocwbKvB9VN4//uo42dheOD/TBsu/RG4/mGIH2jAGxSiAEbtLNF/Jtc8VrejbeIfngXB
         G4QQFSdDqqgyP2ieacHR3qMTFewER46ubMaVgX6OMI2S29q1dmGizIoncToypas2dgai
         sRjZRt7pED40+NDhXchxj/tcPWEV/1DGRpj8FWbtLT9ywV2JHlRm5cIEiS5mEnASY6Pl
         H59A==
X-Forwarded-Encrypted: i=1; AJvYcCVSS8HkFR7Hyk3g3dcnJH0Ud3rJAAIRuhlw0g38Hab2OFm1YVVLcgUK/WRd67WXki9ipgLLiwZuiArBoO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn8Ws/Arys6ahZv7WvSpR9kEtyiOMoVsAKlrIIlePzS9sl47oh
	3TBM/I3gGrBnhU6c7re82AJdS+MIuHqa/QOcCagtBXFfZxPOQeWcScS1AN9mX2AibUXKP3c9ynC
	cWvO02HmZtS4LHlTGWRYPhBCUb+mywKtHpM0m
X-Gm-Gg: ASbGncuNgYDpclGpxZCxOxHnnZ8jNq5Brstwo/FUuJsrJ1ieu307utNyQBxowpcv53o
	Z1EOaNzFpqeDjz1ooc77pu++98c85LKVg/Zpx7oRydpD8md16kANG9NCSxzlXCA==
X-Google-Smtp-Source: AGHT+IG4GnpKek/1UR60rqfCuL5z9RWIUc0qGAHDcDXKe7UZZmylKOJWdccpbWEWgkX8Z24/AHOJlY7nOMsllu5paDE=
X-Received: by 2002:a05:622a:5787:b0:45f:9b3:c7d4 with SMTP id
 d75a77b69052e-4633ef60953mr3840701cf.6.1731424738095; Tue, 12 Nov 2024
 07:18:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111205506.3404479-1-surenb@google.com> <20241111205506.3404479-4-surenb@google.com>
 <ZzLgZTH9v5io1Elx@casper.infradead.org>
In-Reply-To: <ZzLgZTH9v5io1Elx@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 12 Nov 2024 07:18:45 -0800
Message-ID: <CAJuCfpHpGSpix8+mB76Virb+HAMrOqB3wG8E4EXPrRCnBoBGeA@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: replace rw_semaphore with atomic_t in vma_lock
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, liam.howlett@oracle.com, 
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

On Mon, Nov 11, 2024 at 8:58=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Nov 11, 2024 at 12:55:05PM -0800, Suren Baghdasaryan wrote:
> > When a reader takes read lock, it increments the atomic, unless the
> > top two bits are set indicating a writer is present.
> > When writer takes write lock, it sets VMA_LOCK_WR_LOCKED bit if there
> > are no readers or VMA_LOCK_WR_WAIT bit if readers are holding the lock
> > and puts itself onto newly introduced mm.vma_writer_wait. Since all
> > writers take mmap_lock in write mode first, there can be only one write=
r
> > at a time. The last reader to release the lock will signal the writer
> > to wake up.
>
> I don't think you need two bits.  You can do it this way:
>
> 0x8000'0000 - No readers, no writers
> 0x1-7fff'ffff - Some number of readers
> 0x0 - Writer held
> 0x8000'0001-0xffff'ffff - Reader held, writer waiting
>
> A prospective writer subtracts 0x8000'0000.  If the result is 0, it got
> the lock, otherwise it sleeps until it is 0.
>
> A writer unlocks by adding 0x8000'0000 (not by setting the value to
> 0x8000'0000).
>
> A reader unlocks by adding 1.  If the result is 0, it wakes the writer.
>
> A prospective reader subtracts 1.  If the result is positive, it got the
> lock, otherwise it does the unlock above (this might be the one which
> wakes the writer).
>
> And ... that's it.  See how we use the CPU arithmetic flags to tell us
> everything we need to know without doing arithmetic separately?

Yes, this is neat! You are using the fact that write-locked =3D=3D no
readers to eliminate unnecessary state. I'll give that a try. Thanks!

>

