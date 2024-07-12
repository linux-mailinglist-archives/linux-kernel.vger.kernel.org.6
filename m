Return-Path: <linux-kernel+bounces-250033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EC092F344
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 03:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3968A282BC3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 01:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7EB46B5;
	Fri, 12 Jul 2024 01:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVNuMMVe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9E320E6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 01:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720746094; cv=none; b=oD2PzOfj0PhUJ1CCkvpah/2CS1h4tQAtzLxH23lbGWEWv3n12Vpyu2OtHrkBFCWX/WjkrD33GFYu6Fldtztc3QEZESocelwgXbhw235D0MJGfJqjvC2HPzwkwO5p3B1pSTEuB8xjEmg/AxTSf4dCbKM9a1kEZKJioINX4BQoUYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720746094; c=relaxed/simple;
	bh=0lzGgMccgOsb1N/R6m8AEmk1oMrFdCaXnfbBbMXMHRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FlRAevcZLocVituyqUSPecnzVlNavfAvmLs7F72R4pbsvJlJrp2PNPUwI3PUKbY+oBrUmUx56QW/qJ7ypk+vuv6GEqEFq67LBuOzIVDDz3c+956YYucPSSJ6jlbyxHU+K4gOvcDud90uRpsYLI0o4bxcmKav14EW4BBopiKBvgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cVNuMMVe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720746086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E9wm45KJYHSR6EG4gUE0pW1MnhXS5B56DsrXLuti6lY=;
	b=cVNuMMVe5WEsJfYllS15aVx2Vjzh/N9LIFf+hVefSfX4YrwjZVkFLpee67A4af/3LYgUes
	53UQQpM6Rbw+XIZL68EAhvtFQnAlLl/uiccfuB/1gnAjS3Act29hoAyyl+D5RgappFo7gX
	V2mQCHAeL8ItGeKQrwUCuiHawqDRgQ8=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-DbOcJQaZOuGwgBcMBkAqvA-1; Thu, 11 Jul 2024 21:01:22 -0400
X-MC-Unique: DbOcJQaZOuGwgBcMBkAqvA-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-8101b96d66eso150072241.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720746080; x=1721350880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9wm45KJYHSR6EG4gUE0pW1MnhXS5B56DsrXLuti6lY=;
        b=vg2kBP0uLEYrvZaUNW0Cd6KwsrnYpiuQJMwdAp4GBZwmE/uZwLRdRK8x7Fq9MKVNXs
         398ODa3Z0h/6K8v/fKpi+grT+8Hm8cypDB+WFrQ/dZrmUCkzWjkc84Gt6T6IuN80nsn/
         WuW9peEqsqUoFPIlKdU52y9PDfYI/Fk+pSUnVTabPg69UOqPlutn98G1ESI9fK77nbja
         heqC/jKsAspPiZjiPZ5JbUUR4cBdq74YBbLjDUgrA1DMhUoN8pdDLa7F3zOVKaEoBtZ9
         LRPjbtUY3XH7qHLaCRg6GFkaDbcs0fjwcyLw0d3u2cfP3y2YH49Ex+eCQXStks0hAp1T
         sM1A==
X-Forwarded-Encrypted: i=1; AJvYcCWBoYqN/WAGdw6MeKXYnkCNkpYWb6wP79ieHbGTn1x+B9il7XloibonxEFQmgOU8EAvDwD97rYo0eQdiYJnxnkf3W/80qrbndiZ7brA
X-Gm-Message-State: AOJu0Yw+qzUNt3lOzH//jtLHe34FT/RPCmG7rQ8amdqoW/YaVZ1fzP1n
	LrhfOgEgPmBBoSsyIjUpIli5K0qrQhTDgCU4YDOfO2SVvRHBt9h6Vh2HfEKIw5G0+67+9TUzubo
	CgB5AFemTnvONKCWSKiJDiJOwsmgsaX7s44+H4JlDRes5ygUex6RjUR4W60ugyWtX9oUsCntnC4
	q8ImmxaNieK/BUIaT6vl76gbNGGRVYsQeE3lWEaAfowe/2+9OsYLhE
X-Received: by 2002:a05:6122:3c8d:b0:4f2:aa91:34eb with SMTP id 71dfb90a1353d-4f485296ad9mr4395851e0c.1.1720746080270;
        Thu, 11 Jul 2024 18:01:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9qAJCd/UDkXooJxLP3polnc0tAxXfY/AZlFlnhbfWI+/TnM9trFyVB+qIUz+wEKL7J4r0h72VhTW6a3A80Wk=
X-Received: by 2002:a05:6122:3c8d:b0:4f2:aa91:34eb with SMTP id
 71dfb90a1353d-4f485296ad9mr4395840e0c.1.1720746079952; Thu, 11 Jul 2024
 18:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710065616.1060803-1-yang.yang@vivo.com> <29e50fff-fa7f-4b92-bfe9-7665c934b7dc@acm.org>
 <ead047aa-d9dc-4b2f-869f-610b309b5092@vivo.com> <Zo/gevNqftePGvic@fedora> <6acb93c3-f11b-40a4-bec0-b17fb77ad0c9@acm.org>
In-Reply-To: <6acb93c3-f11b-40a4-bec0-b17fb77ad0c9@acm.org>
From: Ming Lei <ming.lei@redhat.com>
Date: Fri, 12 Jul 2024 09:01:08 +0800
Message-ID: <CAFj5m9L2qin-h1qfPbhotSr-2Xh+mnQbsWhpzeK3dA_YTQ=JpA@mail.gmail.com>
Subject: Re: [PATCH v6] sbitmap: fix io hung due to race on sbitmap_word::cleared
To: Bart Van Assche <bvanassche@acm.org>
Cc: YangYang <yang.yang@vivo.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 12:33=E2=80=AFAM Bart Van Assche <bvanassche@acm.or=
g> wrote:
>
> On 7/11/24 6:39 AM, Ming Lei wrote:
> > There are only two WRITE on 'cleared':
> >
> > - xchg(&map->cleared, 0) in sbitmap_deferred_clear()
> >
> > - set_bit() in sbitmap_deferred_clear_bit()
> >
> > xchg() supposes to provide such protection already.
>
> Hi Ming,
>
> The comment above 'swap_lock' in this patch is as follows:
>
>         /**
>          * @swap_lock: Held while swapping word <-> cleared
>          */
>
> In other words, 'swap_lock' is used to serialize *code*. Using
> synchronization objects to serialize code is known as an anti-pattern,
> something that shouldn't be done.

> Synchronization objects should be used
> to serialize access to data.

It can be thought of serializing UPDATE on both ->word and ->cleared,
instead of code.

> Hence my question whether it would be
> appropriate to protect all 'cleared' changes with the newly introduced
> spinlock.

Wrt. ->cleared only update, xchag() is enough.

Thanks,
Ming


