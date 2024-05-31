Return-Path: <linux-kernel+bounces-196371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D1C8D5AC8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248871C2239F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C958060E;
	Fri, 31 May 2024 06:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Xsv6f/Op"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E860212E68
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717138305; cv=none; b=XPiwF2tBNwn0LKK9yT2O8XhrzlXkSiyj4jPdtohjgMmxQMs5jr7jRB1RYt7WzBnCRQ69L33unWg3J1ijphxwkv62Kt5CxYXZ9b6fMDUPXQLr8f8TQ58UEJ0xfH2aCKPnknA6WExZjS/Ra1hKt0acLnklHAAT4L/Z++3TVIYGnLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717138305; c=relaxed/simple;
	bh=2RWBcRuI5JRmtU18wBQ6q5Z+twyv3/m4zREUwhLt8aM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sxlPqHDy0zfeSrYVosQYaoR7QsRQrKOmSwALmG494FDWm7oPcgnEXIsmpN6fFY3AQ9JzgMDm/eYwyXovCM8M60prRmaSBH2NNEXF7t9nZfWevF04KA+1t5AsApAD1vTlbz4SmpZGY3KI20nCoHHYZOmDapnQEOHQ1JA0cEY/ZXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xsv6f/Op; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so9707a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717138302; x=1717743102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzIT2VZ2rHX1hVdVcuQEFyKfNmye58PO7QacsBxeUlk=;
        b=Xsv6f/OpEAe5AB7rOSaO9c/z9YCyRGH9nxMzAQB7TyP9kQQ4ff0Rbv3nPr0jUQ1Gcv
         712pVKf2kdIj647G4j/itl3f09XyqNI3yG3bNTPRCINJs6xbJDPWKZHJTie2jNwZp3ul
         d1aOWBD5xhaQBaHqNN11S4XTF0drvnKIo7m6i9quATCgzsGGVnNJs81P4ZYXwYDbAtDk
         2VVaDMlnOSaGXQmri0bsllSfAuXyY/4XB6BygkbTBPjVosbUBtsiaiXMnI4Shynk4FxP
         lRQdFu8Q4YWTe0wDkEvqT2dCL50NCHk6+45wwUtqxD5y/cWPPFZqa+PXYtLbf9Oivagw
         z0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717138302; x=1717743102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzIT2VZ2rHX1hVdVcuQEFyKfNmye58PO7QacsBxeUlk=;
        b=wXAiseWlxb0Sxp/7Bn109cR4W4qM+JyvNBpFAHCwwEe20xzeDIGVktHHJZLGVh2usY
         y/1yaF0E6hYTQEwIERClkUZed2rA4ed4NEjiIEjFg6DUTnG5KnXq3yqCiUpwb2zwHO8B
         4hwmYSWuq0RWUFSvR9DHSXd1mlK/e1bi4NyhO6vrmFK1Ar5Tof05ZuR/HvsxNpeVHNxO
         GL1KVMgS1TL8vPYGIs9inlmyB6KTmNkFWvd9BtbAG9O/jiT6bFJef86P7hKZlVs0FOUH
         qlCkVX3I3sppAd5+6Q8UMRQX3zbSuxyr3jZDj9+spjmdjLmPXPBdVQHD1hQj0b1X66To
         lQTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwUeXuAEfgLVUD8nfnKSHwAcv9r/QHNFfXDKH5njT9KOlD8+aJiCrEL9uATvkFIjLK+TcXpF8ryWOuUvTWGx3Leh5otXYXSfd8qQzL
X-Gm-Message-State: AOJu0YztoSCKIPmGU3QCESN80DTHftWC0uUF5QxQ4TSYx9LM4MAH+uZs
	h2WgtcEHCAz5Px6R8EKUR+bkfZyvibbiiOLt0bFXCynBkY3jDoBrGNE44KHfKFcBPONhqOBRcKN
	Yuxx44rnZM8Jk3eMthIWf6g4E70wmei4fIIlk
X-Google-Smtp-Source: AGHT+IH9G9rpU2GQq3pusZBiY8IaNqJOBhMA/IkgHi7CVpn3ZjSHl66WTw1UgNcvmN6jqwIJfWjhNJkqzIDDj88OcPE=
X-Received: by 2002:aa7:dd06:0:b0:579:c2f3:f826 with SMTP id
 4fb4d7f45d1cf-57a33c78851mr97467a12.4.1717138301997; Thu, 30 May 2024
 23:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717105215.git.yan@cloudflare.com> <9be3733eee16bb81a7e8e2e57ebcc008f95cae08.1717105215.git.yan@cloudflare.com>
In-Reply-To: <9be3733eee16bb81a7e8e2e57ebcc008f95cae08.1717105215.git.yan@cloudflare.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 May 2024 08:51:30 +0200
Message-ID: <CANn89iLo6A__U5HqeA65NuBnrg36jpt9EOUC7T0fLdNEpa6eRQ@mail.gmail.com>
Subject: Re: [RFC net-next 1/6] net: add kfree_skb_for_sk function
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Abhishek Chauhan <quic_abchauha@quicinc.com>, 
	Mina Almasry <almasrymina@google.com>, Florian Westphal <fw@strlen.de>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, David Howells <dhowells@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 11:46=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrot=
e:
>
> Implement a new kfree_skb_for_sk to replace kfree_skb_reason on a few
> local receive path. The function accepts an extra receiving socket
> argument, which will be set in skb->cb for kfree_skb/consume_skb
> tracepoint consumption. With this extra bit of information, it will be
> easier to attribute dropped packets to netns/containers and
> sockets/services for performance and error monitoring purpose.

This is a lot of code churn...

I have to ask : Why not simply adding an sk parameter to an existing
trace point ?

If this not possible, I would rather add new tracepoints, adding new classe=
s,
because it will ease your debugging :

When looking for TCP drops, simply use a tcp_event_sk_skb_reason instance,
and voila, no distractions caused by RAW/ICMP/ICMPv6/af_packet drops.

DECLARE_EVENT_CLASS(tcp_event_sk_skb_reason,

     TP_PROTO(const struct sock *sk, const struct sk_buff *skb, enum
skb_drop_reason reason),
..
);

Also, the name ( kfree_skb_for_sk) and order of parameters is confusing.

I always prefer this kind of ordering/names :

void sk_skb_reason_drop( [struct net *net ] // not relevant here, but
to expand the rationale
              struct sock *sk, struct sk_buff *skb, enum skb_drop_reason re=
ason)

Looking at the name, we immediately see the parameter order.

The consume one (no @reason there) would be called

void sk_skb_consume(struct sock *sk, struct sk_buff *skb);

