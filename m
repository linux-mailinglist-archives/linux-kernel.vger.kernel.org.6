Return-Path: <linux-kernel+bounces-431750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8132E9E4112
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACFF161E3D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53936218EA7;
	Wed,  4 Dec 2024 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HqunS3Ip"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED89F20E711
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331702; cv=none; b=MzNLbHuPzBHj512IDReeTb8v1pg34gE06u9QrvVkbhbx8kXKOsrHC0R5T+hIcr0U8n07NGYg8u/yUZ9xZiz/BufK/z2NAxlkXRcp1lXX0ZIDqbYdoxMO3UChheZDSYIjTXDBb5Q4xGRXwnBQ1FtdBrjZB5YLbRdk9q3W/T7ibPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331702; c=relaxed/simple;
	bh=ZrlOkFUQYhIWJOetiFuAK2vLC+JxOCjuRnQUbkG0IO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3WKBdEG1Eph0UTs7K3c8koyyCl94KVEtJOu15bziTKOPW/dvaLsMf52EWU20NymxXvb9BHD/I5h41634NxitC34VKFvkzzIG/YmHlmkD9lN9qYRAb+jw+8aF7dKNioj/eT+A4uNgGZsKJ4jxenx9KgnWy57tFdZQc7PDP35UJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HqunS3Ip; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53e2091c383so2852e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 09:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733331699; x=1733936499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrlOkFUQYhIWJOetiFuAK2vLC+JxOCjuRnQUbkG0IO4=;
        b=HqunS3IpgVhoep/xhnhULQC6j+lfx81q2Z5bdb0m1g0gFSTt2lmFwA5QulDITDnz6O
         KclkikkqKBpPidbLyjXjPf8FtdWLu72ddhTPa0K/BtELescsAgdNpbJD1ROMgxnN8//s
         3jAj3KFj9Br61yFny5uR2kwNKAhg8osuzj+Tq7USCVpjaVBsuQE18Zbyi8unW1iv1QyA
         h5MJ4BegZTjsxh8hNMARymxzIte7P6pDBuhgptUfZ+S7sfR7vDe5+gZYn79uzs/u+F3v
         ol4RUSDz1WMISf6iSWgFhwLTBJmIUCHuyi8MkHFAL8pPeqyr/htOXgJUoJx80YumDL1j
         aqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733331699; x=1733936499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrlOkFUQYhIWJOetiFuAK2vLC+JxOCjuRnQUbkG0IO4=;
        b=TslEZnP8Z8rX5RezZO8s3DlUkl7da65KMYT8qPR7jlp8YgU4XlBaMYyDVa173OU/fv
         cjNghNajVdh3CKBn9CA8v7qytrIpYfQpvCHDKLcgb3jNlPZSjLfAvOmowNu0iiB6+JrW
         4v6tbKOT9eJIvTZ+u92s/MOlX1kJeQgkiqig3a8cT0mkCW09vif8VOYlIZxqcNJEO5O1
         Wc9aEM888MJe1WgabHrv1o40SroxTejSCC4tyswnsbmficQVspzIdhknojwQ+1noO/AG
         ArAlMg/xSNLNqi9DKWJcG5p8/Z8JUio8rI+b5TekRijdAhjHRg670r7acCKTlAo1WhuA
         hLWw==
X-Forwarded-Encrypted: i=1; AJvYcCWdxysY9EnNqW6y8koU7xZa/Jy1Bg6iWRd+E5WTBTQXmnYalSQN4D0yRKmKEFrP/Es9K56zOnBd6FsOFWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywr+kOBhnNA5e9l6TEx8mJWD1Fe3t97IAG7I5qW1oLlQ6k7xHF
	Zc2MX+GTUHqt7+WPNpSjNRpt0jkysrnD3AR4RqTxT56Um6y8EnXgUNylK11GnwEmR+8+xyRroTS
	tlLiiGhayDh3L4bBO6Bdcl4BqnEfrdoNqvCeO
