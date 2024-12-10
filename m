Return-Path: <linux-kernel+bounces-440141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAA49EB967
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5782830B2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C018D214229;
	Tue, 10 Dec 2024 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALCANVvO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CD6214225
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855702; cv=none; b=muHKFdZKY8jqi4JXJAbzAJgmugEVQ1Ex3y44N+8W/BCdN97gA1dOgaRkFyF7JPep7fhd8FAYrcnXFg0//67R3BFWtP74G4QxyZRMNuKra1t09A5ulJlPYxCw3UFiKrdPEQ2Uod4ICp56eU59+yrahrMO0bcpbsF6G85HIgQzDe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855702; c=relaxed/simple;
	bh=NaoW2XYUkM/DqsZGjkM8Izv9P6koZoIMPQ7uTpu9s5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ozNitkakeP4AXnkA9hoWTDWwrnLkE+zWS6+ABKu9F87S+5Ijrn4kR1hD7auLbhp3ddbjsqQSrPtx/iEy0ohdb73mPhiyPgRIKRqYSf94neVtwCoqh5kYgYyj0jXfMqJi3br1d0NvRamTo3W9PC6Ibb2OSnvOpFpeHvFtVyNeazs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALCANVvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308C4C4CEDF;
	Tue, 10 Dec 2024 18:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733855701;
	bh=NaoW2XYUkM/DqsZGjkM8Izv9P6koZoIMPQ7uTpu9s5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ALCANVvObH03L/0We+6GkNNw4Q7avtq8khyjeqDHgIvpnkyqkSeodUkwD+mGYFHoH
	 HLUHjjuCJpXZ8cl1B+M97MXVh7+Y306t4b0zIbjxHDt0VjucmyR+n/JOKKx0eb91NN
	 ODgYOZXRcvzWycRSVwoZt9uN4wYLJCsvVw3PKcatqdaeGh25HNZAifkptBdvyH3Jk9
	 D4b9oalrdlVbpqJ374jU733yFKiqpMzl3MPeGycLv6KAuSri6kOlyG/MQyNhTMMVaj
	 AUniXivMev41wMSAnZ9Ir/AcePWy1WdqIF8h2Ej/r/IWkljXP38iRtPisTBU4bdgis
	 /GohIHv1T2WEA==
From: Will Deacon <will@kernel.org>
To: broonie@kernel.org,
	anshuman.khandual@arm.com,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] arm64/cpufeature: Refactor conditional logic in init_cpu_ftr_reg()
Date: Tue, 10 Dec 2024 18:34:45 +0000
Message-Id: <173383298019.2041619.15466719029042277892.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241115053740.20523-1-hardevsinh.palaniya@siliconsignals.io>
References: <20241115053740.20523-1-hardevsinh.palaniya@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 15 Nov 2024 11:06:35 +0530, Hardevsinh Palaniya wrote:
> Unnecessarily checks ftr_ovr == tmp in an extra else if, which is not
> needed because that condition would already be true by default if the
> previous conditions are not satisfied.
> 
> 		if (ftr_ovr != tmp) {
> 		} else if (ftr_new != tmp) {
> 		} else if (ftr_ovr == tmp) {
> 
> [...]

Applied to arm64 (for-next/cpufeature), thanks!

[1/1] arm64/cpufeature: Refactor conditional logic in init_cpu_ftr_reg()
      https://git.kernel.org/arm64/c/e52163df7721

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

