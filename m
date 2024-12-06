Return-Path: <linux-kernel+bounces-434235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DCA9E6399
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 02:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1AEC16396A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39981A269;
	Fri,  6 Dec 2024 01:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PsBhvqBU"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9135C256E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 01:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733449872; cv=none; b=HO4dwCvRnhZo/f5boHf7H75vo4FAj3aQHKO7TUVEqmB4wERGNC6spTPp1Ofete3XA21m/FD7X9T6BB0Bu3n8a62DTfAKURNgxuEjfiKg7tTt48EhEJpE0L9Osp9L2tjPhbPIyG3iuzUwaswe5yvKDi29b3RnPWLq4PG3GXsHY/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733449872; c=relaxed/simple;
	bh=OoQC+gOrz0ZzNEn/2ka6vHAcdEioUhe+IJUUPVBkmac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YHJ9UiUWgMQIHOePEiFhViaIccG1OutdS0W3CegrzN7oN95rgv1xDekYjaO5cr7OcGwUBQU5BRH9k9GlqNhyzQ4prYtU5l6WWIbF2LDf3t6uLwp2/HHIaYf4uzxoQ9XhTLHVjuZq4lZrB+HtAPN3Byqoxp25qtbA50+TdUPJB18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PsBhvqBU; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=neLV3rQJjDnSmtGX79GKgoDMxbL/JOFzL0sHX7pN5Qk=; b=PsBhvqBU5fjWGtQNZ1wkBqaM7w
	nXhXBbZRhG074UOCAPdC0IbNYdLtftkFL7NqpK7a/ISZqqQ3X+tdRS/fD2Nrxn2SgLK060ipPYdPk
	oX1J8zp/midodO8jrWI2mCFoszi7va++YGib1wX1ivl4aQI0+T9X9AbPGtsFr08PFdkVWgnk7qysK
	pCAGH14wlhxnaHf1rwUxKn6Q0LzX9NM6REwhK5hHPYSMUYa8aJDu842SoEt8zgq4Xn2EIO6X4lahP
	x1NgQnFrjMi/3JPR3vwcxyfnVXUIQL68phgs+KVCagBRdP00ROQs3pD0O3VTq5JpqjfUqvbFFEruW
	mtxtkTDA==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tJNUP-00HDeX-0U; Fri, 06 Dec 2024 02:50:41 +0100
Message-ID: <9b6bff28-b5b3-435d-899b-5da8acaa9882@igalia.com>
Date: Fri, 6 Dec 2024 10:50:35 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] sched_ext: Manage the validity of scx_rq_clock
To: Tejun Heo <tj@kernel.org>
Cc: Changwoo Min <multics69@gmail.com>, void@manifault.com, mingo@redhat.com,
 peterz@infradead.org, kernel-dev@igalia.com, linux-kernel@vger.kernel.org
References: <20241203142802.36305-1-changwoo@igalia.com>
 <20241203142802.36305-3-changwoo@igalia.com>
 <Z0-TiGC5eUg4ZMWT@slm.duckdns.org>
 <ea78741a-09d6-42b6-b106-9fa5a54ed0fa@igalia.com>
 <Z1CjiYdeYMzxZNuo@slm.duckdns.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <Z1CjiYdeYMzxZNuo@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 24. 12. 5. 03:46, Tejun Heo wrote:
> Hello,
> 
> On Wed, Dec 04, 2024 at 10:42:13AM +0900, Changwoo Min wrote:
>> I investigated all sched_ext_ops. Besides these two ops, all the
>> rest are control operations, of which BPF operation should be
>> relatively simple. On the other hand, ops.running() and
>> ops.update_idle() are different from the others since a CPU
>> executes a task or becomes idle, which could be arbitrarily long.
>> So I think refreshing the clock in those cases would be nice.
>> Does it make sense to you?
> 
> Hmm... I'm not really following. Both ops.running() and ops.update_idle()
> are called during task switches with rq lock held. I don't see why they'd be
> any different in terms of expected runtime, which should be pretty short,
> compared to any other rq-locked operations.


Originally, what I wanted to say is the rq clock *after*
ops.running() and ops.update_idle() should be invalidated since
task running and idling could be arbitrarily long.

However, after double-checking the scheduler core again, I found
that such invalidations are redundant because anyway rq lock will
be released right after ops.running() and ops.update_idle().

I will remove two redundant invalidation in the next version.

Regards,
Changwoo Min

