Return-Path: <linux-kernel+bounces-540972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF60A4B716
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586B916D0B4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1696F1DE4F1;
	Mon,  3 Mar 2025 04:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHSJUXbS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CEE18B494
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 04:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740974819; cv=none; b=bXOjBKzZh2q48MlI3MfwsXNJsCTx83oVK3O6wooUhzB3ITsUcuZnndxami7Bu2F9k9D0L4aPJpZER1DSMWxVfgwxOWAleRaNf4cemVt1Lx7VmG4gJQrCzEOIk56b/up3tWO9K5WPFp/R/EgxK8odi/M3fZ/Qd//CNTeUqRm5XYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740974819; c=relaxed/simple;
	bh=1wzdOirKyTsZVCC1Ram2ZbDslf5ecQQUi0CW6qdxLA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4DZ0hW5nmGGX2B8hMyfFTevIhyi3tuG6T/OSVMEQZRGXymWmbA7jGR+Ky0RU2ma2cm7+SVnWYshasjIcYj8bs+xReVpNCXjmZ0S02v+mXcyqIscAtZcj3n3qOtU66OIMiUwhkHI6F6085eTFvfvKNQF02DFvlfwKyBJrQbDxxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WHSJUXbS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740974816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1wzdOirKyTsZVCC1Ram2ZbDslf5ecQQUi0CW6qdxLA4=;
	b=WHSJUXbSm2fbGF5IcKAPEJjIRRO/97ZOvN2lEr38Kanh2tWVmDmR6FzdLdNtnbHf5ILRkd
	yWBxaF9SlH4vhMwpbSsCBX2xEoedY8vzZL5w5Dxs8C2yLL0ToG30g+kiFi/ecn6Y+wxB9j
	qw1QeZ/YBo85jP8WR7eKDMA88kVfwcA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-FDZLSt5jMoC4T3jzjl9ENA-1; Sun, 02 Mar 2025 23:06:50 -0500
X-MC-Unique: FDZLSt5jMoC4T3jzjl9ENA-1
X-Mimecast-MFC-AGG-ID: FDZLSt5jMoC4T3jzjl9ENA_1740974809
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-abf75d77447so84705966b.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 20:06:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740974809; x=1741579609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wzdOirKyTsZVCC1Ram2ZbDslf5ecQQUi0CW6qdxLA4=;
        b=WGW6TNJHm7cX9jXqXKfXqVSBg+h4fEmUZnSS/Eyko1fR5DF/MHHE0Imayhpe6HB7wq
         LExFspy+QfWZmLom4C2KaBdhT4X94NmprcMJmsFfymvF5ISDdh3w5p88wrz9WGkPV474
         buAdlfPIce7ZjEYxyardbXGoL7Jt/ZSKOqeb0G44ViNsu0CLBujQotBmRW25d3e/FMoK
         3Wco2+Y99a/qLJWHQHtHw9unHESqdQOFlyRu6bCBzRvYrCirC6caMYXCo2F6a492WIj5
         Nv83RxVJywW9TDvJHOaq3cI8esZ0VO5l9X+pAa9VmUwJ5UM2sUhVRhSWdbeDyReBoiBB
         Z2uA==
X-Forwarded-Encrypted: i=1; AJvYcCVwjovk8LrBtLx4WCWkhNbC5Uyy4VF/6bxVBOZYghvHXoCpnf6zm73Ddp+/ceGfCDcCcJuad1yWVVolSog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdWFLNrx7g8TknNwR3PevLXKziwYQTNtOq8gMpmV6esnRQPK3q
	K7ySJ+3G+PKKaoKTGxcXbNKlderHppwv+oZH92pgj1ifATMZHfZBiih9qIejB/4lKRKRo5llbrk
	8xY2ZKcB/0VApT//BkZscsT0ugkEZPZF/hWjTGLxYfOD4JBgyHjduXu/tYr3x4RyjLkXa1P2z2U
	+G4UecCgBh4m0BQPUNkQb+WrIXC37ch+hWpVFL
X-Gm-Gg: ASbGnct6iZ1xF6Qt3TjcHxuow9mSJ8Rlrc1PJa2Dch3vfIRiUDy/0w3JF7+BB3zliWF
	E6ODlC961cfAbs2MUbvwVYIsKFPPOcaphjqL8F2zDtoLLhxKHetd6LUqq0nG7lmCyq6NghKjYEQ
	==
X-Received: by 2002:a17:907:6d27:b0:abf:7a26:c485 with SMTP id a640c23a62f3a-abf7a26c67fmr190820866b.50.1740974809383;
        Sun, 02 Mar 2025 20:06:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmtrdRGgr7U86+kr7f7l+xUDJuXUAyByaCCPcM629oXjBKkXRBVGvEXjN66jpswo1w8JgxuIRD6C81df5Lbfo=
X-Received: by 2002:a17:907:6d27:b0:abf:7a26:c485 with SMTP id
 a640c23a62f3a-abf7a26c67fmr190819866b.50.1740974809047; Sun, 02 Mar 2025
 20:06:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220193732.521462-2-dtatulea@nvidia.com> <CACGkMEuUsh-wH=fWPp66XAFeE_xux-drf1gatSQSiGuS_rO_zQ@mail.gmail.com>
In-Reply-To: <CACGkMEuUsh-wH=fWPp66XAFeE_xux-drf1gatSQSiGuS_rO_zQ@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 3 Mar 2025 12:06:11 +0800
X-Gm-Features: AQ5f1JqUG0YYBVOhwWGb6YuP75KRc_vcIL7Lh2pD9dN004pjvXLXIThnUsVJvbs
Message-ID: <CAPpAL=zfKkWD8BVio__qHezhs-UDht6rq7mp6Rn5Z-tQG8RW6w@mail.gmail.com>
Subject: Re: [PATCH vhost v2] vdpa/mlx5: Fix oversized null mkey longer than 32bit
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, stable@vger.kernel.org, 
	Jason Wang <jasowang@redhat.com>, Cong Meng <cong.meng@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this patch with virtio-net and mlx5 vdpa regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Fri, Feb 21, 2025 at 9:13=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Feb 21, 2025 at 3:40=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.c=
om> wrote:
> >
> > From: Si-Wei Liu <si-wei.liu@oracle.com>
> >
> > create_user_mr() has correct code to count the number of null keys
> > used to fill in a hole for the memory map. However, fill_indir()
> > does not follow the same to cap the range up to the 1GB limit
> > correspondingly. Fill in more null keys for the gaps in between,
> > so that null keys are correctly populated.
> >
> > Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
> > Cc: stable@vger.kernel.org
> > Reported-by: Cong Meng <cong.meng@oracle.com>
> > Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
>
>


