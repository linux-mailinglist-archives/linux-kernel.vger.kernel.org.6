Return-Path: <linux-kernel+bounces-264550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CC993E4FD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 13:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6601C209D9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 11:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9371043AD7;
	Sun, 28 Jul 2024 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFAGVz9Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD21C4205D
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 11:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722167711; cv=none; b=mjBP2nDUFF3CxUMJqm7Tf+J3mYkUiI3OQr3IXwa9476/1+oycNWA4WpR1IJfEbDm60JU6PF8ejEvTE3D1dRrgYAby+Rl6yX1eBnAcrxzFgARVO3oWe6AisermfiEfEGQXnLd9rQNAInnLBH4H3S9v4UJQbr9b5s1iVbOggYdpIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722167711; c=relaxed/simple;
	bh=IBz57s74vuSUyAAr3ijmdcIIYCDfWCz8eKghNS3oOYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UjTy1CNb+5ANJLsvMCB9Vfs5fGE1BLCdb4mlToBhfR58q3muPPG0cdR9L3WTQSEgfxVSv7EPeHKLpm9dG/duH/DgTFDD511db5hVJitOUGgtt70CsQREue+qxFGsF5X1R2XS143YggCIaC73r6cYr3i7kn+eOo+b43HBcA2Asxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFAGVz9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D871EC116B1;
	Sun, 28 Jul 2024 11:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722167711;
	bh=IBz57s74vuSUyAAr3ijmdcIIYCDfWCz8eKghNS3oOYE=;
	h=Date:Subject:To:List-Id:Cc:References:From:In-Reply-To:From;
	b=CFAGVz9Zcx4aV+t6eliOFJFzNfhWdqF6v9jQ8c03li3ZwmUKkMBXkF7E3wbh79q46
	 PxfwUXyA9ZMBAMMCmpw+vflv+y40Gnshz8/eGsG7JO+vTUyv3a1DXVM9EHg3WwsLcC
	 lhyG+vB7NQpbAfO1wFPsZQGm56BpgOKpQ8e0YOk7fZJ6PqiFUZuVZKke0bc1U1JyTs
	 pquBNX3H2W0rm/YhiMO5KP9K9bxexCWFAuvg1tlXMCvHXa2BxZEeP81qNsqprPpyYM
	 wWA49uvZpqSSGw7igAjIGxYZ5eCdU9EDf1fIJ1scnn1Qt/VklGCCddfXndv9F+vk7T
	 DBxHq5D0LjtDA==
Message-ID: <91308a58-f70c-4b28-95e5-d64a1f12f252@kernel.org>
Date: Sun, 28 Jul 2024 13:55:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] soc: hisilicon: kunpeng_hccs: support low power
 feature for specified HCCS
To: Huisong Li <lihuisong@huawei.com>, xuwei5@hisilicon.com
Cc: linux-kernel@vger.kernel.org, soc@kernel.org,
 linux-arm-kernel@lists.infradead.org, Jonathan.Cameron@Huawei.com,
 liuyonglong@huawei.com
