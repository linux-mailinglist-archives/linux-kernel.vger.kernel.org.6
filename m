Return-Path: <linux-kernel+bounces-234273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A456C91C48D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F45928280F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6571C9ED6;
	Fri, 28 Jun 2024 17:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eqv5eF6l"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501FC6AB9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 17:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594932; cv=none; b=BFP6a43xzO/t43QUCxVzzNr3u5A+NbQzBDcJwhFCY2yt5IF94jBzk0tINJYd9LXa2DXLeTmMv6bpqlrPFXJbiLoclkl5/EFgrs2r/DDfleXnd1w8EGs6+6LpmRWnl/38gSGvc+x+moj6qGrM3/4inh68U3KIbIEEgv+Uwi34Uj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594932; c=relaxed/simple;
	bh=4IwJjCbkcI9ioxglHRz/ZJAYJoonlFehzoAB1ceYFLA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=P45Wtobsy/r6oO2lPsObG8/kGLH+uHIZaC84EHNrkOmMw9/sN8F0gVHkRKUrHoJu/gbjMQjKw7DkMkmwxahPyyThEls6ejQLIAUYfcmqLCV662xowBzloKHg0V82WZ7zj4xIb21zfsSJvoYdALOhCYGVQNoTbwETkbXOcRPDQ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eqv5eF6l; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3734052ffd9so515335ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 10:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719594929; x=1720199729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D/j4eGhOaAY3yoztRoWYvbEMIVafpbJK0SZsDiA+E4k=;
        b=eqv5eF6lVH3etrZni/X5gtf/vgXSXgisVKSDJruVnkWLlcr45AmgVYwygBXfD1JV6q
         Gp+Dutlwc1VqLQO4365zwukVeHeuk4BO3v3or8fMngUxOaGxYGHDOJgbGlzjQYl9hrFP
         h7q+TWSmJsixewXbmJq5yNB9yPJ5qPptlcNOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719594929; x=1720199729;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D/j4eGhOaAY3yoztRoWYvbEMIVafpbJK0SZsDiA+E4k=;
        b=j3pgT5MCOEVrXknXPt+cV5CUVGs6h9mBTsl9R+CAS3SXy9AYvwZTfzj0Tr4zEzZvj3
         r0V6CyNFRZ8viuYq8s78ZpAeV4De6Cm5/31EsmT3xXoDXPCarFybR6cZBxcuNhal7cO8
         296eOpVMI4iUXvrxGHWPa7v5Z4OzFixGBT/iS3rs8UASPNIxNwdah5v9fyMPJ9xfqPd/
         mWo9++yeJdAzzGLLfSetnQlyxNu50OY8IG2zna75zYfZQ0gm9z9ELezm4RfHuaJmTFWK
         q3klDPZsH1q4I0qa5dbBZemrE99vBdFmScGbtGCBGo4egRl+FdfbQjD/9JqSj/NwFtoR
         d9eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYAcabNKIwaZu+PMD0S0ZqRSN0HPk5qojh2wcjR1NslmCB9Fxz7RsHnRklEUuodgG26qY5Vnl3VjO0HPbX7ujTjIW8S0+ODfWMr06V
X-Gm-Message-State: AOJu0Yzx88F5PJBq2f7KSTD4mHvKohgvyk+KmlRyLkVAODuyzftQx9D2
	0oMJkKi9b2h4fu6HgU/0RqOu5djPCXmvXv3MlW0fUnJiAc6Ue88/pyrLlP2FKvguEcWSlIczqY/
	d
X-Google-Smtp-Source: AGHT+IEvoWVb/REB+KdFAMwhK7nALye46Ii+qf/gBh4MtnSRuqaBh9+CBE69BXuZPghz8H69rs6kIA==
X-Received: by 2002:a5d:984e:0:b0:7f3:9dd3:15bf with SMTP id ca18e2360f4ac-7f39dd317famr1616390939f.0.1719594929314;
        Fri, 28 Jun 2024 10:15:29 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7f61d112dbcsm57549439f.46.2024.06.28.10.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 10:15:28 -0700 (PDT)
Message-ID: <8c94fa65-780e-44d2-8e75-5cdc51cee9f6@linuxfoundation.org>
Date: Fri, 28 Jun 2024 11:15:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] usb: usbip: remove unnecessary cmd variable
To: Xiaobo Liu <cppcoffee@gmail.com>, valentina.manea.m@gmail.com,
 shuah@kernel.org, i@zenithal.me
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240628104616.16441-1-cppcoffee@gmail.com>
Content-Language: en-US
In-Reply-To: <20240628104616.16441-1-cppcoffee@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/28/24 04:46, Xiaobo Liu wrote:
> There are two redundant if conditions that can be simplified to directly use pdu->u.cmd_submit.
> 

I see you sent the same patch twice without indicating that it is a
resend with a change in subject line.

How did you determine this change is necessary?

> Signed-off-by: Xiaobo Liu <cppcoffee@gmail.com>
> ---
>   drivers/usb/usbip/usbip_common.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/usbip/usbip_common.c b/drivers/usb/usbip/usbip_common.c
> index a2b2da125..74a01a265 100644
> --- a/drivers/usb/usbip/usbip_common.c
> +++ b/drivers/usb/usbip/usbip_common.c
> @@ -568,17 +568,9 @@ static void correct_endian_ret_unlink(struct usbip_header_ret_unlink *pdu,
>   
>   void usbip_header_correct_endian(struct usbip_header *pdu, int send)
>   {
> -	__u32 cmd = 0;
> -
> -	if (send)
> -		cmd = pdu->base.command;
> -
>   	correct_endian_basic(&pdu->base, send);

Did you check what correct_endian_basic() does and why
it is important to check "send" and assign "cmd"

>   
> -	if (!send)
> -		cmd = pdu->base.command;

It is necessary to assign the command after calling
> -
> -	switch (cmd) {
> +	switch (pdu->base.command) {
>   	case USBIP_CMD_SUBMIT:
>   		correct_endian_cmd_submit(&pdu->u.cmd_submit, send);
>   		break;

This patch will introduce an error. NAK on this patch.

thanks,
-- Shuah

