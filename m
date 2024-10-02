Return-Path: <linux-kernel+bounces-348363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F83898E6A0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 01:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093F22836E0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354A419D077;
	Wed,  2 Oct 2024 23:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVwAaUa2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A56C1AAD7;
	Wed,  2 Oct 2024 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727910841; cv=none; b=ouzl/2uP+doCbP7AQx9CrwaWzNoIq38P7ArzQ8Ri/u7zN+EWgFGwVeo1DArPRPKXHPDwudVvEfc1xpyFl0BLKApjF0avtzCqwGLnnc+ps+hXyyfO9gduk9OHZ5/Vt+Lx8DSt+PTtt674688x5cWAVeJ0AIYYJEqq+7e9nkgoTuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727910841; c=relaxed/simple;
	bh=7YYc3tKXWLUFk4DRNKpYVMKBIua9W9e+ZaMQmUrPvjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTSmvY9BirQFFb5CdoHdlgYSuvSr42r2HXJV3z27gwzPUoOmuNdX2dzIM7PDBNynPMG0msjJf4Fe05IlBE1Z5cynPzPLt7wkR+QqvPQHuRtaNTN9c4Iq0ogne+QzI9Y1ajIdBwVHcEAnjw5b0cxGSeuMR6c4+dlRF6fiszU7M4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVwAaUa2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AFEC4CEC2;
	Wed,  2 Oct 2024 23:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727910841;
	bh=7YYc3tKXWLUFk4DRNKpYVMKBIua9W9e+ZaMQmUrPvjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qVwAaUa2LFESEmFu1zJ1Wzg+AJn37DVAWFp+xiTwBy9mcgc4iR9He3UQpBwbVTMzf
	 fisplMEFSlwzBvZR1vHIPVcL8fZdCBN+8ZQw5WDCFISKGZpv4kazuav4ShDEECwWTy
	 Nbaj16s5mrN38IV1SomH8OHbpMtCN/QqzYhOZOqxewImA0zPBD+4QVyKrhU4p4TxFM
	 2A9/Xb1UOyUe5ZGBXgWB9Y7yWgaZMKuKZC7G9pDLYvXm/EYsuubOGY/QfEFClFYreT
	 CEqnSPreSw7RiWM6xk9CCHjUt8RCZ0pvzVcm15OHgz2H/DsTuQyl8+oeu0XLMuifFQ
	 +BuUUk0k+B/WQ==
Date: Wed, 2 Oct 2024 18:13:51 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org, pierre-henry.moussay@microchip.com,
	Stephen Boyd <sboyd@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	valentina.fernandezalanis@microchip.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Lee Jones <lee@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v1 01/11] dt-bindings: mailbox: mpfs: fix reg properties
Message-ID: <172791083082.1519634.10076484205246276978.robh@kernel.org>
References: <20241002-private-unequal-33cfa6101338@spud>
 <20241002-stingily-condone-576e948e6d67@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-stingily-condone-576e948e6d67@spud>


On Wed, 02 Oct 2024 11:47:59 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> When the binding for this was originally written, and later modified,
> mistakes were made - and the precise nature of the later modification
> should have been a giveaway, but alas I was naive at the time.
> 
> A more correct modelling of the hardware is to use two syscons and have
> a single reg entry for the mailbox, containing the mailbox region. The
> two syscons contain the general control/status registers for the mailbox
> and the interrupt related registers respectively. The reason for two
> syscons is that the same mailbox is present on the non-SoC version of
> the FPGA, which has no interrupt controller, and the shared part of the
> rtl was unchanged between devices.
> 
> This is now coming to a head, because the control/status registers share
> a register region with the "tvs" (temperature & voltage sensors)
> registers and, as it turns out, people do want to monitor temperatures
> and voltages...
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/mailbox/microchip,mpfs-mailbox.yaml    | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


