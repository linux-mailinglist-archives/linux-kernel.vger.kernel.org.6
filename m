Return-Path: <linux-kernel+bounces-328392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600209782CA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A54B1C223BC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E586B2A1D7;
	Fri, 13 Sep 2024 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ay3fgm8T"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FBB29CE7
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726238392; cv=none; b=kZygtrUDIO77Mhjw7FlNJRH3ztFMBtAOI0z8jcWfxKi2drsF0myaMM8EtmUkvxtMi4kDyeEbu96ke5meh3Rdp2aQ06uLX2JdbkxJAM+3a7PsTQ1ptFXRQpT8GQD7ZfIYrBS8oTgyGvCSKG3uu6AlIDgjUZs+Z5mb0gupLAZtznU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726238392; c=relaxed/simple;
	bh=tx+eiWlkm8Gy1oJTVQzCp0tnPwzYu6jX+WUYZnyHw/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVCJyf8PeW/Ogy/wzOGeFkdRZ+f2KgWfY5LoPiJOtpnZHXAWc/xd035Ta/wK2KOXa11TUPxlAEx35wX3CS1nMArErF3cOgAaRWb9WEdmctk/GEtXEEXgs8V9/lmVC7EYkiZQShd5/KMBtUrvyaAFdWd76GAm2arP2p6i+y1vRMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ay3fgm8T; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f75428b9f8so16226461fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 07:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726238389; x=1726843189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tx+eiWlkm8Gy1oJTVQzCp0tnPwzYu6jX+WUYZnyHw/I=;
        b=Ay3fgm8TX/lylCmCYjEA8IgcdrFn0qsvI8OaIXHuy6OQNIuEre2yyb0Iss6BA6wuTU
         vunDWCwf0vXqylUTcHcpleK6cPxULGoi5qiCWjrQd1pCZjp1BgvSsIB1kXSbK08pHTFw
         oJjKvH8bq+jrFD28eS5eSSmWfdGrf4oZp1xgN8uaj99AucAKMW8mnUaUAnZheadYrAop
         QmkZ+9/UFVAVN8IdeLdznmRlUubZqOkRZGzj3V5ZW5M8GLEowR1YWP0bo6mvlTJ4PR1T
         PJne7U/1dBU4OxON2mGn9o+hvNVT39wgx88PvmJP4SA7n1j1Q0/Li6cfkc0PSzao/OfX
         IY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726238389; x=1726843189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tx+eiWlkm8Gy1oJTVQzCp0tnPwzYu6jX+WUYZnyHw/I=;
        b=dnjMGDt4JCtt9JZw1yMPA/jUl9F7zgExizd4ijmUsCFV5DLwg9te3qD6UzRqLRJKDL
         3vKbP66nzJYdH2QsnkhPIFSc4qYVax951I+xwHgEKMEAfTaEtCnF9MVQst6LxpNebxfj
         uyZ6gcGs+Bu/tNyDw+FUcofzFpA2tPDa/1SA8MlGtOFWNMT3w8800fi2JByOqyHAX3Dx
         Zj3PWqmMl6khgzlhqFweSs0r1cHb2USFh/1dMcAKNud8cQymBv3Hk/HQACn9l9v1TRSX
         DLCke7eFahqxbuBf3ORUSy1Yq964AZtmc14K8XNgmnGtZjKgzH2IEkBfhDHfsOQx1j3s
         5iiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTvf13sBM22wE2m+/SpSkXC1islZU1+YprZG2ziBAVJfJBjCFHgYl1PSqLCqdRAFSGC8bERgiExl95PLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3UzGuOW0OZH0EjyAtXdP/vBVh+N+02ozRgFtfrCCCWRcItqOc
	arrfdL3NVOjTkdBNduLHtq5a9ENFOT8j8F9QVe1AC6EDWcQNg1MgUUeJ1CP6J86ZXSlgBxAuJWy
	8F1cdmpRj0mU97sMfLnsLOZRq2GNpn2FeNTFq
