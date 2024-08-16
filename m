Return-Path: <linux-kernel+bounces-290363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 478D69552BC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CABBF1F23245
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD5C1C688D;
	Fri, 16 Aug 2024 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aqHTPrmy"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D581C5791
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723845149; cv=none; b=GvmoyFbxF7pBV7ZXo9kuW0/Vxd1gkdTLl//78Oxqs0wlOGK+ylQt9U/F2EBnPjPGz5p5RJcv5PkN0VewlfiM+olCCilPhhpHZFMOqBA0oOify/7PM2HRXqaCR6e8fDJBKOXGOv/oJkZf6D0nHIHhxTOsAw5rHv9iVCQ2QPWY1+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723845149; c=relaxed/simple;
	bh=Tb2YsmBZ9MOyDI/stnMDhfutA+rVZT0BSt77il9pWyo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TlC385JfzYavNjP+kUHegRloetwU9dSyOF8P6y6Ue6hyyzW6pVeY/iT02AoHYaos8GvL8V6ItdcCXOQIBHoSkHVxmAB9OPoqdbt69PcO83u+wEL6BuoVyIyoWk69OENwCHyP5kFYS/25Hmshga1hUvR1G91m4U2S4ixuANoAAT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aqHTPrmy; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03b3f48c65so3793892276.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 14:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723845147; x=1724449947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b4vUtlej2XubFdEQblSjm6EcKT3Hh6Wknx4PIkCBxnA=;
        b=aqHTPrmyOPiy5wnLyIbdHWPcjD9ICyxdfWkYWwelrsCQhcIr/5UawMt9fRxpkK1q/t
         wYjrV2Yk4kuFxsH1m8FnekLVd5RQI2ne3fNwMzoprenGs1/kUc5PTG2gJz++U5NtGtXj
         vOccOAtVDky2y6orpb21VCYBzauWVJyNn4bh/+nrx+63Su56hD213JWLxPJXEWjZ3BIw
         UqcTx/M2Rr5GUw3ZjuxMuq5S6pC65X4hu6WWnQ8vlji16NvG8T0bowJZUkUQZfuaAncY
         Uzd/YOqB5wQpHfc/dDIWbBJqT39+dYzSkr//SdaS4IZuJIFa8f9mOW/JufBzjJUbvsZC
         IFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723845147; x=1724449947;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4vUtlej2XubFdEQblSjm6EcKT3Hh6Wknx4PIkCBxnA=;
        b=XEec7T2FlEsAyFtaJmHqDcIbncTHqWV6oWt6jWf+Z8vylnN5teh7XCjI6RiZR/EIUq
         iYiBUrNJfoz2Q+RDKRo2WQ5L8ByLPGl3S3pXC9h4FaIMP9SqB8vShpCx50nRrW82mmCl
         3/hsW30jVUcFMKqIDAfVaSxQXaXHIAGwTdJxZdNRuV9RUaM7VHDoLmRaV3PLM9GDZ6Mo
         jMBDyWgV1ZNvBfB/bX5dBQ8j2MSAapjTo/Inqtto60IkuL/bLOqXgN4GgLtOvlXFnwVp
         YECx4cjraaKZSVOqZmle78ZPWfGeSj7Pz70QU/njo+XxZkvy9lp4nqN78tZnDxwxXLII
         E9DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHP41uSiis2PCvy8KEXLqAGnxZMkzl2YxUjiNP2AGt74iJj6mTp/iyE02tTnMWT/LZD+D96y56mGgW98M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdVoDNyVgWzkNOva0krOWDppW4c4jLOc2wUUxhS3DiNK1gPz3C
	aWYEq/0gBrlbcvgu8tqENllHE1dZ6xinMz88uszTnd9p1iIf+U1806RT0l4TB6HIlF2eiWW+tcn
	usdb60GOUDzz3/m6EWn2OxQ==
X-Google-Smtp-Source: AGHT+IEs8zyvsoWuEvbphvAg5cMjHgbJYgPfPLSoGdtpOJDuLoPEAib3HGlcNl6V4/E+t5mIJiod+fTrhqt78lV+hg==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a25:8751:0:b0:e11:6fcc:b656 with SMTP
 id 3f1490d57ef6-e1180e97369mr34695276.6.1723845146700; Fri, 16 Aug 2024
 14:52:26 -0700 (PDT)
