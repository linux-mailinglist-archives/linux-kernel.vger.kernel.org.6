Return-Path: <linux-kernel+bounces-565275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8FDA66503
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 02:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7159178FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EF6155A25;
	Tue, 18 Mar 2025 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFwdSjhQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D90F8248C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 01:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742261399; cv=none; b=n91znfY4ts25vnVO1/cmGgBSd1PrijlKoB2ICXuLaoy6qQ5pqfzc1ReFL9BejRZGtrGA9xslkXa2baF8S4Z5TFm26OhqEtIr7Mb1lL98Kqv0Fd6mXj6z6XqjOtW3lNso+w6jdvodfDROiWamSA5iBkIlQztCz7fWUekiYD01tBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742261399; c=relaxed/simple;
	bh=qODT3Q9/1WjT2glxMbxvM/9CfPGjd3ZnWgJhKz5zS2M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oQ2ZhqfcCJhObKsLmtwRHIlgCiJcjD2yzCzcNfy6mt8hZd2eJwZDIoDG4WpjUA5ZwVSTyKaAKtbcz0em5/8LN+rSLFWu+eoWizcESo7221yYeor8ltARskkyNDX2pr79vR36j+cqP76fAxRg8kKCozY8b0WAj2Phzt2PogOMRlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFwdSjhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C75DC4CEE3;
	Tue, 18 Mar 2025 01:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742261397;
	bh=qODT3Q9/1WjT2glxMbxvM/9CfPGjd3ZnWgJhKz5zS2M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aFwdSjhQYQS2Pi0fdcGJ26rOL2ODWWEIklq2fQcvT9clt8dvsRFOQAlvgqs6JlIeu
	 CbL6RmWtNJ+o2OUNMLv2TUXOj7t9dRf/elt12vvyswh+KUAl2OOKmiWtpVtR8W3t3q
	 wsPkvRQ1m6srQ1eDrTXfjdSDGLFxJlOeNxNPMl/19qPKkTEJAPYaoc7A++cYVScFev
	 hHk8nEQKnpg9ejzsAzRlL6d0j7tx4RGLj2luNUKk+nf2aNhc5cq8upKpY1KQW2A21s
	 YJoOsyWc6J1geYXOkWaNeySgRdSsDMT8S4G/FATMZEysQkorYMy/V+9iZBaBCgSrl3
	 8ExYlH1ImHoIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB02E380DBEF;
	Tue, 18 Mar 2025 01:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: optimize f2fs DIO overwrites
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <174226143279.3976340.11320826422025580869.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 01:30:32 +0000
References: <20250317133611.457-1-yohan.joung@sk.com>
In-Reply-To: <20250317133611.457-1-yohan.joung@sk.com>
To: Yohan Joung <jyh429@gmail.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, daeho43@gmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 17 Mar 2025 22:36:11 +0900 you wrote:
> this is unnecessary when we know we are overwriting already allocated
> blocks and the overhead of starting a transaction can be significant
> especially for multithreaded workloads doing small writes.
> 
> Signed-off-by: Yohan Joung <yohan.joung@sk.com>
> ---
>  fs/f2fs/data.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: optimize f2fs DIO overwrites
    https://git.kernel.org/jaegeuk/f2fs/c/351bc761338d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



