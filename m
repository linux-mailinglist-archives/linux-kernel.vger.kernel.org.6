Return-Path: <linux-kernel+bounces-422503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 547189D9A67
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19CC428408A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4414A1D61B7;
	Tue, 26 Nov 2024 15:26:17 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35D01D47DC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732634776; cv=none; b=lgV6D4o45iOZ5ITBSLZU0r6PcKvpJyoRS+tUOIgJ1FyNC2VnAoSK75mZTjLeFnEIilJni53/nDc9XFX7HpT06avKB7FfYlQTOZhB94nX3OkrsDZS2Y0Wd1em0yiCfProTQQwrPCJB4BZWBBSrzRnRWyQSDpa/DMXQfsCz8CzCas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732634776; c=relaxed/simple;
	bh=7xoXOs6QFvhqbWGq4HfLEgxp2uxNGgWZlA9EHXy0WVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWLKNZ/FX2CicFSKwPl/7TUWfXKaj4JHDhQg5VuShfN6FGCLJYSV3yr1OAfr4hfAq7IcC2KtmBGH+YKe43suVmtxzkbiLxjsLoQ9cKNxhjWsByvAhNb9FSz9Y+irOrdTgJ0rd8xzWZVwIuyj6xuTjNGVf8/F6CQMP+3j0qXHzYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XyQqB5ktvz9v7NV
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 23:05:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 860E7140854
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 23:26:03 +0800 (CST)
Received: from [10.81.211.153] (unknown [10.81.211.153])
	by APP1 (Coremail) with SMTP id LxC2BwB3Njd96EVnYbpVAg--.124S2;
	Tue, 26 Nov 2024 16:26:02 +0100 (CET)
Message-ID: <94ec40b6-79d7-4d23-97c0-951a5faac9c8@huaweicloud.com>
Date: Tue, 26 Nov 2024 16:25:46 +0100
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
Cc: Akira Yokosawa <akiyks@gmail.com>, boqun.feng@gmail.com,
 dhowells@redhat.com, dlustig@nvidia.com, frederic@kernel.org,
 hernan.poncedeleon@huaweicloud.com, j.alglave@ucl.ac.uk,
 joel@joelfernandes.org, linux-kernel@vger.kernel.org, lkmm@lists.linux.dev,
 luc.maranget@inria.fr, npiggin@gmail.com, parri.andrea@gmail.com,
 peterz@infradead.org, quic_neeraju@quicinc.com, stern@rowland.harvard.edu,
 urezki@gmail.com, will@kernel.org
References: <3d72b92a-4935-425c-abd5-ec4631baef2c@huaweicloud.com>
 <46d291da-ddb9-43b9-bd93-b81aacd5e29c@gmail.com>
 <7542399d-87c5-4f1c-9d09-6a6f96d148da@huaweicloud.com>
 <a278c4a9-eae2-491e-8f13-5a87a25dad26@gmail.com>
 <f1d7a295-ad24-41c8-a431-7d6492d51097@huaweicloud.com>
 <245e4781-80b2-4e21-b4de-51ffeac9cc39@paulmck-laptop>
 <02537f27-ac3b-4e2e-80a2-ad57230ac478@paulmck-laptop>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <02537f27-ac3b-4e2e-80a2-ad57230ac478@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwB3Njd96EVnYbpVAg--.124S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYv7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aV
	CY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4II
	rI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r
	4a6rW5MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 11/18/2024 um 4:05 PM schrieb Paul E. McKenney:
> On Fri, Nov 08, 2024 at 10:35:24AM -0800, Paul E. McKenney wrote:
 >>
>> And now you know.  ;-)
> 
> if it is important to
> get the first three into the current merge window, please rebase them
> to mainline some time this week

> Over to you!

Luckily there's no need and we can wait until a new herd release.

Have a lot of fun,
    jonas


