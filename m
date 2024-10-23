Return-Path: <linux-kernel+bounces-377266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 044F09ABC2E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E041F2317C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 03:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879DD126F0A;
	Wed, 23 Oct 2024 03:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIoREXqq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0BC3398A;
	Wed, 23 Oct 2024 03:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729654251; cv=none; b=nMSFRHzTA9yyH5LTaZxaEtC2Z4mB4gWtls5CMBtTTtQQl4bcjC1ucniSBDtBQAJh7E/2xz9Ehzi/3pS2lfMm37b3ahoyA4fXepJikIXpB4YY2DC0AQMP/yePZ3/MWSXwXmAkBMsORpNjxJKX88jv7tPVaDw6NtmnPNZfgGI4dX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729654251; c=relaxed/simple;
	bh=2i0u7Oyd6EIWrfo7dkMmqDbK5/4NHEU8hCqC4MvB95s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOAHsrWyNJ9uvzTLl3+9GslqrhkoiiVT0+3nmoj9bZX/ZR+BIze2Zg6Rr9LuZ0nty+Z6X65HlbV4PKIbjW8AHioUXh1NY9BTaMkdgDWxxpyWI9krWp1lv2aqZfbcRwxRmOt7yujPfbE+VgD0RGY+oBY55oG/VfktK7MhJeVixDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIoREXqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF2AC4CEC3;
	Wed, 23 Oct 2024 03:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729654250;
	bh=2i0u7Oyd6EIWrfo7dkMmqDbK5/4NHEU8hCqC4MvB95s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lIoREXqq2E0X3Me3bOJvaFdr5u8AXOktWlPVzGJbNA1RF0Lp/NmyjEBt5fFJh8TnL
	 u8WW8HgSh19yisgJ+Ohf44ieEvhAf8lPNCJgM/IKj9+8dxiI5JidizwVgk4UpkKwvP
	 k5W3Jo1iGllnKmS6ml3J+aPVfQnsq6pPs2iOLGoSOjaFctt2YFxWtn4FXUTVx5B+2w
	 2a5/SrQqfY6geukQ13wRURp9UdZUI8PBqaNKTkftHyXbS7RdnyLCQ2WVl3hNvcRIOq
	 4CkJZAdbjgqha7bOyt+cQxgFsRvKOUiV2h95FApxQK61jjoNmbvQYZ5XOu4suMMIiQ
	 UsyaaT/oQaFjg==
Date: Tue, 22 Oct 2024 22:30:47 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	"Satya Durga Srinivasu Prabhala --cc=linux-arm-msm @ vger . kernel . org" <quic_satyap@quicinc.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] clks: qcom: Introduce clks for SM8750
Message-ID: <upcpsmpe3on23uakvkrtuxq4ooprjdyin2umvflztfrsaeem4w@4zwrmmwpuqjj>
References: <20241021230359.2632414-1-quic_molvera@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021230359.2632414-1-quic_molvera@quicinc.com>

On Mon, Oct 21, 2024 at 04:03:52PM GMT, Melody Olvera wrote:
> Add GCC, RPMH, and TCSR clocks for the SM8750 SoC.
> 
> The Qualcomm Technologies, Inc. SM8750 SoC is the latest in the line of
> consumer mobile device SoCs. See more at:
> https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/images/company/news-media/media-center/press-kits/snapdragon-summit-2024/day-1/documents/Snapdragon8EliteProductBrief.pdf
> 

Please adopt b4, as described in go/upstream, to help avoid the mistake
with linux-arm-msm not being Cc'ed in the future.

Regards,
Bjorn

> Taniya Das (7):
>   dt-bindings: clock: qcom-rpmhcc: Add RPMHCC bindings for SM8750
>   clk: qcom: rpmh: Add support for SM8750 rpmh clocks
>   clk: qcom: clk-alpha-pll: Add support for controlling Taycan PLLs
>   dt-bindings: clock: qcom: Add SM8750 GCC clock controller
>   clk: qcom: Add support for GCC clock controller on SM8750
>   dt-bindings: clock: qcom: Document the SM8750 TCSR Clock Controller
>   clk: qcom: Add TCSR clock driver for SM8750
> 
>  .../bindings/clock/qcom,rpmhcc.yaml           |    1 +
>  .../bindings/clock/qcom,sm8550-tcsr.yaml      |    2 +
>  .../bindings/clock/qcom,sm8750-gcc.yaml       |   65 +
>  drivers/clk/qcom/Kconfig                      |   17 +
>  drivers/clk/qcom/Makefile                     |    2 +
>  drivers/clk/qcom/clk-alpha-pll.c              |   14 +
>  drivers/clk/qcom/clk-alpha-pll.h              |    7 +
>  drivers/clk/qcom/clk-rpmh.c                   |   26 +
>  drivers/clk/qcom/gcc-sm8750.c                 | 3285 +++++++++++++++++
>  drivers/clk/qcom/tcsrcc-sm8750.c              |  147 +
>  include/dt-bindings/clock/qcom,rpmh.h         |    2 +
>  include/dt-bindings/clock/qcom,sm8750-gcc.h   |  226 ++
>  include/dt-bindings/clock/qcom,sm8750-tcsr.h  |   15 +
>  13 files changed, 3809 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8750-gcc.yaml
>  create mode 100644 drivers/clk/qcom/gcc-sm8750.c
>  create mode 100644 drivers/clk/qcom/tcsrcc-sm8750.c
>  create mode 100644 include/dt-bindings/clock/qcom,sm8750-gcc.h
>  create mode 100644 include/dt-bindings/clock/qcom,sm8750-tcsr.h
> 
> 
> base-commit: 63b3ff03d91ae8f875fe8747c781a521f78cde17
> -- 
> 2.46.1
> 

