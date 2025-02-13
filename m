Return-Path: <linux-kernel+bounces-513680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723CCA34D60
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4FA53AB228
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA99245037;
	Thu, 13 Feb 2025 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGe7qyOt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3681245030
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470624; cv=none; b=abzYWTldnJEYZ+HNrSe93l1yXc95XqehNuDeR7GNg5yVh2wsCeIEak1A/frUoA+h8bEp7hLE7BjeUCUOztkEbnfpr/XyvrbNDx0L/Z6tSiBIcvyL2hajTH7rLQSvUEg3be9XTlpf6mVrkT/zi8XU0VPNXcy7+stS/LN0qHadJQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470624; c=relaxed/simple;
	bh=OL4dYF305QXhH4qXKBx1QHuLXwMdLA2pA/wG6iulJos=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hsPjJaB6Qxj6tMjpJn6BRjeqyD8fm/xtozj+xpZWahosAudOJAVycaEWzNvgprRbCKJfYWw0OriyKuwb56ImPhTtI761gjaK8ASrnzDC/T4MJB0QYQ86n2vIik6eQlwMkf0sIkpTFzA+iYJHp30kUr/sYVik+FDhdfQyZFPUCew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGe7qyOt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2344CC4CEE5;
	Thu, 13 Feb 2025 18:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739470624;
	bh=OL4dYF305QXhH4qXKBx1QHuLXwMdLA2pA/wG6iulJos=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VGe7qyOtM0BKL/p/Nbjgjow1OHW4jD6ULOIjuBji1MLIqLvbTlV1mtX4MYBGEqkmG
	 Qp8uC1or2PGChwk5w8TqiXQnmpSpoFbODVNfWl23rhFH9Nh2StCo9+6TDjwYlbhpW8
	 zvMIvAWZA6/5I7Gd0dvL0vHxAwUqBTGmZhWIAE+ikDeplZBg6cCiqOWOGtQ+/RzAKC
	 QLeqE8RNkiINXSgjS28CrGrATGQlvykKG4l3WtQo5qkA479vviNBdnVWrwfH+UU9K0
	 BuJRV9e1ioFPoXM1E8bk9jAGDuJpL9ss+WXYmRZiaghUC/kaEDOocX9/j5nDTIqTIm
	 ZVEFCgPK0NLlw==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20250209-phy-fix-set-moe-v2-1-76e248503856@linaro.org>
References: <20250209-phy-fix-set-moe-v2-1-76e248503856@linaro.org>
Subject: Re: [PATCH v2] phy: core: don't require set_mode() callback for
 phy_get_mode() to work
Message-Id: <173947062273.294083.8317890397960470675.b4-ty@kernel.org>
Date: Thu, 13 Feb 2025 23:47:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sun, 09 Feb 2025 14:31:45 +0200, Dmitry Baryshkov wrote:
> As reported by Damon Ding, the phy_get_mode() call doesn't work as
> expected unless the PHY driver has a .set_mode() call. This prompts PHY
> drivers to have empty stubs for .set_mode() for the sake of being able
> to get the mode.
> 
> Make .set_mode() callback truly optional and update PHY's mode even if
> it there is none.
> 
> [...]

Applied, thanks!

[1/1] phy: core: don't require set_mode() callback for phy_get_mode() to work
      commit: d58c04e305afbaa9dda7969151f06c4efe2c98b0

Best regards,
-- 
~Vinod



