Return-Path: <linux-kernel+bounces-172135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AC08BEDF2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43729B214C3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF46F187337;
	Tue,  7 May 2024 20:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzCd5kht"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC943187320;
	Tue,  7 May 2024 20:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715113011; cv=none; b=B+MEvJGG7kQIZghqXkkaWPWaJqiqnCuPVmIX27AeHnVpx0/AEY/FX7SL7IbRkPL5VydraUkXB2HS4vn6Qp47K7v1Gso8ZMUIX0ieFp0+N6UUAOWg7nJ8W2N+3nlWZ5nrAlVhzaMq80PiyuOHurAJuRKFtor8hsp0i12nMAfbQnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715113011; c=relaxed/simple;
	bh=cGaAkkEOXpEMKaanh5pAkmdxFKN5fg25gZkTzU10KXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHSlECtaKtj1cAkmpxHw0aMe5saAmJ1lj2ssWdmYQUpv5pt7TqEezsc2NBCOwXnM4z5d+D6jICOWpp7x9HxtefH2JlavWrDw1rtfdevU1wbg/OZo/L2shVrzOQiIgcbSLvSrXn/yretLgqmy3qyfaSG310fWnJNw08x22yU2lW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzCd5kht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBFAC2BBFC;
	Tue,  7 May 2024 20:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715113010;
	bh=cGaAkkEOXpEMKaanh5pAkmdxFKN5fg25gZkTzU10KXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DzCd5kht5CJIc7xsbUMaE6HsmKbfChDDD1LJUcuBiK3Dl+rVaoYyxpGs8hZzE07Yj
	 dLBXaoXx5Gq1PZ1KzqqDoCBnjNZqGc1D0LxU2t1Ee4zW9Jjo/Nz0eDs1o6kUO97Jmb
	 tOKXF8acwihZSthw04n2tVCjY0niFo7R9e4iGQPMZ7E3t8eO7cvxtWEun7stK1KL+g
	 vTcwg8eo5P1+Q1n9ZqDiAGZBToF3iZcbcnSfteaF8owH+28/SHfw9XMxBeyxP4Axkj
	 Pjfzu9DUdhXHttJ2YMfT2jtHBGhR3FPHvkjWKeZqiKhVtUk5m2CxRQYV0AO/SPVbsU
	 SYq7FfQx6p1wg==
Date: Tue, 7 May 2024 15:16:48 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Drew Fustini <dfustini@tenstorrent.com>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	Jisheng Zhang <jszhang@kernel.org>, linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Yangtao Li <frank.li@vivo.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	devicetree@vger.kernel.org, Guo Ren <guoren@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>, Fu Wei <wefu@redhat.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH RFC v3 2/7] dt-bindings: clock: Document T-Head TH1520
 AP_SUBSYS controller
Message-ID: <171511300571.994683.10040593951113632886.robh@kernel.org>
References: <20240506-th1520-clk-v3-0-085a18a23a7f@tenstorrent.com>
 <20240506-th1520-clk-v3-2-085a18a23a7f@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506-th1520-clk-v3-2-085a18a23a7f@tenstorrent.com>


On Mon, 06 May 2024 21:55:15 -0700, Drew Fustini wrote:
> Document bindings for the T-Head TH1520 AP sub-system clock controller.
> 
> Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf
> Co-developed-by: Yangtao Li <frank.li@vivo.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> ---
>  .../bindings/clock/thead,th1520-clk-ap.yaml        | 64 +++++++++++++++
>  MAINTAINERS                                        |  2 +
>  include/dt-bindings/clock/thead,th1520-clk-ap.h    | 96 ++++++++++++++++++++++
>  3 files changed, 162 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


