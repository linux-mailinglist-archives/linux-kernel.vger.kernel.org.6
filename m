Return-Path: <linux-kernel+bounces-354339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7468C993C28
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A03B1F241D0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 01:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B64F9EC;
	Tue,  8 Oct 2024 01:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="g4pGe95A"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAE329A5
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 01:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728350521; cv=none; b=scEF20Hcw7s8RvcVNGTTD6IcZ7BD8+gExcPdAuKBZYu9duLoO7xpQTtNVIIo6MF+hY4i8w3DulXLvZC8p/e+pptiizZUnqTIxLZZZXX3pkOo7AeyWQwP/bKl9OqCytJDNJaIIGe52t5/ymnmM/0DwkR1bFjgTpoOEZXsGbNLBXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728350521; c=relaxed/simple;
	bh=vmlBgpMmaRdobg5QAbPB5ZkP8D4L0nTY7n9EoGLQJg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RVHOVgW2g5vfHDeN6DKQEobAOXxeuHFQqEhpvxAXm9YqkK1ywYM5BBILrTHc99tMYJ61jI73qJp+cbJs8YocdSwFKvtKNmoOp0Mzppd8Pq3ZCL5FUt/NCbt2d7Mnv1FLOJJO0u8T6sp0gyGMz238dcw4wpDhDBkrDAHD3JJ4aYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=g4pGe95A; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b319e9ba851311ef88ecadb115cee93b-20241008
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=PMRavPU31cBGTn/6HZlIp9pt4S49zJD0Tjvymm+53a4=;
	b=g4pGe95A85+Wr1OcuOuyguVg0MSW6h5ov6HLFF6vIm2skIxalVGzRbfk7bQ8PKaoBGG5P6INDNKyoHfAh4rAby3cE2hHq5TTpjRz21G3UQfrJs0TXtDg0CW3vPaphTW325SeovCT00KOWhVKhmdf/igySrv30ttNq7nBqLeL9vc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:8d3c1c96-0212-4030-81b2-b42d3e1be38c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:c189e464-444a-4b47-a99a-591ade3b04b2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b319e9ba851311ef88ecadb115cee93b-20241008
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 108352282; Tue, 08 Oct 2024 09:21:52 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 7 Oct 2024 18:21:51 -0700
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Tue, 8 Oct 2024 09:21:51 +0800
Message-ID: <f5b027b7-7490-3f96-66a7-ff6513ba8309@mediatek.com>
Date: Tue, 8 Oct 2024 09:21:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] soc: mediatek: pwrap: add pwrap driver for MT8188 SoC
Content-Language: en-US
To: Fei Shao <fshao@chromium.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Alexandre Mergnat <amergnat@baylibre.com>, Bear Wang
	<bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin
	<macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>, Chris-qj chen
	<chris-qj.chen@mediatek.com>, MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
References: <20241007024350.7878-1-macpaul.lin@mediatek.com>
 <381fcbfa-edfb-46c8-8ee2-1386af2ba4c4@collabora.com>
 <CAC=S1nj-hpt9CS1+_Jt8C710KDz1uYTcTS5qGqSZT9qmmVm7Yg@mail.gmail.com>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <CAC=S1nj-hpt9CS1+_Jt8C710KDz1uYTcTS5qGqSZT9qmmVm7Yg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit



On 10/7/24 23:23, Fei Shao wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> On Mon, Oct 7, 2024 at 10:55 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 07/10/24 04:43, Macpaul Lin ha scritto:
>> > MT8188 are highly integrated SoC and use PMIC_MT6359 for
>> > power management. This patch adds pwrap master driver to
>> > access PMIC_MT6359.
>> >
>> > Signed-off-by: Sen Chu <sen.chu@mediatek.com>
>> > Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>>
>> Actually, MT8188 and MT8195's pwrap registers and code flow are exactly the same:
>> since they are, we don't need this commit (or we don't need it right now!), and
>> we can just update the binding so that we can declare...
>>
>> compatible = "mediatek,mt8188-pwrap", "mediatek,mt8195-pwrap", "syscon";
>>
>> ...hence this driver doesn't get any commit :-)
> 
> ... which is already the case. :)
> See commit 040c3303f110 ("dt-bindings: soc: mediatek: pwrap: Modify
> compatible for MT8188").
> And the device tree is set as well, so it's all good for MT8188 I believe.
> 
> Cheers,
> Fei
> 

Oh. Thank you for the reminder and point out the related commits.
Then this patch could be dropped.

Thanks!
Macpaul Lin

