Return-Path: <linux-kernel+bounces-261481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B055993B7DB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26C71C240CB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5861716A38B;
	Wed, 24 Jul 2024 20:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="igwkOP0w"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AACB50284
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852036; cv=none; b=ZnRgQbyj5I0+lj/uEBFI6Ovoyvb26BvRsoRAX2Ri3zH1SoFlvJjqlZU8TkwOCAh6Pu/v4JT0wYGekOVWOW23zVqdcckrYCJD3HuOwoxfV4aDUsGgpWbhNrMea1g6I75zR1Xx2Wj+O+y5Elei3Dm3O80SuN+jlHOTugeVYLJJ0NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852036; c=relaxed/simple;
	bh=nkr0lIZ2SS9RiNP/6cpiplg0yuLWnzQGWkB6D7Kn3vI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8R2zDyc0wbkGpP4S7lWDxtp/QpVRNQsyYfJ8+2MXCl54qtOUnYuhiGwZEZHBpiZ8qI0xGWQyHoyd/1vPhqtT6ulr+VnUzYnU+pLkg/eDjX7aLDdWqVssqGlgg8iB/0DaapbwDITVeB5URmoKvgY5XK5d/b4QtwY314wFoxNl7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=igwkOP0w; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3013c48e-1757-4e43-a0c0-d2b3af9f3100@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721852032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QgmohGYP6ZaHb17OqQ/1ToU1Ygt9h2KB+Wu/4W1ssrY=;
	b=igwkOP0w7qQD6Ai1mGCUD+HziQo0zI+i+pQiA5JG+SgP70wlG4TlKJcgy4OpIN1kMkFIQk
	oT2gVq/C30npsHgIyBjf8MWDuS4sih7OIONEIahq958wsIgBcMMtDhigJc228GNlIV1qn8
	urx91weVuN5E76W7ZlzMjP4DtQBUvRo=
Date: Thu, 25 Jul 2024 04:13:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4] drm/loongson: Introduce component framework support
To: Markus Elfring <Markus.Elfring@web.de>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240723183436.216670-1-sui.jingfeng@linux.dev>
 <20240723183436.216670-2-sui.jingfeng@linux.dev>
 <b3f75c6c-6c3e-41ee-92b9-ac5d9cca53f8@web.de>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <b3f75c6c-6c3e-41ee-92b9-ac5d9cca53f8@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 7/24/24 15:30, Markus Elfring wrote:
>> In some display subsystems, the functionality of a PCIe device may too
> 
>                                                                   might be?
> 
> 
> …
>> of the dirver is loaded, …
> 
>           driver?
> 
> 
> …
>> its dependencies ready before it can register the service to userspace.
> 
>                                                                 user space?
> 
> 
> …
>> submodule by creating platform devices manually during driverload time.
> 
>                                                           driver load?
> 
> 
> …
>> device as a DRM proxy, which will attach the common drm routines to our
> 
>                                                        DRM?
> 
> 
> …
>> While at it, also do some cleanups.
> 
> I find such information suspicious.
> Is there any need to offer adjustments as separate update steps?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10#n81

Thanks a lot for review, I will try to fix those problems in the future.

> Regards,
> Markus

