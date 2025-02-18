Return-Path: <linux-kernel+bounces-519862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 608D0A3A2E2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715863AD3B5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AEF26E650;
	Tue, 18 Feb 2025 16:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cbmr0gRz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F4813B7B3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739896328; cv=none; b=Kl0cUMke0BncAfAw8TvxI4x6wtx2+uli2QEh0erFCDnCtf6gDEB9U2C03Z4yd2EttjnEHWLDjJsOd9eEqf36azwWonmSRtmKZp0U//ZKK83aTvOvp3ArB8/CtCg/VQ+awJpZ8EA4v42u3LbXU7sDF6ckizZZ+QAb8v/PKEpi6xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739896328; c=relaxed/simple;
	bh=8fZ2YwL4zE2wGh4mEXK1Q0dnsmYxS1QtjyJ51GvGl4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gc7g0SklCjTphjVSQ/Bl503ZHdeeV/D7t/tWfYnKaruliDPQDrbHzD3yYOO1YZ6hu/2DPut7BhAliXz4l6nS9Y90VDNbedyFGc/tk0nA/qw9H91VrR2UgsJGVvylsLhn6qS8IyrOLycs8XwskCQ4zNploq12cGNVcseYM6UhE9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cbmr0gRz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739896326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lgPlVGhbeqEzlRphlfwN5cVytTh9XFzZGkmtCQbZrNA=;
	b=Cbmr0gRzgRQ36aeyyQipl6gbQA62xKSMy9N5wKSt/mjIotzKpnYf4IWefkpjyYioAa2aoW
	FAZ6Z1zfz7HCWpIywez4oKKzGYI3CoP5BuFfAsG2E3l690w+gXcP7LFRmcDD9TBXljs5Hp
	b4vnFJeVc28MZew/fhNbYqEZ9RwU4NU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-8N3Sl7dUMi-SBs_8SYx8qw-1; Tue,
 18 Feb 2025 11:32:02 -0500
X-MC-Unique: 8N3Sl7dUMi-SBs_8SYx8qw-1
X-Mimecast-MFC-AGG-ID: 8N3Sl7dUMi-SBs_8SYx8qw_1739896321
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E5641800995;
	Tue, 18 Feb 2025 16:32:01 +0000 (UTC)
Received: from [10.22.65.116] (unknown [10.22.65.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2AF6219560A3;
	Tue, 18 Feb 2025 16:31:58 +0000 (UTC)
Message-ID: <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com>
Date: Tue, 18 Feb 2025 11:31:58 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, bmarzins@redhat.com,
 Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
 axboe@kernel.dk
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
 <Z7Sh-3yHbXVmRbNL@kbusch-mbp>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <Z7Sh-3yHbXVmRbNL@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 2/18/25 10:06 AM, Keith Busch wrote:
> On Thu, Feb 13, 2025 at 03:37:28PM -0500, John Meneghini wrote:
>> Keith, Christoph and Sagi,
>>
>> This patch has been fully tested and analyzed by Red Hat's QA group and no
>> unexpected side effects or regressions have been found. Both NVMe/FC and NVMe/TCP
>> have been tested. Our QE engineer has asked me to report this upstream.
> 
> What's the harm in leaving the parameter? *I* use it so I can test both
> ways without needing to compile multiple kernels.

LOL.  We've been talking about this since 2017. The goal has always been to remove support for DMMP with NVMe.

We want to remove this parameter because it is causing confusion with users and customers who keep trying to use
DMMP with their multipath NVMe devices.

We want to remove this parameter because:

1) the upstream kernel does not support multipath nvme devices without CONFIG_NVME_MULTIPATH enabled
2) the upstream kernel does not support multipath nvme devices when core.nvme_multipath is set to N
3) Non-multipath nvme devies are supported just fine with core.nvme_multipath is set to Y

You don't need set core.nvme_multipath to N to test your devices both ways w/o recompiling the kernel.
All of the code paths involved here are controlled by NVME_CTRL_CMIC_MULTI_CTRL and setting core.nvme_multipath
to N doesn't do anything to help your single path NVMe devices. It doesn't remove multipath.c, reduce the code
path length or do anything else to optimize your non-NVME_CTRL_CMIC_MULTI_CTRL devices.  All it does is provide
an escape hatch to disable the incore multipath scheduler start creating multiple /dev/nvme%d/n%d entries so
that DMMP can be used with multipath capable NVMe devices.

Personally, I'd like to remove CONFIG_NVME_MULTIPATH as well. It's just another source of confusion. Most users
are running Linux with the the default settings for NVME_MULTIPATH. This is what Red Hat customers use and that's
what's used upstream.  So what's the point?

/John



