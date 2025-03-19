Return-Path: <linux-kernel+bounces-567503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA5FA68712
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F486420FAC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FAA251786;
	Wed, 19 Mar 2025 08:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgDISaV4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D843615A85A;
	Wed, 19 Mar 2025 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742373593; cv=none; b=YRwKJVvL17Ve+GXwbfsV+JH1IZrODy6dKBHXQuZ5zkcoNP8ZO6JQiOX0/6WSXlT3j4Qx44OqhzYj1WFnhZC/1IsqqjEDF1NxkbhEX6YjhB+T/ZqCGWSMNEpllpJ6Tu8GGf8UCK/A20NRkK9OyWKVeYOCfVVzaQkSAcZReqJbHS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742373593; c=relaxed/simple;
	bh=gr9n+K/DMQiaNIfWEJjpc4Rm/fdyAPYWwEfd3TplAWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMuqS6NXQkbDhUm+gGPB9DDx79mOw7wqpg9Iaxlsb5ngx47wKgHBrObeakIomDiPzwCHRykHNZkdZPQu4NRpcISR5teUjMgW4gCfRr8n3d9HTJ6REwJ4cqLeYSF0PMA5d/TIv5j6pVL1VSyevj8p/mLePeWtcGOJyAH2Lv6Joio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgDISaV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68160C4CEE9;
	Wed, 19 Mar 2025 08:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742373592;
	bh=gr9n+K/DMQiaNIfWEJjpc4Rm/fdyAPYWwEfd3TplAWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FgDISaV4Ij5Oy0XOmSduT+ZeUJa7iw4Wf+JWqHoJQpp5Bv1TD742urZPit29yGzBN
	 07SeEzlEoo2uoVYtzwtj/gnAaen/SiRwVmtqkiyd+4t69tqDnaxpYTenoiQn7gvEkF
	 fDsnHafZHtQbSaS7DPWqxY4PGVszAiUgXVqByDI5/qayAqy4QJI/PaDbJYWdGY/orR
	 PmY1OiHUeH6g8iq0R6XHHg9V8An8N9dKJMs6MuvBkz+51TWHIUjx8XmX2WzLTTzqbF
	 oLN1WU3H+r/5y4edS+/epG3Bq3BwDllScbINC8ID3ukD9ozX8QHQzBAIGSkfs/uxI8
	 y8ZtT2BKe1PBA==
Date: Wed, 19 Mar 2025 09:39:48 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Artur Weber <aweber.kernel@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alex Elder <elder@kernel.org>, Stanislav Jakubek <stano.jakubek@gmail.com>, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v4 3/8] dt-bindings: clock: brcm,kona-ccu: Add BCM21664
 and BCM281xx bus clocks
Message-ID: <20250319-dazzling-industrious-gharial-db45a3@krzk-bin>
References: <20250318-kona-bus-clock-v4-0-f54416e8328f@gmail.com>
 <20250318-kona-bus-clock-v4-3-f54416e8328f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318-kona-bus-clock-v4-3-f54416e8328f@gmail.com>

On Tue, Mar 18, 2025 at 09:13:25AM +0100, Artur Weber wrote:
> Add bus clocks corresponding to peripheral clocks currently supported
> by the BCM21664 and BCM281xx clock drivers and add the relevant clock
> IDs to the dt-bindings headers (bcm21664.h, bcm281xx.h).
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> Changes in v4:
> - Squash BCM21664 and BCM281xx bus clock bindings commits
> ---
>  .../devicetree/bindings/clock/brcm,kona-ccu.yaml   | 49 ++++++++++++++++++++--
>  include/dt-bindings/clock/bcm21664.h               | 13 ++++++
>  include/dt-bindings/clock/bcm281xx.h               | 19 +++++++++
>  3 files changed, 78 insertions(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


