Return-Path: <linux-kernel+bounces-175371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C27D8C1E99
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B2C282392
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 07:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705D815B147;
	Fri, 10 May 2024 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="FSR6UNy7"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986835490E
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715324516; cv=none; b=M8mqzleYuDcxGl/ggLICpjTCfFQMsEwniGuQJoLKEj7bmTbNg650Okgy1sYoFMo1u+ec8iQr9mbbCMWRuKfnv5DX8+lyshdh/lX4r9XO53oiiPYfCdcPTadwf7MmqmgpjFEFkqF5zSmMPiBDZSYgnTfOxq+SxO+/s4T9t/9KC2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715324516; c=relaxed/simple;
	bh=7oGXbFORwBCyzCIXmLVRq2rm6tpAyoLE/wEl7xVni/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfSuY/wdhA35Hyil9s3CUeVd0JZH7FdUwVxJB11VefAeqMVh1SATQatqb88WOno7buTwBgugmYBmxIVotKC1M+LkNXYr9SADOXR8GvCMoeeBXxforgobS+bDQhfjOP97XdA8FPbGk/f9UBQeVvdDfPnZG6MWDyJDBMkKXukObS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FSR6UNy7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41ff3a5af40so30455e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715324513; x=1715929313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fNjQtXaSKOYp8nX/E0knSnpY+xEYmx9idjbqHww5m8=;
        b=FSR6UNy7ZCeAoKw4kCtum0FHjMP04IWADohr7m7A5TLlSkuMvQAjAcvzR8UjzJfBNC
         3tH7uJQlHm9S8jDO6mu/RD1pDyNcw8i8+pjqVYJmkM6H3p4vvwvDTCRPDQ+Lla7srN1u
         jHJWTGQxz/SPK7mJqIYKLsMtyepy5LA5XDs57QyfEYwjukbNg/MrZ/kCBNl6Khp3UTE0
         UERCbamJedTMLe+klmnv4hli01rs0GgW6e1p91U/vJNfArxZWxwAC9MDidnzM/4fMSVY
         kT/vxWA/+Z3IkROawa9ZCYxHlLHIJAIGXOyToPnpCgWZYyrgZUeNT+5U0HLEElf9UYyi
         cxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715324513; x=1715929313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fNjQtXaSKOYp8nX/E0knSnpY+xEYmx9idjbqHww5m8=;
        b=d66l1rbVb3mXO+uQbBBEl50jLC1EHvCfwVUOCfsSn7Z2D0o9Xnx4csiORMs7HTBdwQ
         4RrFvpqx8b0SnyEXlJVCYfr0mGM2AJZbDLHecZw8auuSPcRpy/bm9FFByfo+7V2Ve9eN
         QJC4Gw+1JE+ZrYVdGiPu+foZj4GOJAjcvM+DLvET51bOvokV7zFkh1t5jwvDxD6XCgDZ
         u2QgKwGEx35xqtcQJhGy5zWjXhvewxfRXwVmaisgqg7UK867mo1DNdMjJfjz/erBs9i/
         ThpTC0S9AsVUeMiIl7YfKXs01RFjnPBD8s5xNfqOnSP76t1Jah17on3eP6dcszqZeIbv
         vJOw==
X-Forwarded-Encrypted: i=1; AJvYcCURrHNrw6AgVBlXfdLrhYGY/EFsztm5jDuiT0+Andww8Kb283pyWCELV/wjpWv7erLpniD60haI3nJFOFA4X4y1Fn7rXgX6Ohb/hHtR
X-Gm-Message-State: AOJu0YwqhHeA1N6Xvn2eZGz4Qv4sbk72lZl7LUGj6m0qNlmoPpAup4zV
	m/DT6v6cMow4lWZQO2Fgi3tMALgxUU72gTTP6HqdjcgqpaN4VQnG8plzo0quX0bbNmqgpD1qv+C
	AIzYylRUKHCQyjJ+9Iz+8rfwlFKkfgYulLcgA
X-Google-Smtp-Source: AGHT+IHXgoYwv8mIiaDIGVOr7ncUPb8+Jxgb25xnmzzrh7Nx+vSrbhU+T7T2JV86E1ZVTxXeU3M9WBbaaejAwoMk2Q4=
X-Received: by 2002:a05:600c:6b13:b0:41b:e416:1073 with SMTP id
 5b1f17b1804b1-41fedc6d1d4mr1312435e9.0.1715324512596; Fri, 10 May 2024
 00:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507162349.130277-1-richardbgobert@gmail.com>
 <20240507163021.130466-1-richardbgobert@gmail.com> <CANn89iJfVHA=n-vSpFwoP3Jb8Wxr1hgem1rLqmyPWPUwDpe-cg@mail.gmail.com>
 <82f6854c-5d69-4675-8233-052a7b085cd4@gmail.com>
In-Reply-To: <82f6854c-5d69-4675-8233-052a7b085cd4@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 10 May 2024 09:01:37 +0200
Message-ID: <CANn89iJ7TPa350Git+r2dp6rvvJ-TUTYj5RiLi7i5TWsBJO1bQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 2/3] net: gro: move L3 flush checks to
 tcp_gro_receive and udp_gro_receive_segment
To: Richard Gobert <richardbgobert@gmail.com>
Cc: alexander.duyck@gmail.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	shuah@kernel.org, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 8:58=E2=80=AFPM Richard Gobert <richardbgobert@gmail=
com> wrote:
>

>
> Interesting, I think that is indeed a bug, that exists also in the curren=
t
> implementation.
> NAPI_GRO_CB(p)->ip_fixedid (is_atomic before we renamed it in this commit=
)
> is cleared as being part of NAPI_GRO_CB(skb)->zeroed in dev_gro_receive.

And the code there seems wrong.

A compiler can absolutely reorder things, I have seen this many times.

I would play safe here, to make sure NAPI_GRO_CB(skb)->is_atomic =3D 1;
can not be lost.

diff --git a/net/core/gro.c b/net/core/gro.c
index c7901253a1a8fc1e9425add77014e15b363a1623..6e4203ea4d54b8955a504e42633=
f7667740b796e
100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -470,6 +470,7 @@ static enum gro_result dev_gro_receive(struct
napi_struct *napi, struct sk_buff
        BUILD_BUG_ON(!IS_ALIGNED(offsetof(struct napi_gro_cb, zeroed),
                                        sizeof(u32))); /* Avoid slow
unaligned acc */
        *(u32 *)&NAPI_GRO_CB(skb)->zeroed =3D 0;
+       barrier();
        NAPI_GRO_CB(skb)->flush =3D skb_has_frag_list(skb);
        NAPI_GRO_CB(skb)->is_atomic =3D 1;
        NAPI_GRO_CB(skb)->count =3D 1;

