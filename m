Return-Path: <linux-kernel+bounces-262132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F3893C12D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76ED6B22209
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D6B199E84;
	Thu, 25 Jul 2024 11:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XzmSzcB/"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5FF199396
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721908425; cv=none; b=NiZdT55g/vaB12+Rfsm5E+BoFEvVEIU2MmoVUcpwM0+jvfXHEm7L0HgxOkQ2pXT3b+KubhIIvaHonzpran1L0Xv+vLRGEhXE8lSVWwGoWNSrIB/rLmBWuF4vSAL27PKYst+hhn/h8sgKt8fNfaozW3E5IOAAHXHTNXDVL/N9TAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721908425; c=relaxed/simple;
	bh=6PGgGYHRW1Fy1ldCtA21C6UkADY3uVnVxlOU/P1ZO7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVtfJFa/jTfda/H926cURdGn0yJG+KVLjp1vrU3jdqvLPItIBYc3XqQur4PF9MKIsadX7CnOANLQntkIoIDfd510tpJ4gRQYQ+yzxdVc3PzKKBZrUUwAIs+ob2qEf/AL5sdI/fQuACxLgqxhjI3Q1wmDEfkMNy8bvgc8soh4jbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XzmSzcB/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so10251a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721908422; x=1722513222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tp9zFfq6Mp6wXC8Na+4ujbdqv2pzT03d9NP2nnsFpQw=;
        b=XzmSzcB/f0xzkTgiOuowrBPyUD1v3q74J0sg1gKpmnj6DJX6l0EtWLH4npd20r7VVk
         YuIx0LMe0CGi8czkBzz8B2ALJBHFKvWAkJITI0htMkLkWl3QSQ/51DqtasJned7YK2aU
         JWzgfHTGGwKkICeba/t7JFx+xaTbGTX3hUVKO7SL4bpHekpTkhaM9BrQMtBrcYvb4agZ
         XlN/G9C5mGLkLDL3SR8mFFP/P/fdVZCJy+LydBRrpkoLGizv5KsIAEjRr63fp8ScbRyw
         oRtS6ya/+DKEJSdDDl3Uik4VcRgiuuH4drc4ETJdsEYE+6grpfHmJytAaTNrDiiylm+H
         mKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721908422; x=1722513222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tp9zFfq6Mp6wXC8Na+4ujbdqv2pzT03d9NP2nnsFpQw=;
        b=FgMwPWVc/+MIj5lv6lJVhL8DUeKeVIHplLivZlax2WrNukEsl6Jjr0wBsmfls9wkgS
         2rNZdQuh1yqA9GLB0iKf2p959ble5XtegvLg3yhDntEnJIkBF6efY3QWuMBee6syVSzS
         SMp8aerWUU8A/pPAVNdqJnRBkl6Cm3872sgd/R/A59QmZOIdkg3lXGYrvmC++fAGeO+U
         h9IiBiT/ePd4cl1pQnUjOJ7N3s33396CEAF0O5pxEzpwtXx0lGdNAiTcQ1/fXQK+AR9k
         IARXU73GKJ4H5H/HZ9KGoT8U47ta1kiK+inNpo5wOXh/NA6udWMg4fuomEIxM6lDktMF
         AYtg==
X-Forwarded-Encrypted: i=1; AJvYcCUu4a1lbeXONwaoB377RD/R1ztCeTpIrVHPlhh1YejqyOOpr8HBjCCSYWdzMY3nsRfPW2FYdNNAzktphcOem2X/LO6LC918tQAaS1Z3
X-Gm-Message-State: AOJu0Yy/ISHVXzGjp0dGBBp3avU1XF1Cr6QzeqlsZxNoWbjkoFHDys8W
	dAjvc0IVYXk30/7rv4evTgF4ED53FB+d1ERAmJTQH8CwdEkYccBN0GrE5dVFLJKnEtDEzi11BY1
	5Sm5+BIUQB8LIKQPoEp5MliZIJ4UCoeYYnz47ruYhN6WI1fxAT8qN
X-Google-Smtp-Source: AGHT+IF4Nc85qJaIsgPDyd9SnzqU79cudDhEao8n/ZdhzfhOJiiXDZ2e4ajJAvQNyK9PoM9KTLeZ2xX5pt+ED/IdJso=
X-Received: by 2002:a05:6402:268a:b0:57c:c5e2:2c37 with SMTP id
 4fb4d7f45d1cf-5ac2c3b3eb1mr205737a12.3.1721908421621; Thu, 25 Jul 2024
 04:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724135622.1797145-1-syoshida@redhat.com> <CANn89iKOWNa28NkQhhey=U_9NgOaymRvzuewb_1=vJ65HX1VgQ@mail.gmail.com>
 <d2014eb3-2cea-474a-8f04-a4251fd956c9@redhat.com>
In-Reply-To: <d2014eb3-2cea-474a-8f04-a4251fd956c9@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Jul 2024 13:53:27 +0200
Message-ID: <CANn89iL_fyHeEh0ymxYuSEtNg10wnzPbaOo06xToejMmDxRHNA@mail.gmail.com>
Subject: Re: [PATCH net] macvlan: Return error on register_netdevice_notifier()
 failure
To: Paolo Abeni <pabeni@redhat.com>
Cc: Shigeru Yoshida <syoshida@redhat.com>, davem@davemloft.net, kuba@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 12:13=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
>
>
> On 7/25/24 11:44, Eric Dumazet wrote:
> > On Wed, Jul 24, 2024 at 3:56=E2=80=AFPM Shigeru Yoshida <syoshida@redha=
t.com> wrote:
> >>
> >> register_netdevice_notifier() may fail, but macvlan_init_module() does
> >> not handle the failure.  Handle the failure by returning an error.
> >
> > How could this fail exactly ? Please provide details, because I do not
> > think it can.
>
> Yup, it looks like the registration can't fail for macvlan.
>
> It's better to avoid adding unneeded checks, to reduce noise on the
> tree, keep stable backport easy, etc.

Shigeru, you could send a debug patch when net-next reopens next week,
so that we do not get another attempt
on fixing a non-existent bug.

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 24298a33e0e94851ebf9c704c723f25ac7bf5eec..0803fcf8df4c56ede10597c8622=
88c7aa887160e
100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1849,7 +1849,8 @@ static int __init macvlan_init_module(void)
 {
        int err;

-       register_netdevice_notifier(&macvlan_notifier_block);
+       err =3D register_netdevice_notifier(&macvlan_notifier_block);
+       DEBUG_NET_WARN_ON_ONCE(err < 0);

        err =3D macvlan_link_register(&macvlan_link_ops);
        if (err < 0)

