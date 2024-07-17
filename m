Return-Path: <linux-kernel+bounces-255637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC6A93430B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77BDA281F9C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10EB18508C;
	Wed, 17 Jul 2024 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHi5eyp+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768E41850A0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721247060; cv=none; b=gpIpW7PtKRVctZ9/d8xcyxC0Rj+EpPSz5Bc5EhNnaVLLs7ZRbaHIwZ5YsQAnHLYr+8cs7P+mrXnnbmBGDDIOdpWVKHpECeuz/IBg2hRO3jlFCKnMHDYebkjtTzvnVvXiQXPteD2gTBIAIwnmuQ/o3bTcPupYm2DRIvG38jr9/fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721247060; c=relaxed/simple;
	bh=dqw5Qeh2xp7WhjNIwZjRLJC8bY9vGPDrCHCpJxFD1dQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8CU7na+V3/oix1XOcHujfvPGoZKBnjytePYw9oRUds1JZ4FlMxGPasgu8Uzvh1rtZTBGMC+nn5VvUoG4swaCE8bF/BNcL0MmNgooz+su6PZfUPaZ4rZapKr6ruLlelyplcLAqzvx4zohxB948qkBf4K0Hg1KFrKbYTa5Hfc650=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CHi5eyp+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721247057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wUuy8Fm1573t8h+fqy2o6dRDaXACJrIuqRSm7ii11lY=;
	b=CHi5eyp+YxyHnzb4BsVJWsc9/3m4mxB7MbrL1uV5DuYP3ZNfRuPnAd15mNA4z1qlJE47oo
	C3HR0YW71WL77dHiFAW+lxoUzNmHtA4D5ROnRv+ye490aRl4RUNOSiNtUUqGNmoANq6YdS
	dunGw8e9ljC9Y4/LkBoB49y7jBiVQCw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-B53qFSwvNFeNd5Np47bj3g-1; Wed, 17 Jul 2024 16:10:55 -0400
X-MC-Unique: B53qFSwvNFeNd5Np47bj3g-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1fc52d3c76eso978755ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721247054; x=1721851854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUuy8Fm1573t8h+fqy2o6dRDaXACJrIuqRSm7ii11lY=;
        b=nWjp2xIkrSo/kekYOctyrBTT9pPzATmFyq2oP5JiIZde0c6gfxJXSiRlFVpF2IiUcm
         UetUjYuQsnpP4c9X3oWWM39a2JBJu377fVb3AsnaP8Wk/K1fy936lY8fRweljLvASxmI
         vsqHItmloSkE++KK7zHdTun/adZqiWAtU+y4Hq2mhAzMq4ohz4zePgz3iY6Q6QVJYQkM
         vIspTNBY2PC12pTmU+MhBn8Dlu1qxF9Lanh0JA1tQaKH7ASGj0qiJ1Xat3suxxB8IQri
         qxfmBPpMp+pIhvuB5SZTxJovZaNEX4dK9YmIo8SjNZfMAKs//HKsAfgsG46RPTZYCpts
         LCpw==
X-Forwarded-Encrypted: i=1; AJvYcCXN8GWX0oSPGBWibQhbRp4TglkUIdtj/0LJAZoJr1y4ByObeHWupFru3xlLv1FkQ9D7NTxBj6tZDtLUubTDkOQ18oPnRMdaQm4mAVVx
X-Gm-Message-State: AOJu0Yy4fMQKqiVc+qlspK3mre1pHTISx1q5ly7PG9xqOXXh7+9pAGvd
	oZDhxw0zo+PW2XqvEuKNXG0nAkVV6f0tpUcPacqBvzfe/KSOU92a4RV3A6Hphr9gzCGxmoZ0x6q
	Uk2akg3eTAZwuIzuoyhsVZGBh6B99GucuF6INhMXF6V+WxyynnMiWU0iLMZs4bBXyszkN9HYAmZ
	Fg0OnVPSZzmLLD+YNUCFVKPtuEm3/fXFfi047hrAu+AzZk
X-Received: by 2002:a17:903:2288:b0:1fc:287f:623 with SMTP id d9443c01a7336-1fc4e154aebmr22813725ad.11.1721247053963;
        Wed, 17 Jul 2024 13:10:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTxL2wGq4qFVRg2dVJl/Fkrg4wVfEqLIKk8VPK81qtTGJ+uA+Dr22xE7RfaMxJsxhvqD2CfBFqlBqX5PmSb0E=
X-Received: by 2002:a17:903:2288:b0:1fc:287f:623 with SMTP id
 d9443c01a7336-1fc4e154aebmr22813655ad.11.1721247053525; Wed, 17 Jul 2024
 13:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715174757.876203-1-agruenba@redhat.com> <CAHk-=wi68M2mAY82Ss264_++2q2x1fumXnjK2Lxt5LZoDHbr9A@mail.gmail.com>
In-Reply-To: <CAHk-=wi68M2mAY82Ss264_++2q2x1fumXnjK2Lxt5LZoDHbr9A@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 17 Jul 2024 22:10:41 +0200
Message-ID: <CAHc6FU6Up+wLg=3Kho5mE8fa5h5-4bNKtTu2fPJ4Q8X=XwJNOg@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 changes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 9:25=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, 15 Jul 2024 at 10:48, Andreas Gruenbacher <agruenba@redhat.com> w=
rote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tag=
s/gfs2-v6.10-rc1-fixes
>
> Btw, your key has expired, and neither a "gpg --refresh" nor looking
> it up on kernel.org seems to find a new expiration date.
>
> Please update the key somewhere, and use *long* expiration dates. This
> kind of noise is pointless.
>
>               Linus

Sorry for that. I've pushed an updated key with an extended expiry time now=
.

Andreas


