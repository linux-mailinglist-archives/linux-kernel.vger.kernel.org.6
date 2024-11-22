Return-Path: <linux-kernel+bounces-418306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388909D602B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5AD6B22F33
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1C82E40B;
	Fri, 22 Nov 2024 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUR/0TP5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DE5182D2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732284631; cv=none; b=EwzgDY4cgWBVgJecwWU6UhW5Kaj9BvqSiyrm5V2s1IiPMTsDWaNsnD1aN47r3gFRawMpFc1HRrV/AShRbH3xP1hTDFM9ginZh4FUrJcJdhClOSJ6f6mJzY9W4O5ITQFtupwxua3GqGsHOl/bkB4n2fTufk6BehyTRcF+3lkGd0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732284631; c=relaxed/simple;
	bh=SOPR0W+Fo1w/OFVtrjfKYGSHcnjhLgraMD5Xwu9ZsO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDa78AF3/NB0qH/2tQBYbWbTuwc4GB1B25yfV62QhsIT/vuABsDrmTQyRqDHuiFQQ6Xhs4si1zmGQE9u4b4XpFJ4k/foGFmzwQLDKrcHF9+vx0Dk8z3Ssm4nkU3es6S7WZQTJyETs5OBSBZE+0CagLnhx3elDPzIW7IyxQb7lSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUR/0TP5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732284629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFXk9mqkVM9P4jO5qIAEBl+vinIgn7s7A2Iirsp1WlM=;
	b=XUR/0TP5m7rIOhEA4DCbIwEU+GTnC8dP9iYOuEml3qEV4o4UvG+/x51iVz3CfsJQHd+mR+
	nHl7rTKpdkVV5bqoqczMTf02MBBfOqjdLzZ+2ADjCHg4uiL1AGyMN4R6ucN/JOrfSM+8px
	X6MIgHtWn/c3m2rNavvqSLMjsahh3o4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-_hXRCg6-PfGqEPLgdA5rnA-1; Fri,
 22 Nov 2024 09:10:26 -0500
X-MC-Unique: _hXRCg6-PfGqEPLgdA5rnA-1
X-Mimecast-MFC-AGG-ID: _hXRCg6-PfGqEPLgdA5rnA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B9631955F41;
	Fri, 22 Nov 2024 14:10:23 +0000 (UTC)
Received: from [10.22.81.129] (unknown [10.22.81.129])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AC41B195E481;
	Fri, 22 Nov 2024 14:10:19 +0000 (UTC)
Message-ID: <a9c1329a-c5b3-4807-8536-810b45f0c6ef@redhat.com>
Date: Fri, 22 Nov 2024 09:10:18 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme: always enable multipath
To: Nilay Shroff <nilay@linux.ibm.com>, Bryan Gurney <bgurney@redhat.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
 mpe@ellerman.id.au, naveen@kernel.org, maddy@linux.ibm.com, kernel@xen0n.name
Cc: bmarzins@redhat.com
References: <20241121220321.40616-1-bgurney@redhat.com>
 <5bbfcfe6-6e7f-437c-9c0e-cb80578b0c87@linux.ibm.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <5bbfcfe6-6e7f-437c-9c0e-cb80578b0c87@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 11/22/24 01:26, Nilay Shroff wrote:
>  
> On 11/22/24 03:33, Bryan Gurney wrote:
> 
> I applied the above changes to my kernel tree and ran the below blktests:
> 
> # ./check nvme/033 nvme/034 nvme/035 nvme/036 nvme/037 nvme/039
> nvme/033 => nvme0n1 (tr=loop) (create and connect to an NVMeOF target with a passthru controller) [not run]
>      /dev/nvme0n1 is a NVMe multipath device
> nvme/034 => nvme0n1 (tr=loop) (run data verification fio job on an NVMeOF passthru controller) [not run]
>      /dev/nvme0n1 is a NVMe multipath device
> nvme/035 => nvme0n1 (tr=loop) (run mkfs and data verification fio job on an NVMeOF passthru controller) [not run]
>      /dev/nvme0n1 is a NVMe multipath device
> nvme/036 => nvme0n1 (tr=loop) (test NVMe reset command on an NVMeOF target with a passthru controller) [not run]
>      /dev/nvme0n1 is a NVMe multipath device
> nvme/037 => nvme0n1 (tr=loop) (test deletion of NVMeOF passthru controllers immediately after setup) [not run]
>      /dev/nvme0n1 is a NVMe multipath device
> nvme/039 => nvme0n1 (test error logging)                     [not run]
>      /dev/nvme0n1 is a NVMe multipath device
> 
> As we can see here, the above tests were skipped because the test detects
> that the device (/dev/nvme0n1) is a multipath device. However, in fact,
> the test device is NOT a multipath. So I think we need to update the above
> tests. We may submit another patch to blktest and update above tests once
> your changes are merged upstream.

Nilay, what kind of device is /dev/nvme0n1 ?

Can you show us the output of

nvme id-ctrl /dev/nvme0 -H
nvme id-ns /dev/nvme0n1 -H

Thanks,

/John

> Otherwise, changes look good to me:
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> 


