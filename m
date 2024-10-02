Return-Path: <linux-kernel+bounces-347038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA5F98CCE8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3040928742E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 06:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3E4823DD;
	Wed,  2 Oct 2024 06:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1l4vKo+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBFB28F4;
	Wed,  2 Oct 2024 06:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727849069; cv=none; b=j5P13QGafBPMtvz64/gbQWVs7gHwuOCFMlytRLTG84yngorWRQaYiuO/+gQgUDNO/ZQ1zgCNgvhll7eMHdEFhpEJAYaxFUEY3lF3ZGOlCLaX6vEbKC5hrcXKvUkw/VyIZMh+lNogisbwRpqVmGjNELSA1SPNuyKxfZYmAEsCryY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727849069; c=relaxed/simple;
	bh=eRDH2gRHruASGT5jIjGwtC0n2ZkTL8neYpxlhmRvEhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mo7x/HYfngvkvDlbQX1iTjE6ter4js6ljD6pJOOCleLAWiELaa0jzOgyq6XzetapQ3FD4sAWzIbKtn0Cyx6tADwL1q0ES/67ZcFtf87tC8dqxj6tzlJmFaDREdI/A9bEkpQd+Lm68wMXxKPk3U5JSUojqhEmKxVW+2qefYqWQTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1l4vKo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B438C4CEC5;
	Wed,  2 Oct 2024 06:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727849069;
	bh=eRDH2gRHruASGT5jIjGwtC0n2ZkTL8neYpxlhmRvEhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o1l4vKo+R24aKUhtoK4RPWqg3hTdfs5DZ8QTcKArXPES9xZ/CMZxzDEIDZmGdtBN6
	 i4YrOt9UWjUMHOMl+Vc3xNYigCtDHmP6ZIqlrw2/KUTRP7g8iWO7MtU+NVW38eHma+
	 Hjo3/2okxFlyS6xpnivTf8T3Hp/fvqkFjo2y4tAMP39+z49ZYFyP9d0uY+PSSHe4LY
	 0J6j4mBx5kBwn3uvOpSX+B0VHnjPazoNR1M9X2CaYcLOSXAx4pgJlXxrAVTXUmJNK8
	 dk7SnCyAkfFVdwuLjcFeTM+cxgMgqVHULozvZp8tsLuCbMbPkdxiRP1E8qlIbxFtqs
	 S8cnpJhj1mNuA==
Date: Wed, 2 Oct 2024 08:04:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rohit Agarwal <rohiagar@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Alexandre Mergnat <amergnat@baylibre.com>, Bear Wang <bear.wang@mediatek.com>, 
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>, 
	Chris-qj chen <chris-qj.chen@mediatek.com>, 
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai <wenst@chromium.org>, 
	Jitao Shi <jitao.shi@mediatek.com>
Subject: Re: [PATCH v4 5/5] dt-bindings: display: mediatek: dpi: correct
 power-domains property
Message-ID: <idkorrjd5g2yjcnclks55pozf6rrv2w4fyhbwaaznvq5ngmcdm@vxpjh6q4visi>
References: <20240930083854.7267-1-macpaul.lin@mediatek.com>
 <20240930083854.7267-5-macpaul.lin@mediatek.com>
 <20241002015120.GA236278-robh@kernel.org>
 <7f212146-3dc7-9a0d-baf4-ac7a5b845060@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f212146-3dc7-9a0d-baf4-ac7a5b845060@mediatek.com>

On Wed, Oct 02, 2024 at 11:09:07AM +0800, Macpaul Lin wrote:
> 
> 
> On 10/2/24 09:51, Rob Herring wrote:
> > 	
> > 
> > External email : Please do not click links or open attachments until you
> > have verified the sender or the content.
> > 
> > On Mon, Sep 30, 2024 at 04:38:54PM +0800, Macpaul Lin wrote:
> > > The MediaTek DPI module is typically associated with one of the
> > > following multimedia power domains:
> > >  - POWER_DOMAIN_DISPLAY
> > >  - POWER_DOMAIN_VDOSYS
> > >  - POWER_DOMAIN_MM
> > > The specific power domain used varies depending on the SoC design.
> > > 
> > > These power domains are shared by multiple devices within the SoC.
> > > In most cases, these power domains are enabled by other devices.
> > > As a result, the DPI module of legacy SoCs often functions correctly
> > > even without explicit configuration.
> > > 
> > > It is recommended to explicitly add the appropriate power domain
> > > property to the DPI node in the device tree. Hence drop the
> > > compatible checking for specific SoCs.
> > > 
> > > Fixes: 5474d49b2f79 ("dt-bindings: display: mediatek: dpi: Add power domains")
> > > Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> > > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > > Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
> > > ---
> > >  .../display/mediatek/mediatek,dpi.yaml        | 24 ++++++++-----------
> > >  1 file changed, 10 insertions(+), 14 deletions(-)
> > 
> > You missed Krzysztof's R-by tag.
> > 
> 
> Oh, I just missed that reply for v3 in the mailbox
> and thought it still need to be reviewed.
> I just found Krzysztof's R-by tag in the mailbox right now.
> 
> I'll send an update for this patch set.
> Thanks for the reminder.

Plaese, instead just start using b4...

Best regards,
Krzysztof


