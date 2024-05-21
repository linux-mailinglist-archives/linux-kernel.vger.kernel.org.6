Return-Path: <linux-kernel+bounces-185110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84BF8CB09F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E97271C2103D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2765414291F;
	Tue, 21 May 2024 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UanXuMl4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097BC13D29F
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716302656; cv=none; b=FAUTAJAaruP4OfE+LW1uijWFmI95Ay3qCq7Howt5imgX6PJc/ALX1nnbTQYRwl3sS9HHel1dBCg6lucMXSTKGFpN5xRS4RzI9cOII7cIqinFpongb3LpKsHzx9EyfpXmjA58Jl6zwt8sOLEJYSYNnHYNvLj7PUlkwuzrM9rlyQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716302656; c=relaxed/simple;
	bh=IbiMENtJRUpAYj9BkGqABsQrjw2WB0RIdq7to/XUFO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8bCkEQfhz4hOyzqBy+f2v4ZDbA9Y3zLUToXQtQ1cL4O2nvue42OtojJ6IFNQfI+y+Pcxa6SE013veI3UN5h0tZWCBWtIi5bj9O9HgdIK8Eno+dXFNYA+Mm4ZrV6SufvpZ92pR41cBRn4aU4OLRbZNDNXMxYkOlVm7gEmFbFtfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UanXuMl4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716302654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZE79ngHiPYMsknTkJKUUOGKy5jq6C5Ns0sjPmwNKqk=;
	b=UanXuMl4J510wb/5rpQh0O1mZ4aIBHL1KkUX3YBd4bAZhPxfuyGrLXi+DVM+xFGQldaaHK
	0tVUuyeqge8+uwIoFXqSB+FGBDtIErMPM7XWKVtcjXG6UmoWWfpfB6kSkmj8g1BUjDZ3Fp
	4qfuNimYavhoJw1V9P+QIh3QlQKYu98=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-eIJdvIDPPYGPxIVEjg4jmQ-1; Tue,
 21 May 2024 10:44:10 -0400
X-MC-Unique: eIJdvIDPPYGPxIVEjg4jmQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45D4B3C0C2C4;
	Tue, 21 May 2024 14:44:09 +0000 (UTC)
Received: from [10.22.8.193] (unknown [10.22.8.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 409B31C008BB;
	Tue, 21 May 2024 14:44:08 +0000 (UTC)
Message-ID: <8f5ad047-be0b-471c-a708-f2bc464d29ef@redhat.com>
Date: Tue, 21 May 2024 10:44:07 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 kbusch@kernel.org, hch@lst.de, emilne@redhat.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240520202045.427110-1-jmeneghi@redhat.com>
 <20240520202045.427110-2-jmeneghi@redhat.com>
 <945416af-3f8b-40b5-9681-49973beb2cb2@linux.ibm.com>
 <3b8d33db-f2c3-469a-bfa0-8fc52594f243@grimberg.me>
 <95fe3168-ec39-4932-b9fc-26484de49191@linux.ibm.com>
 <da35bc8b-6813-42c8-b446-8a07b08db156@grimberg.me>
 <073ae18a-a80e-4a95-a093-36210a3bb230@grimberg.me>
 <ba2a6973-ba58-492c-9785-31e50ab40957@grimberg.me>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <ba2a6973-ba58-492c-9785-31e50ab40957@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 5/21/24 06:16, Sagi Grimberg wrote:
>>>
>>> Exactly, nvme_mpath_init_ctrl resets the counter.
>>
>> Except you're right, the counter reset needs to move to nvme_mpath_init_identify()
>> or some place that is called on every controller reset.
> 
> This however raises the question of how much failover/reset tests this patch has seen...

I has received quite a bit of testing with failover and controller resets.  I shared some of the testing that was done at LSFMM 
last week.

It has received enough testing to make me confident that this code is safe.  That is: it won't panic, corrupt data, or otherwise 
do any harm.  We believe the error paths will not be affected by this change... but I agree that running the error paths could 
negatively impact the accuracy of the nr_active counters... which could lead to an inaccurate outcome with the queue-depth policy.

I agree the nr_counter initialize should move to nvme_mpath_init_identify(), or maybe be done there in addition to in 
nvme_mpath_init_ctrl(). I'm will to make that change now... if that's what people want.  I don't think it would require any 
extensive retesting.

/John


