Return-Path: <linux-kernel+bounces-278441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F77294B04B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B7F282AA8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3345143740;
	Wed,  7 Aug 2024 19:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="KWvGPu+T"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D96140360
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 19:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057784; cv=none; b=L7IRdh86lppiJkhmBaBGHs7VheHl7A4H13ROR8wIFE9pj+KGJaq6h6kX0UaG+IWvLukZVI+Tz4LUCIp3oIhxSOKe651CdHpfTZjxjavwBDLlwJqYgAkQ20JCPb1FvMiut/VkAqVInUCakGCv988GgEEIPpI25ZefnTYx7cHp2ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057784; c=relaxed/simple;
	bh=665V6GpuKcYosGxkSGgs5JFtAN6ecNLGWm3yl28vOjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHBtBm7Q47mrfRAqN601TLIjfmHp6PbYwzHeXhIHH4+yCgO3ScSyVUYMQbsZJ12GJobkPbmbwl5ULQjK2Gm4+VfMekVHsiuR/c3aLmD5jwBrwSmuJfM50GapOvHA1TWc6BEmEtIrt+bOSA3K0KUyJLOdX9ljfdZmRsSM4PAbgq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=KWvGPu+T; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-710887a8083so189815b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 12:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1723057781; x=1723662581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xNFT4KC4ST1CTLnmvPUzLWyegQdM89SKEORmSJFJTX4=;
        b=KWvGPu+TS5vmmAj2iQa7fYl+qaIWuGrQIZkiM2nBfemNzK9y3sS2qmYOpagATt6hjx
         DlGfxMGZ3EcZ8xfK282vpjbsRzTfzOfSx+ANr2xb9QBWoto8oBr1qjMz2sCI5bAGXWmn
         5r7QyJTLpsFC2XYtiv9qD28txCt4ayaIQ00QY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723057781; x=1723662581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNFT4KC4ST1CTLnmvPUzLWyegQdM89SKEORmSJFJTX4=;
        b=Qwj6y6pvLGrfB3MfHQ0cFfiBWsJodsvPLw55HNH3zE3o2ncLIwzDiOlRLSB13718sV
         2AXZN/+EK4DcRknhiRyR3yZRh46nOmR5K1VbD6/N/y3KOv6GJh6zSYLX/XQQb7aieaKU
         G2jIZdVKcukndDambtjy8UC4ZNrRjtuZyisl9KmuA3ahGFnMtktLhfucrz9xBJZYdIpF
         o1EyWtsdgPCmAq9Sz2sA20vWksjUHrGbBCeLM7D1WzN12CiOG1psCdfSQh/5/j/GNmSt
         7bH8wWnRJx1sPaa6th88JYDXgwY1fEul8eYc6pQjvGjpuiUUgGQoYqsV+a5z2GIWQHRL
         fUFA==
X-Forwarded-Encrypted: i=1; AJvYcCX+wwhDXRKJSrAzUr86BlKj4b1a36oiR2JAMOzaYmSI9HKJ92iZCu1SMohHDv5lYLososAa62oAFbpx3g/YXaMQiuo/EAmjCmrxXTSc
X-Gm-Message-State: AOJu0YzBWDfy2iCw0TQ47VV7F1UEo9NjCJ69DK3FlJ52AnGaGUKi5xt8
	rdQy1aQ2WJi8CBo129p92npl4GKiR9B+IuInqaeiJcKU9aLrwzpa0EEg0TIv4g==
X-Google-Smtp-Source: AGHT+IFHaj5wmHCRYIyICHWw2PDkOtSbvnqBki+fv41wkCuVHTFqZ+Xbandv0IN2SZchWx+iyQTZbA==
X-Received: by 2002:a05:6a21:3989:b0:1c4:9f31:ac9e with SMTP id adf61e73a8af0-1c69960e243mr15826576637.42.1723057780573;
        Wed, 07 Aug 2024 12:09:40 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecfc35csm8989130b3a.149.2024.08.07.12.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 12:09:39 -0700 (PDT)
Message-ID: <a3bd82fa-eb27-4a71-96d8-c768b9866bf1@penguintechs.org>
Date: Wed, 7 Aug 2024 12:09:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] Bluetooth: hci_qca: fix QCA6390 support on non-DT
 platforms
To: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240731-hci_qca_fixes-v1-0-59dad830b243@linaro.org>
 <20240731-hci_qca_fixes-v1-2-59dad830b243@linaro.org>
Content-Language: en-US
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <20240731-hci_qca_fixes-v1-2-59dad830b243@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 8:20 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> QCA6390 can albo be used on non-DT systems so we must not make the power
> sequencing the only option. Check if the serdev device consumes an OF
> node. If so: honor the new contract as per the DT bindings. If not: fall
> back to the previous behavior by falling through to the existing
> default label.
> 
> Fixes: 9a15ce685706 ("Bluetooth: qca: use the power sequencer for QCA6390")
> Reported-by: Wren Turkal <wt@penguintechs.org>
> Closes: https://lore.kernel.org/linux-bluetooth/27e6a6c5-fb63-4219-be0b-eefa2c116e06@penguintechs.org/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Was this commit supposed to have a Tested-by: footer for me?

> ---
>   drivers/bluetooth/hci_qca.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index a20dd5015346..2baed7d0f479 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2412,11 +2412,14 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>   		break;
>   
>   	case QCA_QCA6390:
> -		qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
> -							   "bluetooth");
> -		if (IS_ERR(qcadev->bt_power->pwrseq))
> -			return PTR_ERR(qcadev->bt_power->pwrseq);
> -		break;
> +		if (dev_of_node(&serdev->dev)) {
> +			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
> +								   "bluetooth");
> +			if (IS_ERR(qcadev->bt_power->pwrseq))
> +				return PTR_ERR(qcadev->bt_power->pwrseq);
> +			break;
> +		}
> +		fallthrough;
>   
>   	default:
>   		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
> 

-- 
You're more amazing than you think!


