Return-Path: <linux-kernel+bounces-331881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7962197B265
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3947F285BBF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B57176FD3;
	Tue, 17 Sep 2024 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yt7NKeVB"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9E7170A0B
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726588082; cv=none; b=X7H16yFYBuyKkx8K3921V1dOkJrjJ8S6ZgytoGx+jHvukxUM4nG0p1Nh5v0bn0xjXqynL0D215XbQG6rzweMw6H37Cd5+bIh/9t5NiPnfZYpuFz2FD2WmkulA/mAAljOmqO6r6+BR6uYftCwfyxz6o+0kDZZs//XutZOmc+iDOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726588082; c=relaxed/simple;
	bh=Ld7fRpLxFMJNxIaFcR99WTYikSCebs9O5cxo+5DSHuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COcpAq7DZT+L+9MkSGCUJJ+CQqBqrACxrZX0jZwTz0xy/28t2Uk4p4LkEYJhMddKqWi6cjmt8Rw0VYPM9a6ThsnmRKaFBYEP+sqssnvxaCqyHMleg0XRyPPDj/gMh49/rl6FZzd8yHF7IU0oNXVZdQkb0TIXffL4efa75dr7gO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yt7NKeVB; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a90349aa7e5so706886766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726588079; x=1727192879; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LlwzHDu+HWKNGZE27Uc0LkSKrmxyD2UPEKYf14nObbE=;
        b=Yt7NKeVB08hp7tHma9PhYhBpFTW3rNfOJkvApijH2yY25EikuxyoBpwfjxN+GzQURD
         o3ILuuG0yvfGoON9zct+Kdx1lQLpmlHj1jeZhOWnLyTYPuBDE+qn7HRAv3+d06LmQTyk
         KSI+5ek1lJe/59njfPtgx/V/eqG1e9GgeXu5+R8uANuEw3pqArNXbOha17u58RMd0pVW
         9HtstdNz0I8S//AwAPqVfpO8XHaUx64BdRBP7tYWQcRaBLHWp2GlObGEBPJPQlKVhM67
         j3Iqa/PJERIF9usO5PmYo1C0Tjh+UB1gg8fxK7/DWWh5bHfl3PwL+8CizXI9obiUA4iA
         Pz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726588079; x=1727192879;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LlwzHDu+HWKNGZE27Uc0LkSKrmxyD2UPEKYf14nObbE=;
        b=lsKUWjTSTUcsytAXh3ekvcvYafDdOvzaJJeWYnnCOAHG2RsSxnrbBBoA591xqCypFc
         bdGP2fyeTN9Cw8T6YsbDZbelygKXMOXGRBtxYka4AxAKdlKnyb2U/TebEXMW/CUAZCYI
         h3/opPIrKPEraCrqHklJaBrxv62sNRmqLY/frlD02HHpdqQxdUTw8KAMXCA+zk7XOs6i
         gsaRJzN9GowANg5t1rNsYZGLUAuCtrEvVNOtwc9TyYTE7CxPNW+zUR3sinusWbb1i2yq
         AV0zOgdwLNPCnw3kRMHmxz2UNTegWLR5554hH7xHw9I452ydWalj96445qnPhX+a/08e
         sPVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZA4FWW/w4qlWOFQ+bhvsMJiKP6HXtac99pbGDZn3Llja3Hq96im83VP9u3s4hRyVaMb6zbTIsVra0XSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaC3FtkWwsXRjARd8fhqDcbeaTP18TSanAiFUfJIQrpAtKxhzQ
	VpT6GJ8J0rqa3hQK7ixZO+oP7MnCUGPjV4gsLvfR823Pi3Mk5UGy
X-Google-Smtp-Source: AGHT+IHhC0COrvuStie5QwYI0cPnBAH4a/c91m0AHmvbkWZJmnY8YNyTN+BYErxCmGTU5u00tF5B/w==
X-Received: by 2002:a17:907:94c4:b0:a8a:3f78:7b7b with SMTP id a640c23a62f3a-a9029440920mr1821474666b.14.1726588079014;
        Tue, 17 Sep 2024 08:47:59 -0700 (PDT)
