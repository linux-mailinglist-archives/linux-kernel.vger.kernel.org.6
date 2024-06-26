Return-Path: <linux-kernel+bounces-230884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAD791834E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 993E5282E9A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D55184128;
	Wed, 26 Jun 2024 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ScyVxO9V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA631822C5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409727; cv=none; b=d4JX7xBxyCIYy/jR9Zj5tVuYHwKbBfweCULIgd5/mWzXEBT+EiLCW0gYqUSPFqjW7CaNXVIkxi8jRhVt5NtTeZSJRmAg2C42YVYcoBJa6ufSxO8CUcNmHfA6j+EtI9TEL26+eq053qyEMG+Y2OnBqSFJaFa3Up6Qf2UfEqoVT/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409727; c=relaxed/simple;
	bh=cEjtRolDCfKQ9IvTMKrFmtTXKUoTDyiceEDQ9jpuSi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7/67z4wQlIk2wwmt6FdrOumPzYtkeuebYlvPou38LDZQPOavhWtvi90wdZfF/FTiyGok6yyVPTlJYVaP+hOrOaf4X6DSUwN6eiHU1/9/9OeZHp8RjUNaut6/8x4baW3IwRvxfekXJdCRTeDFcL9qXW8V7yV9sJ2kApz+H1zDhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ScyVxO9V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719409724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hvXKpAHhZexkNIvChdHi+nkqCcOCNF/XIjN6+0tv388=;
	b=ScyVxO9V7izyte1/VSXl9WuSFittqVwfaKnOTcu7LLdYHWRPMCTwZIEdMcDTZH91G2ADGR
	S59/YGiivt3iSkag+DQkDvNrFzFvAOBBsBLIiBeVVFNXORpb2PIm+Ex4dFjdzCLNMSP3Zg
	BgIrrt1/cqI8BhKF0ZOwppvaPlHuFmA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-wA6yUkFrM2aCZmJN9weuTQ-1; Wed, 26 Jun 2024 09:48:43 -0400
X-MC-Unique: wA6yUkFrM2aCZmJN9weuTQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ec681f9c54so18618701fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 06:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719409721; x=1720014521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvXKpAHhZexkNIvChdHi+nkqCcOCNF/XIjN6+0tv388=;
        b=nU/SarqplkXpl64K/L9qU8UMK3ofbmIXbCkU49ZbaOQNY5uylr/2iCImo6QG1l3TER
         c+FU1K2NpCwgCxOEm3J78ilwZ44aj8+TyCzlZaV5DfL+boXSH4PDMXN9fxeeP9MzC0LN
         s5FofEmPQbA41U+OV+l2hdXiK+Kt0ACW5sPbCpzoKuhWLPHDIpjV74X3t9ruqRWFVViB
         HMWn1uvhDdkVf3keoz6G2Zk4McHfQktgzYx9DEG5uiJPNHscsjH3G1YnJ9/2el37AEU/
         HZ1WYEU+hl9gOVKAq+0A2DwO2LczbRYkXC9BY1jTh66Rkg3aTjnnnlNN88cMl0NkKYV0
         S2Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWdfLzNbcAalQZn8j4I0UafOgpULHhV/zsDRhAKoj7bVMWYAlC2bom7UDwB2cK8cNaC3MrUetqwrmhh03zoBUK8+KrxdkaAxtMrHe+f
X-Gm-Message-State: AOJu0YxgLbPQvisbnVJzaHKGNWtjT9ml8QakyMDTAZ0pz+3KW7lF2nk2
	jp0TAwHXDVmmvqRJqrqIqEBQ6WwkBcxAlyTloF22V0x/pJK19rf6UK0uVNQfrkkEEYjVE2ZjsyV
	1RGyyDGdRxojjyvjb3NKL422EBqXF2p5WCvqnFpobEiZ4C6KuqyX3ehDHhvS/wNVy7VnFIAisv4
	tP60mubfRAjhFMLkUMlij4RfD0Iqp8irxxqNHy
X-Received: by 2002:a2e:6808:0:b0:2ec:588d:7ecc with SMTP id 38308e7fff4ca-2ec5b27a875mr66146251fa.12.1719409721678;
        Wed, 26 Jun 2024 06:48:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWr9A8HlXr3cWn0bW10jR/P2yGKk2CEGLW8OPrjvtvXaetA9H/5QUUzENARZAZqSPVij/rzCu3ObGzbE48Ntw=
X-Received: by 2002:a2e:6808:0:b0:2ec:588d:7ecc with SMTP id
 38308e7fff4ca-2ec5b27a875mr66146081fa.12.1719409721300; Wed, 26 Jun 2024
 06:48:41 -0700 (PDT)
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
Date: Wed, 26 Jun 2024 09:48:30 -0400
Message-ID: <CAK-6q+hRz-M0hy611rDZhiF7CVUSD1FmPGMLGNBhVJ-CjSFqtg@mail.gmail.com>
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

makes sense to me. I am asking myself what the exact reason is to have
the difference between "recognized" and "unrecognized" to judge more
about such change and what we may miss here to consider?

- Alex


