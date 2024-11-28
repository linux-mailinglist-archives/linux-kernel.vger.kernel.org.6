Return-Path: <linux-kernel+bounces-424646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 642089DB76B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E04284244
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9C719CC11;
	Thu, 28 Nov 2024 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRGsSDQX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A79156661
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732796291; cv=none; b=VxiyFRwV6clddfLrd3hdnM/PSiXFhzNLKQ0f7fkulJKUh8x84fW2A/XKc7tyek27BWu5y56QR/wdai7Bft0ooFgOiq3FxYfkPFotxdAHugXtN9twmfwYHpdXo1Ewk1O9vJs8eCt6WYsNzHV6DzBqrrHmdwzgG8+bk+erEgmu3vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732796291; c=relaxed/simple;
	bh=942roQ/1+TfMOBDOWcXjD8zVhh/75iK+muTdlxjUtbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsKxyO3uay7mMowd0ACZQSGkZ2xKZpjMIKW0FecZNI1oEF6PodnQxIYeNjnHNil3vNIKsy09JZFcb4/1Mo6/FgrJdmgj6BYkJ+49no1vVQwJgUFY9kU6KtqUsd7D+mjJnjB+WNVSa4ZFj7E1x9PU6d3MqF8++4TywBDjsOHAxR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TRGsSDQX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732796288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kGyj1e0U3ksoyTpdyLxwMT3YZEpvLvZfOMIvSoDLwpI=;
	b=TRGsSDQXpUPr/NuURnFq+TVQoFIHN1Md2/tdVzeHCTOvQgSWiIJu/x8bNiJakBmBfFO2Zn
	gbBgbUSNUQvN7gzeVbAqulYX4Pj4kM2U2/wBW+lauYcZqWL8GFVRnm3aTepLOnAa5gYehK
	OcNRh9s8feeK1dlchfClO/pHpLHUS5o=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-YPikAxx0PCeaGNseKtPhLQ-1; Thu, 28 Nov 2024 07:18:07 -0500
X-MC-Unique: YPikAxx0PCeaGNseKtPhLQ-1
X-Mimecast-MFC-AGG-ID: YPikAxx0PCeaGNseKtPhLQ
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5cfcc48b20bso418987a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 04:18:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732796286; x=1733401086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGyj1e0U3ksoyTpdyLxwMT3YZEpvLvZfOMIvSoDLwpI=;
        b=T4vICvbyRj7P4JmHHtH+X5Hr/9SXdXK2bwseuNC/PfCkkfWLJOE6C2EmuzE2uvxiR4
         pJLs/Xmb+iLGBtHDqhq8GvmjSkzJGv7uWxWUOVf6obrTzUX9fSJx38gOsWMh9Klb6iU7
         uZglo27FoOA3gaLaffKLI/EQXg9IG3kBVE3Gozfzras36IducEHfJICLlKz3eJPym/rS
         Pvqi0ZMfxKh+0E/afLnXQsbWSYpTKqAg3w6yYc5JiOQOqyNw5b5kUCqIOfxwDe2/E7kz
         PTFM3GoXZHadfSO+lp8ezoxTWXpUesDb8KopPrYiTs4Ee3rYpIXFqBOeLD9bNQUw+r/Z
         fxQA==
X-Forwarded-Encrypted: i=1; AJvYcCWHrNEp/30cmypF2cSL4TO+DIYGWeZ8fAXVUIutO74XKxva4aPv2141jmzIQmJRo/NCrZkJ8A/B4HNMwzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu7jdPaq/icVxRqK1mdzvM//4k2d2oomLMBYNxrNLeBN6Tr+KU
	iblS40khSBHvu5NB6eesp+ge7M/gMZDF4E4dIxRuUod4moxN3r1TxellzUH7YWB4Jtp5YYwnORN
	Pb5iMzSW5mi/AZ3uiJL/zZgwCK1UT72g8WQOHl2VPgKmuCNdG3AX03bhe0VMAkt20m/AxVr8Ic1
	ZDynHKw/1HR7Cq3IjwIrUa9KbcowvWUQ6ZsKFHiqiDu1MQayE=
X-Gm-Gg: ASbGncuL5tyUk6bV06N8dXCPFaCfvqXvocnxi9s4MpnqHEXjzHKuvD0MtdCbQXOu9D4
	aZuVUoZCMVLXBvQvqB6dZWsYqto3ZWJg=
X-Received: by 2002:a05:6402:368:b0:5d0:819b:3ee8 with SMTP id 4fb4d7f45d1cf-5d0819b3f6bmr5339708a12.28.1732796285800;
        Thu, 28 Nov 2024 04:18:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9T9A68feUeCUZameufi69BcHELHrmj3OzoVEiBlnXaBDzr0EfsijSDW4O9CCtKZGec59PyJncSPWuL5/Z2ME=
X-Received: by 2002:a05:6402:368:b0:5d0:819b:3ee8 with SMTP id
 4fb4d7f45d1cf-5d0819b3f6bmr5339689a12.28.1732796285506; Thu, 28 Nov 2024
 04:18:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212027.2704515-1-max.kellermann@ionos.com>
In-Reply-To: <20241127212027.2704515-1-max.kellermann@ionos.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 28 Nov 2024 14:17:54 +0200
Message-ID: <CAO8a2SiS16QFJ0mDtAW0ieuy9Nh6RjnP7-39q0oZKsVwNL=kRQ@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Max Kellermann <max.kellermann@ionos.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Pages are freed in `ceph_osdc_put_request`, trying to release them
this way will end badly.

On Wed, Nov 27, 2024 at 11:20=E2=80=AFPM Max Kellermann
<max.kellermann@ionos.com> wrote:
>
> In two `break` statements, the call to ceph_release_page_vector() was
> missing, leaking the allocation from ceph_alloc_page_vector().
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  fs/ceph/file.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 4b8d59ebda00..24d0f1cc9aac 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1134,6 +1134,7 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_=
t *ki_pos,
>                         extent_cnt =3D __ceph_sparse_read_ext_count(inode=
, read_len);
>                         ret =3D ceph_alloc_sparse_ext_map(op, extent_cnt)=
;
>                         if (ret) {
> +                               ceph_release_page_vector(pages, num_pages=
);
>                                 ceph_osdc_put_request(req);
>                                 break;
>                         }
> @@ -1168,6 +1169,7 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_=
t *ki_pos,
>                                         op->extent.sparse_ext_cnt);
>                         if (fret < 0) {
>                                 ret =3D fret;
> +                               ceph_release_page_vector(pages, num_pages=
);
>                                 ceph_osdc_put_request(req);
>                                 break;
>                         }
> --
> 2.45.2
>


