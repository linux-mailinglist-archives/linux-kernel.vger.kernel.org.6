Return-Path: <linux-kernel+bounces-342157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C95F988B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 22:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5CA284089
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626B71C2329;
	Fri, 27 Sep 2024 20:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHYkxNdv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03D51474B5
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 20:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727467610; cv=none; b=kcZKGjeCTRj0H+vOs5l9caS31MDMlc0nhFV6Wp6xdEu1NwLMLuk4BpGvrKx+bWB3BkYDtLFvNdEPDsk+Cyf7txYcQDac0m3Dq+24Fs9RuKH16LgMcO8jyAv7SkjC5IYWSxXzx0s/TGkYjg6rpT+n+xoRxKHgiAvWPwNtrq/Ze5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727467610; c=relaxed/simple;
	bh=D5fPCpj9s1tc7Jt2yvLk9QJBZbT9sfvqCeXn904Ooms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGTRwHm3mDN81HG7DNs43C0b+pl2FVym5KPoFFn8Kfd13n18Rr2dGNer3AUdzzEhV+ffzjXNuzndkjko7FzmXbrCJgiiVYmmkphoJZsgNFd5BrhYFbIFn+hiU1rPwpsrgc9iS1BRmP9HgtO0hdCHl7r9WmQtt3LYuH7tzRm50cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHYkxNdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805C7C4CEC4;
	Fri, 27 Sep 2024 20:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727467610;
	bh=D5fPCpj9s1tc7Jt2yvLk9QJBZbT9sfvqCeXn904Ooms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iHYkxNdvvlrNtJXzV1eRwM4pE0SQAYWHRb702MXa49KEv62kOsziQ1jsPxIsSrcTS
	 YvoD33e1UnP6Wq4g4UQ+OUA7LBvCZaD+4tr5Ourb534FQtmDJ4hPFmRY0Y1e++WYsk
	 WrtOjV9PNFIUjP3YdTUfks+eSUZHGvOiFLR5paXlCoQAIlNLtDzyaUdrulnc/mwJo5
	 XZkLD2Ug55N6SvOM7fNaVeb3nJvp8KozpO0XoN5EYhIEXvbcuEOwEGKzNscOTCyKKY
	 cFgXwBYRl3vv9T/ut4AEiVyIKpNcGcHcHxEwoBjhAb+ZOlUlgpxh9HrdRonQJQaNyV
	 8QocsqPNlqF3w==
Date: Fri, 27 Sep 2024 10:06:49 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, sched-ext@meta.com
Subject: Re: [PATCH sched_ext/for-6.13] sched_ext: Factor out
 move_task_between_dsqs() from scx_dispatch_from_dsq()
Message-ID: <ZvcQWXet-m7p_tct@slm.duckdns.org>
References: <ZvNUlEVgJkJkGaT8@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvNUlEVgJkJkGaT8@slm.duckdns.org>

On Tue, Sep 24, 2024 at 02:08:52PM -1000, Tejun Heo wrote:
> Pure reorganization. No functional changes.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Applied to sched_ext/for-6.13.

Thanks.

-- 
tejun

