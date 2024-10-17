Return-Path: <linux-kernel+bounces-370071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EBA9A26F1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A6D1C23444
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC1B1DEFF3;
	Thu, 17 Oct 2024 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZVYgJ2J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF071DEFE5;
	Thu, 17 Oct 2024 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179368; cv=none; b=KvrckyWqnLYm7+LbhlNOnm4VJpm7zBMR71iObEj6QvlmnAAjj0pXhzfXEL9EwTdQnJYtwV75Qrap6liJwueWSkJNUkYUAWdhdVzXiFoB2jC4bPq6MBF5U9Uls23zYgB7o1Wu55DPzPzFRRNaWazRKhN73+3KDJGh8L5uf6ixHxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179368; c=relaxed/simple;
	bh=0r0JjnkkjqSE3jNgXwiFfV5tkiZFhPe4hiVJEamy0fA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ESl3zkXgenS0CaXLiO2Dk3I8042T75C6hB9Dif82hhsqQ3SqlpdSKxvkGC+qSG7Xwipx+7cLq8P/bzYo16Zpihy1uRw9AGQbcjt3zptPzHzKJGOoe7WA1Id/6GBKTX98BrrM0oyCOOdr7kHoUbc88+/Gr9KLNWUePuw27a9U9Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZVYgJ2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC5CC4CEC7;
	Thu, 17 Oct 2024 15:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729179367;
	bh=0r0JjnkkjqSE3jNgXwiFfV5tkiZFhPe4hiVJEamy0fA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sZVYgJ2J5a0gA6RIyL4Yvbt9ouXNMdspscC7MUdDEmKFY3iJFg6AJ7J4ZkKphTPVn
	 Zjs7ZS30LO58nKjNB7qjkuuJNp9WbvRDcBR6pjaalJzdgJAeI1n9BmRuzFzfj0nC2O
	 WHtkfKreWXzg4BSNjLezKCifxYQ0Kw3rdWyggSAEZ28JPFkUU7uiY2z3valjvBct46
	 nSFeMC5HyScWkPYCytouRLKYiKEVDMXHB9zO4kabMU1yWekDOqxVAR2XqPu6TkIoYi
	 0+ejBlf1gxjAcuMNsdEaG5Bt9vQuLsquZl1ve5n5cArMdOiSPIH1wvn82OElNTE4vY
	 oQhFG4m0nxCNg==
From: Vinod Koul <vkoul@kernel.org>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, 
 Macpaul Lin <macpaul@gmail.com>, 
 Project_Global_Chrome_Upstream_Group@mediatek.com
In-Reply-To: <20241012035016.17667-1-macpaul.lin@mediatek.com>
References: <20241012035016.17667-1-macpaul.lin@mediatek.com>
Subject: Re: [PATCH v3] dt-bindings: phy: mediatek: tphy: add a property
 for power-domains
Message-Id: <172917936283.288841.9548294790735623997.b4-ty@kernel.org>
Date: Thu, 17 Oct 2024 21:06:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 12 Oct 2024 11:50:16 +0800, Macpaul Lin wrote:
> Include the MediaTek TPHY in a power domain.  Add the 'power-domains'
> property in the Device Tree (DT) Schema and set 'maxItems: 1'.
> 
> Also, include a reminder in the description of the 'power-domains'
> property.
> 
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: phy: mediatek: tphy: add a property for power-domains
      commit: 2ac03d0811b94c2397d5ec3c82a65a112aeab5b0

Best regards,
-- 
~Vinod



