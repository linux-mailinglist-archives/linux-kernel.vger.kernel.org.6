Return-Path: <linux-kernel+bounces-335278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A65B97E36C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 22:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019401F21172
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 20:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C474763EE;
	Sun, 22 Sep 2024 20:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JblqszoC"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D666F315
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727037996; cv=none; b=E8GpC7H5DfYTuEQ0wqF6F1vFq9VSHiP7/uIrqqKaMJG0OULIy+IfIVmUggadDwqGQIQVfjAq4i2YBzZfLAv3gCec3YAdXgTIblT2PIxYi6al1o08qqjFbnA9l+FASnS2wgRbtjsahyuV5FZ7ZKy8ZGuV6HJBBxFTYU+Msj+OtjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727037996; c=relaxed/simple;
	bh=Y6o6Nvhk4MbbquwR3LkuwUeh4kcXCCAG6hiXOu9TYG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+FlXxVV8F2b8VPH3U9it0xM54yg4XkYMBcdw/EVIPl4q03LpQyjN118+rwPmSRh2n6QfhiWNdMEMmE3rPxjiGq+laA+tQ+BGn08gWT44IJWRLxfdY6jZeC477plxBFa7mYOIzeDqt7I3MAMFIiXrcpHXjZzL9yukGc92w+UXLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JblqszoC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so36425475e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 13:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727037993; x=1727642793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qylzz3Fel6izYnniiK3d6HMSKBRm/fSHsAY/NJaK+aQ=;
        b=JblqszoCYSQorKehBD4DaLQV0S4CMfwb21D6aQQVHPjtYuEMjM9QGSTZquzZ1kZuoh
         /IObpMYSI9havrQUfmGdDlKDUy7amqxU4AP5XwQcD9Iqv/B3rd1aS4Da6d96gzUbSVRm
         e7KxcvwrfnuCOlOZhSZJTKHEJlfoz0hPMRsiqKJFnod+O6dzmX6pYcG7jn7f8R1YA12Y
         V7DwRMdt+qXVYcIU4zuM+OEQ+pywWxbnnlLxNtdHkhjVq8SN2qC08FhQD1Wz5SSuV2j2
         RdFkeagwNTmbDqlYaUhsnujvsM6p7GUIAOyVRbZ5eimX8bGxgk1kYdYK2FqBWO8Jsqhd
         uKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727037993; x=1727642793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qylzz3Fel6izYnniiK3d6HMSKBRm/fSHsAY/NJaK+aQ=;
        b=EcbwRTXHHBgzdeE5VbP8C8ZxZRzTXglJTCbzTMQOThwOTTNC926Uaye+w87blgm5vf
         Sj4iGcbC4EpACo2yhY4PXuy5emyzX2aEoWbOq9M7QPqiosH7br/Rzna+xIACnT4+n/02
         i65UFogpkcDVTtp96IIviXu/UHHWd+9Qr6gU/U8u1xnNsK3JweSjD3osOYWZSOSy28kR
         73o9Md2tbvAqy8KKa4ej+EpUnegB9Gqr91DT8aNIkiTjuThXWgfHTtxDhzZlbiIs1XGO
         zIk1+fxyhXujhJvy7xoQksYmeSHElfHg68IwO9oZhz4p19eKsHwovkt/nfi2tM4x78qe
         pmlg==
X-Forwarded-Encrypted: i=1; AJvYcCUu67XzXvWIoGyoS0yUnIdAdiGWwpgrf9Y8PsnP54KroqaWKdC2sLUuPJTmlpIM1cb86qqiK5BEndwOwK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKEzFbEjzTCpeSctXgAn0nVO1t+nKDQegfQvSrUlWeRc+srh+m
	bduA5Ge6W+oIgWNbpu5V3AJNvSokRZZoir5N7AFPouG33qHXWJ0l
X-Google-Smtp-Source: AGHT+IFV/qufi5eb2P54dV2Z7QOxKzi5EVqRb7g+f6+3RUKkrEe6nXiEjZ8fwqTAfUHF0E6TZ3cctA==
X-Received: by 2002:a05:6000:1fa4:b0:374:cd32:f84e with SMTP id ffacd0b85a97d-37a43160b5amr6020141f8f.29.1727037993176;
        Sun, 22 Sep 2024 13:46:33 -0700 (PDT)
Received: from [10.188.212.131] (cust-west-par-46-193-35-178.cust.wifirst.net. [46.193.35.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754c5c78sm109226595e9.42.2024.09.22.13.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 13:46:32 -0700 (PDT)
Message-ID: <525a7e43-d8d8-4973-8e3a-ac6b53785d6d@gmail.com>
Date: Sun, 22 Sep 2024 22:46:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] staging: rtl8712: use kmalloc_array
To: Tudor Gheorghiu <tudor.reda@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
 Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
 Linux Driver Project Developer List
 <driverdev-devel@linuxdriverproject.org>, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <ZvBy2lB_ok_OCmVI@redaops>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <ZvBy2lB_ok_OCmVI@redaops>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/24 9:41 PM, Tudor Gheorghiu wrote:
> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> WARNING: Prefer kmalloc_array over kmalloc with multiply
> +       pxmitpriv->pxmitbuf = kmalloc(NR_XMITBUFF * sizeof(struct xmit_buf), GFP_ATOMIC);
> 
> Signed-off-by: Tudor Gheorghiu <tudor.reda@gmail.com>
> ---
> v2: Update patch description
> ---
>   drivers/staging/rtl8712/rtl871x_xmit.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
> index 408616e9afcf..a0f29fab3dce 100644
> --- a/drivers/staging/rtl8712/rtl871x_xmit.c
> +++ b/drivers/staging/rtl8712/rtl871x_xmit.c
> @@ -117,7 +117,7 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
>   	/*init xmit_buf*/
>   	_init_queue(&pxmitpriv->free_xmitbuf_queue);
>   	_init_queue(&pxmitpriv->pending_xmitbuf_queue);
> -	pxmitpriv->pxmitbuf = kmalloc(NR_XMITBUFF * sizeof(struct xmit_buf), GFP_ATOMIC);
> +	pxmitpriv->pxmitbuf = kmalloc_array(NR_XMITBUFF, sizeof(struct xmit_buf), GFP_ATOMIC);
>   	if (!pxmitpriv->pxmitbuf)
>   		goto clean_up_frame_buf;
>   	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;

Reviewed-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>


