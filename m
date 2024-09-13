Return-Path: <linux-kernel+bounces-328966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3230978B94
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 01:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569432834F0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E9816F0EB;
	Fri, 13 Sep 2024 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QsNi6t7d"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091DB183CDA
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 23:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726268405; cv=none; b=mavO7ghBaCQ6OU42KIsC3uiCR0LduUeCA7zbMO1NuweyogFOEfXQ/rLqgSAH0roGUTnFHlq8uLMFupFldJH3nLo/jGqHLgdBljXO0OcgSWreriU0Jb6jix2gSAkRN7vmrFqcexI87Rb3cG5SmU615gHJjFSsZA5idIOplFepYvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726268405; c=relaxed/simple;
	bh=4Rljwipq3tEsYdpCyyQJLeX0ooclejtLdo/lF/ka4mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BESvJ+y1l9nnu6T5QsQdi9LWfnCyBcLOT/8yCwNE9sEVUMjSbAWcbmr6KT/rLr4daV6iG/jYiuDGJ5plasJLzCRJnGZfl+Kn9q8hhsKBfB897eP5Yu2bGkmMGpjVO136WXtFngy0L1vPu+8LMxP/CdsRyYF6em7ogOfYG5pbijs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QsNi6t7d; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e0501d96c4so132413b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726268403; x=1726873203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uQnZG2FkiJVH/FNBSQsovL+XHO5tAw2cuV4O/cm3RU=;
        b=QsNi6t7d50KKVc8rz5HO0bu9rtEmibEh582x6qcxOczdDFxQx/OrRee7fyU5KcNZzo
         Hbzd3010DJPBu6ETLly53MQ1qLqV0SpISEZvQNMwyq8I9wUFCVQtfhIwLf9Msrt1cPS+
         jmDef4bBHS8A89Cos1fNui/hScARK0ywXiDhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726268403; x=1726873203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uQnZG2FkiJVH/FNBSQsovL+XHO5tAw2cuV4O/cm3RU=;
        b=bLB0MHm7nnUhjrDrIkHTa82r4Wx+8F25LXw4/GTcpxdWdDymoex9curk5/kKem1KH0
         iHJZuNSftSd3oK23wZtYCSZsRHFHqBDYh3DEv82dZulCMvO100SpGuN6B3D8tC8eTAlH
         tTdchJqVriPenGnWfCSOXqXx7fXpUJZTQqosbs92My9awLuj0eksbdQGmVpsdMRnfefB
         uVvsg8Kv4EkHZIFN5suuv6r2QvOboWeb0LONZ7hw35GAECeAVJ7Maxm+owszFpEjS8fe
         Bb5RTnwPS84LtbCMsAprdWtODYc5r0/J14OO86+6WFgo1NQ1ZWb6mgqbsUP2Pk7oycPa
         /6xw==
X-Forwarded-Encrypted: i=1; AJvYcCVKbNG/1fCBNMnNMhL3bh1/OoWNK92hH8tBKJeK8FdnNpcVsMEQ/lMXPWguRvwSxT9ju4mmhQ1NkSqiL0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu+QbtZq5OLb4RVy9l16PmBR7ZczinYjomFMXyWQtLlKH/KWF8
	X+Yxw2oaKJ7VDsGNTbHIa1T7+x/OIHpyJpSM4zmvIMtrctJC5pudxV7hHV/uy0GW6jCBAFI/I1f
	kd1DWkqk9rT/4a+S3z24f9Ni9Hv3KM4Mq17O9
X-Google-Smtp-Source: AGHT+IEVPZfFT+ibnTF4pI9UcZLzSJRCqjMlhaulJR9tiSRKbpWAKYYnC2TslOUpj0ICyRwwZy9DUCydGRjgpkjZ4vU=
X-Received: by 2002:a05:6870:b616:b0:27b:58d8:c8de with SMTP id
 586e51a60fabf-27c3f278400mr1550781fac.5.1726268402819; Fri, 13 Sep 2024
 16:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830180237.1220027-1-jeffxu@chromium.org> <20240830180237.1220027-5-jeffxu@chromium.org>
 <e7ea2b84-8d10-40fe-a14f-837bca851ea9@lucifer.local> <fd927106-2fc3-4b96-8014-2c517229bc99@lucifer.local>
 <CABi2SkUpCf+aOa2sPED8CosG5ccqjFd7ouot8gXi9ECqsHiZhw@mail.gmail.com>
 <4944ce41-9fe1-4e22-8967-f6bd7eafae3f@lucifer.local> <ihclooyralrg2yugyrkwvw3kay6k7hpdgzczhcxh5dgmakulwb@wpb4kyofz7ot>
 <CAKbZUD1pfwN_vyq3y1rBoc=66WRBTXJU5gJjpFKttFiaVznaPQ@mail.gmail.com>
