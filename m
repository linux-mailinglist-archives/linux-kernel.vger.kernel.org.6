Return-Path: <linux-kernel+bounces-309948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F12396724F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 17:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1CA01C213B6
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 15:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740BC1F951;
	Sat, 31 Aug 2024 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lSWjjw+3"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC2715E81
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725116715; cv=none; b=dTZBbkreM0bFFPW2onAyuesCvKp2UCPQYpWA027dPkK7LvGlf//66FmeQe1PpEHDSpb1kLWg1+DsJh7ueEp5PQqo0WW/WMled7yyQBqi0YZyO2In6DTvCyy0YfYhscRO6mRaPP+SclSR26NdewVs6fyuB953IXH2H5obfprCu4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725116715; c=relaxed/simple;
	bh=Z8zJrbUxDzawYA1Gq8ndnFwUwsRue4UwXp1NVeQ3c2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEIoYsTW4KnE+wYYwidrOemhr3qV+H/wiQPx+ak/4lusCnRPOPkXJacXijXGmlhEsBFbrIrSQh+4M5SyGQCjrP18kRnK9/uCcAKyKOeAcO+MJtI9xZociAQeqkIakQVk/fTrfwF552ROx5kyaVADXAyO8ozLARnv5oArKFCsLTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=lSWjjw+3; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [IPV6:2405:201:2033:3865:19c8:9110:3e7:4518] (unknown [IPv6:2405:201:2033:3865:19c8:9110:3e7:4518])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 81234735;
	Sat, 31 Aug 2024 17:03:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1725116641;
	bh=Z8zJrbUxDzawYA1Gq8ndnFwUwsRue4UwXp1NVeQ3c2Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lSWjjw+3S5gxOAv8hyrNIkUjH2PFeMWdaH2YauJ2gZGQf1M20QE2rUOM0Q/eQjEBG
	 L8B8UkOpFg0Ug3ePVmLzc27OLRYK5AwlyIhxKhVtGswvNJkwP3oCVoe/XOshFB0tvA
	 tHer2yVwUjg15wFE3beIZWcVeUSoJL5ZUZJlbJ+s=
Message-ID: <b0e51146-6f6c-46d7-bfea-277092cfbd7b@ideasonboard.com>
Date: Sat, 31 Aug 2024 20:35:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] staging: vchiq_core: Factor out bulk transfer for
 (no/)callback mode
To: Arnd Bergmann <arnd@arndb.de>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 "laurent.pinchart" <laurent.pinchart@ideasonboard.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Stefan Wahren <wahrenst@gmx.net>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Phil Elwell <phil@raspberrypi.com>
References: <20240823-to_sent2-v1-0-8bc182a0adaf@ideasonboard.com>
 <20240823-to_sent2-v1-4-8bc182a0adaf@ideasonboard.com>
 <08aa277d-a966-4785-921e-6a63a2e5922b@app.fastmail.com>
Content-Language: en-US
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <08aa277d-a966-4785-921e-6a63a2e5922b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Arnd

On 23/08/24 9:11 pm, Arnd Bergmann wrote:
> On Fri, Aug 23, 2024, at 15:14, Umang Jain wrote:
>
>> +int
>> +bulk_xfer_callback_interruptible(struct vchiq_instance *instance,
>> unsigned int handle,
>> +				 void *offset, void __user *uoffset, int size,
>> +				 enum vchiq_bulk_mode mode, void *userdata,
>> +				 enum vchiq_bulk_dir dir)
> It seems you can also tighten the argument types here a bit more:
>
> - uoffset is always NULL and can be left out

Not true.

in vchiq_dev.c. it is not NULL

This should ideally be split off even more, for in-kernel usage (using 
the kernel pointers only) and for ioctl interface (that uses __user pointer)
> - userdata is either NULL or a struct mmal_msg_context, so you can use
>    that type directly.

It can be NULL, struct mmal_msg_context or a integer pointer - if coming 
through ioctl interface (vchiq_dev.c)

(Checked via checking vchiq_test code)

>
>       Arnd


