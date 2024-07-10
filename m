Return-Path: <linux-kernel+bounces-247812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D561B92D4E1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90497285E82
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B74194153;
	Wed, 10 Jul 2024 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dr4XHeKb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BCE2A1C9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720624979; cv=none; b=ppl/R71HjdawENaAuiTaU+Tdt6m9p3Oym0GeS7XvXVZiES6G0rlVnwtUbFNX6EJHeN2YQLzWXANXXy2aTEEo4SzbV+6MCuLV60nOwqE9ULiWyu0x9/LN/MUXfOg3OdS/J9ZRHVm++mnlvPLaB5MLUIZEV6S4qH4TEZjQ3v0aStw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720624979; c=relaxed/simple;
	bh=erdx/YDuY1nsaJxaC8TvXKgwHjYDK0CLut0tTlTGSmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e0pCNGQH9h13/nPM/RbarfhwLAG4MpUgfkDVBF6paNs8QprCTtIh7tCnurlwd+hDpnlmcy843szKM2iSRCv1O3QwWZF0rbgsw9gAl/Yk26zw+l7Mltt8bZ9weptRfFxy8m7LIyU/iblqNw9rC6Li3tLA69NTi8nlaO25A5meiEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dr4XHeKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655C4C32781;
	Wed, 10 Jul 2024 15:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720624979;
	bh=erdx/YDuY1nsaJxaC8TvXKgwHjYDK0CLut0tTlTGSmw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dr4XHeKbL4jSGYqorBqgaiHAGF06g9tVbQiAjAFxZAXBMyrO3XZAq5jq8ZVmwpcuc
	 6KOCQiZo1SJKOgakNyK9tYV6Y2e2jzeWWdodXQtkJ/V/dGdltJkUgaJoB/tLabzqhx
	 dAaPw8HYluKRUbMSPBich1n+VDLZuuxyxtCqgzW76eobmrXpLavVfHZkDTkg/Zx1nM
	 0u2rgbwrxNgZT0MmzPsu8J7GY6yPcih7aIiN9M10PHSbz68/pNzuszHwF5IDo3Vs35
	 Zbx6JBW2Y8k55FxrwUnIeCsnKepgN1l04O5qW6bU6TO7hzwGR3T/E/IxTB9BiFn4th
	 C1nWLGYx1p2EQ==
Message-ID: <acef4aeb-ddb6-4e2b-b2ac-8ac351efcf2f@kernel.org>
Date: Wed, 10 Jul 2024 18:22:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] phy: cadence-torrent: add support for three or more
 links using 2 protocols
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vkoul@kernel.org,
 kishon@kernel.org, p.zabel@pengutronix.de, sjakhade@cadence.com,
 thomas.richard@bootlin.com, theo.lebrun@bootlin.com, robh@kernel.org
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com
References: <20240710115624.3232925-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240710115624.3232925-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Siddharth,

On 10/07/2024 14:56, Siddharth Vadapalli wrote:
> The Torrent SERDES can support at most two different protocols. This only

Could you please point to where this is mentioned? Doesn't this SERDES support 4 lanes?
So in theory each lane can be used as one protocol (or link) independed of the other.

Also, from code

struct cdns_torrent_phy {
...
        struct cdns_torrent_inst phys[MAX_NUM_LANES];
...
}

and MAX_NUM_LANES is 4.

And from Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml

patternProperties:
  '^phy@[0-3]$':
    type: object
    description:
      Each group of PHY lanes with a single master lane should be represented as a sub-node.

Which means it can have upto 4 phy nodes with different protocols.

> mandates that the device-tree sub-nodes expressing the configuration should
> describe links with at-most two different protocols.
> 
> The existing implementation however imposes an artificial constraint that
> allows only two links (device-tree sub-nodes). As long as at-most two
> protocols are chosen, using more than two links to describe them in an
> alternating configuration is still a valid configuration of the Torrent
> SERDES.
> 
> A 3-Link 2-Protocol configuration of the 4-Lane SERDES can be:
> Lane 0 => Protocol 1 => Link 1
> Lane 1 => Protocol 1 => Link 1
> Lane 2 => Protocol 2 => Link 2
> Lane 3 => Protocol 1 => Link 3
> 
> A 4-Link 2-Protocol configuration of the 4-Lane SERDES can be:
> Lane 0 => Protocol 1 => Link 1
> Lane 1 => Protocol 2 => Link 2
> Lane 2 => Protocol 1 => Link 3
> Lane 3 => Protocol 2 => Link 4
> 

Could you please give an example of device tree where existing implementation
doesn't work for you.

> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on linux-next tagged next-20240710.
> Patch has been sanity tested and tested for functionality in the following
> configurations with the Torrent SERDES0 on J7200-EVM:
> 1. PCIe (Lanes 0 and 1) + QSGMII (Lane 2)
>    => 2 protocols, 2 links
> 2. PCIe (Lane0 as 1 Link) + PCIe (Lane 1 as 1 Link)
>    => 1 protocol, 2 links
> 3. PCIe (Lanes 0 and 1) + QSGMII (Lane 2) + PCIe (Lane 3)
>    => 2 protocols, 3 links
> 
> v1:
> https://lore.kernel.org/r/20240709120703.2716397-1-s-vadapalli@ti.com/
> Changes since v1:
> - A multilink configuration doesn't necessarily imply two protocols
>   since a single protocol may be split across links as follows:
>   Lane 0 => Protocol 1
>   Lane 1 => Unused
>   Lane 2 => Protocol 1
>   Lane 3 => Unused
>   which corresponds to two links and therefore two sub-nodes. In such a
>   case, treat it as two single-link configurations performed sequentially
>   which happens to be the case prior to this patch. To address this,
>   handle the case where cdns_torrent_phy_configure_multilink() can be
>   invoked for a single protocol with multiple sub-nodes (links) by
>   erroring out only when the number of protocols is strictly greater
>   than two, followed by handling the configuration similar to how it was
>   done prior to this patch.

-- 
cheers,
-roger

