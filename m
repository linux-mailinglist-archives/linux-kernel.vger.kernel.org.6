Return-Path: <linux-kernel+bounces-331434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5577097ACE0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E51CEB26CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B018159598;
	Tue, 17 Sep 2024 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SRauZwM4"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF59135417
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726562006; cv=none; b=KpLH7J0u17zN2BU+vlpY0zkoQgV9a5tyiMvPSl0DIOCOkVTvlr6SfC9MqEImPN5qL0nxP5ZnX7249NTb2Jzr/eBlv6k4fq31Ac+rlGM0luUKw7Q2z+9oK627pCwRFcD4tjPs4iQ5RVrvLQdvRnlVZ910tRVhFHCG9H3KR9sDPy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726562006; c=relaxed/simple;
	bh=iE2Wv0+cvG+2aZXxRAF3RlJ75YbC/cTAt9RJEO8/fHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rbCRRlAHsxxrxA16N/HHzt4IcviqFs2DgG3Q2SjKdbCFEFQn0AQXejZxAVdHq1dBOZ22DUNWM94LAc61dWO7WHvwRy3xnyQR9by13AKU7tYiugnmPMgfFlQiNoCzdhhncSW2XU/1/zYXlWqUrTSryZvvP2mMMEQXKmajfAJOQwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SRauZwM4; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374d29ad8a7so3768458f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 01:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726562003; x=1727166803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uaZq80rKA8PR8arvgj14dSjlnVlXU4VT+sLVAjweGL4=;
        b=SRauZwM42G6Xa00/XBZ2NeTSacSd+kn0+obCBNuVj1l+QpZQDISie/gcfB92flBvl1
         Q2eETmWFBLopQtl5CEOo2H3lkxuITkkd8+/6n8GBIc4U7xA/uVDT1rm+auvJZgyOdYco
         F6RXDyJY6gdzNVmjmtk054YdVuOy4cqLoTgiTinOETQoD1PqH9cx6/YZMSqhSeHMYZQ5
         co0/NZINcqxy8cfbO+qsvaTeOmPCAEQsUdPvQEJexPGRSU4fgWghggPj93vB1a3njphT
         zUkxi5tvCel2dT6UYNMFNL+ox86NQouy4/8L9Jf061BYCwyH3Rt88whvXG722rgMo3ap
         3WyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726562003; x=1727166803;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uaZq80rKA8PR8arvgj14dSjlnVlXU4VT+sLVAjweGL4=;
        b=hzxpCGJ6ck33BLSYa9GjkezRiSNDa7chpUnk6tSh3CEbVBd5/Fuj3FFGN7un30kdW4
         PoCx0OKK05O4UXAD2OdnWlA3He5nrm/u6i8kubqV9gG23jVxpH+6NWlWeyos8Nsiyz02
         02zd7Y1CIKYIX0AsBZbUEFmMrRWM6c4+t61G/yLLhbhxAty0WrXcMtHeOMRe4ZgvD06O
         fyMTXM1hCV8AEwVAeWLRGtfE5F/Pn2GFaMa+C3Fou0nkcC2S2HB6OWxIeN5zOyoXfrw9
         IRHbEh2LHcC4PtRcePrqO0mnkSt6rui1dA9UVzoOFD1kRndGJdI4LlVEfYusBi+yGpyF
         XcaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPOT9+B4EwAn+k3fqBIxwzSH8S7qIsFHDpS3/hkIXlxiK4nf40mfRWXiC3urMMIpC8Z7WAkmgor8zSUiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Pgk/+cIEC4foAUnD9EyWLZsO1U02MbM5viuTaHgG+fUu5nHp
	72RYXz1URzqKVKcEAJ7cWXW/zgSLTcqkJ+kXkjqXYaUdoACQKpKMvWtdyy1BSqQ=
X-Google-Smtp-Source: AGHT+IE18tMydtbEAct5RuY9jItVP08eE6+B7i44g5FEd+bUiIHVt16rsPdFoWrSWWWG6HoY9IImXA==
X-Received: by 2002:a5d:4983:0:b0:374:c1f9:ea79 with SMTP id ffacd0b85a97d-378c2cd5e5fmr10660845f8f.5.1726562002356;
        Tue, 17 Sep 2024 01:33:22 -0700 (PDT)
Received: from ?IPV6:2001:a61:13ed:c201:b884:edfc:abaf:1cf4? ([2001:a61:13ed:c201:b884:edfc:abaf:1cf4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780e14fsm8894819f8f.117.2024.09.17.01.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 01:33:22 -0700 (PDT)
Message-ID: <c96e95c2-aa59-4ef0-b211-c1cea71519ea@suse.com>
Date: Tue, 17 Sep 2024 10:33:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: use mutex_lock in iowarrior_read()
To: Jeongjun Park <aha310510@gmail.com>, Oliver Neukum <oneukum@suse.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, colin.i.king@gmail.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240916040629.28750-1-aha310510@gmail.com>
 <2024091648-excusable-unfilled-83de@gregkh>
 <15bc0f3a-5433-43e0-b0b0-8b9c26dec165@suse.com>
 <CAO9qdTHrbG-aWetpM_e7zHUhrwPD=7uCHPbWSMoorgnwjKEOmA@mail.gmail.com>
 <bf971924-9d91-40a3-a4c2-5b518e2ce2fd@suse.com>
 <CAO9qdTHWfYv8u-gJqGkuG_OSdkU9c=qZSnEbE+zCYWG5bT6r+Q@mail.gmail.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <CAO9qdTHWfYv8u-gJqGkuG_OSdkU9c=qZSnEbE+zCYWG5bT6r+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.09.24 08:23, Jeongjun Park wrote:
> Oliver Neukum <oneukum@suse.com> wrote:

> Okay. But O_NONBLOCK flag check already exists, and I don't know
> if we need to branch separately to mutex_trylock just because O_NONBLOCK
> flag exists. I think mutex_lock_interruptible is enough.

It will still block.

> And the point of locking is too late. I think it would be more appropriate to
> read file->private_data and then lock it right away.

You are right. dev->present should be checked under the lock only.

> I think this patch is a more appropriate patch:
> 
> ---
>   drivers/usb/misc/iowarrior.c | 41 +++++++++++++++++++++++++++---------
>   1 file changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
> index 6d28467ce352..6fb4ecebbc15 100644
> --- a/drivers/usb/misc/iowarrior.c
> +++ b/drivers/usb/misc/iowarrior.c
> @@ -277,28 +277,40 @@ static ssize_t iowarrior_read(struct file *file,
> char __user *buffer,
>      struct iowarrior *dev;
>      int read_idx;
>      int offset;
> +   int retval = 0;
> 
>      dev = file->private_data;
> 
> +   if (mutex_lock_interruptible(&dev->mutex)) {

This blocks. To quote the man page:

        O_NONBLOCK or O_NDELAY
               When  possible,  the file is opened in nonblocking mode.
		Neither the open() nor any subsequent I/O operations on the file descriptor which is
               returned will cause the calling process to wait.

          

[..]
> +unlock_exit:
> +   mutex_unlock(&dev->mutex);
> +exit:
> +   return retval;

The rest looks good to me.

	Regards
		Oliver


