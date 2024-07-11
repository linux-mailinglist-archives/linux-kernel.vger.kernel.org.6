Return-Path: <linux-kernel+bounces-248652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F227392E03A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D18283781
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 06:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8152984E1E;
	Thu, 11 Jul 2024 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wJN6yJ8A"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC16A26ACC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 06:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720679589; cv=none; b=aPF/dSfgD7XcUKCFQjdvCZD9Xn8dlO/mzRvQgWU5EvK74K95NU4phJFVUtpzMCrr4CUs/Heg9LlvbKEVww3EAy5G52HY9nu0IzDrevN2gtAJZXzamcbS6tfc1UoLhTnd5bDlxrqnUy4zfn5moFK5UQSHfpeXiVP6j/WsexA2/NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720679589; c=relaxed/simple;
	bh=U7rbkxLcE1VU37ylwPRTqPUWauNWN2X+nQnsxjxpEG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wlemi9GqR5s1067TJnJW8zIEyoNsiAlIKVpWQPyYdn9mnUHINAMJ1hW5+S2o/6EeKiFHDLBeUoGw5U0oaM1TdnI+jaWVDAjiZgJUlgKDoJL+y/iNQgXTBYs5SSjrjZQQo2J0XFccFkIiD+gfVYTZX8uUNj0mBD4HTAWRq+UMmNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wJN6yJ8A; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: sfoon.kim@samsung.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720679583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VJHH7Wx3XHEyE7veqN7gpho4Y8N6hqLK1Tgti03sgZc=;
	b=wJN6yJ8AwEjQrHAMBxovjJH1aA524Y3x3n+HaUdWA/d2QCA2r4IyJuzh1uaOn41G3kjFOn
	0rnbU+7YZTa/ET7HKz+4D0it0QUcsjaupNVzZYBdtRqTnBpRmofirQMSbULP6Fc2kLOuRG
	383WD88G2+qApR6QLIHtoJHyDYWepFY=
X-Envelope-To: david@redhat.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: sungguk.na@samsung.com
X-Envelope-To: sw0312.kim@samsung.com
X-Envelope-To: sebuns@gmail.com
X-Envelope-To: akpm@linux-foundation.org
Message-ID: <727feddd-bc2d-4b70-aa0a-148b73a62948@linux.dev>
Date: Thu, 11 Jul 2024 14:32:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm: ksm: Consider the number of ksm_mm_slot in the
 general_profit calculation
To: Sung-hun Kim <sfoon.kim@samsung.com>,
 'David Hildenbrand' <david@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: sungguk.na@samsung.com, sw0312.kim@samsung.com, sebuns@gmail.com,
 akpm@linux-foundation.org
References: <CGME20240620043920epcas1p1b57dce789304aa96fd83e5b2b194d244@epcas1p1.samsung.com>
 <20240620043914.249768-1-sfoon.kim@samsung.com>
 <254bf3e0-0056-4593-94ee-8431a1bfc430@redhat.com>
 <0fe501dad351$ef692cb0$ce3b8610$@samsung.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <0fe501dad351$ef692cb0$ce3b8610$@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/7/11 13:19, Sung-hun Kim wrote:
> Hello,
> I'm sorry for late reply, because there was an issue in the mail system of my company.
> 
> In my humble opinion, this problem can be considered due to the objective of the value
> that can be gotten through general_profit.
> I think that there is no problem in getting the more accurate value through general_profit
> because it involves only negligible overhead due to the accounting of allocated metadata.
> Even the difference is small, it could affect the decision in the use of KSM on the
> memory-restricted device.

Seems reasonable, not sure how does it matters with a few more pages 
consumption in your case.

> Since KSM only wastes the CPU time to find identical pages if the gain is small, so more
> accurate information is needed to decide whether KSM is used or not.

Apart from the CPU time for scanning and merging, another important 
consideration is how dynamic changing of your merged pages, since it
has to CoW when fault on writing.

(And if you have swap enabled, KSM rmap can also bring some performance
affects, since it breaks CoW unconditionally.)

> Even though ksm_mm_slot and ksm_stable_node occupy few pages (or tens of pages), if KSM
> found small amount of pages_sharing, it can affect the gained profit.
> Because of that, I think that including other metadata in general_profit calculation is
> not a big problem if tracking such metadata causes negligible overhead.
> 
> It's my mistake in omitting the consideration of ksm_stable_node. The patch should include
> the calculation of the amount of ksm_stable_node.

FYI: I sent a patch that includes ksm_stable_node in general_profit some 
time ago. You can take it as you want:
https://lore.kernel.org/all/20240508-b4-ksm-counters-v1-4-e2a9b13f70c5@linux.dev/

Thanks.

