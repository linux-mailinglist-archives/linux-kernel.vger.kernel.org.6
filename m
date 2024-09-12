Return-Path: <linux-kernel+bounces-326115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2689C9762CA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D835828179E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D65718DF6F;
	Thu, 12 Sep 2024 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CX5VzK+J"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6F718858F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726126540; cv=none; b=lKvuC2wIf6mskn0zJRznXobjOQC3JR9g2Qdsvf5ZM+TTx+MNeRF4l8V3o3BMyuT3LolNtiYUpmZsic18BJ/rveDDyQCHs+6hC7cXpkaYeLHlDasY/v4KUsZmHGRvQH82ozinz2U0RLkPThKk6ZUHcwNiL/Dcra319LIubUgl5/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726126540; c=relaxed/simple;
	bh=uhFaBT3eSnVu4Qfkz/ZQSlU7RrPtKmeYKr5aDLq+vZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulKDKhzuKiVnF/SkVNsg5XRPd9zdWxIVuinzhUWQfZQBaNHUysKooj592jtjyZnhjlnY+yXVhZ/BRj1Xn0HTDcLqZdJEE4T3dVRXtm9u5+6/x/yk4K+65WvaGuU9Dg5eIKhdye3oNzSh/3PF5ToAP6YA115Jhw5Oz3EHxpJy12Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CX5VzK+J; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c27067b81aso694666a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726126536; x=1726731336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0hFF9Ufg5tJAUtGx+1QcEX70VmZ5BNJfaBbgW27+8M=;
        b=CX5VzK+Juc7Vp49Uh4DtPTbeLtE9p4GFhSw340pvFBL6Fn87T1nbbgqutS62vgS95Q
         pi64TzMf1vc23e35vm07c34luOfAIoO7HoEEFPVeWigSFRJVYM4qLIJRzM/WgZukFiu4
         C1ugQPzWq99O/QH8SljLRZQuwZaIR0nVZkNHHqRCmMCRxUSS93vz/t5rFsWCI0gGGZDM
         /T1nERIjrmpY1h3nLnch6bpAuy3JLNs84HhcniA/ZLMTK/IPY/iUsGmz7v8xAQNjPwJR
         SRSmuNXXfXoLNCwvT9OfNYuSigrZy5oKlP58sr/Fj5oH7KrgxBIGyMQShUHRMU0k5avl
         G+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726126536; x=1726731336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0hFF9Ufg5tJAUtGx+1QcEX70VmZ5BNJfaBbgW27+8M=;
        b=c/w1mN33fp2w/Q2YopoGEiixvU6+pqdgZR+lWMoAW5Nq9Q1rjVcctyAoB1iZ25JI+/
         i868l6NOrCMWNqVIYESpKdJhbxGBacS6mk9BkP5cQ31tVeGm1kEjlIZN9UCPyZUDYw0K
         dXa0zND3XuPb+6syb7bOcOtb839VZopTE5pKI1UHZImIkvba7TCOmZpz3WP4RZzD34p1
         o6M5BXNWJnz0D4LYQQOTTpiee/aUK0ad8LDmzQrccdBTbpdkPHdQ1sbcrzpV32M7ZH76
         oajT6gs5hZXYkyQB38XhUpUJr5HorRholtBlIQTIYTcoUKkGiwtY5vpiBQ7E2D718yMf
         utTw==
X-Forwarded-Encrypted: i=1; AJvYcCXlKfuoYc9SiAKPhD2A8uk5lHN2bO+zaKakvUWFk7q0VUGt2JLKT4CsNmZ5/nkQCrIhzsERXWaoKKxZ6LI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGSZmnyXl4d81Q8OY9bsufEzcExoSX/+gghynwjeP9PKHX5rxB
	xQg+cp9KQKf2gzkZi0jq6riD/u777feC5N165cYjwAuC/wFrm8/0Rp2U7ihS49uS3HdRRI3S3qH
	qyKtTor4K06rg3tHkzNfK2ySna394od+mYKHA
X-Google-Smtp-Source: AGHT+IFcXvb5XmwiR+MJ2LMIHHLGzLdAhP6xrcp+BGvr2AUERIhvmKbyioD2GxtT2eWKzJbZXLszw0lmYp5/VCDlnto=
X-Received: by 2002:a05:6402:4308:b0:5c3:c388:2e36 with SMTP id
 4fb4d7f45d1cf-5c413e0892bmr1288929a12.3.1726126534725; Thu, 12 Sep 2024
 00:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912071702.221128-1-en-wei.wu@canonical.com>
