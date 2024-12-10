Return-Path: <linux-kernel+bounces-440139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE68B9EB965
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90E72282755
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC992046B7;
	Tue, 10 Dec 2024 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ug9DywyU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13B320469D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 18:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855697; cv=none; b=AUHFPg8q9btbrjFsoVLXVWpP/72IGoMggl+DWfnQ+ohDfupXYjlrYRDAYxSSLbGMDWcM5XIffEXKBhvTVv7gXzf8YNOtGrIYJ7CmPkUfNRLZ5yyY0HTeFAGJuxGY5u7aO2kctnciv6V8vxScSiUiDG55iruO4wUds5ZcGY/Q4x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855697; c=relaxed/simple;
	bh=vttEYAubWNzS+Rst5S57Guvga5iqDX/eDF9eIn6/hlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLFDj3KBzxS2VeQMwAZ3gcKnNL/dIQ6wtpTsv0ZChScDFf3Dd65yA2QanKE5AKQceHr4nmQMsbrISAtMlIKiS8hWq0ei5EGV7I3sE5ZTlYDFjvWEc+DSj0dtdoigi1n2tX8HTyZB7yEzz8lGMYNl2GUXuDCVEZp/fuHH1waVlZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ug9DywyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4695C4CEDF;
	Tue, 10 Dec 2024 18:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733855696;
	bh=vttEYAubWNzS+Rst5S57Guvga5iqDX/eDF9eIn6/hlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ug9DywyUt+XJD2W5ydcCPZZgNmDmDbzoXt0/YweBsgyVW3DGK17RVbkbdlg3es8l8
	 bfit4n5isKRh4RU+fZx140TotLElvirchWqlkk4SgdvPxtRxcJOGuv3bjqruHXGhEB
	 NCxC4jx9nxWyRgvBUkGtb12fqvI3uLHneoiRcrCNah7ueVM2AE0JBULiNs9igKiuXh
	 3O5juq6ewRDvjid3UTsEHkE0eenBiA/HPomYgzlEyIL8P7ZHOQKbA+6vLfdGM2MYVB
	 gWyZj0ubA3pQQSU9knizeW/QyMlmF2WGpLWaFZ3k/TNP3QTazq9se4SdkR3I3rYccz
	 qXxZO4WB7bC0A==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Ensure adequate HUGE_MAX_HSTATE
Date: Tue, 10 Dec 2024 18:34:43 +0000
Message-Id: <173383046649.3808051.6059989869125290793.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241202064407.53807-1-anshuman.khandual@arm.com>
References: <20241202064407.53807-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 02 Dec 2024 12:14:07 +0530, Anshuman Khandual wrote:
> This asserts that HUGE_MAX_HSTATE is sufficient enough preventing potential
> hugetlb_max_hstate runtime overflow in hugetlb_add_hstate() thus triggering
> a BUG_ON() there after.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/mm: Ensure adequate HUGE_MAX_HSTATE
      https://git.kernel.org/arm64/c/1e5823c8e86d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

