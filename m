Return-Path: <linux-kernel+bounces-245263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B3492B05D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283752812DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E87C13E04B;
	Tue,  9 Jul 2024 06:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g5VN38CH"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A668918B14
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 06:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720507221; cv=none; b=oUnzUSCuUkkkEp1sCxMBE8DIgirlRBhCBOjH87GMQ9pTWfTsER/hJW+f1XZGW5ILX991hDqsV3FqZiyPAqICItnXevVPzEW6HO/LCy6m+4v9rqqbxA+rY5ad7SvY05/iT72yV+003R8+nBLlrarrP0RvBYnJl/adXhEeXzrCMac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720507221; c=relaxed/simple;
	bh=8zmvSnDS/scEnVf+qHFusF6TNH1mYh3I1ZikFZkf+Ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBQfiMuxoxZ477QVRLNSNJZkoc3YLwGeeQA2Tr1GyPXl30gg9vHunDUzdYCX1wOk0QkGHKXRCCagwJy1KX624oQGAQ5ktYm4L/VkVhSczow19El7vs7l4F/7k7bZqqNVc2ySK0Cr9tDV3O+cHe51jgFt8kB1ljIkecUuVCAwunU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g5VN38CH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-58b447c513aso5553392a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 23:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720507218; x=1721112018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pqPeM4BsSONRjcr+rqZ/uVWhCZBtkeiIHJe4ujxOfdY=;
        b=g5VN38CH2FdIOPHIzBXsMT89CJvGnZSv6dYoNCuRlyoUk3H4ccfMoJmprBczLAy27k
         ycdzjP9ljRP4znsAKjG3IfagcM4T7/J4bFtkKEZLuUEI4IOg/cTEQOkrV91Und4ig3gc
         mI49Tk62sVh3Yu5QTiGlEXR52L1ysH3DmvZW6wodvsOS63tduo19/a2fD32H5FQelTpb
         HTIma3CvQFei4cuuqORls4V8/OgFedXnDMcllqZ4lvxLPK1koeUOBDDEWxd8W569SpfL
         1zBMkKnbC7RMOtOjafSlTp2I60R9908N/Dc4C5AMn5uzZYO/hWaMbBCovJ9p44IiYDzt
         yf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720507218; x=1721112018;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pqPeM4BsSONRjcr+rqZ/uVWhCZBtkeiIHJe4ujxOfdY=;
        b=On5mVdsGkTQmcAVo8DqGpVhSvNIvn50ivdjaGXpn8iCp6tHE7Twg8efgDkmngxMVj/
         HZADWE1LYbeaZu33zM7U/Rd8F8Dcp8xkwFRViqYQAbg8INGpYnU3mOeZdkAu3MVr59tt
         I4LXpuKnAvALdi8s3HhSEz7rputoc7NNivjnUZ9PuINV7MCR8B5bsSacKuNju0f2KfCM
         3XVxxluxL3PbeiGrCq9k0UAbPg7vSWhB5vU9vqMi/6jRGzZp/KsMCFG8d/a3/iduvmtd
         E1mdPnYNmNYAqXnoGA8r9heyFXiVMm7yVcdsiqMZWKawsZytx+M41V9rA/3fAN5g7ZDE
         dkbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxBK4Ev8MCcEJ8Y/FvYPIZKMWXOUq7xg02usgds7qHD1JNMf2zhzCHHVlMtfyxWkhJAV3ccUOlYv0HsCrUXAA1iSQ/TQwnUpCUJRpk
X-Gm-Message-State: AOJu0Yw7VVypC9FZVFvMXlf9HBfaLIUxXiLuU09Z79B75/HIvFRd7a0L
	XNHQbTX6Acqe35ptiPEvEhcJmYVf9BsVKetU8sm7yFZoFXzdQai6JoBSUk+V36s=
X-Google-Smtp-Source: AGHT+IECLY72ZK0esx+fgl2F0Ey/uSUpvNeEW4AaTCsnM7UFtmA+AELqgzNtDIItLE9T9018/nL35w==
X-Received: by 2002:a05:6402:234b:b0:58c:909f:3d46 with SMTP id 4fb4d7f45d1cf-594ba0cbe63mr1165597a12.10.1720507217993;
        Mon, 08 Jul 2024 23:40:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bda30a24sm690038a12.86.2024.07.08.23.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 23:40:17 -0700 (PDT)
Message-ID: <14f85202-6c08-4d03-9d8b-4ab7e42cd230@linaro.org>
Date: Tue, 9 Jul 2024 08:40:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: vendor-prefixes: Add prefix for ieisystem
To: George Liu <liuxiwei1013@gmail.com>, linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
References: <20240709012243.44810-1-liuxiwei@ieisystem.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240709012243.44810-1-liuxiwei@ieisystem.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/07/2024 03:22, George Liu wrote:
> Add a vendor prefix entry for ieisystem
> 
> Signed-off-by: George Liu <liuxiwei1013@gmail.com>
> ---
> v2 -> v3
>  - match Signed-off-by email
> ---

You fixed two out of three issues that I pointed out. So let's be
specific: how did you fix broken mail threading?

Best regards,
Krzysztof


