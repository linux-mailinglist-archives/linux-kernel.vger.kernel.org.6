Return-Path: <linux-kernel+bounces-442022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1509ED6F7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C13188055D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D100820B205;
	Wed, 11 Dec 2024 20:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EKV225Ll"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA2D20A5FE
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 20:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733947307; cv=none; b=I1njDOb8eqBu2B67zSCzRmxAZWsGFbM17oRv1dNy4DE3honCKxCJa1dttZblGfMM4fglzFfFpVGj71AU8JoWcZyY/CP0C6HVXRQJ3Sts70cfg89k0Rgpf7i1LSsDG7VEbn+H3A1fZE3MtucJPU/NcFX1JcqKtQcBz8+ScjVctqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733947307; c=relaxed/simple;
	bh=F0M8NGa4GfHUrZooP1Zinaaxwf3Co2ffNjNkg35UMTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQp+Rvk2FjP7O0nv8viaVho3QtT9mw6MYVTagrA22gWhZtuLo06lz0bgrjxWzsTC8x61Yz3CBd0Uc9L45WnaInGri+/YSEUQ+uJkvXZD5AhtmKTGjfYzxlioh85wsYgjsSsIb7uHpQFwDpjQUrn5dDVyiBouIwlwiLn8YFIMmek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EKV225Ll; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-46772a0f85bso25333361cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 12:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733947303; x=1734552103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RF+SgaA8A4yu1/WtuO/9GkUtQsQvHRuIDWUMOSCXiAk=;
        b=EKV225LlIVMUZItRLdA7G6ugsy1JEul2f98IrubU45RkiYqY2DL8urr+GVjFduWfif
         qBFvOG1Z1IJIfOmMtkN8aU5cQqirgYFOheeQ4Tuck51zqWebAYvXCWrZxXDD6VPlIsFb
         rD2lWFFRbb8yQI7mDbCCcZ6ZN4i6lnZUSa4iY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733947303; x=1734552103;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RF+SgaA8A4yu1/WtuO/9GkUtQsQvHRuIDWUMOSCXiAk=;
        b=RfnKaPYm0MCqsecddvm+jvA43BYsMB8oG+bRVKtEEvhalmgwn0YgOjsCbk0Xu3k5oe
         EuRm4Wk1jxXpjjGfZqkJax9seY5payJddEXCnJACIobulntw5PRJmyxYg0Bhkv9F5wgX
         0Vrq11RRNfWcmngujnlauPqFuJBz8nhNrG2i00PDshgVwc7X5lr/SC7TCVmRiVMuKkA5
         YQ74ImWC1vaUkbXRsMO0X8DAhQd3LcYt8ukdc134QDpL1+E4aKmWlaXbA49TbwKlZopm
         YayAinxt3G0uIexClksHc/QJcbqx/+Qm5eujZjbKbATfxtdL3XyQ/tM+WfqP7s42dnBg
         cZKw==
X-Forwarded-Encrypted: i=1; AJvYcCU8aTPpWvvmO/KplqoTWzHDT89sL7lMjrB0pw9zsF6/vitBtSeMUdPbs5Fk7JdR2xmHllOsGa3ZF99qaFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsc5lI4ijwA1TAsy0Olwzkc1UWBfrLWGbEed3BwNAsaVlMGyGL
	2uNvr2pe7lBKIPSnu4UWSPmLd/d3k/Rdu+HgDLkOfLQi96XRjvt5Ulm17cacWA==
X-Gm-Gg: ASbGncurnR866qc1Kt/cZ8y6deeOhgKkLEfL8WpgCmi26LnLNYpk7yujRDsMBggwoxa
	66R4CA1LpaRDYJZ4U2KDara8XorKBDRlDgOCNS2zUqEnh2kE7r4x1KxDlBjk4ipw1amN7BlhUqA
	8tE1KUDwDaPmwECFlmBMFBzS+pov4qcJIWIeIw7mVJej9WCtITxPKyy7NDGg2hp0Py4fPJJ4P8b
	RTeQxin17C3RmAIR4q9ooPUL7rU3pU2Ls2PQAojstucjK9ISM362Q4ctE195q4fFRRTvuF+lreB
	7hWrCNu82TxG0G8=
X-Google-Smtp-Source: AGHT+IH1EItEhDF0PhWzxH0hzNi2adGVkl/4FI0Nh7NmAubh3vPiMk36HkqtIjpl2KFJLYurfshIMQ==
X-Received: by 2002:ac8:7f42:0:b0:467:59a3:b44a with SMTP id d75a77b69052e-467962a741dmr12907131cf.56.1733947303166;
        Wed, 11 Dec 2024 12:01:43 -0800 (PST)
