Return-Path: <linux-kernel+bounces-203584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 274738FDD78
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 05:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B856A1F24271
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8721F954;
	Thu,  6 Jun 2024 03:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvSEwlLY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC671DFD1;
	Thu,  6 Jun 2024 03:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717644638; cv=none; b=VOJSlnjDtca2lIVaIVCPWYKcFUfZpQkGrb4zIYAV6qVVRTKJYAZfYputS/PiGorh7HbPv8S/okZ16iZ/LClCYj17VTVhrTsBHbhnrjJ9ZxEwPQHTTiatxq8XrWu2UDyvTFZU77Ak1L/eGJcAqqhEvgOZ0/cw16tVuok4NDT7Dpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717644638; c=relaxed/simple;
	bh=yKoMqYenKsDXJSAfLOHIldm2JIof0n4lktPheAOsA7M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Plh2iAELHCF6G6qyNmdqxPU5+aA8ro5ZctjeV04huzu7KwQoZIWAT0Q6b0Y+Xz5GgYUKE9zINoyDuTfuOpDUxB9yyzAjWulzJFDXIsNdMlrPCEucGxwI/bMmyOqg+7qtSg+75OZWTKtJVvu7grMX+fjVZUCn0fAJHyDS7XPzluI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvSEwlLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1D45C4AF12;
	Thu,  6 Jun 2024 03:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717644638;
	bh=yKoMqYenKsDXJSAfLOHIldm2JIof0n4lktPheAOsA7M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FvSEwlLYmwznzU/EzKhGRvS5noM6qFPvUHhVXPOWVDp3asS0mRQ0g4MHd45weAtPn
	 KPdN1bgzFag0gqEmz45yRzJF3Osoh6E+ucWUtL5dD///wQbiHqeJR595/mTfr5M2Jy
	 8yRlT/1vD8xO7pnZHpKfqD1QanedznBVtpcNdE8geZogZbB65vAf8vMHyeAIoVh7SM
	 qZ2IVszdJRQasO7c5xWgIxANe11iOq3/wDyfy5ZsjU48HVnUQffebS2aPxr2b253CZ
	 xRDgsyy2b9bFS0gwJN0S8ThwsSNXiyHjCrbgig+yZanImFcPlm50aEiIqb5/LG/C2h
	 UJGoQ5rPSH8Xw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E6A7AD3E996;
	Thu,  6 Jun 2024 03:30:37 +0000 (UTC)
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
 <171764463793.22288.16988875399152277741.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jun 2024 03:30:37 +0000
References: <20240605063351.14836-1-ben@jubnut.com>
In-Reply-To: <20240605063351.14836-1-ben@jubnut.com>
To: Ben Walsh <ben@jubnut.com>
Cc: bleung@chromium.org, tzungbi@kernel.org, groeck@chromium.org,
 dustin@howett.net, ktl@frame.work, linux@weissschuh.net,
 mario.limonciello@amd.com, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-kernelci)
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



