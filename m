Return-Path: <linux-kernel+bounces-233130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2E991B2A2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B375B2256F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C291A2FA2;
	Thu, 27 Jun 2024 23:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0SxAQ/5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9941A2C2D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 23:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719530388; cv=none; b=CGHAzKM7Qfj0XQ4s014P010BzjSUQSG2dg+qLJsV8QTM3P72hmsetbK1LMEENbhzh67zoOCJTHv95HQzlHBFoK9XCXbxODgleIn8wmXpRDr4KQTTUTYVyq6ldqf5Ea0GAp8G6pxXgeLzcM7X2K/rWP4G4cnMyQTEhAcM14tMYFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719530388; c=relaxed/simple;
	bh=PPRwhvydXhxUZQexsx5RnnndFRg7TQ1NyXIyNCDp3+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pfhbq2koVKyeEG/hXrMbF5aFXSQ/7EXuDFuJ+3zibYpfi7AUaV6w6gTT6mj8dEDSp9HmoAOOp36FQA8Zof4Tk2VY3hvOBWmGLVQtJP14IpS/P5+qJzZyN4n+zFMOLwaLnMntTMZKu4HW/UAUFe7rlScrF11/ouOjEpSSJH9oGnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O0SxAQ/5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719530385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D1YXe5ol6L04xULXPymw3GJypJtsSF73vsgstdp57Og=;
	b=O0SxAQ/5BGxPQGTjLAG6MfEv5DdTuK3RlMQrb77R5g3xQ9eVMxDqYXRclH7FGej5cNSF29
	9O+Bkn6KVER7O0JRNS1h8zjL1771UJEOrQcrCRmw2sTPkX99NGcBu2byALxEPLe5vmNKbQ
	gEnu9DKwFkV/tY8z5Nkl/iZFJ1RJBbI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-rBpHui0SN0GPeBXPgXXrbg-1; Thu, 27 Jun 2024 19:19:43 -0400
X-MC-Unique: rBpHui0SN0GPeBXPgXXrbg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b52c538d04so184726d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 16:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719530383; x=1720135183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1YXe5ol6L04xULXPymw3GJypJtsSF73vsgstdp57Og=;
        b=YzOXOR7agzKx1wRXRkv/uRxvDUkKAJv2wQY4l4zQGPyP3zcja1lQnYCEJnrwGUS8Uj
         Jf85yTCGRnkzYNWIASaEsA+KpGb/4112n7z2NzA+I2l6YA5E77h3UTTPYjF3Yl5d2Kjp
         8ZhFw+Cmm5I+tGNG7JXzwNTPLvvCxt7wg4wFaUjPf/YM76BRjv0saTFxxAFhAIoOBWVc
         3v8RDnF7K48iAEWcuR9ylIWliSDOeoewtkUxy/AX7eCrYGRXeK9SO78mTjmq19L6fD+P
         W75Pb8kGR/ee3Av01s6lEJbceqrxyAKyTFqEOJ0NKDPfidf0k4rS5c0cdO6y2V26pnUv
         vbNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS9EGAtTafte0tpECqSsVqRlyNHHM2jJrqjJAFVR1OpwjfBDJwtUKOBV1p7IIdZ2g6TZDdXMyzmHzWAaIvnulEA1Ca59/hBmPW2kjb
X-Gm-Message-State: AOJu0YwvAxn3+oIsNirQ32oABQxaKyDpkurv+m8x3MCDSt0YDxo1OazF
	o4VZwWPffCjazEthzPHhajl54u9UaS0gJNPPvdIDY1KGWpNjJN265frhmIhiZbGLr2QcRrJ7XYc
	d0DW8GFnudrO5jifFDkPFlbK2jt20dWNvkz9ZkW5PJ82GLtgNKvS0FogmW3GJGg==
X-Received: by 2002:a05:620a:2905:b0:79c:12a4:538b with SMTP id af79cd13be357-79c12a458a7mr732288885a.2.1719530383186;
        Thu, 27 Jun 2024 16:19:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFINKkJ5VHiTiiGezMh5c/t5IqK3PUIBzUnqYyYCVAOhNr45JVSecJ4xWQgBsizyziOSOPc1w==
X-Received: by 2002:a05:620a:2905:b0:79c:12a4:538b with SMTP id af79cd13be357-79c12a458a7mr732286585a.2.1719530382525;
        Thu, 27 Jun 2024 16:19:42 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d692ea2ccsm22783185a.88.2024.06.27.16.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 16:19:42 -0700 (PDT)
