Return-Path: <linux-kernel+bounces-530399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5056EA432F4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 03:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56BA189E313
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9530912C544;
	Tue, 25 Feb 2025 02:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAHoyD4N"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6821CAB3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740450105; cv=none; b=LB2PCmHgOMhXYk673iiP5YF6AYhhbm56TZEdWDNzG6IxJtNMcmubD1JJfIMsWC+WNJowxtrZiQ6oVLahW1qKVwpmNfRK3Qt5FN7if7d8HXSICuR/0uDxg6uAwSe9IjuLHzad5F3qwg1vtYlTIvMtriWIyGxA4xFlSSHTRj87G+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740450105; c=relaxed/simple;
	bh=JFIMsaljc/OsNF2ji0aIKwRyKe88J0Fe7e6NSM1ldg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1UFoLZbvBzL+IeAjpBsmnvSZVe+P+o4rSiHDajxN8GTzHmkMJWZaZ6S7jMQq1H1sSZXrAlWojcJ5Sq5scWWwMnJFJrh6tGX3O8UnUWIOjGZkzUVw6SLWVDePqHQBZcbR/VmgTamJ/j7nBBm2R5v86TGSmd3Q6dMStvadd4mRqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAHoyD4N; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-219f8263ae0so106936055ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740450102; x=1741054902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HN9Mi/04d7rm3C5xy1wbndrq4MdUVMimL5fYGZEmdkw=;
        b=eAHoyD4NddhRM+VMaIRfbuuoKuVBNrQ2JuWetH9RydTcvw2AZzA7pxMLAwmlq440tB
         4s5gp2AUGaWhx/AMtM0WXa7ev5Z99YgKUi/FMIO8WB1z0fiZmDrYaDKuv2HUKmL+1Pbx
         NoXHFuMj7jmEKFSpWkYaCdMt+Pfz8M/UXTZNKarR8VtPI6DOGl3MSvv7tcC+rU6UihGn
         ney7CkMJQM5XMJc0X9i/b9gBaLCWhWsDpCun9ejKwU+CrdJ6UgTj2ofjEHz5D6A+sLgF
         Uh4m427RzEtI2vixNzvKCtsDhTcavM9BwssdJ/1IXz0I1SE3SvfsQevOE/CCImrn3FNJ
         VjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740450102; x=1741054902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HN9Mi/04d7rm3C5xy1wbndrq4MdUVMimL5fYGZEmdkw=;
        b=Icv4XItuQhXCmrlSKBIRt+WIxnPChFAMo+6YXBjPmbdx6vpwONEHXN6Za3CFksneyE
         LhN5xdv4dPqIoiB2DAUfJF1g5RDtKrqz5E2wj/mCPeOb+YZiZE6aIOPgTyAD8SMnz8z9
         byaPLzrBINeTZtgxu8dWL1LeZa/G5O5uQhdnRyUJ5E419xEYtLqe1WNqBxmPxWfCCz+b
         XXDo5phmc4yP0d9Co7jl6sJQKdJYGi3Z8N70B0pe9MBYXGRSy94ohyH1RokGmvVfWfZ/
         whMRAxgPfhlxHxlZ3PKyJJr8Zgw5skQCtaZg6jms1MWZy4ZuMNJqv2LcVOf48LaKun67
         AClQ==
X-Gm-Message-State: AOJu0YwOckbByJvWpY1DMrY0h/XZnWTIL5uM0EjWJD32llNWc1huRo1T
	GcrVJxmVo7lUUai00MyZlglKVcLJdfBa5FFISGQxhxzxI95kIYNub8/wYg==
X-Gm-Gg: ASbGncsNledvlk13IAzx4PLMit3mjAgntfInCxLB9f90p6AYXG8j3QNC0tSK2hm3d/P
	2KDcdWtbbPv7r7YNPcN22ifVqL7Rfk8X/Hu7C/sQcRV4mSCUgHHhWH53tDlc5wYQB4IlR5QXVnL
	kSwPRLwNroxnRNyMlzmSOWC7K4znzA/SyyPlC45tU2IkhJ6VjdlLq2qgNWqoEc5rj0RYnNS8Gan
	qaFAyUKFiw23DmS8C7I71GCZJHVpvNCKT4sh9WKiJO717iuR3X/OMXrdtKeNPlIzHuhF0OPIC2o
	jz4MOpOP2MMRoaE+XurVgMSRhC/XCPrZB3EoWaY=
X-Google-Smtp-Source: AGHT+IEEnytOBAspW2sSUQO7iG5hpqakqNkGD+X2+WwdvqSIByvUT58T+TrNd8qv8kmZZUlsAwTdZg==
X-Received: by 2002:a05:6a00:190e:b0:730:87b2:e839 with SMTP id d2e1a72fcca58-73426d8ff83mr28720259b3a.21.1740450102531;
        Mon, 24 Feb 2025 18:21:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6f9006sm352150b3a.57.2025.02.24.18.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 18:21:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 24 Feb 2025 18:21:40 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.14-rc4
Message-ID: <035ff595-8277-4680-a64e-a1bd8c141e04@roeck-us.net>
References: <CAHk-=wi9Aa_sgCjSncJ7odZX_f=v5WZwWm+GuwXmVy1O+wiBsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi9Aa_sgCjSncJ7odZX_f=v5WZwWm+GuwXmVy1O+wiBsw@mail.gmail.com>

On Sun, Feb 23, 2025 at 12:49:22PM -0800, Linus Torvalds wrote:
> This continues to be the right kind of "boring" release: nothing in
> particular stands out in rc4.
> 
> We've got all the usual driver fixes (ok, let networking than usual,
> but gpu, sound, nvme, you name it, but it won't be huge), various
> smaller filesystem fixes (xfs, smb, netfs, cachefs), core kernel and
> networking fixes.
> 
> And all of it looks pretty small and non-threatening. The biggest
> single patch is just a new self test.
> 
> So - knock wood - 6.14 looks to be on track, with everything looking good.
> 
> Please keep testing,
> 

Time for a report.

Build results:
	total: 161 pass: 161 fail: 0
Qemu test results:
	total: 619 pass: 619 fail: 0
Unit test results:
	pass: 565894 fail: 0

I recently enabled boot tests with PREEMPT_RT enabled. This triggers some
tracebacks in older network drivers. Nothing special, though, so I won't
provide details here. For those interested, preliminary fixes for two of
the problems are available in my 'fixes' branch at
git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git.

b364dd4ed219 possible circular locking dependency backtrace seen when enabling PREEMPT_RT
8571385b8fbf lockdep: Don't disable interrupts on RT in disable_irq_nosync_lockdep.*()

Guenter

