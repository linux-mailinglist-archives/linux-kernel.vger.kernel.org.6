Return-Path: <linux-kernel+bounces-192751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C403C8D219C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009621C227D5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8179172BCA;
	Tue, 28 May 2024 16:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFqO3m1c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C621172786;
	Tue, 28 May 2024 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716913619; cv=none; b=lF6Io9240GiERtqbLvPVAXz+1XLZW02O3JTtsqusqD4Wbk9LV4d+5naEnELZvllYC/HgJZ3rDOseZzjtC2qteuoXu2dP7Idn0McXB9Xdt7DApmy8KBWJSXZ9jvbZYNqe7Tfhd5X5KJbmuPCqPStPLPD+bTaEbHQkO8i+aUCkTCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716913619; c=relaxed/simple;
	bh=qdXP/32lX1/6i73zn1P1xe6RliYLeJS0GT4JVheWLVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqtbWhniaI6qZ+niJMIzrgtJWnddl2J7Z+GMdnTzYsnC8PzxdXZ7eQ7w7xiPdXl9Xc0VnkhNOWv3sarUPHS4kSc38j0n3HwRxpyRd+4cOc6wQ9UyLof9MmsZhFVDKaMAQ9tRhZgUPny0kL9EBh078r0V2zBmcrYZtvqRAh/isr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFqO3m1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AB3C3277B;
	Tue, 28 May 2024 16:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716913618;
	bh=qdXP/32lX1/6i73zn1P1xe6RliYLeJS0GT4JVheWLVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RFqO3m1cQn/BFnvd0GC7RVrsnSw0aZWw4rhKFXxQqzIPWCJpjRAe5W/Tnh2p9/Gyf
	 T1PTZmNjYVrS0+vEe8f2BSzznK+dtvm6ekBUevafYCqoyN3x1wDgmE4QLc7UjL6b3Z
	 +ZBTHr/XtWGiB4DKaaQACU/AHUmAuGEVnZsC9g4N9UueBZQRXbvrF8nY7g2TRCFyPJ
	 +DkXV8fg+v5x0VHjPypF/CQJTY2UjwbynmmkBK3BVNR+Mu367p/Gy2wBK/TygYImnD
	 qBql2otbXnICig6MryWmmpEYbiehHLoelKkqrt16g83CPM0/WVUn1FeqGJDOszm3jH
	 Z/DhhKJFPmhpA==
Date: Tue, 28 May 2024 11:26:57 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Peng Fan <peng.fan@nxp.com>, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v4 2/6] dt-bindings: firmware: add i.MX95 SCMI Extension
 protocol
Message-ID: <171691361410.864372.12807947613760127551.robh@kernel.org>
References: <20240524-imx95-bbm-misc-v2-v4-0-dc456995d590@nxp.com>
 <20240524-imx95-bbm-misc-v2-v4-2-dc456995d590@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524-imx95-bbm-misc-v2-v4-2-dc456995d590@nxp.com>


On Fri, 24 May 2024 16:56:44 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX SCMI Extension protocols bindings for:
> - Battery Backed Module(BBM) Protocol
>   This contains persistent storage (GPR), an RTC, and the ON/OFF button.
>   The protocol can also provide access to similar functions implemented via
>   external board components.
> - MISC Protocol.
>   This includes controls that are misc settings/actions that must be exposed
>   from the SM to agents. They are device specific and are usually define to
>   access bit fields in various mix block control modules, IOMUX_GPR, and
>   other GPR/CSR owned by the SM.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/firmware/arm,scmi.yaml     |  5 ++-
>  .../bindings/firmware/nxp,imx95-scmi.yaml          | 43 ++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


