Return-Path: <linux-kernel+bounces-357439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5ED7997138
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668382874D0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF181F1319;
	Wed,  9 Oct 2024 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxvP+wX7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B2B1F130A;
	Wed,  9 Oct 2024 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490369; cv=none; b=jrfH1IiqyVw60worblUIVHKDRzrU1yOH+8r3WT0/F9tUZOBWC1Wj0xAJkhD7SSYL0B834ZvTwepu7WOFrt8ZHq+yczqs7q1fHYp5a8S78nsaWeB13mCq54k8/ep2SPf8hAJV6Uvx8Lv3x7X6rLOlMCLAsi6FHUrCwZ1aciXEWqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490369; c=relaxed/simple;
	bh=S5aG80GvrKdfMXVhakyIDR2NbDXeLTTdwzkg9R4l52A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gfVQwQWLWGM4k/N42KhTFmQ7G1YI0/xT+qJETeISj2+1xLaZItfttmRdMSHKh/OGtQa8pzQvSIZUvjjln3s/5hXnXAf5bpaa8rIehCd57sJLzFJWirizC3ooISyO5Edlb7IMgmKvUBBYMRmzTJQsH4GHJPcDDE6CjrbA7ejufsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxvP+wX7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04529C4CEC3;
	Wed,  9 Oct 2024 16:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728490368;
	bh=S5aG80GvrKdfMXVhakyIDR2NbDXeLTTdwzkg9R4l52A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hxvP+wX7aPWLqTtiZP+W8BDHgAQNj/T5T8gVd3ljVbXCq7+6iSTL6G8IFidPvHgFc
	 KVENSUMRVifuvcHhLxz+1mol24tzx4g1EVoBfTmbqkKr9OFtjFEjIa7uxWtpZqtzNq
	 wZgU/F82FY31jx76spPYH2BrUz2uHoqf7DLMn2JMMdmdglyYA7o/n7BlG2Rgbtdirb
	 VSQx47sSgJYaWCmy4huSPc0iRSCOJfC/QqAU0B+RlrLPor8c0w1u+w8SdmTJJiE+5/
	 cfAKtrz9tOVWwLAuLX8q9qjcv70jvJKpZnupmXLtzLB9Lq/CWM9iv0MExz+UeL3NTS
	 IctUKp5itIGUw==
From: Lee Jones <lee@kernel.org>
To: linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 pierre-henry.moussay@microchip.com, valentina.fernandezalanis@microchip.com, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Lee Jones <lee@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-riscv@lists.infradead.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20241002-clambake-raider-a8cbb3a021a8@spud>
References: <20241002-private-unequal-33cfa6101338@spud>
 <20241002-clambake-raider-a8cbb3a021a8@spud>
Subject: Re: (subset) [PATCH v1 03/11] dt-bindings: mfd: syscon document
 the non simple-mfd syscon on PolarFire SoC
Message-Id: <172849036272.666113.12889452067505651673.b4-ty@kernel.org>
Date: Wed, 09 Oct 2024 17:12:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Wed, 02 Oct 2024 11:48:01 +0100, Conor Dooley wrote:
> The "mss_top_scb" register region on PolarFire SoC contains many
> different functions, including controls for the AXI bus and other things
> mainly of interest to the bootloader. The interrupt register for the
> system controller's mailbox is also in here, which is needed by the
> operating system.
> 
> 
> [...]

Applied, thanks!

[03/11] dt-bindings: mfd: syscon document the non simple-mfd syscon on PolarFire SoC
        commit: 8ae16d3b2ff6650a90be78881cb88dcdf1bd1370

--
Lee Jones [李琼斯]


