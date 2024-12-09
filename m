Return-Path: <linux-kernel+bounces-437943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9612E9E9ACB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5130B281577
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C161C5CD7;
	Mon,  9 Dec 2024 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiWFzD6j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149E31B4236;
	Mon,  9 Dec 2024 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733759085; cv=none; b=JXUp26iRd1AI7R/4j5eelDG0NokqlS+SnVUckseCEOJyG3EETvCBfXYL1nexhD5wr8xQRZYDQ2ytDDS6CcvViIS0Y+H9unq3NlD3t3eE8o/F2iXA4wPqN3R1uRuh50yDzbhPQwM9hnpCrQ+WaVw29ZG11BgJnbdxkkOLRhdLPWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733759085; c=relaxed/simple;
	bh=9GOLiYQVIhXG83mUb2q1xQx/CP+id9qyn1icV0HpwF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nBcQiI//Oc3832XmynVodewgn46zRylLomf7TcpbYeLf8zePNqDcgFW7xnaNrU7EewP2VNVatIrs6Y7woPKUWoAj6aBi1InNtkfbdjN5Nsfj92XyWEWNEcPJBvzbz+zvjHlO7HgBw2fSHZpSiB++oWdafm7hjOSyB5ya299I7KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiWFzD6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480F9C4CED1;
	Mon,  9 Dec 2024 15:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733759084;
	bh=9GOLiYQVIhXG83mUb2q1xQx/CP+id9qyn1icV0HpwF0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FiWFzD6jHLtDA0q5Qt34FoHZ8bKAmwvsTwOPaEjJVRevpGQqFrBJSQSdwxg4Qt5nV
	 or5w+XQWGhfesAoZducHdP6gYBBtR9wb8wflVvQGO5RYk211K+wFHC9zI/MPccW56X
	 R2+O5tOCK0sZ6U5xTXVES0vm+i+vuailS0lOQR5vutzwG0tZq49doQXOATxtohoGKS
	 XY8cDLHD6ZNXvXqPG3ULJ0JpQO+uI5E5QGzRWafMwDCc30cRfRDxT+VlhpN2ZKoRFr
	 oaMcEqoTrZo8yB2s7cqOk2xaoCsEDPBRtB6cIrydqYcHP5yIyLVfL+s0Ug3j6+8wjZ
	 v3FfVUe1yjYeA==
Message-ID: <4314e730-0852-47e9-8431-f9ec648f4bff@kernel.org>
Date: Mon, 9 Dec 2024 09:44:43 -0600
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
 <c40bed54-63e9-4535-b17b-fba980f19382@kernel.org>
 <20241209154013.GK4955@black.fi.intel.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20241209154013.GK4955@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/9/2024 09:40, Mika Westerberg wrote:
> On Mon, Dec 09, 2024 at 08:15:16AM -0600, Mario Limonciello wrote:
>> On 12/9/2024 00:24, Mika Westerberg wrote:
>>> Hi Mario,
>>>
>>> On Fri, Dec 06, 2024 at 12:33:18PM -0600, Mario Limonciello wrote:
>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> The read will never succeed if nvm wasn't initialized.
>>>
>>> Okay but we would need to understand why it was not initialized in the
>>> first place?
>>
>> Oh sorry I should have included that/
>>
>> https://gist.github.com/superm1/c3763840fefa54298258a6fbec399007
>>
>> As you can see it's an unknown retimer NVM format.  So this ends up down the
>> path of "NVM upgrade disabled".  So that's why I'm thinking the visibility
>> is the right move to adjust here (IE this patch).
> 
> This is actually on-board retimer of the AMD platform:

Oh, good point.

> 
> Dec 09 07:29:11 fedora kernel: thunderbolt 0-0:2.1: retimer NVM format of vendor 0x7fea unknown
> Dec 09 07:29:11 fedora kernel: thunderbolt 0-0:2.1: NVM upgrade disabled
> Dec 09 07:29:11 fedora kernel: thunderbolt 0-0:2.1: new retimer found, vendor=0x7fea device=0x1032
> 
> I would think you guys want to make it upgradeable as well, no?

For AMD platforms retimers are nominally upgraded by the platform's BIOS 
upgrade, there haven't been asks from anyone to upgrade in AFAIK OS 
(Windows or Linux).

> 
>>> I see this is ThinkPad Thunderbolt 4 Dock so probably Intel hardware? You
>>> say you can reproduce this too so can you send me full dmesg with
>>> thunderbolt dynamic debugging enabled? I would like to understand this bit
>>> more deeper before we add any workarounds.
>>>
>>>> Reported-by: Richard Hughes <hughsient@gmail.com>
>>>> Closes: https://github.com/fwupd/fwupd/issues/8200
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>    drivers/thunderbolt/retimer.c | 17 ++++++++++++++---
>>>>    1 file changed, 14 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
>>>> index 89d2919d0193e..7be435aee7217 100644
>>>> --- a/drivers/thunderbolt/retimer.c
>>>> +++ b/drivers/thunderbolt/retimer.c
>>>> @@ -321,9 +321,7 @@ static ssize_t nvm_version_show(struct device *dev,
>>>>    	if (!mutex_trylock(&rt->tb->lock))
>>>>    		return restart_syscall();
>>>> -	if (!rt->nvm)
>>>> -		ret = -EAGAIN;
> 
> This is actually here because it might take some time for the NVM to be
> available after the upgrade so changing this may cause issues on its own.
> 
> Instead we should check first the
> 
> 	rt->no_nvm_upgrade
> 
> and return -EOPNOTSUPP which I believe fwupd handles?
> 

Well I don't think it's right to export the sysfs file in the first 
place if we "know" it's not going to work.  That's disingenuous to software.

How about looking for rt->no_nvm_upgrade in the new retimer_is_visible?

I think it should get the same intent and not break this retry logic.

>>>> -	else if (rt->no_nvm_upgrade)
>>>> +	if (rt->no_nvm_upgrade)
>>>>    		ret = -EOPNOTSUPP;
>>>>    	else
>>>>    		ret = sysfs_emit(buf, "%x.%x\n", rt->nvm->major, rt->nvm->minor);
>>>> @@ -342,6 +340,18 @@ static ssize_t vendor_show(struct device *dev, struct device_attribute *attr,
>>>>    }
>>>>    static DEVICE_ATTR_RO(vendor);
>>>> +static umode_t retimer_is_visible(struct kobject *kobj,
>>>> +				      struct attribute *attr, int n)
>>>> +{
>>>> +	struct device *dev = kobj_to_dev(kobj);
>>>> +	struct tb_retimer *rt = tb_to_retimer(dev);
>>>> +
>>>> +	if (!rt->nvm)
>>>> +		return 0;
>>>> +	return attr->mode;
>>>> +
>>>> +}
>>
>> I just noticed I had a spurious newline here.  If we end up taking this
>> patch would you mind just fixing it up?  If there is other feedback I'll fix
>> it on a v2.
>>
>>>> +
>>>>    static struct attribute *retimer_attrs[] = {
>>>>    	&dev_attr_device.attr,
>>>>    	&dev_attr_nvm_authenticate.attr,
>>>> @@ -351,6 +361,7 @@ static struct attribute *retimer_attrs[] = {
>>>>    };
>>>>    static const struct attribute_group retimer_group = {
>>>> +	.is_visible = retimer_is_visible,
>>>>    	.attrs = retimer_attrs,
>>>>    };
>>>> -- 
>>>> 2.43.0


