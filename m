Return-Path: <linux-kernel+bounces-305653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A71B49631B9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4383DB23EE4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486BB1AC445;
	Wed, 28 Aug 2024 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nawq7yKP"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C591ABEA7
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724876761; cv=none; b=V0ZAoCxO8nt8BgnV8eCUTZEZ6YKwm41zjB4k40Q8tnZOKnJwiNN8IpTF+pplRi4MCoB1D75YSehQLc/htcSqNWRaBUwCNGEf6eqRWzRUsA3C8pgAkDbK5kZzpM7Oz/RwBRpih4NVLRU2PTnWVevdWl5rpkPPgivwbgYbMgoMYbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724876761; c=relaxed/simple;
	bh=D/sIXVXJLrF23RcnRezBLL+pH08yqfp+rpSoFKjbYc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lxfFycpVHuR3uxNS8YtXW4Dpp5mnYXFcFziEkyso5S94ibJ1bn9LxhAGaWi4rIMykqA68FRfM0wzjZHUfrMIp6L3HeN5VBlj4L6twIP2C6lKaZhuRTvzJ3D7bmxI7LrNZCVpv2upeA2RWn6owlbAD4ZJcfCEn0evvfAQd1ahR5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nawq7yKP; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a867a564911so850094466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 13:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724876758; x=1725481558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uSQ66ksgYS2uRo5g5Q03xMDNlqv/GGqsh0pkWtnsyz8=;
        b=Nawq7yKP9B2eHbYMJQ73KrNrO8BMQOkqY4p/gAq4qQQ1gwCpTAcIUgm+9gNp7BlhWI
         51l8n9hs2GB6RTUe8iLOkrajL31XVbkQWsIbtVoI6MQucPy0KSGwuWe3jRURSyg6NZrH
         oUmiKXzMpMi7ye6801dxLK1Gmdps+7MYwhjUJ/LNU48IKq4C9HZluASKdwikS+mmlNsD
         KZ12HG2iwagLXZVrr8LR6zWo0J4QXRAwFQqXGb8pzj6kvZkUNY1iIsbcIskXaq39gBt6
         HMtRHGQxeKuT8+91/YYDjlrT+pOdgbBW5mHGA8/0Ugs92V0S0dpzrgPrXpDxfE3HGn+G
         OV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724876758; x=1725481558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSQ66ksgYS2uRo5g5Q03xMDNlqv/GGqsh0pkWtnsyz8=;
        b=Q8kw7akjsycSbtk68nnmusDYyCg1IMd2MUgW4w2oXhKnl0VziLvJsA1hTqZl3+u4V2
         pt+iXrf4HSDBI5sHdvCSbd/KQE81RwmJsHmmUlgUx8Mcl4lqYEYTLzPdLqBkfl4eXH6R
         5PuNU9ftfqbsaY5N8SjLQhSlp979JGST0pQ/KPMEGJM2IHrzqo4mb59LLJSTSeoLdmJj
         5Z1iNrbTvZs8AvGcU5BE1Meku37I5kF8xyXAOcpwFHXflrDWUVpON++KmeRPYzSE2KGD
         PiKGhBGoVd2cybxFYzHxPPUGHz9Pfn7Hvyb+rKTqghFlJsnxBrgSDTwcW17EKRe5f+qN
         uMrw==
X-Forwarded-Encrypted: i=1; AJvYcCUjYO3rp4PqMmbr4pZf10LfTXudkIQzwhkgkpoWO+iStTjUSMvzlBmkpQCUaAeRS9c3rcjnYfedYDpkzgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywflqy1j4kudCABFUBkr8KUshIHUV0u/qEGEB4Y0oyTSS1/O+sP
	fbCROibmgPMMBea8Sy+8zNuOmhY2HwQScgD6xALouAPwtjhGQDDU
X-Google-Smtp-Source: AGHT+IG82KUcnRAXxO3dzLxKZyRHIC0IlpxkcChajNb3SBoIywPe9/Y4h3xjTPCg159NIQbxpHHPVw==
X-Received: by 2002:a17:907:31c4:b0:a86:80ef:4fe5 with SMTP id a640c23a62f3a-a897fa7444amr43780666b.47.1724876758121;
        Wed, 28 Aug 2024 13:25:58 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8553:4dd4:7649:c4c2:f4e3? (p200300c78f2a85534dd47649c4c2f4e3.dip0.t-ipconnect.de. [2003:c7:8f2a:8553:4dd4:7649:c4c2:f4e3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5878562sm282869966b.156.2024.08.28.13.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 13:25:57 -0700 (PDT)
Message-ID: <5cbf98cf-9b1a-455e-afcd-b0cdfcf1aaec@gmail.com>
Date: Wed, 28 Aug 2024 22:25:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Staging: rtl8723bs: Rename function SelectChannel()
To: vivek t s <vivek6429.ts@gmail.com>, gregkh@linuxfoundation.org
Cc: dan.carpenter@linaro.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <Zs8WLkzoZe3Z0DYF@victor-IdeaPad-Gaming-3-16IAH7>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <Zs8WLkzoZe3Z0DYF@victor-IdeaPad-Gaming-3-16IAH7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/24 14:21, vivek t s wrote:
> Rename SelectChannel() to r8723bs_select_channel() to avoid CamelCase
> warning from checkpatch.
> 
> Signed-off-by: vivek t s<vivek6429.ts@gmail.com>

Hi Vivek,

the description can be improved. Please always consider that checkpatch 
can be wrong. So checkpatch is not a justification.

I propose (feel free to improve):
Rename function SelectChannel() to r8723bs_select_channel() to avoid
CamelCase and to improve cleanliness of the global namespace.

Thanks for your support.

Bye Philipp

