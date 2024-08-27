Return-Path: <linux-kernel+bounces-303474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37365960C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D6F282682
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53351C3F2E;
	Tue, 27 Aug 2024 13:51:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA77F1C32E0
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724766690; cv=none; b=XCB5DesZ/UzPT8ru8HsnBM5rDAtfH8+kzw/c1AqAqz1hcj5bWLFk1gxOvGZM5+hEia/8wp0gQyvMnj7YS53dFv0mFwegQTKNSkz36PVD39YR9TBX7xXXDvZYAOUd0cXZeKIb8z5ZkTgNOoNooIWoo8KGSOb7OTZxFji30JUjWxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724766690; c=relaxed/simple;
	bh=wt5HQO5iRRzyUTY7v/SsXjDubkE5I9+37PKB/oPhHn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+9uUTPT6b0fyBqB3Smi+E5i95C6OCPFLxpWvtPI4yVpeFnCjaAHi4P13BUTBgrbFJQl9IKUWYUv6SuLgOe6hESkNVhqhXsuZZiugm5dkjbxnlRTU8r3Qa4q0QRK3T+7P+GXWLO+Iovl5OFqBgcmFo2q6IBQLKy4FjUHcLjCqeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4108DDA7;
	Tue, 27 Aug 2024 06:51:54 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D5EC3F66E;
	Tue, 27 Aug 2024 06:51:27 -0700 (PDT)
Message-ID: <eeb1eb1c-2e94-4110-a0ff-75efd0794c8e@arm.com>
Date: Tue, 27 Aug 2024 14:51:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] perf/arm-cmn: Refactor node ID handling. Again.
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: will@kernel.org, mark.rutland@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1723229941.git.robin.murphy@arm.com>
 <998064aa2bdb0e39f91b4f1fea2f428689978ea9.1723229941.git.robin.murphy@arm.com>
 <ab1b89c7-7bf-78d2-50ca-3411e511ec33@os.amperecomputing.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <ab1b89c7-7bf-78d2-50ca-3411e511ec33@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/08/2024 2:00 am, Ilkka Koskinen wrote:
[...]
>> static struct arm_cmn_node *arm_cmn_node_to_xp(const struct arm_cmn *cmn,
>>                            const struct arm_cmn_node *dn)
>> {
>> -    struct arm_cmn_nodeid nid = arm_cmn_nid(cmn, dn->id);
>> -    int xp_idx = cmn->mesh_x * nid.y + nid.x;
>> +    int id = dn->id >> (dn->portid_bits + dn->deviceid_bits);
>> +    int bits = arm_cmn_xyidbits(cmn);
>> +    int x = id > bits;
>                    ^^^
> 
> Instead of comparison, shouldn't that be bit shift?

Oh dear indeed... and of course the effects of that would only show up 
on hardware configurations I don't have. Good catch, thanks!

Cheers,
Robin.

