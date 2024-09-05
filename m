Return-Path: <linux-kernel+bounces-316684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D90FB96D2BA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E5E1F22C71
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5563196D80;
	Thu,  5 Sep 2024 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DlsAb96K"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2173194ACB
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527134; cv=none; b=YwkrHk/P5b8/kP9HTHQeDSXfJs72KDo875JjTT3eIe0C7NNgpoN5Jute4H+HwsCHhpaHScw2avDN4CI8KtE2i/sTHkqhIadxwKITtB9RrwiL2pLHkdu6mrZifKrpfAKa4dy6oQCWGlOP5gsHU582H2L55ai2138eDoxUaYtlgvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527134; c=relaxed/simple;
	bh=Rlfd/m5gMuPA6CKfPqi6x1MfWzWdzXLoDmrARY163Lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ucxXncm8gL7QV7s3nwkX4lXQVadoKMwEDLB1jdgbk0Skl54Sdt3YWQzfLs4Hn2xPnWcYPyVa4brmpUqPNi4csk0Nlz/X1zyYba0VgfejUdgZzJfgZHykRR91n4Z8r89D5bcYhYmQmhLK0LagkVpEN3ZG0YT0Oo2gNKmnM07loLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DlsAb96K; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374bfc395a5so296542f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 02:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725527130; x=1726131930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rXkGvmrzjaju+FFxdQOqUz86ayxWamYskoaBHAk4gpk=;
        b=DlsAb96KptiFiyXnhRJ7B/YZPsmgZQM4uJ5+TJgZMakXqRn+pwXOd5D0ioVnXHeJVF
         DDR43EN0g8H2w3iEaWbLH7PQ2gU9KxkpzlODoG9BKrimH66EBoz6ntTDRCV92a4Ihk3/
         AX6qNrJb5tJEc0c971XyyXGYLiYmiwUyhNAhUEkZ/yCM9nRsqFSGKwnZXR88sT3djbfV
         Xjn5UacDo1wwg4l1Gu3+lfQoV2z9Y1p7o/syxQmWZmJnd2NIEJvCbAlMPCa869ciByCZ
         AIGLDNj0yfwklcymUIU0fWSGph3txK6tKVvkbk08qyyzt1/OIXKqSUc04LSTvaSwKzpa
         ZEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725527130; x=1726131930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXkGvmrzjaju+FFxdQOqUz86ayxWamYskoaBHAk4gpk=;
        b=oEcp42ZuM5MXZL8xlUixqxWwC9U7gXA2N1+omwOawxM7DuqhJuYGwjgZg3AuLo86OH
         mmtjyNiWxujFezKSWzqRDqWipwU8DXHCmLv0cTYV6JHrCMk9RuzBv+XcpkFDTGX11Mv8
         QdJoqu3K8r4EX7pl1mytsy4Bo2NZBWtjb3utLKBLUV1ynUcY1e92XvXmV9PLWwrSYly3
         W4dkUeFOgQ4D/rCQVkCTAp97gJD2ieO44QHInszEjH/Gms/iGbT3kVbkij+CzShh4nxr
         ueiejDAQrYdDvFf7MzkYIMZx/6AUBZvN5AhtbDxHL6PVblsO9c6g4ZztdcK5hEReVpt1
         Jnjw==
X-Forwarded-Encrypted: i=1; AJvYcCVa+yGgmbztk9bGuIeTa4QK2LCDrVr6JV17D5eXG43p1qNSsspBHY0KdKRhIfIkoblgHZ/CMil/ROJjbIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaXSBBYgfmOoEaij0ECVY82tiFonTcYIh8xxHBr7at5MH0E2D5
	BuybYhZ2C0Ekt9kH0D9YFJ/RBGOxjCyq1g68KEA13Vbm2tjPV+vO4XNL55Fn3fQ=
X-Google-Smtp-Source: AGHT+IGs8OizwWXd/YtOsSddAZr8iCEdLMOuc1WNos7Odi5UIAAcNaDDCpxTzJfQ/Nko5h3HZKUMCg==
X-Received: by 2002:adf:e709:0:b0:374:c57e:1ea9 with SMTP id ffacd0b85a97d-3779b847aaamr3083162f8f.18.1725527129762;
        Thu, 05 Sep 2024 02:05:29 -0700 (PDT)
Received: from [192.168.0.172] (88-127-185-239.subs.proxad.net. [88.127.185.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-375348df4e8sm7155523f8f.115.2024.09.05.02.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 02:05:29 -0700 (PDT)
Message-ID: <62bc8ee8-f23e-4cd3-a77a-74cb19e6530e@baylibre.com>
Date: Thu, 5 Sep 2024 11:05:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/16] ASoC: codecs: add MT6357 support
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nicolas Belin <nbelin@baylibre.com>
References: <20240226-audio-i350-v7-0-6518d953a141@baylibre.com>
 <20240226-audio-i350-v7-12-6518d953a141@baylibre.com>
 <c386c74c-9008-48ea-ad79-524eb85c370b@sirena.org.uk>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <c386c74c-9008-48ea-ad79-524eb85c370b@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Sorry, I'm gonna send a V8 to fix this ASAP

On 03/09/2024 19:14, Mark Brown wrote:
> On Mon, Jul 22, 2024 at 08:53:41AM +0200, amergnat@baylibre.com wrote:
>> From: Nicolas Belin <nbelin@baylibre.com>
>>
>> Add the support of MT6357 PMIC audio codec.
> 
> This breaks the build:
> 
> /build/stage/linux/sound/soc/codecs/mt6357.c: In function ‘mt6357_platform_driver_probe’:
> /build/stage/linux/sound/soc/codecs/mt6357.c:1824:55: error: too many arguments for format [-Werror=format-extra-args]
>   1824 |                 return dev_err_probe(&pdev->dev, ret, "Failed to parse dts\n", __func__);
>        |                                                       ^~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors

-- 
Regards,
Alexandre

