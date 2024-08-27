Return-Path: <linux-kernel+bounces-302795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE9496036E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 353A8283FC3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB8E156968;
	Tue, 27 Aug 2024 07:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a29+nMqA"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24801153BF6
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744462; cv=none; b=jdro0SyS2A4ca1VpJHNbqFDf52l64h9gGq6SjdzapqTP2oF/cY6NZUL06IeAFKrPucUVIMFuOv0wGw9obxscNYD9JYIOn+zJpjcTMwE3hsnwxy0y9RcI9qv3cKWefsRhJS/eFw1WlarAuHCY8FHlfNMSTwo5BAjdDubFInbYcF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744462; c=relaxed/simple;
	bh=AnPdqd2Hfx4ElN5VkKkmGRRQQsvSkz+4brV0CSzAjpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJmGNvf5qJCW06kecTwc3/FlXfJgMgjY3g87sDSCNzi+R7ih0mDO+pQGgtva0joS9ni4v7Z4ytzmezgC9xxGQs+DdI9n+u8DF91VlUNlyPyTCA31R44cvOqHitLl3aAPiN5pvEMe4DB1+n6aj7Ss9FxsPEzKGxYW1KBG5sCAfs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a29+nMqA; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724744451; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VZ3DvCoP3ydklao5dHWzdTRgPW1Qj3mQTKuX1SzGhOA=;
	b=a29+nMqA5ZjRR1b1xWRABUOH4xyJzKq647U0WlsAtLKf71/K4zwWOEiMOQSDi0Tadtr5eSYGVDwsInVaglR49vQ9gMmZyeZ8250enH7poyFMcDlnXhvahL5Pe8LV3/9SMfPR+4dsEvdYNVVGgV56Gg54uFUvQxM0ZxKtit2b1+o=
Received: from 30.97.56.57(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WDlpgTh_1724744449)
          by smtp.aliyun-inc.com;
          Tue, 27 Aug 2024 15:40:50 +0800
Message-ID: <f62f2d27-e40e-4a72-a160-02f6a8fc1b98@linux.alibaba.com>
Date: Tue, 27 Aug 2024 15:40:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mailbox: sprd: Use devm_clk_get_enabled() helpers
To: Huan Yang <link@vivo.com>, Jassi Brar <jassisinghbrar@gmail.com>,
 Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20240822015956.468945-1-link@vivo.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240822015956.468945-1-link@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/22 09:59, Huan Yang wrote:
> The devm_clk_get_enabled() helpers:
>       - call devm_clk_get()
>       - call clk_prepare_enable() and register what is needed in order to
>        call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the calls to clk_disable_unprepare().
> 
> Due to clk only used in probe, not in suspend\resume, this pointer can
> remove from sprd_mbox_priv to save a little memory.
> 
> Signed-off-by: Huan Yang <link@vivo.com>
> Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
> v2 -> v3: remove unneccessary suggested-by, add v2 marked reviewed tag
> v1 -> v2: remove clk pointer from sprd_mbox_priv
> 
>   drivers/mailbox/sprd-mailbox.c | 25 ++++---------------------
>   1 file changed, 4 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/mailbox/sprd-mailbox.c b/drivers/mailbox/sprd-mailbox.c
> index 9ae57de77d4d..ee8539dfcef5 100644
> --- a/drivers/mailbox/sprd-mailbox.c
> +++ b/drivers/mailbox/sprd-mailbox.c
> @@ -62,7 +62,6 @@ struct sprd_mbox_priv {
>   	void __iomem		*outbox_base;
>   	/*  Base register address for supplementary outbox */
>   	void __iomem		*supp_base;
> -	struct clk		*clk;
>   	u32			outbox_fifo_depth;
>   
>   	struct mutex		lock;
> @@ -291,19 +290,13 @@ static const struct mbox_chan_ops sprd_mbox_ops = {
>   	.shutdown	= sprd_mbox_shutdown,
>   };
>   
> -static void sprd_mbox_disable(void *data)
> -{
> -	struct sprd_mbox_priv *priv = data;
> -
> -	clk_disable_unprepare(priv->clk);
> -}
> -
>   static int sprd_mbox_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct sprd_mbox_priv *priv;
>   	int ret, inbox_irq, outbox_irq, supp_irq;
>   	unsigned long id, supp;
> +	struct clk *clk;
>   
>   	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>   	if (!priv)
> @@ -331,20 +324,10 @@ static int sprd_mbox_probe(struct platform_device *pdev)
>   	if (IS_ERR(priv->outbox_base))
>   		return PTR_ERR(priv->outbox_base);
>   
> -	priv->clk = devm_clk_get(dev, "enable");
> -	if (IS_ERR(priv->clk)) {
> +	clk = devm_clk_get_enabled(dev, "enable");
> +	if (IS_ERR(clk)) {
>   		dev_err(dev, "failed to get mailbox clock\n");
> -		return PTR_ERR(priv->clk);
> -	}
> -
> -	ret = clk_prepare_enable(priv->clk);
> -	if (ret)
> -		return ret;
> -
> -	ret = devm_add_action_or_reset(dev, sprd_mbox_disable, priv);
> -	if (ret) {
> -		dev_err(dev, "failed to add mailbox disable action\n");
> -		return ret;
> +		return PTR_ERR(clk);
>   	}
>   
>   	inbox_irq = platform_get_irq_byname(pdev, "inbox");

