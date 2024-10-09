Return-Path: <linux-kernel+bounces-356515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700F499625A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8858B1C219E7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE8C183CA7;
	Wed,  9 Oct 2024 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nt4mRQlY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1AC185923
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462295; cv=none; b=Id+Th4WRR5SCdlnVB7bWfvzb9Bcfvz5KvjfLcvrd3x2S7wh8MREut3D4j4LsYjRr/Vm//LBfYrbZJjmBjqi8+Hu21pEbjrhJXWHuLjgxeksv+YCdheXMx9gdg6AqrnXYRK7NRdYFt4suOMLaXxxoUYK6oa7DGxhTqDX0oc4PPkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462295; c=relaxed/simple;
	bh=AMqeygrDRnZkLZfYdb04EQ9i5yeRMyIrwByGC8Glue8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XPK9S4l/jLFYjnV/O579s4wKoNXHnrKLfcdRTBv5LsUFQXmwOuG1ybnJs5m/JqL5y2V3xcVp3Qp+570898+Dfi6Y5Wzz3s8UCoH79WjPcaEiWahukyq17XXDmYwUfjQ0lHE006hK6SoB49+LO9DmBskY2Der5I814O1jrSm/VM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nt4mRQlY; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728462294; x=1759998294;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=AMqeygrDRnZkLZfYdb04EQ9i5yeRMyIrwByGC8Glue8=;
  b=Nt4mRQlY6uFmpmsbJTkNSaGsPo0kC+O5tmGBBZwedjmpcfdATxyrwY9o
   uB2mWn0z+0Fsl+V99BRAnS6ibYMvsZwxeodPVrkHM5b2yrCqFWLpphalZ
   1VHBq8P0RWMCWnNIz08G5QFcG+4OFhPHQCkPhtmUuPfUBmxCpepeDJUFh
   rSwXOs1PuiO8lz28b1gxc/P4aoVUGjERTU/3T4p+H6ohuS4e7yjHv1Oke
   ty0JEPo3oLLm4YGaebVfA4T1uc/4CEBXUohAS/RyRA3F4zoZHpMdsEv8H
   WmQfuuQykF9zYyPKQYhI4HxSgynpbn4dnC6BrNdmOZAJdmlZHUQtv04Ss
   w==;
X-CSE-ConnectionGUID: nGPd87aaSi6aslYvXJYPvg==
X-CSE-MsgGUID: Zy79GCrtSIWMgbe6/KrCMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="38334120"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="38334120"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 01:24:50 -0700
X-CSE-ConnectionGUID: LfoKvX/CRRGMoOyFu8Vr6w==
X-CSE-MsgGUID: Mfs71pT1T/6Al5E1oGikIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="106932801"
Received: from mklonows-mobl1.ger.corp.intel.com ([10.245.246.66])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 01:24:49 -0700
Message-ID: <accb9ceb501197b71259d8d3996c461dcef1e7d6.camel@linux.intel.com>
Subject: Re: [PATCH 1/1] nvme-pci: Add CPU latency pm-qos handling
From: Tero Kristo <tero.kristo@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, axboe@kernel.dk, 
	linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org
Date: Wed, 09 Oct 2024 11:24:45 +0300
In-Reply-To: <20241009080052.GA16711@lst.de>
References: <20241004101014.3716006-1-tero.kristo@linux.intel.com>
	 <20241004101014.3716006-2-tero.kristo@linux.intel.com>
	 <20241007061926.GA800@lst.de>
	 <913b063d0638614bc95d92969879d2096ffc0722.camel@linux.intel.com>
	 <20241009080052.GA16711@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 10:00 +0200, Christoph Hellwig wrote:
> On Wed, Oct 09, 2024 at 09:45:07AM +0300, Tero Kristo wrote:
> > Initially, I posted the patch against block layer, but there the
> > recommendation was to move this closer to the HW; i.e. NVMe driver
> > level.
>=20
> Even if it is called from NVMe, at lot of the code is not nvme
> specific.
> Some of it appears block specific and other pats are entirely
> generic.
>=20
> But I still don't see how walking cpumasks and updating paramters in
> far away (in terms of cache lines and pointer dereferences) for every
> single I/O could work without having a huge performance impact.
>=20

Generally, the cpumask only has a couple of CPUs on it; yes its true on
certain setups every CPU of the system may end up on it, but then the
user has the option to not enable this feature at all. In my testing
system, there is a separate NVME irq for each CPU, so the affinity mask
only contains one bit.

Also, the code tries to avoid calling the heavy PM QoS stuff, by
checking if the request is already active, and updating the values in a
workqueue later on. Generally the heavy-ish parameter update only
happens on the first activity of a burst of NVMe accesses.

-Tero


