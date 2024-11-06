Return-Path: <linux-kernel+bounces-398951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEC19BF864
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6DA284060
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C4D20C313;
	Wed,  6 Nov 2024 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="LzIQnRUr"
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CCA1D6DDA;
	Wed,  6 Nov 2024 21:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730927850; cv=none; b=NysQcgWXeACTh3cPMzkfhhE5JlnhwLB6YScn8tcyyIZwX3/PFLvng9y2K7Ya+H+WjDnS3iQKXaprVcBIMrfNuTFeYNoQNp2urTPr/RZK9JFpYXgcp1pK5sg1M9MTfmK+EbXVv+WyIo+lwhIIC6pYKVwWzYU+fs2VB4RDmlHuXx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730927850; c=relaxed/simple;
	bh=zEsXT7lp8yFeWdvXkyF7krDOTtoBSR8PseVMIaWwrqI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Xh/6nZqqcB7+wegroxQuqx3Yys7HZk/rZ3Btf+4+x71zLjdSz2N/htif9Suzywo+iygOVcmkshnbFwucjVqjPsSGHcANOIX5N69DlRs/OzKAgyzRc61S64rfgSJgDMSWj9q/BVDRSzKXjYj6UZbcA40z7zDhShHZQYN63Sw6SSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=LzIQnRUr; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
	by mxout4.routing.net (Postfix) with ESMTP id 5A4E81015D2;
	Wed,  6 Nov 2024 21:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1730927845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hBLyzvIh7CKmRzey/NIzdLIeO4OLcavrJ7K8Oj+KhKw=;
	b=LzIQnRUr49A6oV1zsN6hj4DQg175lI5Ckwwx0fKML1DlY02b6TiyogV0L4LmgS0z10j1Cf
	zcH+mOp5qGZaocNlvqSXhAUcYDe5fbF2cNHQq3oCkkxWUQwYybxqfC+8rUhsD1C49k5P+l
	AI7wyL3wE5PK1RctS0hhkd7w7TES++A=
Received: from webmail.hosting.de (unknown [134.0.26.148])
	by mxbox1.masterlogin.de (Postfix) with ESMTPSA id B16304009E;
	Wed,  6 Nov 2024 21:17:24 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 06 Nov 2024 22:17:24 +0100
From: "Frank Wunderlich (linux)" <linux@fw-web.de>
To: Rob Herring <robh@kernel.org>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn
 <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, frank-w@public-files.de
Subject: Re: [PATCH] arm64: dts: marvell: Drop undocumented SATA phy names
In-Reply-To: <CAL_JsqKfpVVVh6L0PLmieBO3qMFpcDfWFwd+5=qzH_MbeZt31Q@mail.gmail.com>
References: <20241014193528.1896905-2-robh@kernel.org>
 <87r07p8x12.fsf@BLaptop.bootlin.com>
 <0A5AFF77-D888-4151-9C15-15A408709857@fw-web.de>
 <CAL_JsqKfpVVVh6L0PLmieBO3qMFpcDfWFwd+5=qzH_MbeZt31Q@mail.gmail.com>
Message-ID: <4aa7f13e12646722d859ead240177eab@fw-web.de>
X-Sender: linux@fw-web.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Mail-ID: 84ed6ef5-32e9-463f-b99c-fd8841002fe1

Am 2024-11-06 19:39, schrieb Rob Herring:
> On Wed, Nov 6, 2024 at 12:34 PM Frank Wunderlich <linux@fw-web.de> 
> wrote:
>> 
>> Am 5. November 2024 17:28:57 MEZ schrieb Gregory CLEMENT 
>> <gregory.clement@bootlin.com>:
>> >"Rob Herring (Arm)" <robh@kernel.org> writes:
>> >
>> >> While "phy-names" is allowed for sata-port nodes, the names used aren't
>> >> documented and are incorrect ("sata-phy" is what's documented). The name
>> >> for a single entry is fairly useless, so just drop the property.
>> >>
>> >> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
>> >
>> >Applied on mvebu/dt64
>> >
>> >Thanks,
>> >
>> >Gregory
>> >> ---
>> >> Cc: Frank Wunderlich <linux@fw-web.de>
>> >>
>> >> There's also this 2 year old patch fixing other SATA errors[1] which
>> >> was never picked up. :(
>> >>
>> >> [1] https://lore.kernel.org/linux-arm-kernel/20220311210357.222830-3-linux@fw-web.de/
>> 
>> Hi
>> 
>> How to deal with my patch pointed by rob?
> 
> I believe it will conflict with mine. Can you rebase on top of
> mvebu/dt64 and resend it.
> 
> Rob

i have rebased my patch [1], but it seems there are much more errors 
there (which i tried to fix there too).

To be honest marvell is confusing to me finding the right file to patch 
because of many dtsi files included by each other mixed with some 
macros.

at least some properties have to be documented in yaml:

arch/arm64/boot/dts/marvell/armada-8040-db.dtb: sata@540000: Unevaluated 
properties are not allowed ('#address-cells', '#size-cells', 
'dma-coherent', 'iommus' were unexpected)

sata-node itself seems to be defined in 
arch/arm64/boot/dts/marvell/armada-cp11x.dtsi (adress/size-cells and 
dma-coherent are defined here)

iommus seems to be added with
83a3545d9c37 2020-07-15 arm64: dts: marvell: add SMMU support Marcin 
Wojtas  (tag: mvebu-dt64-5.9-1)
which seems not be documented in txt before i converted the binding.

so something like adding this to the binding:

   '#address-cells':
     const: 1

   '#size-cells':
     const: 0

   dma-coherent: true

   iommus:
     maxItems: 1

dma-coherent was there in my version and seem to be broken with

6f997d4bb98b 2022-09-09 dt-bindings: ata: ahci-platform: Move 
dma-coherent to sata-common.yaml Serge Semin

but maybe i only get the error for it because of my call with my yaml 
only

ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make dtbs_check 
DT_SCHEMA_FILES=Documentation/devicetree/bindings/ata/ahci-platform.yaml

adress/size-cells is strange to me, i'm sure i tested the yaml against 
the example which also contains them...i guess it was defined somewhere 
else.

and this one:

arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtb: sata@540000: 
sata-port@0:phy-names:0: 'sata-phy' was expected
	from schema $id: http://devicetree.org/schemas/ata/ahci-platform.yaml#

i guess it is taken from here:
Documentation/devicetree/bindings/ata/ahci-common.yaml:107:        
const: sata-phy

if i understand it the right way then if phy-names is defined in 
sata-subnode it has to be value "sata-phy"...so basicly somewhere in the 
chains of dtsi's a phy-name is defined to another value..am i right?

it looks like it is in 
arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi...if i drop the 
phy-names for the other sata-ports (below cp1_sata0)

seems dropping them were missing from your patch as you remove another 
one in same file (&cp0_sata0)

please correct me if i'm wrong

regards Frank

[1] https://github.com/frank-w/BPI-Router-Linux/commits/mvebu/dt64/

