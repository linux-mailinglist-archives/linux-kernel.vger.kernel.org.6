Return-Path: <linux-kernel+bounces-395152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C69B79BB949
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44D60B22393
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0961C07CE;
	Mon,  4 Nov 2024 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IZlnFGSn"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F85E1B218E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730735126; cv=none; b=d5X4GZiMT2VUUBtVnNV2mkLHCFgzzrqMybvQl/3IvEgppfUFDkmqVF1VJx5ZMHFL3Hin85PGBYrLbou2CXTbTLt0eSoUFqrGyAPwd7G/d0olOQ6D93Pkg20IKhCUfAiopqXrVz4+ZAMH4D9zBZv3qKi/QodCeb0Ghmo6sBWjouM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730735126; c=relaxed/simple;
	bh=hPDJcBx36zovOZyGA7UWvc4j7jN6je11Jp4t2rUWfj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwF5JD5ApzI04gomQjOosyi8caW22qXdXuCgVgYdvrWS67yITMjo1ae3kvu5RCYF8I+BxLHZGPw1Ul5yr9GjiM0wBXXZiVo1kAw1pcdLYA/5mv4fsI26Kg4aLZ6J6g74Om4STaEw8J9zDj1VcsoHNRDcdNWeaJ6fywQ64T8YF/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IZlnFGSn; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso9623593a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 07:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730735123; x=1731339923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyD6YqQEWKxUIe4S6LmMmf6PWiCVhHiKz195ndFs5bE=;
        b=IZlnFGSnmD0MRHl1RSGrTBtSDERcLIHBKDCy2jsi6tYJ/IcomdMVderOnZQHELTuQS
         DLa8CRjg/AdXlIwXSb04KblacKVUKThfN0Oj9eoivkN86x9XdJk8WXFEDAGJmu7cIY4D
         QEDUxUipbPW6debAfE339w164mBugU3GgUcDjldO9onP/7KVHDOO4Kno1b2L4gG/RIds
         VzpjowiQ93tlM4+B7R8FYHjY0TjSR+mNDzgusIhs1VVWTmY9O2ShrduVMgjJH1BNnDaG
         0sHTwW8j6BiY6k6gwmYYckFxx36I0WsFL3zz31c+GDTbDX5qBOWnlEAzBWH5pTCK45Tl
         p9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730735123; x=1731339923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyD6YqQEWKxUIe4S6LmMmf6PWiCVhHiKz195ndFs5bE=;
        b=kSDTuIZi1UcAQAKMqokgmkdRexeSgEPFYGtXg7oj2UKanihwbH7MBb4XN9hLlKiI5r
         LKvynz8o67WWSWaTvbN5/NWM6MmVNxGB8kap2e9Gjy3FjoXeo6MWDEt8rflAm24gPc1r
         BDBaeBOveNBNfaazHz2kclZdX6YTm6K0i6A0qdQu2FKBz1zfrrQ4kWzBjl5p4p8CWVrU
         0NYSKPxvE4iLp2iOr+brZgfOnUXhWMz4tscyaz/QvXMVMF7z1mPVwVGSLdNyQ3fHkamy
         XpnthiwUwTvxd9hXRHHpaXsXDfUn5rBa7kvP6KuGA2S0anasng3DHgE1WYkV9G8pspxL
         0qWw==
X-Forwarded-Encrypted: i=1; AJvYcCW3kMYIgl955jQWqgCfsPYbud7I1WksEWLysI5/MV29c6EEjdc3+PewRzfD8ns27J0l9X8XxNIcswjTgTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzleHZ6eBtzyFL/3Hgpr5Vg4wrly7HyKjjIItfTh2OlKEqRJ3Y
	my/H6VLv8mHqlm6nnQ99ECd1lvYC320i53eZ9apy3yGSOb9VK1GySXYt9XqitYlmUffC4vTCtf7
	ITat4G5J8RCQqg69989Ae8cO3i3iRLaiVnos0
X-Google-Smtp-Source: AGHT+IEL4Bfa722zzMFIJFIe6LUBra+dg2DR/J927/adcjEn393kcxsz9by8vrW9A2NUCiatisxFPqNB6U5c0PPsRnA=
X-Received: by 2002:a05:6402:40c2:b0:5ce:b120:a080 with SMTP id
 4fb4d7f45d1cf-5ceb120a12cmr14019344a12.13.1730735122632; Mon, 04 Nov 2024
 07:45:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031122344.2148586-1-wangliang74@huawei.com>
 <CANn89i+KL0=p2mchoZCOsZ1YoF9xhoUoubkub6YyLOY2wpSJtg@mail.gmail.com> <0913d4ba-7298-4295-8ce0-8c38ddb9d5b6@huawei.com>
In-Reply-To: <0913d4ba-7298-4295-8ce0-8c38ddb9d5b6@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Nov 2024 16:45:11 +0100
Message-ID: <CANn89iKWbcjavVB-7Lwqou8n2v6oGnaE3-jzDz7n9Nj3+5yJTw@mail.gmail.com>
Subject: Re: [RFC PATCH net] net: fix data-races around sk->sk_forward_alloc
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	dsahern@kernel.org, yuehaibing@huawei.com, zhangchangzhong@huawei.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 7:24=E2=80=AFAM Wang Liang <wangliang74@huawei.com> =
wrote:
>
>
> =E5=9C=A8 2024/10/31 22:08, Eric Dumazet =E5=86=99=E9=81=93:
> > On Thu, Oct 31, 2024 at 1:06=E2=80=AFPM Wang Liang <wangliang74@huawei.=
com> wrote:
> >> Syzkaller reported this warning:
> > Was this a public report ?
> Yes=EF=BC=8CI find the report here (the C repo in the url is useful):
>
> https://syzkaller.appspot.com/bug?id=3D3e9b62ff331dcc3a6c28c41207f3b99118=
28a46b
> >> [   65.568203][    C0] ------------[ cut here ]------------
> >> [   65.569339][    C0] WARNING: CPU: 0 PID: 16 at net/ipv4/af_inet.c:1=
56 inet_sock_destruct+0x1c5/0x1e0
> >> [   65.575017][    C0] Modules linked in:
> >> [   65.575699][    C0] CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tai=
nted 6.12.0-rc5 #26
> >> [   ...]
> > Oh the horror, this is completely wrong and unsafe anyway.
> >
> > TCP listen path MUST be lockless, and stay lockless.
> >
> > Ask yourself : Why would a listener even hold a pktoptions in the first=
 place ?
> >
> > Normally, each request socket can hold an ireq->pktopts (see in
> > tcp_v6_init_req())
> >
> > The skb_clone_and_charge_r() happen later in tcp_v6_syn_recv_sock()
> >
> > The correct fix is to _not_ call skb_clone_and_charge_r() for a
> > listener socket, of course, this never made _any_ sense.
> >
> > The following patch should fix both TCP  and DCCP, and as a bonus make
> > TCP SYN processing faster
> > for listeners requesting these IPV6_PKTOPTIONS things.
> Thank you very much for your suggestion and patch!
>
> However, the problem remains unsolved when I use the following patch to
> test.
>
> Because skb_clone_and_charge_r() is still called when sk_state is
> TCP_LISTEN in discard tag.
>
> So I modify the patch like this (it works after local test):

SGTM, please send a V2 then.

