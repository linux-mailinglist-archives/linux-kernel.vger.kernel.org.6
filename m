Return-Path: <linux-kernel+bounces-238163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC8392459A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6FFE288654
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB39E1BE224;
	Tue,  2 Jul 2024 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UO7sTUaZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4B215218A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941071; cv=none; b=k44MOAoXRANk+0valM3bWJBjqiX3hKm3rmt2Wqvj8V3oyTSPB0Fbn0U6k565azCWQHlAC05ZCssMeyAaT4sQIz+1Bq/9WtHHzFGISuXrGiST/zO0TYrgBALFB9hONi1tBDczJh5muJS7xGXvWBcEXYG88yC/53yYBWWSU2Y0euM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941071; c=relaxed/simple;
	bh=pg8eJ9cvgpW3yEy6ea0W94pA6aMSOnMScRUd7CCQto8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZ7TZJepSEYOQKzXLq+1w3SYuqhe8UZxJ2qv6x52ey1HiFqjzY+jgCquQJh98pBwXr9aqlZs2WT2zfEH/gks2YlVk+yuMdYvJg96ElLrLxCZRtR2I15E6o90ZuU/ooR2GqdAF8dUkSzkV1FGKO3CYTyNMbyKKF6ZpensFM05ZP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UO7sTUaZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719941068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YsaGzLcaGrNY0FCyZH8E6bIbu8nMTOjkMKH2kiReAHQ=;
	b=UO7sTUaZHCf9NVp7la6/NYtle4STqRXjLcXGunammnvHQOi1AtVW+AsGeEPXeCixySgeCA
	VWq0q68/ttU+a+dUdsrW7C7qgJYy4Nfk+8tskx+DD4TvlpT+LcFnVmTg9qeU8gFVzh0dh2
	vX78ELk9RmAvUG80aNpHX6VAvWAuIDw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-8ijT-T92PQmejz5kHgQXWQ-1; Tue,
 02 Jul 2024 13:24:27 -0400
X-MC-Unique: 8ijT-T92PQmejz5kHgQXWQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB0B91977323;
	Tue,  2 Jul 2024 17:24:25 +0000 (UTC)
Received: from [10.22.9.99] (unknown [10.22.9.99])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A61BC19560AA;
	Tue,  2 Jul 2024 17:24:24 +0000 (UTC)
Message-ID: <a11610cd-3276-4145-b474-b823bf2abe49@redhat.com>
Date: Tue, 2 Jul 2024 13:24:23 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] workqueue: Simple fix and cleanup for exclusive
 cpumasks
To: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>, Tejun Heo <tj@kernel.org>
References: <20240702041456.629328-1-jiangshanlai@gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240702041456.629328-1-jiangshanlai@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 7/2/24 00:14, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>
> Simple fix and cleanup for the commit fe28f631fa94("workqueue:
> Add workqueue_unbound_exclude_cpumask() to exclude CPUs from
> wq_unbound_cpumask")
>
> Lai Jiangshan (2):
>    workqueue: Update cpumasks after only applying it successfully
>    workqueue: Simplify goto statement
>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
>
>   kernel/workqueue.c | 21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)
>
Thanks for the improvements.

For the series,

Acked-by: Waiman Long <longman@redhat.com>


