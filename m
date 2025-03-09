Return-Path: <linux-kernel+bounces-553408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A394A588CC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 23:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E2716A7C5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 22:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C581A239F;
	Sun,  9 Mar 2025 22:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iwy8CAZR"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5859818E361
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 22:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741558869; cv=none; b=qMKGuhXwY7xXEzWtwogHvmG2e/mC7pjey0OOXLB1kD+QiR8jA50jHNtJKS3NS34mhhX7sxiNpULv3jQDZcwMTFPIQRdsLYd0Cs0HXnKItuTHs0+FyrINpjX/Rq2R7HLgklXHkRkFQGAyMq8TidlzLHBtVL5q0ieBqTJkHJeaXMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741558869; c=relaxed/simple;
	bh=khV2AssbhnLUcmeC/isyhJwFo+WesdkN7LBjGBSdbQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMDWnXBRgOkWRqGrVqEESmFjZaUwNtXorA/3Zbj4Ju5JMK9aalp/bXNR5J0wyYObKxmzBuUITx+gojDWccgZG/NdHtUySAFdvvQGAm/cP+g1x9ofFIxQYuwQbU20HDAOCLpkj5ktgtpD5lC7XJMvUAGGHsqcgbD1+HRkyPirG6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iwy8CAZR; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c3ca86e8c3so244327285a.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 15:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741558867; x=1742163667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mda49N4Llb9FH9F0+WkzWs1rqlShmxC1BmbC6l/Iyuc=;
        b=Iwy8CAZR48R2g0kQKOy9yS+61LpXBlqGHutFhncpqLeyj3M2ZkT8gcQSE3ZI3yTjAR
         kyoUb/YcKFTsHD/dWDT1WK/7T0+RKBB1ZN4QpqVX9VbaJxM5WuXDGQKubgnQuz0+STmB
         bQ4GV3FYBS7DCmVshPWxz8QNtCmt8vb8skcNzx2ZkO2wt/lTKIK8RjoNTzyQgYhpMzzy
         Lp+pr1s6DQLt3bJmgLvv9eMQg7V3ktT0TWDwHzkq+au4GZhMXLz/tXmyYa4lMy9hJlTv
         qjE1R3403zkDMC+opEcXSZA3i40mot2EthM1rQxCd2dMdpWAsWzae811AMWPE3kyvMkf
         IYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741558867; x=1742163667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mda49N4Llb9FH9F0+WkzWs1rqlShmxC1BmbC6l/Iyuc=;
        b=wFFxlDZagfl6aqPv9ndOGKKSdaWn0fMzDMhh1VEeJy9EQuG3GihJFYZVBJJsDdCIEz
         MWdJAjWG+eD9BxDPUarq7T9CkCGFOK/YwFFgK1xfZ74CIyHd04QYJjbN1GiMfoiC8bTt
         H/VxJXjxq4FZoQ5EykeHwxN+wg20u0SPACklRQL87LZl49EBkzP0Swzf/KcoJ6ux+UHu
         KoM0ZaJZXdLqa6AYOSOf86ajEj9cHOfDrh//fngCJXDE2p2cW99b/JWYSAhAQIk6kbIn
         PWYIFySn/5DGqtdxzwdi4ppCz+IOVp92zI9QlGlS6c3Aud81Q1IhYlf9QBH5xlQDNCnR
         d9mw==
X-Forwarded-Encrypted: i=1; AJvYcCUn9iD6Hm9anMS0mM/TJhEZnluVBYurPf4HLNu6ljNE/28PxqtM4bElnpbW1QskI9VgmIv5AlL10F7A3Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj2bAq1xWuCwYGAMElQ8vprka3h9QXeZLF0TaL/m6pZEbJmFcg
	xpo6jEcljs57Kuu4ybOAU0V8hUyj/Lim8McTXpzCgvo4WdBL6kh+B7vzGxNRjTBm8sxrnmleAQQ
	NldwgLER8SNa6Tm/ZlCd2Vud+cYCLNNqa+6A=
