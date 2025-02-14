Return-Path: <linux-kernel+bounces-514488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F97A3579D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D953AC7A0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FF92054F9;
	Fri, 14 Feb 2025 07:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="djXu6Uhs"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77E62045AC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739516869; cv=none; b=dMeKLz2m0whD+FLrWPWf1fSH+zdrwdcWBENEjnufK63PTeHDhRxt7SIjvSx2YNonrHnu+o6VCkt4d5gLKDbTO0074WNc41hcEGc7zskahsU7KDJZoIHbwIZx0hcUqvPXdb7X4jSXXMaOZcuMsLArm87w/G5l8cv2RPrXB/JpJbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739516869; c=relaxed/simple;
	bh=xnv/dhD6Dg3zwN5q/aZMhKSDtKwxQekypPFpXYTWW0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTREAHwB8+tr1bRoI2H6ZnZd1blcssTatuFp6/EPsJnVwoyMUlg1Ax0KMC/mbX90w0xZNOZMC6fq7amP2pN6EBXWU2OjMoSxNpdi+8oF18kYru+VDJQBSVFJja6wSFGdsovaz8fVSgVdNDSTp9f6jqm8ikzvqwNtbpRHu6mXhio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=djXu6Uhs; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aD61O5fbnxUrRrrZkCpAN0fOF6pwVi4QWiJY1iYGdl8=; b=djXu6UhsGPZLhrVX3LfRHLYTDt
	wNv0o7wohnuW1JWexKbKgYude7Z+c5XNgsAVqv/lVoG3B5JgXuPeRcyRRQUdKBx832iEekVwPLGri
	3moRYmeJXQ54/iUk/JKyNBi1VT2zYD9s6HkmcBwIGhUb24jmcNVHZ0xN0oqTkpIZVw2AgD+K9V5pz
	o2rs/ILwC/MkvPpviUDvfjd5/zZ5gqTZtCPrsRpCEHPEdM9TKLHQN+6t6VYa7937scM/46wnkzYhP
	f1afwlN9/eYuv6AKO/LX+LO8DgNRoUx5+dTLIZAOJ6/w9EO62uw3jhmlQc8bm4PvdtoMZevrnm8z6
	vSC/NKCQ==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tipnQ-00Fldt-Lx; Fri, 14 Feb 2025 08:07:38 +0100
Message-ID: <357e2c84-7b60-4ad7-8511-a8415999174d@igalia.com>
Date: Fri, 14 Feb 2025 16:07:33 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched_ext: Provides a sysfs 'events' to expose core event
 counters
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, arighi@nvidia.com, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org
References: <20250210143643.220994-1-changwoo@igalia.com>
 <Z6o3WOGS5Pulha36@slm.duckdns.org>
 <8ce4d887-464c-4d4d-825d-0d01dcafe400@igalia.com>
 <Z64hrU6P67pUA5o9@slm.duckdns.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <Z64hrU6P67pUA5o9@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Tejun,


Thank you for the review!

On 25. 2. 14. 01:45, Tejun Heo wrote:
> Hello, sorry about the late reply.
> 
> On Tue, Feb 11, 2025 at 09:57:08AM +0900, Changwoo Min wrote:
>>> This probably should belong to the root/ subdir as we'd probably want to
>>> keep the event counter separate per scheduler instance in the
>>> multi-scheduler future.
>>
>> I feel this is a bit contradictory to the need to access the core
>> event counters even after an scx scheduler is unloaded. In the
>> current implementation, root/ subdir appears and disappears when
>> an scx scheduler is loaded and unloaded.
>>
>> We may change the scx_ktype to something similar to
>> scx_global_attr_group in order to keep root/ subdir. We then show
>> an empty file for root/ops when no scx scheduler is loaded while
>> keep the root/events file intact. I am not sure if this is what
>> we want.
>>
>> What do you think?
> 
> Hmm... I don't think we can keep the directory for counters of schedulers
> that have been unloaded. Looks like the right thing to do is giving up on
> the idea of being able to access the counters after the scheduler is
> unloaded. The counters are dumped on error exits, so hopefully this isn't
> too big a loss. What do you think?

Yes, dumping the event counters is a part of scx_dump_state().
I agree. That's a reasonable choice. I will move 'events' under
the root/ subdir and send out a new version.

Regards,
Changwoo Min