Date: Thu, 27 Jun 2024 19:19:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: yangge1116@126.com, david@redhat.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [v2 PATCH] mm: gup: do not call try_grab_folio() in slow path
Message-ID: <Zn3zjKnKIZjCXGrU@x1n>
References: <20240627221413.671680-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240627221413.671680-1-yang@os.amperecomputing.com>

Yang,

On Thu, Jun 27, 2024 at 03:14:13PM -0700, Yang Shi wrote:
> The try_grab_folio() is supposed to be used in fast path and it elevates
> folio refcount by using add ref unless zero.  We are guaranteed to have
> at least one stable reference in slow path, so the simple atomic add
> could be used.  The performance difference should be trivial, but the
> misuse may be confusing and misleading.

This first paragraph is IMHO misleading itself..

I think we should mention upfront the important bit, on the user impact.

Here IMO the user impact should be: Linux may fail longterm pin in some
releavnt paths when applied over CMA reserved blocks.  And if to extend a
bit, that include not only slow-gup but also the new memfd pinning, because
both of them used try_grab_folio() which used to be only for fast-gup.

It's great this patch renamed try_grab_folio() to try_grab_folio_fast(), I
think that definitely helps on reducing the abuse in the future.  However
then with that the subject becomes misleading, because it says "do not call
try_grab_folio()" however after this patch we keep using it.

Maybe rename the subject to "mm: Fix longterm pin on slow gup and memfd pin
regress"?

> 
> In another thread [1] a kernel warning was reported when pinning folio
> in CMA memory when launching SEV virtual machine.  The splat looks like:
> 
> [  464.325306] WARNING: CPU: 13 PID: 6734 at mm/gup.c:1313 __get_user_pages+0x423/0x520
> [  464.325464] CPU: 13 PID: 6734 Comm: qemu-kvm Kdump: loaded Not tainted 6.6.33+ #6
> [  464.325477] RIP: 0010:__get_user_pages+0x423/0x520
> [  464.325515] Call Trace:
> [  464.325520]  <TASK>
> [  464.325523]  ? __get_user_pages+0x423/0x520
> [  464.325528]  ? __warn+0x81/0x130
> [  464.325536]  ? __get_user_pages+0x423/0x520
> [  464.325541]  ? report_bug+0x171/0x1a0
> [  464.325549]  ? handle_bug+0x3c/0x70
> [  464.325554]  ? exc_invalid_op+0x17/0x70
> [  464.325558]  ? asm_exc_invalid_op+0x1a/0x20
> [  464.325567]  ? __get_user_pages+0x423/0x520
> [  464.325575]  __gup_longterm_locked+0x212/0x7a0
> [  464.325583]  internal_get_user_pages_fast+0xfb/0x190
> [  464.325590]  pin_user_pages_fast+0x47/0x60
> [  464.325598]  sev_pin_memory+0xca/0x170 [kvm_amd]
> [  464.325616]  sev_mem_enc_register_region+0x81/0x130 [kvm_amd]
> 
> Per the analysis done by yangge, when starting the SEV virtual machine,
> it will call pin_user_pages_fast(..., FOLL_LONGTERM, ...) to pin the
> memory.  But the page is in CMA area, so fast GUP will fail then
> fallback to the slow path due to the longterm pinnalbe check in
> try_grab_folio().
> The slow path will try to pin the pages then migrate them out of CMA
> area.  But the slow path also uses try_grab_folio() to pin the page,
> it will also fail due to the same check then the above warning
> is triggered.
> 
> [1] https://lore.kernel.org/linux-mm/1719478388-31917-1-git-send-email-yangge1116@126.com/
> 
> Fixes: 57edfcfd3419 ("mm/gup: accelerate thp gup even for "pages != NULL"")
> Cc: <stable@vger.kernel.org> [6.6+]
> Reported-by: yangge <yangge1116@126.com>
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>

The patch itself looks mostly ok to me.

There's still some "cleanup" part mangled together, e.g., the real meat
should be avoiding the folio_is_longterm_pinnable() check in relevant
paths.  The rest (e.g. switch slow-gup / memfd pin to use folio_ref_add()
not try_get_folio(), and renames) could be good cleanups.

So a smaller fix might be doable, but again I don't have a strong opinion
here.

Thanks,

-- 
Peter Xu


