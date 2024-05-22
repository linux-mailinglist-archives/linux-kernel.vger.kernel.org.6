Return-Path: <linux-kernel+bounces-186671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCCE8CC75E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C89283FD7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180082D7B8;
	Wed, 22 May 2024 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LhV8ZVrf"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721955C3E
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716406624; cv=none; b=piMDcV7KHu4AV4Clz9DZcAcG98wkQf1/pw+4zBqMONO30FoW84/BtFlh1j6QBAhRTWKBspiZlBf+aOLLrvI+VAeaRduflL57r3GgmX4rtDdZgDL3xQZDMERvL5aNrsiQpDrwhRLuDYyvMSEvnxoLoLB72K0v9DRubO3F+KeEKoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716406624; c=relaxed/simple;
	bh=xTqQdgYcdQoRTQrLafAQR8351orN3TlakwM1Lo0Ihfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIwtlbSMiyKRPx2srkCKwKpkWvrAgtE9P8TUHHXdpPYeOoRkzw1cbh/xO17Qh7bTVA5SijaBj//7XgwIjkzxLUQIL/X4GR6mn9gnLyE0SAfbp59Jq/qa3iPmtYXG3zuQN6+0kgUENx26tJVdaC0EBqdjWAqbippCfOuJVEwrC+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LhV8ZVrf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42100fa9dd6so766775e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 12:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716406621; x=1717011421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RklcF80tq5X+3383bH6neWsLhpnd+n0FQDCW5KgS35A=;
        b=LhV8ZVrfbk9FbEz1HE7vqRlymoVUARrdtjibdVOwToHqqnDodKVE91mWPvHj7l+ykp
         7OUPwd8px0L2/VM7FxvW6xY2SlXTI1iMxcJkft2w3gmOOSPVfMu3wCADkIgqO5lopSS+
         1U6c4gg4PhlEjuI5ma08WwnjeOYYuasCtGor8AQVfvHqu0UGjHYhSBsKIXF/8VBlFsrV
         VmrhKgz53vUVR+7WMJX+mfSRLoxFMZFbGXANUddhe0avwE+XqsjJ/C1KvoyOX0p9PFNU
         GdHVcTGqDJdyeV+McLuLV7RilncjqQ/hjx8M70Lff2OGW9X8Vv0nVHQV5Wtiq1baTo7u
         F50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716406621; x=1717011421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RklcF80tq5X+3383bH6neWsLhpnd+n0FQDCW5KgS35A=;
        b=Ej04dH1oeOqNll8klUi0dr6R02eeqsGmy+y1BKHF/X9zHpcul/voDTHadWR1OT4BT3
         MtXeBq2KWTzkl3QihekwRNUu/deBRm6VgYWOhNv8BdivK0KG1jjn6CyMDfm3VK+TqZ0w
         dt7WvU9Xhrw4YjXtQ4W6F0VULdZ830vcOJh8fWzZPpYYzosr1+dmZpuBR94OaUNBlzun
         81uV4lVzx7bc6xTg6oFhJYJlo+wd/KV/FV+W8Hg5uA90XaUPvj/9Z6/i6/n/mGRmgnuA
         Go+4AwU2AcHRc4rN7QipJPy3+l2CfEg4zRgDV+JhvZ8z5iyV6ugpAj5R5kwVUDJkHBi8
         y+Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXBLnUm65xfC2YRxt33V/2y9i81oQ8tr/RFO43msY7odgdKv9baffKGww9RMUIaZfSxdiuSXvmiTfDewtWUwNwqRCKstbAT/Dy32a70
X-Gm-Message-State: AOJu0YwaI7rPUHCjnRXi+KiOapFxaW3mqyX1HPkEGsxV5wgxtnTruL81
	5EOKITMzi9BhfjJ8ygg2XevbyL+yxM/cbEcml4T1NA4ueesiBDh7Gyk6Em0gQGg=
X-Google-Smtp-Source: AGHT+IE2XqtQTpi6aUOmONE09agwyzRtxEfKZLEFkZJppmwYwmfJSMSzdh3z3XgLykiimkl+iSxAjw==
X-Received: by 2002:a05:600c:3ca5:b0:41b:fad8:45e0 with SMTP id 5b1f17b1804b1-42101452b85mr2047505e9.0.1716406620548;
        Wed, 22 May 2024 12:37:00 -0700 (PDT)
Received: from linaro.org ([188.27.161.69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421010b97c9sm3214785e9.45.2024.05.22.12.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 12:37:00 -0700 (PDT)
Date: Wed, 22 May 2024 22:36:59 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spmi: pmic-arb: Pass the correct of_node to
 irq_domain_add_tree
Message-ID: <Zk5JWzpc8a9Dyfay@linaro.org>
References: <20240522-topic-spmi_multi_master_irqfix-v2-1-7ec92a862b9f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522-topic-spmi_multi_master_irqfix-v2-1-7ec92a862b9f@linaro.org>

On 24-05-22 20:08:17, Konrad Dybcio wrote:
> Currently, irqchips for all of the subnodes (which represent a given
> bus master) point to the parent wrapper node. This is no bueno, as
> no interrupts arrive, ever (because nothing references that node).
> 
> Fix that by passing a reference to the respective master's of_node.
> 
> Worth noting, this is a NOP for devices with only a single master
> described.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

You forgot the fixes tag here as well.

LGTM otherwise.

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
> Changes in v2:
> - Un-delete the missing ampersand
> - Link to v1: https://lore.kernel.org/r/20240522-topic-spmi_multi_master_irqfix-v1-1-f7098b9c8804@linaro.org
> ---
>  drivers/spmi/spmi-pmic-arb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
> index 791cdc160c51..e6a4bf3abb1f 100644
> --- a/drivers/spmi/spmi-pmic-arb.c
> +++ b/drivers/spmi/spmi-pmic-arb.c
> @@ -1737,8 +1737,7 @@ static int spmi_pmic_arb_bus_init(struct platform_device *pdev,
>  
>  	dev_dbg(&pdev->dev, "adding irq domain for bus %d\n", bus_index);
>  
> -	bus->domain = irq_domain_add_tree(dev->of_node,
> -					  &pmic_arb_irq_domain_ops, bus);
> +	bus->domain = irq_domain_add_tree(node, &pmic_arb_irq_domain_ops, bus);
>  	if (!bus->domain) {
>  		dev_err(&pdev->dev, "unable to create irq_domain\n");
>  		return -ENOMEM;
> 
> ---
> base-commit: 8314289a8d50a4e05d8ece1ae0445a3b57bb4d3b
> change-id: 20240522-topic-spmi_multi_master_irqfix-f63ebf47b02c
> 
> Best regards,
> -- 
> Konrad Dybcio <konrad.dybcio@linaro.org>
> 

