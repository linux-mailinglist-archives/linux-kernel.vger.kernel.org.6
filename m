Return-Path: <linux-kernel+bounces-395004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF8B9BB701
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547D11F22F91
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9011304B0;
	Mon,  4 Nov 2024 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QojIpzP+"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C04E8BEE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728954; cv=none; b=qiT5eAINOKOUmnlemtZ66ihAlXlI3ZxJc3KhlD89XrfjE+nWLXEKWfqZCCCt0Q00HvGG3ulVaMuw5pSvZNTmMUOK+F/1pdy3GYmRRUIQbmycGMQtu4igomFRdqhAyOKXiRBUd59k1H6DPrI2fmR/glFJguiEFOvYLrDoxAAdCdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728954; c=relaxed/simple;
	bh=yOBXWoJhGmMMi+ASyzGvTB+XNlvI3lLoqdX8FGIcD2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCH1U7NCN7kcubYQHY+wG69VfR1m7lFGxsmqbnEth4DFSenasXn+j14XscvSOMo78vKwHjSuHSkTCn3bDdnC05rApS8+8IN/vCwpSD0eNUP8dbrihyDEqIFFJJD+nMylNCWEQAylSNHEvUhaRm5sp4LYgoalMu37giDdVlQxYi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QojIpzP+; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d63a79bb6so2828055f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 06:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730728951; x=1731333751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l47cezxUWKYUnDwz81zm1LlwzjMrDQ9sTPrEy9RpQS0=;
        b=QojIpzP+3e0uQT9erWjLunhvYitCTwn/pMWtVPm53qA+X0ZlIROIXcaKwNguuY7jNH
         eKC5cyzwgq/I77SBKlErX/VgUtqWplsiv6330zffmoewDfN/XhT/CSXyMSZnL1wdQn38
         drttf76LRfw5ivAbLqwDxcrhlvF1av/keixlqpfRYxwOeR757cQO9gk00yaBgmJ1cahc
         oJI+8HKZsRO6Io7A/xfxulidWEu1+rtof5nQH9EJG79WEoKagv7PGY82tGdf9OxVaNAs
         Vsg5oVerKPUnpix1wwtFojpU0qujhPc95N3lkZ1wT6N1aXvLMRNitJoayd/pht1lakKl
         +QNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730728951; x=1731333751;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l47cezxUWKYUnDwz81zm1LlwzjMrDQ9sTPrEy9RpQS0=;
        b=QaygyVJBIb+TKR/LSkSPLYfIoMJihorhE2e2hgcqjG1nIQ6SaAt4OloTGHDbw7Neaq
         bwIPp0YCKjtnMs0jnw+86U24o+N2nS+lJIRTbxRv8xySgUxnLWDGUezPNhKo9bXcR5Xb
         jxN61A/S7+gROgtV9TBsA9/CzwyecMaPUtu8zvZDMV8DFk7wvBn9ws4AxA+M0hRdh+NN
         abrt+XMqbSvvnK3CC1OsGpnD5WOFCGJpQER8n+uI0ld2Qwm/CfYI0p+bcdeQJgYmiqL2
         SvqgaU/KE9KwFLKu7U6frFXBTffOdUcr5ZE4yZ0HoAmWzastYsD5R/Vvb0XrjnibFWmK
         3tdw==
X-Gm-Message-State: AOJu0YyO+QekK3rnBjY637fFP41Jv2qurmwBAcWnESyC4pGM5ZelCw1c
	vE2cikwrvrecec9AQAOS4ciDg044MVABMEBNOKq10L3GsX5IhefOxft68d6RIfg=
X-Google-Smtp-Source: AGHT+IF6lOtCx/+WZfbTcNvwOSZMIH2PwfCQYGb3bIroLE69OAyACQz4QIii2CX6Xq1JQ3cBHH7kGA==
X-Received: by 2002:a05:6000:2a8a:b0:37d:47b3:7b82 with SMTP id ffacd0b85a97d-381bea27d6amr13187154f8f.57.1730728950426;
        Mon, 04 Nov 2024 06:02:30 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381c116ae82sm13284355f8f.93.2024.11.04.06.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 06:02:29 -0800 (PST)
Message-ID: <33458feb-0a05-4714-a7a3-08a9880891d3@linaro.org>
Date: Mon, 4 Nov 2024 15:02:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] clocksource/drivers/timer-ti-dm: fix child node
 refcount handling
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org
References: <20241031-timer-ti-dm-systimer-of_node_put-v3-1-063ee822b73a@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241031-timer-ti-dm-systimer-of_node_put-v3-1-063ee822b73a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31/10/2024 13:54, Javier Carrasco wrote:
> of_find_compatible_node() increments the node's refcount, and it must be
> decremented again with a call to of_node_put() when the pointer is no
> longer required to avoid leaking the resource.
> 
> Instead of adding the missing calls to of_node_put() in all execution
> paths, use the cleanup attribute for 'arm_timer' by means of the
> __free() macro, which automatically calls of_node_put() when the
> variable goes out of scope.
> 
> Fixes: 25de4ce5ed02 ("clocksource/drivers/timer-ti-dm: Handle dra7 timer wrap errata i940")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

