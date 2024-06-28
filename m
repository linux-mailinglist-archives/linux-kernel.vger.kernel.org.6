Return-Path: <linux-kernel+bounces-234275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 370EF91C491
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7272B21B14
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC21F1CCCC4;
	Fri, 28 Jun 2024 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FXUoZ8qG"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9BD158DDC
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594991; cv=none; b=QGcPe9fyOLAx1vVs4XHiKsGhsGB3ZZe6ISYQuUCsEShtuZK+u36i/gp/5a3YZTFhjHMEojlMqHsAr/YzKbR1NLYW5J/try1HT6IsbjuNG2BLefYvurmq8o9S2TEjDxvGAPo5WM0BDmKRzY1n1pHrSCvFlbbctZl68Bd+t1+uMik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594991; c=relaxed/simple;
	bh=HDethv1SZLS+naRJvAeYJVIme+PRI3d8lM7PY0zTCCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivOYijpd0Gmhz4shG2NOyrD3sG0BJgnuJAhkfprauak/tFrrc6qzMVRYO5ij/p5NQxHxaYykaBEVapLYNwy1swI431jjfiucxNF8kVLTLWsMxsnPIVpysIZoQ6UNvD5P0fK1S6+Rqk69h1p9+jh3P3bRcJr7NcS54pxVEsCrgkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FXUoZ8qG; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-375df7da74cso496015ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 10:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719594988; x=1720199788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dyak7fcy4WheUrx/4rowppCVwuEbhDjQTwxSTAFmUc4=;
        b=FXUoZ8qGOme1XfCi1jmcmREmO/1IXYRY4EXzcTZoHAog0HkqQqJeFZDDbF9gOo9lm7
         Zy+L5VDRQMvLvfiMP5TDs3pCFwbGkXbix7KB4nnivwHKkYZN+fTjUzyn3CDObkSqZ+65
         dZRlEGsjZZSeAC+GJtzO996B6e9C9pKfnQ2u8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719594988; x=1720199788;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dyak7fcy4WheUrx/4rowppCVwuEbhDjQTwxSTAFmUc4=;
        b=V7dJMevQ4BYaPRA8OY8YTIieEo0pv9pH4Nz+5qM6ZIKoBcP39RRHs9ycjJEKhpnAPn
         Bm+66gB12v9S6WMvfqFbLp6/kCEe8/FzTcr3UsrDhKZEdYr6lSeAX/peXXZEa31RJCEA
         P3KrHKQ3GpmMC12c05WvU0fHSCtxseOsgOP6JlNlDJYDEcwjYPlywYbzNjrolI8bB3kA
         NmyxXXzxFWSfB8xTw2wOPTJNoiigvGxkXGzwITnJnk4qs4+7lmF0+YkN3nvb+MAeeeMH
         QH/SjIrhOKd4ZUiUmwz0skIlQ310/WMOAocMW+Gq52EolJc7KAVaJ0f3XGusqj26nw3e
         zqLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsTDlqB6nq3+UVRnj4jnUzy0goNxu8qWXGZfq7H+dl145EvEuZmIPApPX/dcIigb/r6CTTYYksgRMJiLjgyQoWoWZG+4c41WZHxWue
X-Gm-Message-State: AOJu0YxOEeV9IHFCsYFjy/V8EIxzXNyzhWQL19MajPaXaLc5kERXXrF7
	T1BPsZs57ZqYrfp9as0olR3gO1oAkz5vhsc3X9mmxoXJVduDdql5urOTH27TYxA=
X-Google-Smtp-Source: AGHT+IFK3DO4c20czIEvbq5qRhqWcSTIKZNPs0uSrMmXkXhSNxR4GXk5EtfU0/1h6EjR3whEXfik5w==
X-Received: by 2002:a5d:994f:0:b0:7f3:b778:6966 with SMTP id ca18e2360f4ac-7f3b7786c2amr1445450439f.2.1719594988622;
        Fri, 28 Jun 2024 10:16:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7f61ce88113sm58879939f.7.2024.06.28.10.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 10:16:28 -0700 (PDT)
Message-ID: <53a6df2e-a160-48ec-92eb-44b1ee2d663d@linuxfoundation.org>
Date: Fri, 28 Jun 2024 11:16:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb/usbip: remove unnecessary code
To: Xiaobo Liu <cppcoffee@gmail.com>, valentina.manea.m@gmail.com,
 shuah@kernel.org, i@zenithal.me
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240625051321.63761-1-cppcoffee@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240625051321.63761-1-cppcoffee@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/24 23:13, Xiaobo Liu wrote:
> Both if branches assign a value to the `cmd` variable.
> We can remove the cmd variable and use `pdu->base.command` directly.
> 
> Signed-off-by: Xiaobo Liu <cppcoffee@gmail.com>

This is a duplicate patch and same comments and NAK on this
patch.

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
>   
> -	if (!send)
> -		cmd = pdu->base.command;
> -
> -	switch (cmd) {
> +	switch (pdu->base.command) {
>   	case USBIP_CMD_SUBMIT:
>   		correct_endian_cmd_submit(&pdu->u.cmd_submit, send);
>   		break;

thanks,
-- Shuah

