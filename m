Return-Path: <linux-kernel+bounces-278819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AE294B54A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 05:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9A21C21A94
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 03:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E552E400;
	Thu,  8 Aug 2024 03:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SROHoQYX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E92A2629F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 03:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723086141; cv=none; b=IoNJ585KXiJAXlOyZ7Y6tJlNcOkuR1wfb7BeCtS0176AOYboUy9MnPLR4vPpeguoYf2TeNswR+HVv2lNDnaf2507LM4sxlu9hpaC3HeqCJ1A2ro97VvRKj7RvjYX7BYp0EUvq9bC/SSIJGd8RICEJNS+HaZZWqpa8GFiUdbR/H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723086141; c=relaxed/simple;
	bh=p6xx58xWZKdfb6c1AAu8Mu+FmCVOdJIJVmtwQFvNPYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzTDajWk+xQ1ahrtp8sRBNVLzpXEb39R+XY8ohijbgGfbQAeJ9MHnDA9YgBDwMxLqrqZfMyc+o0P3efLD0OqX8vlH5up0m9TmKsFVrOdeVYBxXEOtaHCzFzOhjNR649jfQa5tVpW2rsXk7Bb8rIC81+ISMwuYwDnDOyf5C8Wc/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SROHoQYX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723086138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hb2Rpkxt3LSPGve30aAKDHxWvpSeSXCq/ixX+f0TGsw=;
	b=SROHoQYX/B7hS7RSDDnmJTwuEm4bBXnzV1X3VjBqS3gUywvVG/XElx2XT4RhHt8iCF2Gdt
	4hiHCuohk6ZSbOPzwcqJ1RBc6bL2oHf17n4VMtqHQ9+Y4dwTCu7rEErVsvRomC9TRUqE6v
	gqbJ3/DJ6pe76PcJ4ZMn96vlx7hsRZ8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-BnXUtp3TOpWuLQnhMVhowQ-1; Wed, 07 Aug 2024 23:02:17 -0400
X-MC-Unique: BnXUtp3TOpWuLQnhMVhowQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2cd4e722d82so645164a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 20:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723086136; x=1723690936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hb2Rpkxt3LSPGve30aAKDHxWvpSeSXCq/ixX+f0TGsw=;
        b=DBGuWx60vLwHqaVZwFtlg9aSZRfrifPWFmCeApy9eZYU5SBU9lILeqWATaRfI6//tm
         F2zDSjrrlyzYVaEH8UfizjSYSSgqtFfhlR01UIHT3qxpEe57QofsR5opS/FAVraBeVud
         yVz8PtV+0Y0NNsCyQfNkc/D2BZJKt+nF1G+epy5zpAAtpmBUaLvuozGP4AO94D6yKg1b
         6e1GGNJ74+EhdKUUHHj2aMQJVCsyzJM0ex0s2IXd29arhH0dUeJx/vYrIlc1rIFh9R/0
         mkwZgUs2zrFmJNHd0M63F2tuutaMyqerwEn57//VNNyNUXwnEjFkITnBWdVFmnEp6qv4
         uP3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSO+9gBgiyhVBjc0Qwc3FlPWZ0Qj7hIEwG9DY8mElFGr41KXJdcEBhY77FF0cLKt0HGMFz88ifuQGCgsQt0XO/sYJPwn0g/yKsjwnA
X-Gm-Message-State: AOJu0YxSDMq5r9EFwW9dB4PYt8P0fk5cCzN4JmqNCn3IDa0N4KNShCbZ
	g8fLs8EovI/aA6I4JtfuoMMQTun/5vtrRAXLSdF60k6IaZJcQPEtREvxz88J+CKgPZHTSyJWlP2
	KzxOjzx7f4FymXDG0stpHjJXwsTHBs0flEyzkHrQuL2rHm/bZ1QQa+b2QCC8CLjDAa5u2zKL3X8
	gH1QNSdoiYZulZ7EOoIeldC8EgZqnrAPxmzVMJ
X-Received: by 2002:a17:90b:380f:b0:2c9:923e:faf1 with SMTP id 98e67ed59e1d1-2d1c3396a72mr713371a91.18.1723086136154;
        Wed, 07 Aug 2024 20:02:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvLiP+h2FOcxwnVHbI3oWaDXPgf/3hnuTAiuAbXo2hpysu/kx+KNhjeKucP6obJyqvU5B/srn4WX8udRClcYs=
X-Received: by 2002:a17:90b:380f:b0:2c9:923e:faf1 with SMTP id
 98e67ed59e1d1-2d1c3396a72mr713344a91.18.1723086135668; Wed, 07 Aug 2024
 20:02:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805082106.65847-1-jasowang@redhat.com> <CAGsJ_4yHU3hBZp2ub1qokf2rCvK7yM0fK9CXQUwxVLn5uaVpcQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4yHU3hBZp2ub1qokf2rCvK7yM0fK9CXQUwxVLn5uaVpcQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 8 Aug 2024 11:02:04 +0800
Message-ID: <CACGkMEtjGZQ1phKKSNK2gv5ZSyuXf7G=+OKZAzixBtJT53jCZg@mail.gmail.com>
Subject: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: Barry Song <21cnbao@gmail.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	maxime.coquelin@redhat.com, xieyongji@bytedance.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 10:30=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Mon, Aug 5, 2024 at 8:21=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > Barry said [1]:
> >
> > """
> > mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> > __GFP_NOFAIL without direct reclamation may just result in a busy
> > loop within non-sleepable contexts.
> > ""=E2=80=9C
>
> the current code will result in returning a NULL pointer but
> not a busy-loop.
>
> static inline struct page *
> __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>                                                 struct alloc_context *ac)
> {
>         ...
>         /*
>          * Make sure that __GFP_NOFAIL request doesn't leak out and make =
sure
>          * we always retry
>          */
>         if (gfp_mask & __GFP_NOFAIL) {
>                 /*
>                  * All existing users of the __GFP_NOFAIL are blockable, =
so warn
>                  * of any new users that actually require GFP_NOWAIT
>                  */
>                 if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
>                         goto fail;
>                 ...
>         }
>         ...
> fail:
>         warn_alloc(gfp_mask, ac->nodemask,
>                         "page allocation failure: order:%u", order);
> got_pg:
>         return page;
> }
>
>
> We have two choices to address the issue:
> 1. busy-loop
> 2. BUG_ON
>
> the below patch chose 2:
> https://lore.kernel.org/linux-mm/20240731000155.109583-5-21cnbao@gmail.co=
m/
>

I will add those to V2.

Thanks


