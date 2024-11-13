Return-Path: <linux-kernel+bounces-407486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 142819C6E1D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8960281B11
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F058D1FF035;
	Wed, 13 Nov 2024 11:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KLrNWP/k"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5776B200B8B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731498336; cv=none; b=W2aDwwPO5kUC/DamrdLeze5nGolUU1dpj/4VI7ivvW1FNY4yy9mGDfbJ3qvXqCtCV3KwPLYqkiPcgVd8PwUCiVskml2nYKj28T9D/iEgEMTbT0/ZJJ9umHBdo/yOBKW8SpFftW/aK0Kf8PRaWxpbtMvXVfr6x9ZvQ1cYu+hGv8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731498336; c=relaxed/simple;
	bh=6E0udyNgSP1qecSTiKlO0UyWkcCXWCsh7X3SGZ6DfX4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=SzjYqbnUuh+khDEzpItkLFIuD7ZhA6DIk9lRtZ7JxzbbKi7GMukauvmAWWjDV0vYnR/B02SyQ2KovPuBua4nTm06hQYNP+d/4eTCqqkmiIpxJnuNtCDVAekKr2p5N5POp0QQpv5t13CjLuwRUc2K57y4S2DSU0l1RSi9/lnMjEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KLrNWP/k; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e5f6e44727so4288093b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 03:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731498332; x=1732103132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a+GQG+dngfYLQ58gUq++xO1sdDZ8ABc6gLSKTdWCc3o=;
        b=KLrNWP/kG4LPPF8US/0E3oDnUYKZtZSa1cJ/epjcx8pyHbZ3vsqV3P9nbgWPak6lKG
         1cBaGgl1yNpYxPcaK6rvqJOhe6sSPWWSKUweyL82YfkfTwii3c4A+8jSyRUcGCQ0VKbW
         BvAsV3AFy8J/EDQm1uHx4n5cvYnpGBNSoKT5+mblhTKKe16n5sFwhb9h260TMrCPsre/
         A6NqZPkitA+KmAU+StF5A9GfxAhtkh4Du861B/ZQaSXogYLwDjgFdqtdK5dtYFiPg1BV
         1/JsEI25A4EF82ItDz8r9KX5W6khPcv2EAtErrlj6isdHqLCto8heY+nF4qomDEw5XiM
         JtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731498332; x=1732103132;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a+GQG+dngfYLQ58gUq++xO1sdDZ8ABc6gLSKTdWCc3o=;
        b=JT04QunXqv8iFnBN2A1lGYwsbXIWDN30LlNWgdK8r/O91a63rG2dNQHshliNSfNWEn
         kyE0MIhgbbfI3lCXLy8M6/KIzMjDcrPXEyRQnTUg4yZEjtLHpmcmGDVY90M7M93ZTZgL
         WF9QnWpCN+PohDCB618WaK9L2ZcrQhLtuNu8vthxnbjpjbXvJKoX9Q4hCgosSPE+ZF5k
         A6kVtRfL+3Z8S8Q7+JkxoZaokDSUiFb/VAq8JaY1EMn9WpdP6x1+QMd8QQYAKnYKdtrY
         zzf1TWkKG328OvWjqHLth13nVPPlovxKu4zD0FvQ8kMs5jQCFwZHq+SHtXA8FswYRmH1
         8mYg==
X-Forwarded-Encrypted: i=1; AJvYcCWRuw0giDrBjy/3HLY0RXznshzjK/XHqoD6dMIo9Etj8VjlAaPxlFXfoYqZy9Cdn2lZfqOPMA7Q0Pj5BWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTERiMEahMzJ7Oks/6tzTINgogDRDGnr1u/HFCoizCSkv4G00r
	Em7lGT2B68iPM7dMsdOWosZqLEoBBqafk7SBtWPyLe3cscau16C5BA51TgJKEQ==
X-Google-Smtp-Source: AGHT+IF82xGVoUw13YD89/y95vpdTTo1xRVEmme5e5EI6drxCrtw9sKHaMsB4+/Wq2qT7vp2wM3k+A==
X-Received: by 2002:a05:6808:23c9:b0:3e7:135d:5de5 with SMTP id 5614622812f47-3e7946fc3b6mr20412496b6e.32.1731498332398;
        Wed, 13 Nov 2024 03:45:32 -0800 (PST)
