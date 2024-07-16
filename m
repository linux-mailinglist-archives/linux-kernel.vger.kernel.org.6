Return-Path: <linux-kernel+bounces-254464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AB093338D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 23:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D1942836CF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5F113A869;
	Tue, 16 Jul 2024 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8UkSDkB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08883CF4F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721165238; cv=none; b=pouohiYcwbrTTKt0Rp9XpbFii7orAuQIszgL9bReNRHpSGrxBz/6d2d8B9lymCzDTlD45BBIOxEHNq6Ivqau/NlLCYHS5X6s1ojTXS/Pq6y2SvA2mFMdKTp15TXGKscIRqG8/9nwaSURMUzhOl8rGHiSvhyWVjyRuFUAfd1kpCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721165238; c=relaxed/simple;
	bh=SGzieUQEpX16lgmk9mW82QaAzlznyacCBQJzom4R2r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BixKjWjH7XPaFVU+pvhKrSqMRKIhmMdBNC3acAaiX5MEAGO/X8O+RLTJKjHzk2TlNDB4i/dp82pacDja4eQjlH+EqounkMis2TDZQgCwN7K+wvrTt9BkPTYxWY+M3KPnPdIs4ghRsqngqPPTzSprhw50y5nDxMRog1tF1qETONM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J8UkSDkB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721165236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxB9jk333dC6G4q0E0+/79K2V4qLrZ+brHs5Bi9B0aY=;
	b=J8UkSDkBWZpMqELaux4lyFzkGd2K5sZh6oWsLOSBdk4PrUlMw/Of5zTbHJ1b1iPDLUpkBL
	GrvJRftJuwOFThz+3FJp3/tO2QOk0g+F6CXGm1If7Z07pEqroKfWlo3V9/3EvUgT7LpzML
	JStrS2nSmqx6mZgYqTNT8bt0hfPSQa0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-Sd2KNR0xNi-5_YJ9VKVyTQ-1; Tue, 16 Jul 2024 17:27:14 -0400
X-MC-Unique: Sd2KNR0xNi-5_YJ9VKVyTQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ee8d83db53so62334751fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 14:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721165233; x=1721770033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxB9jk333dC6G4q0E0+/79K2V4qLrZ+brHs5Bi9B0aY=;
        b=TLdK3Nx/B6gMu/059wEs0G8uNrnQG7p92tU/im4+UC2jm9rcH2XX2iO0Qa4KZZfq4T
         /50ym2541U6llq500bVYGQT/jGQDkoABiJqKtiKpp89NIlYxBhXmz2/0pZJ4fOzqOe7S
         RWRCg87Ip1IeO58Gu4PG8+2EgHpQGxLtwFbi8Nlwa55QWB+pojD9sqE8V4Zwi9epEpCk
         0kWsh0c2JJd0fJn6OeGUY2AsbEngFbK5WWSppf4vWiJjMjnT9EJpihW5fAbTRg5FTCDk
         nXiwcvoJV1gDzKo9z/QtyPQTWpZAL1Nmys6pYnFA2+4/11RV4WR5YTE3WEwmngjskhOP
         IMRA==
X-Forwarded-Encrypted: i=1; AJvYcCXxELSGFQow8jIYl1vurLOz1NsMVCUpypMp6LlMjoWlHkwPWuAYlT0HomiwshHbk9AJc8nj+dpLlNxp3jW1UINUFwAAzxNbrmklO9pq
X-Gm-Message-State: AOJu0YyCNkbkW6aivmlI1+pZbgc67NYk/FIl7hbclKcIc1iE6eIEyXBk
	TLk0aSB3F860XVwaiYSUlIzhRYq6ETkGWwwT1NggIq6XoiLTyxJlTMEfi6G4HGd9GWbhn25dMgA
	5wPFVYi6Dx03DZc9CSHu38slGWK3BzlmLvqDt1NGTcqcpDC4Bdi/ZkgM0pYZdX4VfyP406LfRyl
	IuqXHZksKMseZpuO5hnPKcq0LU+KF62FsK4aDW
