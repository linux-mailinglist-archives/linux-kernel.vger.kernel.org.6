Return-Path: <linux-kernel+bounces-311255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A87049686AC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 329C3B255CF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3039200129;
	Mon,  2 Sep 2024 11:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dSLiLwFs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U3FPl05l"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91780200119;
	Mon,  2 Sep 2024 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277842; cv=none; b=a5fAm4E/mADG6hle8/1J7Ve/ofL37XPLkRHj/0i//afE00IA4ktrHFSIV2hG29XTkcq7WXa0g3/gsf1bfe7Eh5VlamrDWLCbeFI7XGMCXPm9gwW0pp/WcJhXsKDAoAfPCA7wGj9M2xNb5gKwbNGYFdqwQlQhglESjhuaH9xoicE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277842; c=relaxed/simple;
	bh=A0k3d7wdxFo9sEFnr7CFpHwxFKgcd4wWZnqNjNuApic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WT0/jfSRyqdhhABOVW3K1uu3YhXIOOPMu4UArmrvpcS9p2BsrcEqHhI7+C57OUxMY77DlUCtkgISHOShF9Dm4CntaIzmZsCdrQGFS8GukRSPbZxrIJewr57WqDuwypFSu/OXOVCNoNDIsWgfEMBJSzjDl9AsQ+ABt3oaFDOsmaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dSLiLwFs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U3FPl05l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725277833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5LjZ1QNNFQlKaId5zo+XC1TiL4cbSpY/fOAJtKrxVLQ=;
	b=dSLiLwFslla9TZ+Ot5Ux8QrD5fBmLPqaSoSZ6zy8TwqpnOqjvZoB+ofkr42iDv0HSqoGm2
	TN14qLaheL4Dy5s7REDl7QDZFIMNMNjYIkZ4H5fmg0t8c5L2Bb7Ry+WoNsXOlONYqUYz89
	3L7k0CC+ENTDtYxCcSNpMozw+RQuH8JGjlH9HvTngvXokZ7m/gNMHyy5kHirkZBOOM1um+
	FeAadzLCuzqaaKsfTizIPSvoBJ2XrSKbPvAjJ7GoRX41DX42b4PhKIqvmdy9v2ffQYxclf
	rSHO2DuDwW8mam9tbdLT20FD9vvBqvRnbaJiwSv4UQhx2cwJAvH2l6H17G9hQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725277833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5LjZ1QNNFQlKaId5zo+XC1TiL4cbSpY/fOAJtKrxVLQ=;
	b=U3FPl05lX9YZooaXQdnK5OY/2zU879ytBLMKgLHkPUMNwg3fUzyGLMAhprffoAzflQtysH
	/Ao16Z61mCRBu3Aw==
To: Yan Zhen <yanzhen@vivo.com>, ckeepax@opensource.cirrus.com,
 rf@opensource.cirrus.com
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
 linux-kernel@vger.kernel.org, opensorce.kernel@vivo.com, Yan Zhen
 <yanzhen@vivo.com>
Subject: Re: [PATCH v3] irqchip: madera: Simplify with dev_err_probe()
In-Reply-To: <20240830084620.396417-1-yanzhen@vivo.com>
References: <20240830084620.396417-1-yanzhen@vivo.com>
Date: Mon, 02 Sep 2024 13:50:33 +0200
Message-ID: <874j6y6zqu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 30 2024 at 16:46, Yan Zhen wrote:
> Switch to use dev_err_probe() to simplify the error path and
> unify a message template.
>
> Using this helper is totally fine even if err is known to never
> be -EPROBE_DEFER.

Is fine? We don't care about fine. The question is whether it is correct
or not. And if so, then there wants to be an explanation why it is correct.

> Changes in v3:
> -Rewrite the subject as 'irqchip: madera:'.

Which is still wrong. Care to read Documentation/process/ ?

>  drivers/irqchip/irq-madera.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/irqchip/irq-madera.c b/drivers/irqchip/irq-madera.c
> index acceb6e7fa95..d5ad4466a140 100644
> --- a/drivers/irqchip/irq-madera.c
> +++ b/drivers/irqchip/irq-madera.c
> @@ -199,9 +199,8 @@ static int madera_irq_probe(struct platform_device *pdev)
>  		ret = regmap_update_bits(madera->regmap, MADERA_IRQ1_CTRL,
>  					 MADERA_IRQ_POL_MASK, 0);
>  		if (ret) {
> -			dev_err(&pdev->dev,
> -				"Failed to set IRQ polarity: %d\n", ret);
> -			return ret;
> +			return dev_err_probe(&pdev->dev, ret,
> +						"Failed to set IRQ polarity");

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#line-breaks

But that's moot as Krzysztof pointed out that this patch just picks a
random instance of the code for no reason.

Thanks,

        tglx

