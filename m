Return-Path: <linux-kernel+bounces-537679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 449BCA48F08
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2261891BAF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A507115A87C;
	Fri, 28 Feb 2025 03:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCgxRF3i"
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ED3276D37
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 03:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740712601; cv=none; b=BpPU0NHxUhzM9qo9OzrMwskbqktZ74HXtGgOSg+AmROObfPREBkwRZXCXSDvSaVFXn2wGEcGaf5WCmLmDstwi0vso3dXi78qZs5bwS2oYGyMNmUoDsS745+OmEsOwgJgqsb2r3SBUmdFqWalbIGfMFDNW36U58UbdNK5EZ2P4Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740712601; c=relaxed/simple;
	bh=16PsM1hZHh5EdbZ8YIY3Neqt37raxq7tLRBID1W5BIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSLpLx4oakaYJ90bSu7zyIXP27r2cO8e4NUQMX/XLaWkGZIVGOjgHulFP153AtrHaR1dOEOQZP/Ras4+32sVIlksal1Nom2x8yDE4NDUhN2r6T4N2vc9LrN9mtQ/PgFBIoWGARkl4AKVM3fyLKt9FCuxGsrNoiPbnAG4TakiG5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCgxRF3i; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-abb81285d33so317293466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 19:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740712597; x=1741317397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsQv1V81RoMvDet1T87kyc/NnMb5goNVEAJP9Aqhjow=;
        b=lCgxRF3irtW0Z0DlEFUlGETx7UXAv26jbTV85D5laddKP3FJmSvDffv1adZXvMLvjV
         lVVyIjAuvQqVZcDw6qB1k3M45KeSOWysEvFhs1SU9oqJsBDhyAvXsTDlUxie4em66IgE
         r6GTTJHjudj68lOgFconHGhKXMxGmDBQGSbKq06gH+7xx3pdxeUWN4Sz7K/7F7tHRvwE
         vj+47WWHabnoL3Qznr+ucOxp2vuWBfETLCEJonwFtA3PYTAIykufQ6oZbAujV5ATTUCP
         IRmxyAejgNeSAel8Z3QevFMh3Dk0bEYQl0ylahbbg/KC2SdTjRzKWtGb7HsdIboA0PvU
         3bYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740712597; x=1741317397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsQv1V81RoMvDet1T87kyc/NnMb5goNVEAJP9Aqhjow=;
        b=h3RVUWOZZ/OHS9mTHID03zN1c0AsNRYk5X3nBqXH46E7YrxcUJFQvm5DC0FeUPxPo7
         SU7lS/5baoI5eMDrm+MnJoctlsUMOcg+43gJNJx6Jv8P3eADTgXid6aWxEH+1xZubVmJ
         ERgKH+7ye0RC52e38+5EJUeiCoi6DM5HRX5sxIq6kf5ERBeflhdsD+Xovh8GjZeB94IO
         CcdXU5OAmFxypkYXFqdnhI0yiPcXBDxnReQro28EKoCruZx4GyDxD2tICk3ZHuaZy2fA
         lzxP6nYYl9V9wAOj3pGa/+LRQVxGgOQfwqX/8cu4CYDPg8uZwsumytQTb7vTGLv0tQ2W
         CHCA==
X-Forwarded-Encrypted: i=1; AJvYcCXxu1Wpx3LM7jPjPD+vPkZfWUgjmKmkWoz9U7sCSzaTx46oXgJI0xTYJq+V08SD3rmjxGqLtAh+we0n4MU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZeRQKR6sPl1SZzTY5cV2KC5YU8x0fSDFUdqsE7C6J3rdTH+Kn
	Ai9jFxkKDPWqWyOL1y3AdsFtx7+YRS5DGfBBA8tLJJ3TTEmeeRhOFwVAoKljYeO/DwuETZSb/jx
	cqp3uqB++LODR3SSjDkbTIcUfaI0=
X-Gm-Gg: ASbGnculqLpp0ny1cLRp9z8RzTusegIDL+Vtp1adGPkFMTHHAig2qcKgsmazgzzIEO4
	eNx8ugwXxJVPUHECFiV5AQT7kaK2v+mZ7HCmD4bwGQWn5XQheqcc1aQcxbRXOoqGHjcEsLtvEgI
	MA/cW4oLMo
