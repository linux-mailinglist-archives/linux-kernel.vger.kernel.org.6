Return-Path: <linux-kernel+bounces-518255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB2CA38C53
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1AEE3A363D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F60234970;
	Mon, 17 Feb 2025 19:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIcO2wEf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3C1158545
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739820321; cv=none; b=WP6jAQ8HfKkURRK3ECEKXKeajQ5/S2EPNiavfRrrTDDdBZujGO4dMktILwYDALVEAYuBz3LOpsUSBwcY03320M9FRd2msLl7q+/xTELe+LpCyRipDQaXXa8w9OvZ7Wt+Ka1S9JoYRsuC73kwiHrSkMOmE0cojlkI1bAJtQCTzZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739820321; c=relaxed/simple;
	bh=cWA7sKUdtTEsqml0tpOLDNxle82AACtVaehtyeywJXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRlx6gyhbAAGauxlEK/OjZLTjL+bIzf7p/31MWF9B5yPRBUIiSjr78S+kxtaAutiB8l6xw+NgeprBAk/vOZ6xCtAeh7Mz5/z4yPG1elhe2quwSz5XdxGtInNN5z0mGJhvF80AIDOwh09kigYqTOv2IFyk0mvBb8yzHhGH4J8+0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HIcO2wEf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739820318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KT9RP2oMKPjgNG7H76kGM+F77TKCs0EEHFt347YegMQ=;
	b=HIcO2wEfnmIXv/MBjI2A76AJpYYvwpHGReoUUB1RcF0m4bP71btGxXh9PzkvdeBCtVqEcZ
	Kjl7NF3klRytrTlf/XCKmfTIKdJutb5VLVtpwe8sY8BVmMPLnpROyPY6kYZZP38MBLeJT1
	k61P5iWiJvDZacWPRqoUYEZnootYGro=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-x1EnuJqZO8Gie3PpAkrrGA-1; Mon, 17 Feb 2025 14:25:17 -0500
X-MC-Unique: x1EnuJqZO8Gie3PpAkrrGA-1
X-Mimecast-MFC-AGG-ID: x1EnuJqZO8Gie3PpAkrrGA_1739820316
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6fb5bd3bcacso21544997b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:25:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739820316; x=1740425116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KT9RP2oMKPjgNG7H76kGM+F77TKCs0EEHFt347YegMQ=;
        b=gF21zsEDgT9zdnNXzD/uiY1Gwa4GcJqAeIHLbuYAOQQtknhUIh6UMpcMLE6SrjKVFy
         YG1dpLgTAALD/Rqa0jld471ksm7ZEoyHMNoLor0ZyfXYJ9uJD3Rq3ivpkFWNsh8tyT5K
         JoN5hpR8kSiAtxyzF32BwyPfYgUZbyGV1oxQxAblddWrD4czD+L/xixcaSDSBbpfWw20
         O0xCevucy622q/L1Z1lxLqqQ3I2jwMrUr0zF6D28nyI8LdRtlBmXi6rSTnyWHCLVv7MN
         RYYmMMsRxtA+vjbB8UCNKmpiGS68bNb58xvgSZqnzou37poYQOrCjeZBGEeeAKToa56u
         hjrg==
X-Gm-Message-State: AOJu0YzQ/lbtr+SPsvt5eRS3+POl6Yos/yhZ09CD62L5bpkSklDSKXJy
	BJUPdWwlmX0v2YAPRxVyFExdGwGxbGIRbi5MKNoUxwbXGXfOCUw5SEnPmhXegbNAjzcJik2UdGz
	uMLXLTD4r/PICgHagh634CAlgmNSYlcwyWQYPyKPxL8r6BzeO6jfyiClTwE98Ct2Auezt7uLo/x
	K+eFnNAYrDsyf8APGzQe32KKRLH7XxktK4pma3
X-Gm-Gg: ASbGncve4wWS0Nk0Qj+KC12FsZyzlgh0oFGQXdxRlFF+r66LsX3MH+x67SmmpSVL/L9
	dRW6uJTrL76LMEhg9jqKy2MRZyIq9Dwl3y7VdAQeNX2KfEFPlZk/k8RpTuuQkz/eiebwytc3qxt
	I=
