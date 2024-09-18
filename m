Return-Path: <linux-kernel+bounces-332625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B3E97BC0C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55762B217A6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD0B176228;
	Wed, 18 Sep 2024 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="x9bSRmPi"
Received: from smtp99.iad3b.emailsrvr.com (smtp99.iad3b.emailsrvr.com [146.20.161.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9BC1CD23
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726661823; cv=none; b=OcpPdqU9Hik5LNRCJ0g4Yc84fP7UgIhfeiW7CSc9WRosFKLP/UgbWcQAVPtVBnAUrHTFmhi8Du1CTOvaB/zTDy3ELkC0F8nQlgWqHvd6Cgpg9bZY3wj3iRLXW9DTncTf4+pkqWispYdYxuZqBPJRu8uA0B6I7bGu4RWAnPBoF9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726661823; c=relaxed/simple;
	bh=mDd+ozyqGj5rZLBKGgiFLq4apA2bhA38huTQAKkNNkM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FYTDiQV+sOETps/JNfTv/OADvENi2fgz//qfo0FouHiZYAZzoDyVUjg8nEh75VceNTL354VJrWyBbAlyy38T57QjT1Ol7ahi7LVpjxK3eU3ruhp4tr1Qu1gutCYsshXtHF6zABAXSz7iqAxA29ut1a0EwO1VhVODCrKl97M45Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=x9bSRmPi; arc=none smtp.client-ip=146.20.161.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1726661346;
	bh=mDd+ozyqGj5rZLBKGgiFLq4apA2bhA38huTQAKkNNkM=;
	h=Date:Subject:From:To:From;
	b=x9bSRmPi8g5CG+35oP4F/lYPjTgc90yKb0Qo5B59r8r1fm/iwx6oO2/sYntAPejVy
	 ZY3j4DRsxcEbpxnM8ciZMlxEujO4jRwK+u24rxT+vTuBCSgfjcy7npwo4KnTl9SJsO
	 D6UNP3lNhvcI3D650RXlg8W7XJDKutpzgTqPZmQQ=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp13.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id C5EA4602A3;
	Wed, 18 Sep 2024 08:09:05 -0400 (EDT)
Message-ID: <04320187-02bb-440c-9180-c1198dddecb3@mev.co.uk>
Date: Wed, 18 Sep 2024 13:09:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: adl_pci9111: Fix possible division by zero in
 pci9111_ai_do_cmd_test()
From: Ian Abbott <abbotti@mev.co.uk>
To: Aleksandr Mishin <amishin@t-argos.ru>,
 H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240918104304.15772-1-amishin@t-argos.ru>
 <4f46343a-a1f9-4082-8ef2-50cdb3d74f31@mev.co.uk>
Content-Language: en-GB
Organization: MEV Ltd.
In-Reply-To: <4f46343a-a1f9-4082-8ef2-50cdb3d74f31@mev.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Classification-ID: 288153ad-c70e-4b91-91a2-3aa9a4ba161e-1-1

On 18/09/2024 12:41, Ian Abbott wrote:
> On 18/09/2024 11:43, Aleksandr Mishin wrote:
>> Division by zero is possible in pci9111_ai_do_cmd_test() in case of scan
>> begin trigger source is TRIG_TIMER and either 'chanlist_len' or
>> 'convert_arg' is zero.
>>
>> Add zero value check to prevent division by zero.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: f1c51faabc4d ("staging: comedi: adl_pci9111: tidy up 
>> (*do_cmdtest) Step 4")
>> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
>> ---
>>   drivers/comedi/drivers/adl_pci9111.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/comedi/drivers/adl_pci9111.c 
>> b/drivers/comedi/drivers/adl_pci9111.c
>> index 086d93f40cb9..ec1fb570b98c 100644
>> --- a/drivers/comedi/drivers/adl_pci9111.c
>> +++ b/drivers/comedi/drivers/adl_pci9111.c
>> @@ -312,6 +312,8 @@ static int pci9111_ai_do_cmd_test(struct 
>> comedi_device *dev,
>>        */
>>       if (cmd->scan_begin_src == TRIG_TIMER) {
>>           arg = cmd->chanlist_len * cmd->convert_arg;
>> +        if (!arg)
>> +            return 4;
>>           if (arg < cmd->scan_begin_arg)
>>               arg *= (cmd->scan_begin_arg / arg);
> 
> Nice catch!  `cmd->convert_arg` will be non-zero due to earlier checks, 
> but `cmd->chanlist_len` could be zero for the `COMEDI_CMDTEST` ioctl. 
> (The function is called for the `COMEDI_CMDTEST` and `COMEDI_CMD` 
> ioctls, but only `COMEDI_CMD` checks that `chanlist_len` is non-zero 
> before calling the function.)
> 
> Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

On second thoughts, the code should not return 4 (indicating a problem 
at checking step 4) here if `chanlist_len` is 0, because it is OK to use 
a zero `chanlist_len` value when using the `COMEDI_CMDTEST` ioctl.

Suggested fix is to keep your change, but to combine it with this change:

-	if (cmd->scan_begin_src == TRIG_TIMER) {
+	if (cmd->scan_begin_src == TRIG_TIMER && cmd->chanlist_len) {

I think `cmd->convert_arg` will be non-zero unless the call to 
`comedi_8254_cascade_ns_to_timer()` somehow manages to set it to zero.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-


