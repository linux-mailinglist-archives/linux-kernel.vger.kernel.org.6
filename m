Return-Path: <linux-kernel+bounces-300559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B1495E512
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 22:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119211F21C85
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 20:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490D76A8D2;
	Sun, 25 Aug 2024 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="pYJ9xUSC";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="aG/bp6H1"
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB4E801
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724617155; cv=none; b=XbOni2BDBSh/xSSe1sMfKMYvKznlJEPD3tae9DKRImDFypSeGMIkwseNHBV9e+zCV4HskaAKJRNE/OSUdsZ1TquTbkSjVj8uCNvSqNzSp7+rlG/fSQh6X06ovfnhCle6rl71bjyOFAaMv6kTh6M/SFjHadsBR8KAGbTsGoZ3kyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724617155; c=relaxed/simple;
	bh=KHfuj0WsmTQ9rAo/jJOdrdnJd1Y3CYUBuic1YO+g1XE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTwj/IRtYOSuX+Kuhgn47o8UwKcJ5Wg//KQ0FTqm6LbB8UB7yKUIhjF26LTycqZ1cz585To3N7l6rvV8zPb25sDzEH4EY55qmkOpKY1szKNqyTGWWu10RCm8syxASCcpmzhJaTckfA5jZDJOn4x30U3jfYUqoAlsBO2HyFkPda0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=pYJ9xUSC; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=aG/bp6H1; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1724617152; bh=KHfuj0WsmTQ9rAo/jJOdrdnJd1Y3CYUBuic1YO+g1XE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pYJ9xUSCYUOzAStBeX6sdZcJoto9Ceh8vg9DnAb3bzDffLVnm5wiERAxlK5MU9SnD
	 4MEYJXIIxPTRX4dVuWJ2vNsyGEDixo32Gfumehjj9VyhpjrpJvRNMLtdeROfrA1B4X
	 0yA78NXVcoNdPxz3a+rZWgQfb5S+HzH7yX5Dgg2SWQMX09QP7evmSI18xeE8apPcqg
	 vIW1GEYFvGcITS6Es8m82AS8p0+q6hLCyqgjrQ/U0YSdQnAfyjt+TZgyYHTWTiHRHI
	 +DnrqmwsMQe4hhdsExPqxHWd1IJLlIiBDtf6T8xnwDh6Rz3fusTPwRtt4/Q3XKJOwU
	 lC0aypV1KPhMQ==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id EE60116C9;
	Sun, 25 Aug 2024 20:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1724617151; bh=KHfuj0WsmTQ9rAo/jJOdrdnJd1Y3CYUBuic1YO+g1XE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aG/bp6H16StbcqYD+O4iIk3S18kHeszdchuI+nVQLH4N42YD8TsYNNhIWxdq2bGXY
	 GM8wNQ9fPUvINuqdWz4+fsUCYaP0Ppfo5M6R8c8gOMHCHoAARfyNULYTCK62fpmGMJ
	 2YU6KTpO6NhejI5EerEjxQSf7n43IVFi7WZXASqSHHf0Vvhe/n7dIIB4oDA5yHPTO4
	 SSeO+i3QAW31F65KTuY9MqpTur1Y3k+jbPU473TJNRaV8BuJLtBgdKV0V0M5SHk9ZL
	 c/MnHmBJNNE0fpN4xLILyWXQcDqOQnhP3D+4gf7o6cRFCVz4IVuzBQs2InV6V+LY1r
	 LT8ZeCcWmVvSQ==
Message-ID: <44f42291-66c0-4b1e-a44c-221d31afae6f@mleia.com>
Date: Sun, 25 Aug 2024 23:19:11 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] memory: pl172: simplify releasing AMBA regions with
 devm
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michal Simek <michal.simek@amd.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <20240825135001.48963-1-krzysztof.kozlowski@linaro.org>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20240825135001.48963-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20240825_201912_002509_4D4B9F5A 
X-CRM114-Status: UNSURE (   5.24  )
X-CRM114-Notice: Please train this message. 

On 8/25/24 16:50, Krzysztof Kozlowski wrote:
> Use devm_add_action_or_reset() and dev_err_probe() to make the probe()
> error handling simpler around amba_release_regions() cleanup.  This
> allows to drop the remove() callback entirely.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Vladimir Zapolskiy <vz@mleia.com>
Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir

