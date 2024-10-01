Return-Path: <linux-kernel+bounces-345760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6717298BAC8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2E01C21EFA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D248155738;
	Tue,  1 Oct 2024 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TWvnVKv7"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0B61C0DE8
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781311; cv=none; b=ZrypZFiRvztUdYEcY20RGXviPPEvEjDDFq4w6NyRVuGRvu4YFBTNoyPqGAd+ZZ2VvukW5eveC2sVk3dqDt0HZ3i2zUAQeX48wDsHVYELMbsjQBqOQU4WAhTFrtflIUL4LfesB6+7Sb27kUC5vnon07/pR0wRqMLpHZ76a79Xg7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781311; c=relaxed/simple;
	bh=wF+W3o30fnE5ERMF9wak26ZV558A9MZ7rZ72eEgyxGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uFNjHgItx8JyzCuaWcmEdsoFY4GgSJpdFlKDhKlX8RQV9Th0X8aPi1I9EtMlfshGSIlO28GkBGrl5x1GA+8BpYoy7M7M7xlLGkaioHYZtaEJNtqbUIm1ToVaaSzNCeOSPvnqjDcnsaJCopPyvFC+ypW4RCxFNT/gSYR70pPeI7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TWvnVKv7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42ee66c2c49so7777365e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 04:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727781307; x=1728386107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W6SiLJ/fBHqBQIXOaPU5iB2/HMYF5uz01zhEtRfC/Yw=;
        b=TWvnVKv7B71SfwaP+zqQ9KDmIC0FIbOQa879h8QpOP7mGZKExRR4RTGVwmmDn+tsfE
         DvwtRG0eGHKuM+2iiULokucT3CLyo2ZEKAhiMeog/3CY5C/3Emefjkmq31KA4SRgGFud
         lOH4oMM+t1HNIevfIwgD41tC6rvkJ7jMUWLQiGIizwhU1GAmigY+cZi2sWM6P2gd+LeZ
         cp7VFWMPxtqk45P+qz3dwJi/pNzPurs0NAfcJefFTwXeQKUgLgdBzC8JYCEkotylIqHo
         7M86B3CEhcgKlE47WwjmsatwX2peWunMwuv80uguPiCJVjIcCgDPTm257CytKEai1iUz
         38Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727781307; x=1728386107;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6SiLJ/fBHqBQIXOaPU5iB2/HMYF5uz01zhEtRfC/Yw=;
        b=W7CVHz5P9Qfp7ACMBKcPOH5oMx9a8reIeJTvwNYvxs9/yLj/9tGxmXnHinpRxoZegG
         zwy3ozT/2PppX0YYSu5iUnFeLySB2kJwyQdlhLUC6hZGgSyROOTPI/ylDxjFFES72fXd
         9tsWO5tlD9DCstwlTffOEmoDaEnXZ+14h8h5uvJthzPjIxyqurd12z6bKYyekOyUEM48
         +1R3ETcmec5Qx4+LYASzYR184hUpfSe2FVgilVGtVALlwpTOZRyntDcIq0ZTUCwSkUhN
         GJuSfhIuigDlNzqGFybLAl/YLZTuu/S+kPSLzaGfl5NALjO2b+AeKT4BgGy1vhjJ4Skf
         jnLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkKu3uDw/UP4OTaZcczsAVparnIKtOG1SFwPqAZiczG5fs7O2E+IygcoJH3sPIaLQ/FonP1mCDgXMr6gQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1TediEVaC7cbNlYpHwFbV/05zjhM2Xi3Ai1BoNLuPljEtVz3t
	cYA1YXj+zTfJm372nw1XDDdc8jGUomrIjuYLdPMyo7o83KfuUCN7XWuSkpA9mVnOgMqWqU6lchJ
	G
X-Google-Smtp-Source: AGHT+IEs9YcgPcjdQWxKIa/W6Fm+Wc1BMTsPbLsBzcnNPbowqqYS3jZ7lWERZ/FWAMJw4rhW3q4lTQ==
X-Received: by 2002:a05:600c:3b87:b0:42c:c0d8:bf34 with SMTP id 5b1f17b1804b1-42f5e30daf7mr40504545e9.0.1727781306696;
        Tue, 01 Oct 2024 04:15:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a36705sm178764485e9.33.2024.10.01.04.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 04:15:06 -0700 (PDT)
