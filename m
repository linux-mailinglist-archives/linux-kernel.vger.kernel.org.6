Return-Path: <linux-kernel+bounces-527075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5ADA40709
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 10:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD113420494
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 09:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DBA207677;
	Sat, 22 Feb 2025 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o16wwvc/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAE046434;
	Sat, 22 Feb 2025 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740217437; cv=none; b=s7KnsVujdeLHdlAkck6EbykfNq0AyXAWr0T/aiNMhcaH8B3omfHjuHbHPl/B2tjclJTogWw8mSQSnhEb3aa0U3ecAmHcTFKLBYY1IHHwdgrTdekryw/y9IxU0vhRlul78fgOemLLWe7IlOD0UTyzgs6oeIoHp+f3dEftbR28YOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740217437; c=relaxed/simple;
	bh=vejM1D5V8FJU5zIT5zcUExYcNOLocFCfXhexfw8wOrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrBtT74ROfbxpt/AXkGJ+lrCQPMBKY0NVKuK1CzbVvzrvlTqX4qIkk0DVeFQN8Mos7U5zbMxd/2EiAAqgEQJi1855kr+ovuvWgeqfB8TSZr7V8QDl46MIVLMRQWMWKQUyOf6zuc6pj3ZYXh8zEsc9MISQR7HrtTM0aUScuYmxCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o16wwvc/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DBAC4CED1;
	Sat, 22 Feb 2025 09:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740217436;
	bh=vejM1D5V8FJU5zIT5zcUExYcNOLocFCfXhexfw8wOrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o16wwvc/ogg+8FnjU5tJzN9QwUYxnkWrie23dPh0b8DxEM9A6ClAnUtQgnEOrtVxk
	 2XS5hTQ4DXkfMGEFjS7SiEphB5J41OTeGw1c4Tix5obIOuvjHjPFFMUq+nUBi9vM7s
	 4DzaFp3vL/69hlNs3C3LH2L6rOS4wjvr0AZf5Dsa4WAQUuROsjxMZsmpDwAJHGxn6u
	 lfx0dbNmWtTACTJClvn0ZqYpeYvOke+/zSkPauhFEWOmIhNlcu8W+8miw53mrAH0IX
	 wFeEsdiGKbDBRftbrcPlyHVqoOgMt3woaTdcGfkuKzDb/R+r5D73Yk24cBr5h8MHoN
	 qPxUiMSIyRFgA==
Date: Sat, 22 Feb 2025 10:43:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Artur Weber <aweber.kernel@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Stanislav Jakubek <stano.jakubek@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v5 1/9] dt-bindings: mfd: brcm,bcm59056: Convert to YAML
Message-ID: <20250222-orthodox-black-mayfly-984ffc@krzk-bin>
References: <20250221-bcm59054-v5-0-065f516a9042@gmail.com>
 <20250221-bcm59054-v5-1-065f516a9042@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221-bcm59054-v5-1-065f516a9042@gmail.com>

On Fri, Feb 21, 2025 at 09:16:23PM +0100, Artur Weber wrote:
> Convert devicetree bindings for the Broadcom BCM59056 PMU MFD from
> TXT to YAML format. This patch does not change any functionality;
> the bindings remain the same.
> 
> The bindings have been split into two parts: the MFD binding and
> a separate binding for the regulator node, to simplify the addition
> of other models later (which have different regulators).
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> Changes in v5:
> - Replace mfd/brcm,bcm59056.yaml with mfd/brcm,bcm590xx.yaml in
>   regulator binding description
> 
> Changes in v4:
> - Made $ref use full schema path
> - Cleaned up example
> - Dropped regulator name list comment
> - Changed description of regulator binding to mention BCM59056
>   explicitly
> - Changed "Power Management IC" to "Power Management Unit" to match
>   official Broadcom naming
> - Renamed mfd/brcm,bcm59056.yaml to mfd/brcm,bcm590xx.yaml

I don't understand why the name became "xx", instead of matching exactly
compatible. It wasn't like this when I reviewed it last time and this is
really unexpected change.

Please follow standard rules: filename must match compatible.

Best regards,
Krzysztof


