Return-Path: <linux-kernel+bounces-350231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE399901D1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71BD0283B21
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBBF157A55;
	Fri,  4 Oct 2024 11:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fvoXmcew"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66403156C5E;
	Fri,  4 Oct 2024 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728040137; cv=none; b=msj0sMJoHjlltw8IhOwsbogbFplYfGYTOESaSt/7F/XeBaYrduPOZMmxMAhUibC0Plc+P5aPFeHykq2p4pebVn67Wg40ANWkAghBGcTS8rIfK5lAwmGdZaKv/U6lvFMnN5Y6ANAu5totIkurJD/2NWG++1Tpy/XvqFasyLZW2RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728040137; c=relaxed/simple;
	bh=7rAw765mVqpfGMDlakPXuedrwOSDBmggj4LOKJK75wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rBpMwXIQtG9J+tr3l9SuWFPFfTfsjGN6iCNe4VZdIR1t9+9X/1fCynlKJgejMaaHi7LTAsrOhSQTa6/CFwo8UAYXFAPpHTU4QHHpeBlY7uIH8L1WuPj5Z3ttm5imZs+mVzKa6NhYIG4+cEQxRRL21Fs/UMDCfMbLynHedHAEAFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fvoXmcew; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 085499c8824111ef8b96093e013ec31c-20241004
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=Rg57b2C8DB3sjeiJUSQURXizNpt/OycVgwR/X0Z5Pt4=;
	b=fvoXmcewBUYl/9P/erl4TFyRotvP8gssBISM6N4a8s1EcsUYF2JrIVUQKc/vzqyOUxvwEHukJZO4jszPt2UXhDKmHhZQJSH7KimWerq4ndYQTpL+Vk0ZC2oUy2YfHmm1V5aBBiJAtDNDOQTIRv+E42JqnR/Khhf5xnhm8P+AkcA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:457c511d-21cd-4134-92a2-be47e2a32547,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:1c55c140-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 085499c8824111ef8b96093e013ec31c-20241004
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <pablo.sun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1682741167; Fri, 04 Oct 2024 19:08:49 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 4 Oct 2024 19:08:48 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 4 Oct 2024 19:08:48 +0800
Message-ID: <0aa5a003-46d5-4dc7-c720-c847cae95f65@mediatek.com>
Date: Fri, 4 Oct 2024 19:08:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 3/6] dt-bindings: nvmem: mediatek: efuse: Reuse
 mt8186-efuse in mt8188
Content-Language: en-US
To: Rob Herring <robh@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Krzysztof Kozlowski
	<krzk@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
References: <20241002022138.29241-1-pablo.sun@mediatek.com>
 <20241002022138.29241-4-pablo.sun@mediatek.com>
 <mh7upw2y2dclyosved3chw7chpqgdg4a3j5ftwftfhm6v5uqpt@cotoeuopfbqg>
 <559fc2a5-631c-440a-812f-2907f84b16b4@collabora.com>
 <20241002211130.GA1316112-robh@kernel.org>
From: Pablo Sun <pablo.sun@mediatek.com>
In-Reply-To: <20241002211130.GA1316112-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rob, Angelo, and Krzysztof,

Thanks for the thoughtful review, I'd like to follow-up on
Rob's comment:

On 10/3/24 05:11, Rob Herring wrote:
[snip]
> > > diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> > > index 32b8c1eb4e80..70815a3329bf 100644
> > > --- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> > > +++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> > > @@ -39,6 +39,10 @@ properties:
> > >                 - mediatek,mt8195-efuse
> > >                 - mediatek,mt8516-efuse
> > >             - const: mediatek,efuse
> > > +      - items:
> > > +          - enum:
> > > +              - mediatek,mt8188-efuse
> > > +          - const: mediatek,mt8186-efuse
[snip]
> 
> What about all the other efuses? The fallback needs to be a subset of
> the 1st compatible.
[snip]
> 
> No, but any fallback seems seems a bit odd here. It's one of those
> things that's going to change with every chip.

I think you all agree that the common fallback "mediatek,efuse" should
not longer be used, and such deprecation should be commented both commit
message and the YAML, same as "rockchip,rockchip-efuse" in rockchip-efuse.yaml.

But, Rob has mentioned that I should only define a fallback
if and only if mediatek,mt8186-efuse is a **subset** of mediatek,mt8188-efuse.

It is true that I can merely confirm that they share the same "GPU speed bin"
efuse bit definition and conversion routines.

At this moment I cannot confirm:

- mt8188 has every efuse cells mt8186 defined.
- Every mt8188 efuse cells values must be interpreted the same as mt8186.

So, I don't think mt8186-efuse is a subset of mt8188-efuse in this sense.

Do you think it would be better that we re-use this GPU speed bin conversion
in the eFuse driver implementation, rather than reuse it in the dt-binding?

This is also what Angelo suggested initially for v2 modification.

Many thanks,
Pablo

