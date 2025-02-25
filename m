Return-Path: <linux-kernel+bounces-531350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2A9A43F6C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498B5189D36E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5740267731;
	Tue, 25 Feb 2025 12:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cl4uzAFT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EAA2571AD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740486674; cv=none; b=kPH1Mk8ogJQpgIloi53pcsWoefOQAIpaNahDN3JVICDJD85HA0duLek4G+2/2ZJLK0oM3RceTctVUEUYSK+6lqNUsuUT34MFTXmAya6AgWEP/S/aC8nXJtsTlgDwFCPKZUb6Rw8ZVDTSzLK7/aCgGQHFb8L+t+o5r6Z/TG1UNoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740486674; c=relaxed/simple;
	bh=epBzChFWqyXGC78otuPSiM2PC+xIZf6jGDfUxUyxyFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izl6a09CMOPfInLwZPS70xXys2ndJ/kwfvNJ1pizhFLBg5kZAtYtT6EQriuK8fTT07HnaKs2h9BlhV/OLzVs8X9+VrC5hu+a0jhua6LmWXO9eEVCIn3Xi4CJYtQPYIxATN3VDNwAfOLZ8M4TG6SXCT3hKPv+LChWnOdZvsicytQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cl4uzAFT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740486670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKyNSexWiDKwCqu9HObEPednC2sw0nkOY/VAAlgGvIY=;
	b=cl4uzAFT9aHEUpDHYm+Jn/C0/KRc32crCqV2B/LXHks1wBEObBbv3tFoXumDF0XlGa+Of5
	r5WsQFv9/urffQy+uFXVg0p0TuFhCIeuyVAlOWGeyxTDi3N8n1CcLY2OhpJxubN23rQDzZ
	OTZFSM7L0fZAamLnp4IsAdbFrjWlvpw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-w_AlnDQ6MWKdhzpjCRok2w-1; Tue, 25 Feb 2025 07:31:09 -0500
X-MC-Unique: w_AlnDQ6MWKdhzpjCRok2w-1
X-Mimecast-MFC-AGG-ID: w_AlnDQ6MWKdhzpjCRok2w_1740486668
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4398e841963so44713235e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 04:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740486668; x=1741091468;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oKyNSexWiDKwCqu9HObEPednC2sw0nkOY/VAAlgGvIY=;
        b=BMT15++Ew108iHBJ3THqLdU7k/JDwqzx3s/QpKT1BPpOiKDPmwNY0xZeGkhxvR3kW6
         2aB7V7axnE1+Zs0bnA3FIV8D0CD3A4+NYSzq7l0k180JCVYfJnrZE9jGuqtzxd7uKKCb
         rXSVfE2E8OsKGLhP8SqzFmlVCs2OwhqbBavAwvHG1GUdo0/yGSFqkecm/kV85hRjiQxt
         3JPtccB7CBnfptEkNBhyBZY5VGRPa9gM/FV0AcCofyamc6RLl/p9UCxPQRLGwl1Eoos7
         BE2AHdHtE4Aldj+7s6O4SGOweONqhwvdqR0U6rYV7M1N3pwlrN2LcHc1RbzKy+aw9o5u
         8dYg==
X-Forwarded-Encrypted: i=1; AJvYcCUu/85d/cTPVn3DEphXEKYEItVwkLvXyNSSDqYSBhI1QObAbM5QdnEGJ0uUvm32MptV7AMXH2fJz+4Asls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvH9pYHJTB3TEN4XJuwvd04n6QR7ZeK8nCAbIMLF8YvQxaaine
	mdYbjqOikhcz+VA+K8npSBGmGGlEYhpYCYSuwcpkSUBzQiHRfI/LcUe/7p+2tiq4BPD3tMdVzTS
	wV1//e39CpooPW6wwxOBxJsXHU/D7zdMQfY5uC0FIMLo2u5pCBtWDelSL1LTwZw==
