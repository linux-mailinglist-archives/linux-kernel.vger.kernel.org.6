Return-Path: <linux-kernel+bounces-399582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D369C0116
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCC89B22049
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91E21DF26E;
	Thu,  7 Nov 2024 09:25:20 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F82F1DC05D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730971520; cv=none; b=MgcYeWDnEVxQE2Go3d9vGA1BgN6PK4H3jKKZ0KBASnCO3wjmpqeR6cG0koaO9iEPNknqcRKi4tH3eGje7nXJWR1kfpWttjPMNulhoxYKQaNpy+NnJfKDOmEWFs0gDShL+h1WtHdRubuvX8zXIitE06nTcuvBbI8/agA+kwIzozY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730971520; c=relaxed/simple;
	bh=27dhVcjOyaPkGP53Ssz4A+aJPJ0cRY7soYUW0uq3KXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNIdbiul2Ho++dQtfnwluA6ar53kcOqzJsYX+zklC4NHsY0IhaW9ybdhbIHKiKwjov6glfjfMFdeXvFP1OyDvGgqR7jIcFBcB5+I5kvTIGL+pXTcPhhwEfWrpTR+ayK1jC7A7sFB3HvI2o4mW9jBHnW1UhRexOniZo4ja36BdRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XkbHD4xBvz9v7NH
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 16:44:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 63D6D1400CC
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 17:05:33 +0800 (CST)
Received: from [10.45.145.235] (unknown [10.45.145.235])
	by APP1 (Coremail) with SMTP id LxC2BwCnTR7RgixnBBMuAQ--.34656S2;
	Thu, 07 Nov 2024 10:05:32 +0100 (CET)
Message-ID: <3d72b92a-4935-425c-abd5-ec4631baef2c@huaweicloud.com>
Date: Thu, 7 Nov 2024 10:05:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] tools/memory-model: Distinguish between syntactic
 and semantic tags
To: paulmck@kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>, stern@rowland.harvard.edu,
 parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
 npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
 luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
 joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
 frederic@kernel.org, linux-kernel@vger.kernel.org, lkmm@lists.linux.dev,
 hernan.poncedeleon@huaweicloud.com
References: <20240930105710.383284-1-jonas.oberhauser@huaweicloud.com>
 <20240930105710.383284-6-jonas.oberhauser@huaweicloud.com>
 <ZyApMteRMxZbpBta@Boquns-Mac-mini.local>
 <cd97e045-dfa4-4ffe-9df0-f7abeec848e7@paulmck-laptop>
 <3b796ef4-735a-44df-a9b1-671df49fd44e@huaweicloud.com>
 <ZyJEBc1qwFHwQQT2@Boquns-Mac-mini.local>
 <7b755586-79ee-4344-bf50-27ef6e99e7bf@paulmck-laptop>
 <a06ed5e4-37a2-4295-986f-10977878c65b@huaweicloud.com>
 <36c93729-8d3c-4ede-8f5d-3074d6ea7e64@paulmck-laptop>
 <94d8e5f6-db46-463e-ac58-31147cb94508@paulmck-laptop>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <94d8e5f6-db46-463e-ac58-31147cb94508@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwCnTR7RgixnBBMuAQ--.34656S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYk7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aV
	CY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
	5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
	CFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxG
	xcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_GF
	v_Wryl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 11/6/2024 um 7:00 PM schrieb Paul E. McKenney:
> Never mind, I found your patch in my spam folder. 
Glad that got cleared up. I had gotten very confused because you had 
also responded to the thread with the patch.

 > check this commit on -rcu

For future reference, where can I find the -rcu repository? I couldn't 
find the commit on paulmckrcu/linux, but maybe I looked incorrectly.


Have fun,
    jonas


PS:

 > Apologies, and I thought that had been fixed.

One might come to the conclusion that with sufficient effort, things can 
be un-fixed...


