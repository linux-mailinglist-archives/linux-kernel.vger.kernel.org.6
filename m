Return-Path: <linux-kernel+bounces-297916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C7995BF17
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40CD3B22945
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E9A1D04A3;
	Thu, 22 Aug 2024 19:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdMB55xV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571E77CF16
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724356085; cv=none; b=E58IKFOCtHnULSC1pePwlPBCkyKDnoIlg5LS8keKFmfwX4OaEa++yx+Je/JAmiepUE+MITfvsxPMB6GulfOZkCjf0MIUqbfQPRcn6WW/ef4G38UkwPNLs5smkJGXq9m8X1vBGfeRTFp78+zn3phtanwknPXTQJ+DZeZ+Ed36fus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724356085; c=relaxed/simple;
	bh=B/7n1iDkDM9S1I/I5MGVGNZ/BzLhUiUzeHvKd5ek8bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fKgFzgGkCUB618ZaqilgiSMlVkhAsdHnoxNYDopasjKfWHaZ0KxUODuzGAmtLYpwia86vieA9DPI/2c69QkpiGGzTsmfJ1W6MUBPmJ9N4xC+N4lP3tQ6PrWTjDTWsNrKBYf9Zf7vi7yiP2iDF/LvMhZLk1NzkopRHKeD4k1RsbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdMB55xV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A610BC32782;
	Thu, 22 Aug 2024 19:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724356084;
	bh=B/7n1iDkDM9S1I/I5MGVGNZ/BzLhUiUzeHvKd5ek8bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BdMB55xV605LWffCmP6sntGwpQ3yiV1M8J9tkpP5gP9/avEaEUoy3qwK1xNoK6x77
	 QqVYQSdLJ747gdv4CxylBDumSlUUBPgNW7NhfZ5Vaw3RqyzmiTplU06LBKh6WhAMoW
	 Qih+mz/fyuFRJYdvZhdulyzeme28N0LTUwcEVkn1apDzBTUzpp99wnwVkyWv9Dsltm
	 XxzfqBWksvF2FJ3jGPmiJjHupRpDwohKu3ken42bs8nXQAwwn4uTW3i5TSrw3/ivpc
	 u/c9dlNvPzmbSUvWryPIB9XYNaAHW0vZosEBz5eAGQL3jrXUJqhNkQ+Sz3nl8ICLWZ
	 oXi+MqC+MAA7g==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Steve Wilkins <steve.wilkins@raymarine.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] firmware: microchip: fix incorrect error report of programming:timeout on success
Date: Thu, 22 Aug 2024 20:47:48 +0100
Message-ID: <20240822-undercoat-boozy-5f40ee13dc24@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240809-acclimate-droplet-9a782ab70193@spud>
References: <20240809-acclimate-droplet-9a782ab70193@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=538; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=u657phBycd0WhGA0VPLz0UrqZOe2t9Nm2H4SbvRtGbE=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGnHpz4R3XexVGVCSLxfcpLvr2cNL+S4+SONC5dvicrZn XZt7/rJHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZiILxPD/3LWPceZrzlZ71K9 /tOML4ZvX8Ks5RylyhdNZ25iVClr6WBkOOMounKPaj33ehXNVxsj1M7ce9CWdVxJ8Z5H4Ru2U75 BrAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Fri, 09 Aug 2024 14:47:44 +0100, Conor Dooley wrote:
> After successfully programming the SPI flash with an MFPS auto update
> image, the error sysfs attribute reports programming:timeout.
> This is caused by an incorrect check on the return value from
> wait_for_completion_timeout() in mpfs_auto_update_poll_complete().
> 
> 

Applied to riscv-soc-fixes, thanks!

[1/1] firmware: microchip: fix incorrect error report of programming:timeout on success
      https://git.kernel.org/conor/c/591940e22e28

Thanks,
Conor.

