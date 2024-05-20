Return-Path: <linux-kernel+bounces-183688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2408C9C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C5128331E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4785FBB1;
	Mon, 20 May 2024 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OLGHNE3I"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D4356B95
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 11:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716205761; cv=none; b=NVvtT3aFkHXo2hMyXixzQ03SfmmxasGnYoqDg0U4JfRLzjkV1NjoQMUMZifkJLyoP0q/tIisGmSFsYNhPzt/UmgTMshmzDdUsE4moO3cPCU1V68wGzWWa6/TXhModUOeQnqXqzlna6H+PesXuELf5fo04IqLHzXbPfL51iK6ofU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716205761; c=relaxed/simple;
	bh=yWP4aKeWINro0Ux1wtTeGfryGZI1hCqxA8nspc6sNVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhjRjlaNrMOdQbEwnn+SfMu8xkO5Q12rJSHALWZ384s3KED0YFoCTEnvKkhR1wqlOmINlpcWf9LEq8yy/c7VmqTXb/tuCbokgzC9WtoFIQjUToPBMDiFKYYcI1WPiy6+dofTbCrP9kejaw5BdZIVdUCrEabxesWldXBE1Vi8ITU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OLGHNE3I; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e72224c395so11614971fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 04:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716205757; x=1716810557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O/oxcJBIyXlY9TtgU1r7E6cgf1golLAQDrTLfXTTYDk=;
        b=OLGHNE3IPhuAk6QNRs5Q5cHUrohX0BV1OOMO7IgFj5fAacby3uXrkmkHSEkkzmKfWN
         T3R3v+A472Q759N5bbJURzVTYg56Tvkd9YTT9MEmF0jxA/FuD3ItLUZAEGaaAqBPS88W
         2xu/uMxTfW+CIQkTT45miLL0hSaoKbcHNApd+ZRHQy+vuO/wZkzjhxDU+A6zuWC+hs6Q
         Cd/uk25TogZW9PfJ/6Viicb01fPwbdxUe571Uf0POWzh7q0hMLbllFqtu7ZsEBcT7Gqk
         hYVKPzrkqlJ0U69IMGvL1vOaawzsLzlRA2PehxJVT0c+RW1X9ROsV0pFFu+cHMxy6J7u
         +b9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716205757; x=1716810557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/oxcJBIyXlY9TtgU1r7E6cgf1golLAQDrTLfXTTYDk=;
        b=dhMXyWHkhnBQjn7+Ytg4zZCrZG7Mjxy7sZUIstOS8ob79KB7PIWQDebs5yTxXtHwy2
         PQpabiTlzl41DqEJdEgDY03ziPSgZWFeXLOYNERuE+yhQDY8+GV+/5HGxEDjrDS8bpbH
         +nmMluBLgSCh3EYwDaasLNhcLzjrou8s3Ws6XT3hCn69/PZlrzgZCCaRid/sMxOz5wFl
         ANdCPKC7c685f46Bh3FQxR5KtygCc6hDx9aMZXRDe+6U/w1RC2WnGveKt5JGZCCSTa66
         jGbgENwdTBFSirWem7MS8roN2w5oG+4H/j3aWSecpmZMyiy2jjlqgBcCv6TAN9rtl1oa
         p9Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXqWv17M58QOZHhglFhJrBwrYCYUwB0ZXXnWAISuF8lvy7G4QBolMvJppuSbqtHvMqJuwC0cUklcYFxFM3iSCWJwZ4kAtGmXV2AQILo
X-Gm-Message-State: AOJu0YxnJHF90xCo/PTG3ydYJ/lIk4RwCjU9Oqhe+rsnqBpWjGuZ1oMc
	61ChM+l6u9oIPJTT0NlwUWJiW0PeAOJwi1qsEYZvfHfbqeq40HOt+vFlz/+b5uU=
X-Google-Smtp-Source: AGHT+IFlzaGIRfESALSLtsyNFlfZ1/JIBw7ONHINjG4LvPNB4eEcZEi71DkW5rhom1Y1o6Z5gbWZjw==
X-Received: by 2002:a2e:98c5:0:b0:2df:6b06:b5dc with SMTP id 38308e7fff4ca-2e51ff5cf54mr192231491fa.15.1716205756937;
        Mon, 20 May 2024 04:49:16 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-351b79e8e6bsm21316539f8f.65.2024.05.20.04.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 04:49:16 -0700 (PDT)
Message-ID: <67f13b3c-18b2-4042-9908-b4d41c24cdb0@baylibre.com>
Date: Mon, 20 May 2024 13:49:15 +0200
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
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <7dbe08cf-47a1-4da6-9035-6b0932cf8426@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/05/2024 12:53, AngeloGioacchino Del Regno wrote:
>> So, I don't know how you want to manage multiple display, but IMHO there are 2 ways:
>> - removing the current "oneOf".
> 
> ...eh I think this should be anyOf instead :-)
> 
> I'll check later and send a v5.

"anyOf" behavior works as expected on my side, dt-validate pass ;)

-- 
Regards,
Alexandre

