Return-Path: <linux-kernel+bounces-356509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75189996247
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6421F214AA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168C5187FF2;
	Wed,  9 Oct 2024 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NdeBX21Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1311017C220
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462022; cv=none; b=rI1WPuAqFHg6oKhx0rbYdEcVXSUANKxGFzM9TYd154RXlOfwU4cChwmRCjUlbRZ9C8xPHgG1A008jfXWmh1aKUUSQIVpg/I1gH7p6vpCSElfsdPM2SUwVzCuihgPOfoMa4pqQkwF90frTiRb1FojzQtPzGPOfNbA0B1BheWaw84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462022; c=relaxed/simple;
	bh=D8VSyWdM4/Dw5SrlkwgbxBP3gu8g2wjdc1qGVUjDVg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3fHJ4XXJOZAfO8wJPvohI3QgLDp7IbXCJxZrdSKTOa5JBz+DKsBrmLfrpxUBQ+n2vNAENU7JgJvNId2BeLjkLkb0CU6zhNrV5c0R3Tdc4a+gDQCQmtVy1WKH0bpt0UM99Dir2uEzZ4q+NVi1CcGgwvcEqSgNeC2MBEDuSpX2ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NdeBX21Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728462019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8VSyWdM4/Dw5SrlkwgbxBP3gu8g2wjdc1qGVUjDVg4=;
	b=NdeBX21QUaiS+eTnX58aDVnl1pp+a6kbkZypQL0WBeAzT8QnLgVFBS47FOXPgaSbbq1Fia
	2UYe0qXpFww1WmyAHgKkYz9h+iRaWAPzzBpgJpYKVBtbTjP5lxWerPk3EOiDVA8S3N1pXX
	5fyJANyGUQq455G76AJLOhSpPqVlMEU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-Th0Aq_ioMt2y-rjaEgVdWw-1; Wed, 09 Oct 2024 04:20:18 -0400
X-MC-Unique: Th0Aq_ioMt2y-rjaEgVdWw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2e29facda92so635310a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 01:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728462017; x=1729066817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8VSyWdM4/Dw5SrlkwgbxBP3gu8g2wjdc1qGVUjDVg4=;
        b=Dnt/1ZfoqXx8Ed1djyliRQsgllh6oY2/RPDv1QqBKpN8I30Qg+41EO8zpi31IpHjvf
         uF0vlD3tn+yoW2yh5tqO0VavpJFHSw4QF4V3+PIDWUtEIvtiS2K/xDwyT+5kzVWOnPPw
         U97npMPbA0xLwFcZCbenefAkcmSML2ljijvMn57P3kqfjxn6oQjSqEOFF60Nmk8l5N8g
         LPBu/nWCkYr+DTMFgQhKxFvl8i6mnPWTv4k7ydnM29mch0r/DUX50aWBA1dsPWIZN7di
         VV7y+vrTtrhrrWmGEBkYPKFzUkOYZa2MV9uZvBsgLdNGAVLZ1ASsM9h6ETuODJEf9ltT
         4HZw==
X-Forwarded-Encrypted: i=1; AJvYcCVci2mv016HSWDreJacoMoZ7O4heCYVw1JKXm8PkZ2ENXBRbQKCOoQEB/somdUTAbrFv02X7Aq0GBhLVqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIgUaVh/QHw63G+nxt8Zs8R0BCZDE9U2eHr/THQDm7FvMcflwn
	81vrT9Xv7EK0wX/f+e7vLX7Bg4xtm+n3zNuFALtMxx2oUsMn/HMum63iY/YN7eAoAot7WWJvr+k
	nTdRgBoheW+a3Vp+D5A+Qxv2oQ6cfx+Tt74Y2ed5ljlFyj3Od59FHwSSnl8zcczWodWiG4b1PMk
	J5/XL3DxZAsG3Z050K9V4E80w77cajoQHC/T47
X-Received: by 2002:a17:90a:fd82:b0:2e2:a982:e21f with SMTP id 98e67ed59e1d1-2e2a982e2abmr1519520a91.10.1728462017098;
        Wed, 09 Oct 2024 01:20:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzq3XMDK7buMc+YqoW+DuJ828CjCMqzlXqHQN3V0on7iADibxhf+AHHqExyIIAlXBvqsSOSMz/rLhD+CHGIgs=
X-Received: by 2002:a17:90a:fd82:b0:2e2:a982:e21f with SMTP id
 98e67ed59e1d1-2e2a982e2abmr1519505a91.10.1728462016722; Wed, 09 Oct 2024
 01:20:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004015937.2286459-1-lulu@redhat.com> <20241004015937.2286459-2-lulu@redhat.com>
 <olbm26f3ifb6ypfmfl22xszbpevqsxc3ogfzosrb44ujtzt6pw@uh7irbqfy5jr>
 <CACGkMEt-8hdiAaAPjNAPNSNtBFHK+ogCndHFJMtYpjEzoTK6Qg@mail.gmail.com> <d4h4g7txswidmpau5i6evvnragzzgtbxgoelorcolowweb4qjo@ujevaic3uzrv>
In-Reply-To: <d4h4g7txswidmpau5i6evvnragzzgtbxgoelorcolowweb4qjo@ujevaic3uzrv>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Oct 2024 16:20:05 +0800
Message-ID: <CACGkMEv+qfmuEnjjgbZc2nSKCN0TbwJvu6D1CiYV_zHw7QR46g@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] vhost: Add a new modparam to allow userspace
 select vhost_task
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 4:10=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Wed, Oct 09, 2024 at 03:28:19PM GMT, Jason Wang wrote:
> >On Mon, Oct 7, 2024 at 9:31=E2=80=AFPM Stefano Garzarella <sgarzare@redh=
at.com> wrote:
> >>
> >> On Fri, Oct 04, 2024 at 09:58:15AM GMT, Cindy Lu wrote:
> >> >The vhost is now using vhost_task and working as a child of the owner=
 thread.
> >> >While this makes sense from containerization POV, some old userspace =
is
> >> >confused, as previously vhost not
> >>
> >> not what?
> >>
> >> > and so was allowed to steal cpu resources
> >> >from outside the container. So we add the kthread API support back
> >>
> >> Sorry, but it's not clear the reason.
> >>
> >> I understand that we want to provide a way to bring back the previous
> >> behavior when we had kthreads, but why do we want that?
> >> Do you have examples where the new mechanism is causing problems?
> >>
> >
> >The main difference is whose (kthreadd or the owner) attributes
> >(namespace, affinities) would vhost thread inherit.
> >
> >The owner's attributes tend to be different from kthreadd, so
> >management might be surprised for example, vhost might be created in
> >different namespaces or having different scheduling affinities.
>
> Okay, so this requires some API to allow the managment to understand how
> the device vhost will be created.
>
> But why do we need to restore the old behavior with a kthread where the
> resource accounting is completely disconnected from userspace?
> For the old managments that don't expect this?

Yes, as such change can be easily noticed by the user space that
breaks existing management layers or tools.

>
> BTW I would suggest adding all this information in this commit, in the
> parameter/IOCTL documentation, and in the cover letter because IMHO it
> is very important.

I've asked this in the past. Cindy, please make sure such information
were included in the next version in the cover letter.

Thanks

>
> Thanks,
> Stefano
>


