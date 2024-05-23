Return-Path: <linux-kernel+bounces-187053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA9C8CCC52
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A6D1C21EB4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 06:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3670713C664;
	Thu, 23 May 2024 06:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ageFvGMm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6EA1869
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 06:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716446165; cv=none; b=IRP5dhaxacV7mvW7GM6gtBINiJwkdvOL7drCq1X0m0MJSRV70dM79WrFMUNupFIZ6tQMQvTTuiQSxO6SfjtpVSisRtZtL3DqfxC3ix+s9cr1Iiz56nTkB19jN8ijbH3DXODAy0ajkDMfLaVykOCJMpwCGs77I5sJJXcgE6F5MTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716446165; c=relaxed/simple;
	bh=hfWNIGr2gSJ7bTmnEZQAmrv+N4XHJLusC4+LcZsAi2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mzcciV8RK0z7eTQTpuIcZoGX0LQXBhDRBye8R4xCBye6WMHSNQ5lBztZm2Z1ajrfdezTthQqUSpbtgjNVyQbGNWtSH41Fgm3v36WLKHu0A7i70hArEo9xYr1RBzYNvBmLs0jFjHr8iJWQqEFZMHPvD+RVMd9TZLyBNlZLXVp/I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ageFvGMm; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716446163; x=1747982163;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=hfWNIGr2gSJ7bTmnEZQAmrv+N4XHJLusC4+LcZsAi2s=;
  b=ageFvGMmkxqHqJQC8Xj7U8TWh66HevFUxuDO3LST4gfEVBWv08RHbPGL
   TWaOLSOBkzfchCtUtZubGd7mNoIvcu5Gk/HpEbKUeSrrfMuHwUiv2CaKE
   x4hnp+xdQMydrv3YvuRAXGRtc/qj2HZsBqqmNoWt4Wxfo1igyJet90Ul0
   Xm2EVbj+CPZMaQ/fcSxahTw9dBxwR/qnE9CKY0N1iRkWBbzk97oQM9G9L
   WRy8WcEXv2Kpcbs36cmtgulKhwF+K4WDbzlLXsZxei7sWWqbVhDnAnBVp
   YUzDlAf6gP3pLjp7axP0KcKAVWia89OCGVhXVum+k1i5B0zxa7tv/zYcu
   w==;
X-CSE-ConnectionGUID: hyn+ovNmTpOtd+4N43JtxQ==
X-CSE-MsgGUID: 9pIryNhVTJas7EjZTmC4Fg==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="24148936"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="24148936"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 23:36:02 -0700
X-CSE-ConnectionGUID: 4My4By+cThClSd/+zT8Q7w==
X-CSE-MsgGUID: CgZrXa6yRlyRUQvT2VXOug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="70960449"
Received: from jlawryno-mobl.ger.corp.intel.com (HELO [10.246.25.110]) ([10.246.25.110])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 23:35:59 -0700
Message-ID: <b19b95ca-c235-4738-a586-bfd1a36183dc@linux.intel.com>
Date: Thu, 23 May 2024 08:35:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: DRM Accel BoF at Linux Plumbers
To: Jeffrey Hugo <quic_jhugo@quicinc.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 open list <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, David Airlie
 <airlied@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>, Olof Johansson <olof@lixom.net>,
 Lucas Stach <l.stach@pengutronix.de>
References: <CAAObsKAw174AhGaA13Hyw0ANW=TxJHpK10+OwQGNMVca85Urdg@mail.gmail.com>
 <ZkyPoIXBeBUqFJ48@phenom.ffwll.local>
 <CAAObsKAJvgg54zBEP-e3PKPLVeX+akZFJudjutjzVVZOJa-41g@mail.gmail.com>
 <e22ffdea-3c18-3a23-e526-25809e98fcd9@quicinc.com>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <e22ffdea-3c18-3a23-e526-25809e98fcd9@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 21.05.2024 17:10, Jeffrey Hugo wrote:
> On 5/21/2024 8:41 AM, Tomeu Vizoso wrote:
>> On Tue, May 21, 2024 at 2:12 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>>>
>>> On Sat, May 18, 2024 at 10:46:01AM +0200, Tomeu Vizoso wrote:
>>>> Hi,
>>>>
>>>> I would like to use the chance at the next Plumbers to discuss the
>>>> present challenges related to ML accelerators in mainline.
>>>>
>>>> I'm myself more oriented towards edge-oriented deployments, and don't
>>>> know enough about how these accelerators are being used in the cloud
>>>> (and maybe desktop?) to tell if there is enough overlap to warrant a
>>>> common BoF.
>>>>
>>>> In any case, these are the topics I would like to discuss, some
>>>> probably more relevant to the edge than to the cloud or desktop:
>>>>
>>>> * What is stopping vendors from mainlining their drivers?
>>>>
>>>> * How could we make it easier for them?
>>>>
>>>> * Userspace API: how close are we from a common API that we can ask
>>>> userspace drivers to implement? What can be done to further this goal?
>>>>
>>>> * Automated testing: DRM CI can be used, but would be good to have a
>>>> common test suite to run there. This is probably dependent on a common
>>>> userspace API.
>>>>
>>>> * Other shared userspace infrastructure (compiler, execution,
>>>> synchronization, virtualization, ...)
>>>>
>>>> * Firmware-mediated IP: what should we do about it, if anything?
>>>>
>>>> * Any standing issues in DRM infra (GEM, gpu scheduler, DMABuf, etc)
>>>> that are hurting accel drivers?
>>>>
>>>> What do people think, should we have a drivers/accel-wide BoF at
>>>> Plumbers? If so, what other topics should we have in the agenda?
>>>
>>> Yeah sounds good, and I'll try to at least attend lpc this year since it's
>>> rather close ... Might be good to explicitly ping teams of merged and
>>> in-flight drivers we have in accel already.
>>
>> Sounds like a good idea to me. Will check if the people that sent the
>> previous aborted attempts are still interested in this
> 
> Looks like the Intel VPU folks are missing from this thread.
Hi!

> I like the idea of a BoF.  I suspect I will be remote but this list of topics looks good to me.  Nothing obvious missing from what I can tell.
I like it too and I will try to attend. I would maybe add to the list GPU/accel interoperability.

Regards,
Jacek

