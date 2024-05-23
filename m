Return-Path: <linux-kernel+bounces-187924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E55EA8CDAD2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223E91C22EB0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 19:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1854839FF;
	Thu, 23 May 2024 19:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vnTX0/Cf"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADED839F3
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716492117; cv=none; b=GZ0QPbmiqZ60nPEoa0sjUeLvDWm1H5euNMLOCv8V9CzfGCVA5ullMLJE6d1xT2wH36eAvzd/jaAgeXeKwbJxdX8NVcuoclCpjKfuVR3CiMXM1cU5gpA920Me6zzqAAfk463jc3Cm16icjYKFvRRgV03wY39UqvINdph4o7b+vYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716492117; c=relaxed/simple;
	bh=25mrLq4UvC0JErHjDuS4X9W9wdyENwq5Smnn3Kaw0kE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8azjPf5SswjpZzOuvwoklPSLnsP/ykFJK/ucDGvIh2hCrop8Eq3d88GzOf7nalB1MDU3fYdjvyBQs1aTg87b2MoVEdzRTftZhX/q9NspnQKF5ZdiIR2QeiNMCF/yE7HFXHOailpEdDwrWGYIoa3C20tqvGha2ceArbG/FkRaKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vnTX0/Cf; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: markus.elfring@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716492114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WzX5A5SYPlpB7RwukIY2e9k3aUFWdFp/hlgqPag14Us=;
	b=vnTX0/CfpQCPagjo016On7vSi/hVR85K2yQVOo+kUwULXO4l9MXFhPF7rSDbmtAbElptlb
	f9YWyZh55NSi7U6owtU3NemUwYbHwtxCDSXOoLgWfnKfrT0Rj9j/0UMFUlxTRQjrqWNOcs
	/jrUFZHR0K7vt0A+6BgLzR21uS39PpA=
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-pci@vger.kernel.org
X-Envelope-To: kw@linux.com
X-Envelope-To: lpieralisi@kernel.org
X-Envelope-To: robh@kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: bharat.kumar.gogada@xilinx.com
X-Envelope-To: bhelgaas@google.com
X-Envelope-To: lorenzo.pieralisi@arm.com
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: michal.simek@xilinx.com
X-Envelope-To: thippeswamy.havalige@amd.com
Message-ID: <bb9e239f-902b-4f52-a5e9-98c29b360418@linux.dev>
Date: Thu, 23 May 2024 15:21:48 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 5/7] PCI: xilinx-nwl: Clean up clock on probe
 failure/removal
To: Markus Elfring <Markus.Elfring@web.de>,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Michal Simek <michal.simek@amd.com>, Michal Simek <michal.simek@xilinx.com>,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>
References: <20240520145402.2526481-6-sean.anderson@linux.dev>
 <4a43cda4-dfa4-4156-b616-75e740f6fd64@web.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <4a43cda4-dfa4-4156-b616-75e740f6fd64@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/23/24 15:18, Markus Elfring wrote:
>> Make sure we turn off the clock on probe failure and device removal.
> …
>> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> …
>> @@ -817,11 +818,23 @@ static int nwl_pcie_probe(struct platform_device *pdev)
>>  		err = nwl_pcie_enable_msi(pcie);
>>  		if (err < 0) {
>>  			dev_err(dev, "failed to enable MSI support: %d\n", err);
>> -			return err;
>> +			goto err_clk;
>>  		}
>>  	}
>>
>> -	return pci_host_probe(bridge);
>> +	err = pci_host_probe(bridge);
>> +
>> +err_clk:
>> +	if (err)
>> +		clk_disable_unprepare(pcie->clk);
> 
> I suggest to use the label “disable_unprepare_clock” directly before this function call
> (in the if branch) so that a duplicate check would be avoided after some error cases.

Well if you want to avoid a check, we can just do

err = pci_host_probe(bridge);
if (!err)
	return 0;

err_clk:
	...

--Sean

