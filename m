Return-Path: <linux-kernel+bounces-358953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DB99985B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956171C23BF8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0292D1C579F;
	Thu, 10 Oct 2024 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkH7VwR9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A13C1C5787;
	Thu, 10 Oct 2024 12:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728562563; cv=none; b=Kubk+rsHNWvY/19nCE0QQhmg4GN2UFcS+kozhi0O9j0cC2NIePV+1KSt9aRn8oByC3hjM3zadiCB42tKTQM5OnEZ8clwtsgSOiRBBau4/QpXnhFqlB5rsbctTqMhYJNdAnQ9x7Y0dOxzlkfyGoXaQNUXg7Ai3HH/NQ7PxPZ36oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728562563; c=relaxed/simple;
	bh=cWc/rW7yqr34qMiz2wK6ecHqorVL/CciE7qxdFc+cUI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GtYSaIv5A9MxoWPfPQkzUdCtZFgMdcYBgL/8oV8BYHDFxD5sUVva3qoAedgH2AypIIiFxvJbJf2j+JHNMlw1wGlatnda0z0kRawGFgkvAGOlCxivCTm4Gkopy/0VUo61g2NWlxw6awjJR53SaBmdlQnHbYNQTc9Srd00H5vM6jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkH7VwR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE93C4CEC5;
	Thu, 10 Oct 2024 12:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728562562;
	bh=cWc/rW7yqr34qMiz2wK6ecHqorVL/CciE7qxdFc+cUI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MkH7VwR9eUq2xi/V5ij2i7Pg1RvSrZMz+gV8CSzLLBXe6Lq6kEVyKlqigdBULDe0t
	 vgsVIi8JD2s8aZ72OCdCweHly9axwvK7M+EB03ruT1EeDvsqe5iPy2bSnXL0IDYu/K
	 fqUzdJPrw4MRVLhuRz1iDBlOmjpBNpyfpRIMEh2wZ2UG5hfbgROSnfxNxLekxqWP//
	 62skDI3teDykZQ2NBCMYpgZeHi/DWW3JoYppiBncaG1DYU1fF3hOwpKbTsFMDZDLEb
	 2sM9ZQ/utdaVXW/odKviUNHySDxV8v4ADh0CDNLgv9ud3wDUgF45jO38pMEEWhOZ1P
	 e4lNAF8crIjvQ==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 pierre-louis.bossart@linux.dev, bard.liao@intel.com
In-Reply-To: <20241003094830.119673-1-yung-chuan.liao@linux.intel.com>
References: <20241003094830.119673-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 0/2] soundwire: cadence: programming flow corrections
Message-Id: <172856256088.307286.1629248091039124490.b4-ty@kernel.org>
Date: Thu, 10 Oct 2024 17:46:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 03 Oct 2024 17:48:28 +0800, Bard Liao wrote:
> To follow the recommended programming flows.
> 
> Pierre-Louis Bossart (2):
>   soundwire: cadence: add soft-reset on startup
>   soundwire: cadence: clear MCP BLOCK_WAKEUP in init
> 
> drivers/soundwire/cadence_master.c   | 30 ++++++++++++++++++++++++++++
>  drivers/soundwire/cadence_master.h   |  1 +
>  drivers/soundwire/intel_bus_common.c |  6 ++++++
>  3 files changed, 37 insertions(+)
> 
> [...]

Applied, thanks!

[1/2] soundwire: cadence: add soft-reset on startup
      commit: 6124a4063b8083e4d973f60c09ddb7abdbabe57f
[2/2] soundwire: cadence: clear MCP BLOCK_WAKEUP in init
      commit: 830f1aa53c0287eae667fa5f0a690bec34a10a3f

Best regards,
-- 
~Vinod