X-Gm-Gg: ASbGnctH+mjJGIGXXqSbtloW0xX+fuJwSY8XBNbdFO+kndGHDzKpvY7lDFhY7stDKwc
	t3I132h7CDCbuZFqlSfDnlMjY8xq6beu8XGpV9fQtrM18wlcDhcObaNiUg9GPPbR293iLhIyYl0
	LY4Mm0VO1j7UOB1q0rG+KB6/y+PCLAEsWYmU3+
X-Google-Smtp-Source: AGHT+IG+fco3RuCq16yz4lbW6ruVn50Joad/g3vYtByAHgzqgrRMAuGi2/nhyl0Yv1EsoL43F5pb4oFJGb6pP0Pnks8=
X-Received: by 2002:a05:6214:76c:b0:6e8:955b:141e with SMTP id
 6a1803df08f44-6e90066bc53mr146725396d6.21.1741558867007; Sun, 09 Mar 2025
 15:21:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307120141.1566673-1-qun-wei.lin@mediatek.com>
 <20250307120141.1566673-3-qun-wei.lin@mediatek.com> <CAGsJ_4xtp9iGPQinu5DOi3R2B47X9o=wS94GdhdY-0JUATf5hw@mail.gmail.com>
 <CAKEwX=OP9PJ9YeUvy3ZMQPByH7ELHLDfeLuuYKvPy3aCQCAJwQ@mail.gmail.com>
 <20250309010541.3152-1-hdanton@sina.com> <CAKEwX=Mwh9SKWfmaS9q4fym7L-v5m6GmvJrQF8eFizJJd904rA@mail.gmail.com>
 <CAGsJ_4wFfqFZQw-TOM83gUEV_rN6uio1sujXdjCRKTOipPM2SQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4wFfqFZQw-TOM83gUEV_rN6uio1sujXdjCRKTOipPM2SQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sun, 9 Mar 2025 15:20:53 -0700
X-Gm-Features: AQ5f1Jp-fSSmHXAcHy1ZOYNbNwFx7b00IGaeSLZw1VYfH3gufSDCE7BUgw17nfE
Message-ID: <CAKEwX=Nfu23j37GLGBXnxgb0N0Hwnk4jVneY=wTSUNQBDTgCXw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kcompressd: Add Kcompressd for accelerated zram compression
To: Barry Song <21cnbao@gmail.com>
Cc: Hillf Danton <hdanton@sina.com>, Qun-Wei Lin <qun-wei.lin@mediatek.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 1:44=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Mon, Mar 10, 2025 at 8:56=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > On Sat, Mar 8, 2025 at 5:05=E2=80=AFPM Hillf Danton <hdanton@sina.com> =
wrote:
> > >
> > > Could you explain what nr_kcompressd means, Qun-Wei, to quiesce barki=
ng lads?
> >
> > Who's the "barking lads" you are referring to? Please mind your languag=
e.
>
> I also feel extremely uncomfortable. In Eastern culture, this is an extre=
mely
> vulgar word, more offensive than any others.
>
> I strongly feel that this violates the mutual respect within the Linux
> community. This is a serious case of verbal abuse.
>
> Regardless of the existence of nr_kcompressd, it is still unacceptable to
> invent an interface that requires users to figure out how to set it up, w=
hile
> kswapd can launch threads based on NUMA nodes.
> This should be transparent to users, just as kswapd does.
>
> void __meminit kswapd_run(int nid)
>
> {
>         ...
>         if (!pgdat->kswapd) {
>                 pgdat->kswapd =3D kthread_create_on_node(kswapd, pgdat,
> nid, "kswapd%d", nid);
>                 ...
>         }
>         pgdat_kswapd_unlock(pgdat);
> }
>
> On the other hand, no one will know how to set up the proper number of
> threads, while direct reclaim can utilize each CPU.

Agree - how are users supposed to set this? The default puzzles me
too. Why 4? Does it work across architectures? Across workloads?

This makes no sense to me. Can we scale the number of threads in
proportion to the number of CPUs? Per-cpu kcompressd?

