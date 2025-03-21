Return-Path: <linux-kernel+bounces-571401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF44A6BCBF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C555F4619B5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3D113C914;
	Fri, 21 Mar 2025 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="apj7w4GR"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABE078F44
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566490; cv=none; b=LhiRTqV2eUsfOxXC/OPdOPQV0HWyy4D4gzM3vwXR2GJdWzAvluOhamu679XdJSNtUvMtfK3XfeyGXd/zydOdbxjqBUaabLkz1OYIPRAkoklgB04gC4zeWaXYxUxymqd+r6bDgh+Co7y0IWlHi0n1SKaw2xXv8cYSomUMS23Xo+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566490; c=relaxed/simple;
	bh=y+FLQhrEzaYM8D0JtN8Az276b0i+rEP5XnlDlVs/pnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cn0lNwgU3AybdqBLmZP8c0Dc5trldmS3OJk+KUqMC3PknsHYCtOUJzwGFcoVSqbTivz9R3K9SguGOLym40MsE1a5P3a5kodvgPBGw5j/xrtO6c7rgAs/31kNcn+8TrdUa2RFUNqwpn0q+pbMdMLLu7EnRFgQm8VKy2w9yoqXppM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=apj7w4GR; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c54a9d3fcaso205607185a.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1742566487; x=1743171287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9exEh3HjSKqcTsxFRqa5eN4Zk07lWBlI5tYJFrmxJok=;
        b=apj7w4GRoOG7k3YPyDeLb/e31/5E6TFCO0H8UKhlRdYbqvfD21/l2TTpN3AD10sVTF
         gD9OyQoYO7C+b+RAv6POjZl4AwYlX6DZ9Bt2TZl58Nx2pJNHveiXR1P+DMhW6KU4sZyY
         YQ/fYk/5REXuVtnO8pMfkIZhlCqc/Xzyw1t54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742566487; x=1743171287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9exEh3HjSKqcTsxFRqa5eN4Zk07lWBlI5tYJFrmxJok=;
        b=iIITx3pec7CfHFmz5fSQsr88CKU+gAEDStwO/vHs0g3caYW5ZTakxxvxUxKUVNydOI
         RRxSeeN3qGLZ9zfzT6uiBEAF4UaBQ7SxO5FagPDTd5sOcpIhGGxnf424eKsjMzGzO4WH
         yRskRrTbpHI+KSpHJfxyponUDRD2NQjEvCzEUa55vb9MKeON0r59VH2fqov5oKsqrwSN
         RJOKEWOcLhHibvMaqG9ycZaYZUmILnk7P/n+WO1/ZvAY7sCheIxQFeF4AEsFW68g93nh
         MV8CI49A8g6MO9EuO1YL6CsDK2VYe+kbLoQnD08N0gSHfJNtNpu9a6AjHewP+fZzrBiS
         uJOw==
X-Forwarded-Encrypted: i=1; AJvYcCUtl28d/NXz5mfFQ+sGOkuxFuDkyQBXgBH0goa4eaCJJJG8v5X/0PQSUzd2X/bBECSsMQpD1x2Vms73ELg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl0uOmt/i2hMhTCuu1KEY0jIvCieqJ51FynkrSpKKZ+lXO6Yqf
	LicY2y0uyEXAD7mxr8/cTke06S6w9haj99z9OXMiatWdsc6PEQncPWOCqvuk6w==
X-Gm-Gg: ASbGncs2tgIix0FRIGd37nHczJlJ9Ng02QDj8CnM4DUjJ+JeamOx6rfjR+svhhsDPk7
	yxjHFta3vo9FeLMmbXpFOO6q70sAGNZVoLjCKj2Q/kw3EDas9XHvtAqEWYiyXJs/t1Vr+jVNIY+
	jJCf5ovWZTwvbWA5YvKeE4LFf8GAWf+pwyP4QvI7H+y/nrmqkYRoMDEGPZL1tDtITEZ6uVrRoA1
	kuZiQF5X0Zl55rbxR6Yw0dGrvmOXLjkCFNjmEnt9PRlV++L40VXipEhhAcEQ++3E1h+EF43WKo2
	V5mt3E1YJRbVghfcLKpyLOfKXsAtFCyVGV5ANxVK/rDl3AoRNzAOi6iM0elJuFVo595MpR+NkG9
	d4mrtWSvTF0NWyVpVw4aZDr0=
X-Google-Smtp-Source: AGHT+IEAlcWkAnwmrnQqtFTWuwfNBTAEVhK3IQoOiYeHqUDv1MVsDaGZ5Aw/RjXX/sF8QL3K1Ct2sw==
X-Received: by 2002:a05:620a:390a:b0:7c5:5d4b:e621 with SMTP id af79cd13be357-7c5ba1e3f3amr432552285a.37.1742566486918;
        Fri, 21 Mar 2025 07:14:46 -0700 (PDT)
Received: from [10.211.55.5] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7c5b935772fsm134988485a.91.2025.03.21.07.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 07:14:46 -0700 (PDT)
Message-ID: <24b17317-a153-404c-af67-79967bf49968@ieee.org>
Date: Fri, 21 Mar 2025 09:14:43 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: greybus: fix line length issue
To: ErickKaranja <karanja99erick@gmail.com>, hvaibhav.linux@gmail.com,
 johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
 outreachy@lists.linux.dev
Cc: greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250321115545.24468-1-karanja99erick@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20250321115545.24468-1-karanja99erick@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/25 6:55 AM, ErickKaranja wrote:
> Fix line length exceeding 100 columns in arche-platform.c. The code now
> follows Linux kernel coding style guidelines by keeping lines under the
> maximum allowed length of 100 characters.
> 
> Reported by checkpatch:
> 
> CHECK: line length of 101 exceeds 100 columns
> 
> Signed-off-by: ErickKaranja <karanja99erick@gmail.com>

Sometimes a good strategy for reducing long lines (which, as in this
case, is partially due to indentation) is to define a helper function
to isolate the code (and reduce the indentation level).

Another approach can be to define local variables so that the arguments
don't make the line too long.  Here though, the name of the function
(arche_platform_set_wake_detect_state()) is pretty wide.

Ultimately the goal is readability and comprehension.  It's not always
cut and dried the best way to improve things.

					-Alex


> ---
>   drivers/staging/greybus/arche-platform.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> index d48464390f58..1a82a7a3991c 100644
> --- a/drivers/staging/greybus/arche-platform.c
> +++ b/drivers/staging/greybus/arche-platform.c
> @@ -179,8 +179,8 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
>   				 */
>   				if (arche_pdata->wake_detect_state !=
>   						WD_STATE_COLDBOOT_START) {
> -					arche_platform_set_wake_detect_state(arche_pdata,
> -									     WD_STATE_COLDBOOT_TRIG);
> +					arche_platform_set_wake_detect_state
> +						(arche_pdata, WD_STATE_COLDBOOT_TRIG);
>   					spin_unlock_irqrestore(&arche_pdata->wake_lock,
>   							       flags);
>   					return IRQ_WAKE_THREAD;


