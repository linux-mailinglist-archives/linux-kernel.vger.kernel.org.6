Return-Path: <linux-kernel+bounces-197897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC44A8D707B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 16:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A6F1C21311
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 14:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA4915218D;
	Sat,  1 Jun 2024 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ng3s5h3P"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAE11DFF7
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717253431; cv=none; b=uMC4zAzzlxF2JettnqOWzLFLyTs03nnkc9sQHkteg5f9konJNrjg+EWLHKncfD541PWZMMeRmJOo7xn+fg3P65qC1oSn+xk2FNA8qcNfHdeE3tW9ABNN1HvqlvT1asS1VqP9MuPHiDZEnqEMXAFB9KAkaY/2WVrFQx9scuSBNws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717253431; c=relaxed/simple;
	bh=BGUQfv3ddEEs7Y6Va6mWJCj4ZwBPxrpj1xJduPX+SQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ndhwbs9P93OvDhQz7oqbVKdFNehJ4DWBMWsHoqMhTYM6F2ZwnCeZOXygNfaBhwr26nVqtpeAFS6yfwbANpKgTpHyt7sTZ6SehJ3+YZp+UHT00cGuaJfVwGe9jZ+AXvqmB3OSv9ezFJZGmgmRbvaU5k5m+RL43FyqZtuPHGzQCY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ng3s5h3P; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a3f765ab6so222601a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 07:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717253428; x=1717858228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yy7wHDVcQQMPykugaV/Sts6o5xwuXy79ptch3fK9zNQ=;
        b=ng3s5h3PwSQoV76/rnpHCP8FelbUNBD+DW3Xth7i5Gdc2IpP0q+3mfOtUBQJ5VC5Tm
         mTM77olVwvCh/vuW+GbYju/iw1VXsvFmJuamhwYAW37dx2zD9jaVEty6tcAeNSZtMF7S
         vBxjpi1L/roiz1gMXzzageRvOWlGpjfonUHrtRc2SoIft3hYvxNoV95cZFs6NfWeYJDz
         VD9ocsbFB5IqruyxlD2GpWOLqALZuaJ6mrWdUyBq3feGiItsn1k10Jj7bbUw0uY7JVet
         EfIAcsyClFMCxl5MhikY8a7lO9tagQ7pGDyWqRXJNIaUWGqBgTcO01W0F/iMmvRe52rv
         f2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717253428; x=1717858228;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yy7wHDVcQQMPykugaV/Sts6o5xwuXy79ptch3fK9zNQ=;
        b=jVV3Q+3VqVKv3X6Sd/Wck0bnfPdIvPCV7ctxa+g7uYzzyljKHvT0JuwKT7tQAIm8py
         aM0oUP7ty0a4fCkxJCEZQ+5Kb1f6b7AUn5HFidvTZtYH0qFWBzZmVb+mWpwgCFNLWJBh
         +wqReQbWupJXtv53r3LLAe6/4R7LMqg9WEF3ik7fqXA3lvSvfiPE0mcX6s6cNrOFPwzC
         ihRQL9Mok8+2yGmP33V0atxbKBsX4nJDQ4C93zmEN90rmtg6CXeTgDCNEje0G89CRhW5
         7JgVB5VrtfJP7lcnTBAp+4WUiedVfhLIlHCy7hZv0jEdMDUbvUa77TK3Hnq49dj2UkB8
         nqiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVEjgubiJX8XdoqCXH9StcJqZHUdmw4jWfOmFqedffmYQUbCpbBPZs0nw6m9lM0LcOMxVQt2Ip5ohbuS7MX3UMpLv3NqTvpXEhkmfr
X-Gm-Message-State: AOJu0YyOsfOsatckGorc2IpGIkKVc2VhrcPPvBkh7kb7+DXvJma2HblX
	wkZAeRDIn6HlEbnqSJVPqoO6sGPy10Ok/oPq7PkDFwcqA6FJ8dZbSL3pZQ==
