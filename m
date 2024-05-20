Return-Path: <linux-kernel+bounces-183910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F468C9FBD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9261F21B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80ACA136E3F;
	Mon, 20 May 2024 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="H8um/tu4"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61659136E0C
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716219241; cv=none; b=MppNAiZElLty1V838DV76OfaCvLhGlsWCRP5EaRwNGoRztbgEDfxdyiuKc0joXddrGSKhOgk4kXloEbt0OQww3YgAh25Fve5uhZZd/19yNlVumq7Ufes9NxzSdBw8EJYLY3iarhRi9GaJxe68n8ytxqJqF4+eo2MM3Me+2v7PSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716219241; c=relaxed/simple;
	bh=hMZJhGYpUSYbRvMA72Fg/iQh11fD6Y7jcihsNIZUjhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=akQ1QxHUCvrLc8HJAoUHp1ghZ0pLejeB17ZSufQ62yOj3VNDGuZkwah7hHCK5YizP3WqHhOffqGrMW3QeiHzisFNy/XtMIGbtDH89Smz10DjCqb6oHzZfgdxhBJMHnuwq7PZzNtMXujCa0h7Cekk50lQlgJpi2xNRgPbEUDSd1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=H8um/tu4; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-351d4909711so1411734f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 08:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716219238; x=1716824038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a5fhRvRNdkY76LZ7BQ6I+6ho5RPNKmpKNx7+rIS4bQg=;
        b=H8um/tu4QR5ThWm+L9FrmiChBpXexekPpyqUtYf2tNnEZdgBm/xvpcStHMNkUzWCyV
         /+FdmETupt5HsUmG2mXjKiCvbhZQmD5QJMj6iPbBAOoeHGjm9z1ZknI1ckPMaVkB5yHI
         Bf/Ys9n1HfHTPRGPh9MbRwgKoLUm6zAHmZEv14meJ/3oE7To/N/ai7rzvsETk5zL1vW3
         PaL8uZirL36fuhqPzGHNStOrzZGrE/B/3E1nIoC9sNpSBcGgXfROIE6L0IgiJUGqvMOH
         KPnfS93Zt8w4IXWTy/DQuE76FIj94q9hY3N/tJmmH6a90zEEsJP0RPULk4HXIK4dZHRk
         jq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716219238; x=1716824038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5fhRvRNdkY76LZ7BQ6I+6ho5RPNKmpKNx7+rIS4bQg=;
        b=IH4/lSQUqW60T0jLrxO85kWFma1+tJ9n+SP3rv3mBsGqxygbkTlW7sR4WkFL6Cs5LH
         Sjqp4gfp78QQDXhU2LkjIh2FNfDmrlZiFSIg+wttPJBSkLRDrV4vE277BGhphyTXQ6SZ
         mHzjayRSdtHlVf3BS8s70GVohR3u1NVE78dnSPt52rys5PPV0t6ajVUAfn845KhuFJAD
         gfnqnIkKtr3LFJluGCw5wcHbAJCBnzuY22jOhc56bSR7erzBlo/tX1iv6PQZNZoMeGid
         2QvDMBvwWqeDnBkWBYZy0EWXQzVPO64emIUxXK+IKD6ZGROlWTRTbQXsTiB6upXHd6Oi
         ljTA==
X-Forwarded-Encrypted: i=1; AJvYcCXGO6fB0VS4Ajs+n6bjKU+JajkA3seWnhhtkv8oB4H6mcDyDDPZR3zrRDfbXkCAJ7ZeTu7epkgSWu/NdUUBY1kBqhTROy9Qz50ALwEX
X-Gm-Message-State: AOJu0Yykq/dkO3PjEZ6oEIx02mSqosgBSfg+BX1kpEbDNL/tkBtQOKyr
	o2P+l3irGzv9KZucRBxoXBWYFw4PJx7rdDq6550msFKAhZTT2xj2rOyytf41j+M=
X-Google-Smtp-Source: AGHT+IEtcFamuSVknEh6ha0edbY5+ZLvvrbIWav+4DvwqNfed2/74eqCifL094D8HWPsho7WfwN9cg==
X-Received: by 2002:a5d:4852:0:b0:33e:6ef3:b68e with SMTP id ffacd0b85a97d-354b8e4ee8dmr5666430f8f.34.1716219237520;
        Mon, 20 May 2024 08:33:57 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad04dsm29474972f8f.81.2024.05.20.08.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 08:33:57 -0700 (PDT)
Message-ID: <9e2cf6c9-d74a-49f3-bc3f-cdbe83e01015@baylibre.com>
Date: Mon, 20 May 2024 17:33:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph
 support for board path
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 chunkuang.hu@kernel.org
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 matthias.bgg@gmail.com, shawn.sung@mediatek.com, yu-chang.lee@mediatek.com,
 ck.hu@mediatek.com, jitao.shi@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 wenst@chromium.org, kernel@collabora.com
References: <20240516081104.83458-1-angelogioacchino.delregno@collabora.com>
 <20240516081104.83458-3-angelogioacchino.delregno@collabora.com>
 <ce1de395-3f60-4f7f-9424-bf036134de94@baylibre.com>
 <7dbe08cf-47a1-4da6-9035-6b0932cf8426@collabora.com>
 <67f13b3c-18b2-4042-9908-b4d41c24cdb0@baylibre.com>
 <df152312-a8ab-40d8-a361-fe5100e11dd9@collabora.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <df152312-a8ab-40d8-a361-fe5100e11dd9@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/05/2024 13:55, AngeloGioacchino Del Regno wrote:
> Il 20/05/24 13:49, Alexandre Mergnat ha scritto:
>>
>>
>> On 20/05/2024 12:53, AngeloGioacchino Del Regno wrote:
>>>> So, I don't know how you want to manage multiple display, but IMHO there are 2 ways:
>>>> - removing the current "oneOf".
>>>
>>> ...eh I think this should be anyOf instead :-)
>>>
>>> I'll check later and send a v5.
>>
>> "anyOf" behavior works as expected on my side, dt-validate pass ;)
>>
> 
> Hey, thanks for the test, buys me some important time.

You're welcome, after that:

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Tested-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

