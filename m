Return-Path: <linux-kernel+bounces-528026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DF3A4129D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BAE43AECD3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 01:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7474438DE1;
	Mon, 24 Feb 2025 01:27:29 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EC12746A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 01:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740360449; cv=none; b=XuTHnx9QFg0pziXNogrTRC+OdzDWcRy8dcQ3ADU+S5nafn1hnoZ0y49JC5sHeYRo9mv6HrO61JI7yBkve405hFjQX3UPNHHq8hELvOIvXOTAChM18ViibFDzaaHvLZ/SEANoJ/F0jHLFSojoPl7JvbW1ppoprmoOQTmA7iyQz7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740360449; c=relaxed/simple;
	bh=8X/bCZzILqRRaX5wQteNpEGa4Pi7PQjaG0fgtunDdNU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nPLwDPGGXFxQ8pnCSryoaFn4KAbOchNTZfJm6wrUiIXSdLlHgB1lT1axnodKd8J4PTWwsNIN9ICRLXzMMOXG8V8Mvv9/mftkrJAohDGvijZ9ydsa5ldNPrj4zmZGkw7C1Ron6SECl1LO4IsAZsTaq4PM0Fh602ZdmzEyWjfnirA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z1NPj3mXmz4f3jt3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:27:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id EEEC61A058E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:27:21 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP3 (Coremail) with SMTP id _Ch0CgAnesT5yrtnLI6iEg--.54045S2;
	Mon, 24 Feb 2025 09:27:21 +0800 (CST)
Subject: Re: [PATCH 0/6] Some random fixes and cleanups to mm/swapfile.c
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kasong@tencent.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250222160850.505274-1-shikemeng@huaweicloud.com>
 <20250222174427.2f7d1df81853fa01fa92eacf@linux-foundation.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <880080ee-2a18-826d-51f1-1e8d9552fdde@huaweicloud.com>
Date: Mon, 24 Feb 2025 09:27:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250222174427.2f7d1df81853fa01fa92eacf@linux-foundation.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAnesT5yrtnLI6iEg--.54045S2
X-Coremail-Antispam: 1UD129KBjvdXoWrur17Ar4Uur1UGr4xXFy7Jrb_yoWDArc_u3
	90vr9rK3ZFkrWDCanxGF1Yyr1SkFW09ry5ZryrtryUCryrAFn3Gr4vgr15tr1kJay8trZ8
	Wr9xXw13Aw10kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbz8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwmhFDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 2/23/2025 9:44 AM, Andrew Morton wrote:
> On Sun, 23 Feb 2025 00:08:44 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:
> 
>> This series includes several random fixes and cleanups to the mm/swapfile.c
>> code. The issues were discovered during code review and can only manifest
>> under extremely rare and race-condition scenarios. Further details about
>> each fix can be found in the respective patches. Thanks for your
>> attention!
> 
> Thanks.  I queued the first three patches in mm-hotfixes-stable, as
> they address post-6.13 issues which should be addressed during this -rc
> cycle.
> 
> I queued the other three patches for 6.15-rcX.
> 
> I corrected the Fixes: hash in [2/6].
> 
> I made some changelog alterations, along the lines that Kairui
> mentioned.  Please check the results and send along any alterations
> which you feel are desirable.
> 
Thanks for correcting the changelog. The results look good to me
except patch 1 may still need some changelog improvement. Will
send a v2 of patch 1 soon.


