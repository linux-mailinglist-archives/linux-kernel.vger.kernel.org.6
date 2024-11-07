Return-Path: <linux-kernel+bounces-400603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DC49C0FBF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8571F2388B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB288219CB9;
	Thu,  7 Nov 2024 20:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aO6ULwSK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F71E219CA0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 20:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731011447; cv=none; b=NxctQFWRnTnNdZWayeqPeOKO9wuGdx/7Zx9mg9yW0x4o6Zxtswp0o2JSSB58jUwoJFBYrqQ9JU8b2uJSI5bUFgCXa8Q4CavtBkqJnsfO/9/bWMhR753zCaieFKvYSW+ypIS+7qYjr4EigCeuwmN4n2rOaA4yCM/0XIAByLeQJrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731011447; c=relaxed/simple;
	bh=jEy0Z06bKSJsUnioWxmojKNnv+lZHki4tfGbwN4Q4Wg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lTRVjfG3FqF/ANnOQ2H3C22MJXtm+9jUQubiJiePCXd4xILLCUZ4AW5pZlYExXt5VH+VJgSu2SOGqYoIV4A3ydMEwQDpTzs/Re0ZOPGNHac8J9vZqoZM+HtsIAUsPEzKUIX3lMRCfDFT6UvANNbWtW9b7yhWhBMG8jGdoudo6DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aO6ULwSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E48C4CECC;
	Thu,  7 Nov 2024 20:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731011447;
	bh=jEy0Z06bKSJsUnioWxmojKNnv+lZHki4tfGbwN4Q4Wg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aO6ULwSKI2XXmoMb/K1upNn6XeamF6GSIplq6UpaWdTurUYJtcK+0krSy7ldXzhyk
	 n67Xp/yI2K8RR9Xdbak7r3JKZTm2Bwl+nMpw9d73JJCueiyWc/woQn0jpf9xF5dHlh
	 IzNUrDOC3AthX6eqt23x9czUsd/XPR5+ruxli/qg0RnSfXx/ySxkxsOreAqsp+g+jF
	 iD4x5PQZYWbGSE7tp/dG+Ft0so/1XAl7M/jyAAbmZJiGsowiHQC55SrIa5qpVcuWtC
	 V6XlCUL/ZJH86HcZPvHvj1avC5qNE0MbdUWuimYWcRmsjtw5lhNZ6G1jwsU/fsTvsL
	 3/Enmq+0/B02g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBE73809A80;
	Thu,  7 Nov 2024 20:30:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix to parse temperature correctly in
 f2fs_get_segment_temp()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173101145624.2084993.1951748528174851352.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 20:30:56 +0000
References: <20241022020149.2302191-1-chao@kernel.org>
In-Reply-To: <20241022020149.2302191-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 22 Oct 2024 10:01:49 +0800 you wrote:
> In __get_segment_type(), __get_segment_type_6() may return
> CURSEG_COLD_DATA_PINNED or CURSEG_ALL_DATA_ATGC log type, but
> following f2fs_get_segment_temp() can only handle persistent
> log type, fix it.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: fix to parse temperature correctly in f2fs_get_segment_temp()
    https://git.kernel.org/jaegeuk/f2fs/c/9395fb09e897

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



