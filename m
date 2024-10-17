Return-Path: <linux-kernel+bounces-370008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7FD9A25BF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582BF284C01
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C251DE8B8;
	Thu, 17 Oct 2024 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHYvmIA5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D141DE898
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177101; cv=none; b=az+faDn0RprYirAJB6X6NMbHxw5H0UCpH77+na0IIVTkokHfoxNNtnyZyCTxwfdlq+OSt++S2jNQQLPrBr1isDZkwY9mERPHqnDRr3x0RCqrzhOL9niSRamdRYLIrSt1+FRypHsVSl2TnjShZ7MnQlRhyiF4E8gYNicUmPhyc4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177101; c=relaxed/simple;
	bh=avd8bg8mcUPAY+SpVapYfK6GAKFCET4ETNVrqu5Tgm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKvR7fwxohNL0zVDWEb9hsWNo1ip2oY3Stko8e2MmKG0QIuyRYzNZwrWf130vFFdf+sQ+1AMKemMIaITZveC0XyPk8j0a5mLdef0eAZR/q8JapipoyIHIakpLhGnz1p+uM9mi5hSpDjNK7a6OnHVY/SiQDBFhQEwrPBxRJ/znQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHYvmIA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA85C4CEC3;
	Thu, 17 Oct 2024 14:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729177101;
	bh=avd8bg8mcUPAY+SpVapYfK6GAKFCET4ETNVrqu5Tgm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fHYvmIA5ThfPAsfI9339n9u80VUiN+k4pRR20KZUgburi4X8DwCGDK/hJxlLCpJYP
	 J6uAKF/W8JG2B73zorjmZiUf6ZbdlEsLD4hP8AonTJV4lqbNkV8RCMZYQps06yFA3e
	 Cm5Fhy1+s/mHkoaebtE/QeMbLdEmdyCL73cjS2Ncb0y6fs/sCPuC18vwdffYCwxxL0
	 uW2qSDYzMvPgZmhc0XH7xmgL7++mtX/JT1uLiwvaj/C2A3RHt5D84IbRAW30nhtwDk
	 Aajiwxg9RFHNzv33tth1lhhpn0lPdgwbViWrX0uk024jl5r/Gm34dL5YlgOnX65jWI
	 qQx5/CSXUOfMQ==
Date: Thu, 17 Oct 2024 20:28:17 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bartosz Wawrzyniak <bwawrzyn@cisco.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	Swapnil Jakhade <sjakhade@cadence.com>,
	Aswath Govindraju <a-govindraju@ti.com>,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	xe-linux-external@cisco.com, Daniel Walker <danielwa@cisco.com>,
	Bartosz Stania <sbartosz@cisco.com>
Subject: Re: [PATCH v2] phy: cadence: Sierra: Fix offset of DEQ open eye
 algorithm control register
Message-ID: <ZxEmCWsViATsffE/@vaman>
References: <ZwN+8xpOl4+Ggaha@vaman>
 <20241008171000.2665935-1-bwawrzyn@cisco.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008171000.2665935-1-bwawrzyn@cisco.com>

On 08-10-24, 17:09, Bartosz Wawrzyniak wrote:
> Fix the value of SIERRA_DEQ_OPENEYE_CTRL_PREG and add a definition for
> SIERRA_DEQ_TAU_EPIOFFSET_MODE_PREG. This fixes the SGMII single link
> register configuration.

This does not apply for me on phy/fixes

Can you please rebase and resend

-- 
~Vinod

