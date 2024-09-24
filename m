Return-Path: <linux-kernel+bounces-337417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAED9849D4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93612286ABA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CB91AB6D9;
	Tue, 24 Sep 2024 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="I6NQg/R1"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483681AC441
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727196059; cv=none; b=lRylR6Pg97AJFA0CuhsRHdSQubafRGxieIt8Gq9z3PUtVxDyuhrM2bMP338pjNku+dvNvwfBwuxvz5p6KBj68uN+qVF2U6wBFY1iC0mSo9gIXBs58aUhUaO1OI07E6+CH+pXBTpsdLsG8GGv8cbzMFTNglX11M1L+2IFknQmpow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727196059; c=relaxed/simple;
	bh=3gD3nb59lyZxLhkoxFeWjQ+vTGoqQ+1LYG2lqO2CahI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QH2ObV0L0+JUqx1bY+izoiy5ccekCUSxGbBb/GxoOSG2+WbyHWCj2CeHIxMF4GiH5RTrRUl7cw3JpcjOlEt8+Hv/cNSDkyGN6m0omOcB4gwwsqE5u59tJHR0AoINV3zb+C9WLB8j2fZZp0d1rD/f7DcD3syvVN1ZxnzI3NF8RQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=I6NQg/R1; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6c34c02ff1cso35405596d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1727196056; x=1727800856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gD3nb59lyZxLhkoxFeWjQ+vTGoqQ+1LYG2lqO2CahI=;
        b=I6NQg/R1errCAs5f7u+rNn8RyUe8HTk+Z0fg7gDy8A5lJi1OBoLByJk92va1Mqste+
         ra46bvt3NRwlj6vHES/NXXySsAJR6qHOiFOiB6XtmrL4w2636Le+PS8TE0M6FDOikajv
         uBCMwK2FOrzuddfsww+koIlIyLADYB/wUKriQklpeSrp9JVB/ele0rjZsZo3ilm+FQ8O
         FFakb1GJII5BQ3NvxCwMRtkiEE3OnDhZiaJO1m1daY272uCkp6Uf6PO9muRNmSVGILne
         x4YAmRo9+jAxEa/UH3Zbq+heMU18Q3CFgMX5cQp0cheOZJk6gQa7JwWUXmvxHx5w2duk
         nNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727196056; x=1727800856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gD3nb59lyZxLhkoxFeWjQ+vTGoqQ+1LYG2lqO2CahI=;
        b=PdneUIgAZRlNufVCKUzlgbI0yZ9a96FbjkQz2yS28mzDK8xXmfXiwVwpF/I+YOid4X
         lT5YS2ygHOPvxgEurSY5t6nPqOkXa5CWoPVDgjuQwxcr28ndP0nRH8ofe5C8kVqP3NfH
         6sfzzcbCIK5Mc0Gpj4BkOd5EnKue3sVnL013+F9pkh0jHwyfZXFXrYyxBwkjD75IC+2i
         XpAlu52Y81wkIHQihYlJtqR1/hxAEIONBlm+/nzHyZIgLoq2nTq2un+mE1iVIk1afOfg
         I/N0QyEqH29dB7nIN/6CYxI4Qm3mkBFDJ598IB9CbjmgZF+tCw5Zr8l/66+HWU4NPlPr
         HklA==
X-Forwarded-Encrypted: i=1; AJvYcCUyFEiljmCWk3qLchKN/u9AFLFO3zoYEM4c3iNO/GcJi+1tfCAUkb+V5CIeqPfGv38+e6NbK64ViG1cAXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/jaj+d2YWwvgb6pagu6S8baCHpndsR6rkL2oxBAOiBYx/Ehbq
	+YxLw1NY7ZwQZ5joWU8T5nArzkRijgPrdH1EATHk/siOdXEta48JfmF2lodbNyg=
X-Google-Smtp-Source: AGHT+IFJYP6BgUnqYcjH73JqqWOcD4NygI7jzlTvs/gJ9sdNCwq5nEPMFeOsYKZfYRmb1d8iynkHDw==
X-Received: by 2002:a05:6214:5546:b0:6c5:72c0:728b with SMTP id 6a1803df08f44-6c7bd506250mr193680686d6.24.1727196056022;
        Tue, 24 Sep 2024 09:40:56 -0700 (PDT)
Received: from fedora ([173.242.185.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4c2f51sm8013886d6.31.2024.09.24.09.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 09:40:55 -0700 (PDT)
Date: Tue, 24 Sep 2024 09:40:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Eric Dumazet <edumazet@google.com>
Cc: yushengjin <yushengjin@uniontech.com>, pablo@netfilter.org,
 kadlec@netfilter.org, roopa@nvidia.com, razor@blackwall.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net/bridge: Optimizing read-write locks in
 ebtables.c
Message-ID: <20240924094054.2d005c76@fedora>
In-Reply-To: <CANn89iLoBYjMmot=6e_WJrtEhcAzWikU2eV0eQExHPj7+ObGKA@mail.gmail.com>
References: <14BD7E92B23BF276+20240924090906.157995-1-yushengjin@uniontech.com>
	<20240924063258.1edfb590@fedora>
	<CANn89iLoBYjMmot=6e_WJrtEhcAzWikU2eV0eQExHPj7+ObGKA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Sep 2024 15:46:17 +0200
Eric Dumazet <edumazet@google.com> wrote:

> On Tue, Sep 24, 2024 at 3:33=E2=80=AFPM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > On Tue, 24 Sep 2024 17:09:06 +0800
> > yushengjin <yushengjin@uniontech.com> wrote:
> > =20
> > > When conducting WRK testing, the CPU usage rate of the testing machin=
e was
> > > 100%. forwarding through a bridge, if the network load is too high, i=
t may
> > > cause abnormal load on the ebt_do_table of the kernel ebtable module,=
 leading
> > > to excessive soft interrupts and sometimes even directly causing CPU =
soft
> > > deadlocks.
> > >
> > > After analysis, it was found that the code of ebtables had not been o=
ptimized
> > > for a long time, and the read-write locks inside still existed. Howev=
er, other
> > > arp/ip/ip6 tables had already been optimized a lot, and performance b=
ottlenecks
> > > in read-write locks had been discovered a long time ago.
> > >
> > > Ref link: https://lore.kernel.org/lkml/20090428092411.5331c4a1@nehala=
m/
> > >
> > > So I referred to arp/ip/ip6 modification methods to optimize the read=
-write
> > > lock in ebtables.c. =20
> >
> > What about doing RCU instead, faster and safer. =20
>=20
> Safer ? How so ?
>=20
> Stephen, we have used this stuff already in other netfilter components
> since 2011
>=20
> No performance issue at all.
>=20

I was thinking that lockdep and analysis tools do better job looking at RCU.
Most likely, the number of users of ebtables was small enough that nobody l=
ooked
hard at it until now.



