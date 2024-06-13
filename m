Return-Path: <linux-kernel+bounces-213069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABD2906AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC04D285EC5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EBF142902;
	Thu, 13 Jun 2024 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yQhSAw6V"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B46D13D517
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718276419; cv=none; b=MDVGQHSiyznZPR6CZI5qxUiVuREbsjR9U/eZqRqeuE653vfC7nH+Rfs/NHmHFQ8aON0twzjssgC/eruMd8HMBGuINTMH1LFUdAwM4lkx6ww9wdrTo9KS1rDXSTi67HSqNcSYlRF9I4bDJD5jZci8EQbOJfS/IK+9JHdglhXlXwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718276419; c=relaxed/simple;
	bh=oYMRSDDakaydPcxkEL6CQerBYw6j5TYwfuhBjn4dmO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=paqv74XZgQA3t+I2tYYCTw2NgGCd0Qj7ilNNkzjqgG7IbJ2RDyLWH9IrUTx+6ZNU2MftZ+5VI4yQhNpmyPmwOfQf6YKs5qA9YfE6ThyKHKcd/TMIzy2EJ22ejE6PtWxsR34W2omW7psKUpg4qGb8sP4k9AUVqfByUCM/pPoK2kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yQhSAw6V; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4218008c613so7229995e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718276416; x=1718881216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FRA2gN+fK7aCEO1XKkSyLOQjYFK11sMFInaEpOmy+BM=;
        b=yQhSAw6Vry55/d8MMh7a9Yar5f0+xCXBq/d96Yo3EaBC6uDx6MxhrOhFsRGfGxnSx+
         ViZhqeqI4goKNfYz2ozAQ9+Fm+b7RoMj5FXPduool/fLI35QhPlShDTn1DMlqlFK0dpf
         IVSR8fWZI4EirtcM8P4bEs95gVEtkdRhTzn8AAx4X3cOrP+hfWgGu3VTbqPxteUZozRf
         s8SiPcXMNunBFFkkW9/qwehtKhkcOFIOa5t2wAxHLdiTPKRmNDOuOCleYJa/vpM0bAaL
         muZN8zZJTFdmVWhSmC2XJUk7hDeUqzIwMXvQ6FVV9XVHZeAA9hS7NLl/A2TT0YS020vO
         Unbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718276416; x=1718881216;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FRA2gN+fK7aCEO1XKkSyLOQjYFK11sMFInaEpOmy+BM=;
        b=kSuGvCkGrjtGadYjojgwCWwGX2ONUp9KY/JqWPCV/QIUwsCmWKBtHGpeT35o12qUoO
         GvWBmAX7Xk02AADjoGL8Z+1jBShBKZnVK5BXi3hgKZwcsqTlhCh2SGX3cqer8/TSaX3J
         4CTxXlc3loffyrATvYMncj5RgiAak+SEX04a8jYbHpdy2hEix5h660XDgVCW+HWiXILz
         CaHoHayx+HNS2hrrL6kMeX/m7Ydh2bgIyO/nLUvDhB3PzfHirNQOMAv6EaxGVIQoQH1g
         cjLA1i19Amv4Vz6jDGg4tTPomooLzdelm83nzb+pqyH8EAW8ioxvUUKm8Z0uNG7mdEKQ
         GnLw==
X-Forwarded-Encrypted: i=1; AJvYcCXkwyK62L5V+All4zff32GNLWl0ypj33gXYxAfJbouH+sfcqB8mItLNysHtq/aZ49zer+Ce4s7jmOtF7OLwb28M2W7orc0FKiecKTHU
X-Gm-Message-State: AOJu0Yw4J/QsKJRAJLeDN5BXojJLH2uIOjkJnI87qiWKQpnplAv3Ilfk
	iWmiS6n5yZOwk2c4hdowllvjoDTDenXVL9vDKthY8xpnmVEhFe3RreHagGDQHyc=
X-Google-Smtp-Source: AGHT+IHp7x+oZRBv3lqmrMIFTdyft8V5qg20Ntpo/xXU2oD8ndDlDmG7/qy/Ih4VxqyEVpjeD5WBNw==
X-Received: by 2002:a05:600c:1912:b0:421:7ee4:bbeb with SMTP id 5b1f17b1804b1-42285c6ae29mr43922905e9.0.1718276415667;
        Thu, 13 Jun 2024 04:00:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f641a6c1sm19889915e9.40.2024.06.13.04.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 04:00:15 -0700 (PDT)
Message-ID: <a6793126-ba1c-4679-a2c2-eabad4f5a506@linaro.org>
Date: Thu, 13 Jun 2024 13:00:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] ASoC: codec: lpass-rx-macro: add support for 2.5
 codec version
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Banajit Goswami <bgoswami@quicinc.com>
Cc: neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <20240612-lpass-codec-v25-v4-0-f63d3676dbc4@linaro.org>
 <20240612-lpass-codec-v25-v4-3-f63d3676dbc4@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240612-lpass-codec-v25-v4-3-f63d3676dbc4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/06/2024 12:49, Srinivas Kandagatla wrote:
> LPASS Codec v2.5 has significant changes in the rx register strides.
> Due to this headset playback on SM8550, SM8650, x1e80100 and all SoCs
> after SM8450 have only Left working.
> 
> This patch adjusts the registers to accomdate 2.5 changes. With this
> fixed now L and R are functional on Headset playback.

I was just about to respond, are you sure this is suitable for sm8450? I
looked now at registers and sm8450 (which should have codec v2.5) has
old style register layout.


> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I tested earlier version of patchset on SM8550 and X1E80100.
Best regards,
Krzysztof


