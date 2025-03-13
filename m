Return-Path: <linux-kernel+bounces-560120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC8FA5FDFF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6BDC19C5582
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BCF1DACA7;
	Thu, 13 Mar 2025 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4m8IFSl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247651940A1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887382; cv=none; b=WczUyGTuH6yblHmBqO5FJuJsyWMQB43oGW5h13Df2Own/nZABrj1Zw6hVd4spEhPQM9bu77BH6innAucoVuWea8oCCFfxZTgyCupBTglbw1rjREqd/ABDXTG0FIu9VNprVuLyeUeXDZdVVtvJO4mENGTjyfzq2vi1SG1vGKJVAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887382; c=relaxed/simple;
	bh=74LdO3L2papOXx6onu8X7dux3CgaxYMbpnbfEZf5vfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYr/lnv/Q4DVCPJux0nSi9jmcgMzX+zoUvrHNUOKm0stjhKYbHkEbNnRttM8WQ3eex1EkV/ykBNj5Baw+kanrb/3o5mvbbKhmRQM4aa/UHQvNQZrXLSYKdnHrY9nGejHBniWkBKrBP0tu7Zkj8/UeF9LobxNtRJAqsX3cMppWwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K4m8IFSl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741887380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=74LdO3L2papOXx6onu8X7dux3CgaxYMbpnbfEZf5vfs=;
	b=K4m8IFSl+u1sxHRI19hDZU/eQJNFrjhXR3zPY0N6wjPdo8eXgI8ADrY56GA8WQHWpwN7PZ
	uGu9ASfCU8a+l4PhTWsxaCdncu+8Ixlzc1mHMFEVwlfRTo8Sh4bEp3YUFvo5Tz5fUaOO9m
	hk4CqZo+62K41BgBlOBlN4bheeyAJ8w=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-HGRLkXsfP9G-zmaaKivHOg-1; Thu, 13 Mar 2025 13:36:17 -0400
X-MC-Unique: HGRLkXsfP9G-zmaaKivHOg-1
X-Mimecast-MFC-AGG-ID: HGRLkXsfP9G-zmaaKivHOg_1741887377
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e549c458692so2084044276.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741887377; x=1742492177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74LdO3L2papOXx6onu8X7dux3CgaxYMbpnbfEZf5vfs=;
        b=jGGYSyviPloT4CsJyiKVd6Oy4762T9SF6KMAOWfYJtxo6GziOHKtmjlOpWeL/nmbTk
         MnQSbZK5r7WTtVElHhZvtVslG5uRSDz3aQzOQFCR07DZnFn/mFSWO/4Lrw+VGYvNEDu2
         dD3jpn62awHv1L3NiXq0QM2ZEreURpfao1E8+3AZZOZrt8hc8znjiLUdGkSh9C/w8lyQ
         LOswzoB6+EqYEahdqSRnse8Bp2lzgZZoUfecMmAzgpun9Fn/n31uTSFA/QTZ2icmcr+x
         7zgnWFtfU/UE7mXjKDLS4XzZiciwgkgRVQ+wEEmvGjcbIWDRRCVrAwCHQemFxDUPIv6M
         PwFw==
X-Forwarded-Encrypted: i=1; AJvYcCXPZBxAoIMkblG902oBXWfEkx5+E15N+9sFI0TbjZk7xNewbnFE+LUseaJvsTSEy6dtAaskXtduJ9AdAP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxja4aY2hgY8x2i4bkp5mjjpRHY/qgKUDAdCy8MQaj7ffg6RH+/
	Ib5dVAJ+xKxojoN0gWniJ5v/eVSoFaFZRJDRkm0lGa13F5w2aqEMYSDCV4CXR37rBb+ms5kWzrf
	/ZJQspGanJuC5DtB97jvFHzBBPQ9Nbq2Q4nzWEB4OSGHsBfWmWZf6C0ntGpZM0srdfKtfibactB
	mx6z53Gvlh5CbRuAEIatIHi4g2VOJTtj8E4kwo
