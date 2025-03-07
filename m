Return-Path: <linux-kernel+bounces-550533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CCBA560E3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D923B3AF867
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831AB19D081;
	Fri,  7 Mar 2025 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="hVUK7HEt";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="USo9iDYe"
Received: from bayard.4d2.org (bayard.4d2.org [155.254.16.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD993D6D;
	Fri,  7 Mar 2025 06:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.254.16.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741329069; cv=none; b=b0xGbXiFn6PegLPjZPov+/OeDK/S5//aC2D0Q5/E4j+tc2rAepGJd+62GHOPYInA1PwUgCr1qpvhDtSw2TLdlKJbi1ROg+z+JAikT63FrRAGSicJ/uZzS3E2WTf0qXMB8/FOr2Wx7/1INzZsMg/wYM6fVJO4ZeBaQMXBnENbKkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741329069; c=relaxed/simple;
	bh=QbIBN2cYPALHuwk835VmCHT20olGGIRk7Frt+363LtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTzKkozrZtRw458vwmNh8GZUE/sRmrQCnzgFZW0iZIeIFRAyqUK+BclZNjF97a39/9cVi1juxANh9Dq97yaU0wD2ZoB/MlwnUyuwM3NnUk3axGNG779BzU6K69m19NsnUodKIZ64QkrcFzGzVZcT1LAz9k5ZRThxTvnlqzc36jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=hVUK7HEt; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=USo9iDYe; arc=none smtp.client-ip=155.254.16.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from bayard.4d2.org (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id CAB9DEC59F6;
	Thu, 06 Mar 2025 22:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1741329066; bh=QbIBN2cYPALHuwk835VmCHT20olGGIRk7Frt+363LtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hVUK7HEtvyH9RopctGa+q2nO7DTlF9WKs9Unk0B/X3OxmZNCKihro9qCRi0I9YcnH
	 ITlNedSZ7jknmpMmXoQrI4ahi780ANE2CkTVnKTjhOa9TM6ODAk3gWRst++HUEzg24
	 S9VisYglRLgF5tC7OCH/0blS/kyt6tOo1TculZzVhLaDXRlRp1QMVrOfv5nmCbvjop
	 EHxdf7MNTnEBrVvE/UmpzYDRBolpzh0+27mwGw31eS8ARZDzWvIA57Cv67bkfgdAoE
	 qngjcZJhmbNTNqujtBug4O9cyIdFPxecDa2IjiY2Pd5mmkIzAvPBP2odjyFa21KvW7
	 7VQhHSadBkIyw==
X-Virus-Scanned: amavisd-new at 4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by bayard.4d2.org (bayard.4d2.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bcNtAdR40R4T; Thu,  6 Mar 2025 22:31:05 -0800 (PST)
Received: from ketchup (unknown [183.217.80.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id 50050EC59F2;
	Thu, 06 Mar 2025 22:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1741329065; bh=QbIBN2cYPALHuwk835VmCHT20olGGIRk7Frt+363LtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=USo9iDYeupLGfhOfG/Enc2OxgvBUZCQztffyffTK/ZZWiDR6ERox6qdaCVLQxQ7ny
	 ufyGH5rczv27cihJuHg8bn2M7trtL6rFmNQa6IDC3KNx+1oYctVoopbX/d+xBAA8qv
	 WqyRNcsDKDFiTPtt1JNfWL+GrnN2uJCTNCQPNX1b2S5uAhqvfWqx3aD3XLlfHMWP97
	 f3Qo3zvh7TxenaWjGW/GHop8gR7sCZ0GHfvn/yUBE/VDqODpp54/2uKsg83O8OX0Qj
	 aFH2aE4AcgAinbPoe++nkM5mPfBSo2tNntRcsFLnjd7Tdr6mDezcR58MEL4QX5I24f
	 0fRroYRc+Dbxw==
Date: Fri, 7 Mar 2025 06:30:52 +0000
From: Haylen Chu <heylenay@4d2.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haylen Chu <heylenay@outlook.com>, Yixun Lan <dlan@gentoo.org>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	spacemit@lists.linux.dev, Inochi Amaoto <inochiama@outlook.com>,
	Chen Wang <unicornxdotw@foxmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Meng Zhang <zhangmeng.kevin@linux.spacemit.com>
Subject: Re: [PATCH v5 4/5] clk: spacemit: k1: Add TWSI8 bus and function
 clocks
Message-ID: <Z8qSnBc4dmR3ftOz@ketchup>
References: <20250306175750.22480-2-heylenay@4d2.org>
 <20250306175750.22480-6-heylenay@4d2.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306175750.22480-6-heylenay@4d2.org>

On Thu, Mar 06, 2025 at 05:57:50PM +0000, Haylen Chu wrote:
> The control register for TWSI8 clocks, APBC_TWSI8_CLK_RST, contains mux
> selection bits, reset assertion bit and enable bits for function and bus
> clocks. It has a quirk that reading always results in zero.
> 
> As a workaround, let's hardcode the mux value as zero to select
> pll1_d78_31p5 as parent and treat twsi8_clk as a gate, whose enable mask
> is combined from the real bus and function clocks to avoid the
> write-only register being shared between two clk_hws, in which case
> updates of one clk_hw zero the other's bits.
> 
> With a 1:1 factor serving as placeholder for the bus clock, the I2C-8
> controller could be brought up, which is essential for boards attaching
> power-management chips to it.
> 
> Signed-off-by: Haylen Chu <heylenay@4d2.org>
> ---
>  drivers/clk/spacemit/ccu-k1.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
> index 5974a0a1b5f6..44db48ae7131 100644
> --- a/drivers/clk/spacemit/ccu-k1.c
> +++ b/drivers/clk/spacemit/ccu-k1.c
> @@ -558,6 +558,10 @@ static CCU_MUX_GATE_DEFINE(twsi7_clk, twsi_parents,
>  			   APBC_TWSI7_CLK_RST,
>  			   4, 3, BIT(1),
>  			   0);
> +static CCU_GATE_DEFINE(twsi8_clk, CCU_PARENT_HW(pll1_d78_31p5),
> +		       APBC_TWSI8_CLK_RST,
> +		       BIT(1) | BIT(0),
> +		       0);
>  
>  static const struct clk_parent_data timer_parents[] = {
>  	CCU_PARENT_HW(pll1_d192_12p8),
> @@ -795,6 +799,8 @@ static CCU_GATE_DEFINE(twsi7_bus_clk, CCU_PARENT_HW(apb_clk),
>  		       APBC_TWSI7_CLK_RST,
>  		       BIT(0),
>  		       0);
> +static CCU_FACTOR_DEFINE(twsi8_bus_clk, CCU_PARENT_HW(apb_clk),
> +			 1, 1);
>  
>  static CCU_GATE_DEFINE(timers1_bus_clk, CCU_PARENT_HW(apb_clk),
>  		       APBC_TIMERS1_CLK_RST,
> -- 
> 2.48.1
> 

Oops, I don't split out the twsi8-related definitions completely from
PATCH 3, causing building errors with only PATCH 3 applied. Will fix it
in the next version.

Best regards,
Haylen Chu

