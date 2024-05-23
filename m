Return-Path: <linux-kernel+bounces-187592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 366DA8CD4FA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B951C21607
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F3814A4FF;
	Thu, 23 May 2024 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/uPAAe8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9656D13B7BC
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716471766; cv=none; b=HrHJWtgJlUioG5fdLeLSjo4DjsPiAJFGvBJh7RTbsYETRCMqoXknt9jPe+afaS/AMpruqFtel/R7bJr7NeWD0SxljvFa5aCcHF5PoFFpHlAz423sGu+pWRJcdo4EDmBSwhbJRwv5sdjhLqPFTV/fczs82hsg8J/p2MrPo5Fj910=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716471766; c=relaxed/simple;
	bh=z6wVFsjjscl3k4EzCgG7KUwdsYsl9hOldzdujFC3OJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mOS1qQzO7RFjcnsCvsmuM9UmtQuTPlTx7n2vJmnmzUUJaCwq4oe6dOsQWdvkkOBwxPdIaPYs2aWFTCWLEwSX0mzOkpTl1BhKOs1AznhZa2c3pWyT7Kd+ZMrQJ6HN5w+vICPqlK3a3lUAvLPVnUp6IjwQwEmuCpFPXBr2e4xdfOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/uPAAe8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716471763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=afci6CJ76Zp6xoepc357nE1IL04qiOxBOsa2LoqZWNY=;
	b=d/uPAAe8doUvWK2E13JDk8cmBssbX3AFNZ2OpzopemxpZ4Ccu8XY/XqxhO8LyWjUyhEAwN
	nsmYYLN3hQvVVAVY/To5AXFJT9DUF0T8dNGN+LeUmKSLXLO3c/kb2fQQzGHpm71k3FYh/K
	QYDO3RqsWD5uysbHZQ61a7goSy3vuLs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157--11Nvb4yOCmLIs3x9nbQrw-1; Thu, 23 May 2024 09:42:40 -0400
X-MC-Unique: -11Nvb4yOCmLIs3x9nbQrw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD12A101A54F;
	Thu, 23 May 2024 13:42:39 +0000 (UTC)
Received: from [10.18.25.182] (unknown [10.18.25.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6531828E2;
	Thu, 23 May 2024 13:42:39 +0000 (UTC)
Message-ID: <4d90d565-c156-4e4c-8a16-f32aa73fc809@redhat.com>
Date: Thu, 23 May 2024 09:42:39 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni
 <chaitanyak@nvidia.com>, "emilne@redhat.com" <emilne@redhat.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jrani@purestorage.com" <jrani@purestorage.com>,
 "randyj@purestorage.com" <randyj@purestorage.com>,
 "hare@kernel.org" <hare@kernel.org>
References: <20240522165406.702362-1-jmeneghi@redhat.com>
 <935f7e10-ccb4-4891-8f29-84909c061e7a@nvidia.com>
 <60758e4d-4bdc-4a99-a151-a9009a8a460f@suse.de>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <60758e4d-4bdc-4a99-a151-a9009a8a460f@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5


On 5/23/24 02:28, Hannes Reinecke wrote:
> As presented at LSF by Daniel; ALUA support (and, with that, multipath 
> support) is one of the topics to be implemented for blktests.
> And without that we can't have a meaningful QD test.

So as a part of this patch you want a blktest that verifies queue-depth multipathing?

Or are your just tying acceptance of this patch to a blktest that tests multipath testing over all?

Seems to me you have a patch designed to do that...

https://github.com/osandov/blktests/pull/114

/John


