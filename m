Return-Path: <linux-kernel+bounces-192217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 085FA8D1A20
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C37289E55
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCAA16D9BE;
	Tue, 28 May 2024 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPHNRnR+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2846716C6B1;
	Tue, 28 May 2024 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896764; cv=none; b=gjpq6OQp6LonjbyStvfbHpytlXRo7tlaMwnuhKjTQ13aOe31F5uDRQxAOcTRTzYZd0TsMH7lKrZjbpAPh1F883+yLHHhyjiBTn4HqvpNkGdqq/jNiT47y4S+sjgduv8v82n44bbvau0qMNBaUwaG4RZUW+8m49jC9ZRrULjt6SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896764; c=relaxed/simple;
	bh=8eK4lFuvzROCoqOLZA6LdYRepQBeBPy2QYRR9Nmd0YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HCmDkpPAwjlOB3urwRSgvcVWh0rx6NfDqx0KpBOZpU8BVPYCzWUMDFfLIENFlfZsBYsUk+K/DHzEET5y8iuYTAYn/xDbEnTalBuRwmzX03wdg23vMdTdXHPCTUXDwCfYfri0VDPnBwoBXXSiayIyc9uWVuyAAMiAtxzqB3BRjJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPHNRnR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBC5C3277B;
	Tue, 28 May 2024 11:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716896763;
	bh=8eK4lFuvzROCoqOLZA6LdYRepQBeBPy2QYRR9Nmd0YM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YPHNRnR+D1quPmAPgEqPEV0D5R4/+uh9DdwSowMS7wP+Ni08dTDPkGQpov8fOtgk3
	 EdBDPMyk3HUZ7gSOS5t6ZIX+6/3+sFBIhwjcLQr8+iDTdVBi46BeNy0uCQLWcJTN4A
	 nUjgO46k8jhMSUF0KOMPTOeP/CWb5UfduJBudCmV+joKxaf5fw8uhmOnJObPisz1K+
	 IQgGEdoRjEajOnnhCMovItmG4aBEDFi5QK70dxeWV/n/zyg0Cqu+R6PZlB1ykWQZdm
	 wjlJmlj1TmXszIRNAcIGm2QKsV306rlj5zN68YlP6zUh2iSc48ARV+AVc+dljKRxIO
	 LTK73ul2SjOeQ==
From: Conor Dooley <conor@kernel.org>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	conor@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	leyfoon.tan@starfivetech.com,
	jeeheng.sia@starfivetech.com,
	Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 0/2 RESEND] Add StarFive's StarLink Cache Controller
Date: Tue, 28 May 2024 12:44:37 +0100
Message-ID: <20240528-slimy-strum-49808758ecf6@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240515050253.38061-1-joshua.yeong@starfivetech.com>
References: <20240515050253.38061-1-joshua.yeong@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=744; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=uwmj+IvuPNH2MXt62/g3umyKOAR249jIBU85pO/nLLY=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGmhh5fUVIos+Plm27aMOWEel8Nu8X0W1Tn5X7RlrSW/h eTTXSb9HaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZiI2GxGhm3unXHHk3cr26ht yV/IoO62+UCV2o2uN1ObJXtXMFtwlzD8d9DzqP2zejZr32zvf/sZkzb9E4l4skflmdsuc56FnCu 2MAEA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Wed, 15 May 2024 13:02:51 +0800, Joshua Yeong wrote:
> StarFive's StarLink Cache Controller flush/invalidates cache using non-
> conventional RISC-V Zicbom extension instructions. This driver provides the
> cache handling on StarFive RISC-V SoC.
> 
> Changes in v4:
> - Move cache controller initialization to arch_initcall()
> - Link to v3: https://lore.kernel.org/all/20240424075856.145850-1-joshua.yeong@starfivetech.com/
> 
> [...]

I've picked these two up and applied to riscv-cache-for-next, with their
order corrected. Emil, shout if there was something left from your
feedback that was unimplemented. The wording etc seems to have been
"fixed" in this version.

[1/2] cache: Add StarFive StarLink cache management
      https://git.kernel.org/conor/c/cabff60ca77d
[2/2] dt-bindings: cache: Add docs for StarFive Starlink cache controller
      https://git.kernel.org/conor/c/c6005d4dd216

Thanks,
Conor.

