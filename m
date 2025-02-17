Return-Path: <linux-kernel+bounces-518037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A48A388EF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3CB3A1BE4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65312224B08;
	Mon, 17 Feb 2025 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vo0mxhPD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428C62248A8
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739808896; cv=none; b=OKRpfA3MK3sZlBe9z4fbaq+1whcVNdXZ+xT571hHOKHHsTwWPvVSWn28SXXe+eAGixRVrfMYMhFT3nJ1ED2MwjL7+WR0F6wU9iWuiWvUPtMTXxOELF7d5C5c8oU3nwMQ/2iJvGe5tBqTB3wY86nX4oDpx1ElqN9LS6Al05aSIaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739808896; c=relaxed/simple;
	bh=M9DYsLsVT07CGT4hPobGI6G7FsS06XUOR06XNfwA+t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXnBdFP4tnOWQQXc1gEpZX2tST5sMlIh7gAKHXe2REXHBWzfFjzRcnnTRbKJhSlpZ987p0Rxuvp7I4W9+VRzV/DFLPsdDurIC6o0BrwHoVpLNVSxX4f3qzPGkeBoQP/T7UDlXRLlRTU2D+4kWzCLUh9LCPLtEPrFpq5poDu//aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vo0mxhPD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739808894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z6/+vP1Xpq+4H3W/cSS/0CX+mScp7vF8v6bogSAvR/s=;
	b=Vo0mxhPD5KXAlWncBrVCzeJJ07nxGeYcAWPSc3FglG7n+J43jYuYSn+jb9CUcSjjOFQnrn
	yeigLi5emC7dRn3lXe5xcleYbEEJWAZ8PvyZ7KyrgY2FiO5pxoASHRI2BciZ6mm2TIC9X4
	XHHsSh3K66sWJp9R80G0t2JZm4Yqutk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-SAEJScF1P7isgQ0EHNNT0g-1; Mon,
 17 Feb 2025 11:14:51 -0500
X-MC-Unique: SAEJScF1P7isgQ0EHNNT0g-1
X-Mimecast-MFC-AGG-ID: SAEJScF1P7isgQ0EHNNT0g_1739808889
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94E9F19783B5;
	Mon, 17 Feb 2025 16:14:48 +0000 (UTC)
Received: from [10.22.65.116] (unknown [10.22.65.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 20C561955BCB;
	Mon, 17 Feb 2025 16:14:44 +0000 (UTC)
Message-ID: <ea9537d5-721a-4b37-84d1-df797646fce2@redhat.com>
Date: Mon, 17 Feb 2025 11:14:44 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: Sagi Grimberg <sagi@grimberg.me>, kbusch@kernel.org, hch@lst.de
Cc: bmarzins@redhat.com, Bryan Gurney <bgurney@redhat.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Marco Patalano <mpatalan@redhat.com>, axboe@kernel.dk
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
 <ea0e6445-9770-4df9-91bd-80f44cd0388e@grimberg.me>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <ea0e6445-9770-4df9-91bd-80f44cd0388e@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


On 2/17/25 3:08 AM, Sagi Grimberg wrote:
>>
>> We plan to ship this patch with RHEL-10. So it would be really good if we could get this
>> change accepted and merged upstream, perhaps into v6.15.
> 
> Hey John,
> 
> This looks fine to me, I'm assuming this was also tested with CONFIG_NVME_MULTIPATH=n ?

Yes, everything has been tested with CONFIG_NVME_MULTIPATH both enabled (Y) and disabled (N).

As we discussed in the previous email thread[1] there is an anomaly seen when you build a kernel with CONFIG_NVME_MULTIPATH=n.
and the host discovers a multipath capable nvme device (CMIC/NMIC=1). You will see exactly the same thing that you do with
CONFIG_NVME_MULTIPATH=y when the nvme_core.multipath parameter is N. You see a separate /dev/nvmeNN entry for
every namespace/controller path.

We can send send a separate patch to address that problem, but this patch, which simply removes the nvme_core.multipath parameter
has beeen fully tested and is ready to go.

[1] https://lore.kernel.org/linux-nvme/58519c4e-5801-4481-9087-be4f19b218f7@redhat.com/

Please approve/merge this patch.

/John


