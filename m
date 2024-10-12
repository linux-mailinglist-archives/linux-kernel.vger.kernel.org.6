Return-Path: <linux-kernel+bounces-362145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D287E99B18B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DDDD28465F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B9413D600;
	Sat, 12 Oct 2024 07:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l3Ec77uC"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB9112CDA5
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 07:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728717997; cv=none; b=tURm40ZWSESxL39PHsR+Aujo1Q90lkZasnm9CZrfry0EoLe69A4VHZL3o/BNFEMYV9xq31i/fdAq2s3KFNFBm8APRc9SjMHqOpQrUjrX9c7Ljbhibd3i6/xEwDIjv4FwdPpIa+G4AFIHNdHYcLpVE57NFILcLXed6UQbC13/WMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728717997; c=relaxed/simple;
	bh=dMsfE2+72VYWv+Jm5OlaIn5eJZSfiHILiC5fvPxCf9s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=h8oT4ilHYphVCLa5dDPOKeA660W6YiVVPwCNTIp/WxWtZVHrquY+9dwrzjGLsWHzXe9+nSwNBgNC5//g2DaPsmTTY5CL5m5lNHpI4/CJa7NSXpSOctWvAqZcWJ6uNcwYvSSmtQNDPWpl/9MSfKEohHpRbdVsfYkmzIeQNuA2iLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l3Ec77uC; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728717992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPalrDuwgdYFtGhiPoGzD2Ul6Wt70F6b8JTQk1h1z+k=;
	b=l3Ec77uCGgZ3cWIBJLiyEPSUoJ981x4QWnHFv/KfeEkbc8JA4eccovVA1Q0FHRvflp7O3l
	7hvv6h6+dA0vuT0HSn5tsLD9vknvDW/nJA1WYK43b1xg0+3y+2NRaWnjlo/KGHj6zEtLXD
	3Ju/on3xBmtPHVOk7UMdyjdMqRAZqeo=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH] mm/hugetlb: Perform vmemmap optimization batchly for
 specific node allocation
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20241012070802.1876-1-suhua1@kingsoft.com>
Date: Sat, 12 Oct 2024 15:25:32 +0800
Cc: akpm@linux-foundation.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 suhua <suhua1@kingsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <40AEB361-B637-4EE4-B3FD-48B214C1A5AE@linux.dev>
References: <20241012070802.1876-1-suhua1@kingsoft.com>
To: suhua <suhua.tanke@gmail.com>
X-Migadu-Flow: FLOW_OUT



> On Oct 12, 2024, at 15:08, suhua <suhua.tanke@gmail.com> wrote:
>=20
> When HVO is enabled and huge page memory allocs are made, the freed =
memory
> can be aggregated into higher order memory in the following paths, =
which
> facilitates further allocs for higher order memory.
>=20
> echo 200000 > /proc/sys/vm/nr_hugepages
> echo 200000 > =
/sys/devices/system/node/node*/hugepages/hugepages-2048kB/nr_hugepages
> grub=EF=BC=9A default_hugepagesz=3D2M hugepagesz=3D2M hugepages=3D200000=

>=20
> Currently not support for releasing aggregations to higher order in =
the
> following way, which will releasing to lower order.
>=20
> grub: default_hugepagesz=3D2M hugepagesz=3D2M =
hugepages=3D0:100000,1:100000
>=20
> This patch supports the release of huge page optimizations aggregates =
to
> higher order memory.
>=20
> eg:
> cat /proc/cmdline
> BOOT_IMAGE=3D/boot/vmlinuz-xxx ... default_hugepagesz=3D2M =
hugepagesz=3D2M hugepages=3D0:100000,1:100000
>=20
> Before:
> Free pages count per migrate type at order       0      1      2      =
3      4      5      6      7      8      9     10
> ...
> Node    0, zone   Normal, type    Unmovable  55282  97039  99307      =
0      1      1      0      1      1      1      0
> Node    0, zone   Normal, type      Movable     25     11    345     =
87     48     21      2     20      9      3  75061
> Node    0, zone   Normal, type  Reclaimable      4      2      2      =
4      3      0      2      1      1      1      0
> Node    0, zone   Normal, type   HighAtomic      0      0      0      =
0      0      0      0      0      0      0      0
> ...
> Free pages count per migrate type at order       0      1      2      =
3      4      5      6      7      8      9     10
> Node    1, zone   Normal, type    Unmovable  98888  99650  99679      =
2      3      1      2      2      2      0      0
> Node    1, zone   Normal, type      Movable      1      1      0      =
1      1      0      1      0      1      1  75937
> Node    1, zone   Normal, type  Reclaimable      0      0      0      =
0      0      0      0      0      0      0      0
> Node    1, zone   Normal, type   HighAtomic      0      0      0      =
0      0      0      0      0      0      0      0
>=20
> After:
> Free pages count per migrate type at order       0      1      2      =
3      4      5      6      7      8      9     10
> ...
> Node    0, zone   Normal, type    Unmovable    152    158     37      =
2      2      0      3      4      2      6    717
> Node    0, zone   Normal, type      Movable      1     37     53      =
3     55     49     16      6      2      1  75000
> Node    0, zone   Normal, type  Reclaimable      1      4      3      =
1      2      1      1      1      1      1      0
> Node    0, zone   Normal, type   HighAtomic      0      0      0      =
0      0      0      0      0      0      0      0
> ...
> Free pages count per migrate type at order       0      1      2      =
3      4      5      6      7      8      9     10
> Node    1, zone   Normal, type    Unmovable      5      3      2      =
1      3      4      2      2      2      0    779
> Node    1, zone   Normal, type      Movable      1      0      1      =
1      1      0      1      0      1      1  75849
> Node    1, zone   Normal, type  Reclaimable      0      0      0      =
0      0      0      0      0      0      0      0
> Node    1, zone   Normal, type   HighAtomic      0      0      0      =
0      0      0      0      0      0      0      0
>=20
> Signed-off-by: suhua <suhua1@kingsoft.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


