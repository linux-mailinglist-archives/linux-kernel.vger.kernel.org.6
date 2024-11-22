Return-Path: <linux-kernel+bounces-418625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275CA9D6390
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A735A160EB9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DF4224CC;
	Fri, 22 Nov 2024 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iistVGwY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C1013B58C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297785; cv=none; b=i/zL8SLgteipGR9jKsnG3rCEBtmOUePm2Z4cuiiFevXz1qr4sCQcUuZkALZSeihfWDG7EV7plBt+2XEt3pNQajcoVzsM0V9woOGuq82ZsVrrFldSOIdh21rYFosbqI5mIKIY9pd7wEGPNdXJO/J2xp+0c1zmjc5+kvxrSaRNDjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297785; c=relaxed/simple;
	bh=9fb++QsIqhxMf5E+bKzz5POyMwBNlVKDaxFQeLSVdtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5yaEuMG+DMVDMtxokyrvNRF26Cmwa2LAq/4cy3HDBUH3KlK3ORDBU5fk/U8tDsFMXz8AB4UmlES0kc+kx0AcIvujfzJ6zr1U7yo5AxPBJTQYt9MPnrV+3TbAdRifJ5w/p5VEonSFzdTmbGpwDNYQG8Dda93+XzwitTU2KpaaqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iistVGwY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732297782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GVwEH7NKOxp7HHL6S2AFq+acEA1lo3fGSvomSOmbcTI=;
	b=iistVGwYpctFnvfeaWH3fTVKPkbni3MbiVP0hUHL6gN7r2uiiUmMTbWnQHy69En/CsK/EZ
	VAaQX0ieAFY2ZmU8qJa7yetgIDqT+r5A0VXtQKEgrykVRx89h956N/hxwrl9vcqWDHIQz2
	HtKKq9yGGioMJp7gIw/I/pr6mLYY6EI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-nUFJHOxpOkKCm9DDV94noA-1; Fri,
 22 Nov 2024 12:49:38 -0500
X-MC-Unique: nUFJHOxpOkKCm9DDV94noA-1
X-Mimecast-MFC-AGG-ID: nUFJHOxpOkKCm9DDV94noA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 269E719560AA;
	Fri, 22 Nov 2024 17:49:37 +0000 (UTC)
Received: from [10.22.81.129] (unknown [10.22.81.129])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BD8D630000DF;
	Fri, 22 Nov 2024 17:49:33 +0000 (UTC)
Message-ID: <a6902168-0a8e-43ff-afef-b100f75d266c@redhat.com>
Date: Fri, 22 Nov 2024 12:49:32 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme: always enable multipath
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Bryan Gurney <bgurney@redhat.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, axboe@kernel.dk,
 mpe@ellerman.id.au, naveen@kernel.org, maddy@linux.ibm.com,
 kernel@xen0n.name, bmarzins@redhat.com
References: <20241121220321.40616-1-bgurney@redhat.com>
 <20241122120925.GA25817@lst.de>
 <Z0ClxgBJG_YBF-Ql@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <Z0ClxgBJG_YBF-Ql@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/22/24 10:39, Keith Busch wrote:
> On Fri, Nov 22, 2024 at 01:09:25PM +0100, Christoph Hellwig wrote:
>> On Thu, Nov 21, 2024 at 05:03:21PM -0500, Bryan Gurney wrote:
>>> Since device-mapper multipath will no longer be operating on NVMe
>>> devices, there is no longer a need to set CONFIG_NVME_MULTIPATH=n.
>>>
>>> Always enable NVMe multipath, remove CONFIG_NVME_MULTIPATH, and use
>>> the code paths that would be used if CONFIG_NVME_MULTIPATH=y.
>>
>> As mentioned last round not having to build the not tiny multipath
>> code for embedded systems and other small builds that never require
>> multipathing still seems like a sensible idea.
> 
> It's not just embedded either. I have plenty of single port datacenter
> PCIe NVMe's that claim multi-controller capabilities. I think it's some
> artifact of SRIOV that some versions of the firmware can bring.
> 
> Anyway, we only use the one physical function, so they're certainly not
> multipath devices here. We disable the CONFIG option because while the
> nvme multipath IO overhead is low, it's not zero.

So you're saying you want to keep CONFIG_NVME_MULTIPATH and simply remove the modparam nvme_core.multipath? (I know I said we 
were going to do that but that's before Bryan and I started testing his changes with blktests. I think we can fix that.)

The problem with this solution is: when you build a kernel with CONFIG_NVME_MULTIPATH=n you get exactly the same thing as 
CONFIG_NVME_MULTIPATH=y with nvme_core.multipath=n. You get a separate /dev/nvmeNN entry for every namespace/controller path, 
minus the multipath.c code.

So, I don't see the point. If you really want to stop supporting user space multi-path solutions like DMMP with nvme we need to 
stop creating multiple dev entries for multi-path controllers, no matter what.

Note that this multi-pathing stuff is a part of the confusion in UDEV, like I spoke about at ALPPS this year. One reason why the 
/dev/disk/by-path symlinks are so broken is because the kernel has at least three different ways to configure multi-pathing 
support for nvme devices.

We've been saying we're going to do this since since v5.18.

So how do we want to do this?

-
-		if (!multipath) {
-			dev_warn(ctrl->device,
-				"Found shared namespace %d, but multipathing not supported.\n",
-				info->nsid);
-			dev_warn_once(ctrl->device,
-				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
-		}

commit ce8d78616a6b637d1b763eb18e32045687a84305
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Mar 15 13:27:07 2022 +0100

     nvme: warn about shared namespaces without CONFIG_NVME_MULTIPATH

     Start warning about exposing a namespace as multiple block devices,
     and set a fixed deprecation release.

     Signed-off-by: Christoph Hellwig <hch@lst.de>
     Reviewed-by: Keith Busch <kbusch@kernel.org>

(master) > git name-rev --tags --name-only ce8d78616a6b637d1b763eb18e32045687a84305
nvme-5.18-2022-03-17^0


