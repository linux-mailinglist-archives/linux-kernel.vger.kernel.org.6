Return-Path: <linux-kernel+bounces-187706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3544C8CD6E7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 947F9B22312
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F07107B3;
	Thu, 23 May 2024 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OpvT5SxI"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFA213ACC
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716477591; cv=none; b=MFfq2STJhPf2bJNFGuT/6p7r/IMDBRMJCxYeI7z5e1wlc1FmcMm4Tzx7lShMtMsRPWiYELiXFUtb8NUk73IgAFr7HXVct+Po54JzJIDhTHsTg75KMiBIZ0xoXKjOuced6NoZfYLHhh7Uuxy6S2hly1a/JGrGh3MKz6rXBgIy7eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716477591; c=relaxed/simple;
	bh=ZaI6HyjrVf5AfVup6BcuvCZdEFVum+g4SUMC+psoEWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K42zuv9wj8ujJL24/Jrdio0P+532gfuDVseviN4Dr9xFsJTq8eKJzCYYvhY6En0bUSCTtMEroeuE7P+JXIeEA8mFIqTuiTyn+iZXQOSVyOjErOR40KC+FAxj6w0E+IvoBIfuSwF/QwDUXeEtRjU873E/mQt5yOyHUcOzNNfCUUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OpvT5SxI; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: helgaas@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716477587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VmITnvzd0IbZjn+ZkuoMDkt3gI/vCxtww1N54pkDA9I=;
	b=OpvT5SxIDvfkaJ43NWWVgmtXxXm9YUZ34/wYw58Zs01n4yoSD/UwTHQiDU9FGAaJkSQqP1
	4S0uaJa2uC04OL73hIW4vvZK84wGboDHnlkNBp8J3Evaeb/KBnMPgfVH11gt3ntqBivv6T
	EeOGRQ0SD6N0Y4GKyv51WZ4uHS6ozHY=
X-Envelope-To: g@bhelgaas
X-Envelope-To: lpieralisi@kernel.org
X-Envelope-To: kw@linux.com
X-Envelope-To: robh@kernel.org
X-Envelope-To: linux-pci@vger.kernel.org
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: thippeswamy.havalige@amd.com
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: bhelgaas@google.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: conor+dt@kernel.org
X-Envelope-To: krzysztof.kozlowski+dt@linaro.org
X-Envelope-To: devicetree@vger.kernel.org
Message-ID: <afe44d18-178d-4fbc-b19e-691b747df8d0@linux.dev>
Date: Thu, 23 May 2024 11:19:42 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/7] dt-bindings: pci: xilinx-nwl: Add phys
To: Bjorn Helgaas <helgaas@kernel.org>,
	g@bhelgaas.smtp.subspace.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 Michal Simek <michal.simek@amd.com>,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
 linux-arm-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org
References: <20240522222838.GA101305@bhelgaas>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240522222838.GA101305@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/22/24 18:28, Bjorn Helgaas wrote:
> On Mon, May 20, 2024 at 10:53:56AM -0400, Sean Anderson wrote:
>> Add phys properties so Linux can power-on/configure the GTR
>> transcievers.
> 
> s/transcievers/transceivers/

I always forget the spelling is backwards on this one

> Possibly s/phys/PHYs/ in subject, commit log, DT description to avoid
> confusion with "phys" (short for generic "physical").  Or maybe even
> just "PHY properties"?

Well, this is the name for the property...

> What does "GTR" mean?  Possibly expand that?

It's "xlnx,zynqmp-psgtr-v1.1". These are the available transceivers on
the ZynqMP, which is the only SoC this device is present on. I had hoped
this would be clear by calling them "GTR transcievers"...

--Sean

>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> 
>> Changes in v3:
>> - Document phys property
>> 
>> Changes in v2:
>> - Remove phy-names
>> - Add an example
>> 
>>  Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml | 7 +++++++
>>  1 file changed, 7 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
>> index 426f90a47f35..cc50795d170b 100644
>> --- a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
>> @@ -61,6 +61,11 @@ properties:
>>    interrupt-map:
>>      maxItems: 4
>>  
>> +  phys:
>> +    minItems: 1
>> +    maxItems: 4
>> +    description: One phy per logical lane, in order
>> +
>>    power-domains:
>>      maxItems: 1
>>  
>> @@ -110,6 +115,7 @@ examples:
>>    - |
>>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>>      #include <dt-bindings/interrupt-controller/irq.h>
>> +    #include <dt-bindings/phy/phy.h>
>>      #include <dt-bindings/power/xlnx-zynqmp-power.h>
>>      soc {
>>          #address-cells = <2>;
>> @@ -138,6 +144,7 @@ examples:
>>                              <0x0 0x0 0x0 0x3 &pcie_intc 0x3>,
>>                              <0x0 0x0 0x0 0x4 &pcie_intc 0x4>;
>>              msi-parent = <&nwl_pcie>;
>> +            phys = <&psgtr 0 PHY_TYPE_PCIE 0 0>;
>>              power-domains = <&zynqmp_firmware PD_PCIE>;
>>              iommus = <&smmu 0x4d0>;
>>              pcie_intc: legacy-interrupt-controller {
>> -- 
>> 2.35.1.1320.gc452695387.dirty
>> 


