Return-Path: <linux-kernel+bounces-398015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 761EF9BE441
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E67F1F2356D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B886D1DDC39;
	Wed,  6 Nov 2024 10:28:52 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8DA18FDA5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730888932; cv=none; b=EX7Fvvzghf8Y1DFzjo4WLLfQb5C5zcHHmlnuF0EwaIwxBfmZMGB6ZNzd04a5CAI9uoQAc5NPvkXhDb++IyaSHKCJLHZV7fDjL4Wjos3WaDjef/HxlYSU7WW/Z/2XqMjnyn6w7eKH1C+2fvap+Q/45XRRLk9nldk2eC9wRMPPLBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730888932; c=relaxed/simple;
	bh=j0hbXdxofNea5wa6NqBIwSIaJlmvHNGm4+eJeN8hhW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zzbhe3GkFQxYNllY9tw2cMT3z6HbezBEJxdNAZuzsHxCbZdy+sWmSy3n2r9BxDl8uTM1MFNJGB/tgvHQ55/nlMK5u9aE+U4/gY7yCY9shvbAavRydjI8SVzx9LfOtPfV9StjNMiVkv+VmGSFd69GaFf+2h4HaJz3iEzbOwZgMGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xk19h0pNDz9v7J4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:08:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 114531404A8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:28:45 +0800 (CST)
Received: from [10.81.205.156] (unknown [10.81.205.156])
	by APP2 (Coremail) with SMTP id GxC2BwC3H3_PRCtnTiwhAQ--.38583S2;
	Wed, 06 Nov 2024 11:28:44 +0100 (CET)
Message-ID: <a06ed5e4-37a2-4295-986f-10977878c65b@huaweicloud.com>
Date: Wed, 6 Nov 2024 11:28:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] tools/memory-model: Distinguish between syntactic
 and semantic tags
To: paulmck@kernel.org, Boqun Feng <boqun.feng@gmail.com>
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
 peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com,
 j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
 dlustig@nvidia.com, joel@joelfernandes.org, urezki@gmail.com,
 quic_neeraju@quicinc.com, frederic@kernel.org, linux-kernel@vger.kernel.org,
 lkmm@lists.linux.dev, hernan.poncedeleon@huaweicloud.com
References: <20240930105710.383284-1-jonas.oberhauser@huaweicloud.com>
 <20240930105710.383284-6-jonas.oberhauser@huaweicloud.com>
 <ZyApMteRMxZbpBta@Boquns-Mac-mini.local>
 <cd97e045-dfa4-4ffe-9df0-f7abeec848e7@paulmck-laptop>
 <3b796ef4-735a-44df-a9b1-671df49fd44e@huaweicloud.com>
 <ZyJEBc1qwFHwQQT2@Boquns-Mac-mini.local>
 <7b755586-79ee-4344-bf50-27ef6e99e7bf@paulmck-laptop>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <7b755586-79ee-4344-bf50-27ef6e99e7bf@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwC3H3_PRCtnTiwhAQ--.38583S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr43GF1xKr15Jr43Ww13CFg_yoW8XF17pF
	WxJF13KrWDtr12kws7tw4kuFy5Kry5JF48XryrJwn5Aa4q9r13Gr40kr43uF9FyFyxAa42
	qFWag3sxXw1UCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0pRHUDLUUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 11/5/2024 um 9:21 PM schrieb Paul E. McKenney:
> On Wed, Oct 30, 2024 at 07:34:45AM -0700, Boqun Feng wrote:
>> On Wed, Oct 30, 2024 at 12:38:26PM +0100, Jonas Oberhauser wrote:
>>>
>>>
>>> Am 10/30/2024 um 12:41 AM schrieb Paul E. McKenney:
>>>> On Mon, Oct 28, 2024 at 05:15:46PM -0700, Boqun Feng wrote:
>>>>> On Mon, Sep 30, 2024 at 12:57:10PM +0200, Jonas Oberhauser wrote:
>>>>>> Not all tags that are always there syntactically also provide semantic
>>>>>> membership in the corresponding set. For example, an 'acquire tag on a
>>>>>
>>>>> Maybe:
>>>>>
>>>>> Not all annotated accesses provide the same semantic as their syntactic
>>>>> tags...
>>>>>
>>>>> ?
>>>>
>>>> Jonas, are you OK with this change?  If so, I can apply it on my next
>>>> rebase.
>>>>
>>>
>>> I'm ok with an extra s after semantics and a minor rephrase:
>>>
>>> Not all annotated accesses provide the semantics their syntactic
>>> tags would imply
>>>
>>> What do you think @Boqun ?
>>
>> Yes, of course! This looks good to me.
> 
> Please see below for what I currently have.  If there are no objections
> in a day or so, I will set up these five commits for the upcoming v6.13
> merge window.
> 
> The additional bit pointed out by Boqun [1] can be addressed by a
> separate commit.
> 
> 							Thanx, Paul
> 
> [1] https://lore.kernel.org/all/ZyAmlh5GDBsqY0sZ@Boquns-Mac-mini.local/

I'm confused, did I forget to add the fix to the capitalization issue 
discovered by Boqun to the fixed commit? I vividly remember typing git 
commit add ...


     jonas


