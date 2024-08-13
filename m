Return-Path: <linux-kernel+bounces-285633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3419510A6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8C4284F92
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701841AC432;
	Tue, 13 Aug 2024 23:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GVYswoZH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E171A3BCA
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 23:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723592243; cv=none; b=lX4m/Kmq04WJZ6pDG+fP53uEi8Zee5zeM/DT0nVfgSeIArUN8CWa0owUuj8V1e1zmPBIgvW/HM1+WDToofCKE1bQvcYPZyRKXiHOgsBO6D59d+lP6PftNvSM6pDaPpfX0u9vdNYeLJl5kV1fl6eqYKD4mBF5emKPkMm1Kxcail4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723592243; c=relaxed/simple;
	bh=yTHcPQzzXOBbzYIghuy5UqDhp+77jPDrXhK0S/vp+9k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ec+bMxAw2FolvClWhU4vUQ8qQmSlMOBpEEHYHaZgr2zKoUfC0drQR6tJ0YroURCJ80RMGlO2EbLy6QpUXpoJ0P5XV5zeYo/PV0id4pDtd6HBgR0Y8P9hTQb20dLP6vmzk+SDxMrSgNtXKiRxiB0vQmshFODSjBFDc8O8u5nM6CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GVYswoZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C1BC32782;
	Tue, 13 Aug 2024 23:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723592243;
	bh=yTHcPQzzXOBbzYIghuy5UqDhp+77jPDrXhK0S/vp+9k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GVYswoZH6u3L/KnW0Hxg9NLTN3rNKsklGFCfVGFdosm3/mc6yHJwq0EhXtva4Hvhf
	 PBBoaK19ZZ+9aT6wWfB6KXRAfn+DiGqLx55ARl/tOVHXK69Cv7nVjduLJeqQ/Kw47y
	 P+tntIyJaZFsMhEOVP61eNtSKyJ1k5J4ukz1ZJdQ=
Date: Tue, 13 Aug 2024 16:37:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, ssengar@microsoft.com,
 wei.liu@kernel.org
Subject: Re: [PATCH] mm/vmstat: Defer the refresh_zone_stat_thresholds after
 all CPUs bringup
Message-Id: <20240813163722.63c0cdf8838640b0a8d7ff4b@linux-foundation.org>
In-Reply-To: <20240812043754.GA7619@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1720169301-21002-1-git-send-email-ssengar@linux.microsoft.com>
	<20240705135911.4a6e38379ae95c3fc6bbe7e2@linux-foundation.org>
	<20240709045750.GA32083@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
	<20240810000404.b08cb06ebbba7e0de9bb8c72@linux-foundation.org>
	<20240812043754.GA7619@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Aug 2024 21:37:54 -0700 Saurabh Singh Sengar <ssengar@linux.microsoft.com> wrote:

> Without this patch, refresh_zone_stat_threshold was being called 1024 times.
> After applying the patch, it is called only once, which is same as the last
> iteration of the earlier 1024 calls. Further testing with this patch, I observed
> a 4.5-second improvement in the overall boot timing due to this fix, which is
> same as the total time taken by refresh_zone_stat_thresholds without thie patch,
> leading me to reasonably conclude that refresh_zone_stat_threshold now takes a
> negligible amount of time (likely just a few milliseconds).

Thanks, nice.  I pasted this into the changelog.

