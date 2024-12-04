Return-Path: <linux-kernel+bounces-430423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B549E30C2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535D916400F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A600944F;
	Wed,  4 Dec 2024 01:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OZE7XoPY"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221744C8F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 01:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733275738; cv=none; b=m4HgnTqN5lUPsPmzrJg1OO9um/+j3HaDOtO7sg66Q6hwj8YoEsCnGMU7J9KDEXW9JrA8WWfSUC/PaAJLL/DhxGB1hVgIwUB/3cbT5pld1oZZbFx1+nZkFdFMRStbuS/3ERWkZy498DJ5Sb3xwCh0i9var2yZF5Fp5p/JRYkaWBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733275738; c=relaxed/simple;
	bh=c5gxksJxTzBBWxJgkNTyO5SymFjrOsgsg8QEUJeRaJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bv0tO5hrijNsBHLyMImGTAgt4uqDR8Aws5Ib4UDuysbPC1CquzUwkn5ntid2ZuLPbONz0m+3+6WjyNer8qTGOan5vTwqyQmQxaAwF8JW9qPRRKu7jLdoGxUIjSPfJdBjCiVNiMKuJOZDENEx7mKyFK8hUMSoRQV0eeEDGlE8PG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OZE7XoPY; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AmUIqiI2M/tQXMvBiDNVB58dDvwacpQ7qi0yse8EQpE=; b=OZE7XoPYhvMG5391ZSbkyUmpZu
	VGBvdYCCy8YVSvuHaJs2SLWhO+eGsuvHRC1IqXHS5CTtPlFCkGmc7cdxuY/Ucs134rjBah+zyM/gb
	YEECK6bGCFKsRFKfd3PZA2AOp9j/K3AjCXPYWPCFYG46YZPqCWrKp9idJ4oNzCmwOSBf5o9/98Erq
	Yr8ifWRpY7bcJBV1P2MroSeoEaA7Fx3PGly2UU1GMWSzVSmC+OVp9g0owZMgYOZJLrYa2bmwLeEBe
	zN3RIzzP0zTgu/mHhe3Xh6urjDxB5sPVMKSkJVEENHBrBWJOOSTRLtyWQQ9+jgcIWwOxr9M3Dbr+0
	NA2NKV1w==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tIeBo-00GHiQ-Ou; Wed, 04 Dec 2024 02:28:29 +0100
Message-ID: <853dc59e-d83d-49ea-8a2e-1f519234ec0a@igalia.com>
Date: Wed, 4 Dec 2024 10:28:23 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] sched_ext: Implement scx_rq_clock_update/stale()
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, mingo@redhat.com, peterz@infradead.org,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org
References: <20241203142802.36305-1-changwoo@igalia.com>
 <20241203142802.36305-2-changwoo@igalia.com>
 <Z0-S2vvHF0kiEKHi@slm.duckdns.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <Z0-S2vvHF0kiEKHi@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 24. 12. 4. 08:23, Tejun Heo wrote:
> Hello,
> 
> On Tue, Dec 03, 2024 at 11:27:58PM +0900, Changwoo Min wrote:
> ...
>> @@ -2505,19 +2538,6 @@ extern const struct sched_class rt_sched_class;
>>   extern const struct sched_class fair_sched_class;
>>   extern const struct sched_class idle_sched_class;
>>   
>> -#ifdef CONFIG_SCHED_CLASS_EXT
>> -extern const struct sched_class ext_sched_class;
>> -
>> -DECLARE_STATIC_KEY_FALSE(__scx_ops_enabled);	/* SCX BPF scheduler loaded */
>> -DECLARE_STATIC_KEY_FALSE(__scx_switched_all);	/* all fair class tasks on SCX */
>> -
>> -#define scx_enabled()		static_branch_unlikely(&__scx_ops_enabled)
>> -#define scx_switched_all()	static_branch_unlikely(&__scx_switched_all)
>> -#else /* !CONFIG_SCHED_CLASS_EXT */
>> -#define scx_enabled()		false
>> -#define scx_switched_all()	false
>> -#endif /* !CONFIG_SCHED_CLASS_EXT */
> 
> Can you please separate out code relocations into a separate patch? Here,
> it's on the smaller side but patches are difficult to read when they're
> mixed up.

Thanks for the comment! I will separate the code relocation out
in the next version.

Regards,
Changwoo Min

