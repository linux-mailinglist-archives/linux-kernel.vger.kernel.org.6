Return-Path: <linux-kernel+bounces-188118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FE58CDDB2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 01:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73851F218B4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DC812882D;
	Thu, 23 May 2024 23:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="Po23fLZc"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EF4127E38
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 23:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716506640; cv=none; b=ac7ME1ZdRNqx5Oze2VwvkR+Dw6IPodvRUJBhNkcYoRc79UWYiRdLs8P54M4gt6uR9+mNFKpLWpl70aREp3BiULLG5/6T3uCaf8Jm4IoAi0wRHhVcUbcLSBenAqK8gTBV3oFXGnLOVTIt+Q24oaSIZQomt4BhlcUBazjD4wgAo5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716506640; c=relaxed/simple;
	bh=Gamjr1Kq5QKTSqFGHszIUfbG/qhtiy3XUEScc83qRsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euvrLVUcF2taZh50MC1wGkOjWFQxXb1CGFS5cF3und2WTbFP96gtNcMP3wtK3SJN1HkP9Hpawnl0C+rVU4FDu5rfTe8v1U44ATYBrlP2x0fzmspvpNpklE1Xx2BeOqiydQCX9Y1tGTgbc4lxG3L8/BBh5AiqL7YAgtccmhHdU6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=Po23fLZc; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-794ab1bafedso15756585a.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 16:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1716506637; x=1717111437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCsJAhAICDD0J2ZUXO/j6avgWN3eOAMHb3WgznL0auw=;
        b=Po23fLZcGyctEAeiDOpOviQZ2i4Sdt1dWX9zS505f2f7KNrGye+U68xwnSJ7SbmSZK
         bu2wedWuT3bQO9Xn7Agd3qgneNrCRNbaSDkQNA/eLGUCCTgd7oyFGt+5AYf3h8/gr2XT
         O9wDxbQWeKat+tT/EgC18PuoKsmktkMF0UxEiwufuCLIZDbSKbz9jZobBeQKQfRBaAaO
         2wUqrUln0J9uOdoM5+R3O7NH4VWnJ2PxYCAnga1vsoHwIyeFLgy7DUqnaNfmgyqaAj4q
         nD0QkwW/qOVZDvHp3CL+VsBflnZ7ojP9pqlEMDsX+S1nvQocCgrIRmrd7J4EK08FZn30
         VXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716506637; x=1717111437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCsJAhAICDD0J2ZUXO/j6avgWN3eOAMHb3WgznL0auw=;
        b=u1v0tBcYfoR91y9LRXdxGF2Zz3Tug2raVQIGy9FSqj/e97XMX0Mo25SyRGhj+0nNx+
         ol9JG57I4HSoixOb0ffR7sC96VHAxqBQ3uJVs/yLlcv3UkyFzlLJh7kwNoSEhKHihymt
         VtohpS+ySVqINByqFrbwxam0Fyy64aWkVoQon0zMZrqeEztS1NXLLH/hZe4w/6fFQtZ3
         rVxARQsxYJuzvj8WPXe7Z6Qi1Fj3m/Nog6cS+oar7U6JrjoxZIulIm1numMDOM4ojw5x
         kfDyivCGlGem129znFCxjAODeUG3u1/zwWGevpLdRbNUytPNvhVa+AbFKphkTfUiOs46
         Y1Bg==
X-Gm-Message-State: AOJu0YzNKzc6folX9JbdVANpAz9oaq1xBphma3OmUwvfMxXzg9HQxQaC
	3oYVAiMhn9MAEPh6NWE43ZK2qouIlhja77IeQOEuxxc/43fiAWxw3e4rpSRE7TfT0RzW1v4QC8H
	SWyy5aniacGFQAjLG6lqxCbknnKMezBpDiIXyAw==
X-Google-Smtp-Source: AGHT+IFR4OHciC4416nU/Vadzzwje6/rqkHG0oe8lwzmS6LuTsftY2iNl1Gq5BEhPp6lD/4SkUqnuWlmnfdeVgnr8Jc=
X-Received: by 2002:a05:620a:a19:b0:790:f843:db57 with SMTP id
 af79cd13be357-794ab0f8b0bmr65876085a.58.1716506637454; Thu, 23 May 2024
 16:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523132139.289719-1-peterx@redhat.com>
In-Reply-To: <20240523132139.289719-1-peterx@redhat.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 23 May 2024 19:23:19 -0400
Message-ID: <CA+CK2bDhAOto1A+TAvGSuNzNTTUd9FZ4m3wV_3rou6AfXJzXzA@mail.gmail.com>
Subject: Re: [PATCH] mm/debug_vm_pgtable: Drop RANDOM_ORVALUE trick
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Gavin Shan <gshan@redhat.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 9:21=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> Macro RANDOM_ORVALUE was used to make sure the pgtable entry will be
> populated with !none data in clear tests.
>
> The RANDOM_ORVALUE tried to cover mostly all the bits in a pgtable entry,
> even if there's no discussion on whether all the bits will be vaild.  Bot=
h
> S390 and PPC64 have their own masks to avoid touching some bits.  Now it'=
s
> the turn for x86_64.
>
> The issue is there's a recent report from Mikhail Gavrilov showing that
> this can cause a warning with the newly added pte set check in commit
> 8430557fc5 on writable v.s. userfaultfd-wp bit, even though the check
> itself was valid, the random pte is not.  We can choose to mask more bits
> out.
>
> However the need to have such random bits setup is questionable, as now
> it's already guaranteed to be true on below:
>
>   - For pte level, the pgtable entry will be installed with value from
>     pfn_pte(), where pfn points to a valid page.  Hence the pte will be
>     !none already if populated with pfn_pte().
>
>   - For upper-than-pte level, the pgtable entry should contain a director=
y
>     entry always, which is also !none.
>
> All the cases look like good enough to test a pxx_clear() helper.  Instea=
d
> of extending the bitmask, drop the "set random bits" trick completely.  A=
dd
> some warning guards to make sure the entries will be !none before clear()=
.
>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Gavin Shan <gshan@redhat.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Link: https://lore.kernel.org/r/CABXGCsMB9A8-X+Np_Q+fWLURYL_0t3Y-MdoNabDM=
-Lzk58-DGA@mail.gmail.com
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/debug_vm_pgtable.c | 31 +++++--------------------------
>  1 file changed, 5 insertions(+), 26 deletions(-)

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

