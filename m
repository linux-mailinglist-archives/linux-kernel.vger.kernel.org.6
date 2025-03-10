Return-Path: <linux-kernel+bounces-554455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1EFA597EC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127101649FA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A4222D4D2;
	Mon, 10 Mar 2025 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9bpzmW/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE6822B8A9;
	Mon, 10 Mar 2025 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617611; cv=none; b=Cv872afyiVBrcOxrbrbC1l7nTOowo+tm4PtbgI4RmznajdP5yFu8LxwgDeC8b1J3FQ1xZAIuQk+jyQO+kOdzUPeRCEXpDqvjd+3yqZ0ZLuE/hxChVkkFnmhYh3+ETlx0N1N+BIivDViloofkrlZUHY4hSjbUC2XHRMNQJQO6eC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617611; c=relaxed/simple;
	bh=Sm0Mo6AtmCgx4dV4CHSjPIsBg9QJ8dBbfeea4VPSE+s=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=o6TbR0lqI3udYATTNuNqlQvs45Kv/4EMMThvxDcK4y2MDH2zwe1sIWHR0gUAKwSqtQKtEI53my8mPEFR7ym51OhC9/cFuV7Byj87fQtWmV71xdfx3kT6ayW2V727q/wAedQVpcW30dgxLliqUlg5azFVMGIQS+Pp1K1Ym0p7oMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9bpzmW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C7DC4CEE5;
	Mon, 10 Mar 2025 14:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741617610;
	bh=Sm0Mo6AtmCgx4dV4CHSjPIsBg9QJ8dBbfeea4VPSE+s=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=d9bpzmW/aPaZ+H5uUS5RjBMzDsfhN+MNx+PnBk/xBtrNiUq1A/dWbMlDv+OYEZMZq
	 d88khiKQ/4iUo8sCHUfak483oLOKKTkgxswTlLRLt5+liEH8K0NFiT6AkR1JmPMmk2
	 viqzIOOG+fg3Q8q58+o24wfxj/aUwqs+WsJQDDhLlAfMyjVOJhAtmVgkD4pDbtyO49
	 KdPiITje6UoMPOGJgKCkaswP1JcPlGuxa1jtqgvd5FqMsIIP94lx24FFWCLs0gPOWl
	 0ctUT+08DqTIV+6Qd6HdeViDmeggycsLNosvDDVEC2YzlhAqqNmPDkrDnkcY1BMQik
	 AtzBi7lQADNSA==
Date: Mon, 10 Mar 2025 09:40:08 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, Alessio Belle <alessio.belle@imgtec.com>, 
 David Airlie <airlied@gmail.com>, Nishanth Menon <nm@ti.com>, 
 dri-devel@lists.freedesktop.org, Frank Binns <frank.binns@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Tero Kristo <kristo@kernel.org>, 
 Darren Etheridge <detheridge@ti.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexandru Dadu <alexandru.dadu@imgtec.com>, Randolph Sapp <rs@ti.com>, 
 Maxime Ripard <mripard@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>
To: Matt Coster <matt.coster@imgtec.com>
In-Reply-To: <20250310-sets-bxs-4-64-patch-v1-v3-2-143b3dbef02f@imgtec.com>
References: <20250310-sets-bxs-4-64-patch-v1-v3-0-143b3dbef02f@imgtec.com>
 <20250310-sets-bxs-4-64-patch-v1-v3-2-143b3dbef02f@imgtec.com>
Message-Id: <174161760641.1135.692000381478156014.robh@kernel.org>
Subject: Re: [PATCH v3 02/18] dt-bindings: gpu: img: Add BXS-4-64
 devicetree bindings


On Mon, 10 Mar 2025 13:10:26 +0000, Matt Coster wrote:
> Unlike AXE-1-16M, BXS-4-64 uses two power domains.
> 
> Like the existing AXE-1-16M integration, BXS-4-64 uses the single clock
> integration in the TI k3-j721s2.
> 
> Signed-off-by: Matt Coster <matt.coster@imgtec.com>
> ---
> Changes in v3:
> - Include adding the second power domain so it's in context
> - Remove unnecessary example
> - Link to v2: https://lore.kernel.org/r/20241118-sets-bxs-4-64-patch-v1-v2-8-3fd45d9fb0cf@imgtec.com
> Changes in v2:
> - Use normal reg syntax for 64-bit values
> - Link to v1: https://lore.kernel.org/r/20241105-sets-bxs-4-64-patch-v1-v1-8-4ed30e865892@imgtec.com
> ---
>  .../devicetree/bindings/gpu/img,powervr-rogue.yaml | 34 +++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/img,powervr-rogue.example.dtb: gpu@fd00000: power-domain-names: ['a'] is too short
	from schema $id: http://devicetree.org/schemas/gpu/img,powervr-rogue.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250310-sets-bxs-4-64-patch-v1-v3-2-143b3dbef02f@imgtec.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


