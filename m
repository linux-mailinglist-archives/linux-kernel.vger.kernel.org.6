Return-Path: <linux-kernel+bounces-448625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB849F4318
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 06:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9095188D5E0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 05:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE67155CB3;
	Tue, 17 Dec 2024 05:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ql8e6YBa"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB134A23
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 05:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734414156; cv=none; b=SuaalZOEVYr3dYjAIb/t9dS+F0+X9ktQVI72yPR7TGa34wVAATYTupsCAUBKMH5Yy0HuhFx7ZTWJTSSOaiOtkU3MnHad/1qacEil/EZUZNqvTnkC6MJRxYynjAQVNnt4Be0DrFl4nIDhG1FbsdL6HF6Mk2sC47ODSXbM7+00hGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734414156; c=relaxed/simple;
	bh=cPivUNa56W6N1sStio3q00/3N/9gTc/US/eop8L90hA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwMwuU8nwQj8TqKXXNFWZ58g8uFnwjxwMdB7hnb1nMzYn8GldkxIEjQBnKBntBJjizZ0BtOu9KBnDripr0uokP3+i9mvp1Tx/PXriBAAgO9ICl97fk/0fp4UpYwnZP7gCMOA8pxcv9xok/LTG+LYvOdp6Rpjy3LucaMLm8BMtfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ql8e6YBa; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso7746534a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 21:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734414153; x=1735018953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUg1bki9qmjd3PJLJEpIdRdHInyz217prumbOrfoS3g=;
        b=ql8e6YBaYVJT3fnDO5wVghkTxP3/2RWDtk2s8BqWrmg5oBbOVGP3IXzN+L70AkDrQK
         +cd8ueNvmx2VXB0qw+MBQZOaZuy0i7X8PZdfVIpJSQ8hjeFOfKH/9FtyX/tPpu7exK2t
         c9b7FiL6fb7Hjx8eq0o78i6ssO3+8VRN8sYKF5t8do8leyPZS2Y4ft7dWow3FazQbRka
         UTbftJm45qgybNn9o+99y1jxHz7fLQRDpAxlWWTbg9XhGbWum6EpZ3vCuEo6XwBXwzz2
         h19WiR0Edc0+1GNA9IOoq2xpXzp5RGIvjjOsPAcJ+6kHU9Ck8PDWlh4XBBsWeJQGh6AI
         DXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734414153; x=1735018953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUg1bki9qmjd3PJLJEpIdRdHInyz217prumbOrfoS3g=;
        b=Thn1VGAicU+F7ltMNSlgW6/Qr6C+tsJOWI8uQ4woejO0bGuyS1bIErPINRdE2TjqRt
         /Fv/oJgkIVmo+PYJABbRUMB7mi9XL2FcfhaX+v0OsxTug/G1dmbYjCAjM58jvemAn9+R
         y0PzGO9fJ0ScAJ6opBVQnjXw0KVRUfTXgD9E6YuEziok+GfxbX0QOsJDL+LIgVoZffXy
         fCK36+ox6BcjjJp6H8Zi60ckpXIUTOU2TCD9Yo8ZyPw6vyQIELKZydi9IatW0NJC37TD
         wNrZISDapF2YnJ27XTETRgN4P+sA6OZrXfEqmbbqUo9BuW3WKWS37O5sbaKN9XLEBl47
         5frg==
X-Forwarded-Encrypted: i=1; AJvYcCWpkI57gmp/hgspHIwWJpA4VndOQCAcRW1Ismq6CqlAlElwWnj9LB7I/Sr9iTfm5EOINzicr5qihco+mAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyscl1n84U/6dXut8dWxYJmsEQvqRILK9XvGLTujb7BwfbPc+Mg
	66duryxHAzNuMus+rrbGvcXoZPFcfv/+9kYjAP0lud3nqls1fno5D2UT/wKWtMYp28dEadmpYhQ
	G0rFI97qliYLUQLRObkVW/+Oyr3zHveG6efBI
X-Gm-Gg: ASbGncvArhEj+3jUhxRk0IUb+BlxDzaNfK2ErwWlB6OY8q6GQ3uJt8AkOKOECwSOxW0
	DFIZPd0YipX6xTm+t3/SF2YRQhrCD2bvXZh7B0750nD/+1IlG5Nu8WLcVn9CSArNaJSipYb2Q
X-Google-Smtp-Source: AGHT+IH99quBmvN2TDeWTDk539NK15McxLqg0X/XtBmhtgNOj1cVTY+zUKR7hJOqgfEiiueQ2zMaCt3FvZjmiR62mig=
X-Received: by 2002:a05:6402:1ed5:b0:5d3:e79b:3b3d with SMTP id
 4fb4d7f45d1cf-5d63c42a44dmr14015978a12.28.1734414153242; Mon, 16 Dec 2024
 21:42:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217030751.11226-1-mazin@getstate.dev>
In-Reply-To: <20241217030751.11226-1-mazin@getstate.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Dec 2024 06:42:22 +0100
Message-ID: <CANn89iJeh5wCRpiBBBucmJXRdTb=DbOjXTHtEm1rOpvq=dGgvQ@mail.gmail.com>
Subject: Re: [PATCH] ip6_tunnel: Fix uninit-value in ip6_tnl_xmit
To: Mazin Al Haddad <mazin@getstate.dev>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 4:09=E2=80=AFAM Mazin Al Haddad <mazin@getstate.dev=
> wrote:
>
> When taking the branch with skb_realloc_headroom, pskb_expand_head is
> called, as such, pointers referencing content within the new skb's header
> are invalid. Currently, the assignment of hop_limit accesses the now
> invalid pointer in the network header of this "new" skb. Fix this by
> moving the logic to assign hop_limit earlier so that the assignment
> references the original un-resized skb instead.

Unfortunately this is not fixing anything.

If the IPv6 header was in the skb head before skb_realloc_headroom()
and/or pskb_expand_head(),
it would be copied in the new skb head.

Note how the repro is sending a packet with vlan tag (88A8 : ETH_P_8021AD)

endto$packet(r0, &(0x7f0000000180)=3D"a6bea8a120e5f8320c30ce5088a8",
0x12, 0x0, &(0x7f0000000140)=3D{0x11, 0x0, r3, 0x1, 0x0, 0x6, @local},
0x14)

Current code, using pskb_inet_may_pull() is not ready yet.

My patch has been tested by syzbot and I was about to submit it.

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 235808cfec705032b545d6f396f8e58f4693e8d8..c4f0383a136cf5f5e6846293078=
ec8b826c754c9
100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -910,7 +910,7 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *s=
kb,
        __be16 payload_protocol;
        int ret;

-       if (!pskb_inet_may_pull(skb))
+       if (!skb_vlan_inet_prepare(skb, false))
                goto tx_err;

        if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
@@ -958,7 +958,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct
sk_buff *skb,
        __u32 mtu;
        int nhoff;

-       if (!pskb_inet_may_pull(skb))
+       if (!skb_vlan_inet_prepare(skb, false))
                goto tx_err;

        if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))

