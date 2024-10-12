Return-Path: <linux-kernel+bounces-362006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5129F99AFE2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 03:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C0C81C21602
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCECD528;
	Sat, 12 Oct 2024 01:36:16 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081871FDD
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 01:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728696976; cv=none; b=ICzlPga7slFma0wWPF0B+3yWqCE6Dezm7Fywpl8bqg+kLb6TqXoFx5NCkYXGzPYaMRmNK3XhTzfIf+Fh+J5RVspC/YQpXAw4tKYEYH6xKbu5apjYT0IT0f7cMCH6dsJ9V/m+415XoN9x7Tm0v1EnRvSLpneOkbOo6jsqSIzeyXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728696976; c=relaxed/simple;
	bh=p5eJbHBIIO5rJhkqcVEdlxEhzzA6iUGcccgUjrGPfsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2alp2gfKOy3tG61mREkASgpyqRXjzcYSSv36Cj8s13PlJmOS5oV+ZOZGQHU44NePX9V9iiMy8aOnk7MCq7fJ+PpxwPAcQzv6FoyybjXRSG7nkHvWxqx/w73mtrjWPeuTlmHe3cI82EDDMeP++fOvG/jmWYxfDqWwk3A9DxN7ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XQR071h2Zz4f3lDh
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 09:35:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E99A21A06D7
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 09:36:08 +0800 (CST)
Received: from [10.67.111.172] (unknown [10.67.111.172])
	by APP4 (Coremail) with SMTP id gCh0CgCHusaH0glnLzZkDw--.58519S3;
	Sat, 12 Oct 2024 09:36:08 +0800 (CST)
Message-ID: <deea0784-45a0-03b8-b2a6-ed4fa10f1df5@huaweicloud.com>
Date: Sat, 12 Oct 2024 09:36:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] kallsyms: Fix wrong "big" kernel symbol type read from
 procfs
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: arnd@arndb.de, kees@kernel.org, mcgrof@kernel.org, masahiroy@kernel.org,
 ndesaulniers@google.com, ardb@kernel.org, jannh@google.com, song@kernel.org,
 boqun.feng@gmail.com, gregkh@linuxfoundation.org, gary@garyguo.net,
 wedsonaf@google.com, linux-kernel@vger.kernel.org, yeweihua4@huawei.com
References: <20241011143853.3022643-1-zhengyejian@huaweicloud.com>
 <ZwmgKHxgl2BQuKp6@casper.infradead.org>
From: Zheng Yejian <zhengyejian@huaweicloud.com>
In-Reply-To: <ZwmgKHxgl2BQuKp6@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCHusaH0glnLzZkDw--.58519S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GF45XrWfuFW3Zw1UCr4fGrg_yoWDuFc_Z3
	yY93s8ArWDXrn2gF47CrWrXw4DGa13AF18tw1qqF4IkrWYq3ZagFs2kF9ayFyrXrWkAF15
	uas3uFnrt347ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: x2kh0w51hmxt3q6k3tpzhluzxrxghudrp/

On 2024/10/12 06:01, Matthew Wilcox wrote:
> On Fri, Oct 11, 2024 at 10:38:53PM +0800, Zheng Yejian wrote:
>> The root cause is that, after commit 73bbb94466fd ("kallsyms: support
>> "big" kernel symbols"), ULEB128 was used to encode symbol name length.
>> That is, for "big" kernel symbols of which name length is longer than
>> 0x7f characters, the length info is encoded into 2 bytes.
> 
> Technically, at least two.  If we ever have a symbol larger than
> 16kB, we'll use three bytes.
> 

Well, yes!

>> +++ b/kernel/kallsyms.c
>> @@ -103,8 +103,11 @@ static char kallsyms_get_symbol_type(unsigned int off)
>>   {
>>   	/*
>>   	 * Get just the first code, look it up in the token table,
>> -	 * and return the first char from this token.
>> +	 * and return the first char from this token. If MSB of length
>> +	 * is 1, it is a "big" symbol, so needs an additional byte.
>>   	 */
>> +	if (kallsyms_names[off] & 0x80)
>> +		off++;
> 
> So this "if" should be a "while" for maximum future proofing against the
> day that we have a 16kB function ...

I'll test it and send a v3.

-- 
Thanks,
Zheng Yejian