X-Google-Smtp-Source: AGHT+IEhG+dTJtYTj1YMD7Cs2BayN2Mp8duGb5iMRTTDm1TSkoSOnwIiTckfllyg/uTZsmo/So4hr5aEjyizhIv4X08=
X-Received: by 2002:a2e:6119:0:b0:2f0:27da:6864 with SMTP id
 38308e7fff4ca-2f7919fe28amr18951821fa.17.1726238388192; Fri, 13 Sep 2024
 07:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913100941.8565-1-lulie@linux.alibaba.com>
 <CANn89iJuUFaM5whtsqA37vh6vUKUQJhgjV9Uqv6_ARpVGFjB2w@mail.gmail.com> <20240913142155.GA14069@linux.alibaba.com>
In-Reply-To: <20240913142155.GA14069@linux.alibaba.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 13 Sep 2024 16:39:33 +0200
Message-ID: <CANn89iL9EYX1EYLcrsXxz6dZX6eYyAi+u4uCZuYjg=y3tbgh6A@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net/udp: Add 4-tuple hash for connected socket
To: dust.li@linux.alibaba.com
Cc: Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org, 
	willemdebruijn.kernel@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, antony.antony@secunet.com, 
	steffen.klassert@secunet.com, linux-kernel@vger.kernel.org, 
	jakub@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 4:22=E2=80=AFPM Dust Li <dust.li@linux.alibaba.com>=
 wrote:
>
> On 2024-09-13 13:49:03, Eric Dumazet wrote:
> >On Fri, Sep 13, 2024 at 12:09=E2=80=AFPM Philo Lu <lulie@linux.alibaba.c=
om> wrote:
> >>
> >> This RFC patch introduces 4-tuple hash for connected udp sockets, to
> >> make udp lookup faster. It is a tentative proposal and any comment is
> >> welcome.
> >>
> >> Currently, the udp_table has two hash table, the port hash and portadd=
r
> >> hash. But for UDP server, all sockets have the same local port and add=
r,
> >> so they are all on the same hash slot within a reuseport group. And th=
e
> >> target sock is selected by scoring.
> >>
> >> In some applications, the UDP server uses connect() for each incoming
> >> client, and then the socket (fd) is used exclusively by the client. In
> >> such scenarios, current scoring method can be ineffcient with a large
> >> number of connections, resulting in high softirq overhead.
> >>
> >> To solve the problem, a 4-tuple hash list is added to udp_table, and i=
s
> >> updated when calling connect(). Then __udp4_lib_lookup() firstly
> >> searches the 4-tuple hash list, and return directly if success. A new
> >> sockopt UDP_HASH4 is added to enable it. So the usage is:
> >> 1. socket()
> >> 2. bind()
> >> 3. setsockopt(UDP_HASH4)
> >> 4. connect()
> >>
> >> AFAICT the patch (if useful) can be further improved by:
> >> (a) Support disable with sockopt UDP_HASH4. Now it cannot be disabled
> >> once turned on until the socket closed.
> >> (b) Better interact with hash2/reuseport. Now hash4 hardly affects oth=
er
> >> mechanisms, but maintaining sockets in both hash4 and hash2 lists seem=
s
> >> unnecessary.
> >> (c) Support early demux and ipv6.
> >>
> >> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> >
> >Adding a 4-tuple hash for UDP has been discussed in the past.
>
> Thanks for the information! we don't know the history.
>
> >
> >Main issue is that this is adding one cache line miss per incoming packe=
t.
>
> What about adding something like refcnt in 'struct udp_hslot' ?
> if someone enabled uhash4 on the port, we increase the refcnt.
> Then we can check if that port have uhash4 enabled. If it's zero,
> we can just bypass the uhash4 lookup process and goto the current
> udp4_lib_lookup2().
>

Reading anything (thus a refcnt) in 'struct udp_hslot' will need the
same cache line miss.

Note that udp_hslot already has a 'count' field

