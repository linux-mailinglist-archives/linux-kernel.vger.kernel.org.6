Return-Path: <linux-kernel+bounces-267996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D067941F2B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96C25B2527F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604D2189BBB;
	Tue, 30 Jul 2024 18:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eG1+Yg2u"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BAE183CD5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722362552; cv=none; b=UrImRarUarW3MugIbH/m2hykpUEH9BNKwL7sNTap2wQxsKnFx/HLu/7GzWeDXHGTl9hxdmucSd86Xq5i0zZaWA11ybIpMJuAKzT0V+NRilYFV5TpYZnPXz3F2u4S5VLcj5+g2lMlDbJSyijXNxmkmhfvCDSQ4319wDV0IFYCHWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722362552; c=relaxed/simple;
	bh=dGxHFcazl9CZ90JzERa3tmONCOwErs4hWGyTxMLGSew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tAasQOkfQrDticrMjRXr5jEMDQmmEkFcmibzNY4y9yggr2zLNiy7UBMOVg4mBKC9GWAQ9TEKWVduOzJdQFV53aT/uXmNMLCfBYiUM8QWc6Ifawz87NdaEpH1EVpBm+N+joTMcv4B9eYRr2OHWosOmH+VzjZBURr17SQY0aKcU2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eG1+Yg2u; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a9be21648so60328666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722362548; x=1722967348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v0BE6LG9AKH6KqSFQojwgZTXGggkIs90XPNvvVsB9SM=;
        b=eG1+Yg2uE7nlCGmh03GfDha+7Yu/yGMEMxp8BYdPBFp/fq+Hpn0rlqKsDix4WwBf5p
         HimJZ8sxWZbco/nvRDvw2oulPW6k/6EGZOIg+z++Pf3qzL4t1+NIEHEh0XZ9meOo/fE1
         pCvqql3/M3+JSBCfpbXuYpiYKkoBl7FKiSLASl6kj7LmfRpP7q1QkqAxTGhyZQ3EfyXN
         yHwxgym++/cIdKVN9QGOI4t4xoWtruXqHjbYVhUbEDpg2ZjGwBw3QXC853jwVBYCQwyk
         QKiwIBlDQzmMknjid8Qa+5/RechvLa4Bck7tAWqt5K7szgvj0d3EhVRZ/8z4Ylm8ZUMx
         aiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722362548; x=1722967348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v0BE6LG9AKH6KqSFQojwgZTXGggkIs90XPNvvVsB9SM=;
        b=om073kQ+OTwmrVv87CaJmDIPAKjHpmqYvR0zcLmUy+bYJp9Fgs417dwWvrqanz9efv
         Jo4weqfD4LQHuiA5Y0yUMMeV5/7td19tsK68n8g6+6Thpvt5pBlv1rqomWqoWOnVnv4Y
         fBfwAm9d+cLjFkwdt7BoO3iB0Ben5LwSVWqMBfSg8CjHV1qlWQLSn9RoHvrFxuutA4Bc
         tD9l1IkMm+JV/TpAlA7Jbt6rO1pOwYEWD3XLy+3U8o2d66HoREWbRQRvM7c/mCcDfKuF
         dDwgH55a0yZOgh7eGbB9pfV1DCoNgcKZzFnTo4EMn6xNBkpIX5AUIF61oMbiqht5B/YN
         3l1g==
X-Forwarded-Encrypted: i=1; AJvYcCWE4JoKIA6Qg5xyzEc3evtUB/3j78rzSywktms9nOC1ScjVE1XTC/ANr9XUWyVRG3FCgIsW+G0clPwkGnY4KiO7BlCeQVwdI9njqM07
X-Gm-Message-State: AOJu0YxWq+YjBSgFsjT3p542DtJjZvmuXVKnTzt5qhYtj6vpNXZR+sUI
	artTuh/QcMy6meriDdb4AodyTXWaEoPWaRj2gr6LuR5spFY1pJ9d
X-Google-Smtp-Source: AGHT+IHuRvMNTK9iD08DZUMuYiwH4P9y0lJbYNv2H4zQwp4YCAnwg7/jLFtubFZcEVnK4YXmud6lnw==
X-Received: by 2002:a17:906:6a1d:b0:a7a:a763:842a with SMTP id a640c23a62f3a-a7ac5a5b78emr797585166b.8.1722362548088;
        Tue, 30 Jul 2024 11:02:28 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8552:f0f5:c00a:214:55c4? (p200300c78f2a8552f0f5c00a021455c4.dip0.t-ipconnect.de. [2003:c7:8f2a:8552:f0f5:c00a:214:55c4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad41027sm671648566b.122.2024.07.30.11.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 11:02:27 -0700 (PDT)
Message-ID: <d4eb021f-bb35-4f7b-8be8-319907bbff63@gmail.com>
Date: Tue, 30 Jul 2024 20:02:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8712: remove trailing whitespace
To: Felix Yan <felixonmars@archlinux.org>,
 Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: ~lkcamp/patches@lists.sr.ht, helen.koike@collabora.com
References: <20240730063746.176245-1-felixonmars@archlinux.org>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240730063746.176245-1-felixonmars@archlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 08:37, Felix Yan wrote:
> Fix the following checkpatch.pl error:
> 
> ERROR: trailing whitespace
> 
> Signed-off-by: Felix Yan <felixonmars@archlinux.org>
> ---
>   drivers/staging/rtl8712/rtl871x_cmd.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_cmd.h b/drivers/staging/rtl8712/rtl871x_cmd.h
> index 2613b3c2acfc..268844af57f0 100644
> --- a/drivers/staging/rtl8712/rtl871x_cmd.h
> +++ b/drivers/staging/rtl8712/rtl871x_cmd.h
> @@ -736,7 +736,7 @@ void r8712_getbbrfreg_cmdrsp_callback(struct _adapter *padapter, struct cmd_obj
>   void r8712_readtssi_cmdrsp_callback(struct _adapter *padapter, struct cmd_obj *pcmd);
>   void r8712_setstaKey_cmdrsp_callback(struct _adapter  *padapter, struct cmd_obj *pcmd);
>   void r8712_setassocsta_cmdrsp_callback(struct _adapter  *padapter, struct cmd_obj *pcmd);
> -void r8712_disconnectCtrlEx_cmd(struct _adapter *adapter, u32 enableDrvCtrl, u32 tryPktCnt,
> +void r8712_disconnectCtrlEx_cmd(struct _adapter *adapter, u32 enableDrvCtrl, u32 tryPktCnt,
>   				u32 tryPktInterval, u32 firstStageTO);
>   
>   struct _cmd_callback {

Hi Felix,

your patch was already accepted. May be you take the previous 
information as a hint for the next patch.

Bye Philipp

