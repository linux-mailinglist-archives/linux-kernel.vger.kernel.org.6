Return-Path: <linux-kernel+bounces-370051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 319879A26A4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86F31F23DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689F21DEFC9;
	Thu, 17 Oct 2024 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IH/xHH/l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C964C1DF266
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179087; cv=none; b=OjWmY22xzllgwkrHfuK0XKLnKLJAse1g5BjcFGRqNqq5kcJH8G1rX8f4MKyLr7zZFNA2vlWKeow/y1XZx8jlLjnr3Nh9UTXphPJdjGjJscl2JhHiT9LrmXOzewMd/COs0pI4JSXvg9Ow7Fv7CO1i9K45dVVJzhNm3v+0NCRMGws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179087; c=relaxed/simple;
	bh=HG/xpz5PLEPPBftcA0Be0lkUCpIu/vuSmntl93ETESs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h5AJL3+D+zQRCpJbdlqo4ztPORGLCm63PLYHla8Ug/8rY38i4zqySZ1SBCzPRyUSO9Hpp2dhX378cVzCwxx0Dpj8ruLpidlDgHjYfs1ia7VkSYHDYLhpy/E6i7dZdLAPflH/V0vYmCW0DNeERZplnY8sYhTXWbnKAYrZomnxUxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IH/xHH/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23243C4CED1;
	Thu, 17 Oct 2024 15:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729179087;
	bh=HG/xpz5PLEPPBftcA0Be0lkUCpIu/vuSmntl93ETESs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IH/xHH/lVKQns1r64DUdX3QBTgD2vGwog7Mg6USSboJDDblfIi29CV6noQtW6Fco/
	 vcqfNLX4KRM3tih2PoIh/phQnBKKSs9XMpBtQ3KKfJigkOWSFTWiXj7/CYu/efv+U7
	 OpXtDoic6c2Fry/pQAbGu4WKDU+KvIGkLSzGS5cVBiuEGatQ08c7hOkSGIc7VYrDIW
	 WYnFnnlBSCSyUCNM1HySbO/C0pMVZjM2eCF67b3ODdAya/sSiOWLSD+59eldcsAV0F
	 9wRqDQLqFYMHr9GTjQQ49iB0QZ1a/7if6cd+lsGIMioIjsNU1CM8L87ZZ4Nv7b/HfR
	 rXITdZP0VP5ZQ==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>, linux-phy@lists.infradead.org, 
 Minda Chen <minda.chen@starfivetech.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241015070444.20972-1-minda.chen@starfivetech.com>
References: <20241015070444.20972-1-minda.chen@starfivetech.com>
Subject: Re: [PATCH v3 0/4] Fix configuration for on-chip USB 2.0 support
Message-Id: <172917908477.278159.9345933030080410252.b4-ty@kernel.org>
Date: Thu, 17 Oct 2024 21:01:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 15 Oct 2024 15:04:43 +0800, Minda Chen wrote:
> While mainline has support for the USB controller of the JH7110 since 6.5,
> this never really worked in USB 2.0 only case.
> The reason for that was a missing syscon setting that prevented the
> connection between USB 2.0 PHY and the controller. This series finally
> fixes the issue.
> 
> Changes in v2:
>  - fix copy&paste mistake in error patch found by kernel test robot and Dan Carpenter
> 
> [...]

Applied, thanks!

[1/1] phy: starfive: jh7110-usb: Fix link configuration to controller
      commit: e10c52e7e064038d9bd67b20bf4ce92077d7d84e

Best regards,
-- 
~Vinod



