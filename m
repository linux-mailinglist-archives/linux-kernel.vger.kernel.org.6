Return-Path: <linux-kernel+bounces-528664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38296A41A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DED81885E3C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F396D24A060;
	Mon, 24 Feb 2025 10:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuT1086/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4866E242934;
	Mon, 24 Feb 2025 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391940; cv=none; b=IGNbU3yhXR69NoiHPQ+qAZad3reAKu7mrx2kp3bTs7rYydOr79sdK+74chTGYlYY2wJiPyxZUUPpRjARhGy3rYgM9YyG854whQTpujlhbN7R5SBeCgA+Iq6HuiIilzU8sFPxkBbLjlR3SFQQ98QCTRkOWua5ybrsA1dqaji0j+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391940; c=relaxed/simple;
	bh=PCYrjtUGVCNWA2UVJ7z9lylraitHnr5rIdAHSEZtMNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HKO61pxCH8D7RMJXMy4czxqfYbO+PO2533ptRh0FFTxCPF/n6lNQ1S8aE3tq/0iEcjH+u0FfdZdYuAroBwP8ig3yV+sIYVwlxrmjrw9a2yBoo3gWuok1+fdi7qrKqVtGGISu/Bm+0KZij8HgorH6jLQY59SEluX7LCZy8sUBLEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuT1086/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E632C4CED6;
	Mon, 24 Feb 2025 10:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740391939;
	bh=PCYrjtUGVCNWA2UVJ7z9lylraitHnr5rIdAHSEZtMNk=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=nuT1086/FaATtLmemWY7kOIECVttghSCc4222D9Ldf9XVKoYAoTvqQy3s/KaSB3IY
	 81PTkl2QIEWMA6zZM6BI5P6wZfDYoF1AnzNc6SKBdP9JEwYsdeW9BGnfgPeU2TAYMl
	 mCHCT8linYBKLN8VQ6+l7EsAKaRYomEfkzZXVL2D2/wgVXYHB8r0p5Ba4367zLL3Qb
	 6gxNP4F/yPnPsjwUjcjOZ4VQsQAWdvLGCJ3nlwEq/DmgRfj8p9zNSWiQbxFq/XnPSF
	 GYSfBHYuATnubYut9uyyOqywvuJ8UMNofpuPAQMWbh5Vsu1z5174dT8BfsZ4/JmvVq
	 s0DtFT/+KuHBQ==
Message-ID: <71cf8012-3b77-43de-b8ac-54c84a97f9d3@kernel.org>
Date: Mon, 24 Feb 2025 11:12:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/3] reset: aspeed: register AST2700 reset auxiliary
 bus device
To: Ryan Chen <ryan_chen@aspeedtech.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250224095506.2047064-1-ryan_chen@aspeedtech.com>
 <20250224095506.2047064-3-ryan_chen@aspeedtech.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250224095506.2047064-3-ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/02/2025 10:55, Ryan Chen wrote:
> +
> +static void aspeed_reset_unregister_adev(void *_adev)
> +{
> +	struct auxiliary_device *adev = _adev;
> +
> +	auxiliary_device_delete(adev);
> +	auxiliary_device_uninit(adev);
> +}
> +
> +static void aspeed_reset_adev_release(struct device *dev)
> +{
> +	struct auxiliary_device *adev = to_auxiliary_dev(dev);
> +
> +	kfree(adev);
> +}
> +

Every exported function *must* have kerneldoc.

> +int aspeed_reset_controller_register(struct device *clk_dev, void __iomem *base,
> +				     const char *adev_name)
> +{
> +	struct auxiliary_device *adev;
> +	int ret;
> +
> +	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
> +	if (!adev)
> +		return -ENOMEM;
> +
> +	adev->name = adev_name;
> +	adev->dev.parent = clk_dev;
> +	adev->dev.release = aspeed_reset_adev_release;
> +	adev->id = 666u;
> +
> +	ret = auxiliary_device_init(adev);
> +	if (ret) {
> +		kfree(adev);
> +		return ret;
> +	}
> +
> +	ret = auxiliary_device_add(adev);
> +	if (ret) {
> +		auxiliary_device_uninit(adev);
> +		return ret;
> +	}
> +
> +	adev->dev.platform_data = (__force void *)base;
> +
> +	return devm_add_action_or_reset(clk_dev, aspeed_reset_unregister_adev, adev);
> +}
> +EXPORT_SYMBOL_GPL(aspeed_reset_controller_register);

No, you cannot export functions without users. There is no single user
of this, so this is not justified at all.




Best regards,
Krzysztof

