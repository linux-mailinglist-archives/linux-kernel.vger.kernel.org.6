Return-Path: <linux-kernel+bounces-517797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589E3A385DE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEDE83B3AC7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B9521D009;
	Mon, 17 Feb 2025 14:13:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8C121CC59
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801630; cv=none; b=lHxNH9RfGoPgh/P+ITvAEaChzKv5yr8hTVUYWs6OTPfxy94FR/aJ7cFPJfG0Uz2ilMY/pPmUZTdBmAHrUqjuDf0oag4V/As8r3CwCUIHH+aow6vvXqt4zvRmUEQrdA93JrFqhquE++z3HtT4P/ge10v7HWf9dnc9h0RA/l/hEYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801630; c=relaxed/simple;
	bh=BDhq3FnMyKkbbSsoUCH6vLeyIdi0qbI6Kw9qS+IRKD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yd0cLzLOMlj9lUSlMHP81cZz4r18/HHCZr22/LW0QnX+QNkzXeheSltph4YeHpLoHaqmQbw5YKx3A3kvJAIQDQ20UHvoSewSDxhdq/MiUnpbLWcQNyLdScs4Au60Xax9kilVp0ssKpYB+5WZ8d0WulWODdBP4+llai8QV1yB0KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 379CA152B;
	Mon, 17 Feb 2025 06:14:07 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D4523F6A8;
	Mon, 17 Feb 2025 06:13:47 -0800 (PST)
Date: Mon, 17 Feb 2025 14:13:44 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/18] firmware: arm_ffa: Refactor addition of
 partition information into XArray
Message-ID: <Z7NEGG3DKiMUEu83@bogus>
References: <20250131-ffa_updates-v2-0-544ba4e35387@arm.com>
 <20250131-ffa_updates-v2-6-544ba4e35387@arm.com>
 <20250214045030.mfegbypq27gdl6sg@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214045030.mfegbypq27gdl6sg@vireshk-i7>

On Fri, Feb 14, 2025 at 10:20:30AM +0530, Viresh Kumar wrote:
> On 31-01-25, 11:24, Sudeep Holla wrote:
> > @@ -1461,39 +1480,18 @@ static int ffa_setup_partitions(void)
> >  		    !(tpbuf->properties & FFA_PARTITION_AARCH64_EXEC))
> >  			ffa_mode_32bit_set(ffa_dev);
> >  
> > -		info = kzalloc(sizeof(*info), GFP_KERNEL);
> > -		if (!info) {
> > +		if (ffa_xa_add_partition_info(ffa_dev->vm_id)) {
> >  			ffa_device_unregister(ffa_dev);
> >  			continue;
> >  		}
> > -		rwlock_init(&info->rw_lock);
> > -		ret = xa_insert(&drv_info->partition_info, tpbuf->id,
> > -				info, GFP_KERNEL);
> > -		if (ret) {
> > -			pr_err("%s: failed to save partition ID 0x%x - ret:%d\n",
> > -			       __func__, tpbuf->id, ret);
> > -			ffa_device_unregister(ffa_dev);
> > -			kfree(info);
> > -		}
> > +
> 
> Why extra blank line here ?
> 

Spurious for sure, no idea how I managed that though. Dropped it now.

-- 
Regards,
Sudeep

