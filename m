Return-Path: <linux-kernel+bounces-382186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FE09B0A80
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F9F1C224F0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F91318C915;
	Fri, 25 Oct 2024 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zdnb284+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58C715ADAB
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729875846; cv=none; b=Vg+/CjIlpJGssDTxpzTizfSiLNvIbdVOor2TI5heCoR6ydteTmbaGhkmkrTYqD/wuuy6zvcnX6XCGURdgQUYZc72mTJBq6gdN9tiEh+oZGAwBA56tpU8d9XzaXdTaNABcEWGWupKXdcmjiQHk0jb6jJ8iUt6T3YEe4QmWsEzb5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729875846; c=relaxed/simple;
	bh=9w+5BVRnSTrx4wbGeoEbzVRZAvg5wvSo9mP3uwkKb+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBiLVL6FQca1Ct8C6jmoenEuSI1Lt+04Dz2PTQrbfPM0r24XJncuTSonNTFusyzXBnT5NOHGW2oCobflzMMTQpOI4QIMZCvT5n1sn/xVSMozdWP0BSB6dMgm/cFRBLBY4tvNSbAkRm7b9skqCIG41TCuLvBqpXoiY9Ki0oYPr9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zdnb284+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECBEC4CEC3;
	Fri, 25 Oct 2024 17:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729875846;
	bh=9w+5BVRnSTrx4wbGeoEbzVRZAvg5wvSo9mP3uwkKb+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zdnb284+UqFRwDQvh3A/J4QJWfrWOxvmFsBBkfjNIbGLUZF00gHvTkDcdPXUD1x0n
	 LtJiAlnoKmaSQIJEfIpfc4t3IbKWGeWUDV8Cvt4H3WihZfjH1GvgwDyzxNrgW9KlE7
	 AdYKNRjnm/FCqj5FlHLm9qTRmNxTi+Tc0ZBjzoJmWBYNbjid9RBVYRXzTBHdqg7nop
	 MtUJH8ddtYn//Byh4y8X+vGkSrgm183xDrZSDyhn9BoRTK6yLaIpqTLPpMNsO7cQq9
	 KznLucuWmRWE9Tm80yHZj/y54jHF5cpdhkUIKChcErvQcGWu3cjVKd93IWlL7CRlJK
	 sxX4BZd41wQ7Q==
Date: Fri, 25 Oct 2024 07:04:05 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: sched-ext@meta.com, kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] scx: Fix exit selftest to use custom DSQ
Message-ID: <ZxvPhYfWbz8WcBpg@slm.duckdns.org>
References: <20241025054014.66631-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025054014.66631-1-void@manifault.com>

On Fri, Oct 25, 2024 at 12:40:13AM -0500, David Vernet wrote:
> In commit 63fb3ec80516 ("sched_ext: Allow only user DSQs for
> scx_bpf_consume(), scx_bpf_dsq_nr_queued() and bpf_iter_scx_dsq_new()"), we
> updated the consume path to only accept user DSQs, thus making it invalid
> to consume SCX_DSQ_GLOBAL. This selftest was doing that, so let's create a
> custom DSQ and use that instead.  The test now passes:
> 
> [root@virtme-ng sched_ext]# ./runner -t exit
> ===== START =====
> TEST: exit
> DESCRIPTION: Verify we can cleanly exit a scheduler in multiple places
> OUTPUT:
> [   12.387229] sched_ext: BPF scheduler "exit" enabled
> [   12.406064] sched_ext: BPF scheduler "exit" disabled (unregistered from BPF)
> [   12.453325] sched_ext: BPF scheduler "exit" enabled
> [   12.474064] sched_ext: BPF scheduler "exit" disabled (unregistered from BPF)
> [   12.515241] sched_ext: BPF scheduler "exit" enabled
> [   12.532064] sched_ext: BPF scheduler "exit" disabled (unregistered from BPF)
> [   12.592063] sched_ext: BPF scheduler "exit" disabled (unregistered from BPF)
> [   12.654063] sched_ext: BPF scheduler "exit" disabled (unregistered from BPF)
> [   12.715062] sched_ext: BPF scheduler "exit" disabled (unregistered from BPF)
> ok 1 exit #
> =====  END  =====
> 
> Signed-off-by: David Vernet <void@manifault.com>

Applied to sched_ext/for-6.12-fixes.

Thanks.

-- 
tejun

