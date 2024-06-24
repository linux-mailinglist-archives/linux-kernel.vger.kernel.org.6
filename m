Return-Path: <linux-kernel+bounces-226765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A8B914351
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E673284A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 07:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA20F3CF74;
	Mon, 24 Jun 2024 07:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lPGJU+FD"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20A3376E1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719213264; cv=none; b=R2WVaNi4nwki6p3z1ATmK+VT6W0nnLGoxMEXn+2YHfUNTA2DFl4SgNVJfWOl9OVt7AjQbQWfYwOnLtyihBOb3Qv7z0KHsrMHf2bKCJP7LCsriVuAlTQtmwaYaOkC7OckMj2LIQLROUBjyRxwbq7BIzj7067P33zrCAPzz2n2C9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719213264; c=relaxed/simple;
	bh=TPwGeCbxaMvWhwasuexajYhtdGbtYaMDnzOCEVwhdAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dCeSCZkePtuoqCakChOBB6eTLaaWi8ObHmjThGrtWv2QHeWL88GvwKBVt2UuoO1d6GQGsk3QgQ75eB1erkWbvwBb8G7Vxi9iK2YK6t6WpFYqie/eLUHv7U/PxTkgkmtHOzyCm+hWSLHmUFLZK91tq9rXd4RHKR9rZlkFPRjVT6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=lPGJU+FD; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [IPV6:2405:201:2015:f873:9278:2c85:fd02:c5f5] (unknown [IPv6:2405:201:2015:f873:9278:2c85:fd02:c5f5])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C3CEB7E0;
	Mon, 24 Jun 2024 09:13:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1719213233;
	bh=TPwGeCbxaMvWhwasuexajYhtdGbtYaMDnzOCEVwhdAY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lPGJU+FDKBl8q1dkkqYL779EAOsE1BApzA8jsoaem+hbbX20HEeToA1YUHFJHgkja
	 WkXn2rVXBfurqQuLg1+PHPEJKBAKXR2kLRCWub7f9KXgbU4I0TVHFCj9vg3oK9EVbh
	 zLDphaeVdUbDYRjo78FRZKbLX/GOszit2g3ifZiw=
Message-ID: <246fef06-4759-4b2c-a515-933fece425da@ideasonboard.com>
Date: Mon, 24 Jun 2024 12:44:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] staging: vc04_services: vchiq_arm: Fix initialisation
 check
Content-Language: en-US
To: Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-rpi-kernel@lists.infradead.org, Stefan Wahren <wahrenst@gmx.net>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Yang Li <yang.lee@linux.alibaba.com>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20240620221046.2731704-1-kieran.bingham@ideasonboard.com>
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20240620221046.2731704-1-kieran.bingham@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kieran,

On 21/06/24 3:40 am, Kieran Bingham wrote:
> The vchiq_state used to be obtained through an accessor which would
> validate that the VCHIQ had been initialised correctly with the remote,
> or return a null state.
>
> In commit 42a2f6664e18 ("staging: vc04_services: Move global g_state to
> vchiq_state") the global state was moved to the vchiq_mgnt structures
> stored as a vchiq instance specific context. This conversion removed the
> helpers and instead replaced users of this helper with the assumption
> that the state is always available and the remote connected.
>
> The conversion does ensure that the state is always available, so some
> remaining state null pointer checks that remain are unnecessary, but the
> assumption that the remote is present and initialised is incorrect.
>
> Fix this broken assumption by re-introducing the logic that was lost
> during the conversion.

Yes, the logic was broken. thanks for noticing this.
>
> Fixes: 42a2f6664e18 ("staging: vc04_services: Move global g_state to vchiq_state")
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>
>
> ---
> v2:
>   - Just a resend
>
> v3:
>   - Downgrade vchiq_open() error path print to dbg
>   - Clarify commit message about unnecessary state checks.
>
>   .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c  | 4 ++--
>   .../staging/vc04_services/interface/vchiq_arm/vchiq_core.h | 5 +++++
>   .../staging/vc04_services/interface/vchiq_arm/vchiq_dev.c  | 7 ++++++-
>   3 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index 69daeba974f2..5f518e5a9273 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -707,7 +707,7 @@ int vchiq_initialise(struct vchiq_state *state, struct vchiq_instance **instance
>   	 * block forever.
>   	 */
>   	for (i = 0; i < VCHIQ_INIT_RETRIES; i++) {
> -		if (state)
> +		if (vchiq_remote_initialised(state))
>   			break;
>   		usleep_range(500, 600);
>   	}
> @@ -1202,7 +1202,7 @@ void vchiq_dump_platform_instances(struct vchiq_state *state, struct seq_file *f
>   {
>   	int i;
>   
> -	if (!state)
> +	if (!vchiq_remote_initialised(state))
>   		return;
>   
>   	/*
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> index 8af209e34fb2..382ec08f6a14 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> @@ -413,6 +413,11 @@ struct vchiq_state {
>   	struct opaque_platform_state *platform_state;
>   };
>   
> +static inline bool vchiq_remote_initialised(const struct vchiq_state *state)
> +{
> +	return state->remote && state->remote->initialised;
> +}
> +
>   struct bulk_waiter {
>   	struct vchiq_bulk *bulk;
>   	struct completion event;
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> index 67ba9ceaad3e..9cd2a64dce5e 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> @@ -1170,6 +1170,11 @@ static int vchiq_open(struct inode *inode, struct file *file)
>   
>   	dev_dbg(state->dev, "arm: vchiq open\n");
>   
> +	if (!vchiq_remote_initialised(state)) {
> +		dev_dbg(state->dev, "arm: vchiq has no connection to VideoCore\n");
> +		return -ENOTCONN;
> +	}
> +
>   	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
>   	if (!instance)
>   		return -ENOMEM;
> @@ -1200,7 +1205,7 @@ static int vchiq_release(struct inode *inode, struct file *file)
>   
>   	dev_dbg(state->dev, "arm: instance=%p\n", instance);
>   
> -	if (!state) {
> +	if (!vchiq_remote_initialised(state)) {
>   		ret = -EPERM;
>   		goto out;
>   	}


