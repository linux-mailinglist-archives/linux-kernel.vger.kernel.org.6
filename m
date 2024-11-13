Return-Path: <linux-kernel+bounces-408070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C379C7A20
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A813B29F1B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C552022C9;
	Wed, 13 Nov 2024 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TzOWkGue"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CE2200CB6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519456; cv=none; b=WqFu8LLmxROcflTVPJ4tJjGW3glyv/FmjGPelJEGiFrP3ZTs6E0+oaer9yFaqR4n+E5u+2NY1cGxUhdpJNSJi9bMdJXDQgrC/HftF+5rF++w3Q+Ks+ueNh2RNjQ9XfElMsh6efuerAnGg8wqBZOFrsRbSl+8Ym605txUqWkkhCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519456; c=relaxed/simple;
	bh=DvF5LhDrVA2p1bbBCKycQ+GovimY5T+mqu+cNMKGa1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=okAFOLOnkgiQxeg3B8e7E0sQLVa1PqKvlD43LzbCfcy/ydn0ckJ3y176feWJ7qQwmaPzir5oTIe5PGoxXlcjcaiZXvuSMOKQNLD04fo5hHau2Kmx3SHsOtM9icynewiDcFEYuIL5wR2F1o0KWNgCj1aS5MOWAwZ5hQGPwQItOPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TzOWkGue; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53d9ff8f1e4so1426576e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731519452; x=1732124252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fyXplJejgT4PEMFFqJ3S+/ZVXVpr2HhgcPQAhv2Drc8=;
        b=TzOWkGueIdpxCZExcfl1E4RPYFuoTAnujwx1/Bm0GoNeP2EO9KuV+uObaUetcgobQw
         uutqlwQYQ48ioQ+OACL2MVUy/dfF6U0vZeS5Pq0+5XMjxzIbLaGRS9S68VgsNVJZUruF
         kU5WnjmNsI3Hht4hHdqPDbZSqRyM5o2vaRsxlorksi6XoyIpEKW3d3Fd+N+O0RtKTlRi
         6gWpuVj/c5XFlxaxwzr+CIotGQuTVSBchQnh5FYbyu7I/TK6sv6kxUO7PrSiyoNLHk+M
         PGEwXyTH/O+keyY7xAFKHYxhKOriu2I1aTMwozOZuhyhYwhYlJRLjLwOfmq6LMLlEnsk
         g7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731519452; x=1732124252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fyXplJejgT4PEMFFqJ3S+/ZVXVpr2HhgcPQAhv2Drc8=;
        b=R9Z9g+HWbStuAxzhjW20KTw4KjTDfutHHwdaUw9RCuTiZIWTgnacFD3TOCWFlvQyoS
         GHfbu4Co1ToT6nNYIkPKSmSWbDrrJuii6vq9diPdDTEswGEhywXtjLFcY4yB5Isa10sd
         H4aO2xw769skPRIiMZG4SdmQXxqm6CM3uMXooimOG4JItTxBgOvfdzeybyurYcHcp8Ho
         SNdAXhZIeBEseWpGMy0QiWktWMz1rf5Vkt+Ig1yrJEvdhMcTpXX10yBngVEi39/lEABI
         sAV/q+V8nEsO0LPtaVx9qb9bf/UkekMTTDQSzv4Q9OLbHj6vbGOt0dSqPqisH+2FYwqB
         K50g==
X-Forwarded-Encrypted: i=1; AJvYcCVMSOK7KdcXteaKPS94cx/fzSJGkl4NyUj3xganJTyBZ5JcsxkxE2bhwON221pOzq8r6LKCgW+4vHHSlE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJcGC7zm6Jmgf+A8g4Hfs4YxlhFDpAlz/Gkcz3hzV7E7E1m2/8
	rCflWJjOgL5HphezH25+AsNozj4HGaiuW+fcF30NqJ03ZQyOtIWxIERgCwGcfkw6OVDqs/MWc7V
	I
X-Google-Smtp-Source: AGHT+IG6oGFpXj9pMK/anPGDjAvPq7otwgNewCgyoCKxXiQmsCacSGvet9AlOIrykGbDp3bmCAWpJA==
X-Received: by 2002:a05:6512:3ca5:b0:539:9155:e8d4 with SMTP id 2adb3069b0e04-53d862cd218mr10304363e87.8.1731519452083;
        Wed, 13 Nov 2024 09:37:32 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432d550c159sm31616785e9.32.2024.11.13.09.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 09:37:31 -0800 (PST)
Message-ID: <b4314b87-8134-4089-b48d-0a37fae94f30@linaro.org>
Date: Wed, 13 Nov 2024 18:37:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/k3_j72xx_bandgap: Simplify code in
 k3_bgp_read_temp()
To: Rex Nie <rex.nie@jaguarmicro.com>, rafael@kernel.org,
 rui.zhang@intel.com, lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 angus.chen@jaguarmicro.com
References: <20241113005412.2254-1-rex.nie@jaguarmicro.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241113005412.2254-1-rex.nie@jaguarmicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/11/2024 01:54, Rex Nie wrote:
> The return value of vtm_get_best_value() always >= 0, remove always
> false expression 'dtemp < 0' in if statement.
> 
> Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

