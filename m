Return-Path: <linux-kernel+bounces-203585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E09F18FDD7C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 05:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8991F243DB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142F02576B;
	Thu,  6 Jun 2024 03:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MusQma16"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5722120330;
	Thu,  6 Jun 2024 03:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717644639; cv=none; b=um5lAFF95uRDkRoqhV0vZ9VIiDJT9qHxbDhRAg93fVvNFVvOh6Zv8eE6tQHOOgAOTCx3yAhJfvfSfX9TwevFW6fDoFULhEo1UklwngXMNsE/urTTckZQbC1Ncka2/n6CYGTXUqE9cThy2PYFBZ9rr4RHMUDt8KNXH1HxI09FRW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717644639; c=relaxed/simple;
	bh=cbyItvu2defQvqg32H+CbFerKlbVJnymcQicUMfF1Rg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LqswD/bHLug0U0VGBznXJcwtOVMkD0gBIGJxU/HS4U3izYBlHDV5sah4bAa2B60V0JRW7g7zTomtj99jx/nXAo8LJxqMp18RpKly/Dll/qo5PXLQ+8a/XdJklNPVZeZZQRnM9jtw1vfFP/8KtzWXmcdi5V4qycWxJt8MKeezapk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MusQma16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6CBAC4AF0F;
	Thu,  6 Jun 2024 03:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717644638;
	bh=cbyItvu2defQvqg32H+CbFerKlbVJnymcQicUMfF1Rg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MusQma16PoyeRB48POtqOLwxxgj5p5CsTs0iI3TdoDW4pwX974qvZkBSsw7mgEoeq
	 kTJvzlReckIkvTRB2/NWmtvr5MJSy3EHZb4ZS88CDnV7etz3VaUQ8QVSGrckmyC5bK
	 dsywe1wrFNT7TNb8pLSIGMPd54rJOrOIeE2tERErufdkUayrupZIW90M2FYM3RfCGu
	 ls9MoQQiz84/YV/wGa5HJpLE1wMZdSWYuwG6OsJFGA2SCijF/0yIfQeDpGcYhd57P2
	 s4lmt201YT0PwHndidYzyExVqxyT7LRk3ZsogjrQemwNtcV/80vHVU9n3zsY1J8aab
	 340jD+h7s48Yw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB41ED3E997;
	Thu,  6 Jun 2024 03:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/5] platform/chrome: Fix MEC concurrency problems for
 Framework Laptop
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171764463882.22288.7075641947422598016.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jun 2024 03:30:38 +0000
References: <20240605063351.14836-1-ben@jubnut.com>
In-Reply-To: <20240605063351.14836-1-ben@jubnut.com>
To: Ben Walsh <ben@jubnut.com>
Cc: bleung@chromium.org, tzungbi@kernel.org, groeck@chromium.org,
 dustin@howett.net, ktl@frame.work, linux@weissschuh.net,
 mario.limonciello@amd.com, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Wed,  5 Jun 2024 07:33:46 +0100 you wrote:
> Framework Laptops with the Microchip EC have a problem where the EC
> "stops working" after a while. Symptoms include the Fn key not
> working, and "bad packet checksum" errors appearing in the system log.
> 
> The problem is caused by ACPI code which accesses the Microchip EC
> (MEC) memory using the Microchip EMI protocol. It uses an AML mutex to
> prevent concurrent access. But the cros_ec_lpc driver is not aware of
> this mutex. The ACPI code and LPC driver both attempt to talk to the
> EC at the same time, messing up communication with the EC.
> 
> [...]

Here is the summary with links:
  - [v3,1/5] platform/chrome: cros_ec_lpc: MEC access can return error code
    https://git.kernel.org/chrome-platform/c/68dbac0a58ef
  - [v3,2/5] platform/chrome: cros_ec_lpc: MEC access can use an AML mutex
    https://git.kernel.org/chrome-platform/c/60c7df66450e
  - [v3,3/5] platform/chrome: cros_ec_lpc: Add a new quirk for ACPI id
    https://git.kernel.org/chrome-platform/c/040159e0912c
  - [v3,4/5] platform/chrome: cros_ec_lpc: Add a new quirk for AML mutex
    https://git.kernel.org/chrome-platform/c/38c31b1d737b
  - [v3,5/5] platform/chrome: cros_ec_lpc: Add quirks for Framework Laptop
    https://git.kernel.org/chrome-platform/c/04ca0a51f1e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



