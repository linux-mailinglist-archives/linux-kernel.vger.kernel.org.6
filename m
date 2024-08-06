Return-Path: <linux-kernel+bounces-276449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732119493D9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46271C2153C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F841D61B3;
	Tue,  6 Aug 2024 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SfJFDIvX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B902718D655
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955986; cv=none; b=FsslzZOXVIL5t+d2F1ZxMd9kU7Qxbee9XnliBXwd1dUnZyB+iuK7WQ7QieKYUSmELkMdKRXR+w501PH3arYLodjxmK/Hg8hBMFB5HHhNsE2oCXlmsaw0vN6gu+WdfHm03TPrMzrmVcmPlo30BPBBuk572n/QXdUBflMS4fR62RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955986; c=relaxed/simple;
	bh=Nqo689t7LgKgBuMFfNk2N1oBq8U9vdikdPaK8ekHCNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HpimIcVqERkmFLZa26heXHNKRWqSD5e5DYmOrcJW49fwLgIRr6RPEPUHM451Ow3E2kV3IlkZWhdtZiIfBZKbHvM9HC5jt2FFalfvw8+LSomd4c1GkM6208BP2YBSEBuTV3r26JP9uvzHrk3ti9osY+fotbe7I6suqfcCd4OBkkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SfJFDIvX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722955983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kw/gJMf5zY8eaBAGFwMXFDAn70FBRPyDWNFLg3x3Xm0=;
	b=SfJFDIvX69/nDb8MeU5gi6ke0oPNJDdOR8xmFtSze6Uc+GvQHTa24u36V+ywk+guNkl8uW
	Se7LEpl8guNHcxrZrr0c7xJYwXM3GJ2UHJ5W//9KTUGqUVMWo1SaY76epR5wxxrXH1rFRB
	2d/8nSl1aTCjaaK6vzdATwrNzV+kZo8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-gtB0QFl5Nqu--xTn1Ayd4w-1; Tue,
 06 Aug 2024 10:52:58 -0400
X-MC-Unique: gtB0QFl5Nqu--xTn1Ayd4w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 323E51955D59;
	Tue,  6 Aug 2024 14:52:55 +0000 (UTC)
Received: from [10.2.16.146] (unknown [10.2.16.146])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84F0D3001D85;
	Tue,  6 Aug 2024 14:52:53 +0000 (UTC)
Message-ID: <e378ac65-73cc-4829-b605-f164c67dc5ae@redhat.com>
Date: Tue, 6 Aug 2024 10:52:52 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] lockdep: clarify size for LOCKDEP_*_BITS configs
To: Carlos Llamas <cmllamas@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 kernel-team@android.com, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>
References: <20240806010128.402852-1-cmllamas@google.com>
 <20240806010128.402852-3-cmllamas@google.com>
 <218314e9-7c7c-490c-bb2e-9611243cade3@redhat.com>
 <ZrI3mFLUwDyEMRIB@google.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZrI3mFLUwDyEMRIB@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


On 8/6/24 10:47, Carlos Llamas wrote:
> On Mon, Aug 05, 2024 at 09:36:43PM -0400, Waiman Long wrote:
>> Many kernel developers understand that BITS refers to a size of 2^n. Besides
>> LOCKDEP, there are also many instances of such use in other kconfig entries.
>> It can be a bit odd to explicitly state that just for LOCKDEP.
>>
>> Cheers,
>> Longman
> Right, and similar to BITS there is SHIFT, which is also a common way to
> specify the 2^n values. I'd point out though, that it is also common to
> clarify the "power of two" explicitly. To name a few examples that are
> doing so: SECURITY_SELINUX_SIDTAB_HASH_BITS, NODES_SHIFT, CMA_ALIGNMENT,
> IP_VS_SH_TAB_BITS, LOG_BUF_SHIFT but there is more.
>
> Perhaps this is because the audience for these configs is not always a
> kernel developer?
>
> Anyway, this is pretty much a trivial patch to address Andrew's comment
> below. But let me know if you think I should drop it, it seems to me it
> can be helpful.
>
>    [...]
>    btw, the help text "Bitsize for MAX_LOCKDEP_CHAINS" is odd.  What's a
>    bitsize?  Maybe "bit shift count for..." or such.

I am not against this patch. Currently I am neutral. Let's see what 
Boqun think about it.

Cheers,
Longman


