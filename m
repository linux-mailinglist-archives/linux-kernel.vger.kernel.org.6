Return-Path: <linux-kernel+bounces-418675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 140E49D6430
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDAFC283647
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844101DFDA7;
	Fri, 22 Nov 2024 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yi5rbp++"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322E81DFD8B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732300209; cv=none; b=MQDm1VO1cmHrNXHRTHWSQD1uxNGudkOFtwC3TL2+GrO1PV+QRTIIIb+Gk1+UGCGpmcbBjrL8FvDgKHu4P1kKosGF1WvRcZh+pQOWBXHuknFlsUZIp+2rOSG88id4NuxocLlR9nJvMvX0zcSPLsb6VvT9HLRziloEngwqoLa7eFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732300209; c=relaxed/simple;
	bh=tCb2FiArNLzD6sMnrgCpgf+yjSBwAX3Q0VkzlfLHsQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mK7JmTELK4D8CW3nziGGz714W6PD5UVzz1ZOR2VoseVZpT3wgPb1SQ9N+S6eh/XQ5scGIvEYr0eZx5eOeTy9fgNfYHLUtiPiSGrAfQTbW/v0kg6zGX6uJO/oEUc0P6f6UdNZ7PFxVmNNubO6mCy8iEkGJXiyOheLemJQ0+QKaPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yi5rbp++; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732300207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QwKTTx7s6LOt9fOonERQ/U8O+1ezUV/XX92FI19YTLY=;
	b=Yi5rbp++z3rrliwdsI/Z4M2gOPebRwumoh17q3OBj26f5y16f8IVa+7l6sln58ZQ+9E/xu
	JPb9rDofW0wo6Uhh0zaLlXrs2a6H/g8qTZ3XzAl3XS5fJELQ340xh5UTWFWlv2wjuR7a34
	Y46ux/CL046D5JvoXPx00Shy0j3/4vs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-g5FeemTZM_WoU0ASHWgwjQ-1; Fri,
 22 Nov 2024 13:30:03 -0500
X-MC-Unique: g5FeemTZM_WoU0ASHWgwjQ-1
X-Mimecast-MFC-AGG-ID: g5FeemTZM_WoU0ASHWgwjQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB3AA1955E87;
	Fri, 22 Nov 2024 18:30:01 +0000 (UTC)
Received: from [10.22.81.129] (unknown [10.22.81.129])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E01D11955F3E;
	Fri, 22 Nov 2024 18:29:58 +0000 (UTC)
Message-ID: <58519c4e-5801-4481-9087-be4f19b218f7@redhat.com>
Date: Fri, 22 Nov 2024 13:29:57 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme: always enable multipath
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Bryan Gurney <bgurney@redhat.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, axboe@kernel.dk, mpe@ellerman.id.au, naveen@kernel.org,
 maddy@linux.ibm.com, kernel@xen0n.name, bmarzins@redhat.com
References: <20241121220321.40616-1-bgurney@redhat.com>
 <20241122120925.GA25817@lst.de>
 <Z0ClxgBJG_YBF-Ql@kbusch-mbp.dhcp.thefacebook.com>
 <a6902168-0a8e-43ff-afef-b100f75d266c@redhat.com>
 <Z0DKJWjtrpuy8j_V@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <Z0DKJWjtrpuy8j_V@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 11/22/24 13:15, Keith Busch wrote:> If you want to change the driver to prevent exposing subsequent
> namepsace path block devices when multipath is not enabled, that is
> probably fine.

OK, we'll work on another patch to do this. The plan will be:

When CONFIG_NVME_MULTIPATH=y, you get multipath.c and full support for both nvme multipath (CMIC/NMIC = 1) and non-multipath 
devices (CMIC/NMIC=0) devices with 1 /dev entry per namespace.

When CONFIG_NVME_MULTIPATH=n, you get support for non-multipath devices (CMIC/NMIC=0) devices, but multipath devices 
(CMIC/NMIC=1) will only expose the first controller/namespace path.

/John


