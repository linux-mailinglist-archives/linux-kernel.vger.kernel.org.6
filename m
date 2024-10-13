Return-Path: <linux-kernel+bounces-362740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437D099B8DC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 10:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F0D282346
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 08:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5721C13B2A2;
	Sun, 13 Oct 2024 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bQx0BdI9"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA792AD18
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728809278; cv=none; b=JiA5f5KXBfMdBbpxuSZZdguG+5E8kcpd6I+vBbDhIKyv8QmSIte6enxUMkLuiXaA/jsX4kpckvlfE/A2+euo5+g8vCvCUELg43r0u3nXHxthUodgPwvgok/GGgUrpbB1xSg74lwzVHJTle7qmZgOGgHmN6vs2i0rk7EwDHG3xlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728809278; c=relaxed/simple;
	bh=vjMo2uToGmLVWARLnCV3SWBPMkV4Bwj6pFqquGlw13M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GfURtwAf9qB2ruubM8tozKZoNaQ2+iQnFnh6plg6XrbYG+Y6caXnZYs5rAzTpQ83O2LEEuYFaP+GrXX8EgWAQ0byCI0qmbHUw0twCWiz1prcKbtqP01Q4UAbgXQ4zUUIKRhb28xKKCxpX7+weZDLsj+t3Xlugy0cXc4WE0J/6m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=bQx0BdI9; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [IPV6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f] (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A1DD04CE;
	Sun, 13 Oct 2024 10:46:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728809175;
	bh=vjMo2uToGmLVWARLnCV3SWBPMkV4Bwj6pFqquGlw13M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bQx0BdI9qDh2ug0/GU5yjGuc9NKhCyaZQa3rVRwHlmzaxNo871hKX4VRBn5Ll9Iu5
	 mpekhzd2aXY3NUGUnC7GzmCU+6a81BOV5/1uFMrNBV5/uZmmxU9MqxnkpGNwsWF+xM
	 lCn9AksXMuUXMG32R3actdP8FGo9KC21cBcCzaM0=
Message-ID: <e65783aa-11a6-4476-977c-898f4ae8744b@ideasonboard.com>
Date: Sun, 13 Oct 2024 14:17:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] staging: vchiq_arm: Fix drv_mgmt leak
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 kernel-list@raspberrypi.com, Stefan Wahren <wahrenst@gmx.net>
References: <20241013084529.377488-1-umang.jain@ideasonboard.com>
Content-Language: en-US
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20241013084529.377488-1-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

[Treat this series as RFC]

On 13/10/24 2:15 pm, Umang Jain wrote:
> 1/2 is a drive by fix.
> 2/2 uses devres resouce management helper devm_kzalloc() to auto-free
> struct vchiq_drv_mgmt on error and .remove() paths.
>
> It might be good to aware the devres issue and following talk might
> give reviewers a helpful context:
>
> - https://lpc.events/event/16/contributions/1227/
> - https://archive.fosdem.org/2023/schedule/event/devm_kzalloc/
>
> I am not totally sure if these problems, causes a blockers for these
> patches. There are a couple of memory management issues I've spotted
> which can be fixed? by devres (similar to this series) but probably I
> will wait for initial feedback on this series.

Was supposed to mark this as RFC for discussion and yes, I have realised 
I've not written a commit message for 2/2.
>
> Umang Jain (2):
>    staging: vchiq_arm: Drop blank lines
>    staging: vchiq_arm: Use devm_kzalloc for mgmt
>
>   .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c  | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
>


