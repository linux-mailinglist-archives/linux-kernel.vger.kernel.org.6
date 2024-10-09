Return-Path: <linux-kernel+bounces-356363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F19996004
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA2DCB2140E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAB0176AB5;
	Wed,  9 Oct 2024 06:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ReFiXJ0+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F74160884
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728456325; cv=none; b=J3Qr6KJubJdq/u0iAVwn/KTDzLTGQeGrJkp7yoIHxObo6YKMEfRka3d1GIG2UMF2swl1ljfRetvzWM4KueA4A9gM2CXmsz3SxORVJzLV9OKMoY/FDE1iSnq/r54d/uBt0+PDorJuMoTCmK63HSTUUR/dD3/OC2VXV0pfhqX4KQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728456325; c=relaxed/simple;
	bh=T2hK6xz3/99sC4O5f2cRdeWIxz3Ssjx5U9gl5pXCsLE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qOLlfcpfocZ/Qt1XBidiji+gN/Mev9LCp7EBhWdj/ysUR3l0m5MZ874ontlwdIqABZTAsA7NQPxm4K7ajfrDHe/17pYzV5D5xd/Rp9d9gI0JAKJhcDvwnNSWaSKLxYcsL1EGdbMiZUblb0FFw0qinQyXN5kleV3PxD+f09IMsL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ReFiXJ0+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728456324; x=1759992324;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=T2hK6xz3/99sC4O5f2cRdeWIxz3Ssjx5U9gl5pXCsLE=;
  b=ReFiXJ0+3npmfBaIXar9irtIb5SzXeBJjI/rr2n/UTD9a2LatwG2RxiD
   RaL8YHkVLkgp1W4jtT62mWKk4+e/va9djWv97Hnfu5hpgGdv90NyOaVT0
   WWy7xriS5XTGzzxCOu6SIn2/NrE2HPjUZC2pqJ1IJJAhufm2PeIB37eaB
   Zm8SxcLzN3aMruDu4Obub6WGNgwf1ku7oVQCC6PYvpDnZsg1Y9tUwGsvm
   E1DOEqDAknnTgdu4yeKFpEmqcZHFKEdWhbImFiOXGqevl6mB832kg+UW/
   UvLH12Z0xnrLrQIPtDOdwSrnYuWj658DEOlvi0eGWVj7Kv9XOc4KioHGJ
   A==;
X-CSE-ConnectionGUID: daiyZs1iQ8aiqyVinhv7IA==
X-CSE-MsgGUID: 9yfsjf/NRpCyG1Wm18cl0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="31625188"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="31625188"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 23:45:24 -0700
X-CSE-ConnectionGUID: cGV4m5zaRRKdUBFJT9eqFw==
X-CSE-MsgGUID: Wd0qNWyxTCSP9p+l5eHUBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76106536"
Received: from mklonows-mobl1.ger.corp.intel.com ([10.245.246.66])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 23:45:21 -0700
Message-ID: <913b063d0638614bc95d92969879d2096ffc0722.camel@linux.intel.com>
Subject: Re: [PATCH 1/1] nvme-pci: Add CPU latency pm-qos handling
From: Tero Kristo <tero.kristo@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, axboe@kernel.dk, 
	linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org
Date: Wed, 09 Oct 2024 09:45:07 +0300
In-Reply-To: <20241007061926.GA800@lst.de>
References: <20241004101014.3716006-1-tero.kristo@linux.intel.com>
	 <20241004101014.3716006-2-tero.kristo@linux.intel.com>
	 <20241007061926.GA800@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-07 at 08:19 +0200, Christoph Hellwig wrote:
> > @@ -483,6 +498,27 @@ static inline void nvme_write_sq_db(struct
> > nvme_queue *nvmeq, bool write_sq)
> > =C2=A0			nvmeq->dbbuf_sq_db, nvmeq->dbbuf_sq_ei))
> > =C2=A0		writel(nvmeq->sq_tail, nvmeq->q_db);
> > =C2=A0	nvmeq->last_sq_tail =3D nvmeq->sq_tail;
> > +
> > +	/* Kick CPU latency while updating queue. */
> > +	dev =3D nvmeq->dev;
> > +	if (!dev || dev->cpu_latency < 0)
> > +		return;
> > +
> > +	for_each_cpu(cpu, nvmeq->irq_aff_mask) {
>=20
> Doing something as complex as this for every doorbell write is not
> going to fly.
>=20
> Even if it was I see nothing nvme-specific in the interface.
>=20
> So please figure out a way to make things cheap in the I/O path
> and move code to the right layers.

Initially, I posted the patch against block layer, but there the
recommendation was to move this closer to the HW; i.e. NVMe driver
level.

See:
https://patchwork.kernel.org/project/linux-block/patch/20240829075423.13450=
42-2-tero.kristo@linux.intel.com/

Any tips where this piece of code should actually be moved would be
appreciated.

-Tero

>=20
> Also please avoid all these overly long lines.


