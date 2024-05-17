Return-Path: <linux-kernel+bounces-182342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734588C89E9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 18:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10EBDB22E83
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C36F12FB25;
	Fri, 17 May 2024 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJzeUxZ1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A4C41C68
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715962681; cv=none; b=GtpFDpteevaPMiDjNGXbMPdDI5fBIli3vf9cA7748jQcbkASUNwQU+0vYnNgXKLTIoA+oiiKyrgtCPY+TZw4JqittKiExEWxk0Nf+ZnXsr5rCp1mwchluZAYecGLBHdfaDBhsiQO25oX6Oxgi0Cu0tPWUV5gY6DBFmbiOYNeXX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715962681; c=relaxed/simple;
	bh=ZpOimh8bxjQZRSssxiuFJNp4h8dRYPJftPmNZvlgwo4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5gIyzBrwhPZNc0bWDUXwkofp0kR6aM+OsbPUEDTPx3k0VAKeedhb1yJQHRvgCeT5O5HOCRKP1RBIwhn2UuElo3sXjIsu2OanM9rex4ci7l+3KMOPIQBUxMng3i7Y3UVWXS2MSLy4i4mSYGn2soA6WdGaWJHGvt+IfmY1lznGTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJzeUxZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C046C32781;
	Fri, 17 May 2024 16:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715962681;
	bh=ZpOimh8bxjQZRSssxiuFJNp4h8dRYPJftPmNZvlgwo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JJzeUxZ16Jc/S2bfY3smOoHrABTr0xo9dKVnElX+4n66gffMl6dkIlSkEFNjLA2go
	 /RS3bk/lj73nIDi5pLEStDpH0k6XdXZ0Hl9BZLus8PeSqHz/VyRLBq1sLRaFeTveeq
	 PhDpE15+QOs2bxYVkFXYhcTSOsrkTYZFpmRQAl4GJYWJHHpvoaDYb32cthzNYGIYex
	 jXOy3DibjAMdgpmRePBo58X5hphHlGGden11JlXU2QHWzBKi6WNDqrn6zXLDfm7+8Q
	 M3OIyX9fZ0vjaZg7UBmn23p6XzaAtyMz4S7AUD2yxCQYdqI3G82cpHRohseoz200fd
	 PyqS2MKlhj6yw==
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Greg Thelen <gthelen@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Tuan Phan <tuanphan@os.amperecomputing.com>
Subject: Re: [PATCH] perf/arm-dmc620: Fix lockdep assert in ->event_init()
Date: Fri, 17 May 2024 17:17:55 +0100
Message-Id: <171594724543.1439580.13624166301923414961.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240514180050.182454-1-namhyung@kernel.org>
References: <20240514180050.182454-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 14 May 2024 11:00:50 -0700, Namhyung Kim wrote:
> for_each_sibling_event() checks leader's ctx but it doesn't have the ctx
> yet if it's the leader.  Like in perf_event_validate_size(), we should
> skip checking siblings in that case.
> 
> 

Applied to arm64 (for-next/core), thanks!

[1/1] perf/arm-dmc620: Fix lockdep assert in ->event_init()
      https://git.kernel.org/arm64/c/a4c5a457c610

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

