Return-Path: <linux-kernel+bounces-203228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C98C8FD815
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCD16B231FF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB0415F3F9;
	Wed,  5 Jun 2024 21:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+w0OdEU"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1620B4965B;
	Wed,  5 Jun 2024 21:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621419; cv=none; b=dkr1ZicjD56KcmxBt/nZ2/ueZjkOD3ixpiK3EXE1cDnzuGwW2CIEMzQRrMXsoEsQ3+st9Z44j/dzlS60E5ZExyBo7x+XfGUA+ftp8vTpmmvryAfLMoO4lc8bTkLnWrhPaznz8krlwu3tU4LTHCUBqDR8/gXhzHhqNXfucdDn1PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621419; c=relaxed/simple;
	bh=eh9IzC/sXudftroa0oNPCl+CeaVwJW9OIwLv2VcI54Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfxTygizntlryoDzjAWK8vX1d8cY8KmIoguirSBm/DKWw3V+d6qk8NjeS6bEB3ymJ6b6sN7PYPqRiQRF0u6UymImzWARqp0WTef3k/bNujlFlU8m+wiJS+eUo2rKk8+Ij5vJeV0gsuj6BwUWMfquCAax0Y1NcJoPO5R+ovTozBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+w0OdEU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42158db02c3so3589385e9.2;
        Wed, 05 Jun 2024 14:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717621416; x=1718226216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wxkQybmLe5sPp9htKJDI8bCr/w4I0AK0t4E3wZxsO9s=;
        b=T+w0OdEUmtYDHIOI9sZ6DFb8xYQp6NA/zgQidfkWMsyYvDmyUQtK/9oHyMNWnS7Dcz
         S7PYlZP73N3AgIg15FW1VheaoqiZlQDBLT8MxwfcbRNDl1yZFfK0z/fHM7bcNXLP5zwx
         f33sReIWd20rdDAfwTCJJ/bZ674VtaKbPF+JVaGaGgIw6/BeQa8C2L2RhMLJVRRbuMgZ
         ysNp5jrt7uXtPOg7Uxl2kMK5fHdbzKY65af7AiQZ9VxX9HoNfepXK12P/CI492GFudk7
         v1U72/0vzyt2ubA2PKZWJBX9qdaeNAatDoxjA9kFepkY47GJd1Dy6Lg1UQfTvc6Nt2Go
         DuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717621416; x=1718226216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxkQybmLe5sPp9htKJDI8bCr/w4I0AK0t4E3wZxsO9s=;
        b=sA61ZDYzCFSvXAXirY+0t0V+N6bW3e4ubfy8UVLzORnnAZxbsMa7Zr39xQcZaiH0Ju
         aCmPHWHS5c2gy2NsAjg9P5cuhoCOTctDu5AxLunu7Hi5hd/vdMxTEcfVIJ7IkGOtz7G3
         b7C0sLZ5Zo27wyvK3SqvstKAcSe+lpq+y2q5JX4Mn4xVznLkhvwyTBbdiavdA2fVBVNn
         /8ZrPZUTz67zgvs0yACSn9KUbvPwR25yZ/L4BewtJeoTfpmDnYA/I6Z/sryAoEfjTeEV
         9s6/GcuaS365IfSGMIvRQzIu7luJhwhTCFv4siQanwdCUrLkow2wU+UlUnPloG/exVIa
         c6lA==
X-Forwarded-Encrypted: i=1; AJvYcCX6sh5BsO30nsOO+6+h2Epys1/yfSh0HQpbtObfq/UCIRrRqkDQMbtaWxDr7qOumd1L7ZIcc+9TBPRBEVfwwWj0tN8IGfMp8at6njd+2Uxgg36BEtaPJm+3WM0dF+2kuFugwpYQjywBnda5UPhc3L0M3R08pvyG3dmWaXkfWfSOHbvh7Q==
X-Gm-Message-State: AOJu0Ywh/fTQ4oPS/5gXDQgKgtqrtE0xKBkgtHGIU1XWXbvvS6KI0xSL
	j1ea5pi7lmuZCMJIa6PPcO750DM3p1Oxaepwd8sN7lwVFV53zlD/6wHL
