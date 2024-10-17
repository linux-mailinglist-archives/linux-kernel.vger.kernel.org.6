Return-Path: <linux-kernel+bounces-370197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D651C9A2940
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137BE1C21BF5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA341DFDA0;
	Thu, 17 Oct 2024 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxqlAnPv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D251DF989
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183316; cv=none; b=qCEiBAS+bZ8pkSJc5SE1Oa8NUu9K25jyAwY+HBA3Tf6zLYcwWMJRBk4hViu3r9cFlILEJMYEuvjQzij6z/59RkksnTYT1nGNDN0q2WWeDigRJ55czOgtGOeDGisX3uflvTqJx37PjISQJLkNjZ2vzeM6Qep9pcM6036UJWtXwtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183316; c=relaxed/simple;
	bh=3moAy6pGdrYcuXCFA6DkXzq8Ur1/VkoJTyq+PfZTM+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kI7Bcf+1EZK7V8rElGKMWxwdo5SI5ulzdz54h4gZRTnpo9GrjnELiMh7zsWo690hqscR3fvSrEx7JZtCzMoE4Bs/486Ft/7vQsc/+kQcbHgV9a7YK3gd7uSj8L60ZLk6/x8ICf45p9MVDrIUgiMuy3JgDdsJdG3hEtWhkeL3Cxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxqlAnPv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628C0C4CEC3;
	Thu, 17 Oct 2024 16:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183315;
	bh=3moAy6pGdrYcuXCFA6DkXzq8Ur1/VkoJTyq+PfZTM+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GxqlAnPvdpgkVessPZYIH9pPdVgDfH3Fri34yuY47/Du7mykvt730erdO2mEWEAI+
	 H1KoHI6ZNwGiqXACrZlbMKgRds661XVdLa4f/cjahoyk6L7W4miPEzYe2fmYz9cO0O
	 ANb5RrmeVYlIDBs1qeMrkjEFqI56EvgT6eg/N9C8PWHi71PzMG8wHCKoaylpQDBWgC
	 B453uzaPTRUCACGF3kqywJ9JK98a1jNwhidnksKVdryeFPUWTi4l3hOKQQnnSHEKFJ
	 BFSEe3g9XShdFBytQdhpE8XJ3Xhe0an6bgViRgwwIxP+uQFalzqFtj0AQYjIcVfQH7
	 MF7I976xK80OQ==
From: Conor Dooley <conor@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Jamie Gibbons <jamie.gibbons@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] firmware: microchip: auto-update: fix poll_complete() to not report spurious timeout errors
Date: Thu, 17 Oct 2024 17:41:49 +0100
Message-ID: <20241017-reappear-stage-d7ba628da0c5@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241016-slouching-excess-d7a62fc926a1@spud>
References: <20241016-slouching-excess-d7a62fc926a1@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=772; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=t1fwqCU13x4cIAUxKtKLZibb9obfPjm98PUvZvpnv4g=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOmCdn6vZq0+eDfVLGbeQYmeV0Ypkrs+rmn7b3ggODDh6 ErVo1pvO0pZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjART3FGhm9lNi8/Xk64OiuS g91kqdr6xKKcB7K3Wz60LeZS/CbqzMrwP9JDqNe7Rq7nQrWEvVjVl3Ov1jaeX76BXWP6nk1rXtg U8QIA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Wed, 16 Oct 2024 17:35:06 +0100, Conor Dooley wrote:
> fw_upload's poll_complete() is really intended for use with
> asynchronous write() implementations - or at least those where the
> write() loop may terminate without the kernel yet being aware of whether
> or not the firmware upload has succeeded. For auto-update, write() is
> only ever called once and will only return when uploading has completed,
> be that by passing or failing. The core fw_upload code only calls
> poll_complete() after the final call to write() has returned.
> 
> [...]

Applied to riscv-soc-fixes, thanks!

[1/1] firmware: microchip: auto-update: fix poll_complete() to not report spurious timeout errors
      https://git.kernel.org/conor/c/83beece5aff7

Thanks,
Conor.

