Return-Path: <linux-kernel+bounces-199283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524718D84E4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E16A7B22A3D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6983D12EBCA;
	Mon,  3 Jun 2024 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEgQwIiO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95BF12E1ED
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717424794; cv=none; b=i6OwnWt1hpWgl3+qR1MSN+Y+iyjZ/rhVMMHBLN4NTxq+YXrB+0rkxEiQqfPoQTuUIl6y5ARRs44L6q4lDvWQrpnkFdsvF5vV02kuacdNvgnSO3ZDuowxfZcD2WLLAiohTYcu+azzAYqu/bEq8VNVhe5poE1uBM//CYoi28o6C6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717424794; c=relaxed/simple;
	bh=TVVMKCKrGIZH7o6AzV7hmPZQ06ehxdBVTP6Fm2Es6QQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SjT4xRPROg8e4/8tSYE5ffODgHxZHV0tZ/BRcvIfZ0z8huOuxVfKAkYE2nJWKkEqXe//VLNtBZbNqYeF+r5L2to8QXqPQkbQZ/Dz6A3T5RA6B3BTf/5OoUpExOjfODF8/j0KT1INk3+Y28SYQyzDoFHD5eiqSmAlEtrcY9JrG/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEgQwIiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36636C2BD10;
	Mon,  3 Jun 2024 14:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717424794;
	bh=TVVMKCKrGIZH7o6AzV7hmPZQ06ehxdBVTP6Fm2Es6QQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NEgQwIiOsPOtqxI90nP4aAwJsX1RvykInPhObHSaAWD9BymcTHVJwibjtVn4DjvmK
	 S09IVp3DTLYOmyNzmxNim8Nzc4a5fTjpp3on5kYCrKQ2l21PrXulp189eMVCv9/D/k
	 XFBbF6xqwTyqkXbTjfDOqzGCamSrkWMk3LiKmr1wIUl7jwcKFz6VBiVQUsHbK24a0j
	 qnXUydlNaZPO6yzY7edMTY/p2YeRFmRE3sUNYkyWNQcWDC20qptLyBEYNu9IRAym05
	 LIrnoAL/iS50TOi1Y7BTXTqVOU2ZWo1+9NMP9/Fq3DMbnQA/JM8aOKZWcZYbHe0gg4
	 8ctgArNrzo/Kg==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, sjakhade@cadence.com, rogerq@kernel.org, 
 robh@kernel.org, mkl@pengutronix.de, mripard@kernel.org, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, srk@ti.com
In-Reply-To: <20240602021629.3027660-1-s-vadapalli@ti.com>
References: <20240602021629.3027660-1-s-vadapalli@ti.com>
Subject: Re: [PATCH] phy: cadence-torrent: Add SGMII + QSGMII multilink
 configuration for 100MHz refclk
Message-Id: <171742479081.106728.13802512085127626613.b4-ty@kernel.org>
Date: Mon, 03 Jun 2024 19:56:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sun, 02 Jun 2024 07:46:29 +0530, Siddharth Vadapalli wrote:
> Add register sequences for SGMII + QSGMII multilink configuration
> for 100MHz refclk.
> 
> 

Applied, thanks!

[1/1] phy: cadence-torrent: Add SGMII + QSGMII multilink configuration for 100MHz refclk
      commit: 7d5ebb62d72b5ea8a21fc62c8985dacae6a71ca8

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


