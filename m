Return-Path: <linux-kernel+bounces-315521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BF496C3A2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3481F24699
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCC01E1307;
	Wed,  4 Sep 2024 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byY6ypwF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D131E0B9D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466367; cv=none; b=ZPqNL1Ov1e5HP2a9KMeqmNo57Lultrxcx4c9eBH8kk0d/Qd60evrSM3r/vBP3UKtioHjwgb5nT/QbUnG8vYaXkE5l6u0OSE6KKLPDwyG6OYaSYhjpoq8b4oDD5TSA5K5kBczmldS7Ysa9rHyjlu78nyBfJWOOpyfYsGu94nZ/Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466367; c=relaxed/simple;
	bh=ZwEATrRJOGeXZBjx7GhZyhIhHyYKPNwh7r9V2wLyuUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZvtjv3BE38VPtjjz3dVfSD1syL+I0fxO3IUnMxzAoxzl5Aoqk1ITwqAxeEuVjNHBaVOT4WOdvvlSK0fzoYhPgx/PJ5PUt+xXj3b3BFjppJjB2f1asADQq5AqL5HFU/RGmEylLHfziXJWk8Cadf2IxHdr6EX8niaHWEJGpfk2No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byY6ypwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F4AC4CEC2;
	Wed,  4 Sep 2024 16:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725466367;
	bh=ZwEATrRJOGeXZBjx7GhZyhIhHyYKPNwh7r9V2wLyuUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=byY6ypwFE4bTzzxiLOdSKO/4lc2VoprilWwCEz+efaZDAx8nC7HEtDzQTWOb9OZIU
	 8JQ5sNAjg4mWh1cRzNfkWh6O+jrRfwDFT6xRffu5aOJ8jyihaODGS5KmhmNKhxXPNX
	 SQD2zKnBNSV/pTDB9EL5qGsvnyQmLyO06p7G3J/ej4vC1uV3n29PXZvBVDQphOgori
	 H05qmDuipR3WszZFogIwdtLed9VeNdYY0p4YLcj7Fw8iUq/eNosKWMFk8VU0iInhcJ
	 a4RC+qTBsuhaI+q/Aj89o2cGmvrzPwWIwxDCxBassCr4OlvB1gzvLTWsWSNKOHW669
	 isukLni2+72fQ==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ilkka@os.amperecomputing.com
Subject: Re: [PATCH v2 0/8] perf/arm-cmn: Fixes and updates
Date: Wed,  4 Sep 2024 17:12:34 +0100
Message-Id: <172546227464.1263274.14807991322993329637.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1725296395.git.robin.murphy@arm.com>
References: <cover.1725296395.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 02 Sep 2024 18:51:56 +0100, Robin Murphy wrote:
> v1: https://lore.kernel.org/linux-arm-kernel/cover.1723229941.git.robin.murphy@arm.com/
> 
> Hi all,
> 
> Here's v2 addressing Mark and Ilkka's comments. I hope I've added
> sufficient clarification to patch #5, but at worst I'd be OK with
> landing the rest while that discussion continues.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/8] perf/arm-cmn: Refactor node ID handling. Again.
      https://git.kernel.org/will/c/e79634b53e39
[2/8] perf/arm-cmn: Fix CCLA register offset
      https://git.kernel.org/will/c/88b63a82c84e
[3/8] perf/arm-cmn: Ensure dtm_idx is big enough
      https://git.kernel.org/will/c/359414b33e00
[4/8] perf/arm-cmn: Improve build-time assertion
      https://git.kernel.org/will/c/ff436cee694e
[5/8] perf/arm-cmn: Make cycle counts less surprising
      https://git.kernel.org/will/c/c5b15ddf11a8
[6/8] perf/arm-cmn: Refactor DTC PMU register access
      https://git.kernel.org/will/c/67acca3504ea
[7/8] dt-bindings: perf: arm-cmn: Add CMN S3
      https://git.kernel.org/will/c/a87ef537f961
[8/8] perf/arm-cmn: Support CMN S3
      https://git.kernel.org/will/c/0dc2f4963f7e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

