Return-Path: <linux-kernel+bounces-371099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7443F9A3673
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3CDC1C234EA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E2D183088;
	Fri, 18 Oct 2024 07:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iQZsvUnU"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5293420E33D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729235188; cv=none; b=qdk2qe5gx6Xvq63FKdiM2gw8it30NtvmPXzaDyzdmKFKydsFmAxjv/BkXHh0LmqLLBziJmYpZOAywvDYPP7/bNrezaYvU+HF5qLjeymU7Qwby+KhET3A23a6Ecw7RvnynllwrXbPXBIFTem1UGv2ZCUHGkElr4E1RCBNVkSPUeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729235188; c=relaxed/simple;
	bh=+LXYPc6hzDz1apqRx1+djjFCpV4f5yKQDtoRJZwRfQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=td8sQBNG9SrCLM1bREkFSRXKIPM9kFYXD7NTPFa42cnqH/3/zdRs9K5ih9Klj4bjj6dxBaJ3LmKEXKeQ3UgG1Dtjmr3B3UP+Ra284g9snJldiSLaosDcM2GQJKH3LS7MT0YMJCfU2KY1utXNEhSgxUC0DTVS/4e/pluBEXH78ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iQZsvUnU; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb5638dd57so20375161fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 00:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729235185; x=1729839985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sDh29tgBDN/eY+37mHiEnkCsD41OoxLIQqVYqiE06Y=;
        b=iQZsvUnUysgG3+Zmnrbp5TRbC0CZ3fHEb/lgnOGF/jnk25GYxwi2uCAnB17D1LldGf
         nixY9VIT0l4P7YQOKfsz/+NgUwv8F/YkhhQ57zM9TZMxJxdmua92yr8gB+jFmfb4Rk1I
         zjGNW0LwkXZsaXFdzgYY1lV8Yyn/mjqMg4ZtC01kMnVYaOMQwx5vLKACIYfJIk5jUwLm
         hdUnWmMtkGnql09wFJ1a48CKD9nZMz15NL3g8sRi08b6bqOhhwcxqAP0BkawJ4r0zEUf
         jeBDJ1Ryb3+/pVgLu19to+7/sppIfeDQ4SmR8HqJNh7I10oZ/bGGFfedihPfZZqn6oN6
         XFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729235185; x=1729839985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sDh29tgBDN/eY+37mHiEnkCsD41OoxLIQqVYqiE06Y=;
        b=T28+EDdrKZqXglOn/HTiuxV9WIV3C3AXUwqO6GSm/bxUGeGJL/OlGS7RT5MYhCX5ps
         k6BcmUFTpb9swzWNr2yiojnMVkdhTCUHW+SYstWiq/dxEYqZ8EaYJomoDB1OGiRTrNpZ
         34+x0Mvd7oJo5ZJnqcMT2ROgPcMTTCumwof4sP99fJsSiil6BviDey7PXYLKrOlawV/J
         sqs2BgxYvHqv8tHhThWmlKfglGTXvhtdHq5PRPbip+oLTgqSacho56WCidPXrPWFdh1D
         IhxQZZscphw1TLzbpA8u7eDx8FbASyLhoLQDbiIsw9O4yO5WHfZglBvhvt1C8pUwifKL
         e0BQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8P2K0j+t/ExmrUyDP//OHR4uvLMMZwQfdPNOdBHciwe3IiLu3A3WHn7iXGMMTUrXPAjKRhlkbYyZimyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG1Uk4AwLk8pGmlgirWCrFq9PqNDQdtQU/V0fuZKYtTjWyi5To
	w+h8+2Pn37iGYdWyKPFGKXPjDtz93GSWeVFca9megJCvgs9c84Mo1yH2D3akCwFUgZ2gXwCwb/Z
	w/WoMRE1JHRFJqzRv7lEa9DaBjxDpLVEFEYPV
X-Google-Smtp-Source: AGHT+IEID67jPLeUKh1bY4LIIgpCPYkyWpP4dlriYtHZlSy5ZWcIWo8EO6dx3Mc7MG9Ne0bnLTtz+chQnd/X6Cdop5k=
X-Received: by 2002:a05:651c:1543:b0:2fb:65c8:b4ca with SMTP id
 38308e7fff4ca-2fb83226659mr5746961fa.40.1729235185149; Fri, 18 Oct 2024
 00:06:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+nYHL-daCTUG=G0CaAMyabf9LkUYa6HnjhUCYLoJTm2FfMdsQ@mail.gmail.com>
In-Reply-To: <CA+nYHL-daCTUG=G0CaAMyabf9LkUYa6HnjhUCYLoJTm2FfMdsQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 18 Oct 2024 09:06:12 +0200
Message-ID: <CANn89iJ4EwLU2H4CntDbufc3ZRS9-BZrO0vXGxYosx4ELq8PgA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in __nf_hook_entries_try_shrink
To: Xia Chu <jiangmo9@gmail.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 9:00=E2=80=AFAM Xia Chu <jiangmo9@gmail.com> wrote:
>
> Hi,
>
> We would like to report the following bug which has been found by our mod=
ified version of syzkaller.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> description: KASAN: use-after-free Read in __nf_hook_entries_try_shrink
> affected file: net/netfilter/core.c
> kernel version: 5.8.0-rc4
> kernel commit: 0aea6d5c5be33ce94c16f9ab2f64de1f481f424b
> git tree: upstream
> kernel config: attached
> crash reproducer: attached
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> Crash log:
> BUG: KASAN: use-after-free in hooks_validate net/netfilter/core.c:177 [in=
line]
> BUG: KASAN: use-after-free in __nf_hook_entries_try_shrink+0x3c0/0x470 ne=
t/netfilter/core.c:260
> Read of size 4 at addr ffff888067fe4220 by task kworker/u4:2/126
>
> CPU: 1 PID: 126 Comm: kworker/u4:2 Tainted: G        W         5.8.0-rc4+=
 #1

This is an old version of linux, not supported.

What do you expect from us ?

