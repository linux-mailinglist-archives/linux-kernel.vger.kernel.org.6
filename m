Return-Path: <linux-kernel+bounces-378627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 030549AD364
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5251C21D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7AF1CFEC8;
	Wed, 23 Oct 2024 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ0IKM1w"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D5A15EFA0
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729706223; cv=none; b=jLnexYEczTMn6AVvMUFtzLraYi55eklPc0/Lbm8Bz+14CrmMgn06+cDouEfdyHBcK9238swIPTOB931j1mfpqOs5D9pF/5P4+OtdvVfcZ0n7pHEAFWzQH9Qi0AzPYbB5ioXD1Df+qGZbcz+2OOkdpRO4BQkQ8JU7fTjfJL33jHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729706223; c=relaxed/simple;
	bh=rMoGG26xBMc27A53/w+5mvILHWaZsBRQZNCrqqn42xA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ba/S1N+55eYrTFvjC9GTSO3x4i4xNV3qLw8kmz6KHMdwtOV//71ixTTaXIQyBMe8ccqCg/HSyTq0MEhkOXOnjfm9sdn+EouNf4mFxBmpXvyKlZP41XnPH4MuNN3uf8D0zv0T48qfNTEHXeOWECOXw4+Ys2y+jRgGC3U7AFrf02o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQ0IKM1w; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so69401fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729706220; x=1730311020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvB5xKaiaZK0YemghYyGAcxFhcYXko09rPH6v+w5h1s=;
        b=eQ0IKM1wgvMQa/z1+6mmnrbKgjiqHtkN3Fvto9JqbNzeG5IaREuhl5epw8y4PMmw5t
         XyZbCkxiM32aeNvHaIdmQsac02rW2i6a1A64hDKv9H4vSX8ng6TdHJKAAADM6foUPvhF
         3iXf+HYPjpBsq262Rasv9XIIssS/4lrauGXhpE+ozq/wcpoukwCF3H+sfi7R4pjbIn6/
         cWQ8GBv6a8NFR6yq2rQkCQjtEnxSmD4VZQOtihmyfOn/Yh4GMJH7rtCbeU52O1Z43B96
         HEX98GDjLF3/ZFJxGptGw05R7M4bY35fwobtnb3TXrPfNgOpPC30vBzYF+/+uo3Mcnt8
         N/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729706220; x=1730311020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvB5xKaiaZK0YemghYyGAcxFhcYXko09rPH6v+w5h1s=;
        b=p7ikmy6WqluxInS+lf+N8558dPmF5QlRyMdFmQZ8y7J/fkU2PFHRYaVXvuSZ/uxPSi
         T0nNh3wNU3rLIReeprzBonMXE/v130othVjZyKmyHchyvzkiUJMz8VkySFF4wNmGaFZq
         zoElw4FFsm/ElBZcXstAvlyK3u/PY2/3Zj4t4v39CgrgdiXZn3Q4Xw58NFKgTFNTxfvR
         6xh4ZgSStdTBm94Pg6qX9lqav8J3BTXF3ZO7zUWph7DOrZ2FrciEaF9LY+JTjEYmUMhh
         wcMELWoM47/+Nq71OPt5XDTxCZDQKVXAXkk3EqDbVeuY7k8eMLdQLWYgYzZN9j2IMUqt
         rOjA==
X-Forwarded-Encrypted: i=1; AJvYcCX2qlgA7dZJoGrHsNSZtp4VCtjgWwRAZY9bb4iSevKosegobc9zhCyIXWzjxLzhLkx+zR06wtGPqwPM5zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnGMbLgmpHx2KX5L83xzJiLHc/D4jFmwMWfmePnnPWVRjlC2nw
	K3EiUka/oJFsuVWatOYasmVh7jzVVORl3d4Jay5J5uUZvn0Zn6mMIM+yB/p6A4j+gDmFVzk46Vb
	MO3824GpOGxa/+qVUb34OcBownKk=
X-Google-Smtp-Source: AGHT+IEPIQrS+O8DzEln/5FzOgknpG2IVQ+T0FgY4EWyYaDTb7RwkuQQyvMOpcl3Gd3x0//o3WDcADUY3sx5M/NYENg=
X-Received: by 2002:a2e:5119:0:b0:2fb:5014:f093 with SMTP id
 38308e7fff4ca-2fc9d5f8580mr16440661fa.44.1729706219460; Wed, 23 Oct 2024
 10:56:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022192451.38138-1-ryncsn@gmail.com> <20241023032744.84a6a9f6f5f1e3aa1fe5f0d9@linux-foundation.org>
In-Reply-To: <20241023032744.84a6a9f6f5f1e3aa1fe5f0d9@linux-foundation.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 24 Oct 2024 01:56:43 +0800
Message-ID: <CAMgjq7CNm1iFvzmbjMy+J7aruVMhsMW=fdSFgCHCT3MuspsUNw@mail.gmail.com>
Subject: Re: [PATCH 00/13] mm, swap: rework of swap allocator locks
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Chris Li <chrisl@kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Hugh Dickins <hughd@google.com>, Yosry Ahmed <yosryahmed@google.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 6:27=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 23 Oct 2024 03:24:38 +0800 Kairui Song <ryncsn@gmail.com> wrote:
>
> > After this series, lock contention on si->lock is nearly unobservable
> > with `perf lock` with the same test above :
> >
> >   contended   total wait     max wait     avg wait         type   calle=
r
> >   ... snip ...
> >          91    204.62 us      4.51 us      2.25 us     spinlock   clust=
er_move+0x2e
> >   ... snip ...
> >          47    125.62 us      4.47 us      2.67 us     spinlock   clust=
er_move+0x2e
> >   ... snip ...
> >          23     63.15 us      3.95 us      2.74 us     spinlock   clust=
er_move+0x2e
> >   ... snip ...
> >          17     41.26 us      4.58 us      2.43 us     spinlock   clust=
er_isolate_lock+0x1d
> >   ... snip ...
>
> Were any overall runtime benefits observed?

Yes, see the "Tests" results in the cover letter (summary: up to 50%
build time saved for build linux kernel test when under pressure, with
either mTHP or 4K pages):

time make -j96 / 768M memcg, 4K pages, 10G ZRAM, on Intel 8255C * 2 in VM:
(avg of 4 test run)
Before:
Sys time: 73578.30, Real time: 864.05
After: (-54.7% sys time, -49.3% real time)
Sys time: 33314.76, Real time: 437.67

time make -j96 / 1152M memcg, 64K mTHP, 10G ZRAM, on Intel 8255C * 2 in VM:
(avg of 4 test run)
Before:
Sys time: 74044.85, Real time: 846.51
After: (-51.4% sys time, -47.7% real time, -63.2% mTHP failure)
Sys time: 35958.87, Real time: 442.69

Tests on the host bare metal showed similar results.

There are some other test results I didn't include in the cover letter
for V1 yet and I'm still testing more scenarios, eg. mysql test in 1G
memcg and with 96 workers and ZRAM swap:
before:
    transactions:                        755630 (6292.11 per sec.)
    queries:                             12090080 (100673.69 per sec.)
after:
    transactions:                        1077156 (8972.73 per sec.)
    queries:                             17234496 (143563.65 per sec.)

~30% faster.

Also the mTHP swap allocation success rate is higher, I can highlight
these changes in V2.

