Return-Path: <linux-kernel+bounces-179994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E0A8C689F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF3E284547
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F2B13FD67;
	Wed, 15 May 2024 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nh9yFLRi"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C27513F450
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715783215; cv=none; b=CfCy4wrbEnF83BlE8jOjvDCkE7BsPV5y0E5K9AibHKLMe9bihKXtA5K4Lqlp5/zIZy0KbgxqYXlFx141uqbmI69SmXRIxaGa/lQexOjxOxt8fWM8L4+aNqwubam7CkmK80rO2Pt/mBCoNFh2zL9QMrgRnLuA1DBNhTMe9lWYT+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715783215; c=relaxed/simple;
	bh=IzXwnDzL5EFdH3+0tvu4yNaXUaqrwXNLa6apbrChqOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5hxTHSryGRYqSVCxme4TgXsa8xX1pU36hG1NVns00mBAoQUEMP3OO+su9tH8fcjxNwQNcWWt6LcqICTfZkyRS9IBwhEeRZYi7MswjJtuMkfFC6pC6/GvUY/pduSQCBZUAIbFzj9pG66R6PiaIQt/FYYlzC931Xsi05EMbJHz8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nh9yFLRi; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41fd5dc03easo42867865e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 07:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715783212; x=1716388012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IzXwnDzL5EFdH3+0tvu4yNaXUaqrwXNLa6apbrChqOA=;
        b=Nh9yFLRi7p2qYkqiC6u6wCpamkhJjaAPJYoZ0oGJ5IqN+58y4CJw8TUrNpT41BZJuh
         M+rVFa9SiXSdMWUHRN+5ePX/Jxzk+Rc34pi8c2lBF8rTIsfDCmmIddVNxrdvFBiOSxXX
         iWoGElvRClelRKi/4GEg8PPRDMmFdGHpQHoa/3hy4dL46rlfmV+U96mp11csSkrYjSx2
         NDVnBBE9RImzcYBVt8bP36wGFFPMILkgt/C8dRQAqsksRAnl8oGC8PCOCNtnfxddJXSC
         1v4hGke1eKs/uhjKt1VAEVa9GGG9+i0QmT/5E4B/YuUXIz5gBXyRIDcThAlABGTQ929U
         5Nhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715783212; x=1716388012;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzXwnDzL5EFdH3+0tvu4yNaXUaqrwXNLa6apbrChqOA=;
        b=KFFD+gWGGxRSft+zC022qeZSE3LcJC9TvkfO+en9kZqSAC6fIoLDThk1NiJIISij1H
         vaQEnqPH+odFiQRZwB0hKA3bSPoCwNJabgAlrECsKh+5VLE3o2zV5CBo7na1USpIRJwG
         SpkUF4Mp2AVcI89nFMQBKFsVez27HBrFnlWX5tW09fxTe6uNYGOD5FQnNUPGhtH1Uqfc
         3rzQFoTf85SO1EgG2UgNFQyywNR429j6HWTx+dSY173NFZ7f/VGGcblp2c3ZnbELh+4o
         aQTyNtw8OTnuN0olAFdwPvNSa57eKXyrWHEF8kuoDEDbN/WIrkWoE24kdD1m34tGIXzE
         qKCA==
X-Forwarded-Encrypted: i=1; AJvYcCXOO6uJLsR60DxiW4eIX/H7LZ/d7zglZple8faXO+jRVmRsU1r/G5Byu+0ARDiptRRY9PCbll3yagOzI3TUvlU7yzh4O1qRF8jn6o0M
X-Gm-Message-State: AOJu0YzqSV/fduLmMGIml6uZ+ir4idJoKx0TjfooW0/OjR+s15SAxkKU
	P3hRb3LLNbAFvpTUqSOhOdxp0YAV0f2Nh2O8NXuulw/HJ3bs6hr90Uu5ts2uMzQ=
X-Google-Smtp-Source: AGHT+IHRhmKOWpAr1PEsZht6byVh+04sk43uEaa1/eURhjKKvtgGcPggxS0xWe9o9pAJ1aXL3ORwtw==
X-Received: by 2002:a05:600c:1794:b0:41e:454b:2f7 with SMTP id 5b1f17b1804b1-41feab40be5mr116658465e9.23.1715783211968;
        Wed, 15 May 2024 07:26:51 -0700 (PDT)
Received: from [10.91.0.75] ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee92bcsm234751905e9.36.2024.05.15.07.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 07:26:51 -0700 (PDT)
Message-ID: <ce793976-c6ca-4547-aa5b-8845c7fe90f8@linaro.org>
Date: Wed, 15 May 2024 16:26:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Convert the Broadcom OTP memory controller to newer DT
 schema. Created DT schema based on the .txt file which had `compatible`,
 `reg` `brcm,ocotp-size` as the required properties.
To: Pratik Farkase <pratikfarkase94@gmail.com>
Cc: Pratik Farkase <pratik.farkase@wsisweden.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240515140731.63927-1-pratik.farkase@wsisweden.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240515140731.63927-1-pratik.farkase@wsisweden.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/05/2024 16:07, Pratik Farkase wrote:
> Signed-off-by: Pratik Farkase <pratik.farkase@wsisweden.com>

That's not a proper commit... Read introduction to Git how to create
commits.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

Code itself looked good.

Best regards,
Krzysztof


