Return-Path: <linux-kernel+bounces-315150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D3896BE97
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7142828AD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D571DA10F;
	Wed,  4 Sep 2024 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ej4V6gEZ"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ED11922CF
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456918; cv=none; b=KcUBRnkCc0PkNeqDu6KJuo8dIRuul9u6tblO2ncotmhcBIUximqsXCeVltOUlwkZYLoaHZWJ5VAWru3GVdpLTKIQlOzNQnLz66dub67MEg7KAK+IrvdAHsrO1uniSHpjFpQ8AEgSv6r0PLUPUcf+7mzbZfiEUkvha39RIrb+1yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456918; c=relaxed/simple;
	bh=41xFYfekiMubd9r2YEtmUlcXoreoFCjcE8w50qz+NWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJ9vqKoKL8fk8E+nTq+pM9R1un6DMcBojq5pb+zYgIt5CbiJMaykI1j8nLZqZKSMt0Z5oAX4WiY1rktt/FYsGXh+uNcTJY/I7UrATyYBwsloSLMfaIfNAzKPFRBlEjvEHa8+Ruwb50XhAlhFE0Xy4H0HJw96RrPlwCaL3DxzbOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ej4V6gEZ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3780c8d689aso296789f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725456913; x=1726061713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ld5cWyae/iB0k1Ca1RVlaEbBbyAMRHm9ax0zyn7Axo=;
        b=Ej4V6gEZcpHkDMvv2oF4/93mwpXkOpfLs0BFdhPTM5ooPwiAu7EX+XEwng65Ff+vJu
         OozDsLXqQpgiSHHbhjnVfAOn87kh8NGPrbHsp7YCnIIzTXRfvFiIqp24cdSZb046osVb
         YornORTglNi8CF4gFzeBdo5YpUPdIOfwOkXwbw24fnWJ94vuHJQgpTPUIH1mhJNLFXi0
         CchpZm7lal9tlSd8eylPQYkBW/b8XuA8Fm8uyTznQhOELOYpfQhJzW5RRAlTA65stMCj
         B7VfWtrSwibEwAADeoScnSTwWtNb+gcDTMn78xJq+eCHl2bpxa4wPjpbneVVWFf8stI/
         fTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725456913; x=1726061713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ld5cWyae/iB0k1Ca1RVlaEbBbyAMRHm9ax0zyn7Axo=;
        b=Eriza0itHOsq7jOZCq2M+U6EvgywC14W26JIPuocxw346IxiRu/pfaeX4NjlHnzTcM
         p2PSha3autdTjGnxYk42KaobzyEbEDvy4rnfDlOQK2dyRZphmYFa/r9wP6emOIYIFRT2
         DXKmpYCpCQS6iayccs4pM+sju+LirPHFXNUviJCI3CUtQDIwzeYSDjcPfu0S8Mb7dVkV
         lD+Y182z4ivmiazrA3Gi1N3/nUIOVqukZ2K74hkuSMj+5R6dDmlrkpCoxFOsnEyQEqFR
         rVfM67dcAGKuYfpX17eIccIKMHXVtLtjmpoQPcVJTi9faLwomcXlvfyFBOehIvtZjCLF
         DcIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaxEn4RYWZnGeqJKetOi71ydo9y38pP0XrkKE1ESWL37Tb/IVaFJeCtZA6HpHTRv/jgTWoOK4F4/8W3pw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk+qFC4ung2jCBRIsFNf+de2F6h/O5/XzDjKRY1kXppbD1rL8H
	xOuYl1siUotaVDdG0KfRuWYVo+P8N131V+uKOfoBouAQnIgXGV7tYSPgOcZHyIE=
X-Google-Smtp-Source: AGHT+IE1R2i+awcjDPl197c7K24+01eFHTYrMYyuAR8ePTTzDeEHp8BDpPPt5Zs/ISrbNMsn/ws9NA==
X-Received: by 2002:a05:6000:4029:b0:374:ce9a:ff11 with SMTP id ffacd0b85a97d-376dea47205mr4000346f8f.50.1725456913032;
        Wed, 04 Sep 2024 06:35:13 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3767dc16f83sm4099348f8f.60.2024.09.04.06.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 06:35:12 -0700 (PDT)
Message-ID: <eac88362-4b3e-4fd1-b649-2f374453aeae@linaro.org>
Date: Wed, 4 Sep 2024 15:35:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] thermal/drivers/imx_sc_thermal: Use dev_err_probe
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240717085517.3333385-1-alexander.stein@ew.tq-group.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240717085517.3333385-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/07/2024 10:55, Alexander Stein wrote:
> This adds the error code to the error message and also stores that
> message in case of probe deferral.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

