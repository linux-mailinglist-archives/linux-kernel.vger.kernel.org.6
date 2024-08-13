Return-Path: <linux-kernel+bounces-284052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A17D94FC70
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 05:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978761C223B3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 03:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7953E1CD1F;
	Tue, 13 Aug 2024 03:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBpfGkiJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A1618EAB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723521231; cv=none; b=ON5NrZ+D0nqzvNUqZG9qwE/1e6QhZjLfSApjxTDbrcEOKHzsFYfWz4HoD7BgbLb9dW1zr5tFSHfGcYJJHBBn5bSxtPFlqrvfQcBeSAC3XEXkCmCaPkH9ufXb89aB7qy8MAnfXJOu1HHX5hB0t3zAuEaueFPLAOR9OPVTLL9uceA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723521231; c=relaxed/simple;
	bh=1/YYj/FIhKGs1dZdd4D2WEQIg8dqO3w+5kVK4bkLaSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G++a7lUTm/NctDkQLT6eIjU9BitW40i0ofoSx2r892gRAyVHwAQD9mpcBPgxFNGKuoeIUd93b6Gec6Qj0ro449I928BWPhmyRYDYcyD/sKOQtEpplUWiU1HRUbmMyxPTLFKOXMfn3cBcaUIpXMZSFdpmRHhFoDCHkzjaiQz/TGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YBpfGkiJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723521229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8QOhbN+G2UI84CLxR8GtKPdibAYSavfIJXJ0B5CLThc=;
	b=YBpfGkiJMLB+ionLWuI/41i/3DL3jl6MPkosoTGuv7HuUv1H05SLHiEBJPVokFFsTS4ePf
	T0/aWBoE6KcQxxFyNVbCKAjAvv1ccfTOc8T22cNyKwhtp+STxKDic9InpUub0toXJDPChI
	N5IGaqAOLwwZwTwq47Ec18ahlqkSZjc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-9Ij-yEBbNFGUsVjXXIEN1A-1; Mon, 12 Aug 2024 23:53:46 -0400
X-MC-Unique: 9Ij-yEBbNFGUsVjXXIEN1A-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c96e73c886so4875560a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723521225; x=1724126025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QOhbN+G2UI84CLxR8GtKPdibAYSavfIJXJ0B5CLThc=;
        b=lrIURImxIInIX2Myn6LZrOVl143N4C0wKAhWt6SejaUXT7xSxWFlagxrLb6QfTr+AC
         cIalYbLCMuzOPiDc9iyKqA7NICuyOOhZeZIGXppDKtOyCsKQILiKiASS1wlKZfBcCOi9
         vfNR8zM4NN+trOPbaUULE8RBSOvGnEueD5gecRHeon1G52UcNRg0N2S9oTprxndLUR/F
         1MNXM55WdptC+h0ubLH+U0BDN0wIw4/7W4iMevQNcwvRgWtorYnj7I97KB2rgtn1Y+xg
         vILDSQXtZLPmSZ9AFNZtT/O8GQo7AidRBtwLaa2qxaq2RjHDRepeXqgOVq9HMJV+AoSN
         uJiw==
X-Forwarded-Encrypted: i=1; AJvYcCU1pSEewjczoMrc/V4lmZGP+9WfCq6XnmVwweTOOgmXkAtcsiB3jbzvfH8DEg25nhQTY0Snzo1tP349TnmCo31hlI8ra9EX0GMkQkdE
X-Gm-Message-State: AOJu0Yx0tGWr9WbWZaj4xxYbKA6WgHOV7ppm0hIWRhZhS5Wot+PrwAES
	AxYqNlpizEAkSLaEdgZGreOV+Aosjca7wG2lw6bxUotkA8RhWEDPYuCth/sEQcWDiIwMCQbYrBy
	NCC4k58czlopZgw08U3D1g+cZw3cVU67QYlwdI+12GY4zHt5Eq2f/A6CT1rMAISbDH6ZLouIXVe
	WQyHl4aBINmTaQgyn4TGL3tdqJabuOSPHWAfp0
