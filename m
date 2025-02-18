Return-Path: <linux-kernel+bounces-520618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71963A3AC55
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 00:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2EB175680
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 23:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2031D63EF;
	Tue, 18 Feb 2025 23:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUI0K/j7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A592862B7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 23:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919976; cv=none; b=kh6NflqDxfaLZt6ee/wIPSXXMMdhy/a3qLIcE9CIOmTjfo/onnHi+8Fisky6HmCiXsuFa98hBfkEBWn2jGIc1SZ0GhpImpxTx6ZnaoTgf6qQpaP/YLz/bKrF0Mbk0xlBHqYJUXmSLaAYbIBuUXus8PR+rUuDcrTlKxV3yqpoB1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919976; c=relaxed/simple;
	bh=HIBrD9px7WJYxJXgOj/5KWYxNLodgWlGkpEONOLdN9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNkgPb+W9hfGhHZsD7JXuFVPKM/t2uGz3dplmCen2WLqiTUuDodspiTUSueXPWAppDWzIx7Mq7v8znP1GpPlHep+2QuAvHPHgY2CbZP7gVG/Vd86LSz0DHh8dPyGQHznITYH8qlrAqICjUJ0mt6zIegu/ZHyuJ17VSx5D8bUQA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PUI0K/j7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739919974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQizAtyudSg2VONquWG4yvx/pUzf9ud3Ib65veJ3B1s=;
	b=PUI0K/j7A+M2Sc02i0ld2W+Jkf+0np68X62AdROQTPoeAx4+pwZN85m6xuorizRrIHIy5S
	W6gJz63lfShWwJCeT48yuELo+bKUoLdPMIyjCshmdTg2xp/o4nYpJhqn8+zdj9rbwa70OU
	fX9QSk3m/fa1sph/WNDbye5PZqi1qNU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-SFbXYeMYNXChmxdV8F5fXw-1; Tue,
 18 Feb 2025 18:06:10 -0500
X-MC-Unique: SFbXYeMYNXChmxdV8F5fXw-1
X-Mimecast-MFC-AGG-ID: SFbXYeMYNXChmxdV8F5fXw_1739919969
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1011318EB2C6;
	Tue, 18 Feb 2025 23:06:09 +0000 (UTC)
