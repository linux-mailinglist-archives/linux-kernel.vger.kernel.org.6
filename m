Return-Path: <linux-kernel+bounces-388764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2C99B641B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214B22833D7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1AB1EB9E0;
	Wed, 30 Oct 2024 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w8f6Nwe2"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927E71E32B7
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294959; cv=none; b=BgaoVz63CMk4ZTR+ChLtcsc9DwnC9aECPfE9X+U9JzeX7UjNRfIPgJc5xdLEbIQ1vwRFYsxzn2nf/ieSekESbSg0K7ED7w23J9gqspoLLOO1FZOfqhF/iZJAlhbEpIl1Otot9sOHU/nolNsPtt/yJ43gZjLRmbK8ofxElSF5ASE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294959; c=relaxed/simple;
	bh=rcLE83f8I5rl8ZtZIrZgOnTLuwTtp/g9tS9d1ZU8SuI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dwXnT9S4KDc9+0+7VZvuWPhdBAyFWfIAJJrjT2Ku6qQ2BArr4Dv0Uk1Gx0/u8VKIWEcjTAWepxCy57AcJC2WKvkfAbenvVaSeJdQ8R+J1Uqh3uxOvTEWU7s885XJQQniEYhWvFjLrN57CWLhp8nmdpA2xH85Ye6MYJ6vxyxrvHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w8f6Nwe2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d518f9abcso4677575f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 06:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730294956; x=1730899756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rcLE83f8I5rl8ZtZIrZgOnTLuwTtp/g9tS9d1ZU8SuI=;
        b=w8f6Nwe2Lvw6fY90d7sWFp6pWD0lWV9p0z6lJ5/eVjsaJiivlR9ajTQbRbZsF5dRr+
         r5RBvcTJHlsmOazfq7+OyUOLsQUYQ1y7MxWAadXX4ZcTco1Mvf5QUvlV/IYTBFwc2WRf
         vIhytAaZhAfNqemQytcQD/2CqpgSx99caBYvZRoIusFd9zfF5g4OuoPV7qGKNyqYKmU6
         JfC9HpL4aeUF1qHs6eAm6CQqu9nHGEjuHij77tZ+DIq9BwA8bsAJfWTJpWgdeQVMOnk/
         b44qw/RSR0rTNJcrf0atYEZzyg4Jbk7qTAOxtwqhv5F1/VXTLp/kxhmybcF6ifkfK9kp
         97CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730294956; x=1730899756;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rcLE83f8I5rl8ZtZIrZgOnTLuwTtp/g9tS9d1ZU8SuI=;
        b=F6TPHjUpmyP7KZD4yZ4fGxnX954A8LVG6nKL9RtI59lUYe2UZeYUyawxPZjE12fmqv
         i33RILezRMtdnZZhATYLo9U3aVXOEmqkDEZCrMLVkRr+Oqfhb/9DvMQrlmocbtxtmyLl
         ikc+dSE4IVBbjdXliBAx3Hn238+NtwylKLDfNNIL+/JfKqchyFysFbOp3PZU8DSlH24w
         9G9iRjFrSUUDxmn9dcx+SfUCv770Qaw5IuLqOXbyw2iZesGfXwEvxur6KGjWTE0Rjklx
         BGEpUC00cd9zoECcfcaWgDQG21bjYUw1GOxbN9G38ZAQJTRiT9qNGgEIjWhLVetRgecT
         ToUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlaeehhbYf6KJymmOGyfLhgCholDLAH+EZH+/zbh+P8i0uI+8VW2qGI9ay7190kOigq2QLOzWhDtxrm6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbQpiQqJp+Yd20hep98WkYTnFIbHWrVAua0kWC1zTeOdPB6woH
	p3oUD4J5TidyKNGA1GNw+MU8+epozkf9HrVRpHax1wTcaGxstO9BM4y19+uWWSw=
X-Google-Smtp-Source: AGHT+IHp5AbAqgjQIgwYYwcTFJhtpBHYbLWugEe1xzPeyU3dGtA9O/+opSkEXa/XOrO9WuCxMOGUqw==
X-Received: by 2002:adf:ea43:0:b0:37d:633a:b361 with SMTP id ffacd0b85a97d-38061206c0cmr11906179f8f.51.1730294956053;
        Wed, 30 Oct 2024 06:29:16 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9a9a53sm21657955e9.30.2024.10.30.06.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 06:29:14 -0700 (PDT)
Message-ID: <8e2a327a-5efc-4ba3-afa2-387099967468@linaro.org>
Date: Wed, 30 Oct 2024 13:29:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] scsi: ufs: exynos: Add
 EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR check
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, alim.akhtar@samsung.com,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 avri.altman@wdc.com, bvanassche@acm.org, krzk@kernel.org
Cc: andre.draszik@linaro.org, kernel-team@android.com,
 willmcvicker@google.com, linux-scsi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 ebiggers@kernel.org
References: <20241025131442.112862-1-peter.griffin@linaro.org>
 <20241025131442.112862-5-peter.griffin@linaro.org>
 <f5ac07e3-3fde-4ac8-8cfc-fb7918ffb2a7@linaro.org>
Content-Language: en-US
In-Reply-To: <f5ac07e3-3fde-4ac8-8cfc-fb7918ffb2a7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/30/24 8:56 AM, Tudor Ambarus wrote:
> tx_linereset_n, rx_hibern8_wait is set but not used anywhere. Can we
> remove it? Not related to this patch though.

Sent patches to remove these fields at:

https://lore.kernel.org/linux-scsi/20241030132649.3575865-1-tudor.ambarus@linaro.org/

