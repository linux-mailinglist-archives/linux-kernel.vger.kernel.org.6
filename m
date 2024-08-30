Return-Path: <linux-kernel+bounces-309348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A075966938
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03CD31F25099
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525781BC099;
	Fri, 30 Aug 2024 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCCK/E+2"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEC114F135
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 18:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725044240; cv=none; b=MvUAQ3/zCVyHUVtuJqJRwuVORMcgxHmBelS4WckDW/opSVrYxTMYDN6sMUSTeZy5eTKqETyr6AgxsTJNLwFIYXE8rAyj6oYrcwTxSMyvSsbwx3jbTRYa6gnbla94upxzabA4Vz7w0XZ/Jh+JnSWZNAwTszZIcHGU9nO+2ae6gmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725044240; c=relaxed/simple;
	bh=rvX/dDgBSvlVL0izU5WpcjGqdz9GGibZxL4sSXYenXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HJCvG6Vp7wfLs1JeYOlHazEVcNtnD+KyKGgzII/Qdokts79XGF6sJg/xnCko/KWN7DCRaXGm41aMVDMSk9t3KRPM7cjNbpuZkPfb/KBmKiE95J1Iup4MJEAXtQvuPs8gsqmKNb03kqBf5Bk7hEGUdPzC20yh5q2lDjUP5DqXmm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCCK/E+2; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a86cc0d10aaso244852166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725044236; x=1725649036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rypafLFMFg5+ACnGvncHfDlgMeufA++ocEnyXpczDK4=;
        b=QCCK/E+2SQdjzjU+sMljZ0cKGbbw4RN1eubufQRCBX9fi2apIITME4+7Xna5peuFYN
         mpYQapScbsAVxf2FzJZnF09BHegbY6A81awyXBU0OQCw/KQZ3P6uGv+Kq+GDzYYNx5nf
         JO/d7nEH1/fnMHeW1qJqhb/W+ewl71anAu6QTdG91TOMGhccS1e8TySEFKtwC38PgCjU
         nG+qA5Al4WT8TfFV+hIcA38OuGzPKg1JuQ1Z+eZih3kiOhAkZ04LkkBPQjYkkMnh+aG0
         K1ljrYvo9EyCYSmbOITHThyHx1bm/Dlhn9IVM9Vej4yHfhdOU9ChPhidyzSYIU8BSA3+
         dMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725044236; x=1725649036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rypafLFMFg5+ACnGvncHfDlgMeufA++ocEnyXpczDK4=;
        b=aqYjJMXTTurXn3PpWnpru8d+vVnEfzShDMvFugl+wUMYKeDXk6yNB03PsVPSU38p+D
         0Atx0+kJMuk3vQDYt7tx6tDQCLx8qtV/7FEw3f0h6mbUatJFrJ9R22pOHtb+1pDX12yf
         vlJxj2b76U1nyUT05tJsKQi1uwR9uZoKfj/s2mBQ4/lA8X4ch56xgdk0F+7qqcQRXzzz
         RwEBCxHTI+zdEIU3o0WEmEQ5DUX2DvoB1GSK0oO7ZRJI8ZUHxVZ62mXFShTosJfreM9N
         zZnuy8syGi2l3NTM4jTxYrb0KVyHDyptEFfX/QRiB110NUBbGAD4buGF6ODMWbRbMxqL
         Cybg==
X-Forwarded-Encrypted: i=1; AJvYcCXtZiFX9UIDfYvKyx2+8OHWy0ebeEXvxI2zsglQJD22MR84Q+mQaUExXbcCtMF/NdkvKbwIWtGrP6LdC58=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhOBF6qEf+iq2XEqBCjAoqTMnyZJeyKrtfKfhyExUZHwXOt81M
	qsfdF3rrM81XdUThUpsys1Pqfkt3lSn7bsDK+qq4uVhbFkdOjnW+
X-Google-Smtp-Source: AGHT+IEwzDsiIilTOBnxKPwDu4FaomR+DASGJ5X8afzwDXzpevmTO3JZzR6pzbAFc6AMu13BByD3uA==
X-Received: by 2002:a17:907:94c2:b0:a86:993a:93db with SMTP id a640c23a62f3a-a897f92021fmr651788866b.39.1725044235521;
        Fri, 30 Aug 2024 11:57:15 -0700 (PDT)
Received: from [192.168.0.104] (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89892333a0sm241142266b.220.2024.08.30.11.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 11:57:15 -0700 (PDT)
Message-ID: <2cb71c09-f64b-4ed3-9c0b-88c12d418a5f@gmail.com>
Date: Fri, 30 Aug 2024 20:57:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] staging: rtl8192e: Fix parenthesis alignment in
 rtl_core.c
To: Gabriel Tassinari <gabrieldtassinari@gmail.com>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ~lkcamp/patches@lists.sr.ht
References: <20240829214031.4893-1-gabrieldtassinari@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240829214031.4893-1-gabrieldtassinari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/24 23:40, Gabriel Tassinari wrote:
> fix parenthesis alignment in _rtl92e_qos_handle_probe_response to
> silence checkpatch warning:
> 
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Gabriel Tassinari <gabrieldtassinari@gmail.com>
> ---
> v4: Remove line number from subject
> v3: Adjust the indentation by adding one space
> v2: Include the modified file in commit message
> ---
>   drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> index ad21263e725f..75192041008d 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> @@ -322,7 +322,7 @@ static int _rtl92e_qos_handle_probe_response(struct r8192_priv *priv,
>   
>   	if (network->flags & NETWORK_HAS_QOS_MASK) {
>   		if (active_network &&
> -				(network->flags & NETWORK_HAS_QOS_PARAMETERS))
> +		    (network->flags & NETWORK_HAS_QOS_PARAMETERS))
>   			network->qos_data.active = network->qos_data.supported;
>   
>   		if ((network->qos_data.active == 1) && (active_network == 1) &&

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

