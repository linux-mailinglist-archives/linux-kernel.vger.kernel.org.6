Return-Path: <linux-kernel+bounces-336071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A9B97EEC4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C562817BD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C17447F4A;
	Mon, 23 Sep 2024 16:01:53 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17B98C07
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107313; cv=none; b=QCnEhlYCRmovlnttl5UhW3aSaq36e4CQXixoil+7FqIlrrAlGJmyXJER1M5eHNQ9+0BO9H5bSz6nrRnns0w3n5lSEXDMVf46PJOaGBaIehrJZ+TqWhZ2qXIxzSfsCwDetPhJK7aHGMn8jQZNUloJs7AXMm49bdx9VykVQ7TJP2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107313; c=relaxed/simple;
	bh=qqtUj5LfiOoD+U3o0G/cMedfpui3xX7uk5v0+DwTZZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJLnHyoFkTFzlxLhYx3/xNaRAC464xd+9Vy6o9k/v0wFbMnaIZuPMuRC7TH9PRWx1c4lsEROIPuKts9ypzKZZZ7ev0JdXJ7w8sVW1Z5U7pWE7PfhjjJPQ5qxj4qWmDLKRhKk7XTa1JIfB4AhclOwJ432nsg4x7bfxVDYzeJOt1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e1f48e7c18so8705367b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727107307; x=1727712107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trvnU2f2BnPquVQkgl+gsZkg5UvM0YwSQbtJ6O3Txzw=;
        b=vuNXh+qDgTdFr3hvrv4rwLjJf+0zdNbxltGiUmKA0F06NUmgWj7uxjisaHzUny2cTz
         IG4J1I+dUMzF1JMnylpk5sFJHzKwWM+y3vlsytEMoiE6jr5NpNt1TtU9J5GQ/RFDbYVV
         LbgGthp+px3uWHdSCbts2JxtvL8t9nsNbFoGo9AZv/yiZ7GB/pQV2ZcLsOfr8sN9ZIT7
         4ITpSQ2+qBRg1Xgqbis5dIsg+ezq6GfP9gK2UEL1PfOrS/RysZxEOFCif5M2UhC0tlFE
         5nkcOheW865O8WbFgl7s1WtNMhV6rRBwciwEsinP0uK7Ef0zMGqw7aVsr/Lq/7o62HvM
         Sy7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyBog2mJVpuuEOeQK6ZWvGTV4V5cqfg6JXgMle5pvJyul3HMjPkeLp75KyopjmzEJOrRRWybhcskH8McE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqMg87lwu3WPkkwHwxrNadp08tKDxKYOroZtewYNnO6qO/WDEo
	W3+AIFYelU7ujQ0bBE9w8+qrdwoHWQb0hlb+TdCKLmMRxRuukLx5/RFdja87
X-Google-Smtp-Source: AGHT+IGtafX81iigKv7e8fwK9D0JWKVQCwi9VhmF1nnpORWVg6MpmE9V0NP9M0lrsgGoursyWXEu1w==
X-Received: by 2002:a05:690c:d84:b0:6e2:636:d9ee with SMTP id 00721157ae682-6e20636dda3mr8779457b3.9.1727107306852;
        Mon, 23 Sep 2024 09:01:46 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ddbb587ef0sm32592707b3.98.2024.09.23.09.01.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 09:01:46 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e1f48e7c18so8704847b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:01:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3ZLw7rSqOhQvl4hOUz4fbLFUKMEcES35un+kXjdhx6tvAzTPq3qo9f8iJUfi25dqOmZZ6jQid0HIXP8I=@vger.kernel.org
X-Received: by 2002:a05:690c:ecd:b0:65f:aaf1:9dd3 with SMTP id
 00721157ae682-6dff270f59dmr89217777b3.2.1727107305597; Mon, 23 Sep 2024
 09:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922225041.603186-1-linux@roeck-us.net> <CAMuHMdWAuQcFQaQNy2EP_u9vk13g2C3sb3FFBCMAUPyGMgZ+hg@mail.gmail.com>
 <435dc218-f7ea-4697-b3ef-6a786e8d1b2c@roeck-us.net> <CAMuHMdVZWWj8aLvRfX4xH_x1v0gMg34jaX24bqB2Qc4Q75ZFhQ@mail.gmail.com>
 <2ece7321-f6e8-4d4b-8092-8ff7d3dc760f@roeck-us.net>
In-Reply-To: <2ece7321-f6e8-4d4b-8092-8ff7d3dc760f@roeck-us.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Sep 2024 18:01:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVLLnaGKzKFTXST1qgTtJvYqDg109Yv6n4MJtu_ifvuoQ@mail.gmail.com>
Message-ID: <CAMuHMdVLLnaGKzKFTXST1qgTtJvYqDg109Yv6n4MJtu_ifvuoQ@mail.gmail.com>
Subject: Re: [PATCH] resource, kunit: add dependency on SPARSEMEM
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Huang Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi G=C3=BCnter.

On Mon, Sep 23, 2024 at 4:55=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
> On 9/23/24 06:47, Geert Uytterhoeven wrote:
> > On Mon, Sep 23, 2024 at 3:39=E2=80=AFPM Guenter Roeck <linux@roeck-us.n=
et> wrote:
> >> Interesting that you get that to boot. The q800 machine crashes for me
> >> when trying to boot it in qemu with the latest upstream kernel, in fun=
ction
> >> __pte_offset_map_lock(). It bisects to commit 394290cba966 ("mm: turn
> >> USE_SPLIT_PTE_PTLOCKS / USE_SPLIT_PTE_PTLOCKS into Kconfig options").
> >> Reverting that patch fixes the crash for me. I guess you are not seein=
g that ?
> >
> > I never used qemu -M q800.
> > I have just verified that -M virt boots fine?
>
> Not for me :-(
>
> Run /sbin/init as init process
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
014
> Oops: 00000000
> PC: [<000ca784>] __pte_offset_map_lock+0x36/0x7e
>
> This is with virt_defconfig.

Before, I was using my current development tree, which has lots of
local patches. So I retried with commit 394290cba966.
Boots fine into Debian:

root@debian:~# cat /etc/issue
Debian GNU/Linux bullseye/sid \n \l

root@debian:~# uname -r
6.11.0-rc6-virt-00033-g394290cba966
root@debian:~#

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