X-Received: by 2002:a05:651c:a09:b0:2ee:9521:1443 with SMTP id 38308e7fff4ca-2eef41d8e15mr35802731fa.35.1721165233098;
        Tue, 16 Jul 2024 14:27:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD3D037h/+QhZR8p/keq6zeLkUSWI2I6aUtc7yuVtgVxyAyui7505efWXvWtNyBzMyLxdQnF3i3LLzkG/aIsg=
X-Received: by 2002:a05:651c:a09:b0:2ee:9521:1443 with SMTP id
 38308e7fff4ca-2eef41d8e15mr35802491fa.35.1721165232698; Tue, 16 Jul 2024
 14:27:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624141602.206398-3-Mathis.Marion@silabs.com>
 <20240625213859.65542-1-kuniyu@amazon.com> <CAK-6q+gsx15xnA5bEsj3i9hUbN_cqjFDHD0-MtZiaET6tESWmw@mail.gmail.com>
 <0fc38c1b-1a28-4818-b2cc-a661f037999d@silabs.com>
In-Reply-To: <0fc38c1b-1a28-4818-b2cc-a661f037999d@silabs.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 16 Jul 2024 17:27:00 -0400
Message-ID: <CAK-6q+jm51Co0k6cR0fMDXxJiM2G8z_nF8LjrcdCcSnGrap8EA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] ipv6: always accept routing headers with 0
 segments left
To: Mathis Marion <mathis.marion@silabs.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, alex.aring@gmail.com, davem@davemloft.net, 
	dsahern@kernel.org, edumazet@google.com, jerome.pouiller@silabs.com, 
	kuba@kernel.org, kylian.balan@silabs.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, 
	Michael Richardson <mcr@sandelman.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 26, 2024 at 6:10=E2=80=AFAM Mathis Marion <mathis.marion@silabs=
.com> wrote:
>
> On 26/06/2024 3:45 AM, Alexander Aring wrote:
> > Hi,
> >
> > On Tue, Jun 25, 2024 at 5:39=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazo=
n.com> wrote:
> >>
> >> From: Mathis Marion <Mathis.Marion@silabs.com>
> >> Date: Mon, 24 Jun 2024 16:15:33 +0200
> >>> From: Mathis Marion <mathis.marion@silabs.com>
> >>>
> >>> Routing headers of type 3 and 4 would be rejected even if segments le=
ft
> >>> was 0, in the case that they were disabled through system configurati=
on.
> >>>
> >>> RFC 8200 section 4.4 specifies:
> >>>
> >>>        If Segments Left is zero, the node must ignore the Routing hea=
der
> >>>        and proceed to process the next header in the packet, whose ty=
pe
> >>>        is identified by the Next Header field in the Routing header.
> >>
> >> I think this part is only applied to an unrecognized Routing Type,
> >> so only applied when the network stack does not know the type.
> >>
> >>     https://www.rfc-editor.org/rfc/rfc8200.html#section-4.4
> >>
> >>     If, while processing a received packet, a node encounters a Routin=
g
> >>     header with an unrecognized Routing Type value, the required behav=
ior
> >>     of the node depends on the value of the Segments Left field, as
> >>     follows:
> >>
> >>        If Segments Left is zero, the node must ignore the Routing head=
er
> >>        and proceed to process the next header in the packet, whose typ=
e
> >>        is identified by the Next Header field in the Routing header.
> >>
> >> That's why RPL with segment length 0 was accepted before 8610c7c6e3bd.
> >>
> >> But now the kernel recognizes RPL and it's intentionally disabled
> >> by default with net.ipv6.conf.$DEV.rpl_seg_enabled since introduced.
> >>
> >> And SRv6 has been rejected since 1ababeba4a21f for the same reason.
> >
> > so there might be a need to have an opt-in knob to actually tell the
> > kernel ipv6 stack to recognize or not recognize a next header field
> > for users wanting to bypass certain next header fields to the user
> > space?
> >
> > - Alex
> >
>
> My point is that if a particular routing header support is disabled
> through system configuration, it should be treated as any unrecognized
> header. From my perspective, doing otherwise causes a regression every
> time a new routing header is supported.
>

coming back to this. I think you need to add another switch to do that
and turn it by default in whatever the current default situation is,
otherwise this patch will break the next person's behaviour.

- Alex


