Return-Path: <linux-kernel+bounces-323673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B724974192
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4923A1C2531A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1286F1A2643;
	Tue, 10 Sep 2024 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XIPGWa+7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C1618E021
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725991486; cv=none; b=iLSWL/lqJq6BhcsOePxwAypAVZE/ZeuUDuVaSTPcA7oM1FaasUW3AM/QtU/fF84lCKBbMswQJqzBax0+Y0cGLOVvUlsjQ3jGWvHvoVrrfRa+uye1l3MwBPRjA6JnvlKvli4ayxKVueArfiTKvB1OjIJT6qR3QwY2+iGq2qqC7fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725991486; c=relaxed/simple;
	bh=HYe07ZI0K2corIEE4WIobz5cXTg4mN0CKDb1wmIlZjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6+AbkapndP5muJm0GMQy92m1vgwRv/Ocp8QRAgHzu9w/rPLWxU20LUNcROBpHtpW5ULFPcvtpXp1cZ0jOUmJKvRZM1Gna0MfShKF2nIAqtx4OZXmrOqMwT+6VrFzr7yERFGY0H7znr147J4X5xH6oevQiq+x+qwfriuzoYduO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XIPGWa+7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725991482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SgFCGQQl2VecdC+Jvla3KbqveaEYaUuYKtpAVRVPDA=;
	b=XIPGWa+716GYl4mMBVTmiboRNvBPt07UryJkKp6XBTrtBmRSuDKvvq9gXljHZkPoiFYChn
	WD2Hrddi1oeKSy3StbhwCwR/oLk92sDuCYpzqeadUtlVCmd0gb28wcnU+M9m7NPhr+Fjb/
	wf03pdqh96gmRL/cCBz/B97mx4nxHsU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-nTuHkCJ6PRaUmu_ZwblGSw-1; Tue,
 10 Sep 2024 14:04:41 -0400
X-MC-Unique: nTuHkCJ6PRaUmu_ZwblGSw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F402519560B5;
	Tue, 10 Sep 2024 18:04:38 +0000 (UTC)
Received: from [10.2.16.251] (unknown [10.2.16.251])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B362119560AD;
	Tue, 10 Sep 2024 18:04:36 +0000 (UTC)
Message-ID: <7efd55de-51a8-4ffa-88c2-d8c94b1fb2bd@redhat.com>
Date: Tue, 10 Sep 2024 14:04:35 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/rwsem: Move is_rwsem_reader_owned() and
 rwsem_owner() under CONFIG_DEBUG_RWSEMS
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
References: <20240909182905.161156-1-longman@redhat.com>
 <ZuAAOmjTGYEFQJPC@smile.fi.intel.com> <ZuAAbi7hRWz2DUte@smile.fi.intel.com>
 <5142d007-dc8b-4eea-b708-4ec2df08f90a@redhat.com>
 <ZuBtZuK9mJCwdvO1@smile.fi.intel.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZuBtZuK9mJCwdvO1@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40


On 9/10/24 12:01, Andy Shevchenko wrote:
> On Tue, Sep 10, 2024 at 11:47:17AM -0400, Waiman Long wrote:
>> On 9/10/24 04:16, Andy Shevchenko wrote:
>>> On Tue, Sep 10, 2024 at 11:15:54AM +0300, Andy Shevchenko wrote:
>>>> On Mon, Sep 09, 2024 at 02:29:05PM -0400, Waiman Long wrote:
>>>>> Both is_rwsem_reader_owned() and rwsem_owner() are currently only used when
>>>>> CONFIG_DEBUG_RWSEMS is defined. This causes a compilation error with clang
>>>>> when `make W=1` and CONFIG_WERROR=y:
>>>>>
>>>>> kernel/locking/rwsem.c:187:20: error: unused function 'is_rwsem_reader_owned' [-Werror,-Wunused-function]
>>>>>     187 | static inline bool is_rwsem_reader_owned(struct rw_semaphore *sem)
>>>>>         |                    ^~~~~~~~~~~~~~~~~~~~~
>>>>> kernel/locking/rwsem.c:271:35: error: unused function 'rwsem_owner' [-Werror,-Wunused-function]
>>>>>     271 | static inline struct task_struct *rwsem_owner(struct rw_semaphore *sem)
>>>>>         |                                   ^~~~~~~~~~~
>>>>>
>>>>> Fix this by moving these two functions under the CONFIG_DEBUG_RWSEMS define.
>>>> At least this solves my issue,
>>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> ...and
>>>
>>> Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Thanks for the testing.
>>
>> No functional change is intended for this patch. Ingo & Peter, can this
>> patch lands in v6.12 or has to wait until v6.13?
> I see it already in PeterZ's tree.
>
Right. It is in PeterZ's tree. I didn't check his tree that often. 
Thanks for letting me know.

Cheers,
Longman


