Return-Path: <linux-kernel+bounces-347526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FEF98D3E6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0DF5B22ABD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1501D016F;
	Wed,  2 Oct 2024 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wloEyCxI"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F451CDFBC
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873982; cv=none; b=Y9SYocYM6PkeXGy7el8LgZOROY++vdDvEAudBlPq8MY3f65rmbFuBjRudHxipLLT551A1cjJR4kSg5tM5anEYdy41h1/eQAm7kID6wrF9FJ/8q0gqbV006P4myKKxcR/belNgRO7zvNHTeoYk3UM2DUDmf6tJrVnAzC0cLV8FA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873982; c=relaxed/simple;
	bh=qdRoiUJV/Yov0rZQPYpBl2LSQBnZnGJVH2K745EqmXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0GXTooYLInZq3jbEumNzkXdjok2ITQX/vMEnh8nUoE3AUGADLyZqaZpUdbHU0WSMDgV6Wmh2g2Kcu3a1vK9yfUS+SIUm6COGQKSzR4QpzXuFlRl0BDAGfT23Y2HdlIeGHlB5rWqPDJu28JFsxVdthRu8otn/Kq7g3LK3RDJ2hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wloEyCxI; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37cd3419937so3480956f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 05:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727873978; x=1728478778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=st/3yIKgLFCxd81h3jWZRW2Fy2ZRgt+9u39B8oWEiyg=;
        b=wloEyCxIykM5DUpUR+K9xchqfK3iCjlTjaVGypXup9dRvqbbEvBMHr8D0WILb5YuIj
         rcINkjeZOwcbfME2JeNByRFdsihJ8qeA6Uqhf4GA3Y6uvhmDzRqtY0PKlJphG5mZPe8h
         /iM5SntPoUKc+TpLjcolypy2YM26eF7qHlhR3LG91a+2y0pc8pY88i5j3YQ8kcrPLgM4
         1stXWT63J5hQ6UzO0i6q43wjzQ4/OUGHBbkjvFbtRDIiFIL5YNbv0C2WXSMd4RB11374
         HVxdiV07gDfhvLovvfI+wvfSrcBH0bJOqbw22rZQdxgXYgUrz5gVmktkPcncZAfzjtXz
         6OeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727873978; x=1728478778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=st/3yIKgLFCxd81h3jWZRW2Fy2ZRgt+9u39B8oWEiyg=;
        b=rBJXnt3brMuGA/45HKsp7y3OgVeREwc5G2/irzMnAOplTwdWIU9FJ7ORZmXgootfp6
         9iqWvY3WypzIFKW+enUNCqP/+N+lmOm0/qrXBREcfg2tJRBq8sNX/y5KNnG5TwZrQrX6
         33mKGOSP2CGlqqWbZfFgGbS6ElapObB5UxFyDkn89Wj6/3ryBymZ5yO81LLSYPWMG432
         YL5x++yBlRYFPGvF/nlsTZ0bowON81z9Ns2/+3rKDWrQpU7YK8Go07PS4UvkFO8ElpqX
         XaarVceWpmYtgdXMbvn7vzICznksJDf+ag8uqzsjEuyI0oP+RSewiYehKye84MZRTECq
         d+eg==
X-Forwarded-Encrypted: i=1; AJvYcCXO3RlGuENyV9TETMEAhjDpjjrVEUgTr38lREEPCdUGTlfAGORaIsq1E7Y5PO3wSE6Dduzpmk5yQYE+SvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXWiXUWK0JBJcxIyVLw86/oyc4Y8PZTseGlpPYNfJTBJeRV6aB
	lC8b/SK5H3X4/2r0mF3wrt6xy9gc9XW6armBWZXCPImZHY6whJbqx7T0HMnEBqjCMHQFHVvIarn
	HSOgW3iHLh1O4w1fnnZ9nwNaGFTDA541lPjJd
X-Google-Smtp-Source: AGHT+IHgjLvHaqBFwPszuX7w/s0xpfyCrHiRrPhwGt7sEo3B5xKRljFKgr291hjq1Vo0g5FUrVD+DmKjceLAZG021rY=
X-Received: by 2002:a5d:694f:0:b0:37c:d129:3e48 with SMTP id
 ffacd0b85a97d-37cfba0a4a1mr1713461f8f.40.1727873977599; Wed, 02 Oct 2024
 05:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912071702.221128-1-en-wei.wu@canonical.com>
 <20240912113518.5941b0cf@gmx.net> <CANn89iK31kn7QRcFydsH79Pm_FNUkJXdft=x81jvKD90Z5Y0xg@mail.gmail.com>
 <CAMqyJG1W1ER0Q_poS7HQhsogxr1cBo2inRmyz_y5zxPoMtRhrA@mail.gmail.com>
 <CANn89iJ+ijDsTebhKeviXYyB=NQxP2=srpZ99Jf677+xTe7wqg@mail.gmail.com> <CAMqyJG1aPBsRFz1XK2JvqY+QUg2HhxugVXG1ZaF8yKYg=KoP3Q@mail.gmail.com>
In-Reply-To: <CAMqyJG1aPBsRFz1XK2JvqY+QUg2HhxugVXG1ZaF8yKYg=KoP3Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Oct 2024 14:59:24 +0200
Message-ID: <CANn89i+4c0iLXXjFpD1OWV7OBHr5w4S975MKRVB9VU2L-htm4w@mail.gmail.com>
Subject: Re: [PATCH ipsec v2] xfrm: check MAC header is shown with both
 skb->mac_len and skb_mac_header_was_set()
To: En-Wei WU <en-wei.wu@canonical.com>
Cc: Peter Seiderer <ps.report@gmx.net>, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kai.heng.feng@canonical.com, chia-lin.kao@canonical.com, 
	anthony.wong@canonical.com, kuan-ying.lee@canonical.com, 
	chris.chiu@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 12:40=E2=80=AFPM En-Wei WU <en-wei.wu@canonical.com>=
 wrote:
>
> Hi,
>
> I would kindly ask if there is any progress :)

Can you now try this debug patch (with CONFIG_DEBUG_NET=3Dy ) :

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 39f1d16f362887821caa022464695c4045461493..e0e4154cbeb90474d92634d5058=
69526c566f132
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
@@ -3043,6 +3048,7 @@ static inline void skb_unset_mac_header(struct
sk_buff *skb)

 static inline void skb_reset_mac_header(struct sk_buff *skb)
 {
+       DEBUG_NET_WARN_ON_ONCE(skb->data < skb->head);
        skb->mac_header =3D skb->data - skb->head;
 }

@@ -3050,6 +3056,7 @@ static inline void skb_set_mac_header(struct
sk_buff *skb, const int offset)
 {
        skb_reset_mac_header(skb);
        skb->mac_header +=3D offset;
+       DEBUG_NET_WARN_ON_ONCE(skb_mac_header(skb) < skb->head);
 }

 static inline void skb_pop_mac_header(struct sk_buff *skb)

