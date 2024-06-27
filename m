Return-Path: <linux-kernel+bounces-233098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A800291B239
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606C4280EFB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2242B1A2563;
	Thu, 27 Jun 2024 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="az+ZGsAL"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4444DA08
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 22:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719527408; cv=none; b=XqsgEOMiz1m4jIY2y6uKB3xgyU7Hu3IuJgF0KEJ+zJKrTr90D5+FSyE+UEzuVDxlytmPJv5uVp71zF2zwjetsrBIxfKSsbBxvgyn8v0hr/5bPfnA23mg8Q+AJoNYiE38I8sV3VrEZuuafvUZgwZQpUN1fSGpwIaSZR1LkNhZe6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719527408; c=relaxed/simple;
	bh=HcyGdqt/gX06JwJoqPzkza1WBlJNkLrMIzBBpYgzoSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mH1bQ/J8Vu3sMtnRxwU+L7PnkSouofD04grMNa9zFEXB9O6n3luXCLlRKvkJrlyjc97LLj0e+WZKTyqMNycuDfsc+UcFfi7sHHjPcT8duo9wMymBbXGPtvrypkFwSlCz/Pf+49JN44HP7apT0uxalYi188mNhQAutlzaYtsT0+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=az+ZGsAL; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4255f915611so9215e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 15:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719527405; x=1720132205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58qVww7f0rf9S4s7uhywaPpaUHviHgiTVylBLsqtTzQ=;
        b=az+ZGsALn23nnfXa97TndEjVsyDK4K2+6JblHDdgwIsaRrmbj0xZ2r583jAh8ZbgB+
         MugcmKF65MtxQPDxFY1SOctOu2ld0A4zDt09RqTPQJ3IUtw2BvFGfL+ts915WC7bMYL2
         N5a0tWoYFhp54wGssFclvfcISrYByxozUt26Il0/42Ng6SStXbhgF52peWimEtlnR1Vz
         5HJ9KBWXqUWqNf3pjx8ZWno+ohFUa84u3Mu0eHEYOn7yxtQGFg+cij5Ui7b+Uw9/8vxp
         /sVTrVG5QEASo4KAZg93Jt+KqJLF7QhQuPLzibGn0M/SIN9dDzE6kM2RedMoAtuHGjVa
         qVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719527405; x=1720132205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58qVww7f0rf9S4s7uhywaPpaUHviHgiTVylBLsqtTzQ=;
        b=wuadiqidooSRjOkVz6Q56OTXdNpP3Cm4dNncXXl8QPPM3x9PTmV4XYFtZdPAr3cl5w
         Q5HTgOmDHQHtbNwaspLRLMsccSEUvQdruMwlADekqsXlDazulipyUi0CfWdQ4XpDkaIY
         2K/uFSRhbdMGGdiXbn3K9nvK6XfiCmp633dYTiszcKy5YojxUuniOAj5iegx0qyav4hA
         5O+QEj8C7XMFRhf3/6ft1FH7vp/2vACxDjFChi5TjUD83OQcgX0r7A892il8qZlt6t36
         rpkxv8MEO+hi4rnAYC74EZt0rHJLzNNwW+bL8HAyk15xtFSsYGTHob2HUij2Xb/XNO6k
         VbgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ+k5wFEQXGtph2pNkkmydO60IXKClhg4vcqUFHdGCBQsdg8O9g0R05VFkii4p3gINjJ+XXpXWapkCnNvAALuiSRRXbw9JiaG2kwmE
X-Gm-Message-State: AOJu0YyVhKO9vSDN95gTFiFpTfmsuecQGhFLF+13lz5mrJenYtMuPG1a
	SnDl72AQP7ILrBd2yySjU0OEHTeTpNqu5rcSZhWXvBZOegHxj/+Whj7tqVPsEKvOaxA1gqYD3XZ
	tO/re4z5dTQtRRvRJYs13fTsC2xxrz++0blWp
X-Google-Smtp-Source: AGHT+IHMew38O538uLnlg7SpZpTHY59xmxUx61uW+Hjbg9Utnj+/9MBmXx14QwI2eDPC3JVBfRAAOzdk4zR/xoQg8As=
X-Received: by 2002:a05:600c:4f4f:b0:424:8b0c:156a with SMTP id
 5b1f17b1804b1-4256b737260mr621875e9.2.1719527404944; Thu, 27 Jun 2024
 15:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627044335.2698578-1-yuzhao@google.com> <379a225a-3e26-4adc-9add-b4d931c55a9a@linux.dev>
In-Reply-To: <379a225a-3e26-4adc-9add-b4d931c55a9a@linux.dev>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 27 Jun 2024 16:29:28 -0600
Message-ID: <CAOUHufYwau7a_dj6zmB1tYGvVO6CD0G9Dd4eCyAih87u4a-b2A@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1] mm/hugetlb_vmemmap: fix race with
 speculative PFN walkers
To: Muchun Song <muchun.song@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Frank van der Linden <fvdl@google.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Peter Xu <peterx@redhat.com>, 
	Yang Shi <yang@os.amperecomputing.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 1:25=E2=80=AFAM Muchun Song <muchun.song@linux.dev>=
 wrote:
>
>
>
> On 2024/6/27 12:43, Yu Zhao wrote:
> > While investigating HVO for THPs [1], it turns out that speculative
> > PFN walkers like compaction can race with vmemmap modifications, e.g.,
> >
> >    CPU 1 (vmemmap modifier)         CPU 2 (speculative PFN walker)
> >    -------------------------------  ------------------------------
> >    Allocates an LRU folio page1
> >                                     Sees page1
> >    Frees page1
> >
> >    Allocates a hugeTLB folio page2
> >    (page1 being a tail of page2)
> >
> >    Updates vmemmap mapping page1
> >                                     get_page_unless_zero(page1)
> >
> > Even though page1->_refcount is zero after HVO, get_page_unless_zero()
> > can still try to modify this read-only field, resulting in a crash.
> >
> > An independent report [2] confirmed this race.
> >
> > There are two discussed approaches to fix this race:
> > 1. Make RO vmemmap RW so that get_page_unless_zero() can fail without
> >     triggering a PF.
> > 2. Use RCU to make sure get_page_unless_zero() either sees zero
> >     page->_refcount through the old vmemmap or non-zero page->_refcount
> >     through the new one.
> >
> > The second approach is preferred here because:
> > 1. It can prevent illegal modifications to struct page[] that has been
> >     HVO'ed;
> > 2. It can be generalized, in a way similar to ZERO_PAGE(), to fix
> >     similar races in other places, e.g., arch_remove_memory() on x86
> >     [3], which frees vmemmap mapping offlined struct page[].
> >
> > While adding synchronize_rcu(), the goal is to be surgical, rather
> > than optimized. Specifically, calls to synchronize_rcu() on the error
> > handling paths can be coalesced, but it is not done for the sake of
> > Simplicity: noticeably, this fix removes ~50% more lines than it adds.
>
> I suggest adding some user-visible effect here like for use
> case of nr_overcommit_hugepages, synchronize_rcu() will make
> this use case worse.
>
> >
> > [1] https://lore.kernel.org/20240229183436.4110845-4-yuzhao@google.com/
> > [2] https://lore.kernel.org/917FFC7F-0615-44DD-90EE-9F85F8EA9974@linux.=
dev/
> > [3] https://lore.kernel.org/be130a96-a27e-4240-ad78-776802f57cad@redhat=
.com/
> >
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
>
> Acked-by: Muchun Song <muchun.song@linux.dev>
>
> A nit below.

Thanks for reviewing!

I've addressed all your suggestions in v2.

