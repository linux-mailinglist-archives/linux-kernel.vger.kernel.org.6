Return-Path: <linux-kernel+bounces-336026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9890597EE3C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D4C1C217D9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863728F5E;
	Mon, 23 Sep 2024 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZm6erdV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E911779F5
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105537; cv=none; b=OyMB0tu7irECjKr9WepIkRTvV0L+UeEY8iktRYYYFVGJ1VWqCdHaFcUwfIJk9HupWqg9NloGsDfzN8hTNehFYAiu+hOvYd9MaaxUwhU8dZWUetF8YSoKfebXJ4Ow112v8OxaCucsCLT1XvklzhYYvM/qHLQNm6e6y5TFfIUZW5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105537; c=relaxed/simple;
	bh=MOUD2X51z/7YcPvQE8dZMA1+ufJ77/Fsy8V7ivxqFNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJoEPwz2Yr9arMJcyqeFTTxoYDtSdeLCnG3UN3kMfINCm4ggwOeDZ9nX2SMvmuw6kOzP3Fr4X6R1INYUA1vKnVfN9E2x7G6sQ7h49e5reEyQUsjdQLw9IpJ9Kc1PytqmEzl3/x+FyatiSoeLV6YuEapHPREIN6HNq3rp8tfRXA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZm6erdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A02FC4CEC4;
	Mon, 23 Sep 2024 15:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727105536;
	bh=MOUD2X51z/7YcPvQE8dZMA1+ufJ77/Fsy8V7ivxqFNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CZm6erdVrQZFw/HJagqwLJodza6KkfZbohoYKkMMgGWHw8wgBjfaI8DP8QrfF7w8n
	 eJwLJSuFzLlX+idab/4DdexMcPwqTSGx34RjXe2shYYVuIH4SsYHUMQhVvOgyUynPR
	 vcQ4y4iZk3RqW4YtHXskrgewRGvhJqUkD7408K/9xQIqGfYb+VEOtpVJI4xAnR79rv
	 lsjCJpIUCnh1H8OcHFtD9KujtbIDSTzTQnSVtxlMKP9LwaYn8qFPfZIVSd1xFbJ96H
	 lt7K16eBZHP2qchuSznvDAxW2cntsV8AQrwV9dp+QdcyEeJlKryA0894Dp5OysvxN3
	 6MsmYP++p0O1g==
Date: Mon, 23 Sep 2024 05:32:15 -1000
From: Tejun Heo <tj@kernel.org>
To: Phil Auld <pauld@redhat.com>
Cc: andrea.righi@linux.dev, David Vernet <void@manifault.com>,
	Giovanni Gherdovich <giovanni.gherdovich@suse.com>,
	Kleber Sacilotto de Souza <kleber.souza@canonical.com>,
	Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Provide a sysfs enable_seq counter
Message-ID: <ZvGJ_xT2LhYJHQbZ@slm.duckdns.org>
References: <20240921193921.75594-1-andrea.righi@linux.dev>
 <ZvCKPkwwC9-o2dsQ@mtj.duckdns.org>
 <20240923104548.GA308802@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923104548.GA308802@pauld.westford.csb>

Hello,

On Mon, Sep 23, 2024 at 12:45:48PM +0200, Phil Auld wrote:
...
> It's not a per scheduler counter, though. It's global. We want to know

Yeah, the sequence is global but we can report the sequence at which a given
scheduler is loaded on each scheduler. That way, e.g., you can tell whether
a particular scheduler instance is the same one you looked at the last time
too.

> that a (any) scx scheduler has been loaded at some time in the past. It's
> really only interesting when 0 or > 0. The actual non-zero number and which
> scheduler(s) don't matter that much.

Not necessarily. e.g. You can also detect scheduler failing or being updated
for other reasons.

> And it needs to persist when the scheduler is unloaded (I didn't look but
> I uspect the per scheduler attrs come and go?).

Yes, the load sequence number should stay persistent across all schedulers,
but each scheduler should report the sequence number at which *it* was
loaded. Note that this doesn't really change anything now. If you only care
whether any SCX scheduler has ever been loaded, you'd always look under
root.

Thanks.

-- 
tejun