X-Gm-Gg: ASbGncv6MFzdpt+S5SDRvJJyB/vc4SV7UILAF1r8FY8t3h1DRGnfKXhZRTArY5j5Hlx
	k1Aq73ygPBXlD1TFkJoMqD3y0yupv7fOX2YihftSCJV3LDjypRga0JN+GByLzm+pJT1tzGnPpuV
	HwsnwVPo1FXfG326W2kI+N0KdKuCbrCtK07qf8KDHHa0JmLFkPHzrAJrA99kVL3WxoNQu9IHaqq
	kjoSQK8PySxw+A56bEdu2TvdsSqtIzJ83o9OYEfRfMZ5Ri9Bnuz1ifcuU5ikyzel3GmRuh0IwjZ
X-Received: by 2002:a05:600c:1c16:b0:439:8346:506b with SMTP id 5b1f17b1804b1-439aebb2e0fmr135928455e9.19.1740486667907;
        Tue, 25 Feb 2025 04:31:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8IQnXGA03kjD9l5gPzLgfWvd950pwDLmUbGGnKrhkB4ZzLB2aleYySGlP1eeJx4R7L/lfNw==
X-Received: by 2002:a05:600c:1c16:b0:439:8346:506b with SMTP id 5b1f17b1804b1-439aebb2e0fmr135928265e9.19.1740486667515;
        Tue, 25 Feb 2025 04:31:07 -0800 (PST)
Received: from redhat.com ([2.52.7.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd882644sm2100289f8f.42.2025.02.25.04.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 04:31:06 -0800 (PST)
Date: Tue, 25 Feb 2025 07:31:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Hanna Reitz <hreitz@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	German Maglione <gmaglione@redhat.com>, stefanha@redhat.com
Subject: Re: [PATCH] vduse: add virtio_fs to allowed dev id
Message-ID: <20250225072222-mutt-send-email-mst@kernel.org>
References: <20250121103346.1030165-1-eperezma@redhat.com>
 <20250224164956-mutt-send-email-mst@kernel.org>
 <CAJaqyWfir7+oVtC3Z+eC+jbDxkACs0J9a4-wnx_dgU5VeFhr8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWfir7+oVtC3Z+eC+jbDxkACs0J9a4-wnx_dgU5VeFhr8A@mail.gmail.com>

On Tue, Feb 25, 2025 at 01:17:02PM +0100, Eugenio Perez Martin wrote:
> On Mon, Feb 24, 2025 at 10:51 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jan 21, 2025 at 11:33:46AM +0100, Eugenio Pérez wrote:
> > > A VDUSE device that implements virtiofs device works fine just by
> > > adding the device id to the whitelist.
> > >
> > > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> >
> >
> > OK, but the commit log really should say why
> > you are doing this.
> 
> Sure I can expand on the motivation.
> 
> Something like "Allowing VDUSE FS type allows to build filesystems
> that run in userspace and can be presented transparently to the host
> and the guest. After modifying userland's libfuse, this allows to
> expose a good amount to already available userland FS through vDPA."
> 
> I'd add using the high performance virtio protocol but I still need to
> do more tests for this TBH.
> 
> > And also why is it safe.
> >
> 
> Can you expand on the scenarios you think this is insecure? While I
> understand it's security sensitive, you already need root to perform
> vdpa device operations. Is FS different from net or block?
> 
> Thanks!

I did not say it was insecure, just that you need to explain the
security considerations in the commit log.
The issue is that when one gave access to vdpa user device previously
it would only allow mounting blk now a filesystem.

Net is different, it is gated by CAP_NET_ADMIN.

When net was introduced, selinux was there initially then it
was deferred and never surfaced.
Maybe we should revive it so it is possible to control which
devices can be created in a granular way.

> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > index 7ae99691efdf..6a9a37351310 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -144,6 +144,7 @@ static struct workqueue_struct *vduse_irq_bound_wq;
> > >  static u32 allowed_device_id[] = {
> > >       VIRTIO_ID_BLOCK,
> > >       VIRTIO_ID_NET,
> > > +     VIRTIO_ID_FS,
> > >  };
> > >
> > >  static inline struct vduse_dev *vdpa_to_vduse(struct vdpa_device *vdpa)
> > > --
> > > 2.48.1
> >


