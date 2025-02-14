Return-Path: <linux-kernel+bounces-514460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D52AA35753
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249D818926FE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BC72040B6;
	Fri, 14 Feb 2025 06:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qiH7S8I6"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640ED1FFC63
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739515340; cv=none; b=RKVRiYCDA2y9fd9PaJsW2tpGRo2rCdAGl2S+zhAsFEND3M493zYf5Y17q9DaA3l63qLXMhfXYESNgJJraxO0GuuDSEXHaFwSXg5q4f/c0meNnOCzmXep0D+jFdLpYPKxB7V5xRpRN8QCbjWwJtOi8Y3rw6PeYG4A6IckJdSsh5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739515340; c=relaxed/simple;
	bh=dCkSTtk9kSKMKBvRlNtSthP4noQOAV/PykwVDLKRw68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOPTWJrVNGQBFOv7AdOdsHvywcrdZjeyQ8vjyv+KYCpIvbBosxjbkSERrB8z7rUy59Rqqu2haphyqPCpM1E8EgReUacXAG3b/wZRlNyvj4ZWWiKXexZZPG1aFL2zOeOGbWA35BSxJbc6Q5N0xoxqZcRd21b/tRnjX0iZlygHcBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qiH7S8I6; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab7f838b92eso305964266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739515337; x=1740120137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6hfDJLR9yNuRN5GPzA8PeCgTr8s7BG7gSfHQ0NUvCN8=;
        b=qiH7S8I6Y+x1E3lEeswwE+qx4M7Md9a3wLsYjho0J2txMvCYjx5EcBYK2lQnMnvJrf
         r2fe0b+EY+v/6xOFvOjCrcohws0tI0iTW51VxH1EUcciowXJN79ZfSvY44gBgRflrX/P
         Fqlw5Ngz/ysFVbZrCsHSrA5QXey+xU2jbAmu+5FaBvOKADHURwE+iLAmA/lDirgG4byj
         X+/JDSjB33WfydcRGC3wyBgG/Gxt/xbiZrqmusFzKptz7qV+QTc95cW2TpXW8JqdQDzm
         BOjNXCNess8zlv5wNk1k8hB5bqgAXkG5g2ZNHrr5qrmORCq/UtM4Z/+YG87Rwasht7tA
         WhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739515337; x=1740120137;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6hfDJLR9yNuRN5GPzA8PeCgTr8s7BG7gSfHQ0NUvCN8=;
        b=DAdYGVRVzUImMugd3GFaYjKaOzF+3Qf2Bdc6xwU/Sprw7DwpjuNvkRcBfhKJ3lhG7s
         tsEtESrpSxp8Y4nyhoQw7uTYeRhWzeCS3vd/CKi12RBXqeSjeBCPe4TIfQwS9JWCGQr6
         fpz6FVxNiHGqr9CxID2tEuBzrM4QSXi2+ZXGzStCozZpq8GzYGzg2mi0ih7qnxWnBtoj
         vgOhBX9AD5bY6oMpL79t/2CrhvsOvAkBXj5WKjNutEohNUvbf7VffD98K2Oq3fHvmMIW
         4zISJ0CJY4tZiSo0tmFl/L9nCYStx9BIvPfw2NWwQdH6Rkh2huoutW53X4U2taMa9UwE
         1B5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQYp1GrHgSYgeEls/3f2wn5c3CSxtrTPHSvW9PnLz4TWmsY+k1Gh1eYBrJIyddISgFgvUUAUSsmJCvLA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXmi8O6ktFWIYb1Wi3MC9TACBdgrEoodYGE1d4VTvMyoPU/ar+
	qLr4oK+4AkmE6XX5Sk8TVxp1+48WFy8QpOBKPmVSxOLKsSm+KcMdDEDtQlAebTM=
X-Gm-Gg: ASbGncsJPnzWyJkiVBi7aD4hAG3SQgPYcbX5Ef6c8LGn5Zeb5Hx8Qu08t9Az4T/8sPm
	9nA5cpG/qcv4Nf3pWImVQhIzte+YOA+gsgRqWWCU/IEf6qfSF2T8+6M3zvVEnA5PUd9DqiB2uqG
	Qv+GQ2zif18S5FwZnQDDMpcUUPK04E3Z41u7oUjrm5Qk91xyI0SuRmifL5RkLSEnT350GU/n8/t
	Y0xf/0OrDpYXgqAG6TnwxbYVM7iwbVgzz7p37Pi6UgFMs9CxzcSe/1U9xA1yevTFp1hXOvboCU3
	ucxLlXXBiN2U2Vv5zJnyqY8n
X-Google-Smtp-Source: AGHT+IEKcusDJ5ysfHl3uoOwCsLd2p8Ws/FHvKfkzEK57YdhmOYKIadpK1QRFMVRV3ZXNrzmUuWp+Q==
X-Received: by 2002:a17:907:d15:b0:aa6:9503:aa73 with SMTP id a640c23a62f3a-aba501bc5admr629562966b.51.1739515336656;
        Thu, 13 Feb 2025 22:42:16 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532832d1sm275659666b.81.2025.02.13.22.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 22:42:16 -0800 (PST)
Message-ID: <55028ae3-ffab-41e8-b1ec-fb2098b65d7c@linaro.org>
Date: Fri, 14 Feb 2025 06:42:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] dt-bindings: serial: samsung: add Exynos990
 compatible
To: Denzeel Oliva <wachiturroxd150@gmail.com>
Cc: alim.akhtar@samsung.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
 robh@kernel.org, semen.protsenko@linaro.org
References: <20250212234034.284-1-wachiturroxd150@gmail.com>
 <20250212234034.284-3-wachiturroxd150@gmail.com>
 <fc341dbf-3add-4728-9ec5-7291ad3bcbe9@linaro.org>
 <Z67Rm0HoEqGsiL/F@droid-r8s>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <Z67Rm0HoEqGsiL/F@droid-r8s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/14/25 5:16 AM, Denzeel Oliva wrote:
> On Thu, Feb 13, 2025 at 07:20:22AM +0000, Tudor Ambarus wrote:
>> doesn't the 32 bit register restriction apply to uart as it applies to
>> SPI? If so, you shall probably fallback to gs101.
> 
> Of course not, downstream of the UART serial driver there is nothing
> specified about 32-bit access restriction, nothing explicitly
> in the driver. [0]
> 
> https://github.com/pascua28/android_kernel_samsung_s20fe/blob/3be539e9cd22b89ba3cc8282945a0c46ff27341d/drivers/tty/serial/samsung.c#L1543

that's very strange. uart and spi are part of the same USI IP, on the
same bus. I don't think you can have the same IP requiring 32 bit
accesses for SPI but allow 8-bit accesses for uart.

Maybe SPI can work with 8bit accesses? How did you test SPI and uart?