References: <20240718071134.31155-1-lihuisong@huawei.com>
 <20240718071134.31155-5-lihuisong@huawei.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJgPO8PBQkUX63hAAoJEBuTQ307
 QWKbBn8P+QFxwl7pDsAKR1InemMAmuykCHl+XgC0LDqrsWhAH5TYeTVXGSyDsuZjHvj+FRP+
 gZaEIYSw2Yf0e91U9HXo3RYhEwSmxUQ4Fjhc9qAwGKVPQf6YuQ5yy6pzI8brcKmHHOGrB3tP
 /MODPt81M1zpograAC2WTDzkICfHKj8LpXp45PylD99J9q0Y+gb04CG5/wXs+1hJy/dz0tYy
 iua4nCuSRbxnSHKBS5vvjosWWjWQXsRKd+zzXp6kfRHHpzJkhRwF6ArXi4XnQ+REnoTfM5Fk
 VmVmSQ3yFKKePEzoIriT1b2sXO0g5QXOAvFqB65LZjXG9jGJoVG6ZJrUV1MVK8vamKoVbUEe
 0NlLl/tX96HLowHHoKhxEsbFzGzKiFLh7hyboTpy2whdonkDxpnv/H8wE9M3VW/fPgnL2nPe
 xaBLqyHxy9hA9JrZvxg3IQ61x7rtBWBUQPmEaK0azW+l3ysiNpBhISkZrsW3ZUdknWu87nh6
 eTB7mR7xBcVxnomxWwJI4B0wuMwCPdgbV6YDUKCuSgRMUEiVry10xd9KLypR9Vfyn1AhROrq
 AubRPVeJBf9zR5UW1trJNfwVt3XmbHX50HCcHdEdCKiT9O+FiEcahIaWh9lihvO0ci0TtVGZ
 MCEtaCE80Q3Ma9RdHYB3uVF930jwquplFLNF+IBCn5JRzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmA872oFCRRflLYACgkQG5NDfTtBYpvScw/9GrqBrVLuJoJ52qBBKUBDo4E+5fU1bjt0
 Gv0nh/hNJuecuRY6aemU6HOPNc2t8QHMSvwbSF+Vp9ZkOvrM36yUOufctoqON+wXrliEY0J4
 ksR89ZILRRAold9Mh0YDqEJc1HmuxYLJ7lnbLYH1oui8bLbMBM8S2Uo9RKqV2GROLi44enVt
 vdrDvo+CxKj2K+d4cleCNiz5qbTxPUW/cgkwG0lJc4I4sso7l4XMDKn95c7JtNsuzqKvhEVS
 oic5by3fbUnuI0cemeizF4QdtX2uQxrP7RwHFBd+YUia7zCcz0//rv6FZmAxWZGy5arNl6Vm
 lQqNo7/Poh8WWfRS+xegBxc6hBXahpyUKphAKYkah+m+I0QToCfnGKnPqyYIMDEHCS/RfqA5
 t8F+O56+oyLBAeWX7XcmyM6TGeVfb+OZVMJnZzK0s2VYAuI0Rl87FBFYgULdgqKV7R7WHzwD
 uZwJCLykjad45hsWcOGk3OcaAGQS6NDlfhM6O9aYNwGL6tGt/6BkRikNOs7VDEa4/HlbaSJo
 7FgndGw1kWmkeL6oQh7wBvYll2buKod4qYntmNKEicoHGU+x91Gcan8mCoqhJkbqrL7+nXG2
 5Q/GS5M9RFWS+nYyJh+c3OcfKqVcZQNANItt7+ULzdNJuhvTRRdC3g9hmCEuNSr+CLMdnRBY fv0=
In-Reply-To: <20240718071134.31155-5-lihuisong@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/07/2024 09:11, Huisong Li wrote:
> This patch add the low power feature for specified HCCS by increasing

Please do not use "This commit/patch/change", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> and decrasing the lane number of these HCCS ports on platform.
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/soc/hisilicon/Kconfig        |   7 +-
>  drivers/soc/hisilicon/kunpeng_hccs.c | 377 ++++++++++++++++++++++++++-
>  drivers/soc/hisilicon/kunpeng_hccs.h |  14 +
>  3 files changed, 394 insertions(+), 4 deletions(-)

...


> +static struct kobj_attribute pm_types_attr =
> +		__ATTR(support_pm_types, 0444, support_pm_types_show, NULL);
>  
>  static ssize_t used_types_show(struct kobject *kobj,
>  			       struct kobj_attribute *attr, char *buf)
> @@ -1213,11 +1551,46 @@ static struct kobj_attribute used_types_attr =
>  static void hccs_remove_misc_sysfs(struct hccs_dev *hdev)
>  {
>  	sysfs_remove_file(&hdev->dev->kobj, &used_types_attr.attr);
> +	sysfs_remove_file(&hdev->dev->kobj, &pm_types_attr.attr);
> +
> +	if (!(hdev->caps & HCCS_CAPS_HCCS_V2_PM))
> +		return;
> +
> +	sysfs_remove_file(&hdev->dev->kobj, &dec_lane_attr.attr);
> +	sysfs_remove_file(&hdev->dev->kobj, &inc_lane_attr.attr);
>  }
>  
>  static int hccs_add_misc_sysfs(struct hccs_dev *hdev)
>  {
> -	return sysfs_create_file(&hdev->dev->kobj, &used_types_attr.attr);
> +	int ret;
> +
> +	ret = sysfs_create_file(&hdev->dev->kobj, &used_types_attr.attr);
> +	if (ret)
> +		return ret;
> +
> +	ret = sysfs_create_file(&hdev->dev->kobj, &pm_types_attr.attr);

Where is the ABI documentation?

Best regards,
Krzysztof