In-Reply-To: <20240912071702.221128-1-en-wei.wu@canonical.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Sep 2024 09:35:19 +0200
Message-ID: <CANn89iJZGH+yEfJxfPWa3Hm7jxb-aeY2Up4HufmLMnVuQXt38A@mail.gmail.com>
Subject: Re: [PATCH ipsec v2] xfrm: check MAC header is shown with both
 skb->mac_len and skb_mac_header_was_set()
To: En-Wei Wu <en-wei.wu@canonical.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kai.heng.feng@canonical.com, chia-lin.kao@canonical.com, 
	anthony.wong@canonical.com, kuan-ying.lee@canonical.com, 
	chris.chiu@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 9:17=E2=80=AFAM En-Wei Wu <en-wei.wu@canonical.com>=
 wrote:
>
> When we use Intel WWAN with xfrm, our system always hangs after
> browsing websites for a few seconds. The error message shows that
> it is a slab-out-of-bounds error:
>
> [ 67.162014] BUG: KASAN: slab-out-of-bounds in xfrm_input+0x426e/0x6740
> [ 67.162030] Write of size 2 at addr ffff888156cb814b by task ksoftirqd/2=
/26
>
> The reason is that the eth_hdr(skb) inside if statement evaluated
> to an unexpected address with skb->mac_header =3D ~0U (indicating there
> is no MAC header). The unreliability of skb->mac_len causes the if
> statement to become true even if there is no MAC header inside the
> skb data buffer.
>
> Check both the skb->mac_len and skb_mac_header_was_set(skb) fixes this is=
sue.
>
> Fixes: 87cdf3148b11 ("xfrm: Verify MAC header exists before overwriting e=
th_hdr(skb)->h_proto")
> Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
> ---
> Changes in v2:
> * Change the title from "xfrm: avoid using skb->mac_len to decide if mac =
header is shown"
> * Remain skb->mac_len check
> * Apply fix on ipv6 path too
> ---
>  net/xfrm/xfrm_input.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index 749e7eea99e4..eef0145c73a7 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c
> @@ -251,7 +251,7 @@ static int xfrm4_remove_tunnel_encap(struct xfrm_stat=
e *x, struct sk_buff *skb)
>
>         skb_reset_network_header(skb);
>         skb_mac_header_rebuild(skb);
> -       if (skb->mac_len)
> +       if (skb->mac_len && skb_mac_header_was_set(skb))
>                 eth_hdr(skb)->h_proto =3D skb->protocol;

I would swap the two conditions :
We might in the future debug kernels leave mac_len uninitialized if
mac_header was never set.

It would be nice to catch the issue sooner.
Something is calling skb_reset_mac_len() while the mac_header was not set ?
Considering the stack trace, I can not see why mac_header is not set.
Could you try the following patch, and compile your test kernel with
CONFIG_DEBUG_NET=3Dy ?

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 39f1d16f362887821caa022464695c4045461493..fb06dc81039253bafeb49f0b722=
8748e898f480f
100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2909,9 +2909,19 @@ static inline void
skb_reset_inner_headers(struct sk_buff *skb)
        skb->inner_transport_header =3D skb->transport_header;
 }

+static inline int skb_mac_header_was_set(const struct sk_buff *skb)
+{
+       return skb->mac_header !=3D (typeof(skb->mac_header))~0U;
+}
+
 static inline void skb_reset_mac_len(struct sk_buff *skb)
 {
-       skb->mac_len =3D skb->network_header - skb->mac_header;
+       if (!skb_mac_header_was_set(skb)) {
+               DEBUG_NET_WARN_ON_ONCE(1);
+               skb->mac_len =3D 0;
+       } else {
+               skb->mac_len =3D skb->network_header - skb->mac_header;
+       }
 }

 static inline unsigned char *skb_inner_transport_header(const struct sk_bu=
ff
@@ -3014,11 +3024,6 @@ static inline void
skb_set_network_header(struct sk_buff *skb, const int offset)
        skb->network_header +=3D offset;
 }

-static inline int skb_mac_header_was_set(const struct sk_buff *skb)
-{
-       return skb->mac_header !=3D (typeof(skb->mac_header))~0U;
-}
-
 static inline unsigned char *skb_mac_header(const struct sk_buff *skb)
 {
        DEBUG_NET_WARN_ON_ONCE(!skb_mac_header_was_set(skb));

