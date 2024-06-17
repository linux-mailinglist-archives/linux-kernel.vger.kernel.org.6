Return-Path: <linux-kernel+bounces-216571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 112BE90A18F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA921C20FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 01:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285BD6125;
	Mon, 17 Jun 2024 01:06:19 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FE714AB8
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 01:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718586378; cv=none; b=YNVTk5J4C1g7GkS3kH+/FEt7yUpO0+ZMBeX4E9JspFp0VCTHOQYSPDMS7ZYOzpJhbUubd8C55QuWC0xK/OuRX3bYNEPFR/Y8zC16tbG+92QQFAUXtUsV5RBiemwArWLBtt6/AYG3ysIma1/TUG5oVmDlrE9mLVvJEBE6VJBCw7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718586378; c=relaxed/simple;
	bh=PybrqnclO040E50yhWplyWa3cgTt+mJPa8iSJAbfB7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHElPCpo9Y4yJ0dUJqhxTtHI/9t66NGOCOLM6eQhN8+aa1yK6G4hSupXgpySpiH1mAAP3/wN1poWRduyyoPSvBPSxxLG23R23es3JlsZpNNfGMk6iX1tRgbZv7tjUb0RzG68FEAXquvkGcaV8Fakb8K5U4lJGyn1ZsgLZvRAK9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with SMTP id HwEQrADHHsfzi29my3Z5AQ--.7751S2;
	Mon, 17 Jun 2024 09:05:55 +0800 (CST)
Received: from [10.12.169.238] (unknown [10.12.169.238])
	by gateway (Coremail) with SMTP id _____wDnRS7xi29mcCsnAQ--.24238S2;
	Mon, 17 Jun 2024 09:05:54 +0800 (CST)
Message-ID: <4df7cbfd-5a14-43a4-973b-23fd4f5d78fb@hust.edu.cn>
Date: Mon, 17 Jun 2024 09:05:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] scripts: fix most issues reported by pylint
To: Jonathan Corbet <corbet@lwn.net>, Cheng Ziqiu <chengziqiu@hust.edu.cn>,
 Yanteng Si <siyanteng@loongson.cn>, Alex Shi <alexs@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <20240615035323.909650-1-dzm91@hust.edu.cn>
 <87ikyakn6l.fsf@trenco.lwn.net>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <87ikyakn6l.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:HwEQrADHHsfzi29my3Z5AQ--.7751S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvdXoWrZrWDXF1fKw45Ww1UurWrAFb_yoWfCFX_uF
	97Ka9rArWDJa4S9FyDtFs8Jry7Za17WF1kGF1vyr4fAasrZws8GFyvkrsIqw1UWFWavr4U
	Wr9Yv393Ary2kjkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbk8YjsxI4VWxJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
	8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUXV
	WUAwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AI
	YIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VACjcxG62k0Y48FwI0_Gr
	1j6F4UJwAv7VCjz48v1sIEY20_GFW3Jr1UJwAv7VCY1x0262k0Y48FwI0_Gr1j6F4UJwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l42xK82IY6x
	8ErcxFaVAv8VW8uFyUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73
	UjIFyTuYvjxUVoGHUUUUU
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 2024/6/16 03:42, Jonathan Corbet wrote:
> Dongliang Mu <dzm91@hust.edu.cn> writes:
>
>> Pylint reports many coding style issues of scripts/checktransupdate.py
>>
>> This patch fixes most issues with the following contents:
>> - add or revise comments for all functions
>> - use format string suggested by python
>>
>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>> ---
>>   scripts/checktransupdate.py | 55 ++++++++++++++++---------------------
>>   1 file changed, 24 insertions(+), 31 deletions(-)
> How does this differ from v1?  Please always give that information so
> reviewers know what's going on.

Hi Jon,

Patch 1/2 in v2 patch has no difference with Patch 1/2 in v1. Randy put 
up some change requests about

the help documentation, and it is written in the Patch 2/2 in v2.

I am not sure how to show this information in Patch 1/2. How about 
"v1->v2: no changes"?

Dongliang Mu

>
> Thanks,
>
> jon


