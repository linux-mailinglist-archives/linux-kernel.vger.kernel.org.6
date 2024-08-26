Return-Path: <linux-kernel+bounces-302113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF05995F9F0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69571284679
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00DD132121;
	Mon, 26 Aug 2024 19:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OF+SCS3v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5596D12C80F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724701641; cv=none; b=YMBnbq73CJAB9E0xUuRV+ZjRXdfQsr2DJcIZmZuvZAKX4Lnpz2BfUfJ7ASZH0Cyzny/Pp4jKFgQEz7oQdYLuEcHL/7WPE/roUsOcBZ2uP7hURGmMM/htDDjEyv1sHYJtlZA51Z8BgadISPdI2o130Dthafmb9Bpvm+GZ1OQCAkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724701641; c=relaxed/simple;
	bh=k+9W/nw17jlBjjtfac2axE2lhU/IXbWLpg+gT0rR8JI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=spZ9fq+sL5gQmJZeMZR6KDinZlvi5Knb9lfM0/oMD5cbuN6Mucbkb/5GNMdAs7/D6GHq2rU0Ok9y+PYe6J/LQz5qvFVmjQDd1e6/jAB0hrD02dKztfNx78rMhceyZE6BlArPfMBwP3jp537dZBwMM0CkDtJg6yQc/FV5fOM+JH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OF+SCS3v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724701638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+qhWVNvkXNJ4Pj/gRvSvQxzHwZIu1ZYnGi5nOysGGjk=;
	b=OF+SCS3vmEPGKokMRsClp/U0/Gv4hraoYX4x1zsj6UnLiP1V9WY46VJKULJ2X3KnX1vZwJ
	123I2pS5NQiOwpgyoALv7cS1wnFj1jrYDD/3ZcaytmGVJAe0ZywnUXr+7Z8uhEP8TY5zY7
	MfHwg3QNn9Sg+b5LIsqqjBYCLPBjoyw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-hAwK9ZWPPzyDKeQ5KdUDlQ-1; Mon,
 26 Aug 2024 15:47:13 -0400
X-MC-Unique: hAwK9ZWPPzyDKeQ5KdUDlQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E3C81955BF4;
	Mon, 26 Aug 2024 19:47:09 +0000 (UTC)
Received: from [10.2.16.157] (unknown [10.2.16.157])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0862C300019C;
	Mon, 26 Aug 2024 19:47:06 +0000 (UTC)
Message-ID: <9793ce0d-842a-4876-860a-9b7b8d538e45@redhat.com>
Date: Mon, 26 Aug 2024 15:47:06 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next 09/11] cgroup/cpuset: move v1 interfaces to
 cpuset-v1.c
To: Tejun Heo <tj@kernel.org>
Cc: Chen Ridong <chenridong@huawei.com>, lizefan.x@bytedance.com,
 hannes@cmpxchg.org, adityakali@google.com, sergeh@kernel.org,
 mkoutny@suse.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 chenridong@huaweicloud.com
References: <20240826132703.558956-1-chenridong@huawei.com>
 <20240826132703.558956-10-chenridong@huawei.com>
 <eaef1faf-c3f3-4664-ae7d-5cca611925e4@redhat.com>
 <ZszaJFzcmBskojVS@slm.duckdns.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZszaJFzcmBskojVS@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


On 8/26/24 15:40, Tejun Heo wrote:
> On Mon, Aug 26, 2024 at 03:30:14PM -0400, Waiman Long wrote:
> ...
>> Another alternative is to include cpuset-v1.c directly into cpuset.c like
>>
>> #ifdef CONFIG_CPUSETS_V1
>> #include "cpuset-v1.c"
>> #else
>>     ....
>> #endif
>>
>> Then you don't need to change the names and will not need cpuset-internal.h.
>> It is up to you to decide what you want to do.
> FWIW, I'd prefer to have cpuset1_ prefixed functions declared in cpuset1.h
> or something rather than including .c file.

Sure. Let's have "cpuset1_" prefix if it is v1 specific and "cpuset_" 
prefix if it is used by both v1 and v2. That applies only to newly 
exposed names.

Cheers,
Longman


