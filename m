Return-Path: <linux-kernel+bounces-227009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DECC291471C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3301EB20D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F41B136995;
	Mon, 24 Jun 2024 10:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LpPqKTX4"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F79D3BBF2
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719223728; cv=none; b=ZvrRy5mOJBQ2oWHVkXwSRCVYZCmB3KNEVANkb1N3eGbtEzwc/G+ROCs8KoAxI9c96xYI857rumMn3eKKqbIFUYz39eGWAYkG4hS8uXdQxXC+fbWdWoR6EBctDxPxHqlxHnS5EDQWFTjwV7ThPy6dQF+e/QFKv5BuAUlBJfVBQoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719223728; c=relaxed/simple;
	bh=/UbKLukxBkddIvRRKzhPewkQPsvqcr7e+/63nHw+Zbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PdX2vmMJ/u1GdtE5kASGl7wh2yvlT3AH8QQrzCeeYmQ45v7zvO05stdtXnuhFZxI+ztCBfIVS0NJ5mfQqV3da8OQHII/t8TisPWSpQ/ZIhOr/FqOdBFadYcHkKYpJgzXuPKlg0U3hfVoDFwr7Szn5+i3VUfsVkdsygAzblbcKIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LpPqKTX4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-421a1b834acso33513005e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 03:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719223724; x=1719828524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RliwQr7oKKeCWRGlffC526R8LGHslGlTF14dPvseJ7Y=;
        b=LpPqKTX4YGyXxuM2x4uO/4eFX/Aq4w29njaBPGHnDp4mUj3uNC33oCvwt4f9VVc36u
         +YJ+JLtKnL71DcgZgNEFoWVnEFHMAkKvnRhfDJowsysy1kPZs4JTh3srIJSB5VtflNfO
         ed0KreP3duvJeLyV5XDDWFT0wLzKmdaxdQle3ElEaXdcyRmP3YedV/kdDYrKEeL7uBpa
         92Qmhe57H187ga2a2wvNob5V7WxXh+8owLlPhpHbT+eJNLEbU2O+LFLx45bKh5mtzc3F
         Uth7k/MejEy8kTw8+IL/GBHikM9zp6xZ1UVrjnrJWgg5nYkc2+hkp4GSZjUfRGH1+veF
         vS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719223724; x=1719828524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RliwQr7oKKeCWRGlffC526R8LGHslGlTF14dPvseJ7Y=;
        b=MTcdNfHOoRmE2aTVN5i8KgX9ErRepS2yDjSFlIJfquKMUO3bc3L5vAu+SfGu9Iivvy
         oRSS3UEjI/+kjEsibz9Zdtx9GhZkcKMmHYYDObWoMqMDaGZu1A4IovjcdBwcVnVhApZZ
         vu7WZjNEcS0lOFFckpXKYZh9gK3SpsAs7Fm3t7PoATIUDnHKD7DYdX4VyszeXiGMMqDn
         nQzFGn44psrCRJFLkzGM6tuVsdhtGRQpMYjN+n1gs9PJsep7bBmHmCc/WYM6zL0ilKcr
         3JTGOD9KfOs6R8ognPl2IeHGlnHkB97gJR5IwLF+pvBcyhG4h5KQYaOuK5Jw+OrpI0mA
         2cdg==
X-Forwarded-Encrypted: i=1; AJvYcCVqxTTVOEDLprS1sYXUbbv/7TP/FLIZZcAp4uPobv5TZG/xEXnBxIHdNzoCqyPdIfhCJu3lyTCzttcj/IjuUwO9/OoMumS30HV4k89o
X-Gm-Message-State: AOJu0YxaViyVFTRyTrj0RfiwIh5H8n0YlHW97TUNhVTkWR5+nUd+IJTo
	LvmnzJs0pY0Dx4HKSGXVuL6yZqE8waTv2g3S8WpKDtBuY14Pg0FtFch/K5VWvxo=
X-Google-Smtp-Source: AGHT+IEwW9DYv23ejvty0qnPu1uOFrIpQ72XFDd/4QPCp440w3+DZGDmsX3BUt8bOnyalY2jFvabtQ==
X-Received: by 2002:a05:6000:1fa7:b0:365:32e0:f757 with SMTP id ffacd0b85a97d-366e96b22acmr3421441f8f.50.1719223723739;
        Mon, 24 Jun 2024 03:08:43 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366ed18dfeesm3593710f8f.93.2024.06.24.03.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 03:08:43 -0700 (PDT)
Message-ID: <6e643b88-2fbf-4bd1-b7a9-1af9e93f1916@linaro.org>
Date: Mon, 24 Jun 2024 11:08:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] Add debug log info to msm_csid_subdev_init
 function
To: gchan9527@gmail.com, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240624-b4-sc7180-camss-v2-0-0dfecdc50073@gmail.com>
 <20240624-b4-sc7180-camss-v2-6-0dfecdc50073@gmail.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240624-b4-sc7180-camss-v2-6-0dfecdc50073@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/06/2024 00:22, George Chan via B4 Relay wrote:
> +			dev_err(dev, "missing clk %s", res->clock[i]);

Please don't abbreviate - the other error message says "clock" here we 
say "clk"

Once fixed to clock please add

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

