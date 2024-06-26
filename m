Return-Path: <linux-kernel+bounces-229904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D7C9175D4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 03:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68469B2106A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 01:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C52C14AAD;
	Wed, 26 Jun 2024 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atoNO+m1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E908C1A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 01:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719366336; cv=none; b=oLcobWTL2sko/z4sbXrgG+5Bk13PFj+VI7XACA+0eDDOhIK85mDiLNCFpik1dL7PiUJ/XZwa0sNRWS09DYDeXd8TQWqZDRvzaXuU62+x3h9qRPOjd/0b8e7Yy+epr5guNu4FYZdD1znlb/Qkrt/KM2dhKGKOLqgZ2Q0DhSntVdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719366336; c=relaxed/simple;
	bh=3u9DchcBWqEg+EucW73spHNC6ivrtjkXb6CPutXzAv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1oMkWVPnovNiBxGrZ9DvP7jLSuouAQpeMh1s3DMuRoMqc+tPvHjMRuh/Fq66FY4Kdwqxk3eVVGgQJw0ckonmM2wZcJLefguu0ERA0IbIhf/cfzAMke3TsZSnASOtS4+eE2SsDI1nP56PClstWApMr3EuHD1POhONpndElvUWVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=atoNO+m1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719366333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zm4ZGAMAEzALYJd1NNHLmIL7EFq9IvdfBHS2qeGf/kg=;
	b=atoNO+m197VG6DtJgYecELqKlhoe8WwuusCGQQcuF2rvrc0pPONdSp5lQ6jS9PGpY2IN5v
	UYmeO/CFhfKizDK6FA3FmRAew6jVFdxLPPcGZlUlviI8qPGzOrmLZqJJNPHcv6/WXG12Dy
	stkxPEksqPFKaOfW0ccWx7QKVfQywz4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-scc271YMOkyOo0Fdmx6FOg-1; Tue, 25 Jun 2024 21:45:32 -0400
X-MC-Unique: scc271YMOkyOo0Fdmx6FOg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ec617a3355so20813631fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719366331; x=1719971131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zm4ZGAMAEzALYJd1NNHLmIL7EFq9IvdfBHS2qeGf/kg=;
        b=LwHGbbb87Yf/6gLmcspYWIQJdO1eiuxXGeOPxj+4+eDScHVn4dTleFuNHl3rX0P4if
         HMrKw4xNys+HG219f1iyr+/P3W/6C0kJm0LEepvF18cpyT4iGtdttqN9lBL/fHZVrRMn
         +ndhmSQeAHhiJJL+feYcme0VgpiRRnIuQZLYxlziDNrdSmfJJq5mT0Rpi1zrpPxjAeZS
         ynP0L8s8okIHIDE5L5u3HgqWdtgPxm0LaYnOTJYfwkXh1sQBkp9+9fnB8w6ZrlDv8ouv
         6uGadGsfrMc34p/tld6Sy7TcAQcm2J3Zbj8r8vxc+wsQ9S3+ZxRHkslpzjjpbUn0z+B4
         3W1g==
X-Forwarded-Encrypted: i=1; AJvYcCU+yI1N4/ypxLvl0UCSvXPu4DHOOrefTDd6PI6051HOa01UcqdvVb0duocv7UY3KDjFKn3LfL/mmBKbDONhJXByjbqBxqPUo+RyUX4t
X-Gm-Message-State: AOJu0Yx5PknRV12haCV+6nh7WOTO21PIquWcUnRUpKxXBoeGrUftJhya
	Mr/yTdaM1RQToRWCFkjbT3614jEy2W59IpdIQd3P4hgkC6MxStyCrHJ2QmodGa3p55MpHE1yhY5
	XZmGaDMi/5ERjonomL7KkXTt8V/E2Ws6xiFhnwiPbTIRSvF7FFyeTQ3hncQFkr3sI5IkzCWhZJd
	TlkA7aCl2ueaL7fXh2pNPAywyiD7EXwRnYWl3z
X-Received: by 2002:a2e:9684:0:b0:2ec:53a8:4b3e with SMTP id 38308e7fff4ca-2ec5b387fcamr51824731fa.38.1719366330844;
        Tue, 25 Jun 2024 18:45:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFyfsfHjbw/eAr9nRtuFgDufzjtUAZeIkXSWW65AHErjzSV1gBpTz2ywqRAEU9I8YB/eCLbLpDjY7IGg0HhVE=
X-Received: by 2002:a2e:9684:0:b0:2ec:53a8:4b3e with SMTP id
 38308e7fff4ca-2ec5b387fcamr51824661fa.38.1719366330480; Tue, 25 Jun 2024
 18:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624141602.206398-3-Mathis.Marion@silabs.com> <20240625213859.65542-1-kuniyu@amazon.com>
In-Reply-To: <20240625213859.65542-1-kuniyu@amazon.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 25 Jun 2024 21:45:18 -0400
Message-ID: <CAK-6q+gsx15xnA5bEsj3i9hUbN_cqjFDHD0-MtZiaET6tESWmw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] ipv6: always accept routing headers with 0
 segments left
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: mathis.marion@silabs.com, alex.aring@gmail.com, davem@davemloft.net, 
	dsahern@kernel.org, edumazet@google.com, jerome.pouiller@silabs.com, 
	kuba@kernel.org, kylian.balan@silabs.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, 
	Michael Richardson <mcr@sandelman.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 25, 2024 at 5:39=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Mathis Marion <Mathis.Marion@silabs.com>
> Date: Mon, 24 Jun 2024 16:15:33 +0200
> > From: Mathis Marion <mathis.marion@silabs.com>
> >
> > Routing headers of type 3 and 4 would be rejected even if segments left
> > was 0, in the case that they were disabled through system configuration=
.
> >
> > RFC 8200 section 4.4 specifies:
> >
> >       If Segments Left is zero, the node must ignore the Routing header
> >       and proceed to process the next header in the packet, whose type
> >       is identified by the Next Header field in the Routing header.
>
> I think this part is only applied to an unrecognized Routing Type,
> so only applied when the network stack does not know the type.
>
>    https://www.rfc-editor.org/rfc/rfc8200.html#section-4.4
>
>    If, while processing a received packet, a node encounters a Routing
>    header with an unrecognized Routing Type value, the required behavior
>    of the node depends on the value of the Segments Left field, as
>    follows:
>
>       If Segments Left is zero, the node must ignore the Routing header
>       and proceed to process the next header in the packet, whose type
>       is identified by the Next Header field in the Routing header.
>
> That's why RPL with segment length 0 was accepted before 8610c7c6e3bd.
>
> But now the kernel recognizes RPL and it's intentionally disabled
> by default with net.ipv6.conf.$DEV.rpl_seg_enabled since introduced.
>
> And SRv6 has been rejected since 1ababeba4a21f for the same reason.

so there might be a need to have an opt-in knob to actually tell the
kernel ipv6 stack to recognize or not recognize a next header field
for users wanting to bypass certain next header fields to the user
space?

- Alex