X-Received: by 2002:a05:6902:120d:b0:e5d:f878:7b50 with SMTP id 3f1490d57ef6-e5df8787c7emr2021260276.23.1739820316619;
        Mon, 17 Feb 2025 11:25:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7Qe5QzycrNb9QKTC0wgZIxUHrerzUiu11f7E3qUQAW/QjwcTNFBX+3lLbhYw3w99GE9kvpp8qxN+GpNe1iSw=
X-Received: by 2002:a05:6902:120d:b0:e5d:f878:7b50 with SMTP id
 3f1490d57ef6-e5df8787c7emr2021235276.23.1739820316328; Mon, 17 Feb 2025
 11:25:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211004054.222931-1-npache@redhat.com> <20250211004054.222931-2-npache@redhat.com>
 <c4d7c1e0-e83b-4666-8bfb-1220b59251c2@gmail.com>
In-Reply-To: <c4d7c1e0-e83b-4666-8bfb-1220b59251c2@gmail.com>
From: Nico Pache <npache@redhat.com>
Date: Mon, 17 Feb 2025 12:24:50 -0700
X-Gm-Features: AWEUYZlXTbDyGUTQq_7TpVE0pYdfK9lEJauhIky2UmMOE2WpxTluduTbJgChv78
Message-ID: <CAA1CXcCg1EjY5fP=uR9EUpQtwXy1VJJEho8PA1VmG4E03tvBdg@mail.gmail.com>
Subject: Re: [RFC v2 1/5] mm: defer THP insertion to khugepaged
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, ryan.roberts@arm.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org, 
	vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com, 
	dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org, jack@suse.cz, 
	srivatsa@csail.mit.edu, haowenchao22@gmail.com, hughd@google.com, 
	aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com, 
	ioworker0@gmail.com, wangkefeng.wang@huawei.com, ziy@nvidia.com, 
	jglisse@google.com, surenb@google.com, vishal.moola@gmail.com, 
	zokeefe@google.com, zhengqi.arch@bytedance.com, jhubbard@nvidia.com, 
	21cnbao@gmail.com, willy@infradead.org, kirill.shutemov@linux.intel.com, 
	david@redhat.com, aarcange@redhat.com, raquini@redhat.com, dev.jain@arm.com, 
	sunnanyong@huawei.com, audra@redhat.com, akpm@linux-foundation.org, 
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com, tiwai@suse.de, 
	baolin.wang@linux.alibaba.com, corbet@lwn.net, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 7:59=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 11/02/2025 00:40, Nico Pache wrote:
> > setting /transparent_hugepages/enabled=3Dalways allows applications
> > to benefit from THPs without having to madvise. However, the pf handler
> > takes very few considerations to decide weather or not to actually use =
a
> > THP. This can lead to a lot of wasted memory. khugepaged only operates
> > on memory that was either allocated with enabled=3Dalways or MADV_HUGEP=
AGE.
> >
> > Introduce the ability to set enabled=3Ddefer, which will prevent THPs f=
rom
> > being allocated by the page fault handler unless madvise is set,
> > leaving it up to khugepaged to decide which allocations will collapse t=
o a
> > THP. This should allow applications to benefits from THPs, while curbin=
g
> > some of the memory waste.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  include/linux/huge_mm.h | 15 +++++++++++++--
> >  mm/huge_memory.c        | 31 +++++++++++++++++++++++++++----
> >  2 files changed, 40 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 93e509b6c00e..fb381ca720ea 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -44,6 +44,7 @@ enum transparent_hugepage_flag {
> >       TRANSPARENT_HUGEPAGE_UNSUPPORTED,
> >       TRANSPARENT_HUGEPAGE_FLAG,
> >       TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
> > +     TRANSPARENT_HUGEPAGE_DEFER_PF_INST_FLAG,
>
> No strong preference, but maybe just TRANSPARENT_HUGEPAGE_DEFER_FLAG migh=
t be better?

Not a bad idea, TRANSPARENT_HUGEPAGE_DEFER_PF_INST_FLAG is pretty long!
>


