Return-Path: <linux-kernel+bounces-439633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9B59EB209
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3619216A195
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD84E1A9B5B;
	Tue, 10 Dec 2024 13:37:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D26C23DEB6;
	Tue, 10 Dec 2024 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733837869; cv=none; b=NI9y33SkXEIiDSFV79dWx97iLtPPdTpNBUlUAnTz3ZWGmXZLBPhb6Fgn8lfYSOrS9wdWuhIdfyFztPO30/w9zuXPw2Rb+Rb71pKYZ+fHBKj+ZZsfuERLaQpRku5as4/nYHo/tDXYDvR2CFV2K4Cnsp3LD62XjMw7RsUGrlRbW3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733837869; c=relaxed/simple;
	bh=47XtYOyeaYzt/dyCgYM4l4WCQopsc4ZteTTTSNWrYbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IyJ23dDG5YSa+gCNKV2QJXM0QGS6T873g8fGlKiNBaXDWTiovxJFK9xZWdeSA43NZkbVdu+Vg06RU6Ry3u8Hm2Ta0+yFxU80vUIlh8Tl6Y20GKCQcUHtOsnJG2npkePGB+RlQfRUICSUOpYxh9VzzTzWci1Jv0gPC7FSnyOiTP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EA04106F;
	Tue, 10 Dec 2024 05:38:14 -0800 (PST)
Received: from [10.57.91.204] (unknown [10.57.91.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6D203F58B;
	Tue, 10 Dec 2024 05:37:44 -0800 (PST)
Message-ID: <df82b514-e2f7-4edb-b5f3-b91dcb37563a@arm.com>
Date: Tue, 10 Dec 2024 13:37:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] of: property: Implement
 of_fwnode_property_present() by of_property_present()
To: Zijun Hu <zijun_hu@icloud.com>, Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Stephen Boyd <stephen.boyd@linaro.org>, Maxime Ripard <mripard@kernel.org>,
 Grant Likely <grant.likely@secretlab.ca>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com>
 <20241206-of_core_fix-v1-9-dc28ed56bec3@quicinc.com>
 <CAL_JsqJvh5pddoVEgaKQvGth0ncgtC9AAGxMEiK__NiZKrjmxA@mail.gmail.com>
 <dc989762-d868-44ff-968c-6d7be19e41cf@icloud.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <dc989762-d868-44ff-968c-6d7be19e41cf@icloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-12-10 12:44 pm, Zijun Hu wrote:
> On 2024/12/10 00:48, Rob Herring wrote:
>> On Thu, Dec 5, 2024 at 6:54 PM Zijun Hu <zijun_hu@icloud.com> wrote:
>>>
>>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>>
>>> of_property_read_bool() is deprecated for non-boolean property, but
>>> of_fwnode_property_present() still uses it.
>>>
>>> Fix by using of_property_present() instead of of_property_read_bool().
>>
>> of_property_present() just calls of_property_read_bool(). For now. I'm
>> working on making using of_property_read_bool() on non-boolean a
>> warning. No point in this change until that happens.
>>
> 
> what about below idea?
> 
> replace all of_property_read_bool() usages with of_property_present()
> then remove the former.

No, the whole reason of_property_present() was added in the first place 
is because reading the effective "value" of a boolean property is a 
semantically different operation from checking whether a property of any 
type exists. Therefore (ab)using a single function for both purposes, 
whichever way round, is not an ideal API design. The fact that they both 
happen to share the same implementation at the moment is, as Rob says, 
not something we want to be tied to forever.

Thanks,
Robin.

