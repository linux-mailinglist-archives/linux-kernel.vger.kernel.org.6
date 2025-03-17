Return-Path: <linux-kernel+bounces-564560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA980A6570E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3F3E7AC918
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF331632E6;
	Mon, 17 Mar 2025 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOJ7aJpI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F371537CB;
	Mon, 17 Mar 2025 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742227298; cv=none; b=RHzzi/02rxbxfceb7fqDHGYXTPjp+/qckRDQ2xf/HIOEo8z9PUlSsTn7IULvP91/coxgAi93z53fbGzqF32plydcPYjPkz6vBLkMVvS7MreRBHO7292G7EqfZtx9VkgAP9A2Jf2jVhLEl4rlCyO4092FWSSEQOlfJvFM0vPpFaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742227298; c=relaxed/simple;
	bh=aJ3IP71SO/W9NfRGjFTM7N+/kwSupocM7aNe9qVRBDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIpy8ghRwO9TPIrnqqRpsPQ9pl+Rj8LmwqpHAE/Guj+V5QhvxCk94W/ZCQY0v7T7RI33HoqhTdSHqF1SBGpEcnDZnUEvGUJ1GwQY3niN95+9yXnKHG35LugedislDR4MNZGn+2UZv13LjbFhqshv0t44+3UQr6vMveiLKyLbbKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOJ7aJpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0905CC4CEE3;
	Mon, 17 Mar 2025 16:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742227298;
	bh=aJ3IP71SO/W9NfRGjFTM7N+/kwSupocM7aNe9qVRBDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WOJ7aJpIQ20nyMCGeBjFqGg1Jhcb2AzJUpo8g1Xhk3a/teE1uMfCJWQCyTiUsL/kf
	 nfEvWaQ8nytoiX5aGxOYplAVtFXJBwQRkAkipwl6rT4SsJNcUbDImnErS3L07tn13r
	 xkKVccxwbT3awyAhXnwDH8c+UJuEz/FfizEUyLDloYZMzzH8NF4uZwyVaEJQZRKLU7
	 ZFh9Id0HGx0/9E5GIq/gfVit0rjVclobVAHZLFx8MtCtfCTUFMCdp+UMzdiaUDF7Sx
	 bt7PUYz9ZSQo9K2hRiZUCPZhvZ8Eh9pWPd53xiJuNAqi/NrLIHKWldelYOv3SS7+f0
	 ot5949uIKvn2Q==
Date: Mon, 17 Mar 2025 11:01:37 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	Crystal Wood <oss@buserror.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: mtd: raw-nand-chip: Relax node name
 pattern
Message-ID: <174222729663.55568.3356685384531262945.robh@kernel.org>
References: <20250313-ppcyaml-elbc-v4-0-55903722d9ea@posteo.net>
 <20250313-ppcyaml-elbc-v4-1-55903722d9ea@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313-ppcyaml-elbc-v4-1-55903722d9ea@posteo.net>


On Thu, 13 Mar 2025 22:35:44 +0100, J. Neuschäfer wrote:
> In some scenarios, such as under the Freescale eLBC bus, there are raw
> NAND chips with a unit address that has a comma in it (cs,offset).
> For reasons of compatibility with historical device trees and
> readability of the unit addresses, this format is kept.
> 
> Relax the $nodename pattern in raw-nand-chip.yaml to allow such unit
> addresses. Unfortunately $nonenames defined in bindings that reference
> raw-nand
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
> 
> V4:
> - reintroduce patch to silence dtc validation error, after discussion
>   with Rob Herring and Miquèl Raynal
> - add some more detail to the commit message
> - remove unit address format rather than extending it
>   (old pattern: "^nand@[a-f0-9](,[0-9a-f]*)?$")
> 
> V3:
> - remove patch after discussion with Miquèl Raynal
> 
> V2:
> - new patch
> ---
>  Documentation/devicetree/bindings/mtd/raw-nand-chip.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


