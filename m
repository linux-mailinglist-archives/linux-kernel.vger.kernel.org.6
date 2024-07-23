Return-Path: <linux-kernel+bounces-260436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9B893A907
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 00:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A511F2336B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 22:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE822146D7E;
	Tue, 23 Jul 2024 22:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m6lCMWhL"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67FD143747
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721772102; cv=none; b=jXVvpGYU6XA+CKU+fzd73ZyhaZCJMabrZPOOkxyx6CCCh+XQYKm76Jkc3oJkBl3GedafJzDBNeH/85gZuu6Ov/Bf2r+6uyH7UHNfT1Xn4Q+EA1ngc+LAZLST8RY0nOppUd+L+Qr0/tjrf71r7o+z0l5eoIKu8xpSP2JUVnsRQxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721772102; c=relaxed/simple;
	bh=5xVlqisSBJYMgU9MzkbYusXo6EHS+CLhw7wKUYkGMG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/8Qpnuegm3wFewLjWQYgKDhsJ/+MYq8b8m4u6VKsF6peHrmiaQmVVSXF7LOfd3Bg6sUA729OqHRmvoKA22lB2QcqNowLQx7deyGXlUVAeFhDB8Xo7Mc05FX7Y6KYz4XRw5EF3QtnRYABnFCMO601sYavERPufmxuJBGtZp6Rr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m6lCMWhL; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5c6661bca43so3076248eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 15:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721772100; x=1722376900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RbOzRw1HgFS5DEp3YsvL3ixVExK5DUcKmrah8c6zUo=;
        b=m6lCMWhLPPOR0ffCQY6MJaTN4WtwShmCUMJMI7GFf6Go94HAjbTOZCQ/99OdTIQDfO
         Sea97itjk2lM7q9DvLAdyJzlZWwMRTe7Se4l4ClkbLbCAGqM7EVi47r6cBI7b4AbEe60
         S+Fdp1gWJAIe2mYbL74tDHt9xjMh0NgZide6trtBJDS74v0QXqvjBF3mP49yF7CPl22L
         nWFAyrVxs16/cFkWlJ2vj5j1oIZJ4GDX2AJac7HK6fFVQrQwLcRhcqfJdUhSkNvTTV72
         dEMRgEMgyoA4yzhV+QuqIDSOR5cyEy4OJwWKHuX0vBhXBtIzN/348QvDOKopqRNEMA6h
         nfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721772100; x=1722376900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RbOzRw1HgFS5DEp3YsvL3ixVExK5DUcKmrah8c6zUo=;
        b=FC0PRf43qbYMH4SvxnVD1DRgNqWQPqnYIhWoEjmUlVMNxx8YHRZRIHGjBFqQTKlzQO
         YCvYd6CcKX//i0gEfO9cvHCiHhFocd3XeRopEjJ3XfKIMZb4O4Kd5jXJEvPH9CXPiDGe
         0shkbmXxgwdvZyq03LNbbkl7XjNGY+eorGnTzTvHSU0XXt3EdaOJeF1yyrRW6GsylQ/P
         jVo75Sw2SVEXNXln5OqjLZe57fOqeQt0ToFWcbepFNczGze55HAPRtSVWZRMaMVkXNM3
         +E7iwjYhzNA/fSqRuhcEolraVfIxudhJ1ER4Qzs1PNa2qnWDfVHLTSG5TveJAS90qC/T
         wuKg==
X-Forwarded-Encrypted: i=1; AJvYcCV5dcdubIdoiAMQRPRYSsKgYPmrqnRMYRl/8gVvc2pfpihGKtbtbK9uEdWtJR+3oU+4emHs6JPz5NO0e/6Uhu1dLdmTI9ZBWTvnHAY8
X-Gm-Message-State: AOJu0YzAxHcLErA96bRUPbRsTC/HqVQ/abQfMyWhcCkP0peQBE0C/gnZ
	nRoY0zpYET0geYNlrYBBK2rUVeHH6pW8Z0QBcNgcmbC0+0eNbz7osiihW87x7bearu+3EsJEtm2
	43xWYtAmt2wzMgykf9LC6Awjfy/8vDnF2EIVj
