Return-Path: <linux-kernel+bounces-224365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB40C912165
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179EE1C21193
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEB516F910;
	Fri, 21 Jun 2024 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLzHCPJc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCE116F8FB;
	Fri, 21 Jun 2024 09:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718963905; cv=none; b=dCvNvZfXINjxF5S/0dEOTp37TVMMoO/pf8JFWrWHqRKIofprAGtq0Vtz/Q7x0ReDFp0UjipuVABrCADNIwPqDQgRROwgbhWbHL27O22cmftlJ0wYZugI/zVEp1d8+gIXIyjwioXKi662GGCBw4o2txb2v5+/2FRpXTfzdjxOpmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718963905; c=relaxed/simple;
	bh=OrNncGrw3h79oAobFdd2547p2WLR/SpAFjIH1dmFFqI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CtlRL2fTjXAkVxPYAk7zeFk1pr3ZDbzhWjG2+IBhU+wb1FVl8K0/WDq3QVdmlnpDzhKwtOvfQjNd0T2K6MTUVHZEXUTUx+KWsoIHrxyReibGExyKHUciuPktgpe95QLvyqykqovsSioRc0rgTUkroSfX9nOIYoEVn/81nZFJ1Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLzHCPJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0923CC2BBFC;
	Fri, 21 Jun 2024 09:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718963904;
	bh=OrNncGrw3h79oAobFdd2547p2WLR/SpAFjIH1dmFFqI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oLzHCPJcyKa61DFbRXmqqhSO67UORBRjre5H2O3ficr8aMCgjF1xMd4pWX6NbCDXB
	 BHWaKPRakXM/vAPGY598O3BF1MwHjrRcBIHdZXL1LS7mxeXPEqYqYIHliW6RJL29rX
	 5BAXvw8QUj/ZHABGD9lKkYceffzppeLGTDxxsvMI+/h8x8dWzU3XkTGXiiK22vCe60
	 rA61xMi36EozW3cJqt2I4CKMG3xa3J/S5LBpvHwCaXSNkFZjEktcPXxyC/urTLZKBs
	 cpGM+XMIPBIAhIdn78KX0kOisIqrwpAs7szp4h9ewGILhHHey4ED8P1+ilJFN2BAPY
	 QvIYQxDUbDm4Q==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
In-Reply-To: <20240617121350.14074-1-yung-chuan.liao@linux.intel.com>
References: <20240617121350.14074-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: generic_bandwidth_allocation: change
 port_bo parameter to pointer
Message-Id: <171896390261.263874.13870424328773645625.b4-ty@kernel.org>
Date: Fri, 21 Jun 2024 15:28:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 17 Jun 2024 20:13:50 +0800, Bard Liao wrote:
> Currently, we do port_bo += bps * ch in both inside and outside
> sdw_compute_master_ports(). We can pass port_bo as a pointer and only
> calculate port_bo in sdw_compute_master_ports().
> Besides, different port could use different lanes and we can't just
> add port_bo based on total channels in a manager.
> 
> 
> [...]

Applied, thanks!

[1/1] soundwire: generic_bandwidth_allocation: change port_bo parameter to pointer
      commit: 8e8c0dfc828c3f3ba5ebcee076b979d2134a6e27

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


