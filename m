Return-Path: <linux-kernel+bounces-289935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FE8954D7A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9783B1F231D8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DD91BF32E;
	Fri, 16 Aug 2024 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nExxfuLl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886A31BF30B
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723821393; cv=none; b=s+TIzppyB9Ua0wnEyhbECICRSl9pEeX1XHgXaR2EhP6sgcy5jMB1G/KPh+kOQnLAvjRneKQd8v4PS8Bk4t3M3LuV9kfcHkPsuPyVFtqQKW8pKytPz4n456kV2/u/4AS23rERTLpjyFlIrjVFyEMBQV3NI4yU6a65rTXnlQv5b2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723821393; c=relaxed/simple;
	bh=xIyE9SEfcQYZTbYlOOYYUjkFYLyJNpYbBdhgsnKvB4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NrGRhppKW7KI0gF4gpUECw4JJKb9Zh8rsZ4IXToXi961AYkti5DaL+rpVcSnAR/7vZgvjwjSNagrGZKOtIn/j6TOb78JugbzNAhsd36dMWuqnhFGqe7TyyU8RNwTYYeB3YGl89iILvH2iO2OlrXiIJZ+vMg7viZ0fFcbT3Aranc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nExxfuLl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C81C4AF0F;
	Fri, 16 Aug 2024 15:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723821393;
	bh=xIyE9SEfcQYZTbYlOOYYUjkFYLyJNpYbBdhgsnKvB4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nExxfuLlQC+Z/zXJFnBv3wfhOoJhCMmH2zQwf/vt4YOnkcTjDgILh+mTU+U6uI1uz
	 ov6+jNs8f6xD+4VZkx0T8ftbUwZN/KufWe/bRmpf5blVU/YPckxGHM85/IWkcI+tGy
	 m7uGsI7PPzJc5stSpLKHXqA0SqYVsXgB+DOzuo6Uc5b8W4Dl2LJtDXsQVKVnIhW2t5
	 y5SoQFZmQZ/dOQ3Ocnr0noCZdczLvCaPRclav1E49RmBTK80MEFIe2rpNgC4ZLoKZF
	 PxZaLtv1pJLpuAXBuOct1RSka++hWp61hHRp0cTdOs45kQ/O09W/sRN1Hmq7FK+L+l
	 QAXuMzfsYBfIg==
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_pmu: Use of_property_present()
Date: Fri, 16 Aug 2024 16:15:59 +0100
Message-Id: <172381010195.133769.6140795913867011503.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240731191312.1710417-15-robh@kernel.org>
References: <20240731191312.1710417-15-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 31 Jul 2024 13:12:53 -0600, Rob Herring (Arm) wrote:
> Use of_property_present() to test for property presence rather than
> of_find_property(). This is part of a larger effort to remove callers
> of of_find_property() and similar functions. of_find_property() leaks
> the DT struct property and data pointers which is a problem for
> dynamically allocated nodes which may be freed.
> 
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf: arm_pmu: Use of_property_present()
      https://git.kernel.org/will/c/48b035121a56

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