X-Google-Smtp-Source: AGHT+IG52jqWawXgN2kcOVQKAVuGRKQsz6erICJGp/9Nf2OmyPDQUG4y71nh5l7MhmNmqRHohI8zQDyyM5Dy7lSVDY8=
X-Received: by 2002:a05:6358:297:b0:1aa:c73d:5a8a with SMTP id
 e5c5f4694b2df-1acc5b10dc0mr1273554155d.16.1721772099135; Tue, 23 Jul 2024
 15:01:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-0-d653f85639f6@kernel.org>
 <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-1-d653f85639f6@kernel.org>
 <CANn89iJNa+UqZrONT0tTgN+MjnFZJQQ8zuH=nG+3XRRMjK9TfA@mail.gmail.com>
 <2583642a-cc5f-4765-856d-4340adcecf33@kernel.org> <CANn89iKP4y7iMHxsy67o13Eair+tDquGPBr=kS41zPbKz+_0iQ@mail.gmail.com>
 <4558399b-002b-40ff-8d9b-ac7bf13b3d2e@kernel.org> <CANn89iLozLAj67ipRMAmepYG0eq82e+FcriPjXyzXn_np9xX2w@mail.gmail.com>
 <9c0b40e5-2137-423f-85c3-385408ea861e@kernel.org>
In-Reply-To: <9c0b40e5-2137-423f-85c3-385408ea861e@kernel.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 23 Jul 2024 18:01:19 -0400
Message-ID: <CADVnQy=Aky08HJGnozv-Nd97kRHBnxhw+caks+42FUyn+9GbPQ@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: process the 3rd ACK with sk_socket for TFO/MPTCP
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 3:09=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Eric,
>
> On 23/07/2024 18:42, Eric Dumazet wrote:
> > On Tue, Jul 23, 2024 at 6:08=E2=80=AFPM Matthieu Baerts <matttbe@kernel=
.org> wrote:
> >>
> >> Hi Eric,
> >>
> >> On 23/07/2024 17:38, Eric Dumazet wrote:
> >>> On Tue, Jul 23, 2024 at 4:58=E2=80=AFPM Matthieu Baerts <matttbe@kern=
el.org> wrote:
> >>>>
> >>>> Hi Eric,
> >>>>
> >>>> +cc Neal
> >>>> -cc Jerry (NoSuchUser)
> >>>>
> >>>> On 23/07/2024 16:37, Eric Dumazet wrote:
> >>>>> On Thu, Jul 18, 2024 at 12:34=E2=80=AFPM Matthieu Baerts (NGI0)
> >>>>> <matttbe@kernel.org> wrote:
> >>>>>>
...
> >>> +.045 < S. 1234:1234(0) ack 1001 win 14600 <mss
> >>> 940,nop,nop,sackOK,nop,wscale 6,FO 12345678,nop,nop>
> >>>    +0 > . 1001:1001(0) ack 1 <nop,nop,sack 0:1>  // See here
> >>
> >> I'm sorry, but is it normal to have 'ack 1' with 'sack 0:1' here?
> >
> > It is normal, because the SYN was already received/processed.
> >
> > sack 0:1 represents this SYN sequence.
>
> Thank you for your reply!
>
> Maybe it is just me, but does it not look strange to have the SACK
> covering a segment (0:1) that is before the ACK (1)?
>
> 'ack 1' and 'sack 0:1' seem to cover the same block, no?
> Before Kuniyuki's patch, this 'sack 0:1' was not present.

A SACK that covers a sequence range that was already cumulatively or
selectively acknowledged is legal and useful, and is called a
Duplicate Selective Acknowledgement (DSACK or D-SACK).

A DSACK indicates that a receiver received duplicate data. That can be
very useful in allowing a data sender to determine that a
retransmission was not needed (spurious). If a data sender receives
DSACKs for all retransmitted data in a loss detection episode then it
knows all retransmissions were spurious, and thus it can "undo" its
congestion control reaction to that estimated loss, since the
congestion control algorithm was responding to an incorrect loss
signal. This can be very helpful for performance in the presence of
varying delays or reordering, which can cause spurious loss detection
episodes..

See:

https://datatracker.ietf.org/doc/html/rfc2883
An Extension to the Selective Acknowledgement (SACK) Option for TCP

https://www.rfc-editor.org/rfc/rfc3708.html
"Using TCP Duplicate Selective Acknowledgement (DSACKs) and Stream
Control Transmission Protocol (SCTP) Duplicate  Transmission Sequence
Numbers (TSNs) to Detect Spurious Retransmissions"

neal

