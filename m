Return-Path: <linux-kernel+bounces-299395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D79995D3F6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68F3281E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5C01922C5;
	Fri, 23 Aug 2024 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITACbNYg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4212B191F80
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432562; cv=none; b=rMTB7O8/2Q8Pl3aHs4ycOICTmZyQNMZxMKcHJwo5WNYiGwg/n4DYjtflhXwaIxArxLkDLxlSXRUsG0jHCi2zDac7ub1pC2GNqTAdw4hY69+xmj+1ksswmkHCNN4jmgRD5lWBwxrufTzYM3rSXzEK/2xKwbPEGHNf/jrKIXSttvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432562; c=relaxed/simple;
	bh=CTLpVEJ9EQmqF+fgzEF/eWSuGq+2R/j1YEfrcM59j5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xvfz9jFqQyxDTJ9YLMlwiRQ7kr5lBsy9a2GwIBDtN0J9CnSsRr5In6EA7Cpq5JmO8RRm5APPFwtFSefJvEPqVDJQT9c0W/9m1ViYyolcueB7w3eYxFMt+Zo5EqyTo4DzMizkDbWx0mshpYdmQ6wftyn48vCDPz+rogto3tBq1Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITACbNYg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEA2C32786;
	Fri, 23 Aug 2024 17:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724432561;
	bh=CTLpVEJ9EQmqF+fgzEF/eWSuGq+2R/j1YEfrcM59j5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ITACbNYg03anW1iBY9/jWHwq36xaLa9EfXK7pdqYh7Tf7xwTCJQuZowenPBwMg4nf
	 nvMmDNebxjle5f62fmwuh/g8c0jJ6TBunf2+stqO89E36aFE7HpBM4txE8ZGgrt7EV
	 wi4wqxOLc3PK205rWkWqP2bQ4IR8BkGvAXOMjGddE8toxWcx+f5hUEumOnWAKOu/9H
	 IRkJze+QS1J+++foK4nilDaENoL0xqms6Td2S9DzpbcXClWY3Z1ame1derYn2uYyIF
	 FSFpiTuDktjdI9aQXwWLTrJtULXSTY9itltxAv9PAOsccsZF0GijHVDli5klZmIFSc
	 RhCrERGIb7ROw==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] drivers/perf: Fix ali_drw_pmu driver interrupt status clearing
Date: Fri, 23 Aug 2024 18:02:13 +0100
Message-Id: <172442543794.2791566.7487559494853957932.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1724297611-20686-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <2a70eaa3-f1c5-4803-948b-4b8eb86190c6@linux.alibaba.com> <1724297611-20686-1-git-send-email-renyu.zj@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 22 Aug 2024 11:33:31 +0800, Jing Zhang wrote:
> The alibaba_uncore_pmu driver forgot to clear all interrupt status
> in the interrupt processing function. After the PMU counter overflow
> interrupt occurred, an interrupt storm occurred, causing the system
> to hang.
> 
> Therefore, clear the correct interrupt status in the interrupt handling
> function to fix it.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] drivers/perf: Fix ali_drw_pmu driver interrupt status clearing
      https://git.kernel.org/will/c/a3dd920977dc

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