Received: from ?IPv6:::1? ([2409:40f4:304d:f0dc:8000::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f65bf93sm12219366a12.79.2024.11.13.03.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 03:45:31 -0800 (PST)
Date: Wed, 13 Nov 2024 17:15:25 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>,
 Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
CC: lpieralisi@kernel.org, thomas.petazzoni@bootlin.com, kw@linux.com,
 robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 salee@marvell.com, dingwei@marvell.com
Subject: Re: [PATCH 1/1] PCI: armada8k: Add link-down handle
User-Agent: K-9 Mail for Android
In-Reply-To: <20241112213255.GA1861331@bhelgaas>
References: <20241112213255.GA1861331@bhelgaas>
Message-ID: <AD287CCE-9FFE-49BC-B9CA-B5CED4F05AF1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On November 13, 2024 3:02:55 AM GMT+05:30, Bjorn Helgaas <helgaas@kernel=
=2Eorg> wrote:
>In subject:
>
>  PCI: armada8k: Add link-down handling
>
>On Mon, Nov 11, 2024 at 10:48:13PM -0800, Jenishkumar Maheshbhai Patel wr=
ote:
>> In PCIE ISR routine caused by RST_LINK_DOWN
>> we schedule work to handle the link-down procedure=2E
>> Link-down procedure will:
>> 1=2E Remove PCIe bus
>> 2=2E Reset the MAC
>> 3=2E Reconfigure link back up
>> 4=2E Rescan PCIe bus
>
>s/PCIE/PCIe/
>
>Rewrap to fill 75 columns=2E
>
>I assume this basically removes a Root Port (and the hierarchy below
>it) if the link goes down, and then resets the MAC and tries to bring
>up the link and enumerate the hierarchy again=2E
>
>No other drivers do this, so why does armada8k need it?  Is this to
>work around some unreliable link?

Certainly Qcom IPs have this same feature and I was also looking to implem=
ent it=2E But the link down should not be handled by this in the controller=
 driver=2E

Instead, it should be tied to bus reset in the core and the reset should b=
e done through a callback implemented in the controller drivers=2E This way=
, the reset cannot happen in the back of PCI core and client drivers=2E

That said, the Link down IRQ received by this driver should also be propag=
ated back to the PCI core and the core should then call the callback to res=
et the bus that I mentioned above=2E

>
>I would think this would be reported via AER and possibly handled
>there already, but apparently not?

No, these are not reported via AER (atleast on Qcom platforms)=2E We have =
a global_irq that fires when Link down happens=2E

- Mani

>
>> Signed-off-by: Jenishkumar Maheshbhai Patel <jpatel2@marvell=2Ecom>
>> ---
>>  drivers/pci/controller/dwc/pcie-armada8k=2Ec | 84 ++++++++++++++++++++=
++
>>  1 file changed, 84 insertions(+)
>>=20
>> diff --git a/drivers/pci/controller/dwc/pcie-armada8k=2Ec b/drivers/pci=
/controller/dwc/pcie-armada8k=2Ec
>> index 07775539b321=2E=2Eb1b48c2016f7 100644
>> --- a/drivers/pci/controller/dwc/pcie-armada8k=2Ec
>> +++ b/drivers/pci/controller/dwc/pcie-armada8k=2Ec
>> @@ -21,6 +21,8 @@
>>  #include <linux/platform_device=2Eh>
>>  #include <linux/resource=2Eh>
>>  #include <linux/of_pci=2Eh>
>> +#include <linux/mfd/syscon=2Eh>
>> +#include <linux/regmap=2Eh>
>> =20
>>  #include "pcie-designware=2Eh"
>> =20
>> @@ -32,6 +34,9 @@ struct armada8k_pcie {
>>  	struct clk *clk_reg;
>>  	struct phy *phy[ARMADA8K_PCIE_MAX_LANES];
>>  	unsigned int phy_count;
>> +	struct regmap *sysctrl_base;
>> +	u32 mac_rest_bitmask;
>> +	struct work_struct recover_link_work;
>>  };
>> =20
>>  #define PCIE_VENDOR_REGS_OFFSET		0x8000
>> @@ -72,6 +77,8 @@ struct armada8k_pcie {
>>  #define AX_USER_DOMAIN_MASK		0x3
>>  #define AX_USER_DOMAIN_SHIFT		4
>> =20
>> +#define UNIT_SOFT_RESET_CONFIG_REG	0x268
>> +
>>  #define to_armada8k_pcie(x)	dev_get_drvdata((x)->dev)
>> =20
>>  static void armada8k_pcie_disable_phys(struct armada8k_pcie *pcie)
>> @@ -216,6 +223,65 @@ static int armada8k_pcie_host_init(struct dw_pcie_=
rp *pp)
>>  	return 0;
>>  }
>> =20
>> +static void armada8k_pcie_recover_link(struct work_struct *ws)
>> +{
>> +	struct armada8k_pcie *pcie =3D container_of(ws, struct armada8k_pcie,=
 recover_link_work);
>> +	struct dw_pcie_rp *pp =3D &pcie->pci->pp;
>> +	struct pci_bus *bus =3D pp->bridge->bus;
>> +	struct pci_dev *root_port;
>> +	int ret;
>> +
>> +	root_port =3D pci_get_slot(bus, 0);
>> +	if (!root_port) {
>> +		dev_err(pcie->pci->dev, "failed to get root port\n");
>> +		return;
>> +	}
>> +	pci_lock_rescan_remove();
>> +	pci_stop_and_remove_bus_device(root_port);
>
>Add blank line=2E
>
>> +	/*
>> +	 * Sleep needed to make sure all pcie transactions and access
>> +	 * are flushed before resetting the mac
>> +	 */
>> +	msleep(100);
>
>s/pcie/PCIe/
>s/mac/MAC/ (also below)
>
>What PCIe spec parameter is the 100ms?  If we don't already have a
>#define for it, add one in drivers/pci/pci=2Eh with spec citation=2E
>
>> +	/* Reset mac */
>> +	regmap_update_bits_base(pcie->sysctrl_base, UNIT_SOFT_RESET_CONFIG_RE=
G,
>> +				pcie->mac_rest_bitmask, 0, NULL, false, true);
>> +	udelay(1);
>> +	regmap_update_bits_base(pcie->sysctrl_base, UNIT_SOFT_RESET_CONFIG_RE=
G,
>> +				pcie->mac_rest_bitmask, pcie->mac_rest_bitmask,
>> +				NULL, false, true);
>> +	udelay(1);
>> +
>> +	ret =3D dw_pcie_setup_rc(pp);
>> +	if (ret)
>> +		goto fail;
>> +
>> +	ret =3D armada8k_pcie_host_init(pp);
>> +	if (ret) {
>> +		dev_err(pcie->pci->dev, "failed to initialize host: %d\n", ret);
>> +		goto fail;
>> +	}
>> +
>> +	if (!dw_pcie_link_up(pcie->pci)) {
>> +		ret =3D dw_pcie_start_link(pcie->pci);
>> +		if (ret)
>> +			goto fail;
>> +	}
>> +
>> +	/* Wait until the link becomes active again */
>> +	if (dw_pcie_wait_for_link(pcie->pci))
>> +		dev_err(pcie->pci->dev, "Link not up after reconfiguration\n");
>> +
>> +	bus =3D NULL;
>> +	while ((bus =3D pci_find_next_bus(bus)) !=3D NULL)
>> +		pci_rescan_bus(bus);
>> +
>> +fail:
>> +	pci_unlock_rescan_remove();
>> +	pci_dev_put(root_port);
>> +}
>> +
>>  static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
>>  {
>>  	struct armada8k_pcie *pcie =3D arg;
>> @@ -253,6 +319,9 @@ static irqreturn_t armada8k_pcie_irq_handler(int ir=
q, void *arg)
>>  		 * initiate a link retrain=2E If link retrains were
>>  		 * possible, that is=2E
>>  		 */
>> +		if (pcie->sysctrl_base && pcie->mac_rest_bitmask)
>> +			schedule_work(&pcie->recover_link_work);
>> +
>>  		dev_dbg(pci->dev, "%s: link went down\n", __func__);
>>  	}
>> =20
>> @@ -322,6 +391,8 @@ static int armada8k_pcie_probe(struct platform_devi=
ce *pdev)
>> =20
>>  	pcie->pci =3D pci;
>> =20
>> +	INIT_WORK(&pcie->recover_link_work, armada8k_pcie_recover_link);
>> +
>>  	pcie->clk =3D devm_clk_get(dev, NULL);
>>  	if (IS_ERR(pcie->clk))
>>  		return PTR_ERR(pcie->clk);
>> @@ -349,6 +420,19 @@ static int armada8k_pcie_probe(struct platform_dev=
ice *pdev)
>>  		goto fail_clkreg;
>>  	}
>> =20
>> +	pcie->sysctrl_base =3D syscon_regmap_lookup_by_phandle(pdev->dev=2Eof=
_node,
>> +						       "marvell,system-controller");
>> +	if (IS_ERR(pcie->sysctrl_base)) {
>> +		dev_warn(dev, "failed to find marvell,system-controller\n");
>> +		pcie->sysctrl_base =3D 0x0;
>> +	}
>> +
>> +	ret =3D of_property_read_u32(pdev->dev=2Eof_node, "marvell,mac-reset-=
bit-mask",
>> +				   &pcie->mac_rest_bitmask);
>> +	if (ret < 0) {
>> +		dev_warn(dev, "couldn't find mac reset bit mask: %d\n", ret);
>> +		pcie->mac_rest_bitmask =3D 0x0;
>> +	}
>>  	ret =3D armada8k_pcie_setup_phys(pcie);
>>  	if (ret)
>>  		goto fail_clkreg;
>> --=20
>> 2=2E25=2E1
>>=20

=E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