X-Gm-Gg: ASbGnctvOYfHiTlgnTtxNCF27HAjGPEWAhXB38wLooBznrF1mMNd5yoHK2JFpjfJzF7
	Pkp2iWgbQ87P0i+AKjeaNu2+ZCiP3U6CKDkp8Y3V2wel/ASQSMouyZZEwVydvCzIreW5EXa1fv4
	CNxmPfihKNuw==
X-Received: by 2002:a05:6902:11cc:b0:e5d:d6b8:231d with SMTP id 3f1490d57ef6-e63f3c1ab89mr394088276.46.1741887377126;
        Thu, 13 Mar 2025 10:36:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESNapqN0/McTxEgf1yThn7lvo6wBYo3eRd0NunIcEjHGxMwrpjR53TwIJsg0lBT1jUk9YB7r7WxOStKAHssG0=
X-Received: by 2002:a05:6902:11cc:b0:e5d:d6b8:231d with SMTP id
 3f1490d57ef6-e63f3c1ab89mr394058276.46.1741887376762; Thu, 13 Mar 2025
 10:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312000700.184573-1-npache@redhat.com> <20250312000700.184573-2-npache@redhat.com>
 <c4229ea5-d991-4f5e-a0ff-45dce78a242a@redhat.com> <CAA1CXcCv20TW+Xgn18E0Jn1rbT003+3gR-KAxxE9GLzh=EHNmQ@mail.gmail.com>
 <e9570319-a766-40f6-a8ea-8d9af5f03f81@redhat.com>
In-Reply-To: <e9570319-a766-40f6-a8ea-8d9af5f03f81@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Thu, 13 Mar 2025 11:35:49 -0600
X-Gm-Features: AQ5f1JrzcM5gNtNPl-Fo_pToh0DelHZYtUioYU9wKMINK1ALGT_dvw_uu_EmSak
Message-ID: <CAA1CXcBsnbj1toxZNbks+NxrR_R_xuUb76X4ANin551Fi0WROA@mail.gmail.com>
Subject: Re: [RFC 1/5] meminfo: add a per node counter for balloon drivers
To: David Hildenbrand <david@redhat.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, jerrin.shaji-george@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de, 
	gregkh@linuxfoundation.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgross@suse.com, 
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com, 
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	nphamcs@gmail.com, yosry.ahmed@linux.dev, kanchana.p.sridhar@intel.com, 
	alexander.atanasov@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 2:22=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 13.03.25 00:04, Nico Pache wrote:
> > On Wed, Mar 12, 2025 at 4:19=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 12.03.25 01:06, Nico Pache wrote:
> >>> Add NR_BALLOON_PAGES counter to track memory used by balloon drivers =
and
> >>> expose it through /proc/meminfo and other memory reporting interfaces=
.
> >>
> >> In balloon_page_enqueue_one(), we perform a
> >>
> >> __count_vm_event(BALLOON_INFLATE)
> >>
> >> and in balloon_page_list_dequeue
> >>
> >> __count_vm_event(BALLOON_DEFLATE);
> >>
> >>
> >> Should we maybe simply do the per-node accounting similarly there?
> >
> > I think the issue is that some balloon drivers use the
> > balloon_compaction interface while others use their own.
> >
> > This would require unifying all the drivers under a single api which
> > may be tricky if they all have different behavior
>
> Why would that be required? Simply implement it in the balloon
> compaction logic, and in addition separately in the ones that don't
> implement it.

Ah ok that makes sense!

>
> That's the same as how we handle PageOffline today.
>
> In summary, we have
>
> virtio-balloon: balloon compaction
> hv-balloon: no balloon compaction
> xen-balloon: no balloon compaction
> vmx-balloon: balloon compaction
> pseries-cmm: balloon compaction

I'm having a hard time verifying this... it looks like only
vmx-balloon uses the balloon_compaction balloon_page_list_enqueue
function that calls balloon_page_enqueue_one.

>
> So you'd handle 3 balloon drivers in one go.
>
> (this series didn't touch pseries-cmm)
Ah I didn't realize that was a balloon driver. Ill add that one to the todo=
.
>
> --
> Cheers,
>
> David / dhildenb
>


