Return-Path: <linux-kernel+bounces-176333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA028C2E32
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C410B28510B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0CB168B7;
	Sat, 11 May 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTO9iWfy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30993D52F
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388634; cv=none; b=VGbuVAbGeowMqwSUPagBYi6r8hNBiNa8ALpLOgvQrXwDZ5Q1PCowcZam8XF5d44CKZEPWy5eN7C2tXunfws8KJTxtOsX23a1nhBexnQjBSDTNuL62x+7ZDDhTk5Q7J9h0dglA74WS6X9zaTupcKiriG0MyWxi9luJXx87e1NgD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388634; c=relaxed/simple;
	bh=IkWSIHrbqZTzX+fRBRe9yxXll9h/oBe+bhlmPQRjqqg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nk4dtiwtC815p8CrYEO/uf4C4B9WPl4SCyIO6QP7CAZKnv5hwMix/mIWcbwP+5X4ucrOedVSNycQK37U+iqhkFB9/FC5e3V0BLbfqeB0E6/gS/rC5kKYokI+3W0ShOR5YM90w8yeYZQ5hHCqD8EbpRG5IFG+TspV/Y1bVUCIl/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTO9iWfy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF236C32783;
	Sat, 11 May 2024 00:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715388633;
	bh=IkWSIHrbqZTzX+fRBRe9yxXll9h/oBe+bhlmPQRjqqg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uTO9iWfy46Efpenyx2YM6RyEWSplVynlC9UdGOWU7qe5eWsdhDAFL2DzyDUXudYRO
	 IPKCoj6mNJxQfiG3OR+b4EgiXadDo1V59AmCZ3r5XScJbrKf3sFOqxkIsw7eToA7ih
	 lq0gZSG89H8JHxsZSYnpShSx99GIA4YlVhOmYgrzQBbb2Y7bAsZAQqeJK76FaoZd3s
	 WF1g+io2zV4kGT2By7OfPdeX7IesR/FedumsurRV9bSZh0oS2AAPnj40A1IwYrXfdQ
	 HIKgOjPGFt20hBTJsVftwcfCbCszM85O0OvaN+GkV1s8qMddEWhz43tlFO+rzMC6hb
	 v4+9loL4G0R1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC03AE7C112;
	Sat, 11 May 2024 00:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: allow dirty sections with zero valid
 block for checkpoint disabled
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171538863383.11229.16017084763139644395.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 00:50:33 +0000
References: <20240510134908.3271725-1-daeho43@gmail.com>
In-Reply-To: <20240510134908.3271725-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com, daehojeong@google.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 10 May 2024 06:49:08 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Following the semantic for dirty segments in checkpoint disabled mode,
> apply the same rule to dirty sections.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: allow dirty sections with zero valid block for checkpoint disabled
    https://git.kernel.org/jaegeuk/f2fs/c/f2526c5cf1d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



