Return-Path: <linux-kernel+bounces-300791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A8B95E870
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271B91F21719
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF8F82877;
	Mon, 26 Aug 2024 06:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kaax4KJ3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900DA823D1
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 06:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653330; cv=none; b=K/Rfu/gBbIKKqL2uvrTE7SSACW+roCmrEJdZ5ejIVzw6gurQUfHF5v6t9tAGR4av2CbcUoBgzM1+1eettKdSYvY8yxwN1SxO7xCSET3baE6mRvlKKEbDTvPAYREOCzj9aG7DLKC5LYGEq2DDyNjBG6ij0y6qLrdhnIWvsXKUVwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653330; c=relaxed/simple;
	bh=W/orvY4d+MyuUZyg5aYI8nCoBLSyyGylJt1UrQHKaeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5jwp3xk1k+2iSujOv+ymgK6euPVYDqz+4WJUqWz8Awsmqt+t15UklMyxLcDT1hU2w4Ujvgc5WznBgdMQIvW3ZdbjSyPQbSLASDhDd7SiZIqEKNNJbZs5ttmYlyKEjlimZ3HvYd/0ja+agY0Ivd3L+eZiGTI4urcNDJAg5ak1rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kaax4KJ3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724653327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W/orvY4d+MyuUZyg5aYI8nCoBLSyyGylJt1UrQHKaeI=;
	b=Kaax4KJ3J+lp2GoD4OFIWkgUFi5aByLoYan8LHjEkMCaEqmBCAq3AqpXuorMAJLH+Pl7mv
	ZSgio3Kn4FfkNH65VFtuZ5sSC8fo7/Ju9os8HdXdNt9/y/0PLpgGm/8m1BNJroT5PO5xsB
	69TOnWqcKWdRsIolJYaUURbrMEB7xDA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-nsRwWS3tOEqY0OAV7n5x9A-1; Mon, 26 Aug 2024 02:22:05 -0400
X-MC-Unique: nsRwWS3tOEqY0OAV7n5x9A-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d3c89669a3so4905087a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 23:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724653324; x=1725258124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/orvY4d+MyuUZyg5aYI8nCoBLSyyGylJt1UrQHKaeI=;
        b=WfsGP0sOtmRJiWd5WbPpQ8auF09FIXIXZOagnEwv9mfbAK9hR6J7lKqSRuMwVdTpZT
         oVfxsD5Nu1I7LsnMt+klQ98mfXRWZZkwooq7IU7cBXSTULxlbf02sr8JL128zsoPn1WH
         3WbqUcffCLyjRgr4egufe3M5yJ8NdPeZqKerP06pODrFjhDcr1GmlC6f6U5s1aIcOpMZ
         WrUNL6mTvMNvQgPWmFSEzg0j0/CEcIC6Vhi10Mn5mZnhXA9uXMeXPQyjA5/6jKuwXM/n
         gwcDtb2ve5ki01DF/ZqjjiZbgpu+A7njVBqMcKu4JQhD1F9Npdi/JphKDptVNLH3GcHb
         BOkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw6mgWVQkkwsmSWAIrMzBVibpglXRMS0IE6mxL+NHBT6eTaZk0+Dcup5ePdg9uTwLNXvtorBM2rj1qatI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCTwVjPL1KqYxTOQyxqBAj2zVtg8D4m6DZI/KQAefdHq01SuQT
	s56r6T5FZ9IeRx1aP+ipb3G1aIsmqAjVolVAUSTIk+LRuGpEq+yQkrsyoj/9eGgL0e3d0PVf3Ik
	0Nl5l2l2TtD47CWewwFMyYD8CYY0EtPdmNcVU4msij8FFE6CxlYBMeAHzEwunwbg8tU0s+OUSlJ
	DgAqMsKsw4OyKCD1b/BkJNINCFbsfGWSnH5j3s
X-Received: by 2002:a17:90a:4d83:b0:2cf:28c1:4cc2 with SMTP id 98e67ed59e1d1-2d646bb9cd8mr11652457a91.3.1724653324439;
        Sun, 25 Aug 2024 23:22:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXJfj3XOMNpAgzpAtxdEftGfG0TOD+eVj11eYPkpG+vQJ2vtmQv/QzmjFQVGtWIG7U3tOa7tJOLAWR+r5s2LU=
X-Received: by 2002:a17:90a:4d83:b0:2cf:28c1:4cc2 with SMTP id
 98e67ed59e1d1-2d646bb9cd8mr11652440a91.3.1724653323932; Sun, 25 Aug 2024
 23:22:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819092851.441670-1-lulu@redhat.com> <20240819092851.441670-8-lulu@redhat.com>
 <ZsV17ACIEelIQuKx@infradead.org>
In-Reply-To: <ZsV17ACIEelIQuKx@infradead.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Aug 2024 14:21:52 +0800
Message-ID: <CACGkMEv=cQqXeLdsM1ivOFvUcG+-eOOwHE_BVQmF_scbqYxUpg@mail.gmail.com>
Subject: Re: [RFC 7/7] vhost: Add new UAPI to support changing Kthread mode
To: Christoph Hellwig <hch@infradead.org>
Cc: Cindy Lu <lulu@redhat.com>, mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 1:07=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Aug 19, 2024 at 05:27:33PM +0800, Cindy Lu wrote:
> > Add a new UAPI to support setting the vhost device to
> > use kthread mode. The user space application needs to use
> > VHOST_SET_USE_KTHREAD to set the mode.

I think we need a better name. Probably something like
VHOST_INHERIT_OWNER or others (not a native speaker)

> > This setting must
> > be set before VHOST_SET_OWNER is set.
>
> Usage of an API is a complete kernel internal detail that has absolutely
> no business being exposed to applications.
>
> What is the application visible behavior that the API use is the proxy
> for?

Vhost used to be created by kthreadd but some recent patches change it
to behave like being froked by the owner. So the various attributes
that interhit from the parent has been changed (scheduling and
namespace etc).

Thanks

>
>


