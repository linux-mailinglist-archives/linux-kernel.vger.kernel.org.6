Return-Path: <linux-kernel+bounces-307875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6450C965444
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 02:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01ABA1F26AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 00:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6718F4C7C;
	Fri, 30 Aug 2024 00:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/3fHpeF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFA42599
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 00:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724979082; cv=none; b=Ycy/XU3SDkLumXpY92hrGcMmvvtu+tRU66hNKkUHVAtVLjMKU1XJPN00PmjL04+vyDqNu2EFxfe6Hosfqtdmx1JgO0bZ/il5Vt3CtuDRhgPnQA+Rhmy95JnS7jHgm8hSimV4xg5Gxo0JxtEH0R3+Q8tEmCRMn+i3/Eb2eyl6ikI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724979082; c=relaxed/simple;
	bh=98To16Pw25J/JIE9h+sXbpZyl6yq3vWHnjtVFDfFHOA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OxcFk0O9nFPDyEYe8fuOP8KxzhbQGVGqPjPahiFu1z5Nn8o4bz0eT4YvfG19J9hREAI3G7YIyg4awM6AzmmCxWBve9qvv+iiZPsM/Q8QcDu4H2w20x/+p/qS0DzzbGIhNFBZ8vLtdHc6gxI+JzkcBv8Hlsg7IY3rzw0mXuyxYoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/3fHpeF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F19C4CEC1;
	Fri, 30 Aug 2024 00:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724979082;
	bh=98To16Pw25J/JIE9h+sXbpZyl6yq3vWHnjtVFDfFHOA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=D/3fHpeFFQ223L+0TMe1fuoseZrcSkqAAMBTNUn5XxHgaY3d1B8HYjqI+myTzq9CF
	 zoVZ6qeu8GuqC9q6g9mhOsYL6zNd4yzK+g12kJN4msLVui/6ti54wl3LgMME8CwjLG
	 RvwAWbok16iBKzd5bkUN7JdiKuYASlOU6d61TfhwEAPVzp8xK6ixwtC4drROEe5Ve7
	 +P2wNPJr9cIazyP1KRo2knKjsUgdy/aEefXj74g71aAANR7b6PA8DAwTVecrL1lUfa
	 4qOtaiFrEmu8AI6Kg6JRx5a/BVBBmZPC81JKoA5yL/1zeI2o8CwNuRWBGVH8qDCeET
	 E2vNBNEKuFaWA==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1B70C3805D82;
	Fri, 30 Aug 2024 00:51:24 +0000 (UTC)
Subject: Re: [GIT PULL] execve fix for v6.11-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <202408291304.2B20D61BE4@keescook>
References: <202408291304.2B20D61BE4@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202408291304.2B20D61BE4@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.11-rc6
X-PR-Tracked-Commit-Id: c6a09e342f8e6d3cac7f7c5c14085236aca284b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b5fe53681d9c388f1600310fe3488091701d4d0
Message-Id: <172497908410.2127991.8173501789036292167.pr-tracker-bot@kernel.org>
Date: Fri, 30 Aug 2024 00:51:24 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Greg Ungerer <gerg@kernel.org>, Kees Cook <kees@kernel.org>, Max Filippov <jcmvbkbc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 29 Aug 2024 13:05:01 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.11-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b5fe53681d9c388f1600310fe3488091701d4d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

