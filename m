Return-Path: <linux-kernel+bounces-539674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65149A4A733
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C17817073A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06255A923;
	Sat,  1 Mar 2025 00:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Av7Y55fq"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A24F23F379
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 00:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740790003; cv=none; b=mRAn3P4Cug++Z86tpsmsQ1jBnyrPRXvjLUcoxi8xCFVLFA25hgdFUHrzTB8/F3yNzhCrSvFlhe+RPN1pmNWt5ylqmEl+vgZrHhqwk1wJ00xYWa/C+bhkncUh62FBP/Y9zPkLljov+3ZmnTxmbG23c7T13cOQ/e1Kpg2tlTeD21A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740790003; c=relaxed/simple;
	bh=pk65AtbUTNKqbltqv+/SNRRJE2Z9gQlUxZRq+L9paM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OdDkgEuBKuV4wALpZH0OL41DmrA6DMCZ88gxx+zYSxj7OJxnyXwbmE7DEAol1KP8c41KaSPNcNY3U+zM9gUp9djNqjT3IgZsgnksEX/gv/+vb8TO1n4J5rUju5bd1sr3DJ01LoKWMubBrvyydzaPgZYOC9TKtqQdQ2HRK7dWuDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Av7Y55fq; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=06eEerUNQ87zy8PJuQn7SSDXVVXGI3HgHMuZidWzrqc=; b=Av7Y55fqfsOfhv2Dc+qg/07+Ly
	A9nNAWDVAqEaqTbyYUbNMFHTlWSpurDMB8zj1qkz3BV16P4hoqvWPWyeyjtonDpeiTpwGpfpSsK37
	+IT1W3WO6CdbcY2dCAzO0jmFBIP7cd2I7da3rFt8kvAva4gKM2YeB6HgVlWe1Q0S+JEBHy8jTCISO
	HnDrw6C6MwTXvTg30J1yz8y+TTksBy+eRE8Qzu0yLSUiltGl92aXyV71lqUedAp2qMx+aHGIC8Bnc
	x62siMvxfrpIJLLu20NJ2YVfsAA59WicatRDra1simgTLxrX6WKXHorOeXi3SVozwhDXjxfQE0O77
	UziIiiOA==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1toAzp-002Jx5-TB; Sat, 01 Mar 2025 01:46:32 +0100
Message-ID: <2c45f480-b693-4d22-ad7d-4a0bf523c0c5@igalia.com>
Date: Sat, 1 Mar 2025 09:46:25 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched_ext: Add trace point to track sched_ext core
 events
To: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>, void@manifault.com,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org
References: <20250228085944.19451-1-changwoo@igalia.com>
 <Z8GKCkWNVN_Pbcc0@gpd3> <Z8Hy6qu8shpYOR83@slm.duckdns.org>
 <86a6c5c7-47b7-49af-af57-b1d2171ba97c@igalia.com>
 <Z8JLzOBMGvvAtu54@slm.duckdns.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <Z8JLzOBMGvvAtu54@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25. 3. 1. 08:50, Tejun Heo wrote:
> Hello,
> 
> On Sat, Mar 01, 2025 at 08:33:36AM +0900, Changwoo Min wrote:
> ...
>> You might have two options here: 1) returning per-CPU event
>> counter or 2) returning aggregated event counter. The first opion
>> will be fast but less meaningful from user's point of view
>> compared to the second option. Assuming the tracepoint are not in
>> the hot path, I think the second option will be better choice.
>> I will add an @event field and a special version of
>> scx_bpf_events() for faster aggregation.
> 
> Ah, right, let's forget about printing aggregate for now. That's not
> difficult for anyone to find out if necessary after all.

Okay. I will send a new version with __s64 changes.

Thanks!

