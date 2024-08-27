Return-Path: <linux-kernel+bounces-303955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEE696178F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CF40B231C5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA591D31A5;
	Tue, 27 Aug 2024 18:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5EBZPEy"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730B81D67A3
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 18:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785005; cv=none; b=aC6rAokieT9C+x9hYy2uFefdDs82c+Hm36DBI7lXKoqXt5Qk7r3fbTbpp7as+YJhWGAqPJ3Fntxgva4itfJh+5CEMpKBslPcybbX91haOQAY3V+/uGIS+N4pNjyv7HvHykcZgRfo1kjXtdBkL2cdTJxnDaL3gHYDdfkS+EAOZDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785005; c=relaxed/simple;
	bh=8W8DJtG5QwzrHLO0o5WOxAdUoditAnTyTjRHnSdGC6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mBWPWOjEFX1OM/VCX4Q2EVMIiFJSzRlAXP8GFmPDVF/j3n1hNQIoPZoMnaXNjbDPaZO+4KlNaWjWI1qCNFetlzZ+/h5plvkBpqWhfM6Vq+xYJM4ukoUTsQnDWspO75ApfeLI1SIm4v8SU4M8LziaOyKTQtxsBj3+qmdPva868IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5EBZPEy; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7aa086b077so531078166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724785001; x=1725389801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DHMNkKWtG7xVVsPKFmS7u1mfT0PBjzV9td88vcbmAaE=;
        b=R5EBZPEylcNoqDBgVcuSXWZSXvJitgtSx0uYYfAEv/IJp1Qnme7RSdJlQ2zvcPCwuc
         luQsNuN7c3bPTDZL2h/AhrNkewU1PyXevxIvovCXxcTzZDxOj2WDanPxMiaMFW0S5YjU
         9Dl73Qy8VG6QqSa3KoehyuQQP6Fe7UjKDNOAeLwmXWDZh7nSqktg0oEygcql56ZzjT1I
         qvB1DS+5kJYu4SIuAwyuXOYGPImbfmagkdvwiaIUsfektaMn5S2YRXr1lMJIhHAZITEs
         oO1zKioHAuCuPYbFyA2Mj1CW1dqu+aCUhf9/p8LAbBrSB9DNDvUbQ0nlm7fnygMdHlnw
         SQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724785001; x=1725389801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DHMNkKWtG7xVVsPKFmS7u1mfT0PBjzV9td88vcbmAaE=;
        b=ghw+N1+3HOPNPZAzE8GPZJY96Th3Y1TGVuev1ySQSFeGI8weRWc1Hja0q7QrFW+r1k
         1kQGfcb+Erk6O/1owEj6EoXTlyoiGY7iiGpzHdxPoh8efg8JmTk8F+PN+XFK9V55190B
         K5/QGp4axfzkKdWXHc5V8CXmOxjkF5nUlQpgKdCtkoBHjvY1E3pK5e3MvrxoRk6q+uOY
         pJOEKmoc1/tpq3OvgPnih+2C5RcUA57KBm3fNPuafcUCa153ws3FxGl2lbA+g47VSi7L
         7jv+h5fKjoiSc+3Cu/Z0yeMexBjxKrfBDgGdUUb2PT6F6zoYMAkrWwdET7cLXiI4nWDE
         RRAg==
X-Forwarded-Encrypted: i=1; AJvYcCULsGlByYgMZvBtSqXkIRpVoajdW1ZTxR6U30PmwGEPfiiTJrz5QX+MFP9U2SKs2RJ6pvoSk160pOBWBDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YygUHB+U9yuiyIjsRQuH/qboV/3KFG6VqzCUDKKvT+rKa2RJ+lw
	Lw8dKD+O/KcSqDrt6M1bw8Nb5gYA6GA752Mjxh4qaJOlZiQ+CuBV
X-Google-Smtp-Source: AGHT+IExs9LhDfQlxwMpO9mGAhnUUj5Fw8KLiH6bxOVbhU71h8AnU3vXmI+pZuiVbj6GVT0XMtV6yQ==
X-Received: by 2002:a17:907:da4:b0:a77:b516:3023 with SMTP id a640c23a62f3a-a86a518b2b2mr1141809666b.4.1724785000369;
        Tue, 27 Aug 2024 11:56:40 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8589:9a84:3869:ee20:88fd? (p200300c78f2a85899a843869ee2088fd.dip0.t-ipconnect.de. [2003:c7:8f2a:8589:9a84:3869:ee20:88fd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549ca7bsm143038666b.52.2024.08.27.11.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 11:56:39 -0700 (PDT)
Message-ID: <3871ba3a-4742-4106-89a7-8fa8deb6598e@gmail.com>
Date: Tue, 27 Aug 2024 20:56:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl87212: Match parenthesis alignment
To: Dorine Tipo <dorine.a.tipo@gmail.com>,
 Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240827081845.GA15504@ubuntu-focal>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240827081845.GA15504@ubuntu-focal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/24 10:18, Dorine Tipo wrote:
> Fix the parenthesis alignment in r8712_read_port() function to match
> the opening parenthesis
> 
> Signed-off-by: Dorine Tipo <dorine.a.tipo@gmail.com>
> ---
>   drivers/staging/rtl8712/usb_ops_linux.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8712/usb_ops_linux.c b/drivers/staging/rtl8712/usb_ops_linux.c
> index 0a3451cdc8a1..4a34824830e3 100644
> --- a/drivers/staging/rtl8712/usb_ops_linux.c
> +++ b/drivers/staging/rtl8712/usb_ops_linux.c
> @@ -221,7 +221,7 @@ static void r8712_usb_read_port_complete(struct urb *purb)
>   			fallthrough;
>   		case -EPROTO:
>   			r8712_read_port(padapter, precvpriv->ff_hwaddr, 0,
> -				  (unsigned char *)precvbuf);
> +					(unsigned char *)precvbuf);
>   			break;
>   		case -EINPROGRESS:
>   			netdev_err(padapter->pnetdev, "ERROR: URB IS IN PROGRESS!\n");
> --
> 2.25.1
> 
> 


Hi Dorine,

please correct the typo in the subject. ("rtl8712")

Please make your "Subject" line more unique. Consider that we may end up 
with having dozen of commits like yours, all of them referring to 
different removals and all without the necessary information to tell 
what they differ in (except the driver/subsystem). So it would help if 
you add the changed file or function to make it more unique.

Please use a dot to end the sentences in the description.
You described a why but may be you can improve the description with the 
why for the reader. For example by adding ... to improve readability.

If you send in a second version of this patch please use a change 
history. Description from Dan under:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Thanks for your support.

Bye Philipp

