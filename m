Return-Path: <linux-kernel+bounces-201171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF0A8FBA97
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19ADA1C2161F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199F9149E01;
	Tue,  4 Jun 2024 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CF5ZD1vl"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8D714A0AE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522519; cv=none; b=C0uFUyEp06TXtoPqgkFkQ9Uo+f7feyJeMwRjC+ncwqSBoitAXxP/ylMrHPggnVlCEOJ8escwl9tHe43Ns+GKdHbVS5BX5Fjsn5L4YyW53CChDAb+QP0BIaCxTfh3+WjLQhaLDFTdusFW/RoG/jIaGzGDilhMlVNn0iXNOv61lso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522519; c=relaxed/simple;
	bh=lxElhNb6+LLAOwSRzJUjOlUE1gCjxcVourbCmwIjDc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lc+vlXvY3R3aItql1my6aHv0UK2KjSjpP4bGwuotKtsl+6zSt4CT/0Mhy+H0DPRLoIsZ9ezfsT2aH0oO2OT4UYSZe5q5vZplmkcWQfEfKFupvOuFHVC9E6bHJdbzfSDT9YJhRhIjBdOdYst9mBL2w5a0Oj54hp6I7Fnl+sUJuBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CF5ZD1vl; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso88184a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 10:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717522516; x=1718127316; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QnqJOAf1Q2Nckvls20fL4xWcgC3Wkf+wvlijKAtyrII=;
        b=CF5ZD1vlubTegKWW+/xN5r+Y2tslC6HWVC2vtr+PfuHO6GZvA3FX/iLbFoN6vn2n9P
         dlt2z5DF2dWE4CUoRv8BJ608mscTyREWTs6MB3ML0akgWcFL5B5ZNsG2Q4nbrqlVq2yE
         ZWj0WMg6C+yRcEQcnp9jxDRuvcEucE4339p0FhKg2xT5YH32yA/eo0xN9stpF+Jl4WzT
         IT+8bpNjxCxG79Bt45g9O2lxtMKDZn/JvYaqR6dQrJKIolz5pXjDu+GzOt//Kf+HcIPd
         YwgAunk37OmZgrb62fC3vHlW5eyNEUQ020Urd20AlWbo17RJdR7+wvjttokvpsg34r3I
         9FLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717522516; x=1718127316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QnqJOAf1Q2Nckvls20fL4xWcgC3Wkf+wvlijKAtyrII=;
        b=GWvOZhondwlR3H2N9HjRbdJQYkC4crqkm/UiT5K6EYH6+a6eDHCexDOahoG0ulTXyY
         vr7Y0xBEXGkVZJitdRhryyqKXeD2ux+hr3NUQpGgJvJyilXyd1qiWn0a0ilSEOSCoJCi
         3JTxqugPanYi5JououkhQZY7ujTyq3xUMokOiWpxgNO/4mwg4qquHaV02EFm0A/xK0t8
         t6k/fLye/M91tMIi8AHjxzmfzoinZBA37rZYwbwUZvjD7JMzRXgdhf5oa1njWSJeffk5
         IsWEc66MIkuVKwPziLS1WrmB1gMP6h8Iw30PmDQTeV+NtXRTNsXmVi+NEVXbBu4wiqHG
         Xdhg==
X-Forwarded-Encrypted: i=1; AJvYcCUuCkrlTHi70As2Kr/nSX8K/7qZ+F9MyIRPMHBULJgHOiDAywEMCNB/aFtSkMZmAKxOB2DuZl0bFC4olos8UUH77qSJ9k6i9VuY++p/
X-Gm-Message-State: AOJu0YxuJL37QLp/hvUz2xhK9eyO+ErRSWlOY5oZmTqoOz/w/SuAmgJX
	sqJVraGoreYSL9noq/G58fKVeGaIFOXRf77aZHTK/Uttiwuxn4xqoxmZKXdtF5FqtwPsntoG5QP
	Wx5CHLjv2Pej2F6//sQHpY/xgjvc=
