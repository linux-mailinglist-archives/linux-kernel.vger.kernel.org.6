Return-Path: <linux-kernel+bounces-356422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 275CE9960DB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593181C2162C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307B7183CC1;
	Wed,  9 Oct 2024 07:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jI36At7y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EF517B50E
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 07:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458945; cv=none; b=CnCOXSgeeg6/4Yjry55AMdOXbyqMAmLghTfWmOekYbjL0qyfUgVTcgvLMLPXEcG3ZaKygy6EzeAPNF8nv1SpqgbaxbrAMoKaJsrW8PgY0atjxTCCud6xoBGeC1hqO80gIv9VihdQe9Eu/Vdx5LkZDWhlySaol5N8S5+wrO/h4oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458945; c=relaxed/simple;
	bh=nAlwX7heCTnYT7gHHjut1Sm+B6Ti5/c/smSRa0DeyZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=laBUnsbQ4v4N86hXaMTzEXI79B3+bpcMLuxYHfAsnZ2m9A235gVQH2Ff4cQmLi3umIaH9NS8tWn9T1UlYU+3YPqSKHRaQD/3F9hcXCfzJ1jHM8SjjTvuCMqwAr8RNlePl8D53kNPZauPtQk0zPmB/lKjxKRPUFDbFBpeP8NcUxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jI36At7y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728458942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nAlwX7heCTnYT7gHHjut1Sm+B6Ti5/c/smSRa0DeyZQ=;
	b=jI36At7ytBwfrUNNdG4Cobixav6ph5gn3c8eDedzjBXPBF3Gd+dbzDa+DhAjocuogLzfWJ
	kVc/13zux/sgxJjvxtAFwRx0rW12k+Vud0rvuT6mtNLmV1i4+0ShoYmUaaMQEyxzpqL4WL
	fbEp0qMh+4ubtMica7bql3xvaEDx08k=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-xeza8aqCNf6cziPnkosbSw-1; Wed, 09 Oct 2024 03:28:31 -0400
X-MC-Unique: xeza8aqCNf6cziPnkosbSw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2e10dec7d0fso5872468a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 00:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728458910; x=1729063710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAlwX7heCTnYT7gHHjut1Sm+B6Ti5/c/smSRa0DeyZQ=;
        b=DbYSTnktjziRWnJYRlnUiSKnqdZbn6ZzWRDycLETg51ZMAzZZru4QJYhpwzASLoWas
         Syms7CAzO7yUMi9biGLBKPjjVrY1mX/CEJ7pNqVrCvW5GZRVauruCOFRBwYl7Yu5217F
         6RYWHPmilc80dTgRQXF5ZFW6uxPLxHrvdj61i1mwdz7qcx3BQ1yINvoT+QORvRhuwPtt
         zLcKJR+p4YVX5/unmnhjC2hEt7bJ1GHnfjN4730fE7NHsK73F5eJtcUXkANBo+CJaGZ1
         X9BIlXsbfT/6vJHKKX4vPRr3YDaor+6qeONwBNv7qBjJsHYO5kGIuR3ty1KU8zf4nUzk
         q+cg==
X-Forwarded-Encrypted: i=1; AJvYcCUYUjDVKVHzwL3YDQ2xRIEUBLmkqCW207rMPwDiA5B0iJUAdLquuARo/sT8sDKUoWjHNDQ94kIj5MK9MgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoMg4nb97x6iRD7JGTLiWxsTN/+R2a3vJU3IgRp2BmGtngifOQ
	w2lhNCIUCCitABhKqy9UdJx2KJaIGeqKirFc26h3VpK2dVZL5eEOb5htdivDzUhSOFN5AiWv1Ja
	NntHyDzDix3xWMPtpCKQ0KfsrYADedjcDXWI1pXYpLYsNKibUzDTfbtsU/QhydmbYuwoq+Lya+x
	Vrkk+3fuyvW9ab8oIayP8HxvvGC+KMl2n6Ox7T
X-Received: by 2002:a17:90a:6fe2:b0:2e2:8744:711 with SMTP id 98e67ed59e1d1-2e2a21d4d1amr2103319a91.3.1728458910409;
        Wed, 09 Oct 2024 00:28:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLz9tstmnsOxhFo9SgB4hJ8Yecxi8VvRl7k62LSd/ahWAaKz/BzKbB4YS/dO0BgAqKF6liAjeW1yMcJRWvEPo=
X-Received: by 2002:a17:90a:6fe2:b0:2e2:8744:711 with SMTP id
 98e67ed59e1d1-2e2a21d4d1amr2103302a91.3.1728458910005; Wed, 09 Oct 2024
 00:28:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004015937.2286459-1-lulu@redhat.com> <20241004015937.2286459-2-lulu@redhat.com>
 <olbm26f3ifb6ypfmfl22xszbpevqsxc3ogfzosrb44ujtzt6pw@uh7irbqfy5jr>
In-Reply-To: <olbm26f3ifb6ypfmfl22xszbpevqsxc3ogfzosrb44ujtzt6pw@uh7irbqfy5jr>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Oct 2024 15:28:19 +0800
Message-ID: <CACGkMEt-8hdiAaAPjNAPNSNtBFHK+ogCndHFJMtYpjEzoTK6Qg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] vhost: Add a new modparam to allow userspace
 select vhost_task
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 9:31=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Fri, Oct 04, 2024 at 09:58:15AM GMT, Cindy Lu wrote:
> >The vhost is now using vhost_task and working as a child of the owner th=
read.
> >While this makes sense from containerization POV, some old userspace is
> >confused, as previously vhost not
>
> not what?
>
> > and so was allowed to steal cpu resources
> >from outside the container. So we add the kthread API support back
>
> Sorry, but it's not clear the reason.
>
> I understand that we want to provide a way to bring back the previous
> behavior when we had kthreads, but why do we want that?
> Do you have examples where the new mechanism is causing problems?
>

The main difference is whose (kthreadd or the owner) attributes
(namespace, affinities) would vhost thread inherit.

The owner's attributes tend to be different from kthreadd, so
management might be surprised for example, vhost might be created in
different namespaces or having different scheduling affinities.

Thanks


