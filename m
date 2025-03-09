Return-Path: <linux-kernel+bounces-552868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF55A58035
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 02:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0D41891C39
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 01:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA928C2EF;
	Sun,  9 Mar 2025 01:06:41 +0000 (UTC)
Received: from smtp134-31.sina.com.cn (smtp134-31.sina.com.cn [180.149.134.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629404C91
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 01:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741482401; cv=none; b=j3VKSimbAPjFKt8DxxABO7/TP2uYtoBgkOG8xJBM5A4YY4T44I/SmHYnpEYR7Dad1y9wPfpQ4iaOc1qJOqhvf46PJh7hgSlrhsQ+dVShJ83jpwRktdjllZoE09RDrmJcYx31behjW9BpXo7JpdbUReuJqOn++nASBO5+f3RLQQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741482401; c=relaxed/simple;
	bh=S+Nv7k3/mmFrzGHckeo8cjudm8lR4wwrLCYBcP/dAL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/EmdZHgRnqtGmjC14t9OEiu3IrEluq/1ds2/D4Sx/eeJxAGfjAgsLxGrtl1PLkNIq0LLm9qL2TdYMY/zwIj/4VYbd5AnNQbAPNTqhqdOX3AHKaFvS/Si+sTaiyYm1oPmkT2x7JY2rwDC4F/dlyO01+XS77e8pXkNd84HJJEmHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.65.203])
	by sina.com (10.185.250.21) with ESMTP
	id 67CCE96D00004BB8; Sun, 9 Mar 2025 09:05:52 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9464423408360
X-SMAIL-UIID: C1B2F9E6C3134DE499268E94EB7A02E5-20250309-090552-1
From: Hillf Danton <hdanton@sina.com>
To: Nhat Pham <nphamcs@gmail.com>,
	Barry Song <21cnbao@gmail.com>
Cc: Qun-Wei Lin <qun-wei.lin@mediatek.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/2] kcompressd: Add Kcompressd for accelerated zram compression
Date: Sun,  9 Mar 2025 09:05:22 +0800
Message-ID: <20250309010541.3152-1-hdanton@sina.com>
In-Reply-To: <CAKEwX=OP9PJ9YeUvy3ZMQPByH7ELHLDfeLuuYKvPy3aCQCAJwQ@mail.gmail.com>
References: <20250307120141.1566673-1-qun-wei.lin@mediatek.com> <20250307120141.1566673-3-qun-wei.lin@mediatek.com> <CAGsJ_4xtp9iGPQinu5DOi3R2B47X9o=wS94GdhdY-0JUATf5hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 7 Mar 2025 15:13:12 -0800 Nhat Pham <nphamcs@gmail.com>
> On Fri, Mar 7, 2025 at 11:41 AM Barry Song <21cnbao@gmail.com> wrote:
> > On Sat, Mar 8, 2025 at 1:02 AM Qun-Wei Lin <qun-wei.lin@mediatek.com> wrote:
> > >
> > > Introduced Kcompressd to offload zram page compression, improving
> > > system efficiency by handling compression separately from memory
> > > reclaiming. Added necessary configurations and dependencies.
> > >
> > > Signed-off-by: Qun-Wei Lin <qun-wei.lin@mediatek.com>
> > > ---
> > >  drivers/block/zram/Kconfig      |  11 ++
> > >  drivers/block/zram/Makefile     |   3 +-
> > >  drivers/block/zram/kcompressd.c | 340 ++++++++++++++++++++++++++++++++
> > >  drivers/block/zram/kcompressd.h |  25 +++
> > >  drivers/block/zram/zram_drv.c   |  22 ++-
> > >  5 files changed, 397 insertions(+), 4 deletions(-)
> > >  create mode 100644 drivers/block/zram/kcompressd.c
> > >  create mode 100644 drivers/block/zram/kcompressd.h
> > >
> > > diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
> > > index 402b7b175863..f0a1b574f770 100644
> > > --- a/drivers/block/zram/Kconfig
> > > +++ b/drivers/block/zram/Kconfig
> > > @@ -145,3 +145,14 @@ config ZRAM_MULTI_COMP
> > >           re-compress pages using a potentially slower but more effective
> > >           compression algorithm. Note, that IDLE page recompression
> > >           requires ZRAM_TRACK_ENTRY_ACTIME.
> > > +
> > > +config KCOMPRESSD
> > > +       tristate "Kcompressd: Accelerated zram compression"
> > > +       depends on ZRAM
> > > +       help
> > > +         Kcompressd creates multiple daemons to accelerate the compression of pages
> > > +         in zram, offloading this time-consuming task from the zram driver.
> > > +
> > > +         This approach improves system efficiency by handling page compression separately,
> > > +         which was originally done by kswapd or direct reclaim.
> >
> > For direct reclaim, we were previously able to compress using multiple CPUs
> > with multi-threading.
> > After your patch, it seems that only a single thread/CPU is used for compression
> > so it won't necessarily improve direct reclaim performance?
> >
> > Even for kswapd, we used to have multiple threads like [kswapd0], [kswapd1],
> > and [kswapd2] for different nodes. Now, are we also limited to just one thread?
> > I also wonder if this could be handled at the vmscan level instead of the zram
> > level. then it might potentially help other sync devices or even zswap later.
> 
> Agree. A shared solution would be much appreciated. We can keep the
> kcompressd idea, but have it accept IO work from multiple sources
> (zram, zswap, whatever) through a shared API.
> 
> Otherwise we would need to reinvent the wheel multiple times :)
>
Could you explain what nr_kcompressd means, Qun-Wei, to quiesce barking lads?

