Return-Path: <linux-kernel+bounces-214474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C02B890853D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C691F26EAC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBA3149C53;
	Fri, 14 Jun 2024 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upBlsidc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F8F149011;
	Fri, 14 Jun 2024 07:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718351024; cv=none; b=hvuQ58MZyi9MMPjISERcepEETDLueT3iKu4iMqGtelao10VY1NO5IHNJRyDo/xF+KvEgbS9SXS1ql9AUi/xwmvgfL28MfNxrmKqei0GEWoezjxU+Qz+zJcUWDd3d2mO9YKQP2FZtt33Gq3NDaUnDpfVZpAoBM7w++U1g1TL/rnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718351024; c=relaxed/simple;
	bh=oTDBUdRDD6OthFIBZDrKQucTLqx4aJOFf70vJFKFyYY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IbkMAKitgkKTYyBm7mXFPvj9HUlNobS1HZ5IH/VQafU1DsGTSBukS8oJvscdKXAnzjIVn5rm8BjHWX9noycF5iTG8yt0GpF6kMNqEUrxfdBG+N/Y4tyUkEbbqYSZ4f8VSX2P6kA3g7PU9Z23gSn9Wuppigtjuz+FC0STkxwIWOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upBlsidc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6911C2BD10;
	Fri, 14 Jun 2024 07:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718351024;
	bh=oTDBUdRDD6OthFIBZDrKQucTLqx4aJOFf70vJFKFyYY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=upBlsidcuX68KCzaMBbA2j/WbpiukE8WH4uksFtFXFvH0Uy5NLdOWPnVmMSYA7Mdc
	 V5IU1LZgaAnv2CvJyJU03AxuK9E44B7NYC4+6El7mGLlb/wUgXyWCn1ZWhBEkRGcPj
	 rYjrK0ACTaWhoMfVUQa2CmvBTxnzigWJtJmv3u8Jz0REs+lF/E7WrRdrVwhsUodhYt
	 lyAL3lgMun6vxeMJjRWDI3NElHiPVZUFsJcdFgymIV1fcXjDUj6ejV3rpxgjKgEieV
	 zqrImSJRV/8eGUnWtowVW+7JfCQ7u+gDTzbCiWsLXGYsUkN2yk2q5Hu3dORbim/1qq
	 h6Wzrq4g0s3ew==
From: Lee Jones <lee@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>, Andre Przywara <andre.przywara@arm.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, Chris Morgan <macroalpha82@gmail.com>, 
 Ryan Walklin <ryan@testtoast.com>, 
 Philippe Simons <simons.philippe@gmail.com>
In-Reply-To: <20240613233104.17529-1-andre.przywara@arm.com>
References: <20240613233104.17529-1-andre.przywara@arm.com>
Subject: Re: (subset) [PATCH v3] mfd: axp20x: AXP717: Fix missing IRQ
 status registers range
Message-Id: <171835102238.2975804.6897127880257764523.b4-ty@kernel.org>
Date: Fri, 14 Jun 2024 08:43:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Fri, 14 Jun 2024 00:31:04 +0100, Andre Przywara wrote:
> While we list the "IRQ status *and acknowledge*" registers as volatile
> in the MFD description, they are missing from the writable range array,
> so acknowledging any interrupts was met with an -EIO error.
> This error propagates up, leading to the whole AXP717 driver failing to
> probe, which is fatal to most systems using this PMIC, since most
> peripherals refer one of the PMIC voltage rails.
> This wasn't noticed on the initial submission, since the interrupt was
> completely missing at this point, but the DTs now merged describe the
> interrupt, creating the problem.
> 
> [...]

Applied, thanks!

[1/1] mfd: axp20x: AXP717: Fix missing IRQ status registers range
      commit: 569c5136baf12c3b8dd137ac356f2a7ceb38bdb5

--
Lee Jones [李琼斯]


