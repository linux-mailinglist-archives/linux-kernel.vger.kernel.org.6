Return-Path: <linux-kernel+bounces-573570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA51A6D934
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E392D169042
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B7825DD13;
	Mon, 24 Mar 2025 11:34:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C671E633C;
	Mon, 24 Mar 2025 11:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742816091; cv=none; b=CXp7I2I/XKGqF/1XIL138Eq7u7pTav2/plSh6lGUf29PCpTiKs7/HzRHKXfnBWp0Out8qRswv3eqDQwd7XnmuKclQ/r+6giSiIw9gzc+oCNOZL9GyqASZ2jrAT7y1ygqzS3WR4u1Ey1Bul6XI2Rp3TPNsAwTwFJ3LfoZIFfz70s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742816091; c=relaxed/simple;
	bh=pI8OV3S5gqKdPxqh70UVk+GABqcMT3BDTM73LIZiSdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKWnB3V4iw7AFXelliDvUGWHoLIL6UOLpNtkHtafxYkkoHzn5Rd/WUjy+yn5ZzzjRr+8tWKEL87NyhxV/zV9fXCqrMM6FToHEAXRLPoiRmplWrmeaWfs6BLlQIe+/cNVDLDm7kIq/gTiRUurhBamHoJovWSZ7Tsr7xvoW1CYMVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDF831C14;
	Mon, 24 Mar 2025 04:34:53 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 362633F58B;
	Mon, 24 Mar 2025 04:34:47 -0700 (PDT)
Date: Mon, 24 Mar 2025 11:34:45 +0000
From: Leo Yan <leo.yan@arm.com>
To: Marcus Meissner <meissner@suse.de>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, carsten.haitzler@arm.com,
	james.clark@linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: annotate asm_pure_loop.S
Message-ID: <20250324113445.GA604566@e132581.arm.com>
References: <20250323085410.23751-1-meissner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323085410.23751-1-meissner@suse.de>

On Sun, Mar 23, 2025 at 09:53:45AM +0100, Marcus Meissner wrote:
> Annotate so it is built with non-executable stack.
> 
> Fixes: 8b97519711c3a0f9eb8274a227dff3fe4f0f72a2

Fixes: 8b97519711c3 ("perf test: Add asm pureloop test tool")

> Signed-off-by: Marcus Meissner <meissner@suse.de>
> ---
>  tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S b/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S
> index 75cf084a927d..577760046772 100644
> --- a/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S
> +++ b/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S
> @@ -26,3 +26,5 @@ skip:
>  	mov	x0, #0
>  	mov	x8, #93 // __NR_exit syscall
>  	svc	#0
> +
> +.section .note.GNU-stack, "", @progbits

With the fix tag change:

Reviewed-by: Leo Yan <leo.yan@arm.com>

I found actually Jan Stancek has submitted a similiar patch [1]
~2 years ago but we missed, sorry for that.

[1] https://lore.kernel.org/linux-perf-users/e79288922fbd0bad6facf06488735ec74f811d1b.1689588798.git.jstancek@redhat.com/

