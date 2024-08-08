Return-Path: <linux-kernel+bounces-278966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EDA94B73E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0ED1F243A9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EDC189B80;
	Thu,  8 Aug 2024 07:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="en55UcgE"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBF5187FE2;
	Thu,  8 Aug 2024 07:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101109; cv=none; b=j1VMEH+fQfqKpX270o4R9eiB/an9g8en9dsYana/LH1AAXc1KoPNleC40jzShDesQCPph8dGzfif4TeWFWDGp7OGKuPcFz71q6WTZkYjxJ+Gbxh/b1n0s8JSTm5uDEPbqseZVjnvD+Id9WYbRf1bu8ewgsjnhZ59V/9s4xB8CjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101109; c=relaxed/simple;
	bh=+G//lIJY2ftDNlmLTfy1gSkQLE1FJOZgoyHxi4nd1+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MtIFM91cPh1F2A2eAk7obShlz7R3XQJW2ltmHYXOrTmEoG5+DCFsLdvN0ntq+6vjXkBKLPOKN2PqSfNIUs63lJsxMVoDnjZQl7mLG28Fdzg1NRzzmTEmhlfo1xSXd51S6vCt2oKptCZswb6iP+J9oAHwBNPkrejgp3yZOOvwlJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=en55UcgE; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 714b46ca555511ef87684b57767b52b1-20240808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=xdjGRG2C3LvwOmsYFPcbKW0yZATvTyH5hadq862NARw=;
	b=en55UcgEYe67+HJhZGknMwJ7B/ZVdzVutesKo88wdkeFNKvLH0xyGvYAFePnW2qERoyjxd/gAlNiOCIBWMoiOXAnwhR4/ngvnSbg9i8k/cToJ641NKENgSFujrVbkcT2eARsk6tNzFr1YripyIJBzhcyg/vR8nsLawYLye9ZAHE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:b7afbebf-790e-412b-9ad5-413e88fa70b3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:3193e93d-6aa5-4057-84d5-0e7d47251781,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 714b46ca555511ef87684b57767b52b1-20240808
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1925627340; Thu, 08 Aug 2024 15:11:33 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 8 Aug 2024 15:11:30 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Thu, 8 Aug 2024 15:11:28 +0800
Message-ID: <38933817-11f8-adc0-eb34-56a5602e37e6@mediatek.com>
Date: Thu, 8 Aug 2024 15:11:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] dt-bindings: regulator: mediatek,mt6397-regulator:
 convert to YAML
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
CC: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bear Wang
	<bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin
	<macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>, Jason-ch Chen
	<Jason-ch.Chen@mediatek.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>, "Chen-Yu
 Tsai" <wenst@chromium.org>
References: <20240807091738.18387-1-macpaul.lin@mediatek.com>
 <ZrPvb_bT2ty-1V6-@finisterre.sirena.org.uk>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <ZrPvb_bT2ty-1V6-@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.500900-8.000000
X-TMASE-MatchedRID: pBwXUM+nCwsOwH4pD14DsPHkpkyUphL9IfyQNHR2naa1eX0jEQ9c6qnq
	WHYEB3G4sgbiBx9i+zIl5NT9XNABgo8sb4DSq8SmxMb7Gw3AjrorHkgIan9a0WlIYy/8U7rao8W
	MkQWv6iUD0yuKrQIMCCAtDqHg/4Qm0C1sQRfQzEHEQdG7H66TyJ8TMnmE+d0ZTZXFr1g0J/nt1y
	Rzd18hTqqUu5UWWPJiARCUAVRFOzfSVIuyXKG3Xhp+dmWg9hpR+oE+9VrjUxFu60CZVSXrDcsC6
	++T8K1Grwc1Nq3cgvQxf1lrcMPVQHZOlaHNG3zLys274HLLVzNWXGvUUmKP2w==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.500900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	20AB1ECA636973C2693942798CA415BEA7C19413E8836D5F4D0319E89DA80F5B2000:8

On 8/8/24 06:04, Mark Brown wrote:
> On Wed, Aug 07, 2024 at 05:17:38PM +0800, Macpaul Lin wrote:
>> Convert the MediaTek MT6397 regulator bindings to DT schema.
> 
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

Thanks for the reminding,
will keep in mind and take recent patches for reference when converting 
next dt-bindings.

Thanks
Macpaul Lin

