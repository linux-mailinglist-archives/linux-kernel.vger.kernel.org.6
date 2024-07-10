Return-Path: <linux-kernel+bounces-248099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6F592D869
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DEF91C21322
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F47196D80;
	Wed, 10 Jul 2024 18:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByHOYa/z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05397195B14
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 18:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636903; cv=none; b=ld7ZIxA3BklGnQGhjNiJSyXSVnkfrs4moQWb+tWPfwX+okDEHr5dL7YnZkDUmvUO8YIQ+iEHRjmMItz8uQdprFLkRitm4Km7LS/CKcO4z+JawRYkrRAyxGLD7gC3qWBmPKZVtU1qq47mVVtGiDcp1PEt2t3I6hdEfQfZN4BBxGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636903; c=relaxed/simple;
	bh=kFOZP6lI7AgDUHF0HVs5zGxIUNwq87ClOyIhyJ9v/Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqG91uwsK8/ht6XCvs1qH8EJdQ1cJURi1gsD2ZAkeaFMxGQ0wFZmAEsfCg2zWNGcR5+y5vb/4EYqArFUgaWN86ngwVfEQvSxdtpF9vj0dNc1hhDu2F9dOMUV1mXrwXE5CfctUzVzDwMsEgRH9oIC0OLE0VvVqqX/nZB7Ekou1oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ByHOYa/z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720636900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tpHbHafyRz1p56VJ6Fm5TcwApHDo2ZOEJ9cujlJzeok=;
	b=ByHOYa/zsONq+1Rx82oake8Hzol7Xn/G3Yu6ttxJNzGrqhLqRh887mgI1/ppWffdCMTOrN
	LGTJZB2Y1IWnT7h/9fEeu+VKVmrci/wl/rKlwfWgan7TDGMLlXC2bFr7+j40m4U+RF+2ST
	93eTComEp92MCyPo842WHNnm4m5J+/U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-T3xPEGmePIS5-_gY-jEPbA-1; Wed, 10 Jul 2024 14:41:39 -0400
X-MC-Unique: T3xPEGmePIS5-_gY-jEPbA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4272718b9b0so556865e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720636898; x=1721241698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpHbHafyRz1p56VJ6Fm5TcwApHDo2ZOEJ9cujlJzeok=;
        b=Ef7AKgJEJ1iGn9dPOWMDVnPdG7VzLc1JpkeXP08tBwVArpP/uqPs8CN5hLgtXahebZ
         DRflWrOKu6pte9Vpzhn4Ohbya2ju1F5lmcfjomL8J9JO8qbsab+jnxI3hXpnkNeREFuK
         F5ti3WSteGX0/iDzfdsV90lj3hlyDxrWlg3CCUaS+De4vCqXOZXkyB4eTvwFiBPatgOh
         G/vm4b68LxVPO9dxKYvUlOqX6EqMNIJudbXY9U+xJ3VA4+2Ea4I6JEnPO2O9fdaE6pMI
         jNA7qqHBSQiAdk+M98BOBlniZFLYt+rMfs+JBgEZ7KBQcbVq4XqueC4vVAaV9IszOzFo
         GbEg==
X-Gm-Message-State: AOJu0YwZZ1HddB0p35hNTMtXcjEnAJCHH4NlTCqVrOfJnK7S5pn2cCBU
	lsGLncoVdIiCP8gEsiniXNB/gXbQx9S5/KRmkRYWEjo1EAoTk/6/ZQfnY+G+EqHmcwWdQBy9ezn
	aUfZAx2KEoO47EYWYC+9r+nM3N5FoYBiEti47SrUICxoqa9aeK7OgDd5Ef10xcQ==
X-Received: by 2002:a05:600c:42cb:b0:421:7bed:5274 with SMTP id 5b1f17b1804b1-426707d88e9mr46372835e9.10.1720636898396;
        Wed, 10 Jul 2024 11:41:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7VKcxKMDhg9EZyXdQKrl1gUprzWqV7P/VmvC4BXJ1ELuvBe8gZ09LFEYckiyns6FkYstsqA==
X-Received: by 2002:a05:600c:42cb:b0:421:7bed:5274 with SMTP id 5b1f17b1804b1-426707d88e9mr46372765e9.10.1720636897880;
        Wed, 10 Jul 2024 11:41:37 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:f6ae:a6e3:8cbc:2cbd:b8ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab141sm5906585f8f.96.2024.07.10.11.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 11:41:37 -0700 (PDT)
Date: Wed, 10 Jul 2024 14:41:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 0/2] virtio-balloon: make it spec compliant
Message-ID: <20240710144053-mutt-send-email-mst@kernel.org>
References: <cover.1720611677.git.mst@redhat.com>
 <e9405f5d-2b43-40bf-b496-9eaae7c873c5@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9405f5d-2b43-40bf-b496-9eaae7c873c5@redhat.com>

On Wed, Jul 10, 2024 at 08:25:56PM +0200, David Hildenbrand wrote:
> On 10.07.24 13:42, Michael S. Tsirkin wrote:
> > Currently, if VIRTIO_BALLOON_F_FREE_PAGE_HINT is off but
> > VIRTIO_BALLOON_F_REPORTING is on, then the reporting vq
> > gets number 3 while spec says it's number 4.
> > It happens to work because the qemu virtio pci driver
> > is *also* out of spec.
> > 
> > To fix:
> > 1. add vq4 as per spec
> > 2. to help out the buggy qemu driver, if finding vqs fail,
> > try with vq3 as reporting.
> > 
> > Fixes: b0c504f15471 ("virtio-balloon: add support for providing free page reports to host")
> > Cc: "Alexander Duyck" <alexander.h.duyck@linux.intel.com>
> > Reported-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > Changes from v1:
> > 	rebased on vhost tip
> > 
> 
> Looks like you missed to include acks from me and Jason.
> 
> -- 
> Cheers,
> 
> David / dhildenb


indeed they are on lore but not in the mbox, weird. fixed - thanks
for pointing this out.