In-Reply-To: <CAKbZUD1pfwN_vyq3y1rBoc=66WRBTXJU5gJjpFKttFiaVznaPQ@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 13 Sep 2024 16:00:00 -0700
Message-ID: <CABi2SkXOwCMpAYfctHSF28qa7MzhiA3A1zo1XVaJcK_mE1-9bw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	willy@infradead.org, broonie@kernel.org, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, rientjes@google.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pedro

On Sun, Sep 8, 2024 at 2:56=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.c=
om> wrote:
>
> On Sun, Sep 8, 2024 at 10:35=E2=80=AFPM Pedro Falcato <pedro.falcato@gmai=
l.com> wrote:
> > Hi,
> >
> > I agree with most of the points. Sitting down here to write unofficial
> > guidelines for mseal behavior.
> >
> > mseal should seal regions and mark them immutable, which means their pr=
otection
> > and contents (ish?) (not _only_ backing mapping, but also contents in g=
eneral
> > (see madvise below)) should not be changed throughout the lifetime of t=
he address space.
> >
> > For the general syscall interface, this means:
> > 1) mprotect and munmap need to be blocked on mseal regions.
> >  1a) munmap _cannot_ tolerate partial failure, per POSIX.
> >  2b) mmap MAP_FIXED counts as an unmap operation and also needs to be b=
locked and return -EPERM.
> >
> > 2) Most madvise calls are allowed, except for destructive operations on
> > read-only anonymous _pages_ (MADV_DONTNEED is destructive for anon, but=
 we also don't care
> > about blocking these ops if we can do it manually with e.g memset)
> >  2a) The current implementation only blocks discard on anonymous _regio=
ns_, which is slightly
> >      different. We probably do want to block these on MAP_PRIVATE file =
mappings, as to block
> >      stuff like madvise MADV_DONTNEED on program rodata.
> >  2b) We take into account pkeys when doing the permission checks.
> >
> > 3) mremap is not allowed as we'd change the "contents" of the old regio=
n.
> >  3a) Should mremap expansion be allowed? aka only block moving and shri=
nking, but allow expansion.
> >      We already informally allow expansion if e.g mmapping after it + m=
seal.
> >
> > 4) mlock and msync are allowed.
> >
> > 5) mseal is blocked.
> >
> > 6) Other miscellaneous syscalls (mbind, etc) that do not change content=
s in any way, are allowed.
> >  6a) This obviously means PTEs can change as long as the contents don't=
. Swapping is also ok.
> >
> > 7) FOLL_FORCE (kernel-internal speak, more commonly seen as ptrace and =
/proc/self/mem from userspace)
> >    should be disallowed (?)
> >  7a) This currently does not happen, and seems like a large hole? But d=
isallowing this
> >      would probably severely break ptrace if the ELF sealing plans come=
 to fruition.
> >
> > When we say "disallowed", we usually (apart from munmap) allow for part=
ial failure. This
> > means getting an -EPERM while part of the call succeeded, if we e.g mpr=
otect a region consisting
> > of [NORMAL VMA][SEALED VMA]. We do not want to test for this, because w=
e do not want to paint ourselves
> > into a corner - this is strictly "undefined behavior". The msealed regi=
ons themselves
> > will never be touched in such cases. (we do however want to test munmap=
 operation atomicity, but this is
> > also kind of a munmap-related test, and might not really be something w=
e really want in the mseal tests)
> >
> > Kernel-internal wise: The VMA and PTE modifications resulting from the =
above operations are blocked.
> > Sealed VMAs allow splitting and merging; there was contention about the=
 splitting issue, but it truly
> > does not make sense to block operations unless they affect a VMA entire=
ly, and that would also force
> > VMA merging to be ABI ("vma_merge isn't merging these two regions and n=
ow my madvise works/doesn't work :(").
> >
> >
> > Do I have everything right? Am I missing anything?
>
> Small addendum: file write, truncate and hole punching might also
> matter for sealed file-backed regions, as these change the region's
> contents, but we probably
> want to rely on file write permissions to protect against this (as we
> already do). Any other solution is probably terrible and probably
> endlessly NAK'd by fs folks, but it does
> mean sealed regions aren't really immutable if you or the attacker can
> write to the file.
>
Right. The mseal protects the control-data of VMA (e.g. prot),
it doesn't do anything more than that. The file permission relies on
dac/mac control.


-Jeff


> --
> Pedro

