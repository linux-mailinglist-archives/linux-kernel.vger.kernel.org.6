Return-Path: <linux-kernel+bounces-556001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EA4A5BF76
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C163B35AC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC30E2571AE;
	Tue, 11 Mar 2025 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUXhwXQL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE1D254861;
	Tue, 11 Mar 2025 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693333; cv=none; b=mdodtUZgocFd0TZXWUWUix1xxskq/eUJuE3rKS7vADFKuHSh6YiZ7+HHIwQcmx9QByye1IYKtxQ9sWPhYMlGJ7Xat8Lgqop0IxYK27L7e1T5W7nN9uGFc/FoPry/EGMppFFGAbO/hy1wu+DvUuGY8O2wf4X7uF+LIVHCAB02Mdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693333; c=relaxed/simple;
	bh=0cT+g/6WFHRo97S8MzNd/drxoZXKifddanz+n4Uem64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D83IQBorCdey99LBtEgzsKLMgQqYzkUioOUSVfKOzE35B+SlLJRaxzFGshumYIcVjd99kKlRUyF90LlWRihOjx6R7zTMdJTheQjRTVVPYBKWfw9QXsyqgXZdc3kzz4kUtaYmL10ZB3h9YmS1yxkLGtqd5Je6nZRIufCUgrRS13A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUXhwXQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE5DC4CEEB;
	Tue, 11 Mar 2025 11:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741693332;
	bh=0cT+g/6WFHRo97S8MzNd/drxoZXKifddanz+n4Uem64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gUXhwXQLYpC885YJdW2TRx7RUjZm5rSn13EHYURan6o2jQC3pgD+e2hKRnYvENUev
	 IoPstSAUq6ZbXhledQeIrrlmuOGplzdFM1g8h52AMbNS2RN6NK66yvHRSlMg8wX8FO
	 FCPl/kZqLxUF+z1+oPfxJRZo6aRMd0lLFbbrHDqeWeBS5jYgku6BK34y1E8ambTZfo
	 OM2Cy1Z5ZJ8VAZce1vPKhK2/JbXCBZPNeoLJQJ2V7+WW2ethWoFp5rqjolTGskUcSm
	 TQOzVOGlkbYV9Ho9jsztzeW4fkWX8mLb5QS4yKdedn86e7qDzpe615WK+R8unxCa1d
	 RsALeUlcGrUBA==
Date: Tue, 11 Mar 2025 12:42:08 +0100
From: Vinod Koul <vkoul@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Danzberger <dd@embedd.com>, Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Guo Ren <guoren@kernel.org>, Yangyu Chen <cyy@cyyself.name>,
	Ben Hutchings <ben@decadent.org.uk>, Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org, linux-mediatek@lists.infradead.org,
	linux-usb@vger.kernel.org, upstream@airoha.com
Subject: Re: [PATCH 10/13] phy: airoha: Add support for Airoha AN7581 USB PHY
Message-ID: <Z9AhkByegWQgC9YE@vaman>
References: <20250309132959.19045-1-ansuelsmth@gmail.com>
 <20250309132959.19045-11-ansuelsmth@gmail.com>
 <Z9AhN9T8s1oogCUn@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9AhN9T8s1oogCUn@vaman>

On 11-03-25, 12:40, Vinod Koul wrote:
> On 09-03-25, 14:29, Christian Marangi wrote:
> > Add support for Airoha AN7581 USB PHY driver. AN7581 supports up to 2
> > USB port with USB 2.0 mode always supported and USB 3.0 mode available
> > only if the Serdes port is correctly configured for USB 3.0.
> > 
> > On xLate probe, the Serdes mode is validated and the driver return error
> > if the Serdes mode doesn't reflect the expected mode. This is required
> > as Serdes mode are controlled by the SCU SSR bits and can be either USB
> > 3.0 mode or HSGMII or PCIe 2. In such case USB 3.0 won't work.
> > 
> > If the USB 3.0 mode is not supported, the modes needs to be also
> > disabled in the xHCI node or the driver will report unsable clock and
> > fail probe.

Also I dont see phy depends on rest. Please split this and post phy bits
separately at least..

-- 
~Vinod

