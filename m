Return-Path: <linux-kernel+bounces-306023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28769963827
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E9D2854DE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 02:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CF82AF03;
	Thu, 29 Aug 2024 02:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xy6AW5jw"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8ED156CF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724898312; cv=none; b=JRRik9zGpgaGHq+bMg25Gm2rLTnyfpqfeiLQ04RX6LEZJHPn2qPPzJAsvVKlvoj25jikcsws5pfNaLIgkhHYSkDm3DJf531g4AZqWREG2tDPl6fWTx7YV7fMXb+kNvqpkXrSud6IuVpcqzdjX6mCnnvznhD8NSBmiCM9A23Hxvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724898312; c=relaxed/simple;
	bh=MgiIelwC1tULckME10XI0a2ysHKj7m1eCsnDvvBHvpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kwiOKMPmI9obRi7wWIoN+U5vfXIFFPuec1V5KtrvBL8s5YeHuIxUZ95hE5Cri0gxOnohQ6lzlis/P8LSTbMuZuFfhnryCm+dkV2sEbDk/WNJ0/dtj7LgJf6Q5QlJhRwWf59/zVGORnobr62JKA6ahMeiDBdU0z0AWFSYKOs/HYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xy6AW5jw; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4fce352bd28so69078e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 19:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724898309; x=1725503109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgiIelwC1tULckME10XI0a2ysHKj7m1eCsnDvvBHvpE=;
        b=Xy6AW5jwJ5vdedVgcWWqCYcXCsMyhd4V0ioHXdYtgkbUTRb9Iz4XK77elBvxOJIUzp
         S9cieAolz1KMU+qmke+A6iM25b5efwLKhppCk+v3CJS/2Q7qRJWTBwS5TXj+M9Uqzp1L
         pQ5dGdyx4ZlORH1zG3m96EMCYHE04xpdVXHq56mDYcDdjw6NCH6x8ql3QqLyoyBkzmnD
         NmHQnEVdJq9dkwmJZsdo7mX4WNf/aZ6+9UGrkB4lFOho5MfVEudIMWhd9LqOM8+8+GJR
         c5UaV+EzGonVtbcWxOMhPari57m6HAceOOojjlxGw6SoqJmnKWuZTi2kCXtKshUZo7aG
         3t7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724898309; x=1725503109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgiIelwC1tULckME10XI0a2ysHKj7m1eCsnDvvBHvpE=;
        b=bC/sVAirlT5FiMAwBHynb67XiH8PLO2M2NnDEB6owD6wWIgSpHICDwfovCt7vhX03x
         RGCxIDAsv5rgEA/MDmRbK75IUyPJcAUVUzy8Utxj9cPWg+gsGl3/bmwCtZqzLAuG5HX0
         abhgVVUsc8uXInp0/7+R4jsCQCTbYbP4WznVByglILFqWE+9fyYA48uXK6aaJ5nxuKjk
         oeQT4EeG8yNo9mofduIAQ4gKKDlQ3qUVg2wNLxTnIlXu3awhIhVR8crhO+Mf5i0xsFbK
         zgkc20rT5IIUujb7byrSNaO8p4W2jD2VAnNxQYigNCIOs++6ZOUOaUm0I7ny8sZP+YEt
         IZiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDf/JrfFxVw8W+LsZpM54DWxoiLVMntWYyv7ccfPgWhIWHMBFClcsXifoc9DjLVhkBQ7i7CWVv6yZ2Wi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTdbInRu7XzjfynFWPjUdN98zHztHRmaPXNR30pB1B6zH8aeEC
	0q9uei45py9x0P8cGi1TUyVdcYwjmFHHH4ae9oABHts/IH4H3lxKPA1v5YNRmF2gANt+NwA1Kci
	syUuyjKpoLyl6o/RG/6bHpD6KcM0=
X-Google-Smtp-Source: AGHT+IHLZyMvJCjIlrvJvIhE91u/MLjozO/tmBPzLigPIwiVsANW38LZEDjmI6HruSXLIH+AD4PmuwIaQkvPK/p7PvA=
X-Received: by 2002:a05:6122:1e03:b0:4f6:a7f7:164d with SMTP id
 71dfb90a1353d-4ffea19f167mr1442739e0c.8.1724898309374; Wed, 28 Aug 2024
 19:25:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGsJ_4wGK6pu+KNhYjpWgydp6DyjH5tE=9+mje3UyrXdFJOuNw@mail.gmail.com>
 <20240829010103.7705-1-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240829010103.7705-1-kanchana.p.sridhar@intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 29 Aug 2024 14:24:56 +1200
Message-ID: <CAGsJ_4xLCknyaWk1a5RZ9h77QkamBxKi6HbjVhCbXPS9rm0WZg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] mm: support large folios swap-in for sync io devices
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: akpm@linux-foundation.org, baolin.wang@linux.alibaba.com, 
	chrisl@kernel.org, david@redhat.com, hanchuanhua@oppo.com, hannes@cmpxchg.org, 
	hch@infradead.org, hughd@google.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mhocko@suse.com, minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	ryncsn@gmail.com, senozhatsky@chromium.org, shakeel.butt@linux.dev, 
	shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, xiang@kernel.org, ying.huang@intel.com, 
	yosryahmed@google.com, zhengtangquan@oppo.com, wajdi.k.feghali@intel.com, 
	vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 1:01=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> Hi Shakeel,
>
> We submitted an RFC patchset [1] with the Intel In-Memory Analytics
> Accelerator (Intel IAA) sometime back. This introduces a new 'canned-by_n=
'
> compression algorithm in the IAA crypto driver.
>
> Relative to software compressors, we could get a 10X improvement in zram
> write latency and 7X improvement in zram read latency.
>
> [1] https://lore.kernel.org/all/cover.1714581792.git.andre.glover@linux.i=
ntel.com/

Hi Kanchana,
Thanks for sharing. I understand you=E2=80=99ll need this mTHP swap-in seri=
es
to leverage your
IAA for parallel decompression, right? Without mTHP swap-in, you won't
get this 7X
improvement, right?

This is another important use case for the mTHP swap-in series,
highlighting the strong
need to start the work from the sync IO device.

I=E2=80=99ll try to find some time to review your patch and explore how we =
can
better support both
software and hardware improvements in zsmalloc/zram with a more
compatible approach.
Also, I have a talk[1] at LPC2024=E2=80=94would you mind if I include a
description of your use
case?

[1] https://lpc.events/event/18/contributions/1780/

>
> Thanks,
> Kanchana

Thanks
Barry

