Return-Path: <linux-kernel+bounces-553695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A826A58DA4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48095164405
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC617223308;
	Mon, 10 Mar 2025 08:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnHMKZDx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074F884E1C;
	Mon, 10 Mar 2025 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741593968; cv=none; b=gdlSq/HoxCHoLTgnbBL1FYSIp04iDI7AuVbgnL1np/tWvO8EU9vqdN1deTqaCrsVN+VBErxo9CfuP4jMndCe4iy26I2hZYd7fY1VuKviLyGqnfEmFwzKl36hkv3bhIzwoZWMK32oZedDyjBt2YVfBKt3JaiFVWRP+VUg4hQSbm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741593968; c=relaxed/simple;
	bh=JdNOUETRN7NU7vKZ0Jb69tYZgdK4LacoJaUSmjraB+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/gfdncSY4A0PZvJJs0edqXI1A7WN44eqEe0OHh1UYV5v84AF0hDPcDMTBJj4pKpn72GmKcXtW7a4APJyWwbuZr6q+7EYlFyC/rD+Als0WRRV6oddS3oG72Q6tJ80CdCLySkYlRpP0zwdr1Qm4ItBJfDIBu5t0mawr1Srzt+IW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnHMKZDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EC3C4CEE5;
	Mon, 10 Mar 2025 08:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741593967;
	bh=JdNOUETRN7NU7vKZ0Jb69tYZgdK4LacoJaUSmjraB+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NnHMKZDxPk/JEEVnZ14bMVuOE4AMHF+4LK37P9FMw9W5DYYzqRIVR19INgh4GXPz7
	 pl2DKchAu/sj2rtDAx13rXjZavd3cEB3GXA3LcZ+FeKdjQuPDFvb4QyfKfvEmPe7RT
	 pETZrXrtodQFN42DZfV84l68R7WFUrusLOwGG9hJ8oPc6qXPUGDEM8PeHYSEZcBo+i
	 y1QXKKIUXoqlk+E8MxSXmVLARLxeP865GnEm0pc/zd8b1V1GjcZJWn79go4cRzuLr0
	 k6o9F6DCiBSBV8S1iz/OzfRErEq/wuye+AAGVca4oW9p5A2mF+s+xZwSxOmQOGFbQ6
	 p/rBkUw7B3Y4w==
Date: Mon, 10 Mar 2025 09:06:04 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Danzberger <dd@embedd.com>, Arnd Bergmann <arnd@arndb.de>, 
	Linus Walleij <linus.walleij@linaro.org>, Nikita Shubin <nikita.shubin@maquefel.me>, 
	Guo Ren <guoren@kernel.org>, Yangyu Chen <cyy@cyyself.name>, 
	Ben Hutchings <ben@decadent.org.uk>, Felix Fietkau <nbd@nbd.name>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org, upstream@airoha.com
Subject: Re: [PATCH 06/13] dt-bindings: clock: airoha: make reg optional for
 Airoha EN7581
Message-ID: <20250310-pompous-elk-of-serendipity-cfebc9@krzk-bin>
References: <20250309132959.19045-1-ansuelsmth@gmail.com>
 <20250309132959.19045-7-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309132959.19045-7-ansuelsmth@gmail.com>

On Sun, Mar 09, 2025 at 02:29:37PM +0100, Christian Marangi wrote:
> The Airoha EN7581 clock-controller registers are placed in the SCU

I don't understand. The registers moved?

> (System Controller Unit). Now that additional pheriperals are supported
> for the SCU, a dedicated SCU node is created and the clock-controller is
> moved as a child of such node hence the register property is taken from
> the parent node.
> 
> To support this, make the reg property optional and provide an
> additional example for this case.

No, post complete binding instead of adding some sort of stubs and then
later totally reworking them to match different Linux drivers.

Best regards,
Krzysztof


