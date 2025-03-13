Return-Path: <linux-kernel+bounces-560401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A673A6039E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB4917A93D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21951F417A;
	Thu, 13 Mar 2025 21:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0uU/XC/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8DA3A8D2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 21:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741902395; cv=none; b=VCsb5/aHXvyj0K6uAREX3JcnxalBjinaCESuimGEizMr0a7Zt/sQyb86X4XUKw8wFXgcjiwWk/p0B4qLu1bfg5ojV32piRjB5QvpXh92c+BBDaE4VEQ9xlbGQIr6SXT76jlYAMtBQ4kvRpe6p4J18Kl0z124ZNUKZLBSsd9o464=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741902395; c=relaxed/simple;
	bh=M4mhfs2GBioW5lVR2ZXKDAMdgwvxbEUESoYbNfVZyHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZN9BOp/Y3PyLok8WjbJkLzbKs+VprLgcpOrItzJ27xbtPVtYlGAWEZ9H8i7u1zgK+yDx1VpjmabW0Az0hlyYlie83MEwC9pUT5N5qO/w1+z4BZnFW4d4A7LQKgLzSpF3mozbpp1C4jlZrsy9Uq+GggOJaERPZkqABUoAvtI37dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H0uU/XC/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741902392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tHS1SPZsy/hiD4YZfO5zi8XqrDds+QGmWBVIuyOLl44=;
	b=H0uU/XC/pwuKiP3uapf8OZIqOoupK4FtJmIXm3X3AJ/1uG/UdsdHlisCduo4NKLq7NtHkp
	7TBMsiFRIwSxcdw/8duYamx4KIEmHF+iE/XDrcZ1QycujkJw51HrlezGQPiXqg3QtJr+aF
	zYFZl3SGNz+1hAgogTjaSc2rd+jOYng=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-ES6rCyx8P0Cppipgprzl9w-1; Thu,
 13 Mar 2025 17:46:29 -0400
X-MC-Unique: ES6rCyx8P0Cppipgprzl9w-1
X-Mimecast-MFC-AGG-ID: ES6rCyx8P0Cppipgprzl9w_1741902388
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF82519560B7;
	Thu, 13 Mar 2025 21:46:27 +0000 (UTC)
Received: from [10.22.80.28] (unknown [10.22.80.28])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 53BCF1800944;
	Thu, 13 Mar 2025 21:46:26 +0000 (UTC)
Message-ID: <cd731f6e-c0e0-4ea7-9012-5860b0be2920@redhat.com>
Date: Thu, 13 Mar 2025 17:46:25 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nvme-multipath: add the NVME_MULTIPATH_PARAM config
 option
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, loberman@redhat.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 emilne@redhat.com, bgurney@redhat.com
References: <20250228032541.369804-1-jmeneghi@redhat.com>
 <20250228032541.369804-3-jmeneghi@redhat.com> <20250305143353.GB18526@lst.de>
 <03e7cc64-fafd-405e-a07a-4bc6d0e1d743@redhat.com>
 <20250312051958.GA11824@lst.de>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20250312051958.GA11824@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 3/12/25 1:19 AM, Christoph Hellwig wrote:
> On Tue, Mar 11, 2025 at 10:35:40PM -0400, John Meneghini wrote:
>>> What's the point of adding yet another confusing option?
>>
>> If you'll read the kConfig description, hopefully it's not confusing.
> 
> It still is.

OK. I can fix that.

>> The whole point of this patch series is to remove the core.nvme_mulipath parameter.
> 
> Why would a compile time option be preferable over a runtime one?

Because distos like RHEL don't allow customers to recompile their kernel. And including this runtime
switch in the kernel let's users turn nvme-multipath off w/out recompiling the kernel.

Our RHEL customers do this all of the time to enable DMMP with their NVMe devices. This has caused tremendous
confusion and turmoil with our RHEL customers who keep on turning nvme-multipath off even when we ship
RHEL with nvme-multipath on and we tell them turning it off is not supported.

I finally decided that there is no good way to control this situation w/out removing the
core.nvme_multipath parameter while CONFIG_NVME_MULTIPATH is enabled.

This patch enables distros like RHEL simply config out the parameter w/out impacting all of the people out
there who currently want and use the run time switch when CONFIG_NVME_MULTIPATH is enabled.

Please let me know what I need to do to make these patches less confusing and get them accepted upstream.

/John


