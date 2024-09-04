Return-Path: <linux-kernel+bounces-315344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEBF96C151
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC5A2885EB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD90B1DC05F;
	Wed,  4 Sep 2024 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5LOAMP6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3231CCEFC
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461668; cv=none; b=e8ALucOntLjM/wL0XaWJc6awQgdRKvvpgSrAGdlQXE0s9EVvdtxmruy/7ui6/RHQEgdsqjj2aphiQe5sNHzeuPE6BHAjmDWjJk+V4uDzyvBC+WuHtYGej9i9KzIILCy8fypeFriApt2U8llSMt9a/0zBTV9c1tcG92c+Ih9vEFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461668; c=relaxed/simple;
	bh=7qiN97hVkQnNvIWujJuk3T+deCQsX2cLnXGUKZuTy3A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PQ2RNLKOh9iG5JASXOlSIEjEP8+PTuXxa3r+Yt7KPtCTGRbQPOFXW5it3DqUEHCsFDl15vPTZ2V9oGq9Fjk565c8lgUWJDYdre86jHIqJLYwoJVswJ3yop4Ti1VUDmuTDBESNRkDn1x94ZARLH59hPQenIcdWm6Ecj/YWYVyuiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5LOAMP6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725461665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SQioePzHbc4zCNwAEd5SaXL8JFT6VPyvAyI6FpYjL+A=;
	b=G5LOAMP6CHcoDqtKIY+oPIAOfNb1PGiCuzPGBA6LyZU6tsoa+Q/d5m99VFvWNOUKtf+BRL
	l3mYA93k1Wdf8DjTnFCxaybPderNe3bnjnMQ8c6hwHHssUwK66HCwvD26/IbkHT9QUbDd8
	XaEbAajeAHX6SKdiBJQXs7hlE85zznc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-3eL8pwgyN-OwTYamD_fauQ-1; Wed,
 04 Sep 2024 10:54:20 -0400
X-MC-Unique: 3eL8pwgyN-OwTYamD_fauQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F3DB1955F3C;
	Wed,  4 Sep 2024 14:54:18 +0000 (UTC)
Received: from [10.2.16.172] (unknown [10.2.16.172])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F372B1956094;
	Wed,  4 Sep 2024 14:54:15 +0000 (UTC)
Message-ID: <70e5a6f3-1cff-46c9-af34-75664961eae2@redhat.com>
Date: Wed, 4 Sep 2024 10:54:15 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] sched/fair: Use HK_TYPE_SCHED housekeeping CPUs
From: Waiman Long <longman@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20240818234520.90186-1-longman@redhat.com>
 <20240818234520.90186-3-longman@redhat.com>
 <ZtcLUcJvqSV3vXd2@localhost.localdomain>
 <d43165ae-9124-4034-b816-d09c9a48ecec@redhat.com>
Content-Language: en-US
In-Reply-To: <d43165ae-9124-4034-b816-d09c9a48ecec@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


On 9/3/24 09:53, Waiman Long wrote:
>
> On 9/3/24 09:12, Frederic Weisbecker wrote:
>> Le Sun, Aug 18, 2024 at 07:45:19PM -0400, Waiman Long a écrit :
>>> As the previous commit has enabled the setting of HK_TYPE_SCHED
>>> housekeeping CPUs in nohz_full setup, we can now use the more aptly
>>> named HK_TYPE_SCHED housekeeping CPUs instead of HK_TYPE_MISC.
>>>
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>> Can we instead merge HK_FLAG_TICK, HK_FLAG_WQ, HK_FLAG_TIMER, 
>> HK_FLAG_RCU,
>> HK_FLAG_MISC and HK_FLAG_KTHREAD into a single
>> HK_FLAG_KERNEL_NOISE / HK_TYPE_KERNEL_NOISE ?
>
> Sure. I am open to new name as I am not good on that. 
> HK_FLAG_KERNEL_NOISE does make sense.

I can't merge HK_FLAG_TICK just yet as it can be independently set by 
using isolcpus which can set just HK_TYPE_TICK, HK_TYPE_DOMAIN or 
HK_TYPE_MANAGED_IRQ. That is the reason why they are still separate.

Cheers,
Longman



