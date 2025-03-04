Return-Path: <linux-kernel+bounces-543380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E03F9A4D4E2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0451890AFB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FDE1F76C2;
	Tue,  4 Mar 2025 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgot1MhF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA39BAD24;
	Tue,  4 Mar 2025 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741073756; cv=none; b=nUoQoWB6AZ4rNUczs9viDBCZZRYrnQ+6LoTqbiTORrXo7yBkWKmoKPQkqGNsLYbdK0yIM+P6JN4m/0Ns6twncaLF2vryUsRSA09IAle5JkGSn9sx9svkIo/Fgj7+llVTqPZDUNxgNmMT3DTakCqK0c6oCqVZjlPW0RknBm0IEu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741073756; c=relaxed/simple;
	bh=Vt14l9x1ynHXlzYwcGCpTZXEItD0wcqiGeVk9WPAuMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWIbH+/M6/JE6WhI91c5CDe/7IaJc+kpeJqgPJTpKznBd2AV0L+VW/jxxzQH5ClXFsiXPsYQk2EZJAox/FVYmkDbz+cixDQODr3lns1IEHPr6b8El6I9XqBprPhUOZTe64Akq1nRC7muC5ajZCFJp3QIo6CA1Tf9fNeqL2OZg24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgot1MhF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B243C4CEE5;
	Tue,  4 Mar 2025 07:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741073756;
	bh=Vt14l9x1ynHXlzYwcGCpTZXEItD0wcqiGeVk9WPAuMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lgot1MhF4OaA2vFC5slzJpCRF3ny1IzyKoAdOZgkun6IDVUpcN4CLnLp94l+utSIP
	 mMTZQuWmefu1UYA2XIKrF/fuuoHsXPHnoY0wuariH2pZEXUUF08y0RFJEUC7iojkHm
	 hGdusOMZJ2jDchmGw25+tPIFGRzBrHit2lzkKuj2/osHHRS/NbE+8DlpZ1GOY4eljz
	 ObRG+kq+phNRsQmMk75Z0jQmmL60a1NrKgzY/vjYAg3jemU0XLxFie3fIWQQSrWQFD
	 s2XHli1sSFjKm2b8Omlq4JYBKel2uPdyg3SvjaaR26vdzw9rhvmG65/Zp1BRZuNtEd
	 /EeKgIGHJwNNw==
Date: Tue, 4 Mar 2025 08:35:52 +0100
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
Subject: Re: [PATCH v2 1/7] dt-bindings: clock: brcm,kona-ccu: Add BCM21664
 bus clocks
Message-ID: <20250304-squid-of-exotic-variation-f5b19d@krzk-bin>
References: <20250303-kona-bus-clock-v2-0-a363c6a6b798@gmail.com>
 <20250303-kona-bus-clock-v2-1-a363c6a6b798@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250303-kona-bus-clock-v2-1-a363c6a6b798@gmail.com>

On Mon, Mar 03, 2025 at 09:27:49PM +0100, Artur Weber wrote:
> diff --git a/include/dt-bindings/clock/bcm21664.h b/include/dt-bindings/clock/bcm21664.h
> index 7c7492742f3d4ca439236f2f352e432989409570..8d3e3796c72b02eace84dfb90d6264dee0297a33 100644
> --- a/include/dt-bindings/clock/bcm21664.h
> +++ b/include/dt-bindings/clock/bcm21664.h
> @@ -26,7 +26,8 @@
>  /* aon CCU clock ids */
>  
>  #define BCM21664_AON_CCU_HUB_TIMER		0
> -#define BCM21664_AON_CCU_CLOCK_COUNT		1

Same comment as other patch - this cannot change or it is not an ABI.

Best regards,
Krzysztof


