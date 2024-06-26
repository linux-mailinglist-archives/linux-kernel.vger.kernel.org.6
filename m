Return-Path: <linux-kernel+bounces-230184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0651917986
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D4C51C23350
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEDC159598;
	Wed, 26 Jun 2024 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="G9EeXrw+"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D991158D74
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719386471; cv=none; b=P6DE+JtwW5kHn63wiyy7GeAQzHSQwejz3PKFpJ70WYPv7bxCWHX7FWzBV8T/Pn3ncq1jxS923NSwYA9mLWU3v/S5ecIHomXlD2o1OhTEmbE8HDj6ppZ5MAkGFpbK7Vl2SfkLG/DhXmx2pgcGoZ03S5+ihLYPNSA4p6sQ3jvNlYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719386471; c=relaxed/simple;
	bh=nASAPLVT8PjYiJQ9E2FDrsk9NF+lkKBEHcRsZ47YKYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ke/sMv7e6wXRiSHXsGh8TZEK0g1GZvzVLpVLJ8yhHSHfxQ0iRvUmaFRB4ww++pL8MSGGK+7RA1wa4BW/jFPCdwHVysL25FjcrNX24qN4q/k7I2aI6ScWzc09pudveOgAs5dNS3HCMT9T/D1CfTR4OK/LwT/9FRVQaDaeXd7SQ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=G9EeXrw+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from thinkpad-p16sg1.. (S010600cb7a0d6c8b.vs.shawcable.net [96.55.224.203])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3DE0D20B7009;
	Wed, 26 Jun 2024 00:21:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3DE0D20B7009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1719386462;
	bh=moCiPaIn6NwSfydLRZyrKy3vd1OTZl2jw6RofluiaGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G9EeXrw+/0mJx1pij6BPmT+TnZdwksClZtLPrzVUXgEKvyh9KLmAN+bY+kJ5kgNom
	 MFyu/2j/wa+nzn9EqTks0cn7GZH27tnPkawPFxkWRlLsV9rPpRfOLVMYG4x0WX87hS
	 dE97G7JmI5FAdMeJR770S7ATzYaaz4MdKCiwCrW8=
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: dan.j.williams@intel.com
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	iamjoonsoo.kim@lge.com,
	james.morse@arm.com,
	jgg@ziepe.ca,
	jmorris@namei.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	maz@kernel.org,
	mhocko@suse.com,
	osalvador@suse.de,
	pasha.tatashin@soleen.com,
	sashal@kernel.org,
	tyhicks@linux.microsoft.com,
	vbabka@suse.cz,
	will.deacon@arm.com,
	code@tyhicks.com,
	srivatsa@csail.mit.edu,
	apais@linux.microsoft.com,
	vijayb@linux.microsoft.com,
	tballasi@linux.microsoft.com,
	bboscaccy@linux.microsoft.com
Subject: dax alignment problem on arm64 (and other achitectures)
Date: Wed, 26 Jun 2024 00:20:38 -0700
Message-Id: <20240626072038.1419889-1-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAPcyv4jLmDvQ+e7QSQjOsAccSnhpvm9J5kHsA1OCXcaOm7BrMA@mail.gmail.com>
References: <CAPcyv4jLmDvQ+e7QSQjOsAccSnhpvm9J5kHsA1OCXcaOm7BrMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dan,

Restarting this thread to get more insights about dax alignment problem.
So having a devdax pmem of size 128M is [1] not usable and entire memory
is wasted? For 256M size devdax pmem, again 126M seems to be wasted and
only 128M can be hot added/removed. This was observed on ARM64 platform.

do we have any potential or existing solution for this problem ?

> >
> > > Since we last talked about this the enabling for EFI "Special Purpose"
> > > / Soft Reserved Memory has gone upstream and instantiates device-dax
> > > instances for address ranges marked with EFI_MEMORY_SP attribute.
> > > Critically this way of declaring device-dax removes the consideration
> > > of it as persistent memory and as such no metadata reservation. So, if
> > > you are willing to maintain the metadata external to the device (which
> > > seems reasonable for your environment) and have your platform firmware
> > > / kernel command line mark it as EFI_CONVENTIONAL_MEMORY +
> > > EFI_MEMORY_SP, then these reserve-free dax-devices will surface.
> >
> > Hi Dan,
> >
> > This is cool. Does it allow conversion between devdax and fsdax so DAX
> > aware filesystem can be installed and data can be put there to be
> > preserved across the reboot?
> >
> 
> It does not because it's not "pmem" by this designation.
> 
> Instead if you want fsdax, zero metadata on the device, and the
> ability to switch from fsdax to devdax I think that could be achieved
> with a new sysfs attribute at the region-device level. Currently the
> mode of a namespace with no metadata on it defaults to "raw" mode
> where "raw" treats the pmem as a persistent memory block device with
> no DAX capability. There's no reason the default could instead be
> devdax with pages mapped.
> 
> Something like:
> ndctl disable-region region0
> echo 1 > /sys/bus/nd/devices/region0/pagemap
> echo devdax > /sys/bus/nd/devices/region0/raw_default

this interface file seems to be not available

can we use sub-section hotplug feature here, there aren't much details available
about using that, is it via sysfs ?

I appreciate your help and guidance on this.

Thanks,
Shyam

[1] https://elixir.bootlin.com/linux/v6.10-rc5/source/drivers/dax/kmem.c#L102

