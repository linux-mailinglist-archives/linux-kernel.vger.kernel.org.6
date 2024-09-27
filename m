Return-Path: <linux-kernel+bounces-342158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A663988B10
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 22:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7DC3B21027
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC09A1C1AD0;
	Fri, 27 Sep 2024 20:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDGuhsKP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F2F46B8
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 20:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727467702; cv=none; b=E2+o+z1sACTO4eTIel8GbB4Ge++rxsHGvPkhAx/xH+cbr8U3T4rMd6sggadq+pNvypPH0ozWOh8qlayLJwEbVrQIijIQWWhTuFAQPplCQmYMgmxLaPbK7X2XPm0udaplQGQxM9aUAU5wPVEuoeLLIhJMItCR2DxiIyYTzdBTQR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727467702; c=relaxed/simple;
	bh=OtalXiQlU80NzxWq9wb3PrfldpbFS3t0mPGsiwj6M+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyqKibXDsO96qFruFpw1YUa+l9oNvxNZCjQzdvsXJgtq1znpJ92jnv6/tE9MnonDfjYS58oXUoatxLmCCkQ9Sop9D8kWY4meyXgKNn5CmoZ74+Oi33OcrJdqi8ENwmdlz/DLt2zGE3klC2zwe2pzd8tcAX4OPxHqi4+gAg2kcx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDGuhsKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6C5C4CEC4;
	Fri, 27 Sep 2024 20:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727467701;
	bh=OtalXiQlU80NzxWq9wb3PrfldpbFS3t0mPGsiwj6M+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JDGuhsKP5JylFJWBytUZlyQH+au/zIFOEDCR6Wk1YJHurSivkxxonQH8YuaS7XuZ7
	 WErZf0iX0H+WE6JKKJHm+CjtPV25oAUuI+JYkhakJAlsn0xYRoMA9XI2jwl6jnINrv
	 1U97QEoWU971o8rO2lnJ+Gq4UmN5BzVO5/3yug9rW0YQws7O4CHHFlULsw3Do8+ov2
	 HRFV7Znkjphv94Z/zHeuMfQsxSozSen3tIvJIkGaMnPL8m5EYHs23bPVpK3F8dPtRF
	 yDxqi7fer+C1VRHsWgfMQhpmgn75VhjPRBoxnQNWcF/3m6wzAZTnjo/ZV8i0DecdSi
	 u0OLkiBbAzJmQ==
Date: Fri, 27 Sep 2024 10:08:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Zhang Qiao <zhangqiao22@huawei.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] sched_ext code cleanups
Message-ID: <ZvcQtEBwCr8qeY6v@slm.duckdns.org>
References: <20240926021506.340636-1-zhangqiao22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926021506.340636-1-zhangqiao22@huawei.com>

On Thu, Sep 26, 2024 at 10:15:03AM +0800, Zhang Qiao wrote:
> Zhang Qiao (2):
>   sched/ext: Fix unmatch trailing comment of CONFIG_EXT_GROUP_SCHED
>   sched/ext: Use tg_cgroup() to elieminate duplicate code

Applied to sched_ext/for-6.13.

Thanks.

-- 
tejun

