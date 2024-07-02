Return-Path: <linux-kernel+bounces-238154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC346924500
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78BBF1F21DC7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF3C1BE223;
	Tue,  2 Jul 2024 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lmQHjknD"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBB61BD51A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940622; cv=none; b=WaDW14OA36Gk7ohqhFYEpsqZGkZNSzoMyqF4jS0oUDopmLuaDM8K5RE0LE2lgItblmV5wKghoJZivvDc+yOLO0rqHFNHnOpg9c6AOk1io4L51PGzxhSkFJMf4V5Ot70jknRjDlW57K8fPYrrCjjshPW/BPyi/jKkKUrM9PbIhSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940622; c=relaxed/simple;
	bh=Qd+9FCBX5hfWZQ5KFpMTQfddQGI9s3Xv+vB2p6WPZBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=faUMdVIEosvUMNct/ZG5AySeeqS+yHQ7bCVtbCVs4f0VGcK1tFg+HQWckf//7oorixk8u8RCquC1sMhuFW7dYHy2jCySpNIocjmQMnmLWFS6E0Iq2v3ce/o/PWqGr+n0ZIYD3td1Z621to6kWGUZH/rbJUCE4xEpJSCSpikjOt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lmQHjknD; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3678aa359b7so530113f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 10:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719940617; x=1720545417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eMxjNF73xEehfmLmhKwg3pjkqI+cYmjdSdGZcjJzAQY=;
        b=lmQHjknDNO5eFESHHD0posluOABZKtvEgYhW8eMsTcRO1gN5niXJ9NdYCJ7fo7YIpL
         iHl2LGnJCxMdInO6NFko1VCAUDMskmg9mlicJkSg/vv50gtbI3jUF9AzBltt7G7Josw1
         XJHkY74SGNJQs/fGJvBf2LVXk04di1/+snlEwpf8imunxyuJ2uAtMH1ZU08KoTVq7oWe
         GNwi8P7akn9IcRa7mOLdJkSe8DsIPnF1bB+cVU/CNmJgp4BTmmCv+qqoTqO0zpmwpBAF
         PKsOHroS3eWwz9mVL0wIZxGYJjLqLDnGq/4DS9ccmb3edZjz70W+FmiYUV7FMW8BRQKj
         OaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719940617; x=1720545417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eMxjNF73xEehfmLmhKwg3pjkqI+cYmjdSdGZcjJzAQY=;
        b=p/eFVsiKMF716tylW1xZH1SNd4a6aRLX8KKbOeFBvgbLW+Gh6+nNVnMmsTmG1q5Uaa
         y76cSfuAnVqqOnVL/bx/iOU3bsKNCKZFq03I3gYIsu1/ee2r+w+QaA5TKBrCCmJQEF3L
         PeziLQjYJUSAY1CTca75Hmdp7+GjC6V6MP6Y5GpIgpfvdjr6oyyV4SyZktrNwdjN86OV
         AHPMgW4yYaXBMZPml5ybPlPcMJ/esvyUY0s9lMWoVtjRBc5Q/InzeMRMlLJlmhKWbQTo
         ob7JjM2Nh3eaV6Ry4K1Nobl3XeW7uS32/BAnmgU0mzKYmRkjv+TwiZgI4hH/gVDB4DaK
         uE3g==
X-Forwarded-Encrypted: i=1; AJvYcCWlqUTPn2DyHw9YkY+FAsM4DWwvuKXHKRYCvFLj3ccsOV42Y+XRqe8YvnTJGYWN/MPm2ExPBG2k+jocxu0K/L+4hsY93tzACthQDz0j
X-Gm-Message-State: AOJu0YxnIWmg30tbDwsFMK2YWSg68fnopN6HUO4YT9X0U9N54FdmQnb1
	CeIPxmYWm8ZNIA5+TV3Vh3yo++6IFU+NDhhDZA2YkikGoZPuysxApgSsPRIOJCQ=
X-Google-Smtp-Source: AGHT+IHt/P0ua15wXj9zZu7YMLDV20uxy+PQFqpcA+vAHPimqKTS72Y/7YzGoy4cdhn7YTh0hbVksQ==
X-Received: by 2002:a5d:5983:0:b0:35f:314a:229c with SMTP id ffacd0b85a97d-36774f899ffmr9542381f8f.28.1719940617271;
        Tue, 02 Jul 2024 10:16:57 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36789fd7a0esm2004822f8f.104.2024.07.02.10.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 10:16:56 -0700 (PDT)
Message-ID: <7a198549-df42-4fb1-97cd-116e1bd96903@linaro.org>
Date: Tue, 2 Jul 2024 19:16:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Provide default
 calibration data
To: Chen-Yu Tsai <wenst@chromium.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Nicolas Pitre <npitre@baylibre.com>,
 Alexandre Mergnat <amergnat@baylibre.com>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Julien Panis <jpanis@baylibre.com>, Balsam CHIHI <bchihi@baylibre.com>,
 Frank Wunderlich <frank-w@public-files.de>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20240620092306.2352606-1-wenst@chromium.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240620092306.2352606-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/06/2024 11:23, Chen-Yu Tsai wrote:
> On some pre-production hardware, the SoCs do not contain calibration
> data for the thermal sensors. The downstream drivers provide default
> values that sort of work, instead of having the thermal sensors not
> work at all.
> 
> Port the default values to the upstream driver. These values are from
> the ChromeOS kernels, which sadly do not cover the MT7988.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


