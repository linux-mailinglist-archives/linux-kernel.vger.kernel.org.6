Return-Path: <linux-kernel+bounces-285463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED654950DC5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9993F1F237A6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6715B1A7042;
	Tue, 13 Aug 2024 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CcAg8nMo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C218187F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 20:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723580645; cv=none; b=VdNRGCflZjRLJzsBanym1YSP/+fHjjWN6iNO450L2BLCKJkxdN3OU7TQjtkOc6HPnXCQsMZpTaRCGZgxYDZdyZHitR9BGLOrfdHArTIAia4Gu3f3mdBUMMTnRxqZm0o21D8AaEe8dkWgwnwubja4fCUJGtajpO51zbs40MHrJk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723580645; c=relaxed/simple;
	bh=cKzROu2rsXWjPByX6omphwInN7w+SBFfbeXY9ytsO0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMZmLql/yxcSYc9Sm/er1fVMbEPkuzqxnZ5NxnaWoKYUsgfRgPNWJ2uP+Ljw2ADPoQ6SSn8mXnJlZ5NSril3e4mNolJWIIctblRPfDdxFGCPiQiuRvEa3WMe+kshXpgYprmwFGS7mrTPzGKxz63ZNMBd/4Tt+Me7WxqG/hOHMDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CcAg8nMo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723580643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cKzROu2rsXWjPByX6omphwInN7w+SBFfbeXY9ytsO0U=;
	b=CcAg8nMoy2FL0bDN+4VH2kRgdQx49J4AnNef+wyglEEHG2AuWLRzH1svDGnLYdSBEFZ8/Q
	iHqHHOfUxd5hffjYtO3PHj+MIqMeeAYSk89mItXDmN8ferq6ab7AlNbuUT4mcMSMX/IIkT
	awBMj4frdveNgeQeN8LgSL7GGI0YU8U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-8CRdScAAO8SUR37vuXI5pg-1; Tue,
 13 Aug 2024 16:23:59 -0400
X-MC-Unique: 8CRdScAAO8SUR37vuXI5pg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FC011956080;
	Tue, 13 Aug 2024 20:23:57 +0000 (UTC)
Received: from [10.2.16.208] (unknown [10.2.16.208])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C07F19560AA;
	Tue, 13 Aug 2024 20:23:54 +0000 (UTC)
Message-ID: <b770230f-7721-461b-a9f8-b482284c4a94@redhat.com>
Date: Tue, 13 Aug 2024 16:23:54 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] Avoid memory barrier in read_seqcount() through load
 acquire
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: cl@gentwo.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240813-seq_optimize-v1-1-84d57182e6a7@gentwo.org>
 <183ee6fa-1d42-4a01-8446-4f20942680d2@redhat.com>
 <CAHk-=whgwpzsn9XvZt3zRgP87r4mSScD04P_g5JeiR1irN3vRA@mail.gmail.com>
 <5d54a189-3c2b-440a-9626-4e00e95a7f77@redhat.com>
 <CAHk-=why9gTVRPHwbyz-24QSmKW1zXrF_pbS-UtDyQddyzEu9A@mail.gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CAHk-=why9gTVRPHwbyz-24QSmKW1zXrF_pbS-UtDyQddyzEu9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


On 8/13/24 16:01, Linus Torvalds wrote:
> On Tue, 13 Aug 2024 at 12:58, Waiman Long <longman@redhat.com> wrote:
>> Sorry for the confusion. What you said above is actually the reason that
>> I ask this question. In the same way, smp_rmb()/wmb() is available for
>> all arches. I am actually asking if it should be a flag that indicates
>> the arch's preference to use acquire/release over rmb/wmb.
> I think that if an arch says it has native acquire/release, we should
> basically assume that it's the better model.
>
> I mean, we could certainly use "PREFERS" instead of "HAS", but is
> there any real reason to do that?
>
> Do we suddenly expect that people would make a CPU that has native
> acquire/release, and it would somehow then prefer a full read barrier?

ARCH_HAS_ACQUIRE_RELEASE is fine, but the help text for this Kconfig option should clarify this preference as both the ARCH_HAS_ACQUIRE_RELEASE and the !ARCH_HAS_ACQUIRE_RELEASE code are valid.

Cheers,
Longman