X-Google-Smtp-Source: AGHT+IGtTLidtoJ1+wTRTSrRYN6Stb7rU8rJHiX+Hp1pZywNzcYDvnpR3lE67iaDxJfTRHQve0GKBK5FjyIMDANyQ8U=
X-Received: by 2002:a17:907:7f0f:b0:ab6:b9c0:1ea2 with SMTP id
 a640c23a62f3a-abf261f2529mr163289766b.25.1740712597351; Thu, 27 Feb 2025
 19:16:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN2Y7hxDdATNfb=R5J1as3pqA1RsP8c8LubC4QxojK5cJS9Q9w@mail.gmail.com>
 <20250227155431.2534325-1-joshua.hahnjy@gmail.com>
In-Reply-To: <20250227155431.2534325-1-joshua.hahnjy@gmail.com>
From: ying chen <yc1082463@gmail.com>
Date: Fri, 28 Feb 2025 11:16:25 +0800
X-Gm-Features: AQ5f1Jryxw3FMTA2IoyXpHhM2strZZsKlz0OOnXnnAoM-bqY5L_DIGfHx66LEFI
Message-ID: <CAN2Y7hwBQUwWZLjgOZHuMLeLKGkgqJec=2YOGftizPjrHObcGQ@mail.gmail.com>
Subject: Re: [PATCH] mm/vmscan: when the swappiness is set to 0, memory
 swapping should be prohibited during the global reclaim process
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, hannes@cmpxchg.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We only create a limited zram disk size for the cgroups that allow swapping=
.
If this part of the swap space is occupied by other cgroups that don't
allow swapping,
the cgroups that allow swapping may not have enough swap space available.

On Thu, Feb 27, 2025 at 11:54=E2=80=AFPM Joshua Hahn <joshua.hahnjy@gmail.c=
om> wrote:
>
> On Thu, 27 Feb 2025 22:34:51 +0800 ying chen <yc1082463@gmail.com> wrote:
>
> Hi Ying,
>
> I hope you are having a great day! I wanted to share a few thoughts:
>
> Previously, when the system is under a lot of memory pressure and is
> facing OOMs, global reclaim can create space for the system and prevent
> going out of memory by swapping, even when swappiness is 0. If this patch
> removes that check, it would mean that global reclaim can no longer
> "bypass" the swappiness =3D=3D 0 condition.
>
> I am also CCing Johannes, who is the original author of this section [1],
> who clarified in the patch that swappiness =3D=3D 0 has different meaning=
s for
> global reclaim and memory cgroup reclaim.
>
> > When we use zram as swap disks, global reclaim may cause the memory in =
some
> > cgroups with memory.swappiness set to 0 to be swapped into zram. This m=
emory
> > won't be swapped back immediately after the free memory increases. Inst=
ead,
> > it will continue to occupy the zram space, which may result in no avail=
able
> > zram space for the cgroups with swapping enabled. Therefore, I think th=
at
>
> IMHO, I think that even with zram, we would still want to allow the syste=
m
> to reclaim memory & swap out, in case we are facing imminent OOMs. Even i=
f
> the memory isn't immediately swapped back in when we are able to manage t=
he
> memory spike and see free memory, I imagine that we might not even be abl=
e
> to manage the spike if we prevent global reclaim from swapping.
>
> These are just some thoughts that I had about the patch. However, my
> understanding of zram and reclaim is limited; please feel free to
> correct me if you see anything that I am not understanding correctly.
>
> Thank you for your time, have a great day!
> Joshua
>
> [1] https://lore.kernel.org/linux-mm/1355767957-4913-4-git-send-email-han=
nes@cmpxchg.org/
>
> > when the vm.swappiness is set to 0, global reclaim should also refrain
> > from memory swapping, just like these cgroups.
> >
> > Signed-off-by: yc1082463 <yc1082463@gmail.com>
> > ---
> >  mm/vmscan.c | 9 +--------
> >  1 file changed, 1 insertion(+), 8 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index c767d71c43d7..bdbb0fc03412 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2426,14 +2426,7 @@ static void get_scan_count(struct lruvec
> > *lruvec, struct scan_control *sc,
> >                 goto out;
> >         }
> >
> > -       /*
> > -        * Global reclaim will swap to prevent OOM even with no
> > -        * swappiness, but memcg users want to use this knob to
> > -        * disable swapping for individual groups completely when
> > -        * using the memory controller's swap limit feature would be
> > -        * too expensive.
> > -        */
> > -       if (cgroup_reclaim(sc) && !swappiness) {
> > +       if (!swappiness) {
> >                 scan_balance =3D SCAN_FILE;
> >                 goto out;
> >         }
> > --
> > 2.34.1
>
> Sent using hkml (https://github.com/sjp38/hackermail)
>

