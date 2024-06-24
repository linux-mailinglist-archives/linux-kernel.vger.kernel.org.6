Return-Path: <linux-kernel+bounces-227918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E94E915814
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B04289446
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811E21A070D;
	Mon, 24 Jun 2024 20:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioCSjRgP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40981A0701;
	Mon, 24 Jun 2024 20:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261280; cv=none; b=cBdDTDgGfTaID1sUGKI6xextl1prL+zvjsaDOkb2VmAaLUfcwlqAlaZx9bC1sbhgzESSufafK3YOyXFNhEON3hqv92D+stbzOgWZMlMWt7S6VJxmpFq2of41uXtJcGZK5lm/bSEfDqKbFcLiYpamedM+OWgnmZxatk9NHZbQSew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261280; c=relaxed/simple;
	bh=fnYnt1cm4H5OJFjouGeyQRwAXFsct3WiYlfwxAclM7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5I3CnTHxYwIvp5sVM/OdrC8c7kItt/OWnKoR7NCMBdYXYEgLUNcTQTnADc+3VO1wTkmg6sFJGTS5hjxyY7hpab26x7IuZF3SEK6zK8xUIasU/f+/GZyk95F0NJ2TwWNcOcMl3ljTtlsLKRxGeHZ6RyjerrhHXV62FK9xNy4pqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioCSjRgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0985FC2BBFC;
	Mon, 24 Jun 2024 20:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719261280;
	bh=fnYnt1cm4H5OJFjouGeyQRwAXFsct3WiYlfwxAclM7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ioCSjRgPVmkWKAYfMEnQcKe2/Nw1+gJNjjLMabDjfApiT5h25BtImV/0c+b2S74sk
	 oGZKI2CPMFm9e7d+xNuB1iQlMlvxZg5gbQWchcAwiZBwh9ix7+Yz0PC2SCCbF7T/CR
	 DSTk8ZYyI3v6h27WbV3p6FkqkoJz59JF72kem1iGXRY6e9CnUAQfSPK1qedsunc/j0
	 pZUjufoWbx/gWXDcl8nqogJAgkW/ibbVxYU5mmNJBvz79ZrPmw+EX/i9sKH6tr9UUc
	 ARldhrSFACNmx0YyJ8Ka+UlDGMwu9AUJCJh8wjjafgADmQaqViA6Sdp74krJhShOHy
	 6sqlgIdo+tGMA==
Date: Mon, 24 Jun 2024 14:34:38 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Orson Zhai <orsonzhai@gmail.com>, linux-arm-kernel@lists.infradead.org,
	Lee Jones <lee@kernel.org>, Nishanth Menon <nm@ti.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Jacky Huang <ychuang3@nuvoton.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 3/7] dt-bindings: soc: intel: lgm-syscon: Move to
 dedicated schema
Message-ID: <171926127659.368668.12236897236768555715.robh@kernel.org>
References: <20240616-dt-bindings-mfd-syscon-split-v2-0-571b5850174a@linaro.org>
 <20240616-dt-bindings-mfd-syscon-split-v2-3-571b5850174a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616-dt-bindings-mfd-syscon-split-v2-3-571b5850174a@linaro.org>


On Sun, 16 Jun 2024 15:19:23 +0200, Krzysztof Kozlowski wrote:
> intel,lgm-syscon is not a simple syscon device - it has children - thus
> it should be fully documented in its own binding.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Context might depend on patch in Lee's MFD tree:
> https://lore.kernel.org/all/171828959006.2643902.8308227314531523435.b4-ty@kernel.org/
> and also further patches here depend on this one.
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml  |  1 -
>  .../bindings/soc/intel/intel,lgm-syscon.yaml       | 56 ++++++++++++++++++++++
>  2 files changed, 56 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


