Return-Path: <linux-kernel+bounces-553833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D58D3A58F97
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C3E188FD75
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF8F2253A7;
	Mon, 10 Mar 2025 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vNSh+uea"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C2B225397
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598772; cv=none; b=P58hqCu2rn7LnuQtY+zj9cASP5Fq2wTJZ8v1GRo6qtGxT2Kmd6M5bSKJotaNShcz5qjFTwMlwackYMEhQYNqPSshNN21qGoYHN1jmPzJvTqVssosooeMVfUf5vaKbKhYe3Bfyp0YLk9ya62kRJ2OB4/cpmCm3Hr0BpJhLXxlLmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598772; c=relaxed/simple;
	bh=aOyHK5kOgLtc2TGKL7MhAhtvR0ch2AVZcT+44SP+rpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MOLcD0xCSQ4yrLU1ueYRUArVHVRTXHx4BecUq5A2OKD6UP5Jf9TMP4c/iKo6z9NZqsjBD55oXxJh/PqwZ02ULHKeamCprfMSxB0LaBMwzn22kEINuR0TaT9TU1ZKr9o3vtK0MXITK+arCjZWjkrFmER6MjntpNVqRNeE7bpvyZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vNSh+uea; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3913b539aabso892868f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741598768; x=1742203568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SGB61au9EEk11/47YvWNrV6VgtI7CN4so6SIXkNbToE=;
        b=vNSh+ueadt3j55ppcGnm2PbRZq1y4mmsm91hPcF0iN+KHYykecpZGHReSoJ9ymSBax
         w9oNp45hfukVgzcSjmG452fS+3IteclwW9Kzxyaj1XTJXb4Wi5pm+bfLWPvkGjYbvePM
         /gq1jvanDxGk0edHaNSTSZ64An2GnfW8hYuDC46SOa1fXBei2sP7ZybYXj3/ZiFmJ2L/
         28jQUd1GCwt6gFVNOvUIZl9uQBDDzK97K1l8NHQueMCbLym5VYNWeG0nmjaTeIdbWCwJ
         u6oW36h91ekrFrXiHh5PA4hERWIQaELbK90chwRFqnuSh8uSRAIT4GTw2JeLFpJnzK3j
         9M+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741598768; x=1742203568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SGB61au9EEk11/47YvWNrV6VgtI7CN4so6SIXkNbToE=;
        b=V1XoK2tyDstQ24DwDc0+0KM2fug/52EUs+Gk7Y24EipU9OyaL7TIw/m6LNCWot/jpq
         T4lhhAQWrmo4Hi2ECFaS/J0jxvj3n6/a2dhL+d8vI2UoTkQuJ57CxFjGmfJ8v/QqwbmJ
         SpN7sfX41rDZYp2DrsvUQapkvQv9kIy8/hRTjT/xmpCXK6clgU5Om5/17eTGED4DJ9vM
         Pyxk07bGwdNgCTTfG7RziKZF0CPaUfdaZidN3wV1vGSYjVazoeHPk9oekTnOCAS/+/c3
         182EZEY5ojkojDAd4AV/p53dwGBD92IdL8HyphcxFO3XmT68h10sEEfl3U6bnyb/5SsI
         kpaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT//9z0bInftU0eysluCs3xdAziT516G1/gguHU0dod5gU/CpNThR+8MaHwenmkhUNlAUZQp+6kPzzEZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YytKuUg4aFdtdtpZ+Utru85ZD6HDyj4Ul7AXF5K68p8OhstjIUZ
	FBdDWHnDt/F7iPpdHh2GXb6cjmS992angjXZIPeIHG5Apr4O3g8n3C56GZn1OB8=
X-Gm-Gg: ASbGncuL2Hgo05U32TW8ebHxvjYcPOvAo4imQeS0NZvYxKs9uxYRou3kbI4/JRCen6q
	+ngW2cmOi/5YWyx9XeErxZmSEw0e2fXCSGbAges1acireZvDT7zfzPSO0tJKrRd1SpQiHtB+jQr
	spQIPosvh87wuQw050JmesBdUUbqS7HZcur3OxudhRh1aCyIqkuqSqK1zy9zZKYKanuXMPCTr2X
	cWkgRJOf885tJdbcld+kwOcXdlUzGIqyG3Htxtdc/BYBo4tX+fPpULqTkx16vRNPaZSrStlKIPm
	qwkMepByBBe6UhrGA2bSRWZPTDohAH9aJ9s92JU3dHS+37xWEvm6Qg==
X-Google-Smtp-Source: AGHT+IHryabbGhXkC9Vb4Dl3n+sRYRJGNrbBaByC+g/CDOqA7aTuvCvu/OJK9Tr3atCxJvZm8QWu/g==
X-Received: by 2002:a5d:47c1:0:b0:390:f6aa:4e77 with SMTP id ffacd0b85a97d-39132d3a8f5mr8462588f8f.15.1741598768044;
        Mon, 10 Mar 2025 02:26:08 -0700 (PDT)
Received: from [192.168.0.14] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2f39sm14097826f8f.80.2025.03.10.02.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 02:26:07 -0700 (PDT)
Message-ID: <282d3519-8ea6-4a42-97e2-d4cb9ad80c96@linaro.org>
Date: Mon, 10 Mar 2025 09:26:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: Remove unneeded semicolon
To: Chen Ni <nichen@iscas.ac.cn>, jassisinghbrar@gmail.com, krzk@kernel.org,
 alim.akhtar@samsung.com, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250310082628.845544-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250310082628.845544-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/10/25 8:26 AM, Chen Ni wrote:
> Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
> semantic patch at scripts/coccinelle/misc/semicolon.cocci.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

thanks, Chen!

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/mailbox/exynos-mailbox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/exynos-mailbox.c b/drivers/mailbox/exynos-mailbox.c
> index 20049f0ec5ff..2320649bf60c 100644
> --- a/drivers/mailbox/exynos-mailbox.c
> +++ b/drivers/mailbox/exynos-mailbox.c
> @@ -57,7 +57,7 @@ static int exynos_mbox_send_data(struct mbox_chan *chan, void *data)
>  	if (msg->chan_type != EXYNOS_MBOX_CHAN_TYPE_DOORBELL) {
>  		dev_err(dev, "Unsupported channel type [%d]\n", msg->chan_type);
>  		return -EINVAL;
> -	};
> +	}
>  
>  	writel(BIT(msg->chan_id), exynos_mbox->regs + EXYNOS_MBOX_INTGR1);
>  


