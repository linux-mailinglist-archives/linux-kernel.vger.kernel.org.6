Return-Path: <linux-kernel+bounces-510972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A2EA32444
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28A29188BBB8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B5F209F46;
	Wed, 12 Feb 2025 11:06:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7996209F2A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358360; cv=none; b=KIGy4KUPRWqx4CwRUU/keZeBVJhjk0S8HK3xwfdRxKxtd+DgJ2h+PBP0bb8dpGZnBwObnBve4jrMpgXkEEMjfV91S++Q8bMDCRmeP/h5nvTvahGBNXbs7uM6kwmZtl91PSvX4vHL8VtPTgGSVJgI8wA3SFxfYDH75D7u9a+wIGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358360; c=relaxed/simple;
	bh=s1ze4xQNinyH/DHS94nK62X0DXQmMEcpyeP9YdE8IeA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U77Ld1yTauP7gjvrjLphgDaFGFuYDzzBZ5dYFkaS43+ideImxUl4rFA1eIjL1rHo7YIsoKcJIldRB958pz5nEljf+c7qLq7GwMV/uS1xaYNzf957ObhhReuHGQ2/Vg+Dmn+5WDywfv5aL5PtSCA9OBtHz0WqdVc+bU1R1cLUklY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66BFD106F;
	Wed, 12 Feb 2025 03:06:19 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98D223F6A8;
	Wed, 12 Feb 2025 03:05:57 -0800 (PST)
Date: Wed, 12 Feb 2025 11:05:54 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 18/18] firmware: arm_ffa: Allow multiple UUIDs per
 partition to register SRI callback
Message-ID: <Z6yAkmNZFnQW5TBZ@bogus>
References: <20250131-ffa_updates-v2-0-544ba4e35387@arm.com>
 <20250131-ffa_updates-v2-18-544ba4e35387@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131-ffa_updates-v2-18-544ba4e35387@arm.com>

On Fri, Jan 31, 2025 at 11:24:18AM +0000, Sudeep Holla wrote:
> A partition can implement multiple UUIDs and currently we successfully
> register each UUID service as a FF-A device. However when adding the
> same partition info to the XArray which tracks the SRI callbacks more
> than once, it fails.
> 
> In order to allow multiple UUIDs per partition to register SRI callbacks
> the partition information stored in the XArray needs to be extended to
> a listed list.
> 
> A function to remove the list of partition information in the XArray
> is not added as there are no users at the time. All the partitions are
> added at probe/initialisation and removed at cleanup stage.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_ffa/driver.c | 157 ++++++++++++++++++++++++++++----------
>  1 file changed, 116 insertions(+), 41 deletions(-)
> 

[...]

>  static void ffa_partitions_cleanup(void)
>  {
> -	struct ffa_dev_part_info *info;
> +	struct ffa_dev_part_info *info, *tmp;
>  	unsigned long idx;
>  
>  	/* Clean up/free all registered devices */
>  	ffa_devices_unregister();
>  
>  	xa_for_each(&drv_info->partition_info, idx, info) {
> +		struct list_head *phead = (struct list_head *)idx;
> +
>  		xa_erase(&drv_info->partition_info, idx);
> -		kfree(info);
> +		list_for_each_entry_safe(info, tmp, phead, node) {
> +			list_del(&info->node);
> +			kfree(info);
> +		}
> +		kfree(phead);

Issue was discovered when testing it as module(that's when cleanup
gets executed). It is now fixed here[1] with the below patch.

Regards,
Sudeep

[1] https://git.kernel.org/sudeep.holla/l/ffa_updates

-->8

diff --git c/drivers/firmware/arm_ffa/driver.c w/drivers/firmware/arm_ffa/driver.c
index 3c49ab3fe118..c184a220147f 100644
--- c/drivers/firmware/arm_ffa/driver.c
+++ w/drivers/firmware/arm_ffa/driver.c
@@ -1644,14 +1644,14 @@ static int ffa_setup_host_partition(int vm_id)
 
 static void ffa_partitions_cleanup(void)
 {
-       struct ffa_dev_part_info *info, *tmp;
+       struct list_head *phead;
        unsigned long idx;
 
        /* Clean up/free all registered devices */
        ffa_devices_unregister();
 
-       xa_for_each(&drv_info->partition_info, idx, info) {
-               struct list_head *phead = (struct list_head *)idx;
+       xa_for_each(&drv_info->partition_info, idx, phead) {
+               struct ffa_dev_part_info *info, *tmp;
 
                xa_erase(&drv_info->partition_info, idx);
                list_for_each_entry_safe(info, tmp, phead, node) {


