Return-Path: <linux-kernel+bounces-415634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 914A89D396D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4507B22B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C3219DF4F;
	Wed, 20 Nov 2024 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="S0MgJUCW"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B453A199FB2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732100719; cv=none; b=YfPHfuq4RSyhIf1g9XZyTWRN5EocK8A+6VjvHeYv7YhGUpP7tQvbhpjU5eCTcGlrRUQv+a+My7LEt2QtC9zCOqeTw5WNXiU3JB/s2wON1sGCZpRMtAr5yCHP+jthRGUMSGrKkbNKky3K6izgXZgJRYBwWLGfbknwo2e5C1qd40o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732100719; c=relaxed/simple;
	bh=JhH1/NnOJ4PH6HsXEHH84RX8P7/XXd2RwVyColeRg2s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bPs/ir0uiTru5PJ0ZSpM8BJf1SqfubvhbUMBalxft7bouCj/ulY0i0FnNHHqmKeKEP2tTE/d1eB4mIbUBXHKbMM5zo2hqe6+YOKAaU/BcbWfiNRynrO1t/Hf+TTPB0AhRxr2rQEzuQ6DZHNgBzfkSUo14VCabcySAOA0IPoC6QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=S0MgJUCW; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 75BCD40004;
	Wed, 20 Nov 2024 11:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732100709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHuBRMLIL29GAZ5LZO3x3+zO6QGTv1rbdszqFlYCwMw=;
	b=S0MgJUCWK/hcEdorN+Ily5SoZbyEWyWj+oErjdHBG8ap9hv9H0fe6+A4QCEjVFwA8haEnB
	C9et6y7PU2jtkrQ4DPutuCVYwdmGoeyJ87eO4gEGivzVzdhGNBL+QwusqPO10pBJqTK3MW
	6/0ePlZAV1aVusLl0qQVHHIUdNBF0OS+Eadm2tzsIfeuIky6jlhBTYMvRf0jTYbaaG0XMt
	AHje/ZS2DFjVMT0aT7ViqJKwotLV6YJxiG5kl9ggWU2Wsmk+vhK/v/2HAjvmTWvsn0Os59
	phsx0GsOJYe74r1KoDnsl6nR+IXOY4vecAqKUFds2OwXpO9j5MQlTNjkbn5KHw==
Date: Wed, 20 Nov 2024 12:05:06 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: qiang.zhao@nxp.com, christophe.leroy@csgroup.eu,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dan.carpenter@linaro.org, xiaopeitux@foxmail.com
Subject: Re: [PATCH] soc: fsl: cpm1: qmc: Fix qmc_probe() warn missing error
 code ret
Message-ID: <20241120120506.077d3388@bootlin.com>
In-Reply-To: <82d8c18da160b9e0a73c5c5e2eb25ad2831cc6f9.1732095360.git.xiaopei01@kylinos.cn>
References: <bac2dc94-1bf3-4dcf-b776-cd78ef992d28@suswa.mountain>
	<82d8c18da160b9e0a73c5c5e2eb25ad2831cc6f9.1732095360.git.xiaopei01@kylinos.cn>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Pei,

On Wed, 20 Nov 2024 17:38:20 +0800
Pei Xiao <xiaopei01@kylinos.cn> wrote:

> platform_get_irq() may failed,but ret still equals to 0,
> will cacuse qmc_probe() return 0 but fail.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202411051350.KNy6ZIWA-lkp@intel.com/
> Fixes: 3178d58e0b97 ("soc: fsl: cpm1: Add support for QMC")
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/soc/fsl/qe/qmc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
> index 19cc581b06d0..a78768cd6007 100644
> --- a/drivers/soc/fsl/qe/qmc.c
> +++ b/drivers/soc/fsl/qe/qmc.c
> @@ -2004,8 +2004,10 @@ static int qmc_probe(struct platform_device *pdev)
>  
>  	/* Set the irq handler */
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0)
> +	if (irq < 0) {
> +		ret = -EINVAL;
>  		goto err_exit_xcc;
> +	}
>  	ret = devm_request_irq(qmc->dev, irq, qmc_irq_handler, 0, "qmc", qmc);
>  	if (ret < 0)
>  		goto err_exit_xcc;

I already send a fix:
https://lore.kernel.org/all/20241105145623.401528-1-herve.codina@bootlin.com/

And it is available in the following PR done by Christophe:
https://lore.kernel.org/all/c3c4961b-fe2a-4fcc-a7a1-f8b5352e09a2@csgroup.eu/

Best regards,
Hervé

