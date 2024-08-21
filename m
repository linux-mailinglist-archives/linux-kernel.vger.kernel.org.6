Return-Path: <linux-kernel+bounces-295583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 469DC959E91
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C901C2260D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97CD19995C;
	Wed, 21 Aug 2024 13:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g7hqRFNR"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671641531F7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246634; cv=none; b=RmhCIWx4NffPWa6qnJs5Dd7SD2yzSeUjJX99fxm5odR1UuEdJsPCcB4memLulhi11wuHSRddRVkkCKgspSmEXGAnlYWR70TI6Jn1DYQ+rw4zKOVCCmByw4JfBM4RAkIcVTXyCRTIHnLMUbyPbqOpBJZoKIeFgoVsEOojspszmZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246634; c=relaxed/simple;
	bh=1pr66jIBS64x70arVwnLavlWAlzk36uz+N67v9T/qus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EDmKgRNg59msTX2c6YXEbJRrl3YdUci5exjoKMBtNT1FivBhRhhHeH1EFmInXWJCisUMe1ejUVBYvDq6v0fANVQf2mMs1VnJmA3ZlQPGYWKJ5MLfiDjNrTobkRUN01SfBFFjR2vItGel1HxpYICKxOczCBWZH/UHo0LdOVPw9jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g7hqRFNR; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3718706cf8aso4075095f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 06:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724246631; x=1724851431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VCciJi7JxhAf6KSqjag5dJ/2hYHxSDXbm3lJCm4J8IQ=;
        b=g7hqRFNRd1AL9Sev+8ZwnH+uqlTSSDS85vIUDwUGA7hLQeaVRJnC9PII29LFZMQarq
         iQ2oUBKGmplLUzJJ+0mVZk/HvL3il+gz67yLTwODdJJx/rj+h30Zr6vuQ29dMkClFWGx
         bxBuZykdIKsDZ7k0AzQ1ftT4IPtQvKnFtQ+CoAUZIgm+caZSCTDM5ic+/M6IURr4/lOg
         YvTqBOBamAN+nSKUEN/udGOkFy2tZWQdOQjezCqHC/LL81CcxZnE9Rmlxo5j6I4t0CYa
         ybwj+HPqbuVC6KADV38djuOeBk0VpU138PKPWrrMvOULfZ5By8p39bbGMFUrFm9imoM3
         q7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724246631; x=1724851431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VCciJi7JxhAf6KSqjag5dJ/2hYHxSDXbm3lJCm4J8IQ=;
        b=mH9VNEX0XpwYE2ji7JwexmYdp2BWowzwv3dTz/Md3RSbrQAYbx3aAK931yAFNk7Xrx
         dABLoFmBE2ZvOIiq0yJxT8Ts55inAdnOCcFnKJ6ZUox1b7poATNx3MX5e9IoMB+pvoR1
         EbPbTkGhX4jfUZP1L0gE0gysBooHIVhibOJhFl4Y6yFBt+0ffcB8a32yKjQHfvDuDhc6
         ZwHjXlbM3KpLb9QFPMJVNAP2nQp+vJVZh9xKJIuLLcLPvbIBZVicbrCmUznly5JNI3Ls
         Z4F1Vl1h9WTKtlTnmePJXdXWqJNDXQn86H2yvCkGyRTxKb27w5pBw2p+FCK+bZgbaHp+
         r5tg==
X-Gm-Message-State: AOJu0YzET2RlW+YpDi6UpXQe2iCoCPehs6Aw0KSAyxX9fkJaWPtxdgLA
	e0urFoxpMJyfxyN9hyYWOf6FRoaZXThCKyTzcBIBKM1haTJkSowXIukZr2WX9IQ=
X-Google-Smtp-Source: AGHT+IFGE/94UIJXOsrMVfuezmbmwIz0XQedE5AWhGbI7EeyHlwUXExDdcnc2vdbCQ3Aes/LvDehyg==
X-Received: by 2002:adf:e6c4:0:b0:371:8db9:939e with SMTP id ffacd0b85a97d-372fd82f0f2mr1355829f8f.51.1724246630296;
        Wed, 21 Aug 2024 06:23:50 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37189856b07sm15710219f8f.50.2024.08.21.06.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 06:23:49 -0700 (PDT)
Message-ID: <da3edca6-dc7a-4ec4-8cde-3bdc95cea48d@linaro.org>
Date: Wed, 21 Aug 2024 15:23:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/14] thermal: core: Unexport
 thermal_bind_cdev_to_trip() and thermal_unbind_cdev_from_trip()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <3512161.QJadu78ljV@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3512161.QJadu78ljV@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2024 18:05, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since thermal_bind_cdev_to_trip() and thermal_unbind_cdev_from_trip()
> are only called locally in the thermal core now, they can be static,
> so change their definitions accordingly and drop their headers from
> the global thermal header file.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