Received: from [10.22.65.116] (unknown [10.22.65.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 41ACE30001A6;
	Tue, 18 Feb 2025 23:06:06 +0000 (UTC)
Message-ID: <9495391f-eb31-4da5-95bf-e5f8eaafee38@redhat.com>
Date: Tue, 18 Feb 2025 18:06:05 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, bmarzins@redhat.com,
 Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
 axboe@kernel.dk, Randy Jennings <randyj@purestorage.com>
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
 <Z7Sh-3yHbXVmRbNL@kbusch-mbp>
 <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com>
 <Z7TARX-tFY3mnuU7@kbusch-mbp>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <Z7TARX-tFY3mnuU7@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 2/18/25 12:15 PM, Keith Busch wrote:
> On Tue, Feb 18, 2025 at 11:31:58AM -0500, John Meneghini wrote:
>> On 2/18/25 10:06 AM, Keith Busch wrote:
>>> On Thu, Feb 13, 2025 at 03:37:28PM -0500, John Meneghini wrote:
>>>> Keith, Christoph and Sagi,
>>>>
>>>> This patch has been fully tested and analyzed by Red Hat's QA group and no
>>>> unexpected side effects or regressions have been found. Both NVMe/FC and NVMe/TCP
>>>> have been tested. Our QE engineer has asked me to report this upstream.
>>>
>>> What's the harm in leaving the parameter? *I* use it so I can test both
>>> ways without needing to compile multiple kernels.
>>
>> LOL.  We've been talking about this since 2017. The goal has always been to remove support for DMMP with NVMe.
> 
> I understand that disabling nvme native mp it is required for device
> mapper, and I get you want to prevent the possibility of anyone using
> dm-mp with nvme, but that isn't the only user that wants to see all
> namespace paths.

OK, maybe you have a use case in mind. I'll assume you do: some
applications want to disable native nvme multipathing and to see
all namespace paths in user space, and they are using this parameter
to do it. These are ostensibly user space MP applications.

So what happens when one of these user space MP applications needs
a change or a bug bug fix in the kernel?  Are those patches being
merged into the kernel under a different auspices... is it just
DMMP that we don't want to enable support for?
    >> We want to remove this parameter because it is causing confusion with users and customers who keep trying to use
>> DMMP with their multipath NVMe devices.
>>
>> We want to remove this parameter because:
>>
>> 1) the upstream kernel does not support multipath nvme devices without CONFIG_NVME_MULTIPATH enabled
> 
> What do you mean by "support"? I assume you mean no one upstream will
> help you debug your problems if you've set yourself up that way, and
> that's probably true. The kernel currently doesn't stop you from doing
> this though, so it's supported in that sense. Some people are fine doing
> this on their own, they're not seeking upstream help. Changing this
What I mean by "no support" is: Red Hat has proposed multiple patches that were needed
to support core.nvme_multipath=N with DMMP. Those patches have all been NAKed because
"we don't support anything but native nvme multipath with NVMe".

And we are perfectly capable of debugging and supporting all of this w/out any upstream
help. The fact is we had to patch nvme/host/core.c and multipath.c to support DMMP with
nvme.core_multipath=N, and we've carried those out-of-tree patches in RHEL for almost 6
years because they were NAKed upstream.

> would break userspace because it makes the driver fail to create device
> nodes that used to show up.

User space has already been broken. I think we crossed that bridge long ago. Long before
multipath.c was implemented people were using user space MP applications (like DMMP) to support
nvme devices with multiple paths. We took that away as a supported feature a long time ago.

The reason I am saying this is because Red Hat wants to support DMMP with NVMe. We have many customers
who are very upset and unhappy that we are taking this away. Red Hat would much rather use DMMP
with NVMe, than not, and we have been working diligently to close the feature gap between native
nvme multipath and DMMP multipath (e.g. the queue-depth patches).

>> 2) the upstream kernel does not support multipath nvme devices when core.nvme_multipath is set to N
>> 3) Non-multipath nvme devies are supported just fine with core.nvme_multipath is set to Y
>>
>> You don't need set core.nvme_multipath to N to test your devices both ways w/o recompiling the kernel.
>> All of the code paths involved here are controlled by NVME_CTRL_CMIC_MULTI_CTRL and setting core.nvme_multipath
>> to N doesn't do anything to help your single path NVMe devices. It doesn't remove multipath.c, reduce the code
>> path length or do anything else to optimize your non-NVME_CTRL_CMIC_MULTI_CTRL devices.  All it does is provide
>> an escape hatch to disable the incore multipath scheduler start creating multiple /dev/nvme%d/n%d entries so
>> that DMMP can be used with multipath capable NVMe devices.
>>
>> Personally, I'd like to remove CONFIG_NVME_MULTIPATH as well. It's just another source of confusion. Most users
>> are running Linux with the the default settings for NVME_MULTIPATH. This is what Red Hat customers use and that's
>> what's used upstream.  So what's the point?
> 
> There are devices that report CMIC and NMIC despite being single path,
> perhaps as some vestigial sr-iov feature. That adds an unnecessary layer
> for all IO to go through. Having the param makes it easy to test both
> possible driver paths. In production though, I'd expect to just disable
> the CONFIG option if that's the behavior someoone wants, so I think the
> config option ought to stay.

I get it... that's fine... I have no problem if we want to keep support for CONFIG_NVME_MULTIPATH=N.
That's what we originally agreed to and it was my mistake to send a patch the tried to remove it.

As it turns out, user space MP may be supportable with both CONFIG_NVME_MULTIPATH on or off.

Maybe we should just remove all of these dev_warnings from the code and let the users do what
they want. That's what they are going to do anyways. Just don't tell me we won't take patches
to support my user space MP application and not yours.

I am not trying to be a jerk here. Seriously. It's just that our duplicity about this subject
upstream is a little too much. We have these configurable options and parameters... if we don't
want to support them all then let's take them out. People who want continued support for user
space MP with core.nvme_multipath=N can take *this patch* out of their own out-of-tree repository.

This all comes down to who gets to carry the out-of-tree patch. If you don't want to take this patch,
then please take our DMMP multipath support patches. They are not big or invasive, they haven't
changed in years, and they are all controlled by core.nvme_multipath=N. My customers will thank
you if you do.

I just need the upstream maintainers to make up their mind. This is a change we've talked about
for years. I thought you'd want this change. I thought this would be a final end of the
"only native nvme multipath is supported" debate.

/John