X-Google-Smtp-Source: AGHT+IEQ5Bvq496WQdI6NCNSKRLJfGNuhXeduOQUjAa/vxuh86+qvv8BXGs75zaVxP88iejgFvqqSw==
X-Received: by 2002:a05:600c:3550:b0:41b:fc3a:f1ef with SMTP id 5b1f17b1804b1-42156339013mr28592605e9.33.1717621416317;
        Wed, 05 Jun 2024 14:03:36 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:5211:58fe:dfef:c48c? ([2a02:810b:f40:4600:5211:58fe:dfef:c48c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215810242fsm33579345e9.12.2024.06.05.14.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 14:03:35 -0700 (PDT)
Message-ID: <9da22443-b5c3-4fbc-8cb0-d6bebab55da4@gmail.com>
Date: Wed, 5 Jun 2024 23:03:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] clk: rockchip: rk3128: Drop CLK_NR_CLKS usage
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20240605205209.232005-1-knaerzche@gmail.com>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <20240605205209.232005-1-knaerzche@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
sorry for the noise - not sure what went wrong here.
Just resend v2:
https://lore.kernel.org/all/20240605210049.232284-1-knaerzche@gmail.com/

Alex
Am 05.06.24 um 22:51 schrieb Alex Bee:
> Similar to
> commit 2dc66a5ab2c6 ("clk: rockchip: rk3588: fix CLK_NR_CLKS usage")
> this drops CLK_NR_CLKS usage from the clock driver and instead uses the
> rockchip_clk_find_max_clk_id helper which was introduced for that purpose.
> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
>   drivers/clk/rockchip/clk-rk3128.c | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3128.c b/drivers/clk/rockchip/clk-rk3128.c
> index d076b7971f33..40e0e4556d59 100644
> --- a/drivers/clk/rockchip/clk-rk3128.c
> +++ b/drivers/clk/rockchip/clk-rk3128.c
> @@ -569,18 +569,22 @@ static const char *const rk3128_critical_clocks[] __initconst = {
>   	"sclk_timer5",
>   };
>   
> -static struct rockchip_clk_provider *__init rk3128_common_clk_init(struct device_node *np)
> +static struct rockchip_clk_provider *__init rk3128_common_clk_init(struct device_node *np,
> +								   unsigned long soc_nr_clks)
>   {
>   	struct rockchip_clk_provider *ctx;
> +	unsigned long common_nr_clks;
>   	void __iomem *reg_base;
>   
> +	common_nr_clks = rockchip_clk_find_max_clk_id(common_clk_branches,
> +						      ARRAY_SIZE(common_clk_branches)) + 1;
>   	reg_base = of_iomap(np, 0);
>   	if (!reg_base) {
>   		pr_err("%s: could not map cru region\n", __func__);
>   		return ERR_PTR(-ENOMEM);
>   	}
>   
> -	ctx = rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
> +	ctx = rockchip_clk_init(np, reg_base, max(common_nr_clks, soc_nr_clks));
>   	if (IS_ERR(ctx)) {
>   		pr_err("%s: rockchip clk init failed\n", __func__);
>   		iounmap(reg_base);
> @@ -609,8 +613,12 @@ static struct rockchip_clk_provider *__init rk3128_common_clk_init(struct device
>   static void __init rk3126_clk_init(struct device_node *np)
>   {
>   	struct rockchip_clk_provider *ctx;
> +	unsigned long soc_nr_clks;
>   
> -	ctx = rk3128_common_clk_init(np);
> +	soc_nr_clks = rockchip_clk_find_max_clk_id(rk3126_clk_branches,
> +						   ARRAY_SIZE(rk3126_clk_branches)) + 1;
> +
> +	ctx = rk3128_common_clk_init(np, soc_nr_clks);
>   	if (IS_ERR(ctx))
>   		return;
>   
> @@ -627,8 +635,12 @@ CLK_OF_DECLARE(rk3126_cru, "rockchip,rk3126-cru", rk3126_clk_init);
>   static void __init rk3128_clk_init(struct device_node *np)
>   {
>   	struct rockchip_clk_provider *ctx;
> +	unsigned long soc_nr_clks;
> +
> +	soc_nr_clks = rockchip_clk_find_max_clk_id(rk3128_clk_branches,
> +						   ARRAY_SIZE(rk3128_clk_branches)) + 1;
>   
> -	ctx = rk3128_common_clk_init(np);
> +	ctx = rk3128_common_clk_init(np, soc_nr_clks);
>   	if (IS_ERR(ctx))
>   		return;
>   