X-Google-Smtp-Source: AGHT+IGRSfaTDArOtylxesKL7D931D7fAcpFGiqKS4Y4/fHrvmum1iIZdVWQNDKPW3eD2OCISFngyA==
X-Received: by 2002:a17:907:1315:b0:a62:446e:2cfd with SMTP id a640c23a62f3a-a681fc5c097mr264431266b.2.1717253427168;
        Sat, 01 Jun 2024 07:50:27 -0700 (PDT)
Received: from [192.168.0.102] (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67ea67b645sm207265166b.125.2024.06.01.07.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jun 2024 07:50:26 -0700 (PDT)
Message-ID: <7e64f57e-7f49-4681-9b3b-2d8fe2e0f5ce@gmail.com>
Date: Sat, 1 Jun 2024 16:50:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: r8712u: remove unused struct
 'zero_bulkout_context'
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
 gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240529000814.233690-1-linux@treblig.org>
 <971c164f-5ebf-44cb-8cff-3a09c63bb77e@gmail.com> <Zlsfd9Eq5jecxRZq@gallifrey>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <Zlsfd9Eq5jecxRZq@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/1/24 15:17, Dr. David Alan Gilbert wrote:
> * Philipp Hortmann (philipp.g.hortmann@gmail.com) wrote:
>> On 5/29/24 02:08, linux@treblig.org wrote:
>>
>> please remove the following line:
>>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>>>
>> To me it is not important which commit introduced the struct. This is not a
>> bug. So I would omit this lines and use instead just:
>> Remove struct zero_bulkout_context as it is unused.
>>> 'zero_bulkout_context' is unused since the original
>>> commit 2865d42c78a9 ("staging: r8712u: Add the new driver to the
>>> mainline kernel").
>>>
>> please remove the following line:
>>> Remove it. >
> 
> v2 sent just now with changes as requested.
> (Although I think you're the only person who has asked
> to remove that detail, most seem to like it as a hint
> as to whether there's some reason it's unused).
> 
> Dave

May be you are right. But may be they are just happy that they do not 
have to respond to mails for the drivers named in this email:
https://lore.kernel.org/linux-staging/623629d4-87ad-4e7d-b4f7-2d10e0c02a2d@gmail.com/
Please consider that reviewers and testers are always wanted.

That only one person responses for simple changes is not so uncommon.

Thanks for your support.

Philipp



> 
>>> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>>> ---
>>>    drivers/staging/rtl8712/usb_ops_linux.c | 7 -------
>>>    1 file changed, 7 deletions(-)
>>>
>>> diff --git a/drivers/staging/rtl8712/usb_ops_linux.c b/drivers/staging/rtl8712/usb_ops_linux.c
>>> index b2181e1e2d38..0a3451cdc8a1 100644
>>> --- a/drivers/staging/rtl8712/usb_ops_linux.c
>>> +++ b/drivers/staging/rtl8712/usb_ops_linux.c
>>> @@ -26,13 +26,6 @@
>>>    #define	RTL871X_VENQT_READ	0xc0
>>>    #define	RTL871X_VENQT_WRITE	0x40
>>> -struct zero_bulkout_context {
>>> -	void *pbuf;
>>> -	void *purb;
>>> -	void *pirp;
>>> -	void *padapter;
>>> -};
>>> -
>>>    uint r8712_usb_init_intf_priv(struct intf_priv *pintfpriv)
>>>    {
>>>    	pintfpriv->piorw_urb = usb_alloc_urb(0, GFP_ATOMIC);
>>
>>
>> Hi David,
>>
>> I would prefer the following changes:
>> Subject: please change from r8712u which is the compiled driver name to
>> folder name of the driver: rtl8712
>>
>> Please also consider the above hints.
>>
>> If you send in a second version of this patch please use a change history.
>> Description from Dan under:
>> https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/
>>
>> Please contact me for any questions.
>>
>> Thanks for your support.
>>
>> Bye Philipp
>>
>>
>>


