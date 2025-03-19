Return-Path: <linux-kernel+bounces-567418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79204A685B1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24FCD173D60
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A657E24EAB7;
	Wed, 19 Mar 2025 07:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KOmFdm4Y"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1B8211484
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742368706; cv=none; b=iZAk2afxiYe6ejGmrNNEu24LtUM/otG8Wd9tzyMtkcsPPCWTPybpgh9tDMV/cNYvAJJE0xQhX6M97f0DtAotdtVT1EIRAWHg4inFcj3ixeau0jVIIhFGo61/Hc9J71zPkCKTgkHcf4C3RYc85jLZSuYv1GQ7U9vvzrT8K6HVdio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742368706; c=relaxed/simple;
	bh=AurljSFGywwvtLf+Iq1FHd3bwarxSb/wqs/YAobNt1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FbVvj5PQVKJ9xZPKGa7RphZ4MLYqxgUAFwyoAcX5llec0CRmVFDImvf0Ev2WHAODv0pTIMERLV+YN55/9LbMUPqkO5n8tP/+L/Rr7ahGii8qx66OXGN7NVxgg3AFt26XABU20ivyNIjqhemv8wlpCPXTE2AlHp16gKBsyNkBom0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KOmFdm4Y; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43d46491946so65455e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 00:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742368702; x=1742973502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2t1e8lDHeeC+VhrMMM1rV8xRnNEpcJgqStNn0Vw4SWI=;
        b=KOmFdm4YNNb+1aluIAzgQ5E/SFQVH7VM8Qhw7xcmGP8KxtbSmtkTo3aqy5DRbg/hNv
         BdCY4QNlkJyldSUiVZjBY0iFKwH0a8zZI72edAeb7giGH6bOlweKTSFYq9aHqRiTajk3
         1KZldKte28j9xIUUxHrAA9nRxQ8kDd7+8chGMAuhgrWCku0lBl61JPNyOddmiRi5T0G3
         n9j7MRoHm4yVs9wW3dAiyMZMoJsm+SfSpo4bzWJj+76anYj4XY6mEH9qIMFZjesCjznv
         4lNZxVBvtGsu/4h/+Ld9D9KQu7HILwiyw2rYSuOxLh7Mp6SQHGwPQylhA0xMwykyVdXV
         Q3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742368702; x=1742973502;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2t1e8lDHeeC+VhrMMM1rV8xRnNEpcJgqStNn0Vw4SWI=;
        b=NDV4PsdwBGb+P40DwT9R1C2stAVkNS9bytC2hnfxvxvIJ8ZS551P2ZK5/JhLSopH0L
         PgfM0zAbJU0/wcFWFBFezE8OWzn8X1xr/dT65ZSmnBRSlO6fBn7O3+h9S77DEw0bepNW
         c8wxs4Sz8lfN4y7QY9L4f22Bry6qdPnikvT5Bre8MUpRM1ufoDqiPWP24QQQdOlcXbt3
         JHpsww9WFnR26l4nupF+GkyRYBNBrRkeafBSxL9h/iV1CSS2IzJQV3TJ8lX7cOn0DMep
         O4LsWZI8fauthpL5trKGLGHRevmMe6r+4Gf+rekl0mVaR1cMJuAYCTxX1NnwQ8GP0016
         aiyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7hyfz2d1NwH1PVlZK9+JetCGstHy3p8Lg0w70FlIHSRszyb3KXyO28yE6IuCrw5xPR4MygfiBrh5ZkrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyEfAlsUDGJ/dL1wUjEnxhILjm42AkTjg9Ip50g+J3to/YW9Ng
	GQnfUTlO0zUzUOmFfWxC2eLR6Vl32QA4wltGKG4rTe7TZWRMsY4IBUfpDzLI3Qw=
X-Gm-Gg: ASbGncvyMBqqsliPKaBeTZb6Efz6vFW8FndKCL6SpQ0LZiHniyFyOm4Ih7TFfYdwHLr
	2Rd3ojv3JcyJO1YNzQscWjIAqxxw+h1MIh4gOcYoMlOtxX6IJPRIXsFV2YkE87WtssokpQ4Wqt0
	cxGKrSnKwrTaazBtJwPfzt0b5QOE87pyRnokORxujtHU2K0SY7OWBj56+5VEZ4aHSMQXoQqXiT7
	l+xL0Rpgnx2qz9i98k+bxENIyBVCaGK20OGxQmBuIODXsv9svHJqfyH6/BsAeQqz/UDjjUEQUYi
	rcQwxM+P1DG0UkVMm67gFQkbIiCBCveFQkB9nyYpD5Agc1ISE7iX1H/12TfiSJM=
X-Google-Smtp-Source: AGHT+IE8IxeWFwFlKpP8Jw2vDUuTM92MTiYoo+wRg9VD1zFAykda6SI5zvDb5BcQatEeBZe+hwdHQA==
X-Received: by 2002:a05:600c:1553:b0:439:9fde:da76 with SMTP id 5b1f17b1804b1-43d44bd7e25mr2942125e9.0.1742368702376;
        Wed, 19 Mar 2025 00:18:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb876sm20048778f8f.83.2025.03.19.00.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 00:18:21 -0700 (PDT)
Message-ID: <3f147dbd-c4a7-4cf5-911c-1d9263f5067c@linaro.org>
Date: Wed, 19 Mar 2025 08:18:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: remoteproc: mediatek: Remove l1tcm for
 dual-core MT8188 SCP
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Tinghan Shen <tinghan.shen@mediatek.com>,
 Olivia Wen <olivia.wen@mediatek.com>
Cc: kernel@collabora.com, linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250318-scp-dual-core-mt8390-v1-0-8733e192cc73@collabora.com>
 <20250318-scp-dual-core-mt8390-v1-2-8733e192cc73@collabora.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20250318-scp-dual-core-mt8390-v1-2-8733e192cc73@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/03/2025 23:22, Nícolas F. R. A. Prado wrote:
> The SCP present on MT8188 does not have an L1TCM memory region, but the
> binding incorrectly requires one for the dual-core description of the
> MT8188 SCP. Remove that requirement. Also update the minimum number of
> reg and reg-names to 1, since as this is a multi-core SCP with no
> L1TCM memory, only the CFG memory region is present in the parent node.
> 
> Fixes: 91e0d560b9fd ("dt-bindings: remoteproc: mediatek: Support MT8188 dual-core SCP")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

