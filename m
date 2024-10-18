Return-Path: <linux-kernel+bounces-371204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357469A37E2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF8A2851B7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0950218C34C;
	Fri, 18 Oct 2024 07:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BK63DK2h"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079CC18C335
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729238324; cv=none; b=qCi6Mz6B7+MUOAqgCwkwpZCRDldtMUMl0Un3IfU4/lkZLtRKkLFUjkTdXklWdkglo83Sh2KNiKKClTrXlORfLNF+BqtR0BHsf18jLUEzCBf2wLXhbFT7rGlXjbIPJlzQl0Lp84N/mciVRqTUttFUPJPGvXNHqEDZFrtbisot5cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729238324; c=relaxed/simple;
	bh=s+HlrfHqP69nqmDhgJNxMWvtR8m57Il9I98x50Qn7Cg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N+fLKCIqkgoIhrYqJ539gfgJr2O759/QqLEpZRKCJSQ4wr5mqBfz3GqNvzYIMwILw+vyKdWEItYQci7SuJ0+2OHCbW9ky/C5uSToRD8GZYD542NVMC7c+bZ7PwIYWOxVKiuX8juIVdd5GKdnqf/+mXyWkAECwFQUaMXYQ8SzQ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BK63DK2h; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729238323; x=1760774323;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=s+HlrfHqP69nqmDhgJNxMWvtR8m57Il9I98x50Qn7Cg=;
  b=BK63DK2hRfwzPwcl6Q6uxcy+5qgzr4Eq6m2821tTbH/RBnZQOPLuDDaR
   AMdcGvALoqwxetQUb2bC1AD/BHfuMUmGlq3tV8BQ/ZgLdEpaFvLqRPeFF
   exTNEMQaXsmbY1tem4UeFrbNy+cvigCZY3rXwb5YHfBh9PaeC9s0GkXuU
   iO59UYeu7qBk2OQ///inQyrsAspX4htfqSE5A9eZi0ye7iwGQPKczcQtI
   pzxB9p38eaOweK+KWDF1AQ4BCcTHEn4L7T+Ns+1HmNOKeADHYeQF2zd+H
   m9ucHwrBW/o0zgJ0kMVyijpIhcVhHs/g9/G2HPtz/MlZmvJRNiyGrmHyM
   g==;
X-CSE-ConnectionGUID: NmNNZk+gQbGBzmCzlz6SLw==
X-CSE-MsgGUID: l3+HYY8HTtS/ZDufw6Cnmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="46257545"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="46257545"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 00:58:42 -0700
X-CSE-ConnectionGUID: kBNgLfcKTdKJVQbYBLmJpQ==
X-CSE-MsgGUID: 7HOiqOcVQpaecsJmkvw2Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="116254824"
Received: from klitkey1-mobl1.ger.corp.intel.com ([10.245.246.169])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 00:58:40 -0700
Message-ID: <316b41e631572a02a89bab2456cfb373f3e667ae.camel@linux.intel.com>
Subject: Re: [PATCH 1/1] nvme-pci: Add CPU latency pm-qos handling
From: Tero Kristo <tero.kristo@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, axboe@kernel.dk, 
	linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org
Date: Fri, 18 Oct 2024 10:58:36 +0300
In-Reply-To: <20241015132928.GA3961@lst.de>
References: <20241004101014.3716006-1-tero.kristo@linux.intel.com>
	 <20241004101014.3716006-2-tero.kristo@linux.intel.com>
	 <20241007061926.GA800@lst.de>
	 <913b063d0638614bc95d92969879d2096ffc0722.camel@linux.intel.com>
	 <20241009080052.GA16711@lst.de>
	 <accb9ceb501197b71259d8d3996c461dcef1e7d6.camel@linux.intel.com>
	 <0feb16b0bc3515b0a77f33a3e18568f62236b691.camel@linux.intel.com>
	 <20241015132928.GA3961@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-15 at 15:29 +0200, Christoph Hellwig wrote:
> On Tue, Oct 15, 2024 at 12:25:37PM +0300, Tero Kristo wrote:
> > I've been giving this some thought offline, but can't really think
> > of
> > how this could be done in the generic layers; the code needs to
> > figure
> > out the interrupt that gets fired by the activity, to prevent the
> > CPU
> > that is going to handle that interrupt to go into deep idle,
> > potentially ruining the latency and throughput of the request. The
> > knowledge of this interrupt mapping only resides in the driver
> > level,
> > in this case NVMe.
> >=20
> > One thing that could be done is to prevent the whole feature to be
> > used
> > on setups where the number of cpus per irq is above some threshold;
> > lets say 4 as an example.
>=20
> As a disclaimer I don't really understand the PM QOS framework, just
> the NVMe driver and block layer.
>=20
> With that my gut feeling is that all this latency management should
> be driven by the blk_mq_hctx structure, the block layer equivalent
> to a queue.=C2=A0 And instead of having a per-cpu array of QOS requests
> per device, there should one per cpu in the actual mask of the
> hctx, so that you only have to iterate this local shared data
> structure.
>=20
> Preferably there would be one single active check per hctx and
> not one per cpu, e.g. when the block layer submits commands
> it has to do one single check instead of an iteration.=C2=A0 Similarly
> the block layer code would time out the activity once per hctx,
> and only then iterate the (usually few) CPUs per hctx.
>=20

Thanks for the feedback, I have now reworked + retested my patches
against blk-mq, just posted them to the block mailing list also.

-Tero

