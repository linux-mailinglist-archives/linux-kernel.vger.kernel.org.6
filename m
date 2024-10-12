Return-Path: <linux-kernel+bounces-362019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C16C899B002
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 04:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C589284877
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 02:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DEADF51;
	Sat, 12 Oct 2024 02:09:31 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C88DDAB
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 02:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728698970; cv=none; b=RYTvHP8Oe0tz4cKbSCtLn6kBWtLdfPHM3yVproyMciXPux0uV31XnLfU/4ETimDm+CHP1puQQk2AeeAb28Ttb1UmO38r8lbMn/Qb0XmbfcaLhCYP0wXvJcNJDmiST5LLggFcAtLwZBKq2G8watpELkyFB75tp7/MDR1lBZwa1JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728698970; c=relaxed/simple;
	bh=Y1lLvp5/CZgbvAIdYHSz5BglXy3zkytBXeWIVAFnM48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dVz72wsVlOEAfoEk2owYZMKuYtl6onsWjW+yXGPIg6Kj3dGAi3E7rLkj44TD7Gqgds4uUM98QJPOzqxH7I1tq3ZtL+lDVTgM7PwsnmRlC54GRE5YJ4XZ357hdGNEfFtSMVmCuGdneQ4sr3jWEl6wFqEG+br5Ad6VAu2NY9zxZaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XQRkZ6DPNz4f3jjy
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 10:09:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B92C51A018D
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 10:09:22 +0800 (CST)
Received: from [10.67.111.172] (unknown [10.67.111.172])
	by APP4 (Coremail) with SMTP id gCh0CgCHusZR2glnc0NmDw--.59085S3;
	Sat, 12 Oct 2024 10:09:22 +0800 (CST)
Message-ID: <1d14275d-0b8e-d044-a436-a41251fa11f5@huaweicloud.com>
Date: Sat, 12 Oct 2024 10:09:21 +0800
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
To: Gary Guo <gary@garyguo.net>, Matthew Wilcox <willy@infradead.org>
Cc: arnd@arndb.de, kees@kernel.org, mcgrof@kernel.org, masahiroy@kernel.org,
 ndesaulniers@google.com, ardb@kernel.org, jannh@google.com, song@kernel.org,
 boqun.feng@gmail.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, yeweihua4@huawei.com
References: <20241011143853.3022643-1-zhengyejian@huaweicloud.com>
 <ZwmgKHxgl2BQuKp6@casper.infradead.org>
 <20241012024745.3807a071.gary@garyguo.net>
From: Zheng Yejian <zhengyejian@huaweicloud.com>
In-Reply-To: <20241012024745.3807a071.gary@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCHusZR2glnc0NmDw--.59085S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF47Zr4UJrykZw43GFW3ZFb_yoW8XFWfpF
	yFqFWqqF48try2k3s3JF4rXr97Kws7Xr47Gwn8t34xCasYq3Z7Cay7Ka1a93WUGryxGF4I
	qFsIyFW2qrn8AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
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

On 2024/10/12 09:47, Gary Guo wrote:
> On Fri, 11 Oct 2024 23:01:12 +0100
> Matthew Wilcox <willy@infradead.org> wrote:
> 
>> On Fri, Oct 11, 2024 at 10:38:53PM +0800, Zheng Yejian wrote:
>>> The root cause is that, after commit 73bbb94466fd ("kallsyms: support
>>> "big" kernel symbols"), ULEB128 was used to encode symbol name length.
>>> That is, for "big" kernel symbols of which name length is longer than
>>> 0x7f characters, the length info is encoded into 2 bytes.
>>
>> Technically, at least two.  If we ever have a symbol larger than
>> 16kB, we'll use three bytes.
> 
> Let's not worry about things that would not happen.
> 
> scripts/kallsyms.c have a check to ensure that symbol names don't get
> longer than 0x3FFF.

Yes, so currently in kallsyms_expand_symbol() and get_symbol_offset(), the
symbol length are also assumed to be encoded into one byte or two bytes.
If considering the "longer than 0x3FFF" case, those two functions may should
also be changed.

> 
> Best,
> Gary
> 
>>
>>> +++ b/kernel/kallsyms.c
>>> @@ -103,8 +103,11 @@ static char kallsyms_get_symbol_type(unsigned int off)
>>>   {
>>>   	/*
>>>   	 * Get just the first code, look it up in the token table,
>>> -	 * and return the first char from this token.
>>> +	 * and return the first char from this token. If MSB of length
>>> +	 * is 1, it is a "big" symbol, so needs an additional byte.
>>>   	 */
>>> +	if (kallsyms_names[off] & 0x80)
>>> +		off++;
>>
>> So this "if" should be a "while" for maximum future proofing against the
>> day that we have a 16kB function ...
>>

-- 
Thanks,
Zheng Yejian