X-Gm-Gg: ASbGncsspys6a/sflP7XZrEntX12L/89Fba3AIYErzPPhwQL0v0rf8f1rlWaNnEaJq6
	y7lBavU+NbA3QuxavIM745tx+iPoa
X-Google-Smtp-Source: AGHT+IFBqtc+TZMdEO3TjpxzkaycKSYs3PtWeWBfzgvpNYIDrcYDBXM9ysAGGTHByxdmCC7gKVzE61goA7/NjFDYNyM=
X-Received: by 2002:ac2:4bd1:0:b0:53d:e75c:9f9b with SMTP id
 2adb3069b0e04-53e1cab0f00mr201292e87.1.1733331697396; Wed, 04 Dec 2024
 09:01:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202202058.3249628-1-fvdl@google.com> <3tqmyo3qqaykszxmrmkaa3fo5hndc4ok6xrxozjvlmq5qjv4cs@2geqqedyfzcf>
 <87mshccnxr.fsf@oracle.com>
In-Reply-To: <87mshccnxr.fsf@oracle.com>
From: Frank van der Linden <fvdl@google.com>
Date: Wed, 4 Dec 2024 09:01:25 -0800
Message-ID: <CAPTztWbceW0dbCPVMw_maer8o_o851Jf-omOBCQkwwA9qQP2qg@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: optionally pre-zero hugetlb pages
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	Muchun Song <muchun.song@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 4:05=E2=80=AFPM Ankur Arora <ankur.a.arora@oracle.co=
m> wrote:
>
>
> Mateusz Guzik <mjguzik@gmail.com> writes:
>
> > On Mon, Dec 02, 2024 at 08:20:58PM +0000, Frank van der Linden wrote:
> >> Fresh hugetlb pages are zeroed out when they are faulted in,
> >> just like with all other page types. This can take up a good
> >> amount of time for larger page sizes (e.g. around 40
> >> milliseconds for a 1G page on a recent AMD-based system).
> >>
> >> This normally isn't a problem, since hugetlb pages are typically
> >> mapped by the application for a long time, and the initial
> >> delay when touching them isn't much of an issue.
> >>
> >> However, there are some use cases where a large number of hugetlb
> >> pages are touched when an application (such as a VM backed by these
> >> pages) starts. For 256 1G pages and 40ms per page, this would take
> >> 10 seconds, a noticeable delay.
> >
> > The current huge page zeroing code is not that great to begin with.
>
> Yeah definitely suboptimal. The current huge page zeroing code is
> both slow and it trashes the cache while zeroing.
>
> > There was a patchset posted some time ago to remedy at least some of it=
:
> > https://lore.kernel.org/all/20230830184958.2333078-1-ankur.a.arora@orac=
le.com/
> >
> > but it apparently fell through the cracks.
>
> As Joao mentioned that got side tracked due to the preempt-lazy stuff.
> Now that lazy is in, I plan to follow up on the zeroing work.
>
> > Any games with "background zeroing" are notoriously crappy and I would
> > argue one should exhaust other avenues before going there -- at the end
> > of the day the cost of zeroing will have to get paid.
>
> Yeah and the background zeroing has dual cost: the cost in CPU time plus
> the indirect cost to other processes due to the trashing of L3 etc.

I'm not sure what you mean here - any caching side effects of zeroing
happen regardless of who does it, right? It doesn't matter if it's a
kthread or the calling thread.

If you're concerned about the caching side effects in general, using
non-temporal instructions helps (e.g. movnti on x86). See the link I
mentioned for a patch that was sent years ago (
https://lore.kernel.org/all/20180725023728.44630-1-cannonmatthews@google.co=
m/
). Using movnti on x86 definitely helps performance (up to 50% in my
experiments). Which is great, but it still leaves considerable delay
for the use case I mentioned.

- Frank