Date: Fri, 16 Aug 2024 21:52:25 +0000
In-Reply-To: <94c5d735-821c-40ba-ae85-1881c6f4445d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240805-guest-memfd-lib-v1-0-e5a29a4ff5d7@quicinc.com>
 <20240805-guest-memfd-lib-v1-4-e5a29a4ff5d7@quicinc.com> <4cdd93ba-9019-4c12-a0e6-07b430980278@redhat.com>
 <CA+EHjTxNNinn7EzV_o1X1d0kwhEwrbj_O7H8WgDtEy2CwURZFQ@mail.gmail.com>
 <aa3b5be8-2c8a-4fe8-8676-a40a9886c715@redhat.com> <diqzjzggmkf7.fsf@ackerleytng-ctop.c.googlers.com>
 <94c5d735-821c-40ba-ae85-1881c6f4445d@redhat.com>
Message-ID: <diqz4j7km8yu.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [PATCH RFC 4/4] mm: guest_memfd: Add ability for mmap'ing pages
From: Ackerley Tng <ackerleytng@google.com>
To: David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>
Cc: Elliot Berman <quic_eberman@quicinc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Patrick Roy <roypat@amazon.co.uk>, qperret@google.com, linux-coco@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

David Hildenbrand <david@redhat.com> writes:

> On 16.08.24 19:45, Ackerley Tng wrote:
>> 
>> <snip>
>> 
>> IIUC folio_lock() isn't a prerequisite for taking a refcount on the
>> folio.
>
> Right, to do folio_lock() you only have to guarantee that the folio 
> cannot get freed concurrently. So you piggyback on another reference 
> (you hold indirectly).
>
>> 
>> Even if we are able to figure out a "safe" refcount, and check that the
>> current refcount == "safe" refcount before removing from direct map,
>> what's stopping some other part of the kernel from taking a refcount
>> just after the check happens and causing trouble with the folio's
>> removal from direct map?
>
> Once the page was unmapped from user space, and there were no additional 
> references (e.g., GUP, whatever), any new references can only be 
> (should, unless BUG :) ) temporary speculative references that should 
> not try accessing page content, and that should back off if the folio is 
> not deemed interesting or cannot be locked. (e.g., page 
> migration/compaction/offlining).

I thought about it again - I think the vmsplice() cases are taken care
of once we check that the folios are not mapped into userspace, since
vmsplice() reads from a mapping.

splice() reads from the fd directly, but that's taken care since
guest_memfd doesn't have a .splice_read() handler.

Reading /proc/pid/mem also requires the pages to first be mapped, IIUC,
otherwise the pages won't show up, so checking that there are no more
mappings to userspace takes care of this.

>
> Of course, there are some corner cases (kgdb, hibernation, /proc/kcore), 
> but most of these can be dealt with in one way or the other (make these 
> back off and not read/write page content, similar to how we handled it 
> for secretmem).

Does that really leave us with these corner cases? And so perhaps we
could get away with just taking the folio_lock() to keep away the
speculative references? So something like

  1. Check that the folio is not mapped and not pinned.
  2. folio_lock() all the folios about to be removed from direct map
  -- With the lock, all other accesses should be speculative --
  3. Check that the refcount == "safe" refcount
      3a. Unlock and return to userspace with -EAGAIN
  4. Remove from direct map
  5. folio_unlock() all those folios

Perhaps a very naive question: can the "safe" refcount be statically
determined by walking through the code and counting where refcount is
expected to be incremented?

Or perhaps the "safe" refcount may differ based on kernel config. Could
we perhaps have a single static variable safe_refcount, and whenever a
new guest_memfd folio is allocated, do

  safe_refcount = min(new_folio_refcount, safe_refcount)

>
> These (kgdb, /proc/kcore) might not even take a folio reference, they 
> just "access stuff" and we only have to teach them to "not access that".
>
>> 
>>> (noting that also folio_maybe_dma_pinned() can have false positives in
>>> some cases due to speculative references or *many* references).
>> 
>> Are false positives (speculative references) okay since it's better to
>> be safe than remove from direct map prematurely?
>
> folio_maybe_dma_pinned() is primarily used in fork context. Copying more 
> (if the folio maybe pinned and, therefore, must not get COW-shared with 
> other processes and must instead create a private page copy) is the 
> "better safe than sorry". So false positives (that happen rarely) are 
> tolerable.
>
> Regading the directmap, it would -- just like with additional references 
> -- detect that the page cannot currently be removed from the direct map. 
> It's similarly "better safe than sorry", but here means that we likely 
> must retry if we cannot easily fallback to something else like for the 
> fork+COW case.
>
> -- 
> Cheers,
>
> David / dhildenb

