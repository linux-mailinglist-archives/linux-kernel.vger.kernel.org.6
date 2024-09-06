Return-Path: <linux-kernel+bounces-318865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5381C96F452
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5FD1C2457B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92AD1CCB37;
	Fri,  6 Sep 2024 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dImowePr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5712A13AA38
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725625779; cv=none; b=SNU4nfiCoHdkDmB8X6dxSYtriX6/uTolhD0plDg7NLJOgPehFPJHNJAoH3o4Cv9UHUAWJghGkkAGOj1eyQPzuVw9bxsICg+5W6aBMIaaG/H1BxB3OvOMT9Mc1WvWZpFNmTqGIXVDIMObP/yBC6xu3cNhd+hiNl1Ai/uYY35whck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725625779; c=relaxed/simple;
	bh=PxLGu3Ca4EsrSVa4/4/UwoiPxs1oF0tr0au4Y8hzzos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swKFxjM54ECTyZ57VgU5sYnQfxMLoYLFulAHt5bi7Da+pEZqStlMqS3J1APSlVK2hdG4Je70QTD5sCZm3CWZsHd0GEF5bQ8tOCM/48cCV1qD6O3+9F0JXKcqA0L7TFqNXLbZua8WAUMeSqCxR1iQMqLy3aToLJsTUutp6cjdHcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dImowePr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DB7C4CEC5;
	Fri,  6 Sep 2024 12:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725625778;
	bh=PxLGu3Ca4EsrSVa4/4/UwoiPxs1oF0tr0au4Y8hzzos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dImowePrm0LBMSsdjBgePWCrl1V+4YlfiEwgT/22vmn/uBBkusawGKM92LE3r4Efg
	 w8hT0CeTy9sKzDdVLcf7930nWiT8axV+TM5lXVA6l91Nb2UcCCXXD1wf2C5nbUHoeN
	 t3wlH8AeKanIZcHnTo2QeZolXFVQhR5uDLke3Jf8qi7sRGKn4ohMOJmYC7yrTF6Lmu
	 C2t5mDN9yMonB4Sonch3lCOOFUm2tfHdHQOCa2YSolxgy14fTBboRlDMhASm10xGIM
	 VjmfHcFn5fiic6lBcQbR1Wn7sbKeMAsrbShtmCn+Bc4qe8Mr1nvY0kgpZg3bj3NQm9
	 PLw2RmHS66UOQ==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf/arm-cmn: Clean up unnecessary NUMA_NO_NODE check
Date: Fri,  6 Sep 2024 13:29:28 +0100
Message-Id: <172562388689.2321398.11794976470240341493.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <00634da33c21269a00844140afc7cc3a2ac1eb4d.1725474584.git.robin.murphy@arm.com>
References: <00634da33c21269a00844140afc7cc3a2ac1eb4d.1725474584.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 04 Sep 2024 19:41:54 +0100, Robin Murphy wrote:
> Checking for NUMA_NO_NODE is a misleading and, on reflection, entirely
> unnecessary micro-optimisation. If it ever did happen that an incoming
> CPU has no NUMA affinity while the current CPU does, a questionably-
> useful PMU migration isn't the biggest thing wrong with that picture...
> 
> 

Applied to will (for-next/perf), thanks!

[1/2] perf/arm-cmn: Clean up unnecessary NUMA_NO_NODE check
      https://git.kernel.org/will/c/f04b611e6650
[2/2] perf/arm-cmn: Improve format attr printing
      https://git.kernel.org/will/c/f32efa3e4bba

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

