Return-Path: <linux-kernel+bounces-518369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E91A38E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 22:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B883B3FFB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247391A841B;
	Mon, 17 Feb 2025 21:32:24 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3141A841E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 21:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739827943; cv=none; b=eTQO7ktv55T/jjkjd6dehqWhiBO8uPIIudUDaw6YsEg8pvbmAtjw4oVSg8sWaXkkwCS3sc8B+ZTdKtCn6awUjgn4uDz/x247+HWIxqhx9HZcAVlG/xq5A39e/9Cq6y/HVJ6nHgiRVehCmSooSB2CokusHTB/2OrfsUXaz7ptTEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739827943; c=relaxed/simple;
	bh=+tma7wQ8UDOVlTVIdNB2UD+EdsmX5i4zkU90QGZG5XA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hwq5myRMdpyUw9fgdMg0J0IPG979KGNrhnbtjS2p2SpWPotR+eZ9RjrbdQsE/ftRU31t9r0CgsBYrzAiOLL6lD174Ljs9xrm19h2B4UVVmE6JQTz25Gqg0fwtDJN+bZLhWJ3xLU+E8ijjo1pG1AZVbOwEMVhe3lXrLzyo0Fy2aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AFAC4CED1;
	Mon, 17 Feb 2025 21:32:21 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	sudeep.holla@arm.com,
	vincent.guittot@linaro.org,
	beata.michalska@arm.com,
	Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Will Deacon <will@kernel.org>,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	dietmar.eggemann@arm.com,
	pierre.gondois@arm.com
Subject: Re: [PATCH] arch_topology: init capacity_freq_ref to 0
Date: Mon, 17 Feb 2025 21:32:18 +0000
Message-Id: <173982791747.4020779.3793606958598624272.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240827154818.1195849-1-ionela.voinescu@arm.com>
References: <20240827154818.1195849-1-ionela.voinescu@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 27 Aug 2024 16:48:18 +0100, Ionela Voinescu wrote:
> It's useful to have capacity_freq_ref initialized to 0 for users of
> arch_scale_freq_ref() to detect when capacity_freq_ref was not
> yet set.
> 
> The only scenario affected by this change in the init value is when a
> cpufreq driver is never loaded. As a result, the only setter of a
> cpu scale factor remains the call of topology_normalize_cpu_scale()
> from parse_dt_topology(). There we cannot use the value 0 of
> capacity_freq_ref so we have to compensate for its uninitialized state.
> 
> [...]

Applied to arm64 (for-next/amuv1-avg-freq), thanks!

[1/1] arch_topology: init capacity_freq_ref to 0
      https://git.kernel.org/arm64/c/004b500a9031

-- 
Catalin


