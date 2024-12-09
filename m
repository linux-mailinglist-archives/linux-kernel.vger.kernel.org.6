Return-Path: <linux-kernel+bounces-437780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9167C9E9889
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D0A283F6A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62461B0407;
	Mon,  9 Dec 2024 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+N09Gyn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291381798F;
	Mon,  9 Dec 2024 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733753720; cv=none; b=e0u/4oQTzybR1ZbsK8VlYyDTLCMA6554Di/46wzRRtnFvGj/b+DJMHSqJ0cgBrqqofcrmq/5hLLfVysixjfy2q7k57vycNucuQ/Psf49A4qVgi7hoK91FMFEiFt8X7JqI3l14oQxFZhyvNNgFVNuW3xAK+yoBgYzp1DEzl3Ur/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733753720; c=relaxed/simple;
	bh=0cm5M3lg6mJAUxDr/Ep65Go9irRkUEvfAP97btcPZgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HRvxxoxvwbaw+A8cTYtPytoQbaswZou53MV4od+rGHQ4a91fAVEI1BHzgLWQzCi2SwA5knFIVOg6QOQXdq3pzldHD9E2AdAyu19WvS9izo9j5Q0hP+NB3zzseDYHTDgZRN9Ezn5+dcqMa+4TWHIk7tM+pQykYCbK9aON+HlDwNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+N09Gyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D485C4CED1;
	Mon,  9 Dec 2024 14:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733753718;
	bh=0cm5M3lg6mJAUxDr/Ep65Go9irRkUEvfAP97btcPZgs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K+N09Gyn3XV6XcC61qxzaA4MpbG/WnLTgcJASFSr2nU8x0jU0qbic5pbbWQaqnBQ/
	 MRIef3iHVnRVaBDUak2Uwi6mvggycRMO/dGMF5U4JKAQQvBwL12NxgbeGXEne944Uh
	 LitF6g1H4WKQxdqoQeQ8LXU+rbcqChVrWDMwCSJdOTQU1/wNWbfYitOFW7k4LbLynJ
	 v8SQ6X4lC3oS1vn0WOQLAmSv8tvHgJMzeDGIBu4Vj34IXykfj0K4iqOI+EBTnd57Lr
	 NnTyDdBqO8YnFWF/NxGbVMB3O9CkrspgGEDL9TuP1dj33MRVJfzBKluaxnA4VQQt6a
	 9Ow1YqzLVs1fQ==
Message-ID: <c40bed54-63e9-4535-b17b-fba980f19382@kernel.org>
Date: Mon, 9 Dec 2024 08:15:16 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thunderbolt: Don't display retimers unless nvm was
 initialized
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Andreas Noever <andreas.noever@gmail.com>,
 Michael Jamet <michael.jamet@intel.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Richard Hughes <hughsient@gmail.com>
References: <20241206183318.1701180-1-superm1@kernel.org>
 <20241209062415.GG4955@black.fi.intel.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20241209062415.GG4955@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/9/2024 00:24, Mika Westerberg wrote:
> Hi Mario,
> 
> On Fri, Dec 06, 2024 at 12:33:18PM -0600, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> The read will never succeed if nvm wasn't initialized.
> 
> Okay but we would need to understand why it was not initialized in the
> first place?

Oh sorry I should have included that/

https://gist.github.com/superm1/c3763840fefa54298258a6fbec399007

As you can see it's an unknown retimer NVM format.  So this ends up down 
the path of "NVM upgrade disabled".  So that's why I'm thinking the 
visibility is the right move to adjust here (IE this patch).

> 
> I see this is ThinkPad Thunderbolt 4 Dock so probably Intel hardware? You
> say you can reproduce this too so can you send me full dmesg with
> thunderbolt dynamic debugging enabled? I would like to understand this bit
> more deeper before we add any workarounds.
> 
>> Reported-by: Richard Hughes <hughsient@gmail.com>
>> Closes: https://github.com/fwupd/fwupd/issues/8200
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/thunderbolt/retimer.c | 17 ++++++++++++++---
>>   1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
>> index 89d2919d0193e..7be435aee7217 100644
>> --- a/drivers/thunderbolt/retimer.c
>> +++ b/drivers/thunderbolt/retimer.c
>> @@ -321,9 +321,7 @@ static ssize_t nvm_version_show(struct device *dev,
>>   	if (!mutex_trylock(&rt->tb->lock))
>>   		return restart_syscall();
>>   
>> -	if (!rt->nvm)
>> -		ret = -EAGAIN;
>> -	else if (rt->no_nvm_upgrade)
>> +	if (rt->no_nvm_upgrade)
>>   		ret = -EOPNOTSUPP;
>>   	else
>>   		ret = sysfs_emit(buf, "%x.%x\n", rt->nvm->major, rt->nvm->minor);
>> @@ -342,6 +340,18 @@ static ssize_t vendor_show(struct device *dev, struct device_attribute *attr,
>>   }
>>   static DEVICE_ATTR_RO(vendor);
>>   
>> +static umode_t retimer_is_visible(struct kobject *kobj,
>> +				      struct attribute *attr, int n)
>> +{
>> +	struct device *dev = kobj_to_dev(kobj);
>> +	struct tb_retimer *rt = tb_to_retimer(dev);
>> +
>> +	if (!rt->nvm)
>> +		return 0;
>> +	return attr->mode;
>> +
>> +}

I just noticed I had a spurious newline here.  If we end up taking this 
patch would you mind just fixing it up?  If there is other feedback I'll 
fix it on a v2.

>> +
>>   static struct attribute *retimer_attrs[] = {
>>   	&dev_attr_device.attr,
>>   	&dev_attr_nvm_authenticate.attr,
>> @@ -351,6 +361,7 @@ static struct attribute *retimer_attrs[] = {
>>   };
>>   
>>   static const struct attribute_group retimer_group = {
>> +	.is_visible = retimer_is_visible,
>>   	.attrs = retimer_attrs,
>>   };
>>   
>> -- 
>> 2.43.0


