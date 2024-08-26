Return-Path: <linux-kernel+bounces-300831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA08D95E900
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190181C21A94
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05DF139D07;
	Mon, 26 Aug 2024 06:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6kGQxY4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B424C13213C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653955; cv=none; b=QX7maPbzhnekf3dzqTGEwYj6GM+nDaGikWD/e4hPbcsg61/Jozaw3a5JpHPRWqwKE/DAErxmFs/p/tM9CTzaEK1h02ZaH9eTG7/gw0TiiCaXJ2HkD8XWms3I/jpAA3arQKT3fyeGDmPZinFE2gMNPmKaxbFyAHJPOUj5A+bPP/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653955; c=relaxed/simple;
	bh=JESifInmWvZeQwWI8Jn8J0cYeIeDZ3prAXhvDlTsSj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elWLXqx21V7lcoGoqTtXNkF7LKx1qlYSdLstCafI9ok+qhTJaEks56esFrpgcXBm4XjMpElOuHOKiOC+IJNHBIP3FxR9Xr5AOmEQU9kDn2O9o3tG6+YHh8QfZ3mRdhiMkYj6mnGhiKavdtyUXpK70+WDiUAYgbHEKyzBTRBAMf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E6kGQxY4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724653952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JESifInmWvZeQwWI8Jn8J0cYeIeDZ3prAXhvDlTsSj8=;
	b=E6kGQxY4xYiApSOlxL+UwCD068R0rgW2rO3CvvjD0WWae/XH95I5/A3nD01OT3+h0l+NkD
	QNOTW9GQ9Pt3Ocp3hGp60v3xX2RNiyAByuxWXnGSMz0pwOf/pgt/rfjZikGNGfdNq8KN5O
	X0QK3iumZ6bIojjfODaFgcI3atBhU/k=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-PZ0onJcXOSWkVKq8E_tslQ-1; Mon, 26 Aug 2024 02:32:31 -0400
X-MC-Unique: PZ0onJcXOSWkVKq8E_tslQ-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-498cdceda97so1701032137.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 23:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724653950; x=1725258750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JESifInmWvZeQwWI8Jn8J0cYeIeDZ3prAXhvDlTsSj8=;
        b=JRF11z2vB83qdBKmxYO3vcHKbRQsIGkoVNhcMEUy+WCFXD3j+BtOqLU1TR5491nT1p
         qT+uCVkbGrwn8CjApws9FBq3O6jo8i3b735tt1vcEmEfpJg18MC4PguF03YaRtkTPSkO
         bmTiXGy94EP++OtoRX7YywM3j1Qn9FjB2WbLkHtQpXOkh4z1KDwtrgL3HHQ+BygOj86b
         LMj5u8Ce3hjv+KVayugzskM8y6479CxuhhhUoTmxmT1b5Y1qR41XRDQj7XjZS5OMjz++
         Jk2Y6BfKArpNDPTlCzMpflcvyUKBYWGJ4KeQyFvf5Ph/2GM7YDeIlDB/DF1XZmObHFSC
         MAzA==
X-Forwarded-Encrypted: i=1; AJvYcCU5pSuPbWOuh3RGsLdO9wFPl3bk5jetWVDAe3GVF5hw7BGE1pJRbMGoNfNMobHQHk9kSwquJFbSvkQEToM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAnEz4oyO5/Iqdkc2e3roDdTPwCNy8r5GU+n4tEfjFDT8bf3aP
	Blxa071jP1PQWUmAo7NupUL8oYCMUyNcVC6O7/4lpUfa9ihYwYbwBRFf52dwZdK3gvgaqZ7rZx/
	PS3WZ+u24nKblHVXk8CV9BRgfrwQVPY/6iH9MrgDrQBRTPHz7RY3ZLrYWMDIP6KFRHB1NJccaQ7
	jBAGndmvd6nUozFxOiyzvRb48opg8dPbloxyLR
X-Received: by 2002:a05:6102:3f0f:b0:498:cca9:8b3 with SMTP id ada2fe7eead31-498f4768d98mr6498546137.31.1724653950683;
        Sun, 25 Aug 2024 23:32:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwydcuFOVlgtFmwjWlxiF2u2xtiMO6UvY+/x7l/PEgUFs/udwBSaHF5gxdau0K58G8iWDDv631otNdoDoL8Rg=
X-Received: by 2002:a05:6102:3f0f:b0:498:cca9:8b3 with SMTP id
 ada2fe7eead31-498f4768d98mr6498530137.31.1724653950260; Sun, 25 Aug 2024
 23:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824035817.1163502-1-hch@lst.de> <CACGkMEsK8k=yX2ZytMJQhdZi4PS9-7KLUYmf2oGLu-UvNEYzug@mail.gmail.com>
 <CACGkMEu83MjTpkSS1mX02ar8RNDc5T4bsd4kkGHYhkH7LZY-wA@mail.gmail.com> <20240826063002.GA30266@lst.de>
In-Reply-To: <20240826063002.GA30266@lst.de>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Aug 2024 14:32:15 +0800
Message-ID: <CACGkMEvB20-iwNKepBdJBNAvxN-5+MduxnX6XDbPFsVA4hNz5A@mail.gmail.com>
Subject: Re: clearly mark DMA_OPS support as an architecture feasture
To: Christoph Hellwig <hch@lst.de>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, iommu@lists.linux.dev, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bingbu Cao <bingbu.cao@intel.com>, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-media@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 2:30=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Mon, Aug 26, 2024 at 02:27:27PM +0800, Jason Wang wrote:
> > Actually I meant, we can extend the virtio_config_ops to allow mapping
> > ops there, then simulator and VDUSE can hook the map ops there.
>
> From a quick glance that feels like the right layer of abstraction,
> although the config part of the name feels wrong at that point.

Right, or we could have a dedicated map_ops instead of trying to use
virtio_config_ops.

Thanks

>


