Return-Path: <linux-kernel+bounces-353741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C679931FB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11172841DD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084A01DB34E;
	Mon,  7 Oct 2024 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lj/+nOq/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B851DACBE
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316140; cv=none; b=D9TNJkAQlwp50oFg+1dz2deeFThQjWhVYPy2Wk6n1kLSGpT6p283FdBWVzPhVK9PQq7jf9UN9QXS9rPdU12qL/RGKn62uFElpVtNcDZIS3LCLbfRVkCRfIg1JbvlkeyAPQJdwc64rVh2ea+cMZOcKmctzHwIDWuv/4lAX+c1N8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316140; c=relaxed/simple;
	bh=p5Xehmjy7mnH0JiCA6ugLDU31AUR2wdaC5vYbu696nw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Iu2VSvLAwkpSA3brXxbEjaqAZVPtpR8boubCcLDTbthZiKwQExcBV4QnXIEKsr+XbhNDnPjjc5QQ2dyw5PTxWrU0gg9cKNyGaoxA3olN0Npw/J48RpRRnLh986tjE6rW5u7mk20iYK+WY3AUbZ7CiLwd4K9rQIJskJnSXUDjwMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lj/+nOq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05155C4CECC;
	Mon,  7 Oct 2024 15:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728316140;
	bh=p5Xehmjy7mnH0JiCA6ugLDU31AUR2wdaC5vYbu696nw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lj/+nOq/mhJoO5W9psV6cPk58JfZ+f9mGQlw9fcKAx+45XF7M6c2jeMYDes6nkpfH
	 ruyeuGpTqqLwlvPQkiKaRnfz3fuJAXXbiCp4S/BXLCZXQHIWJvZ3ILUFA8RxICyk1+
	 25U5Pre44ZrmjkXNZRj6c53VUx+E4l0YwWhABABPiDMlpDIjl8Cm4i0gTQ/y/x6iZS
	 ao9ppKlkaU0FTVyBTwO05N5MvCqx2IZUAfnBjIcEl0FjIFNyO3ZV+USLJnWawq7dZk
	 Qf7X1ZxL2YCxd8IK7IQVbUphk2Lrdloo0rkgahzGvOsHoZKo4KF6jRNZQI7bSm7jM7
	 tZx2g1MPj/gOw==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Josua Mayer <josua@solid-run.com>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241002-mvebu-utmi-phy-v4-1-83783dc89b9d@solid-run.com>
References: <20241002-mvebu-utmi-phy-v4-1-83783dc89b9d@solid-run.com>
Subject: Re: [PATCH v4] phy: mvebu-cp110-utmi: support swapping d+/d- lanes
 by dts property
Message-Id: <172831613865.134526.12073367410930720808.b4-ty@kernel.org>
Date: Mon, 07 Oct 2024 21:18:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 02 Oct 2024 17:04:40 +0300, Josua Mayer wrote:
> CP11x UTMI PHY supports swapping D+/D- signals via digital control
> register 1.
> 
> Add support for the "swap-dx-lanes" device-tree property, which lists
> the port-ids that should swap D+ and D-.
> The property is evaluated in probe and applied before power-on
> during mvebu_cp110_utmi_port_setup.
> 
> [...]

Applied, thanks!

[1/1] phy: mvebu-cp110-utmi: support swapping d+/d- lanes by dts property
      commit: d6c496f05e98c6d25ac73f23fd0075913620de56

Best regards,
-- 
~Vinod



