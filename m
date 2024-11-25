Return-Path: <linux-kernel+bounces-420944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018519D849E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88807168DDF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CC41993BA;
	Mon, 25 Nov 2024 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s6gdHiif"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DED191F7E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534694; cv=none; b=UKi7Y2jlb928vDy3u5IkbWRoL8JHrdYBwoMrbJz+7zptID7Y+VTkKD7lqwQODzitOhbLLMjOkGrOEswQ9ny9Pivd0fV5XmrkhMCL0N7MXAQnUSBsZ+QQuzeF7DNBln26v+cwHqcpXd3r/NQmvsh+L/6mCF+tpeaiNn04jway2vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534694; c=relaxed/simple;
	bh=mwnwMPsyl+SR2TJEFI1GIutXd7qNeetlprHnd/ODHQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=luQmPzDRRR3F3nKnk713fHs4Sob+EWQ3hWI42hd+f0NOJiVIWDHfKI/q8QTi4V49PuBhu03KobPh0SgOR8AMHIUiIre26bGsUUA7BI06IliDESmhXrsZCw+nA9WZtSa5Ip5H0nimvrbq0X2PsC9a13tyePFwVfbFE5rZIB4VVNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s6gdHiif; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38242100504so129523f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 03:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732534690; x=1733139490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Tat/NKK070c3qC2tUrKRZht2FUvVoXySm4EDmfAlo2A=;
        b=s6gdHiifFCwR/s3Q6n9tZtQ9vHXHSkircai4xa55Wy+W18iAF6Ngs83GVb6s4GOMNL
         hTJCXKAy+9N9BYtD44xsCHZW5tbjczDSaUak8m42MaSWmchPUfRuReeosl19OBnH1TPB
         vowbARKJaSv0WBP3e7zT0ZjTYJy0R/q1PtL2nki4vrFVCBrey4JEOJ5i7badLyAB88bu
         kdu9vj2i0oHv4jh02HQ7f9XAJLYeXCITrlO+jv8HBjkpKtqlOIfMTczeRWZGF4CIkW68
         iFGjlpuBHxXrYarbr6Ft6sh23b6XCpANYENc3Mjvm3P8FgTrmYxvxrB5QhVPVTLkIJ51
         q2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732534690; x=1733139490;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tat/NKK070c3qC2tUrKRZht2FUvVoXySm4EDmfAlo2A=;
        b=svOdbM3uPZanr2Q4qbp0a6RbL3qpe6LlFwMWSba+RFFo7Y5Pa8VSPWatP51DX15egR
         AaxFKOjkXA352wYObhETodF1Nfj58tYIT/h4BW5bCIaLjQOixEgsLBmWeCfoxEtw8NQp
         r4mwGZ1Ww5fZw6LYfVuCej3ld4y+5kUVvpa3C1Ts5C0PPN4873eWgF5tNoHLT/7HbwTn
         NjaIWLF6RekvOWxj1RBzIbBAbPFQfIq8zQEq+gUVWMGS/GigFT21BVgIlCS1q7rPlLBZ
         uMoo+oSwx4yBL/7JlDNb0fLzDpg+l2wGH2tg5D96D2O4ZHNaW5wHpIuPAnoVI5y89jR9
         wetw==
X-Forwarded-Encrypted: i=1; AJvYcCUQzkaJkhUqqM1h621UQd0RS2ilF3T4F5tpSFnd8/AvNx2Ms5op5/ca2r3UF3cpEsmrOMMO1ZKOI1Cv+Ok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2j7k2f/svufqZMi57xFokaxtP6cKTRyNllIT9+mTWps9P79P4
	DtvhRecGLVlIdCuxzpLZGm3ylk7fM5wByspycCfNcjdXTynGdp7Qjxq3NkwSYOM=
X-Gm-Gg: ASbGncuVEBr5gsW2FQoS+y6qXPDE/D4qjlGsJeZx3dRmtGf/CwqwnA6Wo8loK8hZ8fM
	LkSFD9jeBrCE/dO9iiHAwTDWj/Rp/kP1uEdnBatB1IXxBEtBXgU6VY1BqT1mnWZSFjZuCyDzKUY
	/fNe7+irgpqZ7ioLyBo9naCclXF041mv2KFqB7i1xL0tqkjNQm1zlVVFTodOd3bn15KY1cGaqeD
	kK6vDD36kUlKhidOt39Aro+c27HmKUsmNNZaXfdKfttgi0q8ERZBrR+fkDw5YqDJSAIKw==
