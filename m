Return-Path: <linux-kernel+bounces-318866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C5C96F453
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2AFA282F5B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B95F1CCEEA;
	Fri,  6 Sep 2024 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oA41H+BM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F3D1CCB52
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725625781; cv=none; b=MYxcaKOnqdBqWO+KBazfzqofuiAO9p/jvOeSG1ya0Kfdie2GIxYacBas3tp5dytUOdZsFQaxlrPgGf4WLr/yDgEAfucOgOzlhQ2xZHMqlrynaICuaxrEKeCEca3IZO2K24xpVt817s13VG7yqqazDGX8yH2xDkoW9mXaE2SQdfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725625781; c=relaxed/simple;
	bh=45DAADY0pyqAODXqj3oHoGFjPAbErdOcV0lQ8BoqTHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=etOhe/5PDd/2pqVf0BXO0I1Eg5Nqi4yq+ywZwG8hfv1+REKfn9WlVrv+fMIXRCr6isE0VVK82cn1xyaRFv7RO9nzemuA2Qlp1UXPCVHjgi0XvYHKUlCUdzV7fz8ixBOC4FkjHi0qLiv7D652VYktpOJC47UfEpfTzfV2S6PwwXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oA41H+BM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E7BC4CEC7;
	Fri,  6 Sep 2024 12:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725625780;
	bh=45DAADY0pyqAODXqj3oHoGFjPAbErdOcV0lQ8BoqTHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oA41H+BMPguDymuEQEWvvJkU9pO34rJN8UTIzUqbvgD0b8IB/VZTmPmjeAEp8bryd
	 u1Hgu2bx4jh4Pvk0xLSsUEqtT/CZnmE8KWWx7B2pavI/Yt894JCSXjyK6mglXGONnV
	 wv6EXqWvtlewRcRh0CorS+tpLHAmOrikK24sVU0VAT8L9AaOjRo2WrTvQKzpHGkU8H
	 GMy4BXVzaBmc+o4YwPdfn9j0q1pjfyhkDGxP+I401hognx9Wcw49ZsQ3aKQETNZQcU
	 VIWhr4++gh39hNtq274zIprcAmlBLGiD0yhkhkA0PrIaJmpMkma54wHx4Z9MU/GruX
	 Ttd+pXeO8omBg==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jialong.yang@shingroup.cn
Subject: Re: [PATCH v4 0/3] perf: Add Arm Network-on-Chip PMU driver
Date: Fri,  6 Sep 2024 13:29:29 +0100
Message-Id: <172562390943.2321607.6719759678073276486.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1725470837.git.robin.murphy@arm.com>
References: <cover.1725470837.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 04 Sep 2024 18:34:01 +0100, Robin Murphy wrote:
> v3: https://lore.kernel.org/linux-arm-kernel/cover.1725037424.git.robin.murphy@arm.com/
> 
> OK, hopefully these really are the final trivial tweaks :)
> 
> Thanks,
> Robin.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/3] dt-bindings/perf: Add Arm NI-700 PMU
      https://git.kernel.org/will/c/abbe74dd105b
[2/3] perf: Add driver for Arm NI-700 interconnect PMU
      https://git.kernel.org/will/c/4d5a7680f2b4
[3/3] MAINTAINERS: List Arm interconnect PMUs as supported
      https://git.kernel.org/will/c/91df34ef2d88

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

