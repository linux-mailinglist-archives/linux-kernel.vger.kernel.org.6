Return-Path: <linux-kernel+bounces-388606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73C19B6201
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C2BB28170F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9A11E572F;
	Wed, 30 Oct 2024 11:38:52 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945351E5726
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730288331; cv=none; b=fs+RjIGvukFOtE87uQo3pTtDDBN5+4F4FuT/mL9PSi4C91NQm12ORHrsthxE9za6+ajUhDqKabNOawN+PXIM+7UBYnE/pQi6ZfEhqcQHR1ua8UtfkjCm/TgSXx3oQZQ69ij7yIc0qMuyK5uVFXW3ss5VM4wqEcg4H6bnXjQXmV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730288331; c=relaxed/simple;
	bh=C0aAwBCcvhPeaEjmZL7WfMO4SR/2LVbj1CrWtedAbpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZWzLHxbTMgbygfhuZYxnVWdQJrXMsi38KAiys2yqTZDFzwuNXEroI4/X4SldEem+Zo3fQBg93r8j4bTMBJKrlSvON6TkFRB7Iq8Pk18bEdHUMd0Z1ULuuVv2NFBFSMNq0NwVQ/xj6h36LlcTJKRSa4AOyK4g7pg0258Jrhc4Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Xdl3p1zByz9v7NX
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 19:18:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 4AEC714035F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 19:38:41 +0800 (CST)
Received: from [10.81.211.136] (unknown [10.81.211.136])
	by APP2 (Coremail) with SMTP id GxC2BwBnyHe1GiJnogK2AA--.8606S2;
	Wed, 30 Oct 2024 12:38:40 +0100 (CET)
Message-ID: <3b796ef4-735a-44df-a9b1-671df49fd44e@huaweicloud.com>
Date: Wed, 30 Oct 2024 12:38:26 +0100
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
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <cd97e045-dfa4-4ffe-9df0-f7abeec848e7@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwBnyHe1GiJnogK2AA--.8606S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XryfArWUtF1UKw1ruF48Zwb_yoWxurX_uF
	1qk348Zw1DAF9Fk3WDK39Yvry0vFW8Zw4UXrZ7t3sFvr1IyFWxGF47Arn7X3ZxuayavFyD
	uasYva4Yqry29jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
	04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7sRidbbtUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 10/30/2024 um 12:41 AM schrieb Paul E. McKenney:
> On Mon, Oct 28, 2024 at 05:15:46PM -0700, Boqun Feng wrote:
>> On Mon, Sep 30, 2024 at 12:57:10PM +0200, Jonas Oberhauser wrote:
>>> Not all tags that are always there syntactically also provide semantic
>>> membership in the corresponding set. For example, an 'acquire tag on a
>>
>> Maybe:
>>
>> Not all annotated accesses provide the same semantic as their syntactic
>> tags...
>>
>> ?
> 
> Jonas, are you OK with this change?  If so, I can apply it on my next
> rebase.
> 

I'm ok with an extra s after semantics and a minor rephrase:

Not all annotated accesses provide the semantics their syntactic
tags would imply


What do you think @Boqun ?


   jonas


