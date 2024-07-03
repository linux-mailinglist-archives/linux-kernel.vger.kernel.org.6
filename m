Return-Path: <linux-kernel+bounces-240275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC5B926B2F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 00:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36AE1F222C8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE1D13D2B2;
	Wed,  3 Jul 2024 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjRpEtO+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D653A3D393
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720044190; cv=none; b=kT6U2v70Yl4QP3e3aUg78JBmHhCtzWsJWixoCAynYUdYyOuzingiyNaZxnD8qwQ0I8nLw8mG9IopdFUpHrgTib7bkU+tT5kh0wvymOCj5HanZ29oT4R/SjhGPO+KMgGnYUpA+NFDSaMb1fZCO04j54nSw2ZFIqSvq9p6rdZ5suQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720044190; c=relaxed/simple;
	bh=qVQioSyU1r3qRICtBxO06PLG+ctg9/i5eFiQtz7DXnQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GLwFS9rda7QVhXkrSrj2t2XzQM6qaIqA3r99PzC52eRRf+49dZPc5j/dCWDNVXTZMz0IuTRCToXwJWV0TuaUYdpIfdr0Cw6s5VLk3d/Vk967muaSdZMAPA+WLAUST1C7D0MCAQvM5O5SeotDGYOgddpdBFs8sL43B2KOsZPReq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjRpEtO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AC52C2BD10;
	Wed,  3 Jul 2024 22:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720044190;
	bh=qVQioSyU1r3qRICtBxO06PLG+ctg9/i5eFiQtz7DXnQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JjRpEtO+SdN/NzWKOYhds+YHHnscHLc/NioEPgepVQ3qJ+89YwD3HGHTiM9AKslOY
	 bai9Bb92Y8yA0V0eSi4WfGqZi6WtozNbmOIc2J9cZ1sgalJc2gTl7Iy2QHZIl8oUgl
	 kWifvqvbKD3lUrJhmfuGwntobApIowHdVit/FFIvLT9tcmNq7tZCcNjgTpeG3y6X+P
	 cCwuJ6DSg6cCPlnGZbnTp4mZ/+4ct88MtUFznUO+5125X2h+PvSIzDAZprCEkrxvtC
	 33oEstLU8M8+bcRPQSduMp4VDEkbJvq06HHd58IZA6sRHMOG7oltbP3LcHR6HohObO
	 EepgAAfkQ/zvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F20DC43446;
	Wed,  3 Jul 2024 22:03:10 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fix ioctl conflict with memmapped ring buffer
 ioctl
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240703171235.68d02755@rorschach.local.home>
References: <20240703171235.68d02755@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240703171235.68d02755@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.10-rc6
X-PR-Tracked-Commit-Id: 4ecaf7e98a3ae0c843d67c76649ecc694232834b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 795c58e4c7fc6163d8fb9f2baa86cfe898fa4b19
Message-Id: <172004419037.32091.14307705288856766143.pr-tracker-bot@kernel.org>
Date: Wed, 03 Jul 2024 22:03:10 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 3 Jul 2024 17:12:35 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.10-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/795c58e4c7fc6163d8fb9f2baa86cfe898fa4b19

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