X-Google-Smtp-Source: AGHT+IHXpNuf2BcjrXTd+QUegb227fWnqENFLc7DunocDDJ5GF80C+wRoVoBVJRNKJ8qmzJC/IrELCqiSRzMfhrbbvQ=
X-Received: by 2002:a50:a414:0:b0:579:c37c:1b36 with SMTP id
 4fb4d7f45d1cf-57a8bcc896emr242557a12.17.1717522515985; Tue, 04 Jun 2024
 10:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZlpcRnuZUEYJJ0JA@x1n> <CAHbLzkrRw-xf819gYJwRQ=-u971LQYnB2FNJMkN=s6u-pJ4Z8g@mail.gmail.com>
 <CAHbLzkoB+oFTxtVYpeXQvko2q9HUVzUYrr83S6M6PUmXDQpkag@mail.gmail.com>
 <0edfcfed-e8c4-4c46-bbce-528c07084792@redhat.com> <Zl3cakfiRsPQDb8q@x1n>
 <8da12503-839d-459f-a2fa-4abd6d21935d@redhat.com> <Zl4m-sAhZknHOHdb@x1n>
 <9d9a5730-161b-4a9d-a696-1cf6d0c5123c@redhat.com> <Zl4vlGJsbHiahYil@x1n>
 <54ce029f-b16f-4607-bdf1-a1efe904029a@redhat.com> <821cf1d6-92b9-4ac4-bacc-d8f2364ac14f@paulmck-laptop>
In-Reply-To: <821cf1d6-92b9-4ac4-bacc-d8f2364ac14f@paulmck-laptop>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 4 Jun 2024 10:35:04 -0700
Message-ID: <CAHbLzkpuZx7cHoY6vLyetJ9T+KJrTKi1vt=wFv8YMhab7awDxQ@mail.gmail.com>
Subject: Re: [linus:master] [mm] efa7df3e3b: kernel_BUG_at_include/linux/page_ref.h
To: paulmck@kernel.org
Cc: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, 
	kernel test robot <oliver.sang@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, Rik van Riel <riel@surriel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Christopher Lameter <cl@linux.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

> >
> > I chased it further to:
> >
> > commit 8375ad98cc1defc36adf4a77d9ea1e71db51a371
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Mon Apr 29 15:06:13 2013 -0700
> >
> >     vm: adjust ifdef for TINY_RCU
> >     There is an ifdef in page_cache_get_speculative() that checks for !SMP
> >     and TREE_RCU, which has been an impossible combination since the advent
> >     of TINY_RCU.  The ifdef enables a fastpath that is valid when preemption
> >     is disabled by rcu_read_lock() in UP systems, which is the case when
> >     TINY_RCU is enabled.  This commit therefore adjusts the ifdef to
> >     generate the fastpath when TINY_RCU is enabled.
> >
> >
> > Where Paul explicitly restored that fastpath for TINY_RCU instead of removing that code.
> >
> > So maybe Paul can comment if that is still worth having. CCing him.
>
> It is currently an atomic operation either way, though the folio_ref_add()
> avoids full ordering, but that is immaterial on x86.  Some say that it is
> in the noise on server-class ARMv8 as well, though they have also said
> a great many things in the past.  But if that is true, the big benefit
> of the TINY_RCU check is that folio_ref_try_add_rcu() is guaranted not
> to fail in that case (single CPU with preemption disabled).  Except that
> everyone has to check the return value anyway, right?
>
> So the usual advice, unsatisfying though it might be, is to remove that
> #ifdef and see if anyone notices.
>
> After all, both 2013 and 2008 were quite some time ago.  ;-)

Thanks, Paul.

I will submit a patch to remove the #ifdef as the fix for the bug
report. And do the clean up in a separate patch which is preferred by
David.

>
>                                                         Thanx, Paul

