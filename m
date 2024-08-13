Return-Path: <linux-kernel+bounces-285540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F35950F3A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912D628493F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809781A76DB;
	Tue, 13 Aug 2024 21:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KjT/scjd"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA761A76BB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723585294; cv=none; b=j77nJQZgYzVjVgLf3k4s/AQCZ3wuawk3dSBn6M9T3BdzD1P5ugN090e9LeDlUP1f4C7Ol3NjGo98u2uho2z7PFkyRGxDiNG2mVkU7+7Ok3L1IFOGlgO6BjD6DqKIrCGIp3pHam033FtOyzm7blctcbCkjjhNALp3vH9JMN8nQXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723585294; c=relaxed/simple;
	bh=NlaYgVLUQMjxBSw7Pa9XDmYAwLHfrOYpQGartspqsEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UincrXlzaBhZphFWca7u6PlSPfjLlZuUlrQiiUjwHGtY8IIHyVPT2etBICf2XC3uw4ax7n5jwwwSeRXL7FK0c1nqyYvzcYA8l4jAb5Z4C0kI7jKfbDQrudrVntQc7c+FMB5Q48MKFBiSHniE0GxwKw6ze1PhlLOkLy+IqyHGPCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KjT/scjd; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4f5153a3a73so2005311e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723585292; x=1724190092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNKxyCD3sL9Pw4tETI2CMJBPkS8nM7pR4jRQHwUDzl0=;
        b=KjT/scjdIU8gVcU3Z9moxPpUBliINT2ei1j/LQ7DhTr9Pw+oJmykv4BjBrlxxoOnPw
         CtvnRWKxEb6qhqQMdmxUEKdhiVBB4XCrG2+JUublmtL0D+DJLSFCGvm23fXZ5k7JOSxx
         JxEWvtfqJAV7PG7wkHAM83MAy63fqN8hCKJ1OLsKQ8lbsGXGAoRr5Ee5pHfPMCqN1JEF
         Jw88/0+GwyLhK4AcsHik4vlDFmQht9vsFGktrYkqKHjFUs5crczs8LJtVe6u9XcbN+/G
         7kUEzQOXlgXqUrd2QjrfiLnCAugLHompNN/4T1a8koXhLKRPe8mwVO4T7EI59nVowkM2
         n40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723585292; x=1724190092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNKxyCD3sL9Pw4tETI2CMJBPkS8nM7pR4jRQHwUDzl0=;
        b=EI4I57hPKCYzFZO52xM2ZipcKDvqtI+azNH9bc24v/hv8cBhF14vKgcOSk6IHdjrQN
         etOeGJdhHGk7L6Zc/tWDgiAlggFNvMI2wP9ct5kM4TMNK1xMvmZ+0dYPAjNU42Kg4X8o
         DpMWL4J/IMDpmkx480CZoi7caqimfyNTbPrgbzBXDUjW0RnFDDuXdeMQZInZU5QZGkPT
         qbtMlsUPIFz/6ZNJ2TKHEG/WXMY+FqaF9F9f62RLCIOADG2idTx8s+sgi1DssGsG/5Jx
         lGR8yU3E+s4yd7M3gizTaHclXMuuttxtWmIoejje4k8LRIjBqIpYnU+nPl0qQe3Rz0ww
         QYjA==
X-Forwarded-Encrypted: i=1; AJvYcCXKtFmMucWm9XekYJlGILEnEWfN5hRyPG8A1lA0wSp0aI09pFF3Zn/93xk89kUtpILNVL3DDXA2sq+ounoOIYo2kV7azAzW4kvKakaa
X-Gm-Message-State: AOJu0YzQoruWBOmZ3yXoFJxnEiQQc/mPS/lEZyTpZ0cZJThq7cD8iTZO
	x4Lo3s8exlbfpRFTxp51CQtYcKykiWjzYd74m+AyGl44OURlZGFNOojnks5L6l7y//5H88orQ+s
	Z2PiOYWow9n4LUfVQALLSOBqfh9BuTEbafscvFfA0vuU08utTBg==
X-Google-Smtp-Source: AGHT+IFfSvp9hKL/DBf+nQtcz5Qrf9LVeKWTmO/Ig+c7saqhe3JpHcjhAdhxNl48Tm/dhwF7GKWKraao4Zus39qM5iI=
X-Received: by 2002:a05:6122:2524:b0:4f5:199b:2a61 with SMTP id
 71dfb90a1353d-4fad23165a6mr1197419e0c.9.1723585291776; Tue, 13 Aug 2024
 14:41:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812224823.3914837-1-yuzhao@google.com> <20240813140007.2459882ce674b45ecf1403f7@linux-foundation.org>
In-Reply-To: <20240813140007.2459882ce674b45ecf1403f7@linux-foundation.org>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 13 Aug 2024 15:40:53 -0600
Message-ID: <CAOUHufb1MTZ2gmZhdev-X7frj4uBpp_84aGxNeVNq3640q7-xA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v2] mm/hugetlb_vmemmap: batch HVO work when demoting
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 3:00=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 12 Aug 2024 16:48:23 -0600 Yu Zhao <yuzhao@google.com> wrote:
>
> > Batch the HVO work, including de-HVO of the source and HVO of the
> > destination hugeTLB folios, to speed up demotion.
> >
> > After commit bd225530a4c7 ("mm/hugetlb_vmemmap: fix race with
> > speculative PFN walkers"), each request of HVO or de-HVO, batched or
> > not, invokes synchronize_rcu() once. For example, when not batched,
> > demoting one 1GB hugeTLB folio to 512 2MB hugeTLB folios invokes
> > synchronize_rcu() 513 times (1 de-HVO plus 512 HVO requests), whereas
> > when batched, only twice (1 de-HVO plus 1 HVO request). And the
> > performance difference between the two cases is significant, e.g.,
> >   echo 2048kB >/sys/kernel/mm/hugepages/hugepages-1048576kB/demote_size
> >   time echo 100 >/sys/kernel/mm/hugepages/hugepages-1048576kB/demote
> >
> > Before this patch:
> >   real     8m58.158s
> >   user     0m0.009s
> >   sys      0m5.900s
> >
> > After this patch:
> >   real     0m0.900s
> >   user     0m0.000s
> >   sys      0m0.851s
>
> That's a large change.  I assume the now-fixed regression was of
> similar magnitude?

Correct, and only the `real` time was regressed, due to
synchronize_rcu(); the `sys` time is an improvement, since it's not
affected by synchronize_rcu() (or not I could measure).

> > Note that this patch changes the behavior of the `demote` interface
> > when de-HVO fails. Before, the interface aborts immediately upon
> > failure; now, it tries to finish an entire batch, meaning it can make
> > extra progress if the rest of the batch contains folios that do not
> > need to de-HVO.
> >
> > Fixes: bd225530a4c7 ("mm/hugetlb_vmemmap: fix race with speculative PFN=
 walkers")
>
> Do we think we should add this to 6.10.x?  I do.

Agreed.

