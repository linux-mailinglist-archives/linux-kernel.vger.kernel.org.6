Return-Path: <linux-kernel+bounces-416066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDDC9D3FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93A76281128
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C38145B18;
	Wed, 20 Nov 2024 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMMcfdAE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF12137930;
	Wed, 20 Nov 2024 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732118911; cv=none; b=NzVYRdMXgoO8uurFZZROeFR9II8iqXsHsPSVc1tDAyyO26xa4FRumz0L9Sf8TMGot+FQSw6Z6V94zk2b+SWtqLlkKaHpFXlrl5lHbtuAkIDQFTPSvuuSyxDC1Y+V4TJYaSAsTQapQhtZAN0K+dc9jZ/7Dctu4BPDaK8xNmDuNTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732118911; c=relaxed/simple;
	bh=af7wGAEkQoBwlV9tG6jl7JVI6drSwMRS5CPFUjWoAJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3mxsx2jbKr1cDAgjd3Nja63S2XGPf01pX6PHWPLAE7rq/hPcrBrk7ym7Fw8TLfbX1oS0epUyHxuwZOpGf195KyyA03u97getH4LLtXjxbGd6pYYbiX+ZUmLpfS7uNfBON6om3LiTD03WfPY8xdG7the0NFttyJiVpYHt+jkaE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMMcfdAE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057AEC4CECD;
	Wed, 20 Nov 2024 16:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732118910;
	bh=af7wGAEkQoBwlV9tG6jl7JVI6drSwMRS5CPFUjWoAJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dMMcfdAEA1AbIPOrUUoPa17LGml8WouftBECc5lLQ3p6hFnzRNWxu02K0nW8ifE9t
	 Td1PiScjN9nNUyY96XmUBvA/Ia55Zv1yKjnBwMSihrmor00kZQ5k5VSTj1jBRb4vGF
	 lYs2kt7xgu4PosT0/q/Z8AjpJTjrrd9J42m3qpxurCg+Vz08O8XSP5QXAi65OBQBwD
	 KXRVRVCYaADiUHmO3psCd0o9HQVFN6OLXqoB0Mcwe1SBJBrXR6vHmPiHFPZmyYs1di
	 +lTbthGkm21d5ujTa8LZY7V8fdGa1uBKF9HId24BD5RMPsuXPRSNtYqPKFQutFTFEg
	 f+yR+wrmWA3HA==
Date: Wed, 20 Nov 2024 16:08:26 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Sung-Chi, Li" <lschyi@chromium.org>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] platform/chrome: cros_ec_charge_state: add new
 driver to control charge
Message-ID: <Zz4JeoY4R-n703bY@google.com>
References: <20241118-add_charger_state-v1-0-94997079f35a@chromium.org>
 <20241118-add_charger_state-v1-1-94997079f35a@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118-add_charger_state-v1-1-94997079f35a@chromium.org>

On Mon, Nov 18, 2024 at 05:33:46PM +0800, Sung-Chi, Li wrote:
> diff --git a/drivers/platform/chrome/cros_ec_charge_state.c b/drivers/platform/chrome/cros_ec_charge_state.c
[...]
> +#define DRV_NAME "cros-ec-charge-state"
> +#define CHARGE_TYPE_CHARGE "charge"
> +#define CHARGE_TYPE_INPUT "input"

I'm not a big fan of these kind of macros and would prefer to remove them.

> +static int
> +cros_ec_charge_state_get_current_limit(struct cros_ec_device *ec_dev,
> +				       enum charge_state_params charge_type,
> +				       uint32_t *limit)
> +{
[...]
> +	*limit = cpu_to_le32(state.get_param.value);
> +	return 0;
> +}
> +
> +static int
> +cros_ec_charge_state_set_current_limit(struct cros_ec_device *ec_dev,
> +				       enum charge_state_params charge_type,
> +				       uint32_t limit)
> +{
[...]
> +	param.set_param.value = cpu_to_le32(limit);

Looks weird to me.  Both getter and setter use cpu_to_le32()?  Should one
of them be le32_to_cpu()?

> +static int
> +cros_ec_charge_state_get_cur_state(struct thermal_cooling_device *cdev,
> +				   unsigned long *state)
> +{
> +	struct cros_ec_charge_state_data *data = cdev->devdata;
> +	uint32_t limit;
> +	int ret;
> +
> +	ret = cros_ec_charge_state_get_current_limit(data->ec_dev,
> +						     data->charge_type, &limit);
> +	if (ret) {
> +		dev_err(data->dev, "failed to get current state: %d", ret);

If something went wrong, and cros_ec_charge_state_get_current_limit() keeps
returning errors, would it somehow flood the kernel logs?

> +		return ret;
> +	}
> +
> +	*state = data->max_milliamp - limit;

Would it happen: data->max_milliamp - limit < data->min_milliamp == true?

> +static int
> +cros_ec_charge_state_register_charge_chip(struct device *dev,
> +					  struct device_node *node,
> +					  struct cros_ec_device *cros_ec)
> +{
[...]
> +
> +	if (!strcmp(type_val, CHARGE_TYPE_CHARGE)) {
> +		data->charge_type = CS_PARAM_CHG_CURRENT;
> +	} else if (!strcmp(type_val, CHARGE_TYPE_INPUT)) {
> +		data->charge_type = CS_PARAM_CHG_INPUT_CURRENT;
> +	} else {
> +		dev_err(dev, "unknown charge type: %s", type_val);
> +		return -1;

How about -EINVAL?

> +	}
> +
> +	ret = of_property_read_u32(node, "min-milliamp", &data->min_milliamp);
> +	if (ret) {
> +		dev_err(dev, "failed to get min-milliamp data: %d", ret);
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(node, "max-milliamp", &data->max_milliamp);
> +	if (ret) {
> +		dev_err(dev, "failed to get max-milliamp data: %d", ret);
> +		return ret;
> +	}

Would it happen: min-milliamp > max-milliamp == true?

> +
> +	data->ec_dev = cros_ec;
> +	data->dev = dev;
> +
> +	cdev = devm_thermal_of_cooling_device_register(
> +		dev, node, node->name, data,
> +		&cros_ec_charge_state_cooling_device_ops);
> +	if (IS_ERR_VALUE(cdev)) {

Any reasons to not use IS_ERR()?

> +static int cros_ec_charge_state_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
> +	struct cros_ec_device *cros_ec = ec_dev->ec_dev;
> +	struct device_node *child;
> +
> +	for_each_available_child_of_node(cros_ec->dev->of_node, child) {
> +		if (!of_device_is_compatible(child,
> +					     "google,cros-ec-charge-state"))
> +			continue;
> +		if (cros_ec_charge_state_register_charge_chip(dev, child,
> +							      cros_ec))
> +			continue;
> +	}

There should be a way to use the compatible string in struct mfd_cell for
matching the node.  See also [1].

[1]: https://elixir.bootlin.com/linux/v6.12/source/drivers/mfd/mfd-core.c#L184

> +
> +static const struct platform_device_id cros_ec_charge_state_id[] = {
> +	{ DRV_NAME,  0 },
                    ^

> +static struct platform_driver cros_ec_chargedev_driver = {

The whole file uses "cros_ec_charge_state_" as a prefix for all symbols.  Any
reasons to not make this consistent?