Message-ID: <f263831f-d980-47b6-8c1c-841495b3bc1b@linaro.org>
Date: Tue, 1 Oct 2024 13:15:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] soc: marvell: Add a general purpose RVU PF driver
To: Anshumali Gaur <agaur@marvell.com>, conor.dooley@microchip.com,
 ulf.hansson@linaro.org, arnd@arndb.de, linus.walleij@linaro.org,
 nikita.shubin@maquefel.me, alexander.sverdlin@gmail.com, vkoul@kernel.org,
 cyy@cyyself.name, linux-kernel@vger.kernel.org, sgoutham@marvell.com
References: <20241001104948.2779665-1-agaur@marvell.com>
 <20241001104948.2779665-2-agaur@marvell.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20241001104948.2779665-2-agaur@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/10/2024 12:49, Anshumali Gaur wrote:
> Resource virtualization unit (RVU) on Marvell's Octeon series of
> silicons maps HW resources from the network, crypto and other
> functional blocks into PCI-compatible physical and virtual functions.
> Each functional block again has multiple local functions (LFs) for
> provisioning to PCI devices.
> RVU supports multiple PCIe SRIOV physical functions (PFs) and virtual
> functions (VFs). And RVU admin function (AF) is the one which manages
> all the resources (local functions etc) in the system.

I responded to you on your v1 that you should not CC people totally
irrelevant to this patchset: like me.

I gave you also extensive guide how to use tools to find people to cc.

But no, you decided to keep spamming me.

Since you insist, annoyed review follows:

...


> +
> +#define DRV_NAME    "rvu_generic_pf"
> +
> +/* Supported devices */
> +static const struct pci_device_id rvu_gen_pf_id_table[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, 0xA0F6) },
> +	{ }  /* end of table */
> +};
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Marvell Octeon RVU Generic PF Driver");
> +MODULE_DEVICE_TABLE(pci, rvu_gen_pf_id_table);

All above go to the end of the module.

> +
> +static int rvu_gen_pf_check_pf_usable(struct gen_pf_dev *pfdev)
> +{
> +	u64 rev;
> +
> +	rev = readq(pfdev->reg_base + RVU_PF_BLOCK_ADDRX_DISC(BLKADDR_RVUM));
> +	rev = (rev >> 12) & 0xFF;
> +	/* Check if AF has setup revision for RVUM block,

Use Linux coding style. See coding style document to figure out how
comment should look like.

> +	 * otherwise this driver probe should be deferred
> +	 * until AF driver comes up.
> +	 */
> +	if (!rev) {
> +		dev_warn(pfdev->dev,
> +			 "AF is not initialized, deferring probe\n");
> +		return -EPROBE_DEFER;

That's just racy...

> +	}
> +	return 0;
> +}
> +
> +static int rvu_gen_pf_sriov_enable(struct pci_dev *pdev, int numvfs)
> +{
> +	int ret;
> +
> +	ret = pci_enable_sriov(pdev, numvfs);
> +	if (ret)
> +		return ret;
> +
> +	return numvfs;
> +}
> +
> +static int rvu_gen_pf_sriov_disable(struct pci_dev *pdev)
> +{
> +	int numvfs = pci_num_vf(pdev);
> +
> +	if (!numvfs)
> +		return 0;
> +
> +	pci_disable_sriov(pdev);
> +
> +	return 0;
> +}
> +
> +static int rvu_gen_pf_sriov_configure(struct pci_dev *pdev, int numvfs)
> +{
> +	if (numvfs == 0)
> +		return rvu_gen_pf_sriov_disable(pdev);
> +
> +	return rvu_gen_pf_sriov_enable(pdev, numvfs);
> +}
> +
> +static void rvu_gen_pf_remove(struct pci_dev *pdev)
> +{
> +	struct gen_pf_dev *pfdev = pci_get_drvdata(pdev);
> +
> +	rvu_gen_pf_sriov_disable(pfdev->pdev);
> +	pci_set_drvdata(pdev, NULL);
> +
> +	pci_release_regions(pdev);
> +}
> +
> +static int rvu_gen_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct gen_pf_dev *pfdev;
> +	int err;
> +
> +	err = pcim_enable_device(pdev);
> +	if (err) {
> +		dev_err(dev, "Failed to enable PCI device\n");
> +		return err;
> +	}
> +
> +	err = pci_request_regions(pdev, DRV_NAME);
> +	if (err) {
> +		dev_err(dev, "PCI request regions failed %d\n", err);
> +		goto err_map_failed;
> +	}
> +
> +	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
> +	if (err) {
> +		dev_err(dev, "DMA mask config failed, abort\n");
> +		goto err_release_regions;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	pfdev = devm_kzalloc(dev, sizeof(struct gen_pf_dev), GFP_KERNEL);

sizeof(*)


Are you sure you run checkpatch --strict on this?

Best regards,
Krzysztof


