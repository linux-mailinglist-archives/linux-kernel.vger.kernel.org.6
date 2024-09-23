Return-Path: <linux-kernel+bounces-334712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1351797DAF4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 02:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45017B2175F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 00:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C263201;
	Sat, 21 Sep 2024 00:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5+LehS5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2359329A1
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 00:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726877103; cv=none; b=f4+W6tVztcsT1Y5hO40jJmeWjBnM9boESffozRWM5K5PQEUYk9WYHaxFf5F7ngScEHlQFzvqUY/y7A0zjhDN0KyIBuDepoiHaUvd8vk3btA+TtAyKEHRIyRJMR7kHLGQk4exOsP8iSSKTbmveKVWhbT8BaIWlXMq0pZ0q2hROm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726877103; c=relaxed/simple;
	bh=INlKS5tNGyAIUwftuVV4YHTl+jDewLLG5i9G1VOSdhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKh2JXYMDFBib9oVlAwgZJiiPOXzh+GdeKonPDkoMnEjqwcewLivSdF1J87Ks05WDI5IRGoAg8tqStIpcmuz++qF2Im2nFODSSQdVUel4dlYkfPtMgEcbWUaA0+Fv2+bQBLiGbtYJ2AJCPeO+/luw2LJfx0diDVpMtXy0dEkXXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5+LehS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6F3C4CED0
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 00:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726877102;
	bh=INlKS5tNGyAIUwftuVV4YHTl+jDewLLG5i9G1VOSdhM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u5+LehS58NQuczqxX0Rx8/hXqC32CxQTiOKtwz84OVGuwoZtTdrP/4+BeI3xuTtN6
	 z/OOcgiiXo8X/PQ0cyuFBsASo82ztW65Nr5xbC28JeldGKsyiaNvgsFVlxZnuhxuhr
	 SG5zlrs00CWe9FpQ+zjew4WTCAUrMOjUz1WcKxzSQ7ioPjy02wNQymiWwXDmKBqNkA
	 YdJqhMCzHaubASX6Hi1qCKrKyGVos9spL+Xk3LN2wl+He3ovOmtvTB95OBF4y9jTio
	 EjA9WuYfBhZvFxQrchJ62kYgPaPLN05ZY5/pCoA6czn3XdRouyaYIuC4YTTthdyg4w
	 iC3iThbr0J8vA==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6db836c6bd7so25580647b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 17:05:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVyIRLZEdYveL9GUk7REXxmPMLT7lNNXZSDqaqZCgdHeGl2GYpJ6qkIxOrlT+6gHfw99PMaeI5XwD3NlxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsleRL+oYGSlfd6EUGz3RlaFfzlEcZcKD0GzHhpweR1lVe569S
	DKy3EU76Yqk+CL5WT11452eiNtsMkwtUNypnt1l+zuD+rZCk5OaucG+NhPbVwscVNE/jtFGSh46
	WKksJKgVPQFGlWHib/dpeWOfiz+82ZzR/KNMNDA==
X-Google-Smtp-Source: AGHT+IFTgD18lT/k5y3/uFsZmumRkstI4L4Woj+Ow1MTZJ00Q7iFIujz/YsqJe0xXL7E4JJ1Hut1lEDJr9Sp5F5cVxQ=
X-Received: by 2002:a05:690c:6506:b0:6dd:bc2b:2aa4 with SMTP id
 00721157ae682-6dfeeff826dmr53781547b3.39.1726877101859; Fri, 20 Sep 2024
 17:05:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919112952.981-1-qun-wei.lin@mediatek.com> <ZuwM-aEEo7DE-qXw@infradead.org>
In-Reply-To: <ZuwM-aEEo7DE-qXw@infradead.org>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 20 Sep 2024 17:04:51 -0700
X-Gmail-Original-Message-ID: <CACePvbUCNxy3sf6+7hk9HPGTNtTMbA2=Entu0xbV7TbwX4M2WQ@mail.gmail.com>
Message-ID: <CACePvbUCNxy3sf6+7hk9HPGTNtTMbA2=Entu0xbV7TbwX4M2WQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add BLK_FEAT_READ_SYNCHRONOUS and SWP_READ_SYNCHRONOUS_IO
To: Christoph Hellwig <hch@infradead.org>
Cc: Qun-Wei Lin <qun-wei.lin@mediatek.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	David Hildenbrand <david@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Dan Schatzberg <schatzberg.dan@gmail.com>, 
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-block@vger.kernel.org, Casper Li <casper.li@mediatek.com>, 
	Chinwen Chang <chinwen.chang@mediatek.com>, Andrew Yang <andrew.yang@mediatek.com>, 
	John Hsu <john.hsu@mediatek.com>, wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Qun-Wei,

Agree with Christoph that BLK_FEAT_READ_SYNCHRONOUS is not set
anywhere. That needs to be fixed.

Having a flag for BLK_FEAT_READ_SYNCHRONOUS and another flag for
BLK_FEAT_SYNCHRONOUS is just confusing.
for example, read path need to test two bits: "sis->flags &
(SWP_SYNCHRONOUS_IO | SWP_READ_SYNCHRONOUS_IO)"

There is only one caller of the bdev_synchronous(), which is in swapfile.c.

I suggest if you have  BLK_FEAT_READ_SYNCHRONOUS, you should have a
BLK_FEAT_WRITE_SYNCHRONOUS for writing.
The previous path that test the SWP_SYNCHRONOUS_IO should convert into
one of tests of SWP_READ_SYNCHRONOUS_IO or  SWP_WRITE_SYNCHRONOUS_IO
depend on the read or write path (never both).

"sis->flags & (SWP_SYNCHRONOUS_IO | SWP_READ_SYNCHRONOUS_IO)" will
change into "sis->flags & SWP_READ_SYNCHRONOUS_IO"

Then you can have  bdev_synchronous() just return the
SWP_READ_SYNCHRONOUS_IO | SWP_WRITE_SYNCHRONOUS_IO if both are set.
You don't need to have just bdev_synchronous() and
bdev_read_synchronous(). That is more boilerplate code which is
unnecessary.

I also suggest you squish your two patches into one because there is
no user of bdev_read_synchronous() in the first patch.
You should introduce the function with the code that uses it. Yes,
yes, I know you want to have a seperate patch for define vs another
patch for using it. In this case there is no good reason for that.

Best regards,

Chris


On Thu, Sep 19, 2024 at 4:37=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> Well, you're not actually setting your new flags anywhere, which -
> as you might know - is an reson for an insta-NAK.
>

