Return-Path: <linux-kernel+bounces-268717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 090BA942849
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E24282A89
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677781A76CD;
	Wed, 31 Jul 2024 07:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l0laINnu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBBD1A76C2
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411874; cv=none; b=gVUvqLYZheRBVuUkZJCd3UpW9m8lf7aYCXNrfbVSlmFC1BXkPMhMy4L1RUzFqIgqHzOyIcW3ABgRCRHGVI9GH91hpQfQ8/fGr577izjIYg0EnZ+EeLSy9jHm0vVm8NJkz8jyIllBKG6MrZEGckvXyLVNQczn+ewhblht5lvlWrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411874; c=relaxed/simple;
	bh=uI8ued3A1y+KABwhLnnHrEksiCAWTyppjF8eLSYsOcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNN7oapW/zLacpGtPgHwzSEYBQULc5BFprzTnq6ezj0ur6/24HY3gFcWMOgggzh6hYb1vFt5OFt5yUMRtk7+/OJRo7b+yIF5Jq1qToWnTJqZKNWneH0IycCHsOqPzpBv21z+ELr+QZ9QDuXOzwKDnYeiHN1IdXtZkLIAVyxJ8to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l0laINnu; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722411873; x=1753947873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uI8ued3A1y+KABwhLnnHrEksiCAWTyppjF8eLSYsOcw=;
  b=l0laINnu+BHwe9Guc8BNYfCm4z6Bgv5F+saioXY3TXtRrJRFr5KkZMZa
   3o+oLh4eDey8MDeOgVTNljlgAUl9j36Zfzi8YgN80iBQEkRVIqlwvDS+F
   mdTNchTdXhiTk6zn+pXI2rqHdELSoAZZCHXVcP6T0hBsz1lsz6qEHZ+Br
   0idyzvSwVW5B52thbF9YjYV9znOK2rBoBeiG9zAkoy0Lz5vNZMqbHG21n
   jmXltJRL/J2mabJ/Kgs6RkPOmw4RVGdixePUkwiFJ8mMwSW8FtvA3cS6C
   DmG3VT8QPpHmIVTCyhGVoSSVvMiYoMU9yvuinsRHwiRrEq8zD7qbSOmnQ
   g==;
X-CSE-ConnectionGUID: zKLcK9SbRCi04ORwBvbhRA==
X-CSE-MsgGUID: eddvyOtLRAaITHFbOQQnaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="31423135"
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="31423135"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 00:44:33 -0700
X-CSE-ConnectionGUID: AU/vUc6qTpOrr5lhfWTkQg==
X-CSE-MsgGUID: cu7MWQ00QVmLseBL9zTmcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="59455163"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.36])
  by orviesa003.jf.intel.com with ESMTP; 31 Jul 2024 00:44:28 -0700
Date: Wed, 31 Jul 2024 16:00:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
	Ani Sinha <anisinha@redhat.com>,
	Eduardo Habkost <eduardo@habkost.net>,
	Igor Mammedov <imammedo@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Shannon Zhao <shannon.zhaosl@gmail.com>,
	Yanan Wang <wangyanan55@huawei.com>, linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 2/6] arm/virt: Wire up GPIO error source for ACPI /
 GHES
Message-ID: <ZqnvD8o+Fa4o/+Db@intel.com>
References: <cover.1722259246.git.mchehab+huawei@kernel.org>
 <e994c3944d31775d62bbd017dec3adff50ddf269.1722259246.git.mchehab+huawei@kernel.org>
 <ZqigPgTl7quJ553J@intel.com>
 <20240731072158.3aaf85ac@foz.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240731072158.3aaf85ac@foz.lan>

On Wed, Jul 31, 2024 at 07:21:58AM +0200, Mauro Carvalho Chehab wrote:

[snip]

> > The name looks inconsistent with the style of other MachineClass virtual
> > methods. What about the name like "notify_xxx"? And pls add the comment
> > about this new method.
> > 
> > BTW, I found this method is called in generic_error_device_notify() of
> > Patch 6. And the mc->generic_error_device_notify() - as the virtual
> > metchod of MachineClass looks just to implement a hook, and it doesn't
> > seem to have anything to do with MachineClass/MachineState, so my
> > question is why do we need to add this method to MachineClass?
> > 
> > Could we maintain a notifier list in ghes.c and expose an interface
> > to allow arm code register a notifier? This eliminates the need to add
> > the ¡°notify¡± method to MachineClass.
> 
> Makes sense. I'll change the logic to use this notifier list code inside
> ghes.c, and drop generic_error_device_notify():
> 
> 	NotifierList generic_error_notifiers =
> 	    NOTIFIER_LIST_INITIALIZER(error_device_notifiers);
> 
> 	/* Notify BIOS about an error via Generic Error Device - GED */
> 	static void generic_error_device_notify(void)
> 	{
> 	    notifier_list_notify(&generic_error_notifiers, NULL);
> 	}

Fine for me.

Regards,
Zhao



