Return-Path: <linux-kernel+bounces-365861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A1099EC72
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB361F20F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDBE227B97;
	Tue, 15 Oct 2024 13:15:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B46913F435;
	Tue, 15 Oct 2024 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998117; cv=none; b=WpnDokrYcAg0GePkK3LwWdOen7XSPE90L8M0D0U01Pd+SBMobSY0OjZ1A93iTqi4jbCm1JPR4Mq2sK0F1uxogSlk3HwBKCEjjTd58TOK3SRcLA+dXSAg5ZK4Hg7E7rhY+3JD4gBXMcVHEs+e6F7GeU9p/9v+1drei+UdHerLcDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998117; c=relaxed/simple;
	bh=m6H164m1q3pOtv+CZpHZglbzobwhvVqzW768djvjF6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXZaELDgfTUZapyDmGkdIlMnq/4gSYtmwG6mA/EpxucJhGNZN+raGD/xwxLlUSzKHFRh6+DtElAHGj5QO9WGTXSthtu5+p/5bMnlnDz+tL7R3MNNKZ2tg7U0cymr+BKYRYjOuCxLFw8VvHrb1PT9Brdr9vkQuYCQcBLCpVorRYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67B49FEC;
	Tue, 15 Oct 2024 06:15:44 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 454873F51B;
	Tue, 15 Oct 2024 06:15:13 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: cristian.marussi@arm.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	Su Hui <suhui@nfschina.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: fix the double free in scmi_debugfs_common_setup()
Date: Tue, 15 Oct 2024 14:15:03 +0100
Message-Id: <172899805803.948158.17513489982194163246.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011104001.1546476-1-suhui@nfschina.com>
References: <20241011104001.1546476-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 11 Oct 2024 18:40:02 +0800, Su Hui wrote:
> Clang static checker(scan-build) warning：
> drivers/firmware/arm_scmi/driver.c:line 2915, column 2
> Attempt to free released memory.
> 
> When devm_add_action_or_reset() failed , scmi_debugfs_common_cleanup()
> will run twice which caused double free of 'dbg->name'.
> Remove the redundant scmi_debugfs_common_cleanup() to fix this problem.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi/fixes), thanks!

[1/1] firmware: arm_scmi: fix the double free in scmi_debugfs_common_setup()
      https://git.kernel.org/sudeep.holla/c/39b13dce1a91
--
Regards,
Sudeep


