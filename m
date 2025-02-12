Return-Path: <linux-kernel+bounces-510954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0986A3240F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83DA116161C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C5F209F35;
	Wed, 12 Feb 2025 10:57:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA776209691
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739357847; cv=none; b=Vct7A+Hs74ESvZ9QsLtrm5IYAI7tzG7j5Gi5WfZb8u11jnhG2gJ7x0p5ZVDdXLOJPobhiuhmdQ5BS1o36hrwjF5uG/hV4HKmajcr8MCUJr1qnm31RV0Mk9nGAMcgjjrMQJbvMtcpY8IUAd6Lq75U3qxuLuNvr7qUHXvG2yLjf+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739357847; c=relaxed/simple;
	bh=GQyLYv+2kzPcWIkwjWcAcdFueIsenjAzT0oMEGFtaVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lj1esXA8G2wm97eRt8nogREJ4lW6f7dFCgdiiv/hlETtjJKPZ0v0L6QG629HxRlwkVnSESuLE17L0v7T9vZl6TwUMZ2sOm4dkeAZ1Uma7JIM+mu77gcmPZ0b76g9hUUqE+FMruooQazN5+iwHJ5+By/GKTGoj05pXBFca639fEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4606812FC;
	Wed, 12 Feb 2025 02:57:46 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75AE63F6A8;
	Wed, 12 Feb 2025 02:57:24 -0800 (PST)
Date: Wed, 12 Feb 2025 10:57:21 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 17/18] firmware: arm_ffa: Add support for handling
 framework notifications
Message-ID: <Z6x-kXUb9bvFOUco@bogus>
References: <20250131-ffa_updates-v2-0-544ba4e35387@arm.com>
 <20250131-ffa_updates-v2-17-544ba4e35387@arm.com>
 <20250210101743.aqbhqqkdbvka2i46@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210101743.aqbhqqkdbvka2i46@vireshk-i7>

On Mon, Feb 10, 2025 at 03:47:43PM +0530, Viresh Kumar wrote:
> On 31-01-25, 11:24, Sudeep Holla wrote:
> > +static void handle_fwk_notif_callbacks(u32 bitmap)
> > +{
> > +	void *buf;
> > +	uuid_t uuid;
> > +	int notify_id = 0, target;
> > +	struct ffa_indirect_msg_hdr *msg;
> > +	struct notifier_cb_info *cb_info = NULL;
> > +
> > +	/* Only one framework notification defined and supported for now */
> > +	if (!(bitmap & FRAMEWORK_NOTIFY_RX_BUFFER_FULL))
> > +		return;
> > +
> > +	mutex_lock(&drv_info->rx_lock);
> > +
> > +	msg = drv_info->rx_buffer;
> > +	buf = kmalloc(msg->size, GFP_KERNEL);
> > +	if (!buf) {
> > +		mutex_unlock(&drv_info->rx_lock);
> > +		return;
> > +	}
> > +	memcpy(buf, (void *)msg + msg->offset, msg->size);
> 
> Can use kmemdup() here instead.
> 

Thanks for the suggestion. I have fixed locally. I will not respin the
series if there are no other major changes needed, will apply with this
suggestion included directly.

-- 
Regards,
Sudeep

