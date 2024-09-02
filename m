Return-Path: <linux-kernel+bounces-311976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19108969041
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 01:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B2EDB22E32
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 23:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86F618890E;
	Mon,  2 Sep 2024 22:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="OgjklD4r";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="JZyEnDuW"
Received: from mx-lax3-3.ucr.edu (mx-lax3-3.ucr.edu [169.235.156.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CB1188900
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 22:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725317790; cv=none; b=HjlWLsaYGX9uLvKBSc2w9xrEj6eI6sh5CdxCJ6+D/kuK4XLOFmXKDenNnoom2iv50OWGCIhvW6y5hjFYGXgOUoYXl6bSelEOCLmN7VUZT8mKpLswNILsmsSYXzn3j7+cy/rIXPZBELfI4emHAJxd4FqhymQHNPw4CPGtPLGrHWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725317790; c=relaxed/simple;
	bh=yAJ7mL/Sp0fk/eJFks7XQxmneL8mSZYdIXNTHdZlWrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7FUKBSSalpGsYc6rAJ5uYZHakQ+VmK5nBZwLYXQwTLc+9etvTyHC0BCXRutyKjXzdGngQAiBwMiLKiwEWnJkOjfyiu5hdWdk00lwrZSwEFEp95HXcD1whsbGrb0qBb+7lhbGgBYBI2t9depF/ACzv5zvPlkYZWF6cmG+dOsDuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=OgjklD4r; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=JZyEnDuW; arc=none smtp.client-ip=169.235.156.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1725317789; x=1756853789;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=yAJ7mL/Sp0fk/eJFks7XQxmneL8mSZYdIXNTHdZlWrE=;
  b=OgjklD4refchPWDu44XJrkGf0+Zo/65pGt2fsKvsRt9e9JVCs/KJPTjg
   NPpSvTtXScR8NwQWQcfQv+CKHlC7dt0tdUjW9ZmvWHsl7zMxNV4m7HCmW
   EGDSj1uxQc/c7lmesMPLYbQCYcquURTWOJWbhbGJW6yIJU1ytndvH8ZT+
   2J/FEXgvTAijmGR1lVDsPt6wI/OYyICQc5Z0S9Og0MLE1qvwVciPWKKi/
   gQ9xBIEwasSU1kYprGSlV4LGZ5sdWWd1AHIxzNeUeeJ/v2Oi11BMToIqk
   8lwuZOdGEupdVXZ37kqsvHJgmIW1593FuWyZOIF+7mvRSmq0FG3k8RdrX
   g==;
X-CSE-ConnectionGUID: E0bZjah2TJebRsgHiIZHKw==
X-CSE-MsgGUID: PO8InZ0mQm62AHMgOG/sAg==
Received: from mail-pg1-f197.google.com ([209.85.215.197])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 02 Sep 2024 15:56:22 -0700
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7163489149fso4600270a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 15:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1725317782; x=1725922582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfVylBxiv5MiwfE8nXoYEVmTAC2pbYflrAHpnkB5/w4=;
        b=JZyEnDuWhrX0k8UwFTkJok0H6KC0Mnb8L2qJpkG7aCEfMH8sSJXzLrj2FdgkzVM7xM
         SyzI5LvDC98lmjWaaFehSW/EiZnfSBbDxwVk9J9pyxGQ7tTLKS0WnsJ1CCe+7pAzaLFv
         iBeZ+pEzBFdas6qVJEl3dqyX4IJOzPGhSFgY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725317782; x=1725922582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfVylBxiv5MiwfE8nXoYEVmTAC2pbYflrAHpnkB5/w4=;
        b=riTLy1h+ilkFAcs9YdUQh432dzKniIt6ne1Xjq8DKXl6nT3KL50dYTOr1psWLNt9fU
         AM9/VYQvU4+ob5nUBvpqQTWSwsxLIrJ05pvbs+vSbF0U4ufcTJX4qPIaak9VmePepZU8
         qel/iOo+LDrk0qvT+Ue4iOTj6VwQ+rLHsrsLtIB7d+ZjBB079HbM+tPmfm3AV5aGoFKm
         uOgMp3F5aSDlzr+wK/Roxc7XrPs2GimHJXeoeftD01hrcdLjGyEOZ4dTudhN/ZMrY2Hy
         XQzZeOrywScsTIEUv0WpUezR8hNKHiX1HFAJ+EWbmrvNdVLQ47H0KJRBrxkPP2235Gdw
         a9zA==
X-Forwarded-Encrypted: i=1; AJvYcCXdZ10aMI2OZ7Tf3NS8ExwF6BG+pIP8b4NsGqavPWEpukqIsHQXdDlgXvHq5RjXmZr6h0nJ5tnniLsmDUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnh9Z8qp9P5/tynshmSykuYlGTXuCU+x1a+M4L6L4mnCmtcHjG
	zjNFirvMiFCdpx/pSNVk284NuAR2SDriS6w3V92mbSrWHQ5YdWIur+8Lu1G3285gCrFbv87hAKa
	s+ExOz0WtS/nS6gojP2okk6zpo7IqPl4kTTeu8k6IZuVYSvWq2gQFCUyZscVDgxjt67aCPmsC7R
	VgeIsZFos3O+djPYrMdq2UvfHOgVmVr8JDaOv/Fg==
X-Received: by 2002:a17:902:c40e:b0:202:28b1:9f34 with SMTP id d9443c01a7336-2050c4bc092mr178650745ad.56.1725317781847;
        Mon, 02 Sep 2024 15:56:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1HO09XxKMB0+zFXl4VxUm6TRVedsZ05NYoVdJPwBNKUbh1rO/anvKMeLHvqVQ8SJJzE8Rf7jeaNjztVq61RQ=
X-Received: by 2002:a17:902:c40e:b0:202:28b1:9f34 with SMTP id
 d9443c01a7336-2050c4bc092mr178650625ad.56.1725317781524; Mon, 02 Sep 2024
 15:56:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-5cKJnWRsS_2rjL1P9pC0dbNX66b8x09p=DUx1kD+p6PQ@mail.gmail.com>
 <87cylm76f1.ffs@tglx>
In-Reply-To: <87cylm76f1.ffs@tglx>
From: Xingyu Li <xli399@ucr.edu>
Date: Mon, 2 Sep 2024 15:56:10 -0700
Message-ID: <CALAgD-5bYOefCpNw1jcYwJtjZcy4OGzmXaNRhc8gKndBusNrhA@mail.gmail.com>
Subject: Re: BUG: INFO: trying to register non-static key in call_timer_fn
To: Thomas Gleixner <tglx@linutronix.de>
Cc: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, Yu Hao <yhao016@ucr.edu>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Without exact kernel version, config and reproduction
instructions this is not really helpful.

It is on Linux 6.10. Here is the config:
https://gist.github.com/TomAPU/64f5db0fe976a3e94a6dd2b621887cdd
It is compiled by clang version 14.0.0
(https://github.com/llvm/llvm-project.git
329fda39c507e8740978d10458451dcdb21563be).

On Mon, Sep 2, 2024 at 2:26=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Wed, Aug 28 2024 at 17:16, Xingyu Li wrote:
> > We found a bug in Linux 6.10 using syzkaller. It is possibly a
> > corrupted list  bug.
> > The reproducer is
> > https://gist.github.com/freexxxyyy/4c465c7d81957779d8bdea44f6cb8977
>
> Again. Without exact kernel version, config and reproduction
> instructions this is not really helpful.
>
> > The bug report is:
> >
> > Syzkaller hit 'INFO: trying to register non-static key in call_timer_fn=
' bug.
> >
> > INFO: trying to register non-static key.
> > The code is fine but needs lockdep annotation, or maybe
> > you didn't initialize this object before use?
>
> That's simply not possible.
>
> > list_add corruption. prev is NULL.
>
> > Call Trace:
> >  <IRQ>
> >  __list_add_valid include/linux/list.h:88 [inline]
> >  __list_add include/linux/list.h:150 [inline]
> >  list_add_tail include/linux/list.h:183 [inline]
> >  insert_work+0x114/0x320 kernel/workqueue.c:2212
> >  __queue_work+0xb61/0xce0 kernel/workqueue.c:2360
> >  queue_work_on+0x18a/0x2d0 kernel/workqueue.c:2411
>
> So that looks similar to the other unexplainable report
>
>   https://lore.kernel.org/all/CALAgD-7TsMdA7rjxfpheXc=3DMNqikEXY9TZNxJt4z=
9vm6Yfs5qQ@mail.gmail.com
>
> and smells like memory corruption of some sort, which then triggers
> non-sensical issues in other code.
>
> Thanks,
>
>         tglx



--=20
Yours sincerely,
Xingyu