X-Received: by 2002:a17:90b:230b:b0:2c9:69cc:3a6a with SMTP id 98e67ed59e1d1-2d3924d6069mr2555088a91.3.1723521225438;
        Mon, 12 Aug 2024 20:53:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFJc3jsUUMplnLTRxbhe3p0rkwFDORq22WEdzxWm12Cd7QkQG/w4r8SCFfuIABlC3bvzqsUOBo/unBIpoolXI=
X-Received: by 2002:a17:90b:230b:b0:2c9:69cc:3a6a with SMTP id
 98e67ed59e1d1-2d3924d6069mr2555073a91.3.1723521224879; Mon, 12 Aug 2024
 20:53:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF=yD-JVs3h1PUqHaJAOFGXQQz-c36v_tP4vOiHpfeRhKh-UpA@mail.gmail.com>
 <9C79659E-2CB1-4959-B35C-9D397DF6F399@soulik.info> <66b62df442a85_3bec1229461@willemb.c.googlers.com.notmuch>
 <CACGkMEsw-B5b-Kkx=wfW=obMuj-Si3GPyr_efSeCoZj+FozWmA@mail.gmail.com> <66ba421ee77f4_48f70294e@willemb.c.googlers.com.notmuch>
In-Reply-To: <66ba421ee77f4_48f70294e@willemb.c.googlers.com.notmuch>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 13 Aug 2024 11:53:32 +0800
Message-ID: <CACGkMEt0QF0vnyCM5H8LDywG+gnrq_sf7O8+uYr=_Ko8ncUh3g@mail.gmail.com>
Subject: Re: [PATCH] net: tuntap: add ioctl() TUNGETQUEUEINDX to fetch queue index
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: ayaka <ayaka@soulik.info>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 1:11=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Wang wrote:
> > On Fri, Aug 9, 2024 at 10:55=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > ayaka wrote:
> > > >
> > > > Sent from my iPad
> > >
> > > Try to avoid ^^^
> > >
> >
> > [...]
> >
> > > > 2. Does such a hash operation happen to every packet passing throug=
h?
> > >
> > > For packets with a local socket, the computation is cached in the
> > > socket.
> > >
> > > For these tunnel packets, see tun_automq_select_queue. Specifically,
> > > the call to __skb_get_hash_symmetric.
> > >
> > > I'm actually not entirely sure why tun has this, rather than defer
> > > to netdev_pick_tx, which call skb_tx_hash.
> >
> > Not sure I get the question, but it needs to use a consistent hash to
> > match the flows stored before.
>
> This is a bit tangential to Randy's original thread, but I would like
> to understand this part a bit better, if you don't mind.

Comments are more than welcomed. The code is written more than 10
years, it should have something that can be improved.

>
> Tun automq calls __skb_get_hash_symmetric instead of the
> non-symmetrical skb_get_hash of netdev_pick_tx. That makes sense.
>
> Also, netdev_pick_tx tries other things first, like XPS.

Right, using XPS may conflict with the user expected behaviour (e.g
the automatic steering has been documented in the virtio spec, though
it's best effort somehow).

>
> Why does automq have to be stateful, keeping a table. Rather than
> always computing symmetrical_hash % reciprocal_scale(txq, numqueues)
> directly, as is does when the flow is not found?
>
> Just curious, thanks.

You are right, I think we can avoid the hash calculation and depend on
the fallback in netdev_pick_tx().

Have put this in my backlog.

Thanks

>
> > >
> > > > 3. Is rxhash based on the flow tracking record in the tun driver?
> > > > Those CPU overhead may demolish the benefit of the multiple queues =
and filters in the kernel solution.
> > >
> > > Keyword is "may". Avoid premature optimization in favor of data.
> > >
> > > > Also the flow tracking has a limited to 4096 or 1024, for a IPv4 /2=
4 subnet, if everyone opened 16 websites, are we run out of memory before s=
ome entries expired?
> > > >
> > > > I want to  seek there is a modern way to implement VPN in Linux aft=
er so many features has been introduced to Linux. So far, I don=E2=80=99t f=
ind a proper way to make any advantage here than other platforms.
> >
> > I think I need to understand how we could define "modern" here.
> >
> > Btw, I vaguely remember there are some new vpn projects that try to
> > use vhost-net to accelerate.
> >
> > E.g https://gitlab.com/openconnect/openconnect
> >
> > Thanks
> >
>
>


