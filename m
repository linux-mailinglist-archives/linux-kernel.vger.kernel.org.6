Return-Path: <linux-kernel+bounces-297613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC4F95BB73
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23711F212EE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC6D1CCEDD;
	Thu, 22 Aug 2024 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ordt0V0+"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B7113A86C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343153; cv=none; b=jly++7YKJzSj1ORZIJSCIxqmHi05MxTxkuYs6Y4Xkud1+sEAn2p2Beu/rEyYWwYmQCKI4Ns3asEX1+kaSl7gz7MO8lUnIkGAXIpgIjlTZGR0bmnjvTUqCPATN7Nk5H0GxL3gr/TUwAUWy2mPRczO5aefeT5WfjnwKOLfA3PZO9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343153; c=relaxed/simple;
	bh=Ba1IvEzIg0HqH4m0Pj00DWclSyzLhBeuHHgLKg8p/xY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GqLQy/v0PRcpDWgZe5g37VC8nV/pre/QkA6ho0Rxj0XG24ZdvZYB5e9rK6HcPtjGFBZPAOowWv8bEm5OJPtexoxmUG+2bfDG54ALCQ4or6lwH483TGSx+514DGQ7MFrYsVYzLShJ1naYmpHyBZFjXaXMtXY1coZBOGwhot5qBHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ordt0V0+; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-81f8d644fe0so14012639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724343151; x=1724947951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ba1IvEzIg0HqH4m0Pj00DWclSyzLhBeuHHgLKg8p/xY=;
        b=ordt0V0+cwQXMnCf4PcUWG585Fz4sQ+YkT5TcCyYVUxlLeKx0zBkXXWWWl2cwxGgmP
         shGpbiVEbw3y2jK6c552rkBYHw4qwdl9uuVkbS8LfbmbeStkyu2LDdKi/YgkTCziXCTQ
         dSBXQJiU04OHKaulw9Yn/3IrVtSCPpiN5LM3KCRBv8Rm1NeL4tk9k0zMk63I2IRICifC
         ZMLZtico886KOeiyFbtdp0xrs3Fd7zQacugPxuYVGnRZP4aofRSoebyW308H9T49njkH
         nqQcghVNpFMCzmPSPI8jYNBw0T7wUwYgQPeIKkL9KqMiROd8ZcXr7nwWT8VC03ZLzzRo
         cCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724343151; x=1724947951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ba1IvEzIg0HqH4m0Pj00DWclSyzLhBeuHHgLKg8p/xY=;
        b=hHxsMxV0MEEORYOqJsYqGl8Fbsa7hTZJ9RuACSfIcwsA0QWkwAilOlKfOCqEDMvVp3
         xut/2hHmwVf+xbpcwNxbFUhbcyOCfRTDCcJIU+MRcq7R+aNFdb4eR7dCsf1psioycctU
         yhtZMo1J8wyRIK0HeOWOKU2Px8NBtzEpuatiLQEVtVwtT01iPaIO37V1KwWvyqC0OXmT
         D6p71SQstHxRUJ4zwlK004ongK24CFSodaK66aqs61/j/KqacaKS6tfaTYQDeq99U873
         V2tRx9fcpfSekgoBZdzKqFiV/q4DQN/MaJETj7CFWr02bXp9od6j11aX2X4Fuzx106Oo
         6+wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhY2pbiCherjRLKNecyRSy63P+rW22bUtP9nBXJEslZzPBgomy6ZnW7VH7UNN9NQ0jNbtCEGb2GoTRskQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy//lDZ8ITS8/XkuxfBDc5SoiHA1sAo/F74h1G5aKLpOsNKH39I
	JJRKt7gKSjw+CivKyWgSASEMcDHPGnxECdHczt9bUCgEC7P4afiiIaAcGhTGexT+bY3JtBXZbBG
	kGQqkO1FQy/pat950LsQIJkW7THdq9OAuWAcX
X-Google-Smtp-Source: AGHT+IEGLPuEsDAvSUvkTG3B+q34v5yszocQDhualPE03uRvgkr+IilDM2gHqzh5kOtJRZV+mqs9gHW0ku1hkX58aGo=
X-Received: by 2002:a05:6602:1483:b0:803:f97f:59d8 with SMTP id
 ca18e2360f4ac-8252f1344d8mr807386939f.0.1724343151288; Thu, 22 Aug 2024
 09:12:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821150700.1760518-1-aleksander.lobakin@intel.com>
 <20240821150700.1760518-3-aleksander.lobakin@intel.com> <CANn89iL+VTJ6tEe-PZ24h+0U9BYs0t4gZDndiy7j1DwuKMBEFg@mail.gmail.com>
 <fc659137-c6f0-42bf-8af3-56f4f0deae1b@intel.com>
In-Reply-To: <fc659137-c6f0-42bf-8af3-56f4f0deae1b@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Aug 2024 18:12:18 +0200
Message-ID: <CANn89i+qJa8FSwdxkK76NSz2Wi4OxP56edFmJ14Zok8BpYQFjQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/6] netdev_features: remove unused __UNUSED_NETIF_F_1
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew@lunn.ch>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 5:24=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Wed, 21 Aug 2024 17:43:16 +0200
>
> > On Wed, Aug 21, 2024 at 5:07=E2=80=AFPM Alexander Lobakin
> > <aleksander.lobakin@intel.com> wrote:
> >>
> >> NETIF_F_NO_CSUM was removed in 3.2-rc2 by commit 34324dc2bf27
> >> ("net: remove NETIF_F_NO_CSUM feature bit") and became
> >> __UNUSED_NETIF_F_1. It's not used anywhere in the code.
> >> Remove this bit waste.
> >>
> >> It wasn't needed to rename the flag instead of removing it as
> >> netdev features are not uAPI/ABI. Ethtool passes their names
> >> and values separately with no fixed positions and the userspace
> >> Ethtool code doesn't have any hardcoded feature names/bits, so
> >> that new Ethtool will work on older kernels and vice versa.
> >
> > This is only true for recent enough ethtool (>=3D 3.4)
> >
> > You might refine the changelog to not claim this "was not needed".
> >
> > Back in 2011 (and linux-2.6.39) , this was needed for sure.
> >
> > I am not sure we have a documented requirement about ethtool versions.
>
> But how then Ethtool < 3.4 works with the latest kernels? I believe we
> already moved some bits and/or removed some features or it's not true?
>

Presumably most of the 'old and useful' bits are at the same location,
or ethtool has been updated by distros.

> I could try building it, not sure it would build though. How do you
> think then we should approach this? Maybe document the requirement?
> I don't think we should leave the features as they are and sit with no
> bits available only to support ancient Ethtool versions.

I was simply suggesting to correct the changelog, and make clear we
need a recent enough ethtool.

We can not simply say that ethtool always supported the modern way
(ETH_SS_FEATURES)

