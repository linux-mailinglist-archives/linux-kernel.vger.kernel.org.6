Return-Path: <linux-kernel+bounces-517915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3333A38766
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393F816EB50
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0002248A5;
	Mon, 17 Feb 2025 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LT078Jkm"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F3521D5AA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739805535; cv=none; b=ILehw25s8yiM6G0xnRraT/6hkkbPn0NyAcy3OC1gvzDkmzlWnekOt9EpMjBXh0x6Rcm8qzXQ81UlPE65CT9P4CpZg5KSAHuTrZoWj9sN9QCxuzfM5fBkWcpXySKRimOivxngqGnXsOPnlQ7CLr/r4Lw1doTkSPJ4oN1285RzIHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739805535; c=relaxed/simple;
	bh=rB1i4l2/XKVbabCGkwc2C9eIg8JP7iC5IOAbL9NDzD0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=R6KLgHws94swiDEu7ZGMLF2rnbWezAcwF0iUUHwNv+5uzcxAPQ0FpwJYq6yvHxE1eNjmOMrVamSzNQlDeCceDL13T5787XYnIuhjrwG1jFfE/xeTz97/s69475WrZgQiybGdW/I+Lkf7CC/3DP9OhVvyHgvtSAGZFaIUEPEcn7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LT078Jkm; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a51c0c24-fd21-42b3-9c4a-39ebc0751f03@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739805520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SwKI7hWDzcyDyvWSyNtpef/iRsXjDY6W/TTp8ONOqXE=;
	b=LT078JkmIhf9Ya+xQQ/Tt1YHNAOQkvwEdc8wVWxG/bpIHisnMEng06tzN+oKxTu5erE2K+
	YTWOZMBqK9C+pWWjxdEJnIe8vUDFqJkaK5sn2RgRojuhJA8lEGQVTNCHdGUz1a4YylBcmY
	0L9t3nqPl37PFUX401o65DsrL5hrOZM=
Date: Mon, 17 Feb 2025 16:18:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Marco Pagani <marco.pagani@linux.dev>
Subject: Re: [RFC v2 1/1] fpga-region: Add generic IOCTL interface for runtime
 FPGA programming
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Nava kishore Manne <nava.kishore.manne@amd.com>, git@amd.com,
 mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
 robh@kernel.org, saravanak@google.com, linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org, devicetree@vger.kernel.org
References: <20241029091734.3288005-1-nava.kishore.manne@amd.com>
 <20241029091734.3288005-2-nava.kishore.manne@amd.com>
 <ZzwQrYeWVF6cRtgA@yilunxu-OptiPlex-7050>
 <9bfaf1cf-3313-4cb3-9963-2b4bad2d3165@redhat.com>
 <Z0fIiQPCS69O2d/n@yilunxu-OptiPlex-7050>
 <00e5c1c1-a98e-4360-b7e5-ffaa384e1036@linux.dev>
 <Z6RRAXocxWHsZZLF@yilunxu-OptiPlex-7050>
Content-Language: en-US
In-Reply-To: <Z6RRAXocxWHsZZLF@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 06/02/25 07:04, Xu Yilun wrote:
>>>> I'm currently working on an RFC to propose a rework of the fpga
>>>> subsystem in order to make it more aligned with the device model. One of
>>>> the ideas I'm experimenting with is having a bus (struct bus_type) for
>>>> fpga regions (devices) so that we can have region drivers that could
>>>> handle internal device enumeration/management whenever a new region is
>>>> configured on the fabric. Does this make sense in your opinions?
>>>
>>> mm.. I didn't fully understand the need to have a region driver, what's
>>> the issue to solve?
>>>
>>
>> Sorry for the late reply. The general idea is to handle regions in a way
>> that is more aligned with the device model without having to resort to
>> extra ops and additional devices.
>>
>> Having an fpga bus would allow us to handle enumeration using proper
>> region drivers (in the device model sense of the term, i.e., struct
>> device_driver) instead of derived region devices.
>>
>> On second thought, I think having a reconfiguration interface at the
>> fpga manager level is sounder than having it at the region level (one
>> for each region).
> 
> I don't think so. A firmware image may contain enumeration info, e.g.
> of-fpga-region. And I think the fpga-region should parse these
> enumeration info rather than fpga manager. fpga manager should only deal
> with content writing stuff and not be exposed to user.

I agree with that. In my proposal, the fpga manager should be
responsible only for writing the image into the configuration memory
and allocating region devices. In-region enumeration should be handled by
the region drivers.

My worry with having one reconfiguration interface for each region is
that it does not reflect how the hardware works. To my knowledge, all
major FPGA implementations use a DMA engine (controlled by the fpga
manager) that performs the reconfiguration through a single port. So,
having one interface per region might be conceptually confusing and give
the impression that it is possible to configure regions independently in
parallel.

>> With that in place, the fpga manager could request a firmware image,
>> parse it, write the content into the fpga configuration memory, and then
>> instantiate the region devices and add them to its fpga bus. Then, if
> 
> I think an fpga-region is always there no matter it is cleared, being
> reprogrammed, or working. So I don't think an fpga-region needs to be
> re-instantated. The sub devices inside fpga-region needs
> re-instantating. That's also why I'm hesitating to fpga bus.

I think one of the issues with the current subsystem architecture is
that it coalesces two cases: full and partial images. With partial
images, it makes sense to keep the region devices and rerun the internal
enumeration. With full images, I believe it makes sense to clear and
reallocate new devices to set a new region tree.
 
> Thanks,
> Yilun
> 
>> there is a match, a specific region driver can handle the enumeration
>> within the new region.
>>
>> What do you think?

Thanks,
Marco


