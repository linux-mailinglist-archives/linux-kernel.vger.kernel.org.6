Return-Path: <linux-kernel+bounces-333440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D15A297C8A0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 13:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F8C1F267DE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 11:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1616119D897;
	Thu, 19 Sep 2024 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDFjTjTy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BA619D083
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 11:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726745294; cv=none; b=GBvxAWKCGc/hEKuqJcsocWp8pI8u0qK4+kt5TVyROc2wjkL05UhyN5KbiGHRKUnkxbx8tIGRhze2TW9vWik2F1KsG8f/pOIXh8tBdyIEFfHO/fE2TKrEcuzOdvjrAkkg4B6qmVhIaztGxXuZptvBjrWZsFHdA6YaSt8+WLtzURs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726745294; c=relaxed/simple;
	bh=7E/aKuA10vsrgIoeRITsYMjgG8AfcFZ6JbLGuuiwGj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A7gnfKfw1kHNZYKABa2L7OQnf0ZE6axXboQ2z0Rkc4Z/CSWJePF6ZjkLC3j5wW6tTJUPB6r6x3SC+WTQ0spdew2ZA47jpTscnWTTQ2Mw2Q4b9IcLcQkTqzprGU7LXptniAZrJtU9VxdTtbsR6d+Vw/3qnOc+AWajzuz1C+7TzlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UDFjTjTy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726745291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RxU24VtiUEKEFJ7Y05B5EkL0g7nR51AqwbBlViZYyMs=;
	b=UDFjTjTy7yWUM5Spf7FzCtVlOjL9WZTo/m1hztSBBTA1kyhFf0dYbecxqYkoMdF5S7vMxC
	Qh/wFVcyVKmnsL0ITQ5ZTecBfrhU/Upomuh3mhcbaw/pCN8D3VB9e7Mi4Mdcok9SBcqrRL
	lfXZJf5owsAzS0nMqv8AzbEyyWcu2iE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-OLW5ehlnNfWrKx-DNEKzww-1; Thu,
 19 Sep 2024 07:28:08 -0400
X-MC-Unique: OLW5ehlnNfWrKx-DNEKzww-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E6DC1956080;
	Thu, 19 Sep 2024 11:28:06 +0000 (UTC)
Received: from [10.2.16.55] (unknown [10.2.16.55])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 11B4E19560AF;
	Thu, 19 Sep 2024 11:28:01 +0000 (UTC)
Message-ID: <9836c30e-4ee1-485a-83f2-b38630dd7c21@redhat.com>
Date: Thu, 19 Sep 2024 07:28:00 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] locking/osq_lock: The numa-aware lock memory prepare,
 assign and cleanup.
To: yongli-os <yongli-oc@zhaoxin.com>, peterz@infradead.org,
 mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc: linux-kernel@vger.kernel.org, yongli@zhaoxin.com, louisqi@zhaoxin.com,
 cobechen@zhaoxin.com, jiangbowang@zhaoxin.com
References: <20240914085327.32912-1-yongli-oc@zhaoxin.com>
 <20240914085327.32912-5-yongli-oc@zhaoxin.com>
 <5045fb8b-4968-4b5a-9d9e-1def94308426@redhat.com>
 <1d9b40ac-f5d8-4242-bb12-92b7a50a3d05@zhaoxin.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <1d9b40ac-f5d8-4242-bb12-92b7a50a3d05@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


On 9/19/24 05:41, yongli-os wrote:
> BTW, your patch series lacks performance data to justify the addition of
>
>> quite a lot of complexity to the core locking code. We are unlikely to
>> take this without sufficient justification.
>>
> In the cover letter,  these is performance test result for AMD EPYC 
> 7551 and
>
> Zhaoxin KH40000. I listed the perf epoll, locktorture mutex, unixbench 
> and fxmark.
>
> What test do you think is important for the Lock performance?
>
> I will do more test in next submission.

Ah, I was not sent to/cc on the cover-letter. I only got your patches 
1-4. Yes, you did sent out a cover letter with some performance numbers 
after checking the LKML list. I will take a closer look at these 
performance numbers later as I am attending the LPC conference this week.

Cheers,
Longman


