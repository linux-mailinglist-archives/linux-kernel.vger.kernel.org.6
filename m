Return-Path: <linux-kernel+bounces-557200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6508A5D4DB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 04:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE733B4EEE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 03:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504FA1D5CCC;
	Wed, 12 Mar 2025 03:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="husD/r7k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA7D146A68
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741751279; cv=none; b=oKzNgwJ1AeupwzRG5tE0Ogw7opJCS5g7DPxfApuS374kvqXtU3xTLmyb0iX/mYZ05mhkkInapSBOEo/pn/0kHxzINY3753ZTqUPDljYQkLoAZd5VWIngvTc9NuwJCM+Ljct7MT/Dai3L1xREwjb7MqyrwlkBVAQYlndu9e5oN+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741751279; c=relaxed/simple;
	bh=YQ49OF7BDZHO47nIspBXTN0qZN/kcC0Qb/6b2WEN5PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jYTt8OrZMS5gDnm2WwiOCQbDj3ww+2elxS8Ht/Hd8ITT86tCsqU0QZ8P27mFsrltnMdRYCwBNrKbDllP1YeT19bwASzHLtZM195Qyg0uPKJxFEHqC5G6DbJ1HVYGYOTuRo2nfLP6IydZOSYpZ4j6l3eZdhouWKPgBnNJKRlhf20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=husD/r7k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741751276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/taELm4S5wjSnSK9zdR6jac90PyrwFhqo2me21EPLw=;
	b=husD/r7kP501ofn4VEC1syenvYjHEAwNhk4tBx2j0zF1Mw9Dx+m/lq2yWZlFDL3+UsHUbd
	vVixLfeGSH15AReSiqunpsyjjXifX8EwLOotDanIgO26vOuR1pDKzlOWb+j65fviB/2y/u
	9A9+8NZZ2EbnBy/SOnj54iyCFL8Cy3k=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-EVC0RFCHPdmtsG1Sx8ft4g-1; Tue,
 11 Mar 2025 23:47:55 -0400
X-MC-Unique: EVC0RFCHPdmtsG1Sx8ft4g-1
X-Mimecast-MFC-AGG-ID: EVC0RFCHPdmtsG1Sx8ft4g_1741751273
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F22071956087;
	Wed, 12 Mar 2025 03:47:52 +0000 (UTC)
Received: from [10.22.65.26] (unknown [10.22.65.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA7391955BCB;
	Wed, 12 Mar 2025 03:47:49 +0000 (UTC)
Message-ID: <01d799d1-fc93-4285-aa8f-89ac2d01478b@redhat.com>
Date: Tue, 11 Mar 2025 23:47:48 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, bmarzins@redhat.com,
 Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
 axboe@kernel.dk, Randy Jennings <randyj@purestorage.com>
References: <Z8hrJ5JVqi7TgFCn@kbusch-mbp> <20250305235119.GB896@lst.de>
 <Z8jk-D3EjEdyBIU5@kbusch-mbp> <20250306000348.GA1233@lst.de>
 <1ffebf60-5672-4cd0-bb5a-934376c16694@suse.de>
 <20250306141837.GA21353@lst.de> <Z8m4vzE36UHWjwep@kbusch-mbp>
 <20250306151654.GA22810@lst.de> <Z8pB9jQALxMN6WaA@kbusch-mbp>
 <b2c9df64-0afc-46cd-9e8d-6a3f41a4f1c7@linux.ibm.com>
 <Z8sUB2bbbMsurZmu@kbusch-mbp>
 <69cdaf9d-2fb4-4ee0-9c32-cc946405a23a@linux.ibm.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <69cdaf9d-2fb4-4ee0-9c32-cc946405a23a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 3/9/25 1:23 PM, Nilay Shroff wrote:
>> It honestly has potential to solve some real problems, like
>> re-enumeration triggered by a link reset on an in-use drive. You'd
>> currently need to close the old handle and open a new on, even though
>> it's the same device. It may not even be possible to do that if that
>> device contains your root partition, and then you can only power cycle.
>>
>> The downside is we wouldn't get the short cut to blk_mq_submit_bio. We'd
>> instead stack that atop an indirect call, so it's not free.
>>
> Yes agreed however it seems advantages of using an indirect call outweighs
> using the short cut to blk_mq_submit_bio. Moreover it seems the cost of
> indirect call is trivial because we already cache the nexthop.
> 
> I integrated your proposed patch (with few trivial additional changes on top)
> and I see that it's coming out nicely. I ran few tests and confirmed it's
> working well. However, in the proposed patch we*always* delay (~10 sec) the
Have you tested this with a NVMe-oF controller... yet?

Where did the number 10 seconds come from?

> removal of multipath head node. That means that even while removing the
> nvme module (rmmod nvme) or if user delete/detache the namespace, we delay
> the removal of head node but that may not be what we want. So I'd suggest
> instead, delayed removal of multipath head not shall be configurable using a
> sysfs attribute. With this attribute then we shall let user opt for pinning
> the head node (with optional delayed time as well?). And it's only when user

So be aware the TP-4129 is adding a CQT parameter which does almost exactly this.

> shows the intent to pin the node we should delay its removal. This is what
> exactly (pinning of head node) Christoph's proposed patch implements. So I'd
> suggest a bit of amalgamation of yours as well as Christoph patch to implement
> this change.

Please cc: me on your patches Nilay, I'd like to test them with my NVMe-oF testbed.

/John


