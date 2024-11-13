Return-Path: <linux-kernel+bounces-406966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA36A9C66C1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 02:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736EE285AB3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 01:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F0227456;
	Wed, 13 Nov 2024 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPB8r2ji"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4592217BD9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 01:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731461758; cv=none; b=JHDSK0M882HrR+B4sFOjIIA+u6TBgUHu/V9ONO2GtIqmN20ygDYfl4loZqbNIrI8Ff59vKfeug+jWb9rfRKBl2qEMVUrPrmlpAAjeYr2FapdK7BGmXTLKsaw7mwZ6zfwAZwYt5wqPiCABOBdpbwg9pqxWwckkBAHypcjKiVySF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731461758; c=relaxed/simple;
	bh=Hai8CbjxxvC65Grfw0z9wldwL8Fsqy9AZwn2qJq5h1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lsm5Vc813R8dneaDe9BijD2my3qg5fbOakdEP1QcZFzlJvsWYF8/RzIVvzoetSA0zj2pge/V8UM3wCyoagFYJ5c0gbaRJNvDEzp2MVnhIzlxTiABSJuhV/BFSey+oFYW5S3B8T/Afd+JsHAvdERMf6dM4WoitRcOiSodRa00MlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bPB8r2ji; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731461754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mGkqVBD/cl5HjbeUZbHpW2I5be/ruvQ0biy0GT7rtWM=;
	b=bPB8r2jikwZhj6I3VmCrQBEXqE+e/WEiXoIOMsjWZgtuDI++aqdEJrO6COlUCddadJSLui
	swdS9KW+cOHPCS3Rg1mPqCybIDVxpJQVuIFK7yNHvSLJIuvljzlQZ+Kgpj6HqtkP/EM/dI
	F+lhGVn3BRLyoJ8j5nUZhyR4TGjwpDw=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-iHACsJidPwePa56v2fi2UA-1; Tue, 12 Nov 2024 20:35:52 -0500
X-MC-Unique: iHACsJidPwePa56v2fi2UA-1
X-Mimecast-MFC-AGG-ID: iHACsJidPwePa56v2fi2UA
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-71e648910e9so8580990b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 17:35:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731461751; x=1732066551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGkqVBD/cl5HjbeUZbHpW2I5be/ruvQ0biy0GT7rtWM=;
        b=r4UQPC+QqV1Ni9khTAeJdr2w6LAWDqOthpS1nFxABbopd/s3pymxD7DzEVyRWpRc6H
         SRzL0t/AhG7kDa5oZQ7jv8gZb+cSy3XHN2ppSR6KixCDQsFEC01zao5OuwYYHasbL5uc
         BxF4DIoM9JzKuK5sgxKdN6slhdIPo0M3T5b2dKCtA0SLKujNWISVvIt9pNWTHxbyneEy
         JJVdTGQ4gfH4uC3A6JViahaakF912d7bf81UJwi6kdL2cGxCBmqrZ4L6bOeOS46LLHWw
         4e8t76lWA3hfrfyqgy6XMT4jDGPHnrKzbUWi6UeUPPQh8qrwfQ1eYTPhcA7fk3dHCUdO
         fTUg==
X-Forwarded-Encrypted: i=1; AJvYcCWuLgkdQQh9DBPfHJJu9G2PPqEXPUCcxLR1Mu1AArAVP6kHJrhLu29EqUe83xGGfnPxFDmcdfOzqDm7aJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUx0H+/pdTFxL0fERGm9CJOJBvbTIogpMYTPBtGYBdNBOzKhZw
	UNOi4wJhNPMsNOJE2V4HVwIiAjQBAtLCM6L917MZWTKtqWQXOVRqyazt8oZ7wuPeXi6CWSefSaY
	sdy8w5Bo+QGTQ2fGaJGAxV4OnMd0pyM1WwkMUu6/FE+0va39Xzn/4t6wJfD9FdZlY1kz/NVpUg3
	tgy8JKP8V4JINiAIIA4foWGJQjlVSf66SKFO4F
X-Received: by 2002:a05:6a21:339a:b0:1db:ec3e:c959 with SMTP id adf61e73a8af0-1dc2292f6fcmr26523383637.10.1731461751498;
        Tue, 12 Nov 2024 17:35:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZH7pMNwQm2PurwVVeyExbh2UXkF+eg1HiSNrj9jmjuk8eRgNriNhqFYzaWC3Qe2loS5SKWogSrS5vWm8Txp8=
X-Received: by 2002:a05:6a21:339a:b0:1db:ec3e:c959 with SMTP id
 adf61e73a8af0-1dc2292f6fcmr26523358637.10.1731461751071; Tue, 12 Nov 2024
 17:35:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111025538.2837-1-jasowang@redhat.com> <20241111022931-mutt-send-email-mst@kernel.org>
 <CACGkMEuCx=ht2Q75xJ11EGsjuZPWcTTpGh7OyVEHCOhGDB5f7A@mail.gmail.com> <20241112164527-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241112164527-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 13 Nov 2024 09:35:39 +0800
Message-ID: <CACGkMEt-mD8=wkTLua2-3c6bSYzWfp+m4TW8Pm_oe063gsWqMA@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: skip cpu sync when mapping fails
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 5:46=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Nov 11, 2024 at 04:36:52PM +0800, Jason Wang wrote:
> > On Mon, Nov 11, 2024 at 3:30=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Mon, Nov 11, 2024 at 10:55:38AM +0800, Jason Wang wrote:
> > > > There's no need to sync DMA for CPU on mapping errors. So this patc=
h
> > > > skips the CPU sync in the error handling path of DMA mapping.
> > > >
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >
> > > DMA sync is idempotent.
> > > Extra work for slow path.  Why do we bother?
> >
> > dma_map_sg() did this, since current virtio hack sg mappings to per
> > page mapping, we lose such optimization.
> >
> > Actually the path is not necessarily slowpath in some setups like
> > swiotlb or VDUSE.
> >
> > Thanks
>
> I don't get how it's not a slowpath. Example?

I'm not sure how to define slowpath but a possible example is when we
reach the swiotlb limitation, in this case. vring_map_one_sg() can
fail easily.

Thanks

>
> --
> MST
>
>