Received: from [10.28.17.173] ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467583c1b6asm43931021cf.44.2024.12.11.12.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 12:01:42 -0800 (PST)
Message-ID: <f0a734d9-6bf6-4d28-b30b-99b6be9f62dc@broadcom.com>
Date: Wed, 11 Dec 2024 15:01:40 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 06/10] PCI: brcmstb: Enable external MSI-X if available
To: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>
References: <20241025124515.14066-1-svarbanov@suse.de>
 <20241025124515.14066-7-svarbanov@suse.de>
Content-Language: en-US
From: James Quinlan <james.quinlan@broadcom.com>
Autocrypt: addr=james.quinlan@broadcom.com; keydata=
 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
In-Reply-To: <20241025124515.14066-7-svarbanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/25/24 08:45, Stanimir Varbanov wrote:
> On RPi5 there is an external MIP MSI-X interrupt controller
> which can handle up to 64 interrupts.
>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> ---
> v3 -> v4:
>   - no changes.
>
>   drivers/pci/controller/pcie-brcmstb.c | 63 +++++++++++++++++++++++++--
>   1 file changed, 59 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index c01462b07eea..af01a7915c94 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1318,6 +1318,52 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
>   	return 0;
>   }
>   
> +static int brcm_pcie_enable_external_msix(struct brcm_pcie *pcie,
> +					  struct device_node *msi_np)
> +{
> +	struct inbound_win inbound_wins[PCIE_BRCM_MAX_INBOUND_WINS];
> +	u64 msi_pci_addr, msi_phys_addr;
> +	struct resource r;
> +	int mip_bar, ret;
> +	u32 val, reg;
> +
> +	ret = of_property_read_reg(msi_np, 1, &msi_pci_addr, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret = of_address_to_resource(msi_np, 0, &r);
> +	if (ret)
> +		return ret;
> +
> +	msi_phys_addr = r.start;
> +
> +	/* Find free inbound window for MIP access */
> +	mip_bar = brcm_pcie_get_inbound_wins(pcie, inbound_wins);
> +	if (mip_bar < 0)
> +		return mip_bar;
> +
> +	mip_bar += 1;
> +	reg = brcm_bar_reg_offset(mip_bar);
> +
> +	val = lower_32_bits(msi_pci_addr);
> +	val |= brcm_pcie_encode_ibar_size(SZ_4K);
> +	writel(val, pcie->base + reg);
> +
> +	val = upper_32_bits(msi_pci_addr);
> +	writel(val, pcie->base + reg + 4);
> +
> +	reg = brcm_ubus_reg_offset(mip_bar);
> +
> +	val = lower_32_bits(msi_phys_addr);
> +	val |= PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_ACCESS_EN_MASK;
> +	writel(val, pcie->base + reg);
> +
> +	val = upper_32_bits(msi_phys_addr);
> +	writel(val, pcie->base + reg + 4);

Hi Stan,

It looks like all this is doing is setting up an identity-mapped inbound 
window, is that correct?  If so, couldn't you get the same effect by 
adding an identity-mapped dma-range in the PCIe DT node?

Jim Quinlan  Broadcom STB/CM

> +
> +	return 0;
> +}
> +
>   static const char * const supplies[] = {
>   	"vpcie3v3",
>   	"vpcie3v3aux",
> @@ -1879,11 +1925,20 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>   		goto fail;
>   	}
>   
> -	msi_np = of_parse_phandle(pcie->np, "msi-parent", 0);
> -	if (pci_msi_enabled() && msi_np == pcie->np) {
> -		ret = brcm_pcie_enable_msi(pcie);
> +	if (pci_msi_enabled()) {
> +		msi_np = of_parse_phandle(pcie->np, "msi-parent", 0);
> +		const char *str;
> +
> +		if (msi_np == pcie->np) {
> +			str = "internal MSI";
> +			ret = brcm_pcie_enable_msi(pcie);
> +		} else {
> +			str = "external MSI-X";
> +			ret = brcm_pcie_enable_external_msix(pcie, msi_np);
> +		}
> +
>   		if (ret) {
> -			dev_err(pcie->dev, "probe of internal MSI failed");
> +			dev_err(pcie->dev, "enable of %s failed\n", str);
>   			goto fail;
>   		}
>   	}



