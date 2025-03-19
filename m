Return-Path: <linux-kernel+bounces-568959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04114A69CBC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 00:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC51E17AD73
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A1C22330F;
	Wed, 19 Mar 2025 23:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8aMbSk6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E028290F;
	Wed, 19 Mar 2025 23:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742427026; cv=none; b=t3XZ/DMmA9KIBC66NT1DbuTO7oR4+CzXd+SvC4MTzj1KCL7/hTNnGS+DrnmpXpF8MNdfevVqo/qtmqN8t6G4KMbErVPrhFs6JqdzXy6aWRsWOKIya72vLjFjRMBbqmHjgnyx7/HKzuBfvZbAuuAa5gTUZtoIluF7lUK7LT9KupA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742427026; c=relaxed/simple;
	bh=OMKglMOygBYF+GG2fB4Gz4YtFSBhCmTJHwE7Jwd+DPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0OVhMSO7qytUpD+phlsoi0a4MfJ5mx+omkRfnT2eEO7C/ou7n21LDHMuj/p6hjMFQHd63z/OYDwimXRWHl/G1Utgfmb6IKM3YtzCBnnstfumdPhBQ1LySad1NkLBoZkDR52zO+6LEoqQ+ZFtATHTqKXFJAU97iNH7qPmVCZEb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8aMbSk6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231C5C4CEE4;
	Wed, 19 Mar 2025 23:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742427025;
	bh=OMKglMOygBYF+GG2fB4Gz4YtFSBhCmTJHwE7Jwd+DPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d8aMbSk6gk0jUPfw0KamMBrUIQAlPfmzC0Wrh9KojGMEy3e+Bb5vLcGRoeHIStYKI
	 xPSVrZ70gq2E7N8Cg0TrSy8YipjQMmcC3j4R8vBpbDFJIO7xRS/E10ScszoFE0U2L5
	 WY9nmFrlByE+J1JCk0thE5kI9yILDh7VytYqpCbdXfi1jZ6wDh+jK7OAlBgh4gK0TE
	 mHZa9CmOd/4wEcapKDv95Ka7Jy7FPTUmNwLmCm1q7Qo9iWb1k9y0G8KRDT+zFiTJRB
	 dXMocwHJTnSAzSA6+6mamUAt5BJLRj4OXYR+mt0XFejo6srOk0deA8VXo1x5FYFQMi
	 OmpFuDuFxSrYw==
Date: Wed, 19 Mar 2025 18:30:24 -0500
From: Rob Herring <robh@kernel.org>
To: Takahiro Kuwano <tkuw584924@gmail.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bacem Daassi <Bacem.Daassi@infineon.com>,
	Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH 2/3] mtd: spi-nor: use rdid-dummy-ncycles DT property
Message-ID: <20250319233024.GA2625856-robh@kernel.org>
References: <20250319-snor-rdid-dummy-ncycles-v1-0-fbf64e4c226a@infineon.com>
 <20250319-snor-rdid-dummy-ncycles-v1-2-fbf64e4c226a@infineon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319-snor-rdid-dummy-ncycles-v1-2-fbf64e4c226a@infineon.com>

On Wed, Mar 19, 2025 at 06:47:44PM +0900, Takahiro Kuwano wrote:
> There are infineon flashes [1] that require 8 dummy cycles for the
> 1-1-1 Read ID command. Since the command is not covered by JESD216
> or any other standard, get the number of dummy cycles from DT and use
> them to correctly identify the flash.

If Read ID fails, then couldn't you just retry with dummy cycles? Or 
would unconditionally adding dummy cycles adversely affect other chips?

Otherwise, add a specific compatible to imply this requirement. Adding 
quirk properties doesn't scale.

Rob

