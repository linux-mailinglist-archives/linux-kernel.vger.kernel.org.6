Return-Path: <linux-kernel+bounces-367570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8A19A03EF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC502882CC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761F01D2215;
	Wed, 16 Oct 2024 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ssKkyGMl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1145B641;
	Wed, 16 Oct 2024 08:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066565; cv=none; b=H/p3N9s9WK23b30kdTBjnBpy9W+tMhVeEJHBY/Re/BtzursKVOmf1Dz7tStW5ytjgoipdA/MxaoBJMc1oSVaI0gREBAcN/em9QenIHqRxeZ27ffDd8IwSBoxzkkyQQ4xp+tHjmrQ2lQMA5DJlifYHrXGp44dHEOvLW7hmIhtIpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066565; c=relaxed/simple;
	bh=4cwRglCfSwKWUPFuQauJNH5MERyf+7IWbMf6rK6p+bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDldV9yUacFubPp57Zm0RBywFjwCrmRTjxEXKyrElpEhPsnuEEA5QAL7dkqLvGyWayDc8wwZPjT+MxlRqqabYVE9ndIQlUmOV5GpaTUeBQHx5MeuYd7tr/jCkhYjCWiyD+hizMuWzLslng8ZCPCj5a0gqJ+vSWzGChjw5Zrx13c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ssKkyGMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94685C4CEC5;
	Wed, 16 Oct 2024 08:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729066565;
	bh=4cwRglCfSwKWUPFuQauJNH5MERyf+7IWbMf6rK6p+bM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ssKkyGMl4x0o+VVjFYrx1SoDh6CLbjBUqvAxcpnbwGI4gqBtQG0UiSxo91VJuJPzJ
	 wHAh22v6u37EB76rz/gJboYhJM7NKCN4A4MzjBXZKr2/szfeJLonvAbnF8hkm85at6
	 SKt8I5KiDz0Q/yqvskqMOq54NakzcE3joNupGKmY=
Date: Wed, 16 Oct 2024 10:16:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joy Chakraborty <joychakr@google.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: dwc3: Program USB Gen2 De-emphasis defined in
 PIPE4 spec
Message-ID: <2024101635-clergyman-dyslexia-9c75@gregkh>
References: <20241007135508.3143756-1-joychakr@google.com>
 <20241007135508.3143756-5-joychakr@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007135508.3143756-5-joychakr@google.com>

On Mon, Oct 07, 2024 at 01:55:08PM +0000, Joy Chakraborty wrote:
> Set 18bit TxDeemph[17:0] in LCSR_TX_DEEMPH(n) register for USB3 Gen2
> Normal Operation as defined in PIPE4 spec based on dt quirk
> "snps,tx_gen2_de_emphasis_quirk" and "snps,tx_gen2_de_emphasis".
> 
> Signed-off-by: Joy Chakraborty <joychakr@google.com>
> ---
>  drivers/usb/dwc3/core.c | 13 +++++++++++++
>  drivers/usb/dwc3/core.h |  6 ++++++
>  2 files changed, 19 insertions(+)

Any reason why we got 2 copies of all of these in the same series?
Please fix that up for when you send a v2 of them.

thanks,

greg k-h

