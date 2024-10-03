Return-Path: <linux-kernel+bounces-348481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C017798E832
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 03:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50DF1C228B1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 01:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAA0182A0;
	Thu,  3 Oct 2024 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YjRc9BSo"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE451802B
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 01:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727920241; cv=none; b=AX+f7UieAJO8HkFNDQ4yRc+EV1WFIJEAIHjogl8MG4s+ZN7cJVf0+LgEWVzfNTfION8S/cJKt+pB0BKWlZkH5cHKV8Qaa8Oe1bxGfArXh/J82hmz5IhChL9QVMPyp8enKXRp1x8R/mfD8T00WGPx1eIsOPNpjeVvokHNycABflY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727920241; c=relaxed/simple;
	bh=2oMMQpw55zQrCU0yJ+1ZI9faHlam+6bxamgErrV9cLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uOsXvY3UNWuSgSLjtMyiXCnOCkSsxjz3i07wrtPFCq4ZxfUreFoMCCjLRiDlsU+KEVclMY8gpXXSinV52q1QTwBEgOXq8HMH6o/+qJynyN2t8dFZzW0NgobdgKt5W6Y36soD3kpvx0U+fe2qXvjsi3+cTugnMx4qIEMf0nP3QNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YjRc9BSo; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-509fc9d2074so132639e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 18:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727920239; x=1728525039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNOKX0mt51eRMMcf7S69oS8Nk4Atwq3CBGwMXDeQ6Lc=;
        b=YjRc9BSo0sjr+EE0E1vdOi7O4udgPrzWGGpAu+kpRp2hQ+2CJ7SLpqSGuC8IYpniXA
         Vr0diHhamFElcsGo9aNLbzkcDciVNggFeR5ODppziR5NRqmTObZXqDlhZWsXmoK2NN/c
         9hZZ7Qm8ua0kIZl0z+lkAf87Qv4tonrA2svMMWiprh9C/HhgMWtCPYZnbm2tKfmx16OD
         BVJQrtoiqQtzaPslJKlQUkc6KA1gUm2enpwzD1Wrln5m2Z2b2pnrxi2kVFIxOsQE9dI4
         ulzyUShOmcNGNVf/DQSYfCBWRMblEU4R2JlPfEVroQi1ZyjhDLAkcsbCv7TQcwZQKsuv
         7Yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727920239; x=1728525039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNOKX0mt51eRMMcf7S69oS8Nk4Atwq3CBGwMXDeQ6Lc=;
        b=eqKRAOsJWAuoKwDxzUW6hhLZl9Wh4fJYbz7MVbu4sxt1y1CTfRlH+FNlEErlqPNxLm
         7Cvvp+HvwF72yREoxLWN7BqM+VUUIkjDT9iBRSP17E7gayOxMwmcl4oIc6lRFvrBFWvJ
         6bULDIH0kezq/TLlqOt+yg4KgDmtBvV5gkhsHWILidpOlYPAj/oE8pPW4B975I0n+TCC
         bfIO2u+FS0kvTH0O1H3rx/WKik/SETTo1N7t/r5WbYmxRmCTQzEFosNd14sX1IdVJee3
         nwZ3hcBq8tYiwnOamTkl4iPQXEbGxql2Lg6hPFZd1beK3by3ytnCDCkECeSlUnLe/f+L
         Q5KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoB+lOF9JRNrUHmoag3+d3B0YRkJJ7b2LBMJxQkqgX6xeUEyzwsg4xmnVwzjy/RnFICdlcMvSJFXPmiYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzClj6axTIEigTG3RTWzSJADkyn00+m3iNQDaQZD3gNUtcqZ85U
	8jxG0HJFxDKst0dpOKOtIQltlmv0jxm/tS84dO6UpYuI5qCPAyyBQ++aw7yFDH4ltnry0DUdKue
	xB2w0Jpx4ddulpOes1Sx3Tz77UTZ06IFhabIF
X-Google-Smtp-Source: AGHT+IGj/flUaJyJqkL1Fh2/zBqCAOP46vYIpqFQUf15PkkpNvd+6pQy1Y8e16Deeg4/R3adlvwY7hkL4CeupvFWBys=
X-Received: by 2002:a05:6122:31a4:b0:507:9096:423a with SMTP id
 71dfb90a1353d-50c58277e9emr4081833e0c.12.1727920238505; Wed, 02 Oct 2024
 18:50:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909-fix_amba-v1-0-4658eed26906@quicinc.com>
 <CAGETcx9X0m3=8PPtVsHp=AAjyCoUZ0-53H5RzVd4HCDtWRS0Fw@mail.gmail.com>
 <a4cf15fb-bbaa-4ed0-a1d5-c362b7a5c6e2@icloud.com> <CAGETcx_YMUXRLye3OUOQ9O4Cw9nqLcVOts0hTMgORuLmQ7tAZw@mail.gmail.com>
 <343ef9ea-12ab-4ca6-bd9a-fc01bbf9962b@icloud.com>
