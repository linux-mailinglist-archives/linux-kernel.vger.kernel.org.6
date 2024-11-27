Return-Path: <linux-kernel+bounces-423076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BB39DA274
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B9F2B23C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 06:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F80A1494CF;
	Wed, 27 Nov 2024 06:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kg20+Lpv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A111CFB6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 06:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732689935; cv=none; b=iF8jpP5xS1C9rzul4TQHEb2Wd7MOCMAEqKojAV7ffA1LC4d95yP3vxiDmiSbOo5AT2Tz12LIjjr4aBY7JOAw8Zf1TAj1EJySRbinL8c39VbkR7Z4OqgLHeJ6SQu0JCryorgT5Aqf9hvFHjsIstSXp6vgKYLdGj+oHvcaA6PSMaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732689935; c=relaxed/simple;
	bh=RNmNT70ps+kx7slfSFuJ9G/H2xuAhJkWrfXMq+752EE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwlENx+Nyz+leKwMB2dgCYDOckhDwVoOe1hYQJmNGKkaBcNYiaBIm1E2nOYortNS3/83HgEIWLe5uxENHTOHsEluc03G1ur1n6ZucfMSnhnzbrOGmaPgRidQpy9PJApsSioIeCbbYDvSaoaUYckNG6cMllF1cTiIyzOks3jr62A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kg20+Lpv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732689933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/rI2EY7Ph6b3KZhYxy9/j/W0i2aqaLJSO/nDcTsMvA=;
	b=Kg20+LpvVR7ZZ/T2BQ2xaa9/rNRkfcO2ej3XoGvGzsPERVwXv7Mvtk0p9hBrUARt5wx/Bx
	PpA35R9/pJkVXu8RD9BH4rsBeQVBa3BHu4qmLJKbX4YkzhVwu9ci+3DChdkNEOQaP0pMc2
	SSc3Ka2SvuhiZiwnRY5cDVAee5B4JTY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-0-sOCgfkNve6BTwliqC7QQ-1; Wed, 27 Nov 2024 01:45:31 -0500
X-MC-Unique: 0-sOCgfkNve6BTwliqC7QQ-1
X-Mimecast-MFC-AGG-ID: 0-sOCgfkNve6BTwliqC7QQ
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa52ec07bcbso237703366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 22:45:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732689930; x=1733294730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/rI2EY7Ph6b3KZhYxy9/j/W0i2aqaLJSO/nDcTsMvA=;
        b=WvUdNeVDsGGw7FdUIBvyiLJWlfvVUz2o1guNBYQkVmX5IsjJET5uAb5gPwFAOeqXQQ
         gaULVkkMnIj3RwaN3HYO8wdo6SO/2m6rYr7OopHMVnngt9EOkLfy94r/iZwB9SSEPGrw
         hofznNFttp3VPoLetYfYAOcBKzuvuoR2v2RKGQEuXQMmYY8EtvRzk1HqB6cumtgBA+oX
         Z5P8sup14jD+qCifz00qZnGt3fx/8+qQeNZCDXv+PEbQxMeQL13imm211LawEw1ifQXV
         oX9OhLKfs/aBhLeEVHbwM+sc2LWCz2i0Nzg0bfV+DUnBqr6Dz0xYvx9qQ+q59lYl9MP6
         zb3g==
X-Forwarded-Encrypted: i=1; AJvYcCX9SNY21d0Zz9fSAubxpOk3yrJhpXhpsS2cyoehpenJisK7uKJ03O8G6qUtZ1HvfLosO3b4muE5O8VVPrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9dGj4wS9wTlY6+mt0QpO+ErG2rT9CpCD2u9DtBslqf+9xkher
	Gzk7nqYVjESMZIToYg2iO2Lv69khcEWrv+i0LgYX/sTjUXHf92dCug14POsXXxwhDTfj3TDhX/n
	33d4zJ/Zx3mkHqmXHPz6EMRrSl81dEVcA5J1GwpwlZd84fpjgboiLEkmYzRzUja4GtN9S/Cf/nn
	veoBZ9VLl5dWoWaVupJMDXOBfSh2aLA2SE5kc7
X-Gm-Gg: ASbGncsNjSyLsg+0Jk3nY1FbnviSdxk+IQAEDZU8ZuUq3ExwmyBreYHO1uZqYaRK9j5
	3/wbjCQQxZ5xYOoxSj5AO7zSL7C3bhRS8
X-Received: by 2002:a17:906:1ba2:b0:aa5:2f8a:b952 with SMTP id a640c23a62f3a-aa58106613bmr111617766b.54.1732689930416;
        Tue, 26 Nov 2024 22:45:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUP0/KWUbb7Co3AncLRdOmYqmNvbV+nqgWBTGrmbeqC5ZOJ62cFI33uH+j5QLWBacrMzgyNp/kkRsf6zhWK3M=
X-Received: by 2002:a17:906:1ba2:b0:aa5:2f8a:b952 with SMTP id
 a640c23a62f3a-aa58106613bmr111616966b.54.1732689930058; Tue, 26 Nov 2024
 22:45:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105072642.898710-1-lulu@redhat.com> <20241105072642.898710-4-lulu@redhat.com>
 <c6975912-4205-4c75-976a-f68dd6dcaf1c@oracle.com>
In-Reply-To: <c6975912-4205-4c75-976a-f68dd6dcaf1c@oracle.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 27 Nov 2024 14:44:53 +0800
Message-ID: <CACLfguWGxNX1PgTCgH2NbBZoJhRSNnvVKzUzq2=cYY60+-kReQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] vhost: Add the cgroup related function
To: Mike Christie <michael.christie@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 11:22=E2=80=AFPM Mike Christie
<michael.christie@oracle.com> wrote:
>
> On 11/5/24 1:25 AM, Cindy Lu wrote:
> > +static int vhost_attach_cgroups(struct vhost_dev *dev)
> > +{
> > +     struct vhost_worker *worker;
> > +     unsigned long i;
> > +     int ret;
> > +
> > +     /*
> > +      * Free the default worker we created and cleanup workers userspa=
ce
> > +      * created but couldn't clean up (it forgot or crashed).
> > +      */
>
> I think this comment got added here by accident.
>
will remove this
Thanks
Cindy
> > +
> > +     xa_for_each(&dev->worker_xa, i, worker) {
> > +             ret =3D vhost_worker_cgroups_kthread(worker);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +     return ret;
> > +}
> > +
> >  /* Caller should have device mutex */
> >  bool vhost_dev_has_owner(struct vhost_dev *dev)
> >  {
>