X-Google-Smtp-Source: AGHT+IGUuX3DsYKmr/xRhAnzo44NQ2k0mO5CfY3Chxq9GT1NIftKZaQz77/Whg+N0TTRIxfXnPGhiw==
X-Received: by 2002:a05:6000:1f81:b0:382:5206:8b7a with SMTP id ffacd0b85a97d-38260be5288mr4213583f8f.13.1732534690242;
        Mon, 25 Nov 2024 03:38:10 -0800 (PST)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb537dfsm10107284f8f.63.2024.11.25.03.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 03:38:09 -0800 (PST)
Message-ID: <c97c05cf-9cf2-40e7-8f50-2f438721c394@linaro.org>
Date: Mon, 25 Nov 2024 12:38:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] of: Add Google Juniper to excluded default cells list
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Chen-Yu Tsai
 <wenst@chromium.org>, Conor Dooley <conor@kernel.org>
References: <20241125113151.107812-1-krzysztof.kozlowski@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20241125113151.107812-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/11/2024 12:31, Krzysztof Kozlowski wrote:
> Google Juniper platforms have a very old bootloader which populates
> /firmware node without proper address/size-cells leading to warnings:
> 
>   Missing '#address-cells' in /firmware
>   WARNING: CPU: 0 PID: 1 at drivers/of/base.c:106 of_bus_n_addr_cells+0x90/0xf0
>   Modules linked in:
>   CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0 #1 933ab9971ff4d5dc58cb378a96f64c7f72e3454d
>   Hardware name: Google juniper sku16 board (DT)
>   ...
>   Missing '#size-cells' in /firmware
>   WARNING: CPU: 0 PID: 1 at drivers/of/base.c:133 of_bus_n_size_cells+0x90/0xf0
>   Modules linked in:
>   CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.12.0 #1 933ab9971ff4d5dc58cb378a96f64c7f72e3454d
>   Tainted: [W]=WARN
>   Hardware name: Google juniper sku16 board (DT)
> 
> The platform won't receive updated bootloader/firmware so add it to
> excluded platform list to silence the warning.
> 
> Reported-by: Sasha Levin <sashal@kernel.org>
> Closes: https://lore.kernel.org/all/Z0NUdoG17EwuCigT@sashalap/
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Chen-Yu Tsai <wenst@chromium.org>
> Cc: Conor Dooley <conor@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/of/base.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index a8b0c42bdc8e..13f0b2877ee0 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -56,6 +56,16 @@ DEFINE_MUTEX(of_mutex);
>   */
>  DEFINE_RAW_SPINLOCK(devtree_lock);
>  
> +/*
> + * List of machines running old firmware without explicit #address-cells and
> + * #size-cells values for parent nodes, which are most likely not going get any
> + * update.
> + */
> +static const char * const excluded_default_cells_compats[] = {
> +	"google,juniper",
> +	NULL
> +};
> +
>  bool of_node_name_eq(const struct device_node *np, const char *name)
>  {
>  	const char *node_name;
> @@ -91,6 +101,17 @@ static bool __of_node_is_type(const struct device_node *np, const char *type)
>  	IS_ENABLED(CONFIG_SPARC) \
>  )
>  
> +static bool excluded_default_cells_machines(void)
> +{
> +	/* Do not repeat the machine checks for every bus */
> +	static int excluded_machine = -1;
> +
> +	if (excluded_machine < 0)
> +		excluded_machine = of_machine_compatible_match(excluded_default_cells_compats);
> +
> +	return !!excluded_machine;
> +}
> +
>  int of_bus_n_addr_cells(struct device_node *np)
>  {
>  	u32 cells;
> @@ -103,7 +124,7 @@ int of_bus_n_addr_cells(struct device_node *np)
>  		 * is deprecated. Any platforms which hit this warning should
>  		 * be added to the excluded list.
>  		 */
> -		WARN_ONCE(!EXCLUDED_DEFAULT_CELLS_PLATFORMS,
> +		WARN_ONCE(!EXCLUDED_DEFAULT_CELLS_PLATFORMS && !excluded_default_cells_machines(),
>  			  "Missing '#address-cells' in %pOF\n", np);
>  	}
>  	return OF_ROOT_NODE_ADDR_CELLS_DEFAULT;
> @@ -125,12 +146,13 @@ int of_bus_n_size_cells(struct device_node *np)
>  	for (; np; np = np->parent) {
>  		if (!of_property_read_u32(np, "#size-cells", &cells))
>  			return cells;
> +


This was not intentional, I'll fix it in v2.

Obviously this code is not really SMP aware, but even with store tearing
I don't think it will be issue. Worst case the
of_machine_compatible_match() will be called more than one, which is not
fatal and might not justify atomics or locks.

Best regards,
Krzysztof

