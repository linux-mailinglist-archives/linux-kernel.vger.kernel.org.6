Return-Path: <linux-kernel+bounces-449072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B769F495B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B92318862B1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A4D1E9B34;
	Tue, 17 Dec 2024 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEMuXm7J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B5E1E3DC3
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734432926; cv=none; b=Kl6mI/xEHm85Kn5xz/gAOlNbj2H9H0soOtprg7y7BYIKmF35AefJq3bqIHCWqMxd1Xhv2EEE3yl6ax8UqVAnE20NIC2wJiG5r3QV2jGwK8b3USWYNAvcRQrtyTadxaJofu6C+oIqIwzTcO6/g+eQVeF3obHhFj4N5owUnFb0BLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734432926; c=relaxed/simple;
	bh=ppk1m0wfYti5pp74J8GZWTQeEYK1DO6pmOAHvWch4Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qh6kTx32WlApSjchMt/YjOxrkzlcGfIGzEtJ2jSIUdFejrzn3M0h8s9Z/d7nOf2ellEqSMGWhbMBaV5YuqQyFLMKrcSJRCdfDlM0hJIipVLIMaVj5hq3bnoXZiOW8lhnIupzzhn/0Oh8TIiItMOoNuKCui+KWJCoFKp4raBPcBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEMuXm7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8055AC4CED3;
	Tue, 17 Dec 2024 10:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734432926;
	bh=ppk1m0wfYti5pp74J8GZWTQeEYK1DO6pmOAHvWch4Fg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IEMuXm7Jg1EcQmVOpG0y9uKwKuChlHWnJRFbDaeHDWqJsOCG4MGmpDt/elW+UjTON
	 VS3Hiwg9EqU1XgNSY6H/zAUix6b5QY5HQktkQiy1WQaMU/dyQeNSWcLf/xDINU1wsI
	 A3V5XEs4qFSJlhdK1jQK7PffaVyXWthRhuJblDy9YZOwHRwS3Zj1nGq6VJgIKh+3E1
	 TK619LdeXbjmdoj99WlTDXj8GiUktOkTFN9gHfJX4rpH+mn8FV1eP4oP86GU5iyD6K
	 +OBOMDIYT+zpQ19sVfNNXLjjJ3pYO2t0QTdIbc5VWbN/avSBLHGadJQXpNvuG/+6lM
	 G9SzbXw9N+/+g==
Message-ID: <da0122c8-20b9-4b8c-8de0-ed6d40aaa620@kernel.org>
Date: Tue, 17 Dec 2024 11:55:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spmi: hisi-spmi-controller: manage the OF node reference
 in device initialization and cleanup
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, mchehab+huawei@kernel.org,
 sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20241217042646.1866760-1-joe@pf.is.s.u-tokyo.ac.jp>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241217042646.1866760-1-joe@pf.is.s.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/12/2024 05:26, Joe Hattori wrote:
> spmi_controller_probe() increments the refcount of an OF node, but does
> not release it. Instead, call of_node_get() in spmi_controller_alloc()
> and release it in spmi_ctrl_release() to avoid the reference leak.
> 
> This bug was found by an experimental static analysis tool that I am
> developing.
> 
> Fixes: e562cf3aea3e ("spmi: hisi-spmi-controller: move driver from staging")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
>  drivers/spmi/hisi-spmi-controller.c | 1 -
>  drivers/spmi/spmi.c                 | 3 ++-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spmi/hisi-spmi-controller.c b/drivers/spmi/hisi-spmi-controller.c
> index 3cafdf22c909..dd21c5d1ca83 100644
> --- a/drivers/spmi/hisi-spmi-controller.c
> +++ b/drivers/spmi/hisi-spmi-controller.c
> @@ -301,7 +301,6 @@ static int spmi_controller_probe(struct platform_device *pdev)
>  	spin_lock_init(&spmi_controller->lock);
>  
>  	ctrl->dev.parent = pdev->dev.parent;
> -	ctrl->dev.of_node = of_node_get(pdev->dev.of_node);
>  
>  	/* Callbacks */
>  	ctrl->read_cmd = spmi_read_cmd;
> diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
> index fb0101da1485..e662a7a78df2 100644
> --- a/drivers/spmi/spmi.c
> +++ b/drivers/spmi/spmi.c
> @@ -36,6 +36,7 @@ static void spmi_ctrl_release(struct device *dev)
>  	struct spmi_controller *ctrl = to_spmi_controller(dev);
>  
>  	ida_free(&ctrl_ida, ctrl->nr);
> +	of_node_put(dev->of_node);


Aren't other drivers like PMIC arbiter overwriting this with different
value, thus basically you are dropping reference which was not obtained
and causing actual use-after-free?


Best regards,
Krzysztof

