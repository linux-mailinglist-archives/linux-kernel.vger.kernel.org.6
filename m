Return-Path: <linux-kernel+bounces-384800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 649279B2E96
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D4D28128A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F78B1DC1A5;
	Mon, 28 Oct 2024 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YRmfjaEI"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721921D5171
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113905; cv=none; b=IUndtdIzIlmorha4rWSCG/QXpes2I7+cStfe1dIGb8kjlaM10RQWOVQuE0VyTjCVwrpJ5ezGWopWBKlHYURKVdBaFRptCtbV1J2JGx+k6F+yZHR3oYGZmb/tR2a7/j/1pXZiXJI/9mEZijfEeWOEAqTKB/0xAPryqhv7qsc+GPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113905; c=relaxed/simple;
	bh=f9/PsUAOENGCO2p9cGP/XHigmN80YiQDiKgPnCLMWxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ii8Cn0jbnqTqx99orNuNZXIOOXZZjoXspBxeFGwiNvpM1+wGKoD5Gf30M/i+TbfFI2mu1XWk0CXlXwjeQ0wu2CH2vpNYTyyiE/iIjjwFs9HXU+dDsQLTXxCXHB8RQxDyG4QbzgeKeJVldTuEHLbTOy+lTi2c/CcwJn2eUMxorGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YRmfjaEI; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso41122175e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 04:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730113902; x=1730718702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w9kc/MvcCGqsHKnuIn7RBxtKONFpaars6wfvKoTsFt0=;
        b=YRmfjaEIFhwnetaZLw7VFd0WhFbtSpWDXE6440URyncI3yA8RfRDGs8cRbWO7G4FfC
         28uVUUHqBzYrbCje3T/syuvx2fh65YooCvSo9m6G1wKhE+96uGK+0RnyeCOgmW3371wB
         gqO6UNxxgGqchZfzAwVJzoi2iwqvbJ9ZADvEnPgXs0HcE45Owiiro1rcQ41dhdH0cFJk
         y3+ZG3Fmas8+gW9KGz4/kgvbz+E3BZJS3P/lamx/pIPp/zTVgWgA1sZ0lGPhcKgLyWYy
         6U77Z+q9XnkKQJk+axSjk/0NEoGXPTQiXxa3AvysHr7Kqg/lrdnitZsnRaVc2j5hl+6C
         wqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730113902; x=1730718702;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9kc/MvcCGqsHKnuIn7RBxtKONFpaars6wfvKoTsFt0=;
        b=f1XwcC6BOnEYeqHQL9tjdRr/3xXFMIbrGMSxb/SjQD7bJv3+lAg+SJ+0/J0UyzmFIi
         moBAlw3FzXy1AZTN4RtXP9efyCuGJbzlug6AtOT3yXez4JC4znQUX9mbCYL1nVdfvtY5
         gzUOl7kDaHry/cku1nJgLDArPLjotfuuHaEjJ9WimDzjOCrCd+6qYcgkOlC3xbn/JdCV
         o3lkWespvWoFykBVzIRksCWo20r/ZYiketJ53HtPIUNjNzD+nASUlSTxe0ABeOKrOfOK
         sUzk27d9YP75c8cUHFDPMaLva3t6hpJh/gDEmfS4G/JRnYXyfAiSTp8GecBYJ619h9kC
         a/lA==
X-Forwarded-Encrypted: i=1; AJvYcCXqvvW8DXlM61IY9AFy8+iigmTjLp+RjZTL0nYPY5wxeL69zfSi4+AuR5ALQZqACyLTKpJABZFk2j5R8KA=@vger.kernel.org
X-Gm-Message-State: AOJu0YynbZJMjNwfSmULX5ZQbWhkW7VC2yd/+AMlOFrAMtUmKPE8F+Ga
	brZzCSyn3j4YY9MYvSoqb/IXXFgEKMVWfK6kYS1f6L5dvfhDtamt+CwLB6av9Ao=
X-Google-Smtp-Source: AGHT+IE+Z165sXrl550KdLAVYhJzn5VZwWhbSDKWVfm/qVBNZ5a2SDbV2JU/QTEhxtpAj9JuK3Plsg==
X-Received: by 2002:a05:600c:511c:b0:42c:a580:71cf with SMTP id 5b1f17b1804b1-4319ad24423mr63292375e9.30.1730113901661;
        Mon, 28 Oct 2024 04:11:41 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43193594fe7sm105537645e9.14.2024.10.28.04.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 04:11:41 -0700 (PDT)
Message-ID: <f87a0f0d-8501-438c-b05e-7e4554547c79@linaro.org>
Date: Mon, 28 Oct 2024 12:11:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] clocksource: sp804: Make user selectable
To: Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Ross Burton <ross.burton@arm.com>, Mark Rutland <mark.rutland@arm.com>
References: <20241001-arm64-vexpress-sp804-v3-1-0a2d3f7883e4@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241001-arm64-vexpress-sp804-v3-1-0a2d3f7883e4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/10/2024 13:23, Mark Brown wrote:
> The sp804 is currently only user selectable if COMPILE_TEST, this was
> done by commit dfc82faad725 ("clocksource/drivers/sp804: Add
> COMPILE_TEST to CONFIG_ARM_TIMER_SP804") in order to avoid it being
> spuriously offered on platforms that won't have the hardware since it's
> generally only seen on Arm based platforms.  This config is overly
> restrictive, while platforms that rely on the SP804 do select it in
> their Kconfig there are others such as the Arm fast models which have a
> SP804 available but currently unused by Linux.  Relax the dependency to
> allow it to be user selectable on arm and arm64 to avoid surprises and
> in case someone comes up with a use for extra timer hardware.
> 
> Fixes: dfc82faad725 ("clocksource/drivers/sp804: Add COMPILE_TEST to CONFIG_ARM_TIMER_SP804")
> Reported-by: Ross Burton <ross.burton@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

