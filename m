Return-Path: <linux-kernel+bounces-365468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E2E99E2C2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33AB7B24A50
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DF81DACA6;
	Tue, 15 Oct 2024 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ro7U3eON"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224901BE854
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728984345; cv=none; b=EKLTWddOWvYu7aEp/CqsHI41I3feyHzPewpztDagKtbSvxWPXb5qaiuBXkLBOh3IQf2pJKcNHgopgOiSWwQ2T8+Ap40RiTafcP0mfoQN0lfRQl2LvBRlrjBTd7CZ73v/FGWYCRzE8fT6vpacA43t9LTaEFPhwasgbQabX0pyzxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728984345; c=relaxed/simple;
	bh=LBwRXkAIdv1AimxyczECxXGj9by0IZ10c25ZcV9tBtE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HM5tQhkvQ5WHHbrkAklMBxNIvzoEhi5djgwN2CtJNUvgvY8sOwWN5Lp0hIIrT4kVBFoOkvtkRVlInaNFnsiyHOyRhKHqyMzBJPYHzlTnq+qWFeZ19B4ghVpg/7tQpC5CrwpH7zz9e17DZU4ZeYJRWS4Ke8OX5vW1pz1lG9YZjXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ro7U3eON; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728984343; x=1760520343;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=LBwRXkAIdv1AimxyczECxXGj9by0IZ10c25ZcV9tBtE=;
  b=Ro7U3eONFOgU2/9zUuqlpmQWT8LrIW961JjSmwyDDeIfvaGt2DSzb1Km
   idOBdrWDOqtbcNqGJI40oX3sOUqtf93KUOxRqPFx3R7a+05p4diYr1Uv9
   L/uZEf98FO3znxPuavRt/2joSFbRDkvczfwRiisG+q+g111Zpwwr60mY2
   Eha9q7nUsJ/tQX0AHrf/TThOSKpwSRr9OcTf+3vfNwe+/n8Qc6yOGmSSI
   J5j/f/LFfdf8Qb5oTMmcdIHRIUtpBjgj2Q+PRKgBwRzJSGkHtEpCfuKbq
   3c4E+hciZTPacTakYkF9XjL8W8h0n+/XItN0lRjhIB5QtiWy80JT24eJG
   w==;
X-CSE-ConnectionGUID: qAPUyyeoSd+Ibm03N6fgVg==
X-CSE-MsgGUID: aiEHH07FStOWPh0s5vGkkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="38997772"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="38997772"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 02:25:42 -0700
X-CSE-ConnectionGUID: 9X81IRDMTxOE0jJ7zKZwJw==
X-CSE-MsgGUID: qHE+LER4R2m09qKI09dR3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="77850866"
Received: from lfiedoro-mobl.ger.corp.intel.com ([10.245.246.32])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 02:25:40 -0700
Message-ID: <0feb16b0bc3515b0a77f33a3e18568f62236b691.camel@linux.intel.com>
Subject: Re: [PATCH 1/1] nvme-pci: Add CPU latency pm-qos handling
From: Tero Kristo <tero.kristo@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, axboe@kernel.dk, 
	linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org
Date: Tue, 15 Oct 2024 12:25:37 +0300
In-Reply-To: <accb9ceb501197b71259d8d3996c461dcef1e7d6.camel@linux.intel.com>
References: <20241004101014.3716006-1-tero.kristo@linux.intel.com>
	 <20241004101014.3716006-2-tero.kristo@linux.intel.com>
	 <20241007061926.GA800@lst.de>
	 <913b063d0638614bc95d92969879d2096ffc0722.camel@linux.intel.com>
	 <20241009080052.GA16711@lst.de>
	 <accb9ceb501197b71259d8d3996c461dcef1e7d6.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 11:24 +0300, Tero Kristo wrote:
> On Wed, 2024-10-09 at 10:00 +0200, Christoph Hellwig wrote:
> > On Wed, Oct 09, 2024 at 09:45:07AM +0300, Tero Kristo wrote:
> > > Initially, I posted the patch against block layer, but there the
> > > recommendation was to move this closer to the HW; i.e. NVMe
> > > driver
> > > level.
> >=20
> > Even if it is called from NVMe, at lot of the code is not nvme
> > specific.
> > Some of it appears block specific and other pats are entirely
> > generic.
> >=20
> > But I still don't see how walking cpumasks and updating paramters
> > in
> > far away (in terms of cache lines and pointer dereferences) for
> > every
> > single I/O could work without having a huge performance impact.
> >=20
>=20
> Generally, the cpumask only has a couple of CPUs on it; yes its true
> on
> certain setups every CPU of the system may end up on it, but then the
> user has the option to not enable this feature at all. In my testing
> system, there is a separate NVME irq for each CPU, so the affinity
> mask
> only contains one bit.
>=20
> Also, the code tries to avoid calling the heavy PM QoS stuff, by
> checking if the request is already active, and updating the values in
> a
> workqueue later on. Generally the heavy-ish parameter update only
> happens on the first activity of a burst of NVMe accesses.

I've been giving this some thought offline, but can't really think of
how this could be done in the generic layers; the code needs to figure
out the interrupt that gets fired by the activity, to prevent the CPU
that is going to handle that interrupt to go into deep idle,
potentially ruining the latency and throughput of the request. The
knowledge of this interrupt mapping only resides in the driver level,
in this case NVMe.

One thing that could be done is to prevent the whole feature to be used
on setups where the number of cpus per irq is above some threshold;
lets say 4 as an example.

-Tero

