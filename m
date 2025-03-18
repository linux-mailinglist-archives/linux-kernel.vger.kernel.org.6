Return-Path: <linux-kernel+bounces-566705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D8CA67B87
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871CA421733
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28712212B31;
	Tue, 18 Mar 2025 18:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZijYjm++"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AC81A9B52
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 18:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320945; cv=none; b=qGLzO8rt9MTjtHasekU6KsmDs1+p5/upkRbjWD0PW+IVPMIoejM9uAYe2pe+odj8XqiRtHZ3c7Bpy3hIqXlMF47rafz+l10rf3bVPs7Vage9be7Cr07LBCkTpt6AJHjnZ44lfh6ZSexKc1Wa6bsEAkUj/tIXcqrj4p20DwTHs4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320945; c=relaxed/simple;
	bh=BjcYVEKKpUzz2FsrjqEYaGy5upsDyp7dXMD/jUWpPEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1pKloMDVM7SGQFmAXiRJyVpb+QGn4vOUYuPfhwQ6n4MMAEFV684niYuz6tKUwIaXpQo5B3u1PAjW4MtI35oSpA81ny+mxmVwYBfU+kkNCGFLArYdbxdFZ2aXYh296oMnCvq5L7jEQaJT6YxDrGE5301iZIl7jj4h1IbFz664Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZijYjm++; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742320942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qlRKauU87C/lC5/9zx115U/gNR/bBnOd+yZH1lsjrlY=;
	b=ZijYjm++7qeNKLUGlv2uh/rPc964Xqe94eQC8znHrH6UBa0u+LMGIizTBqh0eqPLtWm25s
	jgEhD5blbxQxi7lW3xuxFsB6GhhtRekAcNlz9GbV6oU4W2JINpKk5vmkJcseok/pOI5bUw
	Yq8NIdC3H3ur8D0DfhCczAx5Y7jjChE=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-q_OPzyaTMVSxDOHEDt-caA-1; Tue, 18 Mar 2025 14:02:21 -0400
X-MC-Unique: q_OPzyaTMVSxDOHEDt-caA-1
X-Mimecast-MFC-AGG-ID: q_OPzyaTMVSxDOHEDt-caA_1742320941
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e3a0f608b88so7542804276.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742320941; x=1742925741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qlRKauU87C/lC5/9zx115U/gNR/bBnOd+yZH1lsjrlY=;
        b=XLBTK0Z4X1/9WgmxfJqhyDvqzyFPrbX81Yu0d8WE+cObrLJJ6vbNSF8GJT2kpuJfHv
         e5WTKxXwPArOkcTega5YWZhS3y0QbArivZcHzwPIU+jXCn+blsBGtONHQutO+yYzDrhG
         y2STNYxhI64O+vjnGw2a3IC+/ndTwa+0+5We7RDiYcR9RyBlFfsMbfvH/U5Nn4uzeTyN
         vJ5n708Y3sDnjRLSDHwnV+MKO4bZNBS4Pm4DCp7Lvr88qQMUlRveu8m4M86Jlk4zlHQv
         KlGAbVlG5VOqpYLCgGGaNQxaqsUXAEyz2QxhYM3dZPNX4ROiA7dlRLwU2k2WPyfXxKEF
         DMgg==
X-Gm-Message-State: AOJu0YzZzWFBeGBPum/78a1T62s7ii78H1NLMZ9OJvKSGAtpCGLPJmv/
	X4UfXkmY4iQSRffsMuzKfcv/isIQ3Sy+IHJv8NX/gN6364WgxcZ3t1IxYzk2Q1/kgOxqE3gaplk
	y6i3jD8vP7w5vWfRxZtMb5r7OVIlchXKNYsFyHqvlawucRJECIKqYWpDUmYiuUaM98DJOiwn+UV
	l5PTYZHgk6qCoudRALtMzelsWN1SxtfkiK7nAx
X-Gm-Gg: ASbGncva/L5d7gD+l35ME3GSrUIDQ1R1phd0n88I8sMIk8Qw4dKyAO+hBYtxE43qtyD
	lLpBX1PudggSFQEP0b0qXWlu2ZSvkCRxljm2UZMugo7YnTZqRbpaL3Vt1TJ16n37+mM+XX38/eI
	wpTzRrT80Cbg==
X-Received: by 2002:a05:6902:230a:b0:e60:a2e2:9359 with SMTP id 3f1490d57ef6-e6678ef846fmr311884276.3.1742320939551;
        Tue, 18 Mar 2025 11:02:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf71qxvLWsxGimRT+uGjSq1Z0p53QdA8cl8alstSBpREqHbGhALnJb5uq3wRaeZHh2Md4lHGIZ8rqQbUzgZjw=
X-Received: by 2002:a05:6902:230a:b0:e60:a2e2:9359 with SMTP id
 3f1490d57ef6-e6678ef846fmr311841276.3.1742320939131; Tue, 18 Mar 2025
 11:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317230403.79632-1-npache@redhat.com> <e2807c0f-c6db-4946-a731-009d34c2c72e@redhat.com>
In-Reply-To: <e2807c0f-c6db-4946-a731-009d34c2c72e@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Tue, 18 Mar 2025 12:01:53 -0600
X-Gm-Features: AQ5f1Jqld-DTVBJ5lnYhAbXgkaFBEnpnySW3WxHs_U8l1d99uleiybSQ_j4TBT0
Message-ID: <CAA1CXcAr+rjZmzbzHSuvCDqyfi6wW1-32c6_3isZMSr-qM7DLw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Add "Unaccepted" meminfo entry
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kirill.shutemov@linux.intel.com, corbet@lwn.net, 
	akpm@linux-foundation.org, surenb@google.com, pasha.tatashin@soleen.com, 
	catalin.marinas@arm.com, jeffxu@chromium.org, andrii@kernel.org, 
	xu.xin16@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 2:42=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 18.03.25 00:04, Nico Pache wrote:
> > Commit dcdfdd40fa82 ("mm: Add support for unaccepted memory") added a
> > entry to meminfo but did not document it in the proc.rst file.
> >
> > This counter tracks the amount of "Unaccepted" guest memory for some
> > Virtual Machine platforms, such as Intel TDX or AMD SEV-SNP.
> >
> > Add the missing entry in the documentation.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >   Documentation/filesystems/proc.rst | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesys=
tems/proc.rst
> > index 09f0aed5a08b..8fcf19c31b18 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -1060,6 +1060,7 @@ Example output. You may not have all of these fie=
lds.
> >       FilePmdMapped:         0 kB
> >       CmaTotal:              0 kB
> >       CmaFree:               0 kB
> > +    Unaccepted:            0 kB
> >       HugePages_Total:       0
> >       HugePages_Free:        0
> >       HugePages_Rsvd:        0
> > @@ -1228,6 +1229,8 @@ CmaTotal
> >                 Memory reserved for the Contiguous Memory Allocator (CM=
A)
> >   CmaFree
> >                 Free remaining memory in the CMA reserves
> > +Unaccepted
> > +              Memory that has not been accepted by the guest
>
> I was wondering if we could be clearer like
>
> "Memory that has not been accepted. Especially in some confidential VM
> implementations, memory must be accepted manually by the guest OS before
> it can be used the first time."
I actually grappled with the description for longer than I'd like to
admit lol. I wanted to add more but *most* others left the description
short-- so I tried to make it short too.
>
> In any case
>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!
>
> --
> Cheers,
>
> David / dhildenb
>


