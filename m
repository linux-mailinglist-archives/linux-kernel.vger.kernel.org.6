Return-Path: <linux-kernel+bounces-538917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA095A49ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF831175092
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56E1276023;
	Fri, 28 Feb 2025 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/yw6AqK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D01227560A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760203; cv=none; b=jVtTQc9TNfSEjnBnYePOn+3MAL5HjAtekkfoq+umwjiSu6FvnThxfXGXfWcDki/IMOlH+B31/EBYETwk8g9VP20NxyEyMzCkUxYbGwxVJdK7vkk5b5jE3d3GLPX2kaa8tPl1v9Txi4aRxmHZiCu9my6bnCil0Z4q+Tr9YD9Hbz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760203; c=relaxed/simple;
	bh=YG9VrbbJr4DxSSh5Gb7qipZ8op4p6fRDOhDjWk3vF6k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BBq5mZk7oWVLtcCbMO5XAM8ptXmRE7UPs0lGhHocIaMyhpAH8ab+kjYZBJtPm39Hie+LW6933KexaOV9yksz//J7iVId2UcV8rcUW1LiIWuA7IDDL7067my4iWmsWH+oVc1258dR7/+99E9AiyjC0yWdUV9Xpm+x3mCRdDH7AUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/yw6AqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB23C4CEE5;
	Fri, 28 Feb 2025 16:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740760202;
	bh=YG9VrbbJr4DxSSh5Gb7qipZ8op4p6fRDOhDjWk3vF6k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M/yw6AqK47oxlHlP3ljgIoEVMsrvc4gzOKQ/JIaP9F4ynom8xlYn0SAX2Ergvl3WL
	 oJc4SkA4zSSp/5EEnu4eYlJGOvCosRC02bYb4wsd+SXOvKFL9uZTrwXiG0EzA58tAA
	 fxaJgWJwjkCALP4ezztuxW1TfWhGWhN2BU0g0jU3QfiTLwPV95pKb9cli9iUuI3TTw
	 M5xRoQlIthV9UzTGp3x6szdJJ1g181GUrSac5QRgozNTsO1b6Vm2qJ4aXb5UD5/hmu
	 r+PPTsvXDXMWErKY2xl07jnZPu8+tY1JHXcfQQsvlGvflov5EJRyjNQUFdFzua9nF1
	 ZCJuLIBH95s9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADCC380CFF1;
	Fri, 28 Feb 2025 16:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to set .discard_granularity correctly
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <174076023474.2198557.14487536579623357304.git-patchwork-notify@kernel.org>
Date: Fri, 28 Feb 2025 16:30:34 +0000
References: <20250224062007.1324623-1-chao@kernel.org>
In-Reply-To: <20250224062007.1324623-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, daehojeong@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 24 Feb 2025 14:20:07 +0800 you wrote:
> commit 4f993264fe29 ("f2fs: introduce discard_unit mount option") introduced
> a bug, when we enable discard_unit=section option, it will set
> .discard_granularity to BLKS_PER_SEC(), however discard granularity only
> supports [1, 512], once section size is not equal to segment size, it will
> cause issue_discard_thread() in DPOLICY_BG mode will not select discard entry
> w/ any granularity to issue.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to set .discard_granularity correctly
    https://git.kernel.org/jaegeuk/f2fs/c/1b60b23975d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



