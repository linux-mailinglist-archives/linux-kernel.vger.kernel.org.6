Return-Path: <linux-kernel+bounces-199797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 132208FA60B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576091C2348B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 22:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C126913CF96;
	Mon,  3 Jun 2024 22:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IkYwLqjX"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D7313CF93
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717455049; cv=none; b=WJbUSTE4g+VnASHPbvZgnOud80xY0is77dAYVeNVtuRqATebiW8p0bd082/3htGCMMmJbsTuP4lfo3P48A3CiVlod/xuOHXfVhMFTAT7J8N1xrsUBuor2jDnetttsyMFIg6uTFr1HR8/k2UPX2dTUC+c/mUT7iaM+ffFnecalag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717455049; c=relaxed/simple;
	bh=/G4Eb96J/HcqYH1j+Lw1JhubdgY6c1Wm5NsjlC2H210=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kC+bofdRGtNYEeD4wGsz35wo/oKXa6We5f7bKOW1W6Wyp+o41B57UVt7wsR9tjj9xzk+T+PugDO9DFh7mjMfUqEo/dbmdty6prXEw9qB6vjJIBWdNvXwHVxdv5nPfIfd+ANPooGxjZrxiqnwAPYmB1aALvTfrplc2ROqvJV6V8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IkYwLqjX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-421140314d5so44329045e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 15:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717455046; x=1718059846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5NpBRebLDT64GS8vA9X5NfBTHmBgdaZxuPi9FdQWvDw=;
        b=IkYwLqjXh9ByNB6xzYI8tbyfIExNST4Y8S1YO8kJLOOlM+pHxC8s5FnknpNkt+eRpj
         doC7WZ74+v8n7M19AkkalUcSBpYJnNHA+BMK83RzjhIuIfVNgOlPh2N0BuRMqf+MWOFa
         eBB3xqteukaR0w0xshr4OxekifBmKiIOvvFxfQUCjcETcfCxiwWYIJ8lieDGr3kryuG0
         dMA3/nj9mVbRVOTsOgf2zuH61IS1s8J18aIQbHyumQikuK09YLXeALi3Dwu+W8ZeOGTp
         saLP/O1Pk8RY7njPo+IQmOcxjppXybBPjSglt2nwzf7ionjDsE5yFFgrCop/cWANc73C
         TkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717455046; x=1718059846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5NpBRebLDT64GS8vA9X5NfBTHmBgdaZxuPi9FdQWvDw=;
        b=Lv7ddVEhU9OkdDsfGP3opGd8fe1kN88C/jF1D3gD/PMQAl8fPsHc36AUW+Knx3xciY
         KGh8Sr4brz0R1kQj8M+DOCZISYRlBYoxqcHZBkLLv+NBHfl/z3cit+ItrmHoSM7BzxUN
         Wg+JgzSrLpIy7R4cs7i+ZWvHRqTWpeAwTIHSkSwrUZAybV+UUezzesNsuzKu4IljROnv
         cmKm2NBcXuhitaphCsAFbxSbnPq+QwDjuh6XT8eeSVcIW3xyHLqjwEdldghrPE9Omlar
         /Y1buGhUXrC89BdXGxjL+rhqaQgK+wmQNS5QI/C9mdKGIu0GNRJNZvLzNHNHUkqPCiz9
         Vtqg==
X-Forwarded-Encrypted: i=1; AJvYcCW3gdFsG6b6KdDjoWkIhZyfRhpE2X0nu7lwKtaI2hc7u/yvqNlyaR/U8XASEouaP0MlCauQyZ9UR5RNjoEpEntGUfZlaVGm8ZfwHvyb
X-Gm-Message-State: AOJu0YzGxpNgW3O1kyeEI8MHXnoXlRLFPDzwBKm4l5JvUER1uVLNxj39
	p5ldxL+z+P2xVeFRgz5gC//B+mSVUPQxePLRQ+lGS+g11CgV1ctvFeTpJW+mdRM=
X-Google-Smtp-Source: AGHT+IFIObv1irdqsMbl7TJ12GPOe9tqvV9I9Qe2VKkVL9yVWAhpRgKq5/yy96/ZGGid6wOT2yAuhQ==
X-Received: by 2002:a05:600c:3106:b0:41a:ff7d:2473 with SMTP id 5b1f17b1804b1-4212e0469d9mr97994565e9.4.1717455045676;
        Mon, 03 Jun 2024 15:50:45 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0de3sm10028604f8f.9.2024.06.03.15.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 15:50:45 -0700 (PDT)
Message-ID: <1bcc764b-ed76-46e8-be77-9f7e4edafd69@linaro.org>
Date: Mon, 3 Jun 2024 23:50:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: fastrpc: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@quicinc.com, kernel-janitors@vger.kernel.org
References: <20240603-md-misc-fastrpc-v1-1-6e6d73d08315@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240603-md-misc-fastrpc-v1-1-6e6d73d08315@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/06/2024 20:58, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/misc/fastrpc.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>   drivers/misc/fastrpc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 4c67e2c5a82e..e040cb5470c4 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2478,5 +2478,6 @@ static void fastrpc_exit(void)
>   }
>   module_exit(fastrpc_exit);
>   
> +MODULE_DESCRIPTION("Qualcomm FastRPC");
>   MODULE_LICENSE("GPL v2");
>   MODULE_IMPORT_NS(DMA_BUF);
> 
> ---
> base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
> change-id: 20240603-md-misc-fastrpc-b644f497e68e
> 
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

