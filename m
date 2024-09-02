Return-Path: <linux-kernel+bounces-311196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3549685D7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DDDB1C20CA0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F63184531;
	Mon,  2 Sep 2024 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FL7H9TCG"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E6B273F9
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 11:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275527; cv=none; b=XNRsHnqPy1M28GDQHkE3Y1rSoNP2zOKNi5lrXlxiibpcyFxpqDKZStAOiMdOWc/zMQXzaMjPISy5GKmQjc840LiAJimSjv1i7F8JEO4JvP7gMXL6TUmP3d8B8bzF737G48rFbCaWFu2B0O8aDPHDgYLUWYGG+oyc9G5dMA7Tuas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275527; c=relaxed/simple;
	bh=NSdiqkFQPQx5yVhkYYf5EllVdO2WEy6pd5UFzcR00g0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rc74coVa+EwU5eG6Zgsamm8HYDbQtrHcFBSwBtNi+dSF65xr29PPubkNukx3GTuoOX8dEsl5WHHdStPLPBKGXVRAgy4NuMfbApRqgJYqNRnLbCikPJMSOunDhOE7axp67LbfElq9ZErPQv9F6lO2aYunz6ESDjqNhqILVnFGJp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FL7H9TCG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42c2e50ec6aso11015495e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 04:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725275524; x=1725880324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XdeWPvLZp3Q6k2FkXLajagX65ewk16duqLJh2HAU6vU=;
        b=FL7H9TCG7JdRmkwF3b9JzHES7m4rE8e/3EkKWSH662DbgopxfHMTr5x9GnMkEPY1BR
         qm79QOMZu2csjf9khxN3arVJDY2JuABtRkwx6tiOcUlDhfRlpAzX8Uo8iHjZDmrJmElC
         V/ua+nS4IKqRasIEfrQSVw7XW3lOIQDY846edBn4Yw4yb9+y3Il6oTaLy3jpDRyiJDJr
         ByEThMoPFTe0+dEWIjb1OJEH1Fx3sqZu/FkFjApd5sDIdhR+MguZHHDONIKEViSKnS/x
         WnI0zALvU1WcPsfOayDSpoZxw6ckTe8Ei7h8ZA03wHvO2leU9Tj/vI2EaSceE8IdW3qM
         YrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725275524; x=1725880324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XdeWPvLZp3Q6k2FkXLajagX65ewk16duqLJh2HAU6vU=;
        b=c6Xf66lzRd+/qdtkQRgWpOqzt1AVRwoUI8SmMGfoxFfDsMs3PmT6QhLm28ETtmVmW0
         u8+t3IzETUJSg8npXupOezF5mkMzqk7skgogc/CyVSYonKRGtLFVoVbz8Yezoug/6jM2
         xLzEp42kmJ0rablO5n6R06WBe741r5S4qD2WvBHbB9RzGjFM0wLslyKn2IJkfjoevQTZ
         MwM8amp2bwNLSmhuiKVO05KxHzfCtMAmvGpFvujAx3GxQO9bsK6qHtlOcLbdEtUGi92+
         7tpJN7LWMuIwRIVvvaTZxVCCOsMT40ekQpoyz4a7NNf6uUgyuRDm8GvTfW545yD2fei0
         9SdA==
X-Forwarded-Encrypted: i=1; AJvYcCWXmmQwMItWFZhG55OrhqZP+QFPdxuioNxTchRsjLeiMDizTcs8eFFMmfWuzuEqI+MeHZCc4YoXhNr/08I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKOKI664E6oooWjwp9/AMIOXPcM+c8NtnNX34bzHIIt9nxOtRs
	zwtjOzN9QvyxKqEEkD7cLmYjMsvYJEWDwSncX1Z0huYfBuLIwOT7lMcmZY7RSac=
X-Google-Smtp-Source: AGHT+IEU0vG7DmPRieGOS4+Qr79/RLmOGHPYDu6WJdJnpIUDrjMq+4v6nQ/PkgD3f5tawggCC8Q5zA==
X-Received: by 2002:a05:600c:1914:b0:424:8743:86b4 with SMTP id 5b1f17b1804b1-42bb4c4cbefmr79908475e9.6.1725275523470;
        Mon, 02 Sep 2024 04:12:03 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42bb6da24bbsm134531505e9.0.2024.09.02.04.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 04:12:03 -0700 (PDT)
Message-ID: <81c2084c-d62b-4bbd-87ee-a9cceeb1919a@linaro.org>
Date: Mon, 2 Sep 2024 13:12:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] thermal/drivers/renesas: Remove trailing space
 after \n newline
To: Colin Ian King <colin.i.king@gmail.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-renesas-soc@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240901162719.144406-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240901162719.144406-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/09/2024 18:27, Colin Ian King wrote:
> There is a extraneous space after a newline in a dev_err message.
> Remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

