Return-Path: <linux-kernel+bounces-214602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA109086FD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9075D1F239CF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E24192B97;
	Fri, 14 Jun 2024 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckmaowUL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB1C192B86
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718355820; cv=none; b=hOGz+GW2D1dKnrw4Dzyl9GEssZNinoNXAWvMDwhTdunke9nkFGxR6k26sladj/oLcolBZCVjg1JdAU8JtUyR+9LTYkc/uGpjpHdfg0BHQux+xn0So35bFsifo9JhO4DwPQcBEz2/8ZbMWuJStP9CAJ9E1+7bOWhsaZbq4eSsJlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718355820; c=relaxed/simple;
	bh=BFmUsRHSGitrL2llbaactAdZysHGirK6i9wsDB7sGiQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eC20ZcWAYm5NMZmEXf6JzIwjIKFDmGLs5mPzr3DYT4I2994XlWfz/P3+d6eBTP0XeFZFuClRe34lbof74p238puYg24qbWalzVoCm/hiJioJWRDtEXZcI+1X/tsfK0wqy1cdjkdle0JXRoMd8KIEY1Y7am80quwurqM5tO+Dw8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckmaowUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B780CC4AF1D;
	Fri, 14 Jun 2024 09:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718355820;
	bh=BFmUsRHSGitrL2llbaactAdZysHGirK6i9wsDB7sGiQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ckmaowUL2sHmATqS4uJ49ZHhnNsOJt0Vx4q4hDM+nQu7+bqzSSXrLhsDKaLlBnUhP
	 kiymcD65FHjuf2hGsZD3S5JzQ2bAonXDsb5tZVKUWkkYhLIaLBuVqoFTGIs3POlkTW
	 KgDkMIXEopgUeUe+6z34ywIqIzwc98k5L6nh9tgyXs4IX/e8L6EEoFoAiPwzznLrV/
	 SBYk+ufSRuY2qyvqLh45w9OiwWusEDTWYpbPqfEMTXet/4G3LSj2O1EZnk5YRlAzYK
	 FYEVjyTYTI269WzsrCEmLeWHVbkLWCLtYdov+OFHVX3I/SOKfKhqR8zFvNZElCNUCg
	 q5m51Xe66cd3Q==
From: Lee Jones <lee@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20240613175430.57698-1-afd@ti.com>
References: <20240613175430.57698-1-afd@ti.com>
Subject: Re: (subset) [PATCH v2] mfd: tps65912: Use devm helper functions
 to simplify probe
Message-Id: <171835581949.3023088.12170837244936406984.b4-ty@kernel.org>
Date: Fri, 14 Jun 2024 10:03:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Thu, 13 Jun 2024 12:54:30 -0500, Andrew Davis wrote:
> This simplifies probe and also allows us to remove the remove
> callbacks from the core and interface drivers. Do that here.
> 
> 

Applied, thanks!

[1/1] mfd: tps65912: Use devm helper functions to simplify probe
      commit: fe6ba540b2ce777eb4f59991c3ef20ad8a319a1a

--
Lee Jones [李琼斯]


