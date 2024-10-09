Return-Path: <linux-kernel+bounces-357168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 263AB996CD7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F0C1F23D19
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0949D19994B;
	Wed,  9 Oct 2024 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oCG8j05w"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C914938DE5
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482113; cv=none; b=S0riZsdr/1DtyQx/TvfEWrGYgYbOYM8cTWJZ0dRiTXSuqmxdD0sDZjVl0qT7/ihKGUvEAfHRgRbiYBvq3hwr+PPKFqsGPG2pDG8BNOjz/UI8JzDUaQ34vqQNqIyW1NmibpmTSlt6Wd7Mw9wAsvKBTjOzQVcJWSmgMziEgb6+38I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482113; c=relaxed/simple;
	bh=k7DdMpwjWrSVnF70efu9Nz576OUVbA8sKqdX/14wnt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4w7f8nUHiuRuavD598zpL1dOTSFYAkYqB3zD+ANgAJkPAPeuuEFye9/7XslO4pm6XO0heBmBhAfveWENrZTdS0XLftoiKbS+MRMfFTtAB0OMTQtLxWkiDt/+ydo3gduj/Ktrs4Nwfh9QY2rKBWzrYyswveLXiCSGmHRj6n1huE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oCG8j05w; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c90333aaf1so1808477a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 06:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728482110; x=1729086910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZu/+gdB6bHOpVTSHgDrGd7M0vlZH+wWHXs8Fc7Ognc=;
        b=oCG8j05wTvCRp6vvzQmviTE+7OxKi2R33pYXFANxx/MoQpPtxXbadjuFE3LAlxp5UX
         AbFmeoLKcmiWcsl0UW/E64zZH3r9oVdxKbWKpBH04Lc+IPRCj/wozgCxdMxo9o/3hrse
         J2vzv8LLWzdP0Mivo24woY9fql9xSSl8SZpi+uKx3CKvc+9ySyjwKQ0rP6yEkSd38Mt0
         hgSFLNYwdZ/ihhUrJSTcPWG5fbCIxFx++eH5GN2h40VDP0BEt9iwBM5w8NevAFrDWN9c
         RZFHgK0t+g65896P1/tcnREi+LaIqdatwjAM7CtJdt2RWt2ZZ/iI9P97C6LDAcNdUCPQ
         LW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728482110; x=1729086910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZu/+gdB6bHOpVTSHgDrGd7M0vlZH+wWHXs8Fc7Ognc=;
        b=u3exeoC777DqomARJhA0BZbO3/cZ7QIFI8CjzODlvGKAjBvHlo4MHTJ0XPS2jvkPLu
         ffYUNpNk9AcFCCw6gvDWYhmL8qCMtNUM7Zlm4vIL5Nr9lMGi/2C8ZVzokBqf32qUNCHI
         3uay5AoveapwJmGrjYyt3oZGrtPVWL1oCYpF34I36RbcNfDjvygslR3KfIX1H3Q1NZDn
         V8mT+YywTXXE8Ldqbjr4TAl0mtC82zkLgqKT7z0xDbyV2l8CT49KEYA1+4d4u9a+NOT5
         CObWfsO0UzIN6J7g1md0KXFLfAYv+Okzy9UocoNjyzPOfy4GBwVdfZx30+61Ww/LbkCK
         H5Hw==
X-Forwarded-Encrypted: i=1; AJvYcCX3osvx47zQFIW+G2tSChD2jIqtO23lPDXL08ogmxIhsNMIeQH5xtlGR0J6D3F+HzWc0gwcxYeEgcX2sZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHRXRtewsfgPBGENXoZlbt5ucK4l3qXs53zkayGfRlssKg0hW9
	L9II9h5LVBnWtz7/gym7w5Rg3KH6UOPx29dDqq5/dDa65l+gXmbDOYplqu0uko9Vd3u8070yfO5
	KSjG2a7nVN9cAde9CrEwqq6bZCvAYgXpCVb+3
X-Google-Smtp-Source: AGHT+IEtAzSUDyXHbQ3P6oqVQMFsthgaasp7xwpxPc8RphUDDeGCLQ4wnkjhhmtyLiaqxF2Wb39RmFXqv580ZGOJAew=
X-Received: by 2002:a50:8dc7:0:b0:5c9:1b62:48f4 with SMTP id
 4fb4d7f45d1cf-5c91d58cedamr2219054a12.15.1728482109811; Wed, 09 Oct 2024
 06:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008163205.3939629-1-leitao@debian.org> <cea1458c-6445-45d0-bfa1-3c093384cc90@kernel.org>
In-Reply-To: <cea1458c-6445-45d0-bfa1-3c093384cc90@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 9 Oct 2024 15:54:56 +0200
Message-ID: <CANn89iLH=Y0GuZz3b2p5d7MtEcPFt62+Z4LBbdiRDtE157ER1w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: Remove likely from l3mdev_master_ifindex_by_index
To: David Ahern <dsahern@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, kernel-team@meta.com, 
	"open list:L3MDEV" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 8:25=E2=80=AFPM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 10/8/24 10:32 AM, Breno Leitao wrote:
> > The likely() annotation in l3mdev_master_ifindex_by_index() has been
> > found to be incorrect 100% of the time in real-world workloads (e.g.,
> > web servers).
> >
> > Annotated branches shows the following in these servers:
> >
> >       correct incorrect  %        Function                  File       =
       Line
> >             0 169053813 100 l3mdev_master_ifindex_by_index l3mdev.h    =
         81
> >
> > This is happening because l3mdev_master_ifindex_by_index() is called
> > from __inet_check_established(), which calls
> > l3mdev_master_ifindex_by_index() passing the socked bounded interface.
> >
> >       l3mdev_master_ifindex_by_index(net, sk->sk_bound_dev_if);
> >
> > Since most sockets are not going to be bound to a network device,
> > the likely() is giving the wrong assumption.
> >
> > Remove the likely() annotation to ensure more accurate branch
> > prediction.
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  include/net/l3mdev.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
>
> Reviewed-by: David Ahern <dsahern@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

