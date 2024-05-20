Return-Path: <linux-kernel+bounces-184195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA68B8CA3CC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC671C210D3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E73139D12;
	Mon, 20 May 2024 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnRkzITj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05245139566;
	Mon, 20 May 2024 21:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716240133; cv=none; b=mgs5IItMRADSSylSbizslMhdIhx9/94QLqL372NsLLVT2rER3w62bdNkZPgHBHFxyebgXiOnRE/ZbpLZ05iUlBAzHOSDYA9bKn2/85xxlMYZKMz2FwaUacIY1XTsuvXUwrVrIW/cBiaLFQnQXRst4uUME2WU43bcY4WBfiaYANc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716240133; c=relaxed/simple;
	bh=E6TcOxL5uy2e/cY4PINVvMynIN5+jOe4ZcRRrYdWzI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvTjJLX+GLCwzXN1Qxmcu3rYh4QSIiR6X/WNv2SYdaof824znI9QC2wAiZKhPUFAjed82qOD6H6BcEx1+4IrfLuKMRpKGPgpRQM8WMPE4IRbUnE6a1RPTXb22grfnC7G96Ub7lW36o/OEcNAbPU+zMiIYJJzXXIO95vSqz6zsz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnRkzITj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5316FC2BD10;
	Mon, 20 May 2024 21:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716240132;
	bh=E6TcOxL5uy2e/cY4PINVvMynIN5+jOe4ZcRRrYdWzI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LnRkzITjHDtw1/8w6vcbvQuDUN6HuU47f1hvl2WQCtNmV34bpDgGs7PqLUp3BrxBV
	 ykGPf4vNTIhPlw4eeRCjb2JS6hgyXkNf3DLcDfGvEBsLpteCBRLMPQNJasJsFCtgB9
	 M1xpLWCcIVSRz1A13weQPlssLjuYSa8VrwgJLFj0xTfX3/d7ke9jhSCc0b1hMJHqZa
	 QyU32FqXxDf+ISb0cYIlN8dbGaeUcoMH1lG9GGDnTkmgc39/57noMjGGSGWlE8Z4xe
	 e1cM/rmxDzkxJtPmtW+RrWST7M63H4Vv9OyMfIwAy6eWxPo4eydWzeXgjeVOAgKjpa
	 ERtWs9Q1FoAsw==
Date: Mon, 20 May 2024 16:22:11 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Daniel Machon <daniel.machon@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-mediatek@lists.infradead.org,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH 7/8] dt-bindings: mfd: syscon: Add APM poweroff mailbox
Message-ID: <171624012885.1611775.15501873485589051240.robh@kernel.org>
References: <20240519-dt-bindings-mfd-syscon-split-v1-0-aaf996e2313a@linaro.org>
 <20240519-dt-bindings-mfd-syscon-split-v1-7-aaf996e2313a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240519-dt-bindings-mfd-syscon-split-v1-7-aaf996e2313a@linaro.org>


On Sun, 19 May 2024 20:42:22 +0200, Krzysztof Kozlowski wrote:
> Add compatible for an already used syscon poweroff/mailbox block in APM.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