In-Reply-To: <343ef9ea-12ab-4ca6-bd9a-fc01bbf9962b@icloud.com>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 2 Oct 2024 18:49:57 -0700
Message-ID: <CAGETcx-NzgsUeStjNncP=AYiH9ACEbpMvS1J4doYFd39qZ2zig@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] amba: bus: Move reading periphid operation from
 amba_match() to amba_probe()
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Isaac Manjarres <isaacmanjarres@google.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 5:51=E2=80=AFAM Zijun Hu <zijun_hu@icloud.com> wrot=
e:
>
> On 2024/9/11 00:27, Saravana Kannan wrote:
> > On Tue, Sep 10, 2024 at 5:17=E2=80=AFAM Zijun Hu <zijun_hu@icloud.com> =
wrote:
> >>
> >> On 2024/9/9 15:24, Saravana Kannan wrote:
> >>> On Sun, Sep 8, 2024 at 4:38=E2=80=AFPM Zijun Hu <zijun_hu@icloud.com>=
 wrote:
> >>>>
> >>>> This patch series is to make amba_match(), as bus_type @amba_bustype=
's
> >>>> match(), also follow below ideal rule:
> >>>>
> >>> Also, patch 3/3 is not at all easy to understand and seems to be doin=
g
> >>> way more than what the commit message is trying to do.
> >>>
> >>
> >> thanks for your code review.
> >>
> >> let me explain the issue here firstly to go on with discussion, will
> >> correct it by next revision.
> >>
> >> amba_match(), as bus_type @amba_bustype's match(), operate hardware to
> >> read id, may return -EPROBE_DEFER consequently.
> >>
> >> this design is not very good and has several disadvantages shown below=
:
> >>
> >> 1) it is not good time to operate hardware in a bus_type's match().
> >>    hardware is not ready to operate normally in a bus_type's match()
> >>    as driver_probe_device() shown, there are still many preparations
> >>    to make hardware to operate after a bus_type's match(), for example=
,
> >>    resuming device and its ancestors, ensuring all its suppliers have
> >>    drivers bound, activating its power domain, ...
> >>
> .....
>
> >> 5) amba_match() is the only bus_type's match which breaks below ideal
> >> rule in current kernel tree:
> >>    bus_type's match() should only return bool type compatible integer =
0
> >> or 1 ideally since its main operations are lookup and comparison norma=
lly.
> >
> > All of this used to happen even if the bus match wasn't doing what
> > it's doing today. You don't seem to have full context on how amba
> > devices are added and probed. What you see now is a clean
> > up/simplification of how things used to work.
> >
> > Please go read this patch history and git log history for these files
> > to get more context.
> >
> > Nack for the entire series. It'll never go in.
> >
>
> sorry, not agree with you.
>
> IMO, it is easy to make amba_match() return bool type as shown below:
>
> make amba_match() always match with AMBA device with INvalid periphid
> and move reading id operation into amba_dma_configure().
>
> Above solution can have the same logical as current one but it looks ugly=
.
>
> so i make below optimizations to get this patch series:
>
> 1) only make AMBA device with INvalid periphid match with existing empty
>    amba_proxy_drv to reduce unnecessary reading id operation.

No it doesn't. Once match() returns -EPROBE_DEFER we don't try
matching with other drivers. So it doesn't cause more reads.

> 2) moving reading id operation to amba_probe() looks more graceful.

To do a driver/device match, you need to periphid. It doesn't make
sense to push that into some stub probe function instead of doing it
where it's needed. In the match function.

> Look at below 3 consecutive history commits:
>
> git log --pretty=3D'%h (\"%s\")' 656b8035b0ee -3
> Commit: 656b8035b0ee ("ARM: 8524/1: driver cohandle -EPROBE_DEFER from
> bus_type.match()")
> Commit: 17f29d36e473 ("ARM: 8523/1: sa1111: ensure no negative value
> gets returned on positive match")
> Commit: 82ec2ba2b181 ("ARM: 8522/1: drivers: nvdimm: ensure no negative
> value gets returned on positive match")

Those are commits from 2016! Way before any of the cleanup was done.

> the first AMBA related commit breaks that a bus_type's match() have bool
> type return value.

Have you actually looked at the definition of match and it's doc? It's
return type is int and not bool. And the doc says it should return
-EPROBE_DEFER.

> the remaining two commits at the same time really do not like negative
> return value for a bus_type's match().

This whole series is fixing a non-issue because you have a subjective
opinion that the reading of periphid should happen outside of the
match() function where it's actually needed.

And you even have a comment saying it's adding a race.

Russell,

Definite huge NACK from me. Please don't merge this series. I don't
see it fixing anything and it's moving around code for
pointless/questionable reasons. If it is fixing any real bug, I've yet
to hear it explained properly.

If I don't reply further, it means my NACK stands. If the replies
somehow convince me to remove my NACK, I'll do so.

-Saravana