Received: from carol.localdomain (cst-prg-234-228.cust.vodafone.cz. [46.135.234.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061096896sm467141266b.23.2024.09.17.08.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 08:47:58 -0700 (PDT)
Received: by carol.localdomain (Postfix, from userid 1000)
	id 8A461197F7C07; Tue, 17 Sep 2024 17:47:57 +0200 (CEST)
Date: Tue, 17 Sep 2024 17:47:57 +0200
From: Martin Kletzander <nert.pinx@gmail.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/resctrl: Avoid overflow in MB settings in
 bw_validate()
Message-ID: <ZumkrWn7FtiMxESR@carol.k8r.cz>
References: <1723949d8053aa74da907165dbdc26755f341736.1726492059.git.nert.pinx@gmail.com>
 <abffe9bc-4c2b-4d44-b521-f138179033e3@intel.com>
 <Zuk5_3qzSfld5dvD@wheatley.k8r.cz>
 <7467f313-761a-42ed-ae2d-cdadfd93db90@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7467f313-761a-42ed-ae2d-cdadfd93db90@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett

On Tue, Sep 17, 2024 at 08:08:50AM -0700, Reinette Chatre wrote:
>Hi Martin,
>
>On 9/17/24 1:12 AM, Martin Kletzander wrote:
>> On Mon, Sep 16, 2024 at 09:56:01AM -0700, Reinette Chatre wrote:
>>> On 9/16/24 6:07 AM, Martin Kletzander wrote:
>>>> When resctrl is mounted with the "mba_MBps" option the default (maximum)
>>>> bandwidth is the maximum unsigned value for the type.  However when
>>>> using the same value that already exists in the schemata file it is then
>>>> rounded up to the bandwidth granularity and overflows to a small number
>>>> instead, making it difficult to reset memory bandwidth allocation value
>>>> back to its default.
>>>>
>>>> Since the granularity and minimum bandwidth are not used when the
>>>> software controller is used (resctrl is mounted with the "mba_MBps"),
>>>> skip the rounding up as well and return early from bw_validate().
>>>
>>> Thank you very much for finding the issue and proposing a fix.
>>>
>>>>
>>>> Signed-off-by: Martin Kletzander <nert.pinx@gmail.com>
>>>> ---
>>>> Changes in v2:
>>>>   - actually save the value in the output parameter @data
>>>>
>>>>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 9 +++++++--
>>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>> index 50fa1fe9a073..702b1a372e9c 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>> @@ -48,8 +48,13 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
>>>>           return false;
>>>>       }
>>>>
>>>> -    if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
>>>> -        !is_mba_sc(r)) {
>>>> +    /* Nothing else to do if software controller is enabled */
>>>> +    if (is_mba_sc(r)) {
>>>> +        *data = bw;
>>>> +        return true;
>>>
>>> While this would fix the scenario tested I do not believe this fully addresses the
>>> overflow issue. As I understand the test wrote U32_MAX to the schemata file,
>>> which triggered the overflow because of the rounding and is fixed by this patch. Looks like,
>>> after this patch, writing "U32_MAX + 1" will still trigger the overflow.
>>>
>>> The overflow appears to result from some inconsistent type use and not using
>>> appropriate parsing API that is able to detect overflow.
>>>
>>> How about something like below:
>>>
>>
>> That makes much more sense, I have not considered changing the data type
>> as I wanted to keep the changes at minimum, but your solution is even
>> better.  Should I leave the fix up to you or do you want me to send a v3?
>
>Could you please try it out to ensure it works for you and then send a v3?
>

I wanted but the diff has some weird line numbering and could not be
applied.  I'll write it manually later, test it out, and send a v3.
Thanks!

>Thank you very much.
>
>Reinette

