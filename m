Return-Path: <linux-kernel+bounces-305993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9DB9637C0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EFF01F21E2E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82AA199A2;
	Thu, 29 Aug 2024 01:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHr6sh6X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB2D4C9A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724895167; cv=none; b=ivBhyRYUyjSPCo6EEvKEAWfF+AYwDacVyGChGart0DeJQB+l4DZYgb90NVde7cW3aYNdoOtisH6LJ+CUSnAnfvs6lHZQHGfRwwutkeeNe0G4Ygc6gcK8RlHyf/IhPg0/b5f0H09PufO8PEtmvwghfk0ah4r5FYMrPsFGKtSMFio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724895167; c=relaxed/simple;
	bh=e2RMCpT/WiIcy+SCBMormU1hEiGZIwbbyjX6mATlews=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMjg0iLBn/lPFKXMuwZDFHOrTeOSho03jFtjoMp5lLpfUU/nqeIauJcjOncgauh0c2OKMoCdtLCGNQ7qAHlCzbbnMah58pmrWov2TkwGvR7Z/Lqguu6xbU4pTSdBiMpvfDqlfFBeQoAuaMD3fKylSzCJBzODkzgfuIYLtS5vNI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHr6sh6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8DAC4CEC0;
	Thu, 29 Aug 2024 01:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724895166;
	bh=e2RMCpT/WiIcy+SCBMormU1hEiGZIwbbyjX6mATlews=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hHr6sh6XudGbemjsMZiuBHvdxJh55BXFaUapjckxDhoLQ4VrzMZixwG3APoxr0Z9e
	 jZVbHd1mPGQqxQPb2ADoh8QXrHpn01ss66nmQDfrGTaGx/LREf0ALN33CQ7OcMI/tm
	 Q5D6V7bXLpF5yBICrfk9HM0m8pHtAbYLRQ3LDyyGVQnUWoXiZXn97SGjeRJu1M/l0J
	 3iy7DP1OtXP2VKLD4EaNQZYqkc7z4L7S2XeIIeNy2IB34mZDHisn2/X54Pvv3oWTXi
	 lKuALUXNP3QXYtDvUXDH2Q3D5Ao/o0ppXZEISG44hLEzwVPbC8uQxEbstkSZHn2rL2
	 Mbma+XpU1WMpQ==
Date: Wed, 28 Aug 2024 18:32:46 -0700
From: Kees Cook <kees@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: brauner@kernel.org, akpm@linux-foundation.org, zeming@nfschina.com,
	adobriyan@gmail.com, rdunlap@infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] user_namespace: Use kmemdup_array() instead of
 kmemdup() for multiple allocation
Message-ID: <202408281832.4E29E7727C@keescook>
References: <20240828072340.1249310-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828072340.1249310-1-ruanjinjie@huawei.com>

On Wed, Aug 28, 2024 at 03:23:40PM +0800, Jinjie Ruan wrote:
> Let the kmemdup_array() take care about multiplication and possible
> overflows.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

